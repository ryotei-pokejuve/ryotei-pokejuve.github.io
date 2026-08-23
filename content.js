/* =============================================================
   content.js — サイト共通データ（index.html と lain.html の両方から読み込む）
   ---------------------------------------------------------------
   ページ内容やYouTube連携などの「中身」はここに1箇所だけ書けばOK。
   見た目（UI）は index.html（GBA風）と lain.html（Lain風）がそれぞれ
   別に持っていて、このファイルのデータを共通で表示する。
   ページ内容を編集したいときは、このファイルの PAGES を編集してください。
============================================================= */
(function(global){
  "use strict";

  /* =========================================================
     設定（ここを編集してカスタマイズ）
  ========================================================= */

  // YouTubeチャンネルのURLに変更してください
  var YOUTUBE_CHANNEL_URL = "https://www.youtube.com/@ryotei_pokemoncard";
  // 特集したい動画のID（例: youtube.com/watch?v=xxxxxxxxxxx の xxxxxxxxxxx 部分）。空なら埋め込み非表示
  var YOUTUBE_FEATURED_VIDEO_ID = "u46BlBEv6lk";

  /* ---- YouTube自動更新（動画一覧/Shorts/ポケカ動画/ライブ配信/実績で使用） ----
     設定方法はREADME.md参照。すべて空のままなら「未設定です」と表示されるだけで、
     エラーにはならない。 */
  var YOUTUBE_API_KEY = "AIzaSyBW4fDC9AU3Xjdp2b5_j9L5GaR9zFtSipY";           // Google CloudでYouTube Data API v3のAPIキーを取得
  var YOUTUBE_CHANNEL_ID = "UCv8-wt6gkGbKf0DditFsL_g";        // UCから始まるチャンネルID（@ハンドルではない）
  var YOUTUBE_PLAYLIST_SHORTS = "PLBYd2EyPW3CDVw_g9CwdI2_X34kd78xPK";   // Shorts用の再生リストID
  var YOUTUBE_PLAYLIST_POKECA = "PLBYd2EyPW3CD1YvXDAajn1vfmfQFOWSEj";   // ポケカ動画用の再生リストID
  var YOUTUBE_PLAYLIST_LIVE = "PLflF_vYvMIcE";// ライブ配信動画用の再生リストID

  var SNS_LINKS = [
    { label: "X (Twitter)", href: "https://x.com/ryotei123456", icon: "✕" },
    { label: "YouTube",     href: YOUTUBE_CHANNEL_URL, icon: "▶" },
  ];

  /* =========================================================
     YouTube自動更新まわりのヘルパー
  ========================================================= */
  var ytChannelInfoPromise = null;

  function ytChannelInfo(){
    if(!YOUTUBE_API_KEY || !YOUTUBE_CHANNEL_ID) return Promise.resolve(null);
    if(!ytChannelInfoPromise){
      var url = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,statistics&id=" +
        encodeURIComponent(YOUTUBE_CHANNEL_ID) + "&key=" + encodeURIComponent(YOUTUBE_API_KEY);
      ytChannelInfoPromise = fetch(url).then(function(r){ return r.json(); }).then(function(data){
        var item = data && data.items && data.items[0];
        if(!item) return null;
        return {
          uploadsPlaylistId: item.contentDetails.relatedPlaylists.uploads,
          subscriberCount: item.statistics.subscriberCount,
          videoCount: item.statistics.videoCount,
          viewCount: item.statistics.viewCount
        };
      }).catch(function(){ return null; });
    }
    return ytChannelInfoPromise;
  }

  function ytPlaylistPage(playlistId, pageToken, maxResults){
    if(!YOUTUBE_API_KEY || !playlistId) return Promise.resolve({ videos: [], nextPageToken: null });
    var url = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=" +
      encodeURIComponent(playlistId) + "&maxResults=" + (maxResults || 12) +
      (pageToken ? "&pageToken=" + encodeURIComponent(pageToken) : "") +
      "&key=" + encodeURIComponent(YOUTUBE_API_KEY);
    return fetch(url).then(function(r){ return r.json(); }).then(function(data){
      var videos = (data.items || []).map(function(it){
        var sn = it.snippet || {};
        var thumb = sn.thumbnails && (sn.thumbnails.medium || sn.thumbnails.default);
        return {
          videoId: sn.resourceId && sn.resourceId.videoId,
          title: sn.title,
          publishedAt: sn.publishedAt,
          thumbnail: thumb && thumb.url
        };
      }).filter(function(v){ return v.videoId; });
      return { videos: videos, nextPageToken: data.nextPageToken || null };
    }).catch(function(){ return { videos: [], nextPageToken: null }; });
  }

  function ytIsNew(dateStr){
    var d = new Date(dateStr).getTime();
    return !isNaN(d) && (Date.now() - d) < 1000 * 60 * 60 * 24 * 7; // 7日以内
  }

  // XSS対策: YouTube APIから取得した動画タイトル・サムネイルURLは外部データ扱いとし、
  // HTML文字列への結合は行わずDOM APIで組み立てる（動画タイトルはtextContent、
  // サムネイルURLはhttps確認のうえimg.srcへプロパティ代入）。
  function isHttpsUrl(url){
    if(!url) return false;
    try{
      var u = new URL(url, location.href);
      return u.protocol === "https:";
    }catch(e){
      return false;
    }
  }

  function createVideoItemEl(v){
    var li = document.createElement('li');
    li.className = 'video-item';

    var a = document.createElement('a');
    a.href = "https://www.youtube.com/watch?v=" + encodeURIComponent(v.videoId);
    a.target = "_blank";
    a.rel = "noopener noreferrer";

    if(isHttpsUrl(v.thumbnail)){
      var img = document.createElement('img');
      img.className = 'video-thumb';
      img.src = v.thumbnail;
      img.alt = "";
      img.loading = "lazy";
      a.appendChild(img);
    }

    var infoSpan = document.createElement('span');
    infoSpan.className = 'video-info';

    if(ytIsNew(v.publishedAt)){
      var newSpan = document.createElement('span');
      newSpan.className = 'video-new';
      newSpan.textContent = 'NEW';
      infoSpan.appendChild(newSpan);
    }

    var titleSpan = document.createElement('span');
    titleSpan.className = 'video-title';
    titleSpan.textContent = v.title || "";
    infoSpan.appendChild(titleSpan);

    var dateSpan = document.createElement('span');
    dateSpan.className = 'video-date';
    dateSpan.textContent = new Date(v.publishedAt).toLocaleDateString('ja-JP');
    infoSpan.appendChild(dateSpan);

    a.appendChild(infoSpan);
    li.appendChild(a);
    return li;
  }

  // 動画一覧系ページ：最初の12件を表示し、「もっと見る」を押すたびに次の12件を追加読み込みする
  function ytMountVideoPage(getPlaylistId){
    var container = document.querySelector('#page-content .yt-async');
    if(!container) return;
    Promise.resolve(getPlaylistId()).then(function(playlistId){
      if(!playlistId){
        container.innerHTML = YOUTUBE_API_KEY
          ? '<p class="flavor">再生リストIDが未設定です。</p>'
          : '<p class="flavor">YouTube APIが未設定です。設定すると自動で表示されます（README.md参照）。</p>';
        return;
      }

      var listEl = document.createElement('ul');
      listEl.className = 'video-list';
      container.innerHTML = '';
      container.appendChild(listEl);

      function loadPage(pageToken, isFirst){
        return ytPlaylistPage(playlistId, pageToken, 12).then(function(result){
          if(isFirst && result.videos.length === 0){
            container.innerHTML = '<p class="flavor">動画がまだ見つかりませんでした。再生リストIDを確認してください。</p>';
            return;
          }
          result.videos.forEach(function(v){
            listEl.appendChild(createVideoItemEl(v));
          });
          var oldBtn = container.querySelector('.video-more-btn');
          if(oldBtn) oldBtn.remove();
          if(result.nextPageToken){
            var btn = document.createElement('button');
            btn.type = 'button';
            btn.className = 'video-more-btn';
            btn.textContent = 'もっと見る';
            btn.addEventListener('click', function(){
              btn.disabled = true;
              btn.textContent = 'よみこみちゅう……';
              loadPage(result.nextPageToken, false);
            });
            container.appendChild(btn);
          }
        });
      }

      loadPage(null, true);
    });
  }

  /* =========================================================
     ページ内容テンプレート（editするならここ！）
  ========================================================= */
  var PAGES = {
    top: {
      title: "TOP",
      html: function(){
        return (
          '<p>ポケカの開封や引退品を中心に動画を投稿している、りょていの活動サイトです。</p>' +
          '<p class="flavor">ポケカの引退品って良いよね</p>' +
          '<p>通常動画、Shorts、ライブ配信をメニューからまとめて見られます。カード名や型番から参考価格を探せる「カード相場」も追加しました。</p>' +
          '<table class="stat-table">' +
            '<tr><td>サイト名</td><td>りょていのサイト</td></tr>' +
            '<tr><td>ステータス</td><td>こうかい中</td></tr>' +
            '<tr><td>テーマ</td><td>ポケカ開封・引退品・趣味</td></tr>' +
          '</table>' +
          '<p class="flavor">注目の動画</p>' +
          (YOUTUBE_FEATURED_VIDEO_ID
            ? '<div class="yt-embed-wrap"><iframe src="https://www.youtube.com/embed/' + YOUTUBE_FEATURED_VIDEO_ID + '" title="YouTube video" referrerpolicy="strict-origin-when-cross-origin" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen loading="lazy"></iframe></div>'
            : '') +
          '<a class="contact-btn yt-btn" href="' + YOUTUBE_CHANNEL_URL + '" target="_blank" rel="noopener noreferrer">▶ YouTubeチャンネルを見る</a>'
        );
      }
    },
    profile: {
      title: "PROFILE",
      html: function(){
        return (
          '<p class="flavor">りょていのステータス</p>' +
          '<table class="stat-table">' +
            '<tr><td>名前</td><td>りょてい</td></tr>' +
            '<tr><td>出身</td><td>カントー地方</td></tr>' +
            '<tr><td>趣味</td><td>スポーツ観戦・ツーリング・ポケカ開封</td></tr>' +
            '<tr><td>ひとこと</td><td>RSE良いよね</td></tr>' +
          '</table>'
        );
      }
    },
    history: {
      title: "HISTORY",
      html: function(){
        return (
          '<p class="flavor">つづきから</p>' +
          '<ul class="log-list">' +
            '<li class="log-item"><span class="log-ver">Ver 1.00</span><span class="log-date">2026.08.13</span><span>サイトを公開！GBA風トップページを実装しました。</span></li>' +
            '<li class="log-item"><span class="log-ver">Ver 0.10</span><span class="log-date">2026.08.01</span><span>サイト制作を開始。デザインコンセプトを決定。</span></li>' +
          '</ul>' +
          '<p class="flavor" style="margin-top:16px;"></p>'
        );
      }
    },
    blog: {
      title: "BLOG",
      html: function(){
        return (
          '<p class="flavor">レポート(記事一覧）</p>' +
          '<article class="blog-post">' +
            '<h3>はじめまして</h3>' +
            '<div class="blog-meta">2026.08.13 <span class="blog-tag">お知らせ</span></div>' +
            '<p>YouTubeに投稿した通常動画、Shorts、ポケカ動画、ライブ配信を一か所から見られる活動サイトを公開しました。動画一覧は各メニューから確認できます。</p>' +
          '</article>' +
          '<article class="blog-post">' +
            '<h3>動画メニューの使い分け</h3>' +
            '<div class="blog-meta">2026.08.18 <span class="blog-tag">サイト案内</span></div>' +
            '<p>「動画一覧」はチャンネルの新着順、「Shorts」は短い動画、「ポケカ動画」はカード関連に絞った再生リストです。じっくり見るときは通常動画、短時間で楽しみたいときはShortsがおすすめです。</p>' +
          '</article>' +
          '<article class="blog-post">' +
            '<h3>カード相場検索を追加しました</h3>' +
            '<div class="blog-meta">2026.08.18 <span class="blog-tag">更新情報</span></div>' +
            '<p>カード名・型番・レアリティ・収録パックからカードを探し、管理者が登録した直近の参考価格を確認できます。実際の価格は状態や店舗で変わるため、売買時は複数の情報とあわせてご利用ください。</p>' +
          '</article>'
        );
      }
    },
    sns: {
      title: "SNS",
      html: function(){
        return (
          '<p class="flavor">「りょていのつうしんケーブル」</p>' +
          '<p>各種SNSはこちらから。フォロー・ご連絡お待ちしています。</p>' +
          '<footer id="sns-links">' + SNS_LINKS.map(function(s){
            return '<a class="sns-btn" href="' + s.href + '" target="_blank" rel="noopener noreferrer">' +
                   '<span class="sns-icon">' + s.icon + '</span>' + s.label + '</a>';
          }).join('') + '</footer>'
        );
      }
    },
    videos: {
      title: "VIDEOS",
      html: function(){
        return '<p class="flavor">📹 投稿動画の一覧（新着順）</p><div class="yt-async">よみこみちゅう……</div>';
      },
      onMount: function(){
        ytMountVideoPage(function(){
          return ytChannelInfo().then(function(info){ return info && info.uploadsPlaylistId; });
        });
      }
    },
    shorts: {
      title: "SHORTS",
      html: function(){
        return '<p class="flavor">💡 Shorts一覧</p><div class="yt-async">よみこみちゅう……</div>';
      },
      onMount: function(){
        ytMountVideoPage(function(){ return YOUTUBE_PLAYLIST_SHORTS; });
      }
    },
    pokeca: {
      title: "CARD VIDEOS",
      html: function(){
        return '<p class="flavor">🎴 ポケカ関連動画</p><div class="yt-async">よみこみちゅう……</div>';
      },
      onMount: function(){
        ytMountVideoPage(function(){ return YOUTUBE_PLAYLIST_POKECA; });
      }
    },
    live: {
      title: "LIVE",
      html: function(){
        return '<p class="flavor">🖥️ ライブ配信</p><div class="yt-async">よみこみちゅう……</div>';
      },
      onMount: function(){
        ytMountVideoPage(function(){ return YOUTUBE_PLAYLIST_LIVE; });
      }
    },
    achievements: {
      title: "ACHIEVEMENTS",
      html: function(){
        return (
          '<p class="flavor">🏆 チャンネル実績</p>' +
          '<div class="yt-async">よみこみちゅう……</div>' +
          '<p class="flavor" style="margin-top:16px;">チャンネルの現在地</p>' +
          '<p>登録者数・動画数・総再生数をYouTubeから取得して表示しています。最新動画は「動画一覧」からご覧ください。</p>'
        );
      },
      onMount: function(){
        var container = document.querySelector('#page-content .yt-async');
        if(!container) return;
        ytChannelInfo().then(function(info){
          if(!info){
            container.innerHTML = '<p class="flavor">YouTube APIが未設定です。設定すると登録者数などが自動表示されます（README.md参照）。</p>';
            return;
          }
          container.innerHTML =
            '<table class="stat-table">' +
              '<tr><td>登録者数</td><td>' + Number(info.subscriberCount).toLocaleString() + '人</td></tr>' +
              '<tr><td>総動画数</td><td>' + Number(info.videoCount).toLocaleString() + '本</td></tr>' +
              '<tr><td>総再生数</td><td>' + Number(info.viewCount).toLocaleString() + '回</td></tr>' +
            '</table>';
        });
      }
    }
  };

  var PAGE_ORDER = ["top","videos","shorts","pokeca","live","achievements","profile","history","blog","sns"];

  /* =========================================================
     外部（index.html / lain.html）に公開
  ========================================================= */
  global.SITE = {
    YOUTUBE_CHANNEL_URL: YOUTUBE_CHANNEL_URL,
    YOUTUBE_FEATURED_VIDEO_ID: YOUTUBE_FEATURED_VIDEO_ID,
    SNS_LINKS: SNS_LINKS,
    PAGES: PAGES,
    PAGE_ORDER: PAGE_ORDER,
    ytChannelInfo: ytChannelInfo
  };

})(window);
