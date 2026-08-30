/* =============================================================
   admin.js — 管理画面（admin.html）専用のロジック
   ---------------------------------------------------------------
   ログイン（Supabase Auth）と、管理者専用RPC（api.admin_*）の
   呼び出しをここに集約する。market.js（一般公開・読み取り専用）
   とはあえて分離している。
   実際の書き込み権限チェックはDB側（is_admin()）で行われるため、
   このファイルはあくまでUIの都合上の分離であり、これ自体が
   セキュリティ境界ではない。
============================================================= */
(function(global){
  "use strict";

  // 公開して問題ない鍵（publishable key）。market.jsと同じ値。
  var SUPABASE_URL = "https://idnhamxtwxfcxflenxko.supabase.co";
  var SUPABASE_ANON_KEY = "sb_publishable_lZoCHYEsf4LscKv2TVphBg_0JAAy4wO";

  // 管理者セッションはlocalStorageへ残さない（persistSession: false）。
  // 同一オリジンの別ページに万一XSSがあっても、管理者トークンが盗まれないようにするため。
  // その代わり、ページを閉じる・再読み込みすると再ログインが必要になる（意図した挙動）。
  var _client = null;
  function client(){
    if(!_client){
      _client = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
        auth: {
          persistSession: false,
          detectSessionInUrl: false,
          autoRefreshToken: true
        }
      });
    }
    return _client;
  }

  // 過去のバージョン（persistSession: trueだった頃）にログインした際、
  // localStorageに残っている可能性のあるセッションを起動時に破棄する。
  (function clearLegacyPersistedSession(){
    try{
      var keysToRemove = [];
      for(var i = 0; i < localStorage.length; i++){
        var k = localStorage.key(i);
        if(k && k.indexOf("sb-") === 0 && k.indexOf("auth-token") !== -1){
          keysToRemove.push(k);
        }
      }
      keysToRemove.forEach(function(k){ localStorage.removeItem(k); });
    }catch(e){ /* localStorageが使えない環境では何もしない */ }
  })();

  function login(email, password){
    return client().auth.signInWithPassword({ email: email, password: password })
      .then(function(res){
        if(res.error) throw res.error;
        return res.data;
      });
  }

  function logout(){
    return client().auth.signOut();
  }

  function getSession(){
    return client().auth.getSession().then(function(res){
      return res.data && res.data.session;
    });
  }

  // ログイン状態が変わったとき（ログイン／ログアウト／トークン更新）に呼ばれる
  function onAuthChange(callback){
    client().auth.onAuthStateChange(function(event, session){
      setTimeout(function(){ callback(session); }, 0);
    });
  }

  // ログイン後、実際の書き込みを試す前に管理者かどうかを確認する（UI表示の出し分け用。
  // 実際のアクセス制御はDB側のis_admin()が担うため、これ自体はセキュリティ境界ではない）
  function checkAdminAccess(){
    return client().schema("api").rpc("admin_check_access", {}).then(function(res){
      if(res.error) throw res.error;
      return res.data === true;
    });
  }

  // 管理者専用: 編集対象カードの詳細取得（api.admin_get_card）
  function adminGetCard(cardId){
    return client().schema("api").rpc("admin_get_card", { p_card_id: cardId })
      .then(function(res){
        if(res.error) throw res.error;
        return (res.data && res.data[0]) || null;
      });
  }

  // 管理者専用: カード新規登録・更新（api.admin_upsert_card）
  function adminUpsertCard(fields){
    return client().schema("api").rpc("admin_upsert_card", {
      p_id: fields.id || null,
      p_set_id: fields.setId,
      p_name: fields.name,
      p_card_number: fields.cardNumber,
      p_rarity: fields.rarity || null,
      p_variant: fields.variant || "",
      p_image_url: fields.imageUrl || null,
      p_image_source_note: fields.imageSourceNote || null
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data; // 作成・更新されたカードのid
    });
  }


  // 管理者専用: 新しいパックを登録（api.admin_create_card_set）
  function adminCreateCardSet(fields){
    return client().schema("api").rpc("admin_create_card_set", {
      p_code: fields.code || null,
      p_name: fields.name,
      p_release_date: fields.releaseDate || null
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data; // 作成されたcard_sets.id
    });
  }

  // 管理者専用: シリーズ・画像URL対応の新規パック登録
  function adminCreateCardSetV2(fields){
    return client().schema("api").rpc("admin_create_card_set_v2", {
      p_code: fields.code || null,
      p_name: fields.name,
      p_release_date: fields.releaseDate || null,
      p_series_name: fields.seriesName || "その他",
      p_image_url: fields.imageUrl || null
    }).then(function(res){ if(res.error) throw res.error; return res.data; });
  }

  // 管理者専用: 既存パック情報更新
  function adminUpdateCardSet(fields){
    return client().schema("api").rpc("admin_update_card_set", {
      p_id: fields.id,
      p_code: fields.code || null,
      p_name: fields.name,
      p_release_date: fields.releaseDate || null,
      p_series_name: fields.seriesName || "その他",
      p_image_url: fields.imageUrl || null
    }).then(function(res){ if(res.error) throw res.error; return res.data; });
  }

  // 公開: シリーズ一覧
  function listCardSeries(){
    return client().schema("api").rpc("list_card_series", {}).then(function(res){
      if(res.error) throw res.error;
      return res.data || [];
    });
  }

  // 管理者専用: シリーズ追加
  function adminCreateCardSeries(fields){
    return client().schema("api").rpc("admin_create_card_series", {
      p_name: fields.name,
      p_reference_series_name: fields.referenceSeriesName || null,
      p_position: fields.position || "after"
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data;
    });
  }

  function extForImage(file){
    var type = String(file && file.type || "").toLowerCase();
    if(type === "image/jpeg") return "jpg";
    if(type === "image/png") return "png";
    if(type === "image/webp") return "webp";
    if(type === "image/gif") return "gif";
    return null;
  }

  // 管理者専用: パック画像をSupabase Storageへアップロード
  function uploadPackImage(file, setId){
    if(!file) return Promise.reject(new Error("画像ファイルを選択してください。"));
    var ext = extForImage(file);
    if(!ext) return Promise.reject(new Error("JPG / PNG / WebP / GIF の画像を選択してください。"));
    if(Number(file.size || 0) > 5 * 1024 * 1024){
      return Promise.reject(new Error("画像は5MB以下にしてください。"));
    }

    var safeSetId = String(setId || "new").replace(/[^a-zA-Z0-9_-]/g, "_");
    var rand = (global.crypto && global.crypto.randomUUID)
      ? global.crypto.randomUUID()
      : String(Date.now()) + "_" + Math.random().toString(36).slice(2);
    var path = safeSetId + "/" + rand + "." + ext;

    return client().storage.from("pack-images").upload(path, file, {
      cacheControl: "3600",
      upsert: false,
      contentType: file.type
    }).then(function(res){
      if(res.error) throw res.error;
      var pub = client().storage.from("pack-images").getPublicUrl(path);
      var url = pub && pub.data && pub.data.publicUrl;
      if(!url) throw new Error("画像URLを取得できませんでした。");
      return url;
    });
  }

  // 管理画面用: 利用可能な価格元一覧
  function listPriceSources(){
    return client().schema("api").rpc("list_price_sources", {}).then(function(res){
      if(res.error) throw res.error;
      return res.data || [];
    });
  }

  // 管理者専用: 価格登録（api.admin_record_price）
  function adminRecordPrice(fields){
    return client().schema("api").rpc("admin_record_price", {
      p_card_id: fields.cardId,
      p_price: fields.price,
      p_observed_at: fields.observedAt || new Date().toISOString(),
      p_source_id: fields.sourceId || null,
      p_price_type: fields.priceType || "sell",
      p_condition: fields.condition || "default"
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data; // 登録されたprice_observationsのid（重複時はnull）
    });
  }

  // 管理者専用: ショート掲載情報取得
  function adminGetShortFeature(cardId){
    return client().schema("api").rpc("admin_get_short_feature", {
      p_card_id: cardId
    }).then(function(res){
      if(res.error) throw res.error;
      return (res.data && res.data[0]) || null;
    });
  }

  // 管理者専用: ショート掲載ON/OFF
  function adminSetShortFeature(fields){
    return client().schema("api").rpc("admin_set_short_feature", {
      p_card_id: fields.cardId,
      p_is_active: !!fields.isActive,
      p_youtube_url: fields.youtubeUrl || null,
      p_published_at: fields.publishedAt || null
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data;
    });
  }

  // 公開設定の取得（公開ページと管理画面で共通利用）
  function getSiteSetting(key){
    return client().schema("api").rpc("get_site_setting", { p_key: key }).then(function(res){
      if(res.error) throw res.error;
      return res.data == null ? null : String(res.data);
    });
  }

  // 管理者専用: サイト表示設定の更新
  function adminSetSiteSetting(key, value){
    return client().schema("api").rpc("admin_set_site_setting", {
      p_key: key,
      p_value: value
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data;
    });
  }

  // 管理者専用: 複数カードのレアリティ一括変更
  function adminBulkUpdateRarity(cardIds, rarity){
    return client().schema("api").rpc("admin_bulk_update_card_rarity", {
      p_card_ids: cardIds,
      p_rarity: rarity
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data;
    });
  }

  global.ADMIN = {
    login: login,
    logout: logout,
    getSession: getSession,
    onAuthChange: onAuthChange,
    checkAdminAccess: checkAdminAccess,
    getSiteSetting: getSiteSetting,
    adminSetSiteSetting: adminSetSiteSetting,
    adminGetCard: adminGetCard,
    adminUpsertCard: adminUpsertCard,
    adminBulkUpdateRarity: adminBulkUpdateRarity,
    adminCreateCardSet: adminCreateCardSet,
    adminCreateCardSetV2: adminCreateCardSetV2,
    adminUpdateCardSet: adminUpdateCardSet,
    listCardSeries: listCardSeries,
    adminCreateCardSeries: adminCreateCardSeries,
    uploadPackImage: uploadPackImage,
    listPriceSources: listPriceSources,
    adminRecordPrice: adminRecordPrice,
    adminGetShortFeature: adminGetShortFeature,
    adminSetShortFeature: adminSetShortFeature
  };

})(window);
