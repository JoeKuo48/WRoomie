/**
 * 微倫米 WRoomie - 品牌官方互動與即時在線文字修改系統
 * 核心功能：
 * 1. 中/英雙語無縫切換 (Bilingual Support: ZH-TW / EN)
 * 2. 全站文字即時在線編輯 (Live In-Place Edit Mode)
 * 3. 變更自動儲存至 LocalStorage (Auto-save)
 * 4. 匯出/下載最新修改後的 HTML 網頁檔 (Download Static HTML)
 * 5. 互動預約彈窗與預約體驗連動 (Booking Modal)
 */

// 官方預設文案資料庫 (支援中英雙語)
const defaultTexts = {
  zh: {
    // 導覽列
    "nav-meet": "認識主廚",
    "nav-experiences": "食旅體驗",
    "nav-story": "室友理念",
    "nav-book": "立即預約",
    "nav-lang-btn": "English",

    // Hero 區塊
    "hero-badge": "KAOHSIUNG · LOCAL TASTE & ROOMIE FEAST",
    "hero-title": "用料理，結交一個<span class='accent'>高雄在地室友</span>",
    "hero-subtitle": "微倫米 WRoomie 帶領外國旅人走入市場與共食，將台灣飲食文化轉譯為深度體驗。",
    "hero-cta-explore": "探索體驗行程",
    "hero-cta-chef": "認識主廚 Joe",
    "hero-feat-market": "傳統市井尋味導覽",
    "hero-feat-diner": "美式貨櫃私廚空間",
    "hero-feat-feast": "南台灣在地風土共食",
    "hero-photo-title": "Golden Corn Diner 貨櫃廚房",
    "hero-photo-desc": "溫暖手作 × 美式工業風 × 一日室友歡聚",
    "hero-badge-title": "一日室友深度食旅",
    "hero-badge-sub": "市場尋味 × 貨櫃廚房 × 風土共食",

    // Meet the Chef 區塊
    "chef-section-badge": "MEET THE CHEF & DAY ROOMIE",
    "chef-section-title": "認識你的主廚與一日室友 —— <span class='highlight'>Chef Joe</span>",
    "chef-seal": "CHEF JOE",
    "chef-title-role": "微倫米 WRoomie 負責人",
    "chef-title-sub": "Golden Corn Diner & roomie_club48 主理人",
    "chef-exp-title": "經歷背景",
    "chef-exp-p": "微倫米負責人、Golden Corn Diner 與 roomie_club48 主理人。曾任職於 Fridays、多間獨立小餐廳，以及遊戲公司普橘島特約私廚。",
    "chef-origin-title": "初心與使命",
    "chef-origin-p": "從台北回到高雄，曾參與 homeveler 家廚活動。當看到外國旅人理解台灣南部特色物產與食物時，那份快樂與榮幸，是創辦微倫米的初衷。",
    "chef-spirit-title": "品牌精神",
    "chef-spirit-p": "「微」是透過生活細節觀察，創造深度連結；「倫米」則是延續 Roomie 的意義——大家來當我的一日室友，共樂、共遊、共食。",
    "chef-quote": "「下廚可以很簡單，探索世界不一定要從登機開始。透過料理，我們也可以遊歷世界。」",
    "chef-quote-author": "— Chef Joe，微倫米主理人",

    // Experiences 區塊
    "exp-badge": "OUR EXPERIENCES",
    "exp-title": "選擇你的 <span class='highlight'>WRoomie 室友食旅</span>",
    "exp-subtitle": "由淺入深的三種探索方式，依你的旅行節奏挑選專屬的私廚手作與在地漫遊",

    // 卡片 1 (輕度)
    "card1-tier": "輕度版 · 經典手作",
    "card1-duration": "約 2.5 - 3 小時",
    "card1-people": "4 - 8 人小班體驗",
    "card1-title": "【微倫米】一日室友的私廚餐桌",
    "card1-en": "Roomie’s Table",
    "card1-target-label": "適合對象：",
    "card1-target-text": "行程較趕、想輕鬆體驗手作料理與溫馨交流的旅人。",
    "card1-desc": "直接來到溫馨的 Golden Corn Diner 美式貨櫃屋空間，跟著主廚 Joe 動手做經典或具台灣特色的創意料理，最後圍坐在一起像老朋友般共食交流。",
    "card1-btn": "查看詳情與預約",

    // 卡片 2 (中度)
    "card2-tag": "人氣推薦 POPULAR",
    "card2-tier": "中度版 · 市井探索",
    "card2-duration": "約 4 - 4.5 小時",
    "card2-people": "2 - 6 人深度小團",
    "card2-title": "【微倫米】跟著室友去買菜",
    "card2-en": "Market & Kitchen with Roomie",
    "card2-target-label": "適合對象：",
    "card2-target-text": "熱愛深度文化探索、想貼近在地常民生活的旅人。",
    "card2-desc": "由主廚 Joe 帶領穿梭高雄傳統市場，解密南台灣獨特物產與人情味；回到貨櫃屋將剛買的新鮮食材親手烹調成美味家常菜，享受溫馨共食時光。",
    "card2-tl-title": "行程亮點時刻表",
    "card2-tl-1-time": "09:30 - 09:45",
    "card2-tl-1-text": "捷運站相見歡與破冰",
    "card2-tl-2-time": "09:45 - 11:00",
    "card2-tl-2-text": "【市井尋味】傳統市場探險與食材導覽",
    "card2-tl-3-time": "11:00 - 12:30",
    "card2-tl-3-text": "【手作廚房】貨櫃屋料理實作教學",
    "card2-tl-4-time": "12:30 - 14:00",
    "card2-tl-4-text": "【室友餐桌】圍桌共食與文化交流時光",
    "card2-btn": "查看詳情與預約",

    // 卡片 3 (升級)
    "card3-tier": "升級版 · 風土盛宴",
    "card3-duration": "約 6 - 7 小時 (半日遊)",
    "card3-people": "專屬包場 / 預約制",
    "card3-title": "【微倫米】南台灣風土尋味行",
    "card3-en": "Southern Taiwan Terroir & Feast",
    "card3-target-label": "適合對象：",
    "card3-target-text": "追求永續旅遊（Sustainable Tourism）、喜愛慢食與生態探訪的高端旅人。",
    "card3-desc": "走訪高雄在地農場或魚塭，由生產者親自導覽認識南台灣農漁業；順道走訪市場採買，最後回到貨櫃屋，將風土精華烹調成一桌充滿南部靈魂的料理。",
    "card3-btn": "查看詳情與預約",

    // CTA / Booking 區塊
    "cta-badge": "RESERVE YOUR SEAT",
    "cta-title": "準備好成為彼此的<span>一日室友</span>了嗎？",
    "cta-subtitle": "名額有限，跟著主廚 Joe 一起展開一場有溫度的南台灣料理食旅吧！",
    "cta-btn-book": "立即預約體驗",
    "cta-btn-contact": "聯絡我們 / 洽詢客製",

    // 頁尾
    "footer-brand-title": "微倫米 WRoomie",
    "footer-brand-desc": "以料理作為文化交流媒介，在高雄展開你的一日室友食旅。連結產地、市井常民與老朋友般的溫暖餐桌。",
    "footer-loc-title": "在地座標",
    "footer-loc-text": "台灣高雄市 · Golden Corn Diner 美式貨櫃廚房",
    "footer-social-title": "追蹤室友生活",
    "footer-copy": "© 2026 微倫米 WRoomie. All rights reserved. 用料理在餐桌上漫遊世界。"
  },

  en: {
    // Nav
    "nav-meet": "Meet Chef Joe",
    "nav-experiences": "Experiences",
    "nav-story": "Our Story",
    "nav-book": "Book Now",
    "nav-lang-btn": "中文",

    // Hero
    "hero-badge": "KAOHSIUNG · LOCAL TASTE & ROOMIE FEAST",
    "hero-title": "Connect with a Local Kaohsiung Roommate <span class='accent'>Through Cooking</span>",
    "hero-subtitle": "WRoomie leads global travelers into local wet markets and shared tables, translating Southern Taiwan’s rich culinary culture into an immersive, heartwarming journey.",
    "hero-cta-explore": "Explore Experiences",
    "hero-cta-chef": "Meet Chef Joe",
    "hero-feat-market": "Traditional Wet Market Safari",
    "hero-feat-diner": "American Container Kitchen",
    "hero-feat-feast": "Southern Taiwan Terroir Dining",
    "hero-photo-title": "Golden Corn Diner Kitchen",
    "hero-photo-desc": "Handcrafted Warmth × Industrial Aesthetic × Day-Roommate Feast",
    "hero-badge-title": "Day-Roommate Food Journey",
    "hero-badge-sub": "Market Safari × Container Kitchen × Local Feast",

    // Meet the Chef
    "chef-section-badge": "MEET THE CHEF & DAY ROOMIE",
    "chef-section-title": "Meet Your Chef & Day-Roommate — <span class='highlight'>Chef Joe</span>",
    "chef-seal": "CHEF JOE",
    "chef-title-role": "Founder of WRoomie",
    "chef-title-sub": "Owner of Golden Corn Diner & roomie_club48",
    "chef-exp-title": "Culinary Journey",
    "chef-exp-p": "Founder of WRoomie, owner of Golden Corn Diner and roomie_club48. Formerly at TGI Fridays, various boutique bistros, and resident private chef at Gamania's Island.",
    "chef-origin-title": "Mission & Spark",
    "chef-origin-p": "Returning from Taipei to Kaohsiung after engaging in homeveler home-chef gatherings. Witnessing foreign travelers genuinely connect with Southern Taiwan's unique terroir ignited the passion to build WRoomie.",
    "chef-spirit-title": "Brand Philosophy",
    "chef-spirit-p": "\"Wei (微)\" embodies mindful observation of life's delicate details; \"Roomie (倫米)\" invites travelers to be day-roommates — cooking, exploring, and sharing life together.",
    "chef-quote": "\"Cooking is simple, and exploring the world doesn't always begin at the departure gate. Through cuisine, we journey across the globe.\"",
    "chef-quote-author": "— Chef Joe, WRoomie Host",

    // Experiences
    "exp-badge": "OUR EXPERIENCES",
    "exp-title": "Choose Your <span class='highlight'>WRoomie Culinary Journey</span>",
    "exp-subtitle": "Three distinct rhythms designed for your travel pace — from hands-on container cooking to lively markets and farm-to-table discovery.",

    // Card 1
    "card1-tier": "Light Version · Hands-on Classic",
    "card1-duration": "Approx. 2.5 - 3 Hours",
    "card1-people": "4 - 8 Guests",
    "card1-title": "【WRoomie】Roomie’s Table",
    "card1-en": "Private Kitchen Hands-on Cooking",
    "card1-target-label": "Ideal for:",
    "card1-target-text": "Travelers with tight schedules who want an effortless hands-on cooking experience and warm social connection.",
    "card1-desc": "Step into our cozy Golden Corn Diner container diner, craft classic and Taiwanese-fusion dishes alongside Chef Joe, and gather around the table like old friends.",
    "card1-btn": "Details & Reservation",

    // Card 2
    "card2-tag": "POPULAR CHOICE",
    "card2-tier": "Medium Version · Market Safari",
    "card2-duration": "Approx. 4 - 4.5 Hours",
    "card2-people": "2 - 6 Guests Small Group",
    "card2-title": "【WRoomie】Market & Kitchen with Roomie",
    "card2-en": "Wet Market Walk & Cooking Class",
    "card2-target-label": "Ideal for:",
    "card2-target-text": "Culture enthusiasts who wish to immerse themselves in authentic local daily life and Southern flavours.",
    "card2-desc": "Join Chef Joe through bustling traditional wet markets, uncover secret Southern produce and genuine Taiwanese warmth; then cook your fresh market haul into comforting dishes at our container diner.",
    "card2-tl-title": "Timeline Highlights",
    "card2-tl-1-time": "09:30 - 09:45",
    "card2-tl-1-text": "MRT Station Welcome & Ice-breaking",
    "card2-tl-2-time": "09:45 - 11:00",
    "card2-tl-2-text": "【Market Safari】Traditional wet market tour & ingredient tasting",
    "card2-tl-3-time": "11:00 - 12:30",
    "card2-tl-3-text": "【Hands-on Kitchen】Cooking session in container diner",
    "card2-tl-4-time": "12:30 - 14:00",
    "card2-tl-4-text": "【Roomie's Feast】Shared dining & cross-cultural story exchange",
    "card2-btn": "Details & Reservation",

    // Card 3
    "card3-tier": "Premium Version · Terroir Feast",
    "card3-duration": "Approx. 6 - 7 Hours (Half-Day)",
    "card3-people": "Private Custom Booking",
    "card3-title": "【WRoomie】Southern Taiwan Terroir & Feast",
    "card3-en": "Farm/Fishery Visit & Soul Cuisine",
    "card3-target-label": "Ideal for:",
    "card3-target-text": "Discerning travelers seeking sustainable tourism, slow food exploration, and ecological discoveries.",
    "card3-desc": "Tour local Kaohsiung farms or aquaculture fisheries with producer-led storytelling; source fresh gems at the market, and craft a lavish Southern Taiwan soul feast in the diner.",
    "card3-btn": "Details & Reservation",

    // CTA
    "cta-badge": "RESERVE YOUR SEAT",
    "cta-title": "Ready to be <span>Day-Roommates</span>?",
    "cta-subtitle": "Limited seats per session. Join Chef Joe for a heartfelt culinary immersion in Kaohsiung!",
    "cta-btn-book": "Book an Experience",
    "cta-btn-contact": "Contact Us / Custom Tour",

    // Footer
    "footer-brand-title": "WRoomie Kaohsiung",
    "footer-brand-desc": "Using food as a medium for intercultural dialogue. Embark on a day-roommate culinary journey in Kaohsiung.",
    "footer-loc-title": "Location",
    "footer-loc-text": "Kaohsiung City, Taiwan · Golden Corn Diner Kitchen",
    "footer-social-title": "Follow Roomie",
    "footer-copy": "© 2026 WRoomie. All rights reserved. Wander the world around the dinner table."
  }
};

// 全域狀態管理
let currentLang = 'zh';
let isEditMode = false;
const STORAGE_PREFIX = 'wroomie_custom_text_';

/**
 * 取得指定 key 的儲存文案或預設文案
 */
function getText(key, lang = currentLang) {
  const customTexts = getSavedTexts(lang);
  if (customTexts && customTexts[key] !== undefined) {
    return customTexts[key];
  }
  return defaultTexts[lang][key] || '';
}

/**
 * 從 LocalStorage 讀取客製化修改文案
 */
function getSavedTexts(lang = currentLang) {
  try {
    const raw = localStorage.getItem(STORAGE_PREFIX + lang);
    return raw ? JSON.parse(raw) : {};
  } catch (e) {
    console.error('Failed to read from localStorage:', e);
    return {};
  }
}

/**
 * 儲存客製化文案至 LocalStorage
 */
function saveText(key, value, lang = currentLang) {
  try {
    const custom = getSavedTexts(lang);
    custom[key] = value;
    localStorage.setItem(STORAGE_PREFIX + lang, JSON.stringify(custom));
    showSavedNotification();
  } catch (e) {
    console.error('Failed to save to localStorage:', e);
  }
}

/**
 * 渲染全站文字至 DOM
 */
function renderAllTexts() {
  document.querySelectorAll('[data-edit]').forEach(el => {
    const key = el.getAttribute('data-edit');
    const content = getText(key, currentLang);
    if (content !== undefined) {
      el.innerHTML = content;
    }
  });

  // 更新語系按鈕文字
  const langToggleBtn = document.getElementById('langToggleBtn');
  if (langToggleBtn) {
    langToggleBtn.textContent = currentLang === 'zh' ? 'EN / 英文' : '中 / 繁體中文';
  }

  // 設置 html lang 屬性
  document.documentElement.lang = currentLang === 'zh' ? 'zh-TW' : 'en';
}

/**
 * 切換編輯模式 (Edit Mode Toggle)
 */
function setEditMode(active) {
  isEditMode = active;
  const toggleBtn = document.getElementById('editorToggleBtn');
  const banner = document.getElementById('editModeBanner');

  if (isEditMode) {
    document.body.classList.add('edit-mode-active');
    toggleBtn.classList.add('active');
    toggleBtn.innerHTML = '<span>✏️ 編輯模式 (開啟中)</span>';
    if (banner) banner.style.display = 'block';

    // 啟用所有 [data-edit] 的 contenteditable
    document.querySelectorAll('[data-edit]').forEach(el => {
      el.setAttribute('contenteditable', 'true');
      el.setAttribute('spellcheck', 'false');
      el.setAttribute('title', '點選此處可直接修改文字');
    });
  } else {
    document.body.classList.remove('edit-mode-active');
    toggleBtn.classList.remove('active');
    toggleBtn.innerHTML = '<span>✏️ 開啟文字編輯模式</span>';
    if (banner) banner.style.display = 'none';

    // 關閉所有 contenteditable
    document.querySelectorAll('[data-edit]').forEach(el => {
      el.removeAttribute('contenteditable');
      el.removeAttribute('title');
    });
  }
}

/**
 * 顯示儲存成功提示
 */
let saveTimer = null;
function showSavedNotification() {
  const statusEl = document.getElementById('editorStatus');
  if (!statusEl) return;
  statusEl.classList.remove('show');
  void statusEl.offsetWidth; // trigger reflow
  statusEl.classList.add('show');
  clearTimeout(saveTimer);
  saveTimer = setTimeout(() => {
    statusEl.classList.remove('show');
  }, 2200);
}

/**
 * 重設為官方預設文案
 */
function resetToDefaults() {
  if (confirm('確定要清除目前的修改，恢復成官方預設文案嗎？')) {
    localStorage.removeItem(STORAGE_PREFIX + currentLang);
    renderAllTexts();
    alert('已恢復為官方預設文案！');
  }
}

/**
 * 複製當前文案為 JSON
 */
function exportTextsJSON() {
  const saved = getSavedTexts(currentLang);
  const combined = { ...defaultTexts[currentLang], ...saved };
  const jsonStr = JSON.stringify(combined, null, 2);
  
  if (navigator.clipboard) {
    navigator.clipboard.writeText(jsonStr).then(() => {
      alert('已複製完整文案 JSON 到剪貼簿！');
    }).catch(() => {
      prompt('請複製下方的 JSON 內容：', jsonStr);
    });
  } else {
    prompt('請複製下方的 JSON 內容：', jsonStr);
  }
}

/**
 * 下載包含最新文字修改的完整 HTML 檔案
 */
function downloadUpdatedHTML() {
  // 複製目前的 HTML Document
  const clone = document.documentElement.cloneNode(true);
  
  // 移除編輯器臨時狀態
  clone.classList.remove('edit-mode-active');
  const body = clone.querySelector('body');
  if (body) {
    body.classList.remove('edit-mode-active');
  }
  
  // 清理 contenteditable 屬性
  clone.querySelectorAll('[contenteditable]').forEach(el => {
    el.removeAttribute('contenteditable');
    el.removeAttribute('title');
  });

  const banner = clone.querySelector('#editModeBanner');
  if (banner) banner.style.display = 'none';

  const htmlContent = '<!DOCTYPE html>\n' + clone.outerHTML;
  const blob = new Blob([htmlContent], { type: 'text/html;charset=utf-8' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `WRoomie_Website_${currentLang}_${new Date().toISOString().slice(0, 10)}.html`;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
}

/**
 * 監聽所有可編輯元素的即時打字輸入事件
 */
let debounceTimer = null;
function setupEditableListeners() {
  document.body.addEventListener('input', (e) => {
    const target = e.target.closest('[data-edit]');
    if (!target) return;
    
    const key = target.getAttribute('data-edit');
    const newHtml = target.innerHTML;

    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => {
      saveText(key, newHtml, currentLang);
    }, 400);
  });

  // 在編輯模式下，點選帶有連結或按鈕的元素時，阻止頁面跳轉，方便直接游標選取與輸入修改
  document.body.addEventListener('click', (e) => {
    if (isEditMode) {
      const editTarget = e.target.closest('[data-edit]');
      if (editTarget && !e.target.closest('#liveEditorBar')) {
        if (editTarget.tagName === 'A' || editTarget.tagName === 'BUTTON' || editTarget.closest('a, button')) {
          e.preventDefault();
        }
      }
    }
  }, false);
}

/**
 * 預約彈窗互動邏輯 (Booking Modal)
 */
function setupBookingModal() {
  const modal = document.getElementById('bookingModal');
  const closeBtn = document.getElementById('closeModalBtn');
  const packageSelect = document.getElementById('bookingPackage');
  const form = document.getElementById('bookingForm');
  const formContent = document.getElementById('bookingFormContent');
  const successBox = document.getElementById('bookingSuccessBox');

  // 打開彈窗函式
  window.openBookingModal = function(packageVal = '') {
    if (isEditMode) return; // 編輯模式下不彈出視窗，方便使用者點選修改按鈕文案
    if (modal) {
      modal.classList.add('active');
      document.body.style.overflow = 'hidden';
      if (packageSelect) {
        if (packageVal && packageVal !== 'general') {
          packageSelect.value = packageVal;
        } else {
          packageSelect.value = 'package2';
        }
      }
      if (formContent) formContent.style.display = 'block';
      if (successBox) successBox.style.display = 'none';
    }
  };

  // 關閉彈窗函式
  window.closeBookingModal = function() {
    if (modal) {
      modal.classList.remove('active');
      document.body.style.overflow = '';
    }
  };

  if (closeBtn) {
    closeBtn.addEventListener('click', closeBookingModal);
  }

  if (modal) {
    modal.addEventListener('click', (e) => {
      if (e.target === modal) {
        closeBookingModal();
      }
    });
  }

  // 監聽所有預約按鈕點擊
  document.querySelectorAll('[data-book-action]').forEach(btn => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      const pkg = btn.getAttribute('data-book-action') || '';
      openBookingModal(pkg);
    });
  });

  // 預約表單送出處理
  if (form) {
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      const name = document.getElementById('bookName')?.value || '旅人夥伴';
      const pkgName = packageSelect?.options[packageSelect.selectedIndex]?.text || '';
      
      const successNameEl = document.getElementById('successGuestName');
      const successPkgEl = document.getElementById('successPkgName');
      if (successNameEl) successNameEl.textContent = name;
      if (successPkgEl) successPkgEl.textContent = pkgName;

      if (formContent) formContent.style.display = 'none';
      if (successBox) successBox.style.display = 'block';
    });
  }
}

/**
 * 導覽列滾動陰影與手機版選單
 */
function setupNavInteractions() {
  const nav = document.getElementById('siteNav');
  const mobileToggle = document.getElementById('mobileMenuToggle');
  const navLinks = document.getElementById('navLinks');

  window.addEventListener('scroll', () => {
    if (window.scrollY > 40) {
      nav?.classList.add('scrolled');
    } else {
      nav?.classList.remove('scrolled');
    }
  });

  if (mobileToggle && navLinks) {
    mobileToggle.addEventListener('click', () => {
      navLinks.classList.toggle('mobile-open');
    });

    navLinks.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        navLinks.classList.remove('mobile-open');
      });
    });
  }

  // 語言切換按鈕事件
  const langBtn = document.getElementById('langToggleBtn');
  if (langBtn) {
    langBtn.addEventListener('click', () => {
      currentLang = currentLang === 'zh' ? 'en' : 'zh';
      renderAllTexts();
    });
  }
}

/**
 * 初始化入口
 */
document.addEventListener('DOMContentLoaded', () => {
  renderAllTexts();
  setupEditableListeners();
  setupBookingModal();
  setupNavInteractions();

  // 綁定編輯器工具列事件
  const editorToggleBtn = document.getElementById('editorToggleBtn');
  if (editorToggleBtn) {
    editorToggleBtn.addEventListener('click', () => {
      setEditMode(!isEditMode);
    });
  }

  const resetBtn = document.getElementById('resetDefaultsBtn');
  if (resetBtn) {
    resetBtn.addEventListener('click', resetToDefaults);
  }

  const exportBtn = document.getElementById('exportJsonBtn');
  if (exportBtn) {
    exportBtn.addEventListener('click', exportTextsJSON);
  }

  const downloadBtn = document.getElementById('downloadHtmlBtn');
  if (downloadBtn) {
    downloadBtn.addEventListener('click', downloadUpdatedHTML);
  }
});
