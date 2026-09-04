/* =============================================================
   site-content.js — HISTORY / BLOG 公開コンテンツ
   ============================================================= */
(function(global){
  "use strict";

  var SUPABASE_URL = "https://idnhamxtwxfcxflenxko.supabase.co";
  var SUPABASE_ANON_KEY = "sb_publishable_lZoCHYEsf4LscKv2TVphBg_0JAAy4wO";
  var HISTORY_KEY = "history_entries_v1";
  var BLOG_KEY = "blog_posts_v2";
  var LEGACY_BLOG_KEY = "blog_posts_v1";

  var DEFAULT_HISTORY = [
    { id:"history-20260813", version:"Ver 1.00", date:"2026.08.13", text:"サイトを公開！GBA風トップページを実装しました。" },
    { id:"history-20260801", version:"Ver 0.10", date:"2026.08.01", text:"サイト制作を開始。デザインコンセプトを決定。" },
    { id:"history-youtube", version:"", date:"", text:"ポケモンカードの開封・引退品を中心にYouTubeで動画投稿を開始。" },
    { id:"history-card-db", version:"", date:"", text:"ポケモンカードのデータベースを整備し、カード名・シリーズ・パックから探せるカード図鑑を追加。" },
    { id:"history-card-data", version:"", date:"", text:"カード画像や収録情報、レアリティなどのデータを少しずつ補完・整理。" },
    { id:"history-price", version:"", date:"", text:"ショート動画で紹介したカードをまとめ、カードラッシュ・晴れる屋2・メルカリの参考価格を掲載するPRICEページを追加。" },
    { id:"history-admin", version:"", date:"", text:"管理画面からショート掲載カードや価格を編集できる仕組みを追加。" },
    { id:"history-2d", version:"", date:"", text:"サイト全体をゲーム端末風の2D MODEへリニューアル。" },
    { id:"history-3d", version:"", date:"", text:"今後は3D MODEなど、新しい表示や機能も追加予定。" }
  ];

  var DEFAULT_BLOG = [
    { id:"hello", title:"はじめまして", date:"2026.08.13", tag:"お知らせ", excerpt:"活動サイトを公開しました。", blocks:[{type:"paragraph",text:"YouTubeに投稿した通常動画、Shorts、ポケカ動画、ライブ配信を一か所から見られる活動サイトを公開しました。動画一覧は各メニューから確認できます。"}] },
    { id:"video-menu-guide", title:"動画メニューの使い分け", date:"2026.08.18", tag:"サイト案内", excerpt:"動画メニューの見方を紹介します。", blocks:[{type:"paragraph",text:"「動画一覧」はチャンネルの新着順、「Shorts」は短い動画、「ポケカ動画」はカード関連に絞った再生リストです。じっくり見るときは通常動画、短時間で楽しみたいときはShortsがおすすめです。"}] },
    { id:"card-market-added", title:"カード相場検索を追加しました", date:"2026.08.18", tag:"更新情報", excerpt:"カード相場検索を追加しました。", blocks:[{type:"paragraph",text:"カード名・型番・レアリティ・収録パックからカードを探し、管理者が登録した直近の参考価格を確認できます。実際の価格は状態や店舗で変わるため、売買時は複数の情報とあわせてご利用ください。"}] }
  ];

  function clone(value){ return JSON.parse(JSON.stringify(value)); }
  function cleanText(v){ return String(v == null ? "" : v); }

  function normalizeHistory(value){
    if(!Array.isArray(value)) return null;
    return value.map(function(item,index){
      item=item||{};
      return {id:cleanText(item.id||("history-"+index)),version:cleanText(item.version),date:cleanText(item.date),text:cleanText(item.text)};
    }).filter(function(item){return item.text.trim();});
  }

  function normalizeBlocks(blocks){
    if(!Array.isArray(blocks)) return [];
    return blocks.map(function(block){
      block=block||{};
      var type=cleanText(block.type);
      if(type === "heading") return {type:"heading",text:cleanText(block.text)};
      if(type === "image") return {type:"image",url:cleanText(block.url),alt:cleanText(block.alt),caption:cleanText(block.caption)};
      return {type:"paragraph",text:cleanText(block.text)};
    }).filter(function(block){ return block.type === "image" ? !!block.url : !!block.text.trim(); });
  }

  function legacyBodyToBlocks(body){
    var text=cleanText(body).trim();
    if(!text) return [];
    return text.split(/\n{2,}/).map(function(part){return {type:"paragraph",text:part};});
  }

  function normalizeBlog(value){
    if(!Array.isArray(value)) return null;
    return value.map(function(item,index){
      item=item||{};
      var blocks=normalizeBlocks(item.blocks);
      if(!blocks.length && item.body) blocks=legacyBodyToBlocks(item.body);
      if(item.image_url && !blocks.some(function(b){return b.type==="image";})){
        blocks.unshift({type:"image",url:cleanText(item.image_url),alt:cleanText(item.title),caption:""});
      }
      return {
        id:cleanText(item.id||("post-"+index)),
        title:cleanText(item.title),date:cleanText(item.date),tag:cleanText(item.tag),
        excerpt:cleanText(item.excerpt),featured_image_url:cleanText(item.featured_image_url||item.image_url),
        blocks:blocks
      };
    }).filter(function(item){return item.title.trim() && item.blocks.length;});
  }

  function getSetting(key){
    return fetch(SUPABASE_URL + "/rest/v1/rpc/get_site_setting", {
      method:"POST",
      headers:{"apikey":SUPABASE_ANON_KEY,"Authorization":"Bearer "+SUPABASE_ANON_KEY,"Content-Type":"application/json","Accept":"application/json","Accept-Profile":"api","Content-Profile":"api"},
      body:JSON.stringify({p_key:key})
    }).then(function(response){
      if(!response.ok) throw new Error("HTTP "+response.status);
      return response.json();
    }).then(function(value){
      if(value == null || value === "") return null;
      return typeof value === "string" ? value : String(value);
    });
  }

  function loadJson(key,fallback,normalizer){
    return getSetting(key).then(function(raw){
      if(!raw) return clone(fallback);
      var normalized=normalizer(JSON.parse(raw));
      return normalized || clone(fallback);
    });
  }

  function loadHistory(){
    return loadJson(HISTORY_KEY,DEFAULT_HISTORY,normalizeHistory).catch(function(error){console.warn("RYOTEI history fallback",error);return clone(DEFAULT_HISTORY);});
  }

  function loadBlogPosts(){
    return getSetting(BLOG_KEY).then(function(raw){
      if(raw){ var parsed=normalizeBlog(JSON.parse(raw)); if(parsed) return parsed; }
      return getSetting(LEGACY_BLOG_KEY).then(function(legacyRaw){
        if(!legacyRaw) return clone(DEFAULT_BLOG);
        return normalizeBlog(JSON.parse(legacyRaw)) || clone(DEFAULT_BLOG);
      });
    }).catch(function(error){console.warn("RYOTEI blog fallback",error);return clone(DEFAULT_BLOG);});
  }

  function sortBlog(posts){
    return posts.slice().sort(function(a,b){return String(b.date).localeCompare(String(a.date)) || String(b.id).localeCompare(String(a.id));});
  }

  function textFromBlocks(post){
    return (post.blocks||[]).filter(function(b){return b.type!=="image";}).map(function(b){return b.text||"";}).join(" ").replace(/\s+/g," ").trim();
  }
  function excerptFor(post,limit){
    var text=post.excerpt.trim() || textFromBlocks(post);
    limit=limit||180;
    return text.length>limit ? text.slice(0,limit)+"…" : text;
  }
  function firstImage(post){
    if(post.featured_image_url) return post.featured_image_url;
    var image=(post.blocks||[]).find(function(b){return b.type==="image" && b.url;});
    return image ? image.url : "";
  }

  function renderPostBlocks(post,container){
    (post.blocks||[]).forEach(function(block){
      if(block.type === "heading"){
        var h=document.createElement("h3"); h.textContent=block.text; container.appendChild(h); return;
      }
      if(block.type === "image"){
        var figure=document.createElement("figure"); figure.className="blog-content-image";
        var img=document.createElement("img"); img.src=block.url; img.alt=block.alt||post.title||""; img.loading="lazy"; figure.appendChild(img);
        if(block.caption){var cap=document.createElement("figcaption");cap.textContent=block.caption;figure.appendChild(cap);} container.appendChild(figure); return;
      }
      var p=document.createElement("p"); p.textContent=block.text; p.style.whiteSpace="pre-line"; container.appendChild(p);
    });
  }

  function renderHistory(container){
    if(!container) return Promise.resolve([]);
    container.textContent="HISTORYを読み込んでいます……";
    return loadHistory().then(function(entries){
      container.innerHTML="";
      var list=document.createElement("ul"); list.className="log-list";
      entries.forEach(function(entry){
        var li=document.createElement("li"); li.className="log-item";
        if(entry.version){var ver=document.createElement("span");ver.className="log-ver";ver.textContent=entry.version;li.appendChild(ver);}
        if(entry.date){var date=document.createElement("span");date.className="log-date";date.textContent=entry.date;li.appendChild(date);}
        var text=document.createElement("span");text.textContent=entry.text;li.appendChild(text);list.appendChild(li);
      });
      container.appendChild(list); return entries;
    });
  }

  function renderBlogPreview(container,limit){
    if(!container) return Promise.resolve([]);
    container.textContent="BLOGを読み込んでいます……";
    return loadBlogPosts().then(function(posts){
      posts=sortBlog(posts); container.innerHTML="";
      posts.slice(0,limit||3).forEach(function(post){
        var article=document.createElement("article"); article.className="blog-post";
        var h=document.createElement("h3"),a=document.createElement("a");a.href="blog.html?post="+encodeURIComponent(post.id);a.textContent=post.title;h.appendChild(a);article.appendChild(h);
        var meta=document.createElement("div");meta.className="blog-meta";meta.textContent=[post.date,post.tag].filter(Boolean).join(" / ");article.appendChild(meta);
        var imageUrl=firstImage(post); if(imageUrl){var img=document.createElement("img");img.src=imageUrl;img.alt=post.title;img.loading="lazy";img.style.cssText="display:block;width:100%;max-height:260px;object-fit:cover;margin:10px 0;border:1px solid var(--line);";article.appendChild(img);}
        var excerpt=document.createElement("p");excerpt.textContent=excerptFor(post,140);article.appendChild(excerpt);container.appendChild(article);
      });
      var link=document.createElement("a");link.className="contact-btn";link.href="blog.html";link.textContent="BLOGをすべて見る";container.appendChild(link);return posts;
    });
  }

  global.RYOTEI_CONTENT_STORE={
    HISTORY_KEY:HISTORY_KEY,BLOG_KEY:BLOG_KEY,LEGACY_BLOG_KEY:LEGACY_BLOG_KEY,
    DEFAULT_HISTORY:clone(DEFAULT_HISTORY),DEFAULT_BLOG:clone(DEFAULT_BLOG),
    loadHistory:loadHistory,loadBlogPosts:loadBlogPosts,sortBlog:sortBlog,
    renderHistory:renderHistory,renderBlogPreview:renderBlogPreview,renderPostBlocks:renderPostBlocks,
    excerptFor:excerptFor,firstImage:firstImage
  };
})(window);
