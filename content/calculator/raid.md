---
title: "RAID 璁＄畻鍣�"
slug: "raid"
description: "RAID 瀹归噺璁＄畻鍣紝鏀寔 RAID 0/1/5/6/10 瀹归噺璁＄畻涓庡閿欏垎鏋�"
date: 2026-03-07
---

# 馃捑 RAID 瀹归噺璁＄畻鍣�

閫夋嫨 RAID 妯″紡锛岃緭鍏ョ‖鐩樺弬鏁帮紝璁＄畻鍙敤瀹归噺涓庡閿欒兘鍔涖€�

<div x-data="raidCalculator()" class="raid-calculator">
    
    <!-- RAID 妯″紡閫夋嫨 -->
    <div class="raid-mode-select">
        <label class="raid-label">閫夋嫨 RAID 妯″紡</label>
        <div class="raid-modes">
            <template x-for="mode in raidModes" :key="mode.id">
                <button 
                    class="raid-mode-btn"
                    :class="selectedMode === mode.id ? 'active' : ''"
                    @click="selectMode(mode.id)"
                    :title="mode.desc"
                >
                    <span class="mode-name" x-text="mode.name"></span>
                    <span class="mode-desc" x-text="mode.desc"></span>
                </button>
            </template>
        </div>
    </div>

    <!-- 纭洏閰嶇疆 -->
    <div class="raid-config">
        <div class="config-row">
            <div class="config-item">
                <label class="raid-label">纭洏鏁伴噺</label>
                <input type="number" x-model="diskCount" min="2" max="24" class="raid-input" @input="calculate()">
            </div>
            <div class="config-item">
                <label class="raid-label">鍗曠洏瀹归噺 (TB)</label>
                <input type="number" x-model="diskSize" min="1" max="100" step="0.5" class="raid-input" @input="calculate()">
            </div>
        </div>
    </div>

    <!-- 璁＄畻缁撴灉 -->
    <div class="raid-result" x-show="diskCount >= 2">
        <div class="result-grid">
            <div class="result-card">
                <div class="result-icon">馃捊</div>
                <div class="result-label">鍙敤瀹归噺</div>
                <div class="result-value" x-text="result.usableCapacity"></div>
                <div class="result-sub" x-text="'鍘熷瀹归噺: ' + result.rawCapacity + ' TB'"></div>
            </div>
            <div class="result-card">
                <div class="result-icon">馃洝锔�</div>
                <div class="result-label">瀹归敊鑳藉姏</div>
                <div class="result-value" 
                     :class="result.faultTolerance > 0 ? 'text-green' : 'text-red'"
                     x-text="result.faultTolerance + ' 鍧楃‖鐩�'"></div>
                <div class="result-sub" x-text="result.faultTolerance > 0 ? '鍙悓鏃舵晠闅滄暟閲�' : '鏃犲閿�'"></div>
            </div>
            <div class="result-card">
                <div class="result-icon">馃搳</div>
                <div class="result-label">瀛樺偍鏁堢巼</div>
                <div class="result-value" x-text="result.efficiency + '%'"></div>
                <div class="result-sub" x-text="result.waste + ' TB 鍐椾綑'"></div>
            </div>
        </div>
    </div>

    <!-- 璀﹀憡鎻愮ず -->
    <div class="raid-warning" x-show="warning" x-text="warning" style="display: none;"></div>

    <!-- RAID 妯″紡璇存槑 -->
    <div class="raid-info">
        <h3>馃搵 RAID 妯″紡瀵规瘮</h3>
        <table class="raid-table">
            <thead>
                <tr>
                    <th>妯″紡</th>
                    <th>鏈€灏忕洏鏁�</th>
                    <th>瀹归敊</th>
                    <th>鏁堢巼</th>
                    <th>鐗圭偣</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>RAID 0</strong></td>
                    <td>2</td>
                    <td>鉂� 鏃�</td>
                    <td>100%</td>
                    <td>鎬ц兘鏈€浣筹紝鏃犲閿�</td>
                </tr>
                <tr>
                    <td><strong>RAID 1</strong></td>
                    <td>2</td>
                    <td>鉁� N-1</td>
                    <td>50%</td>
                    <td>闀滃儚澶囦唤锛屽畨鍏ㄦ€ч珮</td>
                </tr>
                <tr>
                    <td><strong>RAID 5</strong></td>
                    <td>3</td>
                    <td>鉁� 1</td>
                    <td>67%-94%</td>
                    <td>骞宠　鎬ц兘涓庡畨鍏�</td>
                </tr>
                <tr>
                    <td><strong>RAID 6</strong></td>
                    <td>4</td>
                    <td>鉁� 2</td>
                    <td>50%-92%</td>
                    <td>鍙岄噸鏍￠獙锛屾瀬绔畨鍏�</td>
                </tr>
                <tr>
                    <td><strong>RAID 10</strong></td>
                    <td>4</td>
                    <td>鉁� 1/2</td>
                    <td>50%</td>
                    <td>闀滃儚+鏉″甫锛屾€ц兘瀹夊叏鍏奸【</td>
                </tr>
            </tbody>
        </table>
    </div>

</div>

<script>
function raidCalculator() {
    return {
        diskCount: 4,
        diskSize: 8,
        selectedMode: '5',
        warning: '',
        raidModes: [
            { id: '0', name: 'RAID 0', desc: '鎬ц兘浼樺厛' },
            { id: '1', name: 'RAID 1', desc: '闀滃儚澶囦唤' },
            { id: '5', name: 'RAID 5', desc: '鍧囪　涔嬮€�' },
            { id: '6', name: 'RAID 6', desc: '鍙岄噸瀹归敊' },
            { id: '10', name: 'RAID 10', desc: '浼佷笟绾�' }
        ],
        result: {
            usableCapacity: '0 TB',
            rawCapacity: '0',
            faultTolerance: 0,
            efficiency: 0,
            waste: 0
        },
        selectMode(mode) {
            this.selectedMode = mode;
            this.calculate();
        },
        calculate() {
            const count = parseInt(this.diskCount) || 0;
            const size = parseFloat(this.diskSize) || 0;
            this.warning = '';
            
            if (count < 2 || size <= 0) {
                this.result = { usableCapacity: '0 TB', rawCapacity: '0', faultTolerance: 0, efficiency: 0, waste: 0 };
                return;
            }
            
            const raw = count * size;
            let usable = 0;
            let faultTolerance = 0;
            
            switch(this.selectedMode) {
                case '0':
                    usable = raw;
                    faultTolerance = 0;
                    if (count < 2) this.warning = 'RAID 0 鑷冲皯闇€瑕� 2 鍧楃‖鐩�';
                    break;
                case '1':
                    usable = size;
                    faultTolerance = count - 1;
                    if (count < 2) this.warning = 'RAID 1 鑷冲皯闇€瑕� 2 鍧楃‖鐩�';
                    break;
                case '5':
                    usable = (count - 1) * size;
                    faultTolerance = 1;
                    if (count < 3) this.warning = 'RAID 5 鑷冲皯闇€瑕� 3 鍧楃‖鐩�';
                    break;
                case '6':
                    usable = (count - 2) * size;
                    faultTolerance = 2;
                    if (count < 4) this.warning = 'RAID 6 鑷冲皯闇€瑕� 4 鍧楃‖鐩�';
                    break;
                case '10':
                    const mirrorPairs = Math.floor(count / 2);
                    usable = mirrorPairs * size;
                    faultTolerance = Math.floor(count / 2) - 1;
                    if (count < 4) this.warning = 'RAID 10 鑷冲皯闇€瑕� 4 鍧楃‖鐩�';
                    break;
            }
            
            const efficiency = raw > 0 ? Math.round((usable / raw) * 100) : 0;
            const waste = raw - usable;
            
            this.result = {
                usableCapacity: usable.toFixed(1) + ' TB',
                rawCapacity: raw.toFixed(1),
                faultTolerance: faultTolerance,
                efficiency: efficiency,
                waste: waste.toFixed(1)
            };
        }
    }
}
</script>

<style>
.raid-calculator {
    max-width: 800px;
    margin: 0 auto;
    padding: 32px;
    background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
    border-radius: 20px;
    color: white;
    font-family: 'Noto Sans SC', sans-serif;
}

.raid-label {
    display: block;
    font-size: 14px;
    font-weight: 600;
    color: #a0a0ff;
    margin-bottom: 12px;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.raid-modes {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 10px;
    margin-bottom: 32px;
}

@media (max-width: 600px) {
    .raid-modes {
        grid-template-columns: repeat(3, 1fr);
    }
}

.raid-mode-btn {
    background: rgba(255,255,255,0.05);
    border: 2px solid rgba(255,255,255,0.1);
    border-radius: 12px;
    padding: 16px 8px;
    cursor: pointer;
    transition: all 0.3s;
    text-align: center;
}

.raid-mode-btn:hover {
    background: rgba(255,255,255,0.1);
    border-color: rgba(255,255,255,0.3);
}

.raid-mode-btn.active {
    background: linear-gradient(135deg, #667eea, #764ba2);
    border-color: #667eea;
    box-shadow: 0 4px 20px rgba(102, 126, 234, 0.4);
}

.mode-name {
    display: block;
    font-size: 16px;
    font-weight: 700;
    color: white;
    margin-bottom: 4px;
}

.mode-desc {
    display: block;
    font-size: 11px;
    color: rgba(255,255,255,0.6);
}

.raid-config {
    background: rgba(255,255,255,0.05);
    border-radius: 16px;
    padding: 24px;
    margin-bottom: 24px;
}

.config-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.raid-input {
    width: 100%;
    padding: 14px 18px;
    background: rgba(0,0,0,0.3);
    border: 2px solid rgba(255,255,255,0.15);
    border-radius: 10px;
    color: white;
    font-size: 18px;
    font-weight: 600;
    transition: all 0.3s;
}

.raid-input:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 20px rgba(102, 126, 234, 0.3);
}

.result-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
    margin-bottom: 24px;
}

@media (max-width: 600px) {
    .result-grid {
        grid-template-columns: 1fr;
    }
}

.result-card {
    background: rgba(255,255,255,0.08);
    border-radius: 16px;
    padding: 20px;
    text-align: center;
    border: 1px solid rgba(255,255,255,0.1);
}

.result-icon {
    font-size: 32px;
    margin-bottom: 8px;
}

.result-label {
    font-size: 12px;
    color: rgba(255,255,255,0.6);
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-bottom: 8px;
}

.result-value {
    font-size: 28px;
    font-weight: 800;
    color: #667eea;
    margin-bottom: 4px;
}

.result-value.text-green {
    color: #34C759;
}

.result-value.text-red {
    color: #FF3B30;
}

.result-sub {
    font-size: 12px;
    color: rgba(255,255,255,0.5);
}

.raid-warning {
    background: rgba(255, 59, 48, 0.2);
    border: 1px solid #FF3B30;
    border-radius: 10px;
    padding: 12px 16px;
    color: #FF3B30;
    font-size: 14px;
    margin-bottom: 24px;
}

.raid-info {
    background: rgba(255,255,255,0.05);
    border-radius: 16px;
    padding: 24px;
}

.raid-info h3 {
    font-size: 18px;
    margin-bottom: 16px;
    color: white;
}

.raid-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
}

.raid-table th,
.raid-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid rgba(255,255,255,0.1);
}

.raid-table th {
    color: #a0a0ff;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 12px;
    letter-spacing: 1px;
}

.raid-table td {
    color: rgba(255,255,255,0.8);
}

.raid-table tr:hover td {
    background: rgba(255,255,255,0.05);
}
</style>

<!-- Alpine.js -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
