# PowerShell script to generate HTML slides and render PNGs
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$desktop = [Environment]::GetFolderPath("Desktop")
$baseDir = Join-Path $desktop "WRoomie\ig_post"
$imgDir = Join-Path $baseDir "images"
$outDir = Join-Path $baseDir "output"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$b64_food1 = [Convert]::ToBase64String([IO.File]::ReadAllBytes((Join-Path $imgDir "food_1.jpg")))
$b64_food2 = [Convert]::ToBase64String([IO.File]::ReadAllBytes((Join-Path $imgDir "food_2.jpg")))
$b64_joe = [Convert]::ToBase64String([IO.File]::ReadAllBytes((Join-Path $imgDir "chef_joe.jpg")))

$cssCommon = @"
  @import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,600;0,700;1,400;1,600&family=Noto+Serif+TC:wght@400;500;600;700;900&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap');

  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    -webkit-font-smoothing: antialiased;
  }

  body {
    width: 1080px;
    height: 1350px;
    background-color: #FAF7F2;
    background-image: radial-gradient(rgba(188, 90, 54, 0.03) 1px, transparent 1px), radial-gradient(rgba(45, 39, 33, 0.02) 1px, #FAF7F2 1px);
    background-size: 40px 40px;
    background-position: 0 0, 20px 20px;
    font-family: 'Noto Serif TC', serif;
    color: #2D2721;
    overflow: hidden;
    position: relative;
    padding: 72px 80px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }

  .frame-border {
    position: absolute;
    top: 32px;
    left: 32px;
    right: 32px;
    bottom: 32px;
    border: 1px solid rgba(188, 90, 54, 0.22);
    pointer-events: none;
    z-index: 100;
  }
  .frame-border::before {
    content: '';
    position: absolute;
    top: 6px;
    left: 6px;
    right: 6px;
    bottom: 6px;
    border: 1px solid rgba(45, 39, 33, 0.08);
  }

  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid rgba(188, 90, 54, 0.18);
    padding-bottom: 22px;
    position: relative;
    z-index: 10;
  }

  .brand-logo {
    display: flex;
    align-items: baseline;
    gap: 12px;
  }

  .brand-logo .eng {
    font-family: 'Cormorant Garamond', serif;
    font-size: 34px;
    font-weight: 700;
    letter-spacing: 4px;
    color: #BC5A36;
  }

  .brand-logo .slash {
    color: #D4C8B8;
    font-weight: 300;
    font-size: 20px;
  }

  .brand-logo .cht {
    font-family: 'Noto Serif TC', serif;
    font-size: 18px;
    font-weight: 600;
    letter-spacing: 3px;
    color: #554D44;
  }

  .slide-tag {
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 13px;
    font-weight: 600;
    letter-spacing: 3px;
    color: #8C8275;
    text-transform: uppercase;
    background: #F0EAE1;
    padding: 6px 14px;
    border-radius: 20px;
    border: 1px solid #E2D7C7;
  }

  .content-main {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    position: relative;
    z-index: 10;
  }

  .year-badge-container {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 18px;
  }

  .year-pill {
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 2px;
    color: #FFFFFF;
    background: #BC5A36;
    padding: 6px 16px;
    border-radius: 14px;
    text-transform: uppercase;
  }

  .year-en-sub {
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-size: 20px;
    color: #8C8275;
    letter-spacing: 1px;
  }

  .slide-title {
    font-size: 42px;
    font-weight: 900;
    line-height: 1.35;
    color: #241E18;
    letter-spacing: 1.5px;
    margin-bottom: 26px;
  }

  .slide-title span {
    color: #BC5A36;
  }

  .story-p {
    font-size: 23.5px;
    line-height: 1.95;
    color: #453E36;
    letter-spacing: 0.8px;
    margin-bottom: 22px;
    font-weight: 500;
  }

  .story-p strong {
    color: #BC5A36;
    font-weight: 700;
  }

  .watermark-year {
    position: absolute;
    right: -20px;
    top: 20px;
    font-family: 'Cormorant Garamond', serif;
    font-size: 210px;
    font-weight: 700;
    color: rgba(188, 90, 54, 0.05);
    line-height: 0.8;
    user-select: none;
    pointer-events: none;
    z-index: -1;
  }

  .footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top: 1px solid rgba(188, 90, 54, 0.18);
    padding-top: 22px;
    position: relative;
    z-index: 10;
  }

  .footer-left {
    font-size: 14px;
    color: #8C8275;
    letter-spacing: 1.5px;
    font-family: 'Noto Serif TC', serif;
  }

  .swipe-hint {
    display: flex;
    align-items: center;
    gap: 8px;
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 13px;
    font-weight: 700;
    color: #BC5A36;
    letter-spacing: 2px;
  }

  .card-quote-box {
    background: #FFFFFF;
    border: 1px solid #E6DED2;
    border-left: 4px solid #BC5A36;
    border-radius: 8px;
    padding: 24px 28px;
    margin-top: 20px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.02);
  }

  .card-quote-box p {
    font-size: 20px;
    line-height: 1.8;
    color: #554D44;
    font-style: italic;
  }
"@

# Slide 1: Cover
$slide1_html = @"
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<style>
$cssCommon

  .cover-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 14px;
    font-weight: 700;
    color: #BC5A36;
    letter-spacing: 3px;
    text-transform: uppercase;
    background: #F3ECE1;
    border: 1px solid #DFD3C3;
    padding: 8px 20px;
    border-radius: 20px;
    margin-bottom: 30px;
    width: fit-content;
  }

  .cover-badge::before {
    content: '';
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #BC5A36;
  }

  .hero-quote {
    font-size: 58px;
    font-weight: 900;
    line-height: 1.35;
    color: #241E18;
    letter-spacing: 2px;
    margin-bottom: 30px;
  }

  .hero-quote span {
    color: #BC5A36;
    font-style: italic;
  }

  .cover-desc {
    font-size: 24px;
    line-height: 2;
    color: #554D44;
    letter-spacing: 1px;
    margin-bottom: 44px;
    max-width: 820px;
  }

  .author-card {
    display: flex;
    align-items: center;
    gap: 22px;
    background: #FFFFFF;
    border: 1px solid #E8E0D2;
    padding: 22px 32px;
    border-radius: 16px;
    width: fit-content;
    box-shadow: 0 8px 24px rgba(45, 39, 33, 0.04);
  }

  .author-avatar {
    width: 64px;
    height: 64px;
    border-radius: 50%;
    background: linear-gradient(135deg, #BC5A36 0%, #983F20 100%);
    color: #FFFFFF;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Cormorant Garamond', serif;
    font-size: 32px;
    font-weight: 700;
    box-shadow: 0 4px 12px rgba(188, 90, 54, 0.3);
  }

  .author-info h4 {
    font-size: 22px;
    font-weight: 700;
    color: #241E18;
    margin-bottom: 4px;
    letter-spacing: 1px;
  }

  .author-info p {
    font-size: 15px;
    color: #8C8275;
    font-family: 'Plus Jakarta Sans', sans-serif;
    letter-spacing: 1px;
  }

  .cover-illustration {
    position: absolute;
    right: 40px;
    bottom: 20px;
    opacity: 0.12;
    width: 260px;
  }
</style>
</head>
<body>
  <div class="frame-border"></div>

  <div class="header">
    <div class="brand-logo">
      <span class="eng">WRoomie</span>
      <span class="slash">|</span>
      <span class="cht">料理</span>
    </div>
    <div class="slide-tag">Brand Story 01/05</div>
  </div>

  <div class="content-main">
    <div class="watermark-year">W</div>
    <div class="cover-badge">Brand Story · 品牌故事</div>
    <h1 class="hero-quote">「透過料理，<br><span>遊歷世界</span>。」</h1>
    <p class="cover-desc">
      從台北深夜的後場廚房，到高雄陽光下的風土餐桌。<br>
      這是一個文組大學生，把旅行記憶與世界美味<br>
      帶進生活與每一張餐桌的真實歷程。
    </p>

    <div class="author-card">
      <div class="author-avatar">J</div>
      <div class="author-info">
        <h4>嗨，我是 Joe。</h4>
        <p>WRoomie Founder & Culinary Creator</p>
      </div>
    </div>
  </div>

  <div class="footer">
    <div class="footer-left">WRoomie ｜ 探索風味的下一站</div>
    <div class="swipe-hint">SWIPE ➔</div>
  </div>
</body>
</html>
"@

# Slide 2: 2012
$slide2_html = @"
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<style>
$cssCommon

  .kitchen-card {
    background: #FFFFFF;
    border: 1px solid #E8E0D2;
    border-radius: 16px;
    padding: 38px 42px;
    margin-top: 30px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.03);
    position: relative;
  }

  .kitchen-quote-icon {
    font-family: 'Cormorant Garamond', serif;
    font-size: 72px;
    line-height: 1;
    color: #BC5A36;
    opacity: 0.3;
    position: absolute;
    top: 16px;
    right: 28px;
  }

  .keywords-tag-row {
    display: flex;
    gap: 12px;
    margin-top: 28px;
  }

  .kw-tag {
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 13px;
    font-weight: 600;
    color: #7D7366;
    background: #F4EFE6;
    padding: 6px 14px;
    border-radius: 20px;
    letter-spacing: 1px;
  }
</style>
</head>
<body>
  <div class="frame-border"></div>

  <div class="header">
    <div class="brand-logo">
      <span class="eng">WRoomie</span>
      <span class="slash">|</span>
      <span class="cht">料理</span>
    </div>
    <div class="slide-tag">Chapter 01 · 02/05</div>
  </div>

  <div class="content-main">
    <div class="watermark-year">2012</div>

    <div class="year-badge-container">
      <div class="year-pill">2012</div>
      <div class="year-en-sub">The Spark · 闖入後場的起點</div>
    </div>

    <h2 class="slide-title">普通文組生的<span>料理轉捩點</span></h2>

    <p class="story-p">
      2012 年，我還只是一個普通的文組大學生，<br>
      不小心闖進了廚房後場——
    </p>

    <div class="kitchen-card">
      <div class="kitchen-quote-icon">“</div>
      <p class="story-p" style="margin-bottom: 0; font-size: 26px; line-height: 1.9;">
        那個 <strong>Rush</strong>、瘋狂，<br>
        卻又充滿<strong>生命力</strong>的領地。<br><br>
        從那之後，<strong>做菜成了我的志業。</strong>
      </p>
    </div>

    <div class="keywords-tag-row">
      <span class="kw-tag">#文組生的逆轉</span>
      <span class="kw-tag">#廚房後場Rush</span>
      <span class="kw-tag">#以料理為志業</span>
      <span class="kw-tag">#熱情起點</span>
    </div>
  </div>

  <div class="footer">
    <div class="footer-left">2012 · 從後場的高壓中萌生熱愛</div>
    <div class="swipe-hint">SWIPE ➔</div>
  </div>
</body>
</html>
"@

# Slide 3: 2022 (Combined with 2 food photos)
$slide3_html = @"
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<style>
$cssCommon

  .slide3-content {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    height: 100%;
    padding: 20px 0;
  }

  .photo-duo-container {
    display: flex;
    gap: 28px;
    margin-top: 24px;
    align-items: center;
    justify-content: center;
  }

  .polaroid-card {
    background: #FFFFFF;
    padding: 14px 14px 20px 14px;
    border-radius: 14px;
    box-shadow: 0 10px 28px rgba(45, 39, 33, 0.08);
    border: 1px solid #E8E1D5;
    width: 440px;
    transition: transform 0.3s ease;
  }

  .polaroid-card.card-1 {
    transform: rotate(-1.5deg);
  }

  .polaroid-card.card-2 {
    transform: rotate(1.5deg);
  }

  .photo-frame {
    width: 100%;
    height: 360px;
    border-radius: 8px;
    overflow: hidden;
    background: #EEE7DC;
  }

  .photo-frame img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }

  .photo-caption {
    font-size: 14px;
    color: #7D7366;
    text-align: center;
    margin-top: 12px;
    letter-spacing: 1px;
    font-family: 'Noto Serif TC', serif;
  }

  .roomie-highlight {
    background: #F4EFE6;
    border-radius: 12px;
    padding: 16px 20px;
    border-left: 3px solid #BC5A36;
    font-size: 18px;
    line-height: 1.7;
    color: #554D44;
    margin-top: 14px;
  }
</style>
</head>
<body>
  <div class="frame-border"></div>

  <div class="header">
    <div class="brand-logo">
      <span class="eng">WRoomie</span>
      <span class="slash">|</span>
      <span class="cht">料理</span>
    </div>
    <div class="slide-tag">Chapter 02 · 03/05</div>
  </div>

  <div class="content-main">
    <div class="watermark-year">2022</div>

    <div class="year-badge-container">
      <div class="year-pill">2022</div>
      <div class="year-en-sub">Birth of Roomie · 一日室友的餐桌</div>
    </div>

    <h2 class="slide-title" style="margin-bottom: 18px; font-size: 38px;">成立 Roomie：<span>把想像做成一桌好菜</span></h2>

    <p class="story-p" style="font-size: 21.5px; line-height: 1.8; margin-bottom: 12px;">
      2022 年，我成立了 <strong>Roomie</strong>。<br>
      起心動念其實很單純，我想做一桌從食譜裡翻閱到、從旅行或生活中想像過的料理，約三五好友們來當我的一日室友享受美食。
    </p>

    <div class="roomie-highlight">
      特此感謝我的<strong>瘋狂室友</strong>，不畏油煙（他房間的空氣清淨機常常亮紅燈！）並且成為我的忠實嘉賓。
    </div>

    <div class="photo-duo-container">
      <div class="polaroid-card card-1">
        <div class="photo-frame">
          <img src="data:image/jpeg;base64,$b64_food1" alt="Roomie 料理創作">
        </div>
        <div class="photo-caption">翻閱食譜與旅行記憶的味覺想像</div>
      </div>

      <div class="polaroid-card card-2">
        <div class="photo-frame">
          <img src="data:image/jpeg;base64,$b64_food2" alt="Roomie 私廚餐桌">
        </div>
        <div class="photo-caption">為一日室友端上的繽紛盛宴</div>
      </div>
    </div>
  </div>

  <div class="footer">
    <div class="footer-left">2022 · 每一道菜，都是一次餐桌上的旅行</div>
    <div class="swipe-hint">SWIPE ➔</div>
  </div>
</body>
</html>
"@

# Slide 4: 2026 (Combined with chef photo)
$slide4_html = @"
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<style>
$cssCommon

  .grid-layout {
    display: flex;
    gap: 36px;
    align-items: center;
    margin-top: 10px;
  }

  .text-column {
    flex: 1.15;
  }

  .photo-column {
    flex: 0.85;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .chef-photo-card {
    background: #FFFFFF;
    padding: 14px 14px 18px 14px;
    border-radius: 16px;
    box-shadow: 0 10px 30px rgba(45, 39, 33, 0.08);
    border: 1px solid #E8E1D5;
    width: 370px;
  }

  .chef-photo-frame {
    width: 100%;
    height: 480px;
    border-radius: 10px;
    overflow: hidden;
    background: #EBE4D8;
  }

  .chef-photo-frame img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center top;
    display: block;
  }

  .chef-caption {
    font-size: 14px;
    color: #8C8275;
    text-align: center;
    margin-top: 12px;
    letter-spacing: 1px;
  }

  .insight-box {
    background: #FFFFFF;
    border: 1px solid #E8E0D2;
    border-left: 3px solid #BC5A36;
    border-radius: 10px;
    padding: 20px 24px;
    margin-top: 18px;
    box-shadow: 0 4px 14px rgba(0,0,0,0.02);
  }

  .insight-box p {
    font-size: 20px;
    line-height: 1.75;
    color: #453E36;
    margin-bottom: 0;
  }
</style>
</head>
<body>
  <div class="frame-border"></div>

  <div class="header">
    <div class="brand-logo">
      <span class="eng">WRoomie</span>
      <span class="slash">|</span>
      <span class="cht">料理</span>
    </div>
    <div class="slide-tag">Chapter 03 · 04/05</div>
  </div>

  <div class="content-main">
    <div class="watermark-year">2026</div>

    <div class="year-badge-container">
      <div class="year-pill">2026</div>
      <div class="year-en-sub">Back to Kaohsiung · 回到高雄</div>
    </div>

    <h2 class="slide-title" style="margin-bottom: 20px; font-size: 38px;">放下習慣，<span>重新認識一座城市</span></h2>

    <div class="grid-layout">
      <div class="text-column">
        <p class="story-p" style="font-size: 21.5px; line-height: 1.85;">
          2026 年，我回到高雄。<br><br>
          熟悉的是親愛的家人和朋友，<br>
          陌生的卻是這裡完全不同於台北的食材、風土與飲食環境。
        </p>

        <div class="insight-box">
          <p>
            於是，我開始試著<strong>放下過去在台北習慣的做菜邏輯</strong>，<br>
            重新認識一座城市，也重新認識料理。
          </p>
        </div>
      </div>

      <div class="photo-column">
        <div class="chef-photo-card">
          <div class="chef-photo-frame">
            <img src="data:image/jpeg;base64,$b64_joe" alt="Joe 專注料理">
          </div>
          <div class="chef-caption">專注於每道料理的細節與溫度</div>
        </div>
      </div>
    </div>
  </div>

  <div class="footer">
    <div class="footer-left">2026 · 高雄食材 × 風土探索</div>
    <div class="swipe-hint">SWIPE ➔</div>
  </div>
</body>
</html>
"@

# Slide 5: Vision & Ending
$slide5_html = @"
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<style>
$cssCommon

  .vision-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 13px;
    font-weight: 700;
    color: #BC5A36;
    letter-spacing: 3px;
    text-transform: uppercase;
    background: #F3ECE1;
    border: 1px solid #DFD3C3;
    padding: 6px 18px;
    border-radius: 20px;
    margin-bottom: 18px;
    width: fit-content;
  }

  .golden-quote-box {
    background: linear-gradient(135deg, #FFFFFF 0%, #FAF5ED 100%);
    border: 2px solid #BC5A36;
    border-radius: 20px;
    padding: 36px 40px;
    margin: 28px 0;
    box-shadow: 0 10px 30px rgba(188, 90, 54, 0.08);
    position: relative;
  }

  .quote-top-line {
    font-size: 23px;
    line-height: 1.8;
    color: #63584B;
    text-align: center;
    margin-bottom: 14px;
    font-weight: 500;
  }

  .quote-main-title {
    font-size: 40px;
    font-weight: 900;
    color: #BC5A36;
    text-align: center;
    letter-spacing: 2px;
    line-height: 1.35;
  }

  .call-to-action-card {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #FFFFFF;
    border: 1px solid #E8E0D2;
    padding: 22px 32px;
    border-radius: 16px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.03);
  }

  .cta-left h4 {
    font-size: 20px;
    font-weight: 700;
    color: #241E18;
    margin-bottom: 4px;
  }

  .cta-left p {
    font-size: 14px;
    color: #8C8275;
    letter-spacing: 1px;
  }

  .cta-btn {
    background: #BC5A36;
    color: #FFFFFF;
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 14px;
    font-weight: 700;
    letter-spacing: 2px;
    padding: 12px 24px;
    border-radius: 30px;
    text-transform: uppercase;
  }
</style>
</head>
<body>
  <div class="frame-border"></div>

  <div class="header">
    <div class="brand-logo">
      <span class="eng">WRoomie</span>
      <span class="slash">|</span>
      <span class="cht">料理</span>
    </div>
    <div class="slide-tag">Vision · 05/05</div>
  </div>

  <div class="content-main">
    <div class="watermark-year">W</div>

    <div class="vision-badge">The Journey Continues · 新旅程</div>

    <h2 class="slide-title" style="margin-bottom: 20px; font-size: 38px;">
      從高雄出發，<span>把世界帶回餐桌</span>
    </h2>

    <p class="story-p" style="font-size: 22px; line-height: 1.85; margin-bottom: 16px;">
      <strong>WRoomie</strong>，是 Roomie 回到高雄之後的下一段旅程。<br>
      從高雄的食材出發，把地方的味道帶進料理，也把世界各地曾經感動我的飲食方式帶回餐桌。<br><br>
      我想做的不只是一頓飯，而是讓料理成為一種<strong>認識地方、感受生活的方式</strong>。
    </p>

    <div class="golden-quote-box">
      <div class="quote-top-line">
        下廚可以很簡單，<br>
        探索世界也不一定要從登機開始。
      </div>
      <div class="quote-main-title">
        「透過料理，我們也可以遊歷世界。」
      </div>
    </div>

    <div class="call-to-action-card">
      <div class="cta-left">
        <h4>歡迎成為 WRoomie 的一日室友</h4>
        <p>追蹤 @WRoomie ｜ 一起在餐桌上漫遊世界</p>
      </div>
      <div class="cta-btn">Follow Us ★</div>
    </div>
  </div>

  <div class="footer">
    <div class="footer-left">WRoomie @ Kaohsiung · 2026</div>
    <div class="swipe-hint">SAVE & SHARE ↗</div>
  </div>
</body>
</html>
"@

# Save HTML files
Set-Content -Path (Join-Path $baseDir "slide1.html") -Value $slide1_html -Encoding UTF8
Set-Content -Path (Join-Path $baseDir "slide2.html") -Value $slide2_html -Encoding UTF8
Set-Content -Path (Join-Path $baseDir "slide3.html") -Value $slide3_html -Encoding UTF8
Set-Content -Path (Join-Path $baseDir "slide4.html") -Value $slide4_html -Encoding UTF8
Set-Content -Path (Join-Path $baseDir "slide5.html") -Value $slide5_html -Encoding UTF8

Write-Output "All 5 HTML slides written successfully."
