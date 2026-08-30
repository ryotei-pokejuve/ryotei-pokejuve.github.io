/* =============================================================
   market.js — カード検索・相場機能の共通ロジック
   ---------------------------------------------------------------
   search.html / card.html の両方から読み込む。
   Supabaseへの接続情報と、api.* RPCの呼び出しをここに集約している。
   秘密情報（publishable keyのみ。これは公開して問題ない鍵）以外は
   一切含まない。管理者用の操作（価格登録・カード編集）は、この
   ファイルには含めない（Phase 4の管理画面で別途実装する）。
============================================================= */
(function(global){
  "use strict";

  // Supabaseプロジェクトの接続情報（publishable keyは公開しても問題ない鍵）
  var SUPABASE_URL = "https://idnhamxtwxfcxflenxko.supabase.co";
  var SUPABASE_ANON_KEY = "sb_publishable_lZoCHYEsf4LscKv2TVphBg_0JAAy4wO";

  var _client = null;
  function client(){
    if(!_client){
      _client = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
    }
    return _client;
  }

  // カード検索（api.search_cards）
  function searchCards(opts){
    opts = opts || {};
    return client().schema("api").rpc("search_cards", {
      p_query: opts.query || null,
      p_set_id: opts.setId || null,
      p_series_name: opts.seriesName || null,
      p_rarity: opts.rarity || null,
      p_limit: opts.limit || 20,
      p_offset: opts.offset || 0
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data || [];
    });
  }

  // 検索ページ用: 表示件数・並び順対応
  function searchCardsSorted(opts){
    opts = opts || {};
    return client().schema("api").rpc("search_cards_sorted", {
      p_query: opts.query || null,
      p_set_id: opts.setId || null,
      p_series_name: opts.seriesName || null,
      p_rarity: opts.rarity || null,
      p_sort: opts.sort || "default",
      p_limit: opts.limit || 20,
      p_offset: opts.offset || 0
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data || [];
    });
  }

  // カード詳細（api.get_card）
  function getCard(cardId, priceType, condition){
    return client().schema("api").rpc("get_card", {
      p_card_id: cardId,
      p_price_type: priceType || "sell",
      p_condition: condition || "default"
    }).then(function(res){
      if(res.error) throw res.error;
      return (res.data && res.data[0]) || null;
    });
  }

  // 価格履歴（api.get_price_history）
  function getPriceHistory(cardId, opts){
    opts = opts || {};
    return client().schema("api").rpc("get_price_history", {
      p_card_id: cardId,
      p_price_type: opts.priceType || "sell",
      p_condition: opts.condition || "default",
      p_limit: opts.limit || 30
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data || [];
    });
  }

  // カードごとの最新価格（カードラッシュ/晴れる屋2/メルカリ）
  function getCardMarketPrices(cardId){
    return client().schema("api").rpc("get_card_market_prices", {
      p_card_id: cardId
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data || [];
    });
  }

  // Shorts PRICE ページ掲載カード（検索・絞り込み・並び替え対応）
  function listShortPriceCards(opts){
    opts = opts || {};
    return client().schema("api").rpc("list_short_price_cards", {
      p_query: opts.query || null,
      p_set_id: opts.setId || null,
      p_rarity: opts.rarity || null,
      p_sort: opts.sort || "newest",
      p_limit: opts.limit || 20,
      p_offset: opts.offset || 0
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data || [];
    });
  }

  // 公開設定の取得（PRICE/SEARCHのデフォルト設定に使用）
  function getSiteSetting(key){
    return client().schema("api").rpc("get_site_setting", {
      p_key: key
    }).then(function(res){
      if(res.error) throw res.error;
      return res.data == null ? null : String(res.data);
    });
  }

  // パック（card_sets）一覧（api.list_card_sets）。絞り込みUIの選択肢に使う
  function listCardSets(){
    return client().schema("api").rpc("list_card_sets_v3", {}).then(function(res){
      if(res.error) throw res.error;
      return res.data || [];
    });
  }

  // シリーズ一覧
  function listCardSeries(){
    return client().schema("api").rpc("list_card_series", {}).then(function(res){
      if(res.error) throw res.error;
      return res.data || [];
    });
  }

  // 画像URLの検証（XSS対策）。https以外・不正なURLはnullを返し、呼び出し側でプレースホルダーに差し替える。
  // src属性への直接文字列結合は絶対に行わず、必ずこれを通した値だけを使うこと。
  function sanitizeImageUrl(url){
    if(!url) return null;
    try{
      var u = new URL(url, location.href);
      if(u.protocol !== "https:") return null;
      // 将来Supabase Storage等に画像を集約する場合は、ここでu.hostnameを許可ドメインに限定する
      return u.href;
    }catch(e){
      return null;
    }
  }

  // 円表示のフォーマット（例: 1234 → "1,234円"）
  function formatYen(n){
    if(n === null || n === undefined) return "―";
    return Number(n).toLocaleString("ja-JP") + "円";
  }

  // 日時表示のフォーマット（例: "2026/08/17 10:13"）
  function formatDateTime(iso){
    if(!iso) return "―";
    var d = new Date(iso);
    if(isNaN(d.getTime())) return "―";
    return d.toLocaleString("ja-JP", {
      year: "numeric", month: "2-digit", day: "2-digit",
      hour: "2-digit", minute: "2-digit"
    });
  }

  // 検索条件の一時保存（カード詳細から戻った時に検索状態を復元するため）
  function saveSearchState(state){
    try{ sessionStorage.setItem("market-search-state", JSON.stringify(state)); }catch(e){}
  }
  function loadSearchState(){
    try{
      var raw = sessionStorage.getItem("market-search-state");
      return raw ? JSON.parse(raw) : null;
    }catch(e){ return null; }
  }

  global.MARKET = {
    searchCards: searchCards,
    searchCardsSorted: searchCardsSorted,
    getCard: getCard,
    getPriceHistory: getPriceHistory,
    getCardMarketPrices: getCardMarketPrices,
    listShortPriceCards: listShortPriceCards,
    getSiteSetting: getSiteSetting,
    listCardSets: listCardSets,
    listCardSeries: listCardSeries,
    sanitizeImageUrl: sanitizeImageUrl,
    formatYen: formatYen,
    formatDateTime: formatDateTime,
    saveSearchState: saveSearchState,
    loadSearchState: loadSearchState
  };

})(window);
