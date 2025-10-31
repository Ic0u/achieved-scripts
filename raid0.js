(function () {
  // === CONFIG / ID ===
  const EXIST_ID = 'roc-tradebot-ui';
  const LOGO_URL = 'https://i.ibb.co/5W5FrYhd/ngau.png';
  let licenseSecondsRemaining = 60 * 60 * 24 * 7; // 7 days

  // Remove old instance if present
  const old = document.getElementById(EXIST_ID);
  if (old) old.remove();

  // Create container
  const container = document.createElement('div');
  container.id = EXIST_ID;
  container.style.zIndex = '2147483647';

  // CSS (Trebuchet MS + improved resizer using pointer friendly hit area)
  const css = `
  @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');
  :root{--toast-bg:rgba(20,20,28,0.9);--muted:#bfbfc6}
  #${EXIST_ID}{
    position:fixed;top:50%;left:50%;transform:translate(-50%,-50%);width:560px;border-radius:16px;min-width:360px;min-height:220px;
    font-family:"Trebuchet MS", Trebuchet, "Inter", system-ui, -apple-system, "Segoe UI", Roboto, Arial, sans-serif;
    color:#e9e9ef;background:linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01)), rgba(18,18,24,0.46);
    border:1px solid rgba(255,255,255,0.06);box-shadow:0 12px 40px rgba(3,6,18,0.6), inset 0 1px 0 rgba(255,255,255,0.02);
    backdrop-filter: blur(20px) saturate(160%);cursor:default;overflow:hidden;transition: opacity 260ms ease, transform 260ms ease, width 160ms ease, height 160ms ease;
  }
  #${EXIST_ID}.closing{animation:rocCloseAnim 360ms cubic-bezier(.25,.9,.3,1) forwards;pointer-events:none}
  @keyframes rocCloseAnim{to{opacity:0;transform:translate(-50%,-50%) scale(0.92) rotate(-2deg)}}

  .roc-header{display:flex;align-items:center;justify-content:space-between;padding:10px 14px;border-bottom:1px solid rgba(255,255,255,0.04);backdrop-filter: blur(6px);cursor:grab}
  .roc-header.dragging{cursor:grabbing}
  .roc-left{display:flex;align-items:center;gap:10px}
  .roc-icon{width:40px;height:40px;border-radius:8px;overflow:hidden;background:rgba(255,255,255,0.03);display:inline-flex;align-items:center;justify-content:center;box-shadow:0 6px 18px rgba(0,0,0,0.45);flex:0 0 40px}
  .roc-icon img{width:100%;height:100%;object-fit:cover;display:block}
  .roc-title{font-weight:700;font-size:16px;color:#fff}
  .roc-exp{font-size:12px;color:#ffd;opacity:0.95;margin-left:6px;font-weight:700}
  .roc-top-controls{display:flex;gap:8px;align-items:center}
  .roc-close{background:rgba(255,255,255,0.06);border:none;width:32px;height:32px;border-radius:8px;color:#fff;font-weight:700;display:inline-flex;align-items:center;justify-content:center;cursor:pointer;box-shadow:0 4px 12px rgba(0,0,0,0.35);transition:transform 140ms}
  .roc-close:active{transform:scale(0.97) rotate(6deg)}

  .roc-content{display:flex;gap:14px;padding:14px;align-items:flex-start}
  .roc-left-col{flex:1 1 360px;min-width:300px;display:flex;flex-direction:column;gap:8px}
  .roc-right-col{width:220px;min-width:200px;background:linear-gradient(180deg, rgba(255,255,255,0.015), rgba(255,255,255,0.005));border-radius:12px;padding:10px;border:1px solid rgba(255,255,255,0.03);backdrop-filter: blur(8px)}

  .roc-row{display:flex;justify-content:space-between;align-items:center;margin-bottom:8px}
  .roc-label{font-weight:600;font-size:13px;color:var(--muted)}
  .roc-value{font-weight:700;font-size:13px}
  .roc-balance{margin:6px 0 10px;padding:8px;text-align:center;border-radius:8px;background:linear-gradient(180deg, rgba(255,255,255,0.01), rgba(255,255,255,0.00));border:1px solid rgba(255,255,255,0.03);font-weight:700}

  .roc-buttons{display:grid;grid-template-columns:1fr 0.6fr 1fr;grid-template-rows:auto auto;grid-template-areas:"buy close sell" "buy pause sell";gap:12px;align-items:center}
  .btn{border:none;border-radius:10px;padding:18px 12px;font-weight:800;font-size:18px;cursor:pointer;box-shadow:0 8px 22px rgba(2,6,23,0.55);color:#0b0b0b;text-align:center;user-select:none}
  .btn:active{transform:translateY(1px) scale(.998);box-shadow:0 5px 14px rgba(2,6,23,0.45)}
  .btn-buy{grid-area:buy;background:linear-gradient(180deg,#39d3f1,#00a4d6);border:2px solid rgba(0,0,0,0.06);font-size:20px;padding:24px 12px}
  .btn-sell{grid-area:sell;background:linear-gradient(180deg,#ffb07a,#ff7a3d);border:2px solid rgba(0,0,0,0.06);font-size:20px;padding:24px 12px}
  .btn-close{grid-area:close;background:linear-gradient(180deg,#ffd800,#ffcd32);border:2px solid rgba(0,0,0,0.06);color:#111;font-size:15px;padding:12px 10px;border-radius:10px}
  .btn-pause{grid-area:pause;background:linear-gradient(180deg,#e89bff,#c665ff);border:2px solid rgba(0,0,0,0.06);color:#120733;font-size:15px;padding:12px 10px;border-radius:10px}

  .controls{display:flex;gap:12px;align-items:center;margin-top:8px}
  .log{margin-top:12px;background:rgba(0,0,0,0.12);padding:8px;border-radius:8px;max-height:120px;overflow:auto;font-size:12px;color:#dcdce0;border:1px solid rgba(255,255,255,0.02)}
  .log .entry{padding:6px 8px;border-radius:8px;margin-bottom:6px;display:flex;justify-content:space-between;align-items:center;gap:10px}
  .log .entry .text{flex:1;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
  .log .entry.latest{font-weight:800;background:linear-gradient(90deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));box-shadow:0 8px 20px rgba(0,0,0,0.45)}
  .log .entry.pos .value{color:#00ff88;font-weight:800}
  .log .entry.neg .value{color:#ff6b6b;font-weight:800}
  .log .entry.info .value{color:#bfbfc6;font-weight:800}
  .log .entry.pos .text{color:#e9fff2}
  .log .entry.neg .text{color:#ffecec}
  .log .entry.info .text{color:#e9e9ef}

  .resizer{
    position:absolute;right:6px;bottom:6px;width:30px;height:30px;border-radius:8px;cursor:nwse-resize;display:inline-flex;align-items:center;justify-content:center;
    background:linear-gradient(180deg, rgba(255,255,255,0.03), rgba(255,255,255,0.01));border:1px solid rgba(255,255,255,0.04);box-shadow:0 6px 18px rgba(0,0,0,0.45);z-index:9999999;touch-action:none;
  }
  .resizer::after{content:'';width:12px;height:12px;background-image:linear-gradient(135deg, rgba(255,255,255,0.12) 25%, transparent 25%),linear-gradient(225deg, rgba(255,255,255,0.06) 25%, transparent 25%);background-size:6px 6px;opacity:0.95;transform:rotate(45deg)}
  .resizer.active{box-shadow:0 10px 26px rgba(0,0,0,0.6), 0 0 0 6px rgba(0,0,0,0.06) inset;transform:scale(1.02)}
  .resizer:active{transform:scale(0.98)}

  .toast-rail{position:fixed;right:20px;top:20px;display:flex;flex-direction:column;gap:10px;z-index:99999999;pointer-events:none}
  .toast{pointer-events:auto;min-width:220px;max-width:420px;background:var(--toast-bg);color:#fff;padding:12px 14px;border-radius:12px;box-shadow:0 12px 40px rgba(0,0,0,0.6);border:1px solid rgba(255,255,255,0.04);overflow:hidden;transform-origin:100% 0%;opacity:0;transform:translateX(12px) scale(0.985);animation:toastIn 360ms cubic-bezier(.22,.9,.3,1) forwards;display:flex;gap:10px;align-items:center}
  .toast .bar{height:4px;background:rgba(255,255,255,0.12);border-radius:6px;margin-top:8px;overflow:hidden}
  @keyframes toastIn{to{opacity:1;transform:translateX(0) scale(1);}}
  .disabled-overlay{position:absolute;inset:0;background:rgba(0,0,0,0.45);display:flex;align-items:center;justify-content:center;color:#ffd;border-radius:16px;font-weight:800;font-size:15px}
  .roc-footer{padding:10px;text-align:center;font-size:12px;color:#b8b8bf;border-top:1px solid rgba(255,255,255,0.03);background:linear-gradient(180deg, rgba(255,255,255,0.00), rgba(255,255,255,0.005));display:flex;justify-content:center;align-items:center;gap:10px;}

  /* minimize accidental selection while dragging */
  .no-select { user-select: none !important; -webkit-user-select: none !important; -ms-user-select: none !important; }

  @media (max-width:600px){ #${EXIST_ID}{width:96%} .roc-content{flex-direction:column} .roc-right-col{width:100%;order:2}}
  `;
  const styleNode = document.createElement('style');
  styleNode.textContent = css;
  document.head.appendChild(styleNode);

  // Build HTML
  container.innerHTML = `
    <div class="roc-header" role="toolbar">
      <div class="roc-left">
        <div class="roc-icon"><img src="${LOGO_URL}" alt="Roculus Icon"></div>
        <div style="display:flex;flex-direction:column;line-height:1">
          <div style="display:flex;align-items:center;gap:8px">
            <div class="roc-title">Raid0</div>
            <div id="expirationDisplay" class="roc-exp"></div>
          </div>
          <div style="font-size:11px;color:var(--muted)">user · marcusnguyen</div>
        </div>
      </div>
      <div class="roc-top-controls">
        <button class="roc-close" id="topClose" title="Close (animated)">×</button>
        <button id="collapseBtn" title="Collapse panel" style="background:rgba(255,255,255,0.04);border:none;color:#fff;padding:6px 8px;border-radius:8px;cursor:pointer">⇲</button>
      </div>
    </div>

    <div class="roc-content">
      <div class="roc-left-col">
        <div style="display:flex;justify-content:space-between;align-items:flex-start">
          <div>
            <div style="font-weight:700;font-size:13px;">Actions</div>
            <div style="font-size:12px;color:var(--muted);margin-top:4px">Manual simulate BUY / SELL or run auto-trade</div>
          </div>
          <div style="text-align:right">
            <div style="font-size:12px;color:var(--muted)">Positions</div>
            <div id="positions" style="font-weight:800">0 (0.00 Lot)</div>
          </div>
        </div>

        <div class="roc-buttons" aria-hidden="false">
          <button class="btn btn-buy" id="buyBtn">BUY</button>
          <button class="btn btn-close" id="closeBtn">CLOSE ALL</button>
          <button class="btn btn-sell" id="sellBtn">SELL</button>
          <button class="btn btn-pause" id="pauseBtn">PAUSE</button>
        </div>

        <div style="display:flex;gap:12px;align-items:center;margin-top:10px">
          <div style="flex:1">
            <div style="font-size:12px;color:var(--muted)">Trailing Stop</div>
            <div style="display:flex;gap:8px;align-items:center;margin-top:6px">
              <input id="tsValue" type="number" min="0" step="10" value="600" style="width:84px;padding:8px;border-radius:8px;border:1px solid rgba(255,255,255,0.04);background:rgba(255,255,255,0.02);color:#fff;font-weight:700">
              <button id="tsToggle" style="padding:8px 10px;border-radius:8px;border:none;cursor:pointer;background:linear-gradient(180deg,#00d4aa,#00b890);font-weight:700">TS: ON</button>
            </div>
          </div>
          <div style="width:220px">
            <div style="font-size:12px;color:var(--muted)">P/L Projection</div>
            <div id="plProjection" style="font-weight:800;margin-top:6px">+0.00 USD</div>
          </div>
        </div>

        <div style="display:flex;gap:12px;align-items:center;margin-top:8px">
          <div style="flex:1">
            <label style="font-weight:700;font-size:12px;color:var(--muted)">Start Lot</label>
            <input id="startLot" type="number" min="0.01" step="0.01" value="0.10" style="margin-top:6px;padding:8px;border-radius:8px;border:1px solid rgba(255,255,255,0.04);background:rgba(255,255,255,0.02);color:#fff;font-weight:700;width:120px">
          </div>
          <div style="width:220px">
            <label style="font-weight:700;font-size:12px;color:var(--muted)">Recent P/L</label>
            <div id="profitLossDisplay" style="font-weight:800;margin-top:6px;color:#00ff88">+0.00 USD</div>
          </div>
        </div>

        <div style="display:flex;gap:12px;align-items:center;margin-top:10px">
          <div style="flex:1">
            <label style="font-weight:700;font-size:12px;color:var(--muted)">Auto-trade</label>
            <div style="display:flex;gap:8px;margin-top:6px;align-items:center">
              <button id="autoToggle" style="padding:8px 12px;border-radius:8px;border:none;background:rgba(255,255,255,0.04);color:#fff;cursor:pointer">AUTO: ON</button>
              <button id="resetBtn" style="padding:8px 12px;border-radius:8px;border:none;background:rgba(255,255,255,0.04);color:#fff;cursor:pointer">RESET</button>
            </div>
          </div>
          <div style="width:220px">
            <label style="font-weight:700;font-size:12px;color:var(--muted)">Speed</label>
            <div class="speed-row" style="margin-top:6px">
              <input id="speedRange" type="range" min="0.5" max="3" step="0.1" value="1">
              <div id="speedLabel" style="width:38px;text-align:right;font-weight:800">1.0x</div>
            </div>
          </div>
        </div>

        <div class="log" id="logArea" aria-live="polite"></div>
      </div>

      <div class="roc-right-col" id="statusPanel" aria-live="polite">
        <div style="display:flex;justify-content:space-between;align-items:center">
          <div class="status-title">Dark Venus — Account Status</div>
          <button id="exportBtn" title="Export stats" style="background:transparent;border:none;color:var(--muted);cursor:pointer">⤓</button>
        </div>

        <div class="roc-balance" id="acc-balance">Balance / Equity<br><strong>76181.81 USD | 76181.81 USD</strong></div>

        <div class="roc-row"><div class="roc-label">Account P/L</div><div id="acc-pl" class="roc-value">0.00</div></div>
        <div class="roc-row"><div class="roc-label">Account Equity</div><div id="acc-equity" class="roc-value">76181.81</div></div>
        <div class="roc-row"><div class="roc-label">Magic P/L</div><div id="magic-pl" class="roc-value">0.00</div></div>
        <div class="roc-row"><div class="roc-label">Chart P/L</div><div id="chart-pl" class="roc-value">0.00</div></div>
        <div class="roc-row"><div class="roc-label">Margin Level</div><div id="marginLevel" class="roc-value">0.00%</div></div>

        <div style="height:8px"></div>
        <div class="status-list" id="symbol-list"></div>

        <div style="height:8px"></div>
        <div class="roc-row"><div class="roc-label">Drawdown</div><div id="drawdown" class="roc-value">0%</div></div>
        <div class="roc-row"><div class="roc-label">Spread</div><div id="spread" class="roc-value">1.0</div></div>
        <div class="roc-row"><div class="roc-label">Start Lot</div><div id="start-lot" class="roc-value">0.10</div></div>

        <div class="mini">Live simulated data — demo only</div>
      </div>
    </div>

    <div class="roc-footer" id="datetime">
      Fri, 31 Oct 25 00:00:00
      <button id="panicUninstall" style="margin-left:12px;padding:6px 8px;border-radius:8px;border:none;background:#ff6b6b;color:#fff;font-weight:700;cursor:pointer;font-size:11px">PANIC UNINSTALL</button>
    </div>

    <div class="resizer" id="resizer" title="Drag to resize"></div>
  `;
  document.body.appendChild(container);

  // Toast rail (ensure single)
  let toastRail = document.querySelector('.toast-rail');
  if (!toastRail) {
    toastRail = document.createElement('div');
    toastRail.className = 'toast-rail';
    document.body.appendChild(toastRail);
  }

  // State + refs
  const symbols = ['EURUSD','GBPUSD','USDJPY','XAUUSD','USDCAD','AUDUSD','NZDUSD'];
  let balance = 76181.81, equity = 76181.81, accPL = 0, chartPL = 0, magicPL = 0, drawdown = 0, spread = 1.0;
  let startLot = 0.10, positions = 0, lots = 0;
  const symState = {}; symbols.forEach(s => symState[s] = { pl:0, trades:0 });
  const recentDeltas = []; const RECENT_LEN = 12;

  // timers & observer handles
  let autoTimer = null; let uiInterval = null; let licenseInterval = null; let mutationObserver = null;
  const refs = {
    positions: container.querySelector('#positions'),
    accBalance: container.querySelector('#acc-balance'),
    accPl: container.querySelector('#acc-pl'),
    accEquity: container.querySelector('#acc-equity'),
    magicPl: container.querySelector('#magic-pl'),
    chartPl: container.querySelector('#chart-pl'),
    marginLevel: container.querySelector('#marginLevel'),
    drawdown: container.querySelector('#drawdown'),
    spread: container.querySelector('#spread'),
    startLotEl: container.querySelector('#start-lot'),
    symbolList: container.querySelector('#symbol-list'),
    logArea: container.querySelector('#logArea'),
    profitLossDisplay: container.querySelector('#profitLossDisplay'),
    plProjection: container.querySelector('#plProjection'),
    expirationDisplay: container.querySelector('#expirationDisplay'),
    buyBtn: container.querySelector('#buyBtn'),
    sellBtn: container.querySelector('#sellBtn'),
    closeBtn: container.querySelector('#closeBtn'),
    pauseBtn: container.querySelector('#pauseBtn'),
    topClose: container.querySelector('#topClose'),
    tsToggle: container.querySelector('#tsToggle'),
    autoToggle: container.querySelector('#autoToggle'),
    resetBtn: container.querySelector('#resetBtn'),
    exportBtn: container.querySelector('#exportBtn'),
    startLotInput: container.querySelector('#startLot'),
    tsValueInput: container.querySelector('#tsValue'),
    speedRange: container.querySelector('#speedRange'),
    speedLabel: container.querySelector('#speedLabel'),
    statusPanel: container.querySelector('#statusPanel'),
    resizer: container.querySelector('#resizer'),
    collapseBtn: container.querySelector('#collapseBtn'),
    datetime: container.querySelector('#datetime'),
    panicUninstall: container.querySelector('#panicUninstall'),
  };

  // helper: notifications
  function notify(title, msg = '', opts = {}) {
    const duration = typeof opts.duration === 'number' ? opts.duration : 4200;
    const type = opts.type || 'info';
    const toast = document.createElement('div');
    toast.className = 'toast';
    const icon = document.createElement('div'); icon.className = 'icon'; icon.textContent = ({info:'ℹ️', success:'✅', warn:'⚠️', error:'⛔'})[type]||'ℹ️';
    const body = document.createElement('div'); body.className = 'body';
    const t = document.createElement('div'); t.className = 'title'; t.textContent = title;
    const m = document.createElement('div'); m.className = 'msg'; m.textContent = msg;
    const barWrap = document.createElement('div'); barWrap.className = 'bar';
    const bar = document.createElement('i'); barWrap.appendChild(bar);
    body.appendChild(t); if (msg) body.appendChild(m); body.appendChild(barWrap);
    toast.appendChild(icon); toast.appendChild(body);
    toastRail.appendChild(toast);
    bar.style.animationDuration = duration + 'ms';
    const timeout = setTimeout(()=>{ toast.classList.add('out'); setTimeout(()=>toast.remove(),360); }, duration);
    toast.addEventListener('click', ()=>{ clearTimeout(timeout); toast.classList.add('out'); setTimeout(()=>toast.remove(),260); });
    return toast;
  }
  window.rocNotify = notify;

  // log helper (enhanced: latest entry bold + colored like trading list)
  const logs = [];
  function classifyLogText(txt) {
    // Look for a signed number in the text: +1.23 or -23.4
    const signMatch = txt.match(/([+-])\s*([0-9]+(?:\.[0-9]+)?)/);
    if (signMatch) {
      return signMatch[1] === '+' ? 'pos' : 'neg';
    }
    // keywords
    if (/error|expired|fail|panic/i.test(txt)) return 'neg';
    if (/warn|ts hit|paused|pause/i.test(txt)) return 'info';
    if (/success|executed|started|exported|enabled|enabled/i.test(txt)) return 'pos';
    return 'info';
  }

  function logPush(txt) {
    const time = new Date().toLocaleTimeString();
    logs.unshift(`${time} — ${txt}`);
    if (logs.length > 120) logs.pop();

    // Render entries: newest first
    refs.logArea.innerHTML = '';
    logs.forEach((entry, idx) => {
      const div = document.createElement('div');
      div.className = 'entry' + (idx === 0 ? ' latest' : '');
      const type = classifyLogText(entry);
      div.classList.add(type); // pos | neg | info

      const text = document.createElement('div');
      text.className = 'text';
      text.textContent = entry;

      // value part: detect trailing signed number and style separately
      const valSpan = document.createElement('div');
      valSpan.className = 'value';
      // try to extract last signed/magnitude number
      const m = entry.match(/([+-]\s*[0-9]+(?:\.[0-9]+)?)/g);
      if (m && m.length) {
        valSpan.textContent = m[m.length - 1].replace(/\s+/g, '');
      } else {
        valSpan.textContent = '';
      }

      div.appendChild(text);
      if (valSpan.textContent) div.appendChild(valSpan);

      refs.logArea.appendChild(div);
    });

    refs.logArea.scrollTop = 0;
  }

  function pushDelta(v) {
    recentDeltas.push(v);
    if (recentDeltas.length > RECENT_LEN) recentDeltas.shift();
  }
  function computeProjection() {
    if (recentDeltas.length < 2) return chartPL;
    const avg = recentDeltas.reduce((a,b)=>a+b,0)/recentDeltas.length;
    const speedVal = parseFloat(refs.speedRange.value) || 1.0;
    return chartPL + avg * 60 * speedVal * 0.3;
  }

  function renderSymbolList() {
    refs.symbolList.innerHTML = '';
    symbols.forEach(sym => {
      const s = symState[sym];
      const item = document.createElement('div'); item.className = 'status-item';
      item.style.display = 'flex'; item.style.justifyContent = 'space-between'; item.style.padding = '6px 8px'; item.style.borderRadius = '8px';
      const left = document.createElement('div'); left.className = 'sym'; left.textContent = sym;
      const right = document.createElement('div'); right.className = s.pl >= 0 ? 'plpos' : 'plneg';
      right.textContent = (s.pl >= 0 ? '+' : '') + s.pl.toFixed(2);
      right.style.fontWeight = '800';
      right.style.color = s.pl >= 0 ? '#00ff88' : '#ff6b6b';
      item.appendChild(left); item.appendChild(right);
      refs.symbolList.appendChild(item);
    });
  }

  function updateDisplay() {
    refs.positions.textContent = `${positions} (${lots.toFixed(2)} Lot)`;
    refs.accBalance.innerHTML = `Balance / Equity<br><strong>${balance.toFixed(2)} USD | ${equity.toFixed(2)} USD</strong>`;
    refs.accPl.textContent = (accPL >= 0 ? '+' : '') + accPL.toFixed(2);
    refs.accEquity.textContent = equity.toFixed(2);
    refs.magicPl.textContent = (magicPL >= 0 ? '+' : '') + magicPL.toFixed(2);
    refs.chartPl.textContent = (chartPL >= 0 ? '+' : '') + chartPL.toFixed(2);
    const marginLevel = positions > 0 ? (equity / (positions * 1000)) * 100 : 0;
    refs.marginLevel.textContent = marginLevel > 0 ? `${marginLevel.toFixed(2)}%` : '0.00%';
    refs.drawdown.textContent = drawdown.toFixed(1) + '%';
    refs.spread.textContent = spread.toFixed(1);
    refs.startLotEl.textContent = startLot.toFixed(2);
    refs.profitLossDisplay.textContent = (accPL >= 0 ? '+' : '') + accPL.toFixed(2) + ' USD';
    refs.profitLossDisplay.style.color = accPL >= 0 ? '#00ff88' : '#ff6b6b';
    refs.plProjection.textContent = (computeProjection() >= 0 ? '+' : '') + computeProjection().toFixed(2) + ' USD';
    renderSymbolList();
  }

  // Trading simulation (same)
  let trailingStopOn = true, autoTrading = true, paused = false;
  function simulateTrade(type) {
    if (licenseSecondsRemaining <= 0) { notify('License','Cannot trade — license expired',{type:'error'}); logPush('License expired — attempt to trade blocked'); return; }
    const userStart = parseFloat(refs.startLotInput.value) || 0.1;
    const newLots = parseFloat((Math.random() * 0.5 + userStart).toFixed(2));
    positions++; lots += newLots; startLot = userStart;
    const sym = symbols[Math.floor(Math.random() * symbols.length)];
    const baseBias = type === 'BUY' ? 0.42 : 0.48;
    const delta = (Math.random() - baseBias) * (100 + Math.random() * 220);
    symState[sym].pl += delta; symState[sym].trades += 1;
    const change = delta * (0.6 + Math.random() * 0.6);
    accPL += change; magicPL += delta * (Math.random() * 0.5); chartPL += change * (0.3 + Math.random() * 0.9);
    equity = Math.max(0, balance + accPL);
    drawdown = Math.max(drawdown, Math.min(99.9, ((Math.max(0, balance - equity) / balance) * 100)));
    spread = Math.max(0.3, Math.min(10, spread + (Math.random() - 0.5) * 0.2));
    pushDelta(change); updateDisplay();
    const sign = delta >= 0 ? '+' : '';
    logPush(`${type} ${newLots} lot on ${sym} → ${sign}${delta.toFixed(2)} (sim)`);
    notify(`${type} executed`, `${newLots} lot @ ${sym}`, { type:'success', duration: 2400 });
    if (trailingStopOn && Math.random() < 0.06) {
      const tsEffect = (Math.random() - 0.6) * 120;
      accPL += tsEffect; equity = Math.max(0, balance + accPL);
      logPush(`TS hit on ${sym}: ${(tsEffect>=0?'+':'')+tsEffect.toFixed(2)}`);
      notify('Trailing Stop', `TS hit on ${sym}: ${(tsEffect>=0?'+':'')+tsEffect.toFixed(2)}`, { type:'warn', duration: 3200 });
      updateDisplay();
    }
  }

  function closeAllPositions() {
    if (positions === 0) { logPush('No positions to close'); notify('Close All','No positions to close',{type:'info'}); return; }
    balance = equity; positions = 0; lots = 0; accPL = 0; chartPL = 0; magicPL = 0; drawdown = 0;
    symbols.forEach(s => symState[s].pl *= 0.25); updateDisplay();
    logPush('CLOSE ALL executed — balance updated');
    notify('CLOSE ALL','All positions closed',{type:'success'});
  }

  function resetStats() {
    accPL=0; chartPL=0; magicPL=0; drawdown=0; spread=1.0;
    symbols.forEach(s => { symState[s].pl = 0; symState[s].trades = 0; });
    updateDisplay(); logPush('Stats reset'); notify('Reset','Statistics reset',{type:'info'});
  }

  // License handling
  function formatTimeLeft(seconds) {
    if (seconds <= 0) return 'EXPIRED';
    let d = Math.floor(seconds/86400); seconds%=86400;
    let h = Math.floor(seconds/3600); seconds%=3600;
    let m = Math.floor(seconds/60); let s = Math.floor(seconds%60);
    if (d>0) return `${d}D ${h}H ${m}M ${s}S`;
    if (h>0) return `${h}H ${m}M ${s}S`;
    if (m>0) return `${m}M ${s}S`;
    return `${s}S`;
  }
  function isExpired() { return licenseSecondsRemaining <= 0; }
  function tickLicense() {
    if (licenseSecondsRemaining > 0) licenseSecondsRemaining--;
    if (refs.expirationDisplay) {
      refs.expirationDisplay.textContent = isExpired() ? 'LICENSE EXPIRED' : formatTimeLeft(licenseSecondsRemaining);
      refs.expirationDisplay.style.color = isExpired() ? '#ff6b6b' : '#ffd';
    }
    if (isExpired()) {
      disableTradingUI(); notify('License','License expired — trading disabled',{type:'error',duration:4000}); showExpiredOverlay();
    }
  }
  function disableTradingUI() {
    [refs.buyBtn, refs.sellBtn, refs.closeBtn, refs.pauseBtn].forEach(b => { if (b) { b.disabled = true; b.style.opacity = '0.5'; } });
    autoTrading = false; if (refs.autoToggle) refs.autoToggle.textContent = 'AUTO: OFF';
  }
  function enableTradingUI() {
    [refs.buyBtn, refs.sellBtn, refs.closeBtn, refs.pauseBtn].forEach(b => { if (b) { b.disabled = false; b.style.opacity = '1'; } });
    autoTrading = true; if (refs.autoToggle) refs.autoToggle.textContent = 'AUTO: ON';
  }
  let expiredOverlay = null;
  function showExpiredOverlay() { if (expiredOverlay) return; expiredOverlay = document.createElement('div'); expiredOverlay.className = 'disabled-overlay'; expiredOverlay.textContent = 'LICENSE EXPIRED'; container.appendChild(expiredOverlay); }
  function hideExpiredOverlay() { if (!expiredOverlay) return; expiredOverlay.remove(); expiredOverlay = null; }

  // Auto sim scheduling
  function scheduleAutoStep() {
    if (autoTimer) clearTimeout(autoTimer);
    const speedVal = parseFloat(refs.speedRange.value) || 1.0;
    const baseDelay = 4500;
    const delay = Math.max(200, baseDelay / Math.max(0.2, speedVal)) + Math.random() * (1000 / Math.max(0.2, speedVal));
    autoTimer = setTimeout(() => {
      if (!paused && autoTrading && !isExpired()) {
        if (Math.random() > 0.3 && positions < 12) simulateTrade(Math.random()>0.5?'BUY':'SELL');
      }
      symbols.forEach(s => { const v = symState[s]; v.pl += (Math.random()-0.5)*(4+speedVal*3); v.pl = Math.max(-2000, Math.min(2000, v.pl)); });
      const agg = symbols.reduce((sum,s) => sum + symState[s].pl * 0.22, accPL * 0.97);
      const delta = agg - accPL;
      accPL = agg; pushDelta(delta);
      magicPL = magicPL * 0.98 + (Math.random()-0.5)*20;
      chartPL = accPL * (0.6 + Math.random()*0.9);
      equity = Math.max(0, balance + accPL);
      drawdown = Math.max(0, Math.min(99.9, (Math.max(0, balance - equity) / balance) * 100));
      spread += (Math.random()-0.5)*0.12; spread = Math.max(0.3, Math.min(10, spread));
      startLot = Math.max(0.01, startLot + (Math.random()-0.5)*0.002);
      updateDisplay();
      scheduleAutoStep();
    }, delay);
  }

  // Dragging the header (existing robust implementation)
  let dragging = false, startX = 0, startY = 0, offsetX = 0, offsetY = 0;
  const header = container.querySelector('.roc-header');
  const topClose = container.querySelector('#topClose');
  const collapseBtn = container.querySelector('#collapseBtn');
  function getClient(e) { if (e.touches && e.touches[0]) return {x:e.touches[0].clientX,y:e.touches[0].clientY}; return {x:e.clientX,y:e.clientY}; }
  function headerDown(e) { if (e.target === topClose || e.target === collapseBtn) return; const c = getClient(e); dragging = true; header.classList.add('dragging'); startX = c.x - offsetX; startY = c.y - offsetY; document.body.classList.add('no-select'); e.preventDefault(); }
  function headerMove(e) { if (!dragging) return; const c = getClient(e); offsetX = c.x - startX; offsetY = c.y - startY; const rect = container.getBoundingClientRect(); const halfW = rect.width/2; const halfH = rect.height/2; const vw = window.innerWidth; const vh = window.innerHeight; const centerX = Math.max(halfW+12, Math.min(vw-halfW-12, (vw/2) + offsetX)); const centerY = Math.max(halfH+12, Math.min(vh-halfH-12, (vh/2) + offsetY)); const newOffsetX = centerX - vw/2; const newOffsetY = centerY - vh/2; offsetX = newOffsetX; offsetY = newOffsetY; container.style.transform = `translate(calc(-50% + ${offsetX}px), calc(-50% + ${offsetY}px))`; }
  function headerUp() { dragging = false; header.classList.remove('dragging'); document.body.classList.remove('no-select'); }
  header.addEventListener('mousedown', headerDown);
  document.addEventListener('mousemove', headerMove);
  document.addEventListener('mouseup', headerUp);
  header.addEventListener('touchstart', headerDown, { passive:false });
  document.addEventListener('touchmove', headerMove, { passive:false });
  document.addEventListener('touchend', headerUp);

  // RESIZER: pointer events, snapping, double-click reset, requestAnimationFrame
  const resizer = refs.resizer;
  const DEFAULT_SIZE = { w: 560, h: 380 };
  let isResizing = false;
  let startRect = null;
  let pointerId = null;
  let rafId = null;
  let targetW = DEFAULT_SIZE.w, targetH = DEFAULT_SIZE.h;
  const MIN_W = 360, MIN_H = 220;
  const GRID = 8; // snap to 8px grid

  function snap(v){ return Math.round(v / GRID) * GRID; }

  function onPointerDown(e){
    // only left button or touch
    if (e.pointerType === 'mouse' && e.button !== 0) return;
    isResizing = true;
    resizer.classList.add('active');
    startRect = container.getBoundingClientRect();
    pointerId = e.pointerId;
    container.setPointerCapture && container.setPointerCapture(pointerId);
    document.body.classList.add('no-select');

    const startX = e.clientX, startY = e.clientY;
    const baseW = startRect.width, baseH = startRect.height;
    // compute new size from pointer movement using RAF for smoothness
    function step(){
      // no-op: we schedule per pointermove to keep animation frame usage consistent
      rafId = requestAnimationFrame(step);
    }
    rafId = requestAnimationFrame(step);

    // attach move/up on document to ensure capture
    function pointerMove(ev){
      if (!isResizing || ev.pointerId !== pointerId) return;
      const dx = ev.clientX - startX;
      const dy = ev.clientY - startY;
      let newW = baseW + dx;
      let newH = baseH + dy;
      // clamp
      newW = Math.max(MIN_W, Math.min(window.innerWidth - 24, newW));
      newH = Math.max(MIN_H, Math.min(window.innerHeight - 24, newH));
      // snap
      newW = snap(newW);
      newH = snap(newH);
      // update target
      targetW = newW; targetH = newH;
      // apply immediately
      container.style.width = targetW + 'px';
      container.style.height = targetH + 'px';
      // ensure it stays centered relative to offsets
      container.style.transform = `translate(calc(-50% + ${offsetX}px), calc(-50% + ${offsetY}px))`;
    }
    function pointerUp(ev){
      if (ev.pointerId !== pointerId) return;
      isResizing = false;
      resizer.classList.remove('active');
      document.body.classList.remove('no-select');
      try { container.releasePointerCapture && container.releasePointerCapture(pointerId); } catch(e){}
      pointerId = null;
      if (rafId) { cancelAnimationFrame(rafId); rafId = null; }
      document.removeEventListener('pointermove', pointerMove);
      document.removeEventListener('pointerup', pointerUp);
    }
    document.addEventListener('pointermove', pointerMove);
    document.addEventListener('pointerup', pointerUp);
    e.preventDefault();
  }

  function onResizerDblClick(){
    // reset to default
    container.style.width = DEFAULT_SIZE.w + 'px';
    container.style.height = DEFAULT_SIZE.h + 'px';
    targetW = DEFAULT_SIZE.w; targetH = DEFAULT_SIZE.h;
    // re-center
    offsetX = 0; offsetY = 0;
    container.style.transform = `translate(-50%,-50%)`;
  }

  // attach pointer listener (works for mouse & touch)
  resizer.addEventListener('pointerdown', onPointerDown);
  resizer.addEventListener('dblclick', onResizerDblClick);

  // Buttons wiring
  refs.buyBtn && refs.buyBtn.addEventListener('click', ()=> simulateTrade('BUY'));
  refs.sellBtn && refs.sellBtn.addEventListener('click', ()=> simulateTrade('SELL'));
  refs.closeBtn && refs.closeBtn.addEventListener('click', ()=> closeAllPositions());
  refs.pauseBtn && refs.pauseBtn.addEventListener('click', ()=> {
    paused = !paused;
    refs.pauseBtn.textContent = paused ? 'RESUME' : 'PAUSE';
    logPush(paused ? 'Manual pause' : 'Manual resume');
    notify('Manual Pause', paused ? 'Paused' : 'Resumed', { type: paused ? 'warn' : 'info' });
  });
  refs.tsToggle && refs.tsToggle.addEventListener('click', ()=> { trailingStopOn = !trailingStopOn; refs.tsToggle.textContent = trailingStopOn ? 'TS: ON' : 'TS: OFF'; refs.tsToggle.style.opacity = trailingStopOn ? '1' : '0.6'; logPush(`Trailing Stop ${trailingStopOn ? 'enabled' : 'disabled'}`); notify('Trailing Stop', trailingStopOn ? 'Enabled' : 'Disabled', { type:'info' }); });
  refs.autoToggle && refs.autoToggle.addEventListener('click', ()=> { autoTrading = !autoTrading; refs.autoToggle.textContent = autoTrading ? 'AUTO: ON' : 'AUTO: OFF'; logPush(autoTrading ? 'Auto-trade enabled' : 'Auto-trade disabled'); notify('Auto-trade', autoTrading ? 'Enabled' : 'Disabled', { type:'info' }); });
  refs.speedRange && refs.speedRange.addEventListener('input', (e)=> { refs.speedLabel.textContent = (parseFloat(e.target.value)||1).toFixed(1) + 'x'; });
  refs.resetBtn && refs.resetBtn.addEventListener('click', ()=> resetStats());
  refs.exportBtn && refs.exportBtn.addEventListener('click', ()=> { const state = { balance,equity,accPL,chartPL,magicPL,drawdown,spread,startLot,positions,lots,symbols:symState }; const d=JSON.stringify(state,null,2); const blob=new Blob([d],{type:'application/json'}); const url=URL.createObjectURL(blob); const a=document.createElement('a'); a.href=url; a.download='roc-tradebot-state.json'; a.click(); URL.revokeObjectURL(url); logPush('Exported state JSON'); notify('Export','State JSON exported',{type:'success'}); });

  // Collapse btn
  let collapsed=false;
  refs.collapseBtn && refs.collapseBtn.addEventListener('click', ()=> {
    collapsed = !collapsed;
    if (collapsed) { refs.statusPanel && refs.statusPanel.classList.add('collapsed'); refs.collapseBtn.textContent = '⇱'; notify('Panel','Status panel collapsed',{type:'info'}); }
    else { refs.statusPanel && refs.statusPanel.classList.remove('collapsed'); refs.collapseBtn.textContent = '⇲'; notify('Panel','Status panel expanded',{type:'info'}); }
  });

  // PANIC UNINSTALL
  refs.panicUninstall && refs.panicUninstall.addEventListener('click', ()=> { cleanupAndRemove(true); });

  // Centralized cleanup routine
  function cleanupAndRemove(force) {
    try {
      if (!document.body.contains(container)) return;
      if (autoTimer) { clearTimeout(autoTimer); autoTimer = null; }
      if (uiInterval) { clearInterval(uiInterval); uiInterval = null; }
      if (licenseInterval) { clearInterval(licenseInterval); licenseInterval = null; }
      if (mutationObserver) { try{ mutationObserver.disconnect(); }catch(e){}; mutationObserver = null; }
      const rails = document.querySelectorAll('.toast-rail, .toast');
      rails.forEach(n => n.remove());
      if (container && container.parentNode) container.parentNode.removeChild(container);
      if (styleNode && styleNode.parentNode) styleNode.parentNode.removeChild(styleNode);
      try { delete window.rocNotify; } catch(e){}
      try { delete window.rocSimTrade; } catch(e){}
      try { delete window.rocCloseAll; } catch(e){}
      try { delete window.rocReset; } catch(e){}
      try { delete window.rocSetLicense; } catch(e){}
      console.log('[Roculus] UI removed & cleaned up' + (force ? ' (panic)' : ''));
    } catch (err) {
      console.error('[Roculus] cleanup error', err);
    }
  }

  // Top close: animate then cleanup
  function topCloseHandler() {
    if (!document.body.contains(container) || container.classList.contains('closing')) return;
    container.classList.add('closing');
    notify('Roculus', 'Closing...', { type:'info', duration: 900 });
    setTimeout(()=> { cleanupAndRemove(false); }, 360);
  }
  refs.topClose && refs.topClose.addEventListener('click', topCloseHandler);

  // Escape to close
  function escHandler(e){ if (e.key === 'Escape') topCloseHandler(); }
  document.addEventListener('keydown', escHandler);

  // Observe DOM removal and auto-clean if removed externally
  mutationObserver = new MutationObserver(()=> {
    if (!document.body.contains(container)) cleanupAndRemove();
  });
  mutationObserver.observe(document.body, { childList:true, subtree:true });

  // Clock + license tick
  function updateDateTime() {
    const now = new Date();
    const days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    const dayName = days[now.getDay()];
    const day = now.getDate();
    const month = months[now.getMonth()];
    const year = String(now.getFullYear()).slice(-2);
    const hh = String(now.getHours()).padStart(2,'0');
    const mm = String(now.getMinutes()).padStart(2,'0');
    const ss = String(now.getSeconds()).padStart(2,'0');
    if (refs.datetime) refs.datetime.textContent = `${dayName}, ${day} ${month} ${year} ${hh}:${mm}:${ss}`;
  }
  uiInterval = setInterval(updateDateTime, 1000);
  updateDateTime();
  licenseInterval = setInterval(tickLicense, 1000);

  // Start auto-sim and UI refresh
  scheduleAutoStep();
  const uiRefresh = setInterval(()=> updateDisplay(), 1000);

  // Expose helpers
  window.rocNotify = notify;
  window.rocSimTrade = simulateTrade;
  window.rocCloseAll = closeAllPositions;
  window.rocReset = resetStats;
  window.rocSetLicense = (seconds) => { licenseSecondsRemaining = seconds; if (seconds>0) { hideExpiredOverlay(); enableTradingUI(); } };

  // Final init render
  renderSymbolList();
  updateDisplay();
  logPush('Roculus TradeBot started (Trebuchet MS font, improved resizer)');
  notify('Roculus', 'TradeBot started', { type:'success', duration: 1200 });

})();
