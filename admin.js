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
      callback(session);
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

  // 管理者専用: 価格登録（api.admin_record_price）
  function adminRecordPrice(fields){
    return client().schema("api").rpc("admin_record_price", {
      p_card_id: fields.cardId,
      p_price: fields.price,
      p_observed_at: fields.observedAt || new Date().toISOString(),
      p_price_type: fields.priceType || "sell",
      p_condition: fields.condition || "default"
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data; // 登録されたprice_observationsのid（重複時はnull）
    });
  }

  global.ADMIN = {
    login: login,
    logout: logout,
    getSession: getSession,
    onAuthChange: onAuthChange,
    checkAdminAccess: checkAdminAccess,
    adminGetCard: adminGetCard,
    adminUpsertCard: adminUpsertCard,
    adminRecordPrice: adminRecordPrice
  };

})(window);
