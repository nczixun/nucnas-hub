---
title: "RAID 计算器"
slug: "raid"
description: "RAID 容量计算器，支持 RAID 0/1/5/6/10 容量计算与容错分析"
date: 2026-03-07
---

# 💾 RAID 容量计算器

选择 RAID 模式，输入硬盘参数，计算可用容量与容错能力。

<div x-data="raidCalculator()" class="raid-calculator">
    
    <!-- RAID 模式选择 -->
    <div class="raid-mode-select">
        <label class="raid-label">选择 RAID 模式</label>
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

    <!-- 硬盘配置 -->
    <div class="raid-config">
        <div class="config-row">
            <div class="config-item">
                <label class="raid-label">硬盘数量</label>
                <input type="number" x-model="diskCount" min="2" max="24" class="raid-input" @input="calculate()">
            </div>
            <div class="config-item">
                <label class="raid-label">单盘容量 (TB)</label>
                <input type="number" x-model="diskSize" min="1" max="100" step="0.5" class="raid-input" @input="calculate()">
            </div>
        </div>
    </div>

    <!-- 计算结果 -->
    <div class="raid-result" x-show="diskCount >= 2">
        <div class="result-grid">
            <div class="result-card">
                <div class="result-icon">💽</div>
                <div class="result-label">可用容量</div>
                <div class="result-value" x-text="result.usableCapacity"></div>
                <div class="result-sub" x-text="'原始容量: ' + result.rawCapacity + ' TB'"></div>
            </div>
            <div class="result-card">
                <div class="result-icon">🛡️</div>
                <div class="result-label">容错能力</div>
                <div class="result-value" 
                     :class="result.faultTolerance > 0 ? 'text-green' : 'text-red'"
                     x-text="result.faultTolerance + ' 块硬盘'"></div>
                <div class="result-sub" x-text="result.faultTolerance > 0 ? '可同时故障数量' : '无容错'"></div>
            </div>
            <div class="result-card">
                <div class="result-icon">📊</div>
                <div class="result-label">存储效率</div>
                <div class="result-value" x-text="result.efficiency + '%'"></div>
                <div class="result-sub" x-text="result.waste + ' TB 冗余'"></div>
            </div>
        </div>
    </div>

    <!-- 警告提示 -->
    <div class="raid-warning" x-show="warning" x-text="warning" style="display: none;"></div>

    <!-- RAID 模式说明 -->
    <div class="raid-info">
        <h3>📋 RAID 模式对比</h3>
        <table class="raid-table">
            <thead>
                <tr>
                    <th>模式</th>
                    <th>最小盘数</th>
                    <th>容错</th>
                    <th>效率</th>
                    <th>特点</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>RAID 0</strong></td>
                    <td>2</td>
                    <td>❌ 无</td>
                    <td>100%</td>
                    <td>性能最佳，无容错</td>
                </tr>
                <tr>
                    <td><strong>RAID 1</strong></td>
                    <td>2</td>
                    <td>✅ N-1</td>
                    <td>50%</td>
                    <td>镜像备份，安全性高</td>
                </tr>
                <tr>
                    <td><strong>RAID 5</strong></td>
                    <td>3</td>
                    <td>✅ 1</td>
                    <td>67%-94%</td>
                    <td>平衡性能与安全</td>
                </tr>
                <tr>
                    <td><strong>RAID 6</strong></td>
                    <td>4</td>
                    <td>✅ 2</td>
                    <td>50%-92%</td>
                    <td>双重校验，极端安全</td>
                </tr>
                <tr>
                    <td><strong>RAID 10</strong></td>
                    <td>4</td>
                    <td>✅ 1/2</td>
                    <td>50%</td>
                    <td>镜像+条带，性能安全兼顾</td>
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
            { id: '0', name: 'RAID 0', desc: '性能优先' },
            { id: '1', name: 'RAID 1', desc: '镜像备份' },
            { id: '5', name: 'RAID 5', desc: '均衡之选' },
            { id: '6', name: 'RAID 6', desc: '双重容错' },
            { id: '10', name: 'RAID 10', desc: '企业级' }
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
                    if (count < 2) this.warning = 'RAID 0 至少需要 2 块硬盘';
                    break;
                case '1':
                    usable = size;
                    faultTolerance = count - 1;
                    if (count < 2) this.warning = 'RAID 1 至少需要 2 块硬盘';
                    break;
                case '5':
                    usable = (count - 1) * size;
                    faultTolerance = 1;
                    if (count < 3) this.warning = 'RAID 5 至少需要 3 块硬盘';
                    break;
                case '6':
                    usable = (count - 2) * size;
                    faultTolerance = 2;
                    if (count < 4) this.warning = 'RAID 6 至少需要 4 块硬盘';
                    break;
                case '10':
                    const mirrorPairs = Math.floor(count / 2);
                    usable = mirrorPairs * size;
                    faultTolerance = Math.floor(count / 2) - 1;
                    if (count < 4) this.warning = 'RAID 10 至少需要 4 块硬盘';
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
