(function() {
    // Remove existing menu if it exists
    const existingMenu = document.getElementById('namGayzMenu');
    if (existingMenu) {
        existingMenu.remove();
    }

    // Create CSS styles
    const css = `
        .imgui-menu {
            position: fixed;
            top: 50px;
            right: 50px;
            width: 320px;
            min-width: 280px;
            min-height: 200px;
            background: #202020;
            border: 1px solid #404040;
            border-radius: 6px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 13px;
            z-index: 999999;
            user-select: none;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.5);
            resize: both;
            overflow: hidden;
            transition: opacity 0.15s ease, transform 0.15s ease;
        }

        .imgui-menu.dragging {
            transition: none;
            cursor: grabbing;
        }

        .imgui-menu.resizing {
            transition: none;
        }

        .menu-titlebar {
            background: linear-gradient(180deg, #505050 0%, #404040 100%);
            padding: 8px 12px;
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            cursor: grab;
            border-bottom: 1px solid #303030;
            position: relative;
        }

        .menu-titlebar:active {
            cursor: grabbing;
        }

        .menu-titlebar::after {
            content: '';
            position: absolute;
            right: 40px;
            top: 50%;
            transform: translateY(-50%);
            width: 20px;
            height: 2px;
            background: #888;
            box-shadow: 0 -4px 0 #888, 0 4px 0 #888;
        }

        .menu-title {
            color: #ffffff;
            font-weight: 600;
            font-size: 14px;
        }

        .close-btn {
            background: none;
            border: none;
            color: #ffffff;
            font-size: 16px;
            cursor: pointer;
            padding: 0;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 2px;
            transition: all 0.15s ease;
            z-index: 10;
        }

        .close-btn:hover {
            background: #ff4444;
            transform: scale(1.1);
        }

        .minimize-btn {
            background: none;
            border: none;
            color: #ffffff;
            font-size: 14px;
            cursor: pointer;
            padding: 0;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 2px;
            transition: all 0.15s ease;
            margin-right: 4px;
        }

        .minimize-btn:hover {
            background: #4a90e2;
            transform: scale(1.1);
        }

        .window-controls {
            display: flex;
            align-items: center;
            gap: 2px;
        }

        .menu-content {
            padding: 8px;
            background: #202020;
            border-bottom-left-radius: 5px;
            border-bottom-right-radius: 5px;
            height: calc(100% - 40px);
            overflow-y: auto;
            overflow-x: hidden;
        }

        .menu-content::-webkit-scrollbar {
            width: 8px;
        }

        .menu-content::-webkit-scrollbar-track {
            background: #303030;
            border-radius: 4px;
        }

        .menu-content::-webkit-scrollbar-thumb {
            background: #606060;
            border-radius: 4px;
        }

        .menu-content::-webkit-scrollbar-thumb:hover {
            background: #808080;
        }

        .resize-handle {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 16px;
            height: 16px;
            cursor: nw-resize;
            background: linear-gradient(135deg, transparent 0%, transparent 30%, #606060 30%, #606060 35%, transparent 35%, transparent 65%, #606060 65%, #606060 70%, transparent 70%);
        }

        .resize-handle:hover {
            background: linear-gradient(135deg, transparent 0%, transparent 30%, #808080 30%, #808080 35%, transparent 35%, transparent 65%, #808080 65%, #808080 70%, transparent 70%);
        }

        .section-header {
            color: #ffffff;
            font-weight: 600;
            margin: 8px 0 4px 0;
            padding-bottom: 2px;
            border-bottom: 1px solid #404040;
            font-size: 13px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 4px 0;
            margin: 2px 0;
        }

        .menu-label {
            color: #cccccc;
            font-size: 13px;
        }

        .imgui-checkbox {
            appearance: none;
            width: 16px;
            height: 16px;
            border: 1px solid #606060;
            border-radius: 2px;
            background: #303030;
            cursor: pointer;
            position: relative;
            transition: all 0.15s;
        }

        .imgui-checkbox:checked {
            background: #4a90e2;
            border-color: #4a90e2;
        }

        .imgui-checkbox:checked::after {
            content: '✓';
            position: absolute;
            top: -2px;
            left: 2px;
            color: white;
            font-size: 12px;
            font-weight: bold;
        }

        .imgui-checkbox:hover {
            border-color: #808080;
        }

        .imgui-input {
            background: #303030;
            border: 1px solid #606060;
            border-radius: 3px;
            padding: 4px 6px;
            color: #ffffff;
            font-size: 13px;
            width: 80px;
            font-family: 'Consolas', 'Monaco', monospace;
        }

        .imgui-input:focus {
            outline: none;
            border-color: #4a90e2;
            background: #353535;
        }

        .imgui-input:hover {
            border-color: #808080;
        }

        .imgui-input-wide {
            width: 120px;
        }

        .imgui-button {
            background: linear-gradient(180deg, #505050 0%, #404040 100%);
            border: 1px solid #606060;
            border-radius: 3px;
            color: #ffffff;
            padding: 4px 12px;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.15s;
        }

        .imgui-button:hover {
            background: linear-gradient(180deg, #606060 0%, #505050 100%);
            border-color: #808080;
        }

        .imgui-button:active {
            background: linear-gradient(180deg, #404040 0%, #353535 100%);
        }

        .separator {
            height: 1px;
            background: #404040;
            margin: 8px 0;
        }

        .tooltip {
            position: relative;
        }

        .tooltip:hover::after {
            content: attr(data-tooltip);
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            background: #404040;
            color: white;
            padding: 4px 8px;
            border-radius: 3px;
            font-size: 11px;
            white-space: nowrap;
            border: 1px solid #606060;
            z-index: 1000;
        }

        .currency-row {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 4px 0;
        }

        .currency-label {
            color: #cccccc;
            font-size: 13px;
            width: 70px;
        }

        .set-btn {
            background: linear-gradient(180deg, #4a90e2 0%, #357abd 100%);
            border: 1px solid #4a90e2;
            border-radius: 3px;
            color: #ffffff;
            padding: 2px 8px;
            cursor: pointer;
            font-size: 11px;
            transition: all 0.15s;
        }

        .set-btn:hover {
            background: linear-gradient(180deg, #5ba0f2 0%, #4a90e2 100%);
        }
    `;

    // Inject CSS
    const styleSheet = document.createElement('style');
    styleSheet.textContent = css;
    document.head.appendChild(styleSheet);

    // Create HTML structure
    const menuHTML = `
        <div class="imgui-menu" id="namGayzMenu">
            <div class="menu-titlebar" id="namGayzTitlebar">
                <div class="menu-title">nem.js ImGUI Demo </div>
                <div class="window-controls">
                    <button class="minimize-btn" onclick="window.namGayz.minimizeMenu()">−</button>
                    <button class="close-btn" onclick="window.namGayz.closeMenu()">×</button>
                </div>
            </div>

            <div class="menu-content" id="namGayzContent">
                <div class="section-header">Game Cheats</div>
                
                <div class="menu-item">
                    <label class="menu-label tooltip" data-tooltip="Kill zombies in one hit">One Hit</label>
                    <input type="checkbox" class="imgui-checkbox" onchange="window.namGayz.toggleCheat('oneHit', this.checked)">
                </div>
                
                <div class="menu-item">
                    <label class="menu-label tooltip" data-tooltip="Unlimited sun points">Unlimited Sun</label>
                    <input type="checkbox" class="imgui-checkbox" onchange="window.namGayz.toggleCheat('unlimitedSun', this.checked)">
                </div>

                <div class="menu-item">
                    <label class="menu-label tooltip" data-tooltip="Infinite plant food">Unlimited Plant Food</label>
                    <input type="checkbox" class="imgui-checkbox" onchange="window.namGayz.toggleCheat('unlimitedPlantFood', this.checked)">
                </div>

                <div class="menu-item">
                    <label class="menu-label tooltip" data-tooltip="Instant energy refills">Instant Refills</label>
                    <input type="checkbox" class="imgui-checkbox" onchange="window.namGayz.toggleCheat('instantRefills', this.checked)">
                </div>

                <div class="menu-item">
                    <label class="menu-label tooltip" data-tooltip="No cooldown on abilities">No Cooldown</label>
                    <input type="checkbox" class="imgui-checkbox" onchange="window.namGayz.toggleCheat('noCooldown', this.checked)">
                </div>

                <div class="menu-item">
                    <label class="menu-label tooltip" data-tooltip="All plants cost 0 sun">0 Sun Price</label>
                    <input type="checkbox" class="imgui-checkbox" onchange="window.namGayz.toggleCheat('zeroSunPrice', this.checked)">
                </div>

                <div class="menu-item">
                    <label class="menu-label tooltip" data-tooltip="Unlock all custom plants">Unlock All Customs</label>
                    <input type="checkbox" class="imgui-checkbox" onchange="window.namGayz.toggleCheat('unlockAllCustoms', this.checked)">
                </div>

                <div class="menu-item">
                    <label class="menu-label tooltip" data-tooltip="Plants cannot be crushed by zombies">Uncrushable Plants</label>
                    <input type="checkbox" class="imgui-checkbox" onchange="window.namGayz.toggleCheat('uncrushablePlants', this.checked)">
                </div>

                <div class="separator"></div>

                <div class="section-header">Currency Editor</div>
                
                <div class="currency-row">
                    <label class="currency-label">Diamonds:</label>
                    <input type="text" class="imgui-input" placeholder="9999" id="diamondValue">
                    <button class="set-btn" onclick="window.namGayz.setCurrency('diamonds')">Set</button>
                </div>

                <div class="currency-row">
                    <label class="currency-label">Tokens:</label>
                    <input type="text" class="imgui-input" placeholder="9999" id="tokenValue">
                    <button class="set-btn" onclick="window.namGayz.setCurrency('tokens')">Set</button>
                </div>

                <div class="currency-row">
                    <label class="currency-label">Keys:</label>
                    <input type="text" class="imgui-input" placeholder="9999" id="keyValue">
                    <button class="set-btn" onclick="window.namGayz.setCurrency('keys')">Set</button>
                </div>

                <div class="separator"></div>

                <div class="section-header">Dimension Unlocker</div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 4px; margin: 8px 0;">
                    <button class="imgui-button" onclick="window.namGayz.unlockDimension('adventure')">Adventure</button>
                    <button class="imgui-button" onclick="window.namGayz.unlockDimension('arena')">Arena</button>
                    <button class="imgui-button" onclick="window.namGayz.unlockDimension('penny')">Penny's Pursuit</button>
                    <button class="imgui-button" onclick="window.namGayz.unlockDimension('battlez')">Battlez</button>
                    <button class="imgui-button" onclick="window.namGayz.unlockDimension('expansion')">Expansion</button>
                    <button class="imgui-button" onclick="window.namGayz.unlockDimension('all')" style="grid-column: 1 / -1; background: linear-gradient(180deg, #4a90e2 0%, #357abd 100%); border-color: #4a90e2;">Unlock All Dimensions</button>
                </div>

                <div class="separator"></div>

                <div class="section-header">Plant Unlocker</div>

                <div class="menu-item">
                    <label class="menu-label">Plant ID:</label>
                    <input type="text" class="imgui-input imgui-input-wide" placeholder="Enter plant ID" id="plantId">
                </div>

                <div class="menu-item" style="justify-content: center; margin-top: 8px;">
                    <button class="imgui-button" onclick="window.namGayz.unlockPlant()">Unlock Plant</button>
                </div>

                <div class="separator"></div>

                <div class="section-header">Zombie Unlocker</div>

                <div class="menu-item">
                    <label class="menu-label">Zombie ID:</label>
                    <input type="text" class="imgui-input imgui-input-wide" placeholder="Enter zombie ID" id="zombieId">
                </div>

                <div class="menu-item" style="justify-content: center; margin-top: 8px;">
                    <button class="imgui-button" onclick="window.namGayz.unlockZombie()">Unlock Zombie</button>
                </div>

                <div class="separator"></div>

                <div style="text-align: center; margin-top: 8px;">
                    <button class="imgui-button" onclick="window.namGayz.saveConfig()" style="margin-right: 4px;">Save Config</button>
                    <button class="imgui-button" onclick="window.namGayz.loadConfig()">Load Config</button>
                </div>

                <div class="separator"></div>

                <div style="text-align: center; margin-top: 4px;">
                    <div style="color: #888888; font-size: 11px; margin-bottom: 2px;">Credit by Marcus Nguyen</div>
                    <div style="color: #888888; font-size: 11px;">快乐 (Happy)</div>
                </div>
            </div>
            <div class="resize-handle" id="namGayzResize"></div>
        </div>
    `;

    // Inject HTML
    document.body.insertAdjacentHTML('beforeend', menuHTML);

    // Global namespace for functions
    window.namGayz = {
        // Dragging variables
        isDragging: false,
        isResizing: false,
        isMinimized: false,
        currentX: 0,
        currentY: 0,
        initialX: 0,
        initialY: 0,
        xOffset: 0,
        yOffset: 0,
        // Resizing variables
        initialWidth: 0,
        initialHeight: 0,
        initialMouseX: 0,
        initialMouseY: 0,
        cheats: {},

        init() {
            const menu = document.getElementById('namGayzMenu');
            const titlebar = document.getElementById('namGayzTitlebar');
            const resizeHandle = document.getElementById('namGayzResize');

            // Dragging functionality
            titlebar.addEventListener('mousedown', (e) => {
                if (e.target.classList.contains('close-btn') || e.target.classList.contains('minimize-btn')) return;
                this.dragStart(e);
            });
            document.addEventListener('mousemove', (e) => this.handleMouseMove(e));
            document.addEventListener('mouseup', () => this.handleMouseUp());

            // Resizing functionality
            resizeHandle.addEventListener('mousedown', (e) => this.resizeStart(e));

            // Prevent text selection while dragging
            titlebar.addEventListener('selectstart', (e) => e.preventDefault());

            // Keyboard shortcuts
            document.addEventListener('keydown', (e) => {
                if (e.key === 'F1') {
                    e.preventDefault();
                    this.toggleMenu();
                }
                if (e.key === 'F2') {
                    e.preventDefault();
                    this.saveConfig();
                }
                if (e.key === 'F3') {
                    e.preventDefault();
                    this.loadConfig();
                }
                if (e.key === 'Escape' && menu.style.display !== 'none') {
                    e.preventDefault();
                    this.closeMenu();
                }
            });

            // Set initial size
            menu.style.height = '600px';
        },

        dragStart(e) {
            this.initialX = e.clientX - this.xOffset;
            this.initialY = e.clientY - this.yOffset;
            this.isDragging = true;
            document.getElementById('namGayzMenu').classList.add('dragging');
        },

        resizeStart(e) {
            e.preventDefault();
            e.stopPropagation();
            const menu = document.getElementById('namGayzMenu');
            const rect = menu.getBoundingClientRect();
            
            this.initialWidth = rect.width;
            this.initialHeight = rect.height;
            this.initialMouseX = e.clientX;
            this.initialMouseY = e.clientY;
            this.isResizing = true;
            
            menu.classList.add('resizing');
        },

        handleMouseMove(e) {
            if (this.isDragging) {
                this.drag(e);
            } else if (this.isResizing) {
                this.resize(e);
            }
        },

        handleMouseUp() {
            if (this.isDragging) {
                this.dragEnd();
            } else if (this.isResizing) {
                this.resizeEnd();
            }
        },

        drag(e) {
            if (this.isDragging) {
                e.preventDefault();
                this.currentX = e.clientX - this.initialX;
                this.currentY = e.clientY - this.initialY;
                this.xOffset = this.currentX;
                this.yOffset = this.currentY;
                const menu = document.getElementById('namGayzMenu');
                menu.style.transform = `translate3d(${this.currentX}px, ${this.currentY}px, 0)`;
            }
        },

        resize(e) {
            if (this.isResizing) {
                e.preventDefault();
                const menu = document.getElementById('namGayzMenu');
                const deltaX = e.clientX - this.initialMouseX;
                const deltaY = e.clientY - this.initialMouseY;
                
                const newWidth = Math.max(280, this.initialWidth + deltaX);
                const newHeight = Math.max(200, this.initialHeight + deltaY);
                
                menu.style.width = newWidth + 'px';
                menu.style.height = newHeight + 'px';
            }
        },

        dragEnd() {
            this.initialX = this.currentX;
            this.initialY = this.currentY;
            this.isDragging = false;
            document.getElementById('namGayzMenu').classList.remove('dragging');
        },

        resizeEnd() {
            this.isResizing = false;
            document.getElementById('namGayzMenu').classList.remove('resizing');
        },

        toggleCheat(cheatName, enabled) {
            this.cheats[cheatName] = enabled;
            console.log(`[Nam Gayz] ${cheatName}: ${enabled ? 'ON' : 'OFF'}`);
            
            // Add your actual cheat implementation here
            switch(cheatName) {
                case 'oneHit':
                    console.log(`[Nam Gayz] One Hit Kill ${enabled ? 'activated' : 'deactivated'}`);
                    // Implement one hit kill logic here
                    break;
                case 'unlimitedSun':
                    console.log(`[Nam Gayz] Unlimited Sun ${enabled ? 'activated' : 'deactivated'}`);
                    // Implement unlimited sun logic here
                    break;
                case 'unlimitedPlantFood':
                    console.log(`[Nam Gayz] Unlimited Plant Food ${enabled ? 'activated' : 'deactivated'}`);
                    // Implement unlimited plant food logic here
                    break;
                case 'instantRefills':
                    console.log(`[Nam Gayz] Instant Refills ${enabled ? 'activated' : 'deactivated'}`);
                    // Implement instant refills logic here
                    break;
                case 'noCooldown':
                    console.log(`[Nam Gayz] No Cooldown ${enabled ? 'activated' : 'deactivated'}`);
                    // Implement no cooldown logic here
                    break;
                case 'zeroSunPrice':
                    console.log(`[Nam Gayz] 0 Sun Price ${enabled ? 'activated' : 'deactivated'}`);
                    // Implement zero sun price logic here
                    break;
                case 'unlockAllCustoms':
                    console.log(`[Nam Gayz] Unlock All Customs ${enabled ? 'activated' : 'deactivated'}`);
                    // Implement unlock all customs logic here
                    break;
                case 'uncrushablePlants':
                    console.log(`[Nam Gayz] Uncrushable Plants ${enabled ? 'activated' : 'deactivated'}`);
                    // Implement uncrushable plants logic here
                    break;
            }
        },

        setCurrency(type) {
            let value, inputId;
            
            switch(type) {
                case 'diamonds':
                    value = document.getElementById('diamondValue').value;
                    inputId = 'diamondValue';
                    break;
                case 'tokens':
                    value = document.getElementById('tokenValue').value;
                    inputId = 'tokenValue';
                    break;
                case 'keys':
                    value = document.getElementById('keyValue').value;
                    inputId = 'keyValue';
                    break;
            }

            if (value && !isNaN(value)) {
                console.log(`[Nam Gayz] Setting ${type} to: ${value}`);
                // Add your currency modification logic here
                // Example: Game.setCurrency(type, parseInt(value));
                
                // Clear the input after setting
                document.getElementById(inputId).value = '';
            } else {
                console.log(`[Nam Gayz] Invalid ${type} value entered`);
            }
        },

        unlockDimension(dimension) {
            if (dimension === 'all') {
                console.log('[Nam Gayz] Unlocking all dimensions');
                // Implement unlock all dimensions logic here
            } else {
                console.log(`[Nam Gayz] Unlocking ${dimension} dimension`);
                // Implement specific dimension unlock logic here
            }
        },

        unlockPlant() {
            const plantId = document.getElementById('plantId').value;
            
            if (plantId) {
                console.log(`[Nam Gayz] Unlocking plant with ID: ${plantId}`);
                // Add your plant unlocking logic here
                // Example: Game.unlockPlant(plantId);
                
                // Clear the input after unlocking
                document.getElementById('plantId').value = '';
            } else {
                console.log('[Nam Gayz] Please enter a valid plant ID');
            }
        },

        unlockZombie() {
            const zombieId = document.getElementById('zombieId').value;
            
            if (zombieId) {
                console.log(`[Nam Gayz] Unlocking zombie with ID: ${zombieId}`);
                // Add your zombie unlocking logic here
                // Example: Game.unlockZombie(zombieId);
                
                // Clear the input after unlocking
                document.getElementById('zombieId').value = '';
            } else {
                console.log('[Nam Gayz] Please enter a valid zombie ID');
            }
        },

        saveConfig() {
            const config = {
                cheats: this.cheats
            };
            console.log('[Nam Gayz] Config saved:', config);
            window.namGayzConfig = config;
        },

        loadConfig() {
            const config = window.namGayzConfig;
            if (config) {
                console.log('[Nam Gayz] Config loaded:', config);
                Object.keys(config.cheats || {}).forEach(cheat => {
                    const checkbox = document.querySelector(`input[onchange*="${cheat}"]`);
                    if (checkbox) {
                        checkbox.checked = config.cheats[cheat];
                        this.toggleCheat(cheat, config.cheats[cheat]);
                    }
                });
            } else {
                console.log('[Nam Gayz] No saved config found');
            }
        },

        toggleMenu() {
            const menu = document.getElementById('namGayzMenu');
            if (menu.style.display === 'none') {
                menu.style.display = 'block';
                menu.style.opacity = '0';
                menu.style.transform = `translate3d(${this.xOffset}px, ${this.yOffset}px, 0) scale(0.8)`;
                // Smooth fade in
                requestAnimationFrame(() => {
                    menu.style.opacity = '1';
                    menu.style.transform = `translate3d(${this.xOffset}px, ${this.yOffset}px, 0) scale(1)`;
                });
            } else {
                menu.style.opacity = '0';
                menu.style.transform = `translate3d(${this.xOffset}px, ${this.yOffset}px, 0) scale(0.8)`;
                setTimeout(() => {
                    menu.style.display = 'none';
                }, 150);
            }
        },

        minimizeMenu() {
            const menu = document.getElementById('namGayzMenu');
            const content = document.getElementById('namGayzContent');
            const titlebar = document.getElementById('namGayzTitlebar');
            
            if (this.isMinimized) {
                // Restore
                content.style.display = 'block';
                menu.style.height = '600px';
                this.isMinimized = false;
                titlebar.querySelector('.minimize-btn').textContent = '−';
            } else {
                // Minimize
                content.style.display = 'none';
                menu.style.height = 'auto';
                this.isMinimized = true;
                titlebar.querySelector('.minimize-btn').textContent = '□';
            }
        },

        closeMenu() {
            const menu = document.getElementById('namGayzMenu');
            menu.style.opacity = '0';
            menu.style.transform = `translate3d(${this.xOffset}px, ${this.yOffset}px, 0) scale(0.8)`;
            setTimeout(() => {
                menu.style.display = 'none';
            }, 150);
        }
    };

    // Initialize the menu
    window.namGayz.init();

    console.log('%c[Nam Gayz] PvZ Mod menu loaded!', 'color: #4a90e2; font-weight: bold;');
    console.log('%cHotkeys: F1 = Toggle | F2 = Save | F3 = Load | ESC = Close | Drag titlebar to move | Drag corner to resize', 'color: #cccccc;');
    console.log('%cFeatures: Cheats, Dimension Unlocker, Plant/Zombie Unlocker, Currency Editor', 'color: #888888;');

})();
