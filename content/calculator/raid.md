---
title: "RAID 计算器"
slug: "raid"
description: "计算 RAID 0/1/5/6/10 的理论容量，区分 RAID 10 保证单盘容错与不同镜像组的条件容错"
date: 2026-03-07
lastmod: 2026-10-13
reviewedAt: 2026-10-13
contentType: "工具与公式核查"
sources:
  - "https://kb.synology.com/helpfile/DSM/6.2.3/dsm/enu/StorageManager/general.html"
  - "https://global.download.synology.com/download/Document/Software/UserGuide/Firmware/DSM/6.0/enu/Syno_UsersGuide_NAServer_enu.pdf"
---

# 💾 RAID 容量计算器

选择 RAID 模式，输入硬盘参数，估算**同容量硬盘、单个阵列**的理论容量。混盘时按最小成员盘容量填写仅作保守估算，本工具不模拟混盘布局。结果未扣除系统分区、文件系统、元数据及热备盘，实际可用空间以设备管理界面为准。TB 按十进制计量。

<div x-data="raidCalculator()" x-init="calculate()" class="raid-calculator">
    <!-- RAID 模式选择 -->
    <div class="raid-mode-select">
        <p class="raid-label">选择 RAID 模式</p>
        <div class="raid-modes">
            <template x-for="mode in raidModes" :key="mode.id">
                <button
                    class="raid-mode-btn"
                    :class="selectedMode === mode.id ? 'active' : ''"
                    @click="selectMode(mode.id)"
                    :title="mode.desc"
                    :aria-pressed="selectedMode === mode.id"
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
                <label class="raid-label" for="raid-disk-count">成员硬盘数量（2–24 块）</label>
                <input id="raid-disk-count" type="number" x-model="diskCount" min="2" max="24" step="1" required class="raid-input" @input="calculate()" :aria-invalid="Boolean(warning)" aria-describedby="raid-warning">
            </div>
            <div class="config-item">
                <label class="raid-label" for="raid-disk-size">最小成员盘容量 (TB)</label>
                <input id="raid-disk-size" type="number" x-model="diskSize" min="0" step="any" required class="raid-input" @input="calculate()" :aria-invalid="Boolean(warning)" aria-describedby="raid-warning">
            </div>
        </div>
    </div>
    <!-- 计算结果 -->
    <div class="raid-result" x-show="valid" x-cloak aria-live="polite">
        <div class="result-grid">
            <div class="result-card">
                <div class="result-icon">💽</div>
                <div class="result-label">理论可用容量</div>
                <div class="result-value" x-text="result.usableCapacity"></div>
                <div class="result-sub" x-text="'原始容量: ' + result.rawCapacity + ' TB'"></div>
            </div>
            <div class="result-card">
                <div class="result-icon">🛡️</div>
                <div class="result-label">任意成员盘失效容错</div>
                <div class="result-value"
                     :class="result.faultTolerance > 0 ? 'text-green' : 'text-red'"
                     x-text="result.faultTolerance + ' 块硬盘'"></div>
                <div class="result-sub" x-text="result.faultTolerance > 0 ? '其余成员健康时，可承受任意这些盘失效' : '任意一盘失效都会破坏阵列'"></div>
                <div class="result-sub raid-conditional" x-show="selectedMode === '10'" x-text="'条件上限：' + result.conditionalMaxFailures + ' 盘；每个镜像对最多失效 1 盘，同一对的两盘失效即无法由 RAID 恢复。'"></div>
            </div>
            <div class="result-card">
                <div class="result-icon">📊</div>
                <div class="result-label">存储效率</div>
                <div class="result-value" x-text="result.efficiency + '%'"></div>
                <div class="result-sub" x-text="result.waste + ' TB 用于镜像或校验'"></div>
            </div>
        </div>
    </div>
    <!-- 警告提示 -->
    <div id="raid-warning" class="raid-warning" x-show="warning" x-text="warning" role="alert" x-cloak></div>
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
                    <td>条带，无冗余</td>
                </tr>
                <tr>
                    <td><strong>RAID 1</strong></td>
                    <td>2</td>
                    <td>✅ N-1</td>
                    <td>1/N（两盘时 50%）</td>
                    <td>本工具按所有成员存放同一份镜像计算</td>
                </tr>
                <tr>
                    <td><strong>RAID 5</strong></td>
                    <td>3</td>
                    <td>✅ 1</td>
                    <td>(N−1)/N</td>
                    <td>单校验</td>
                </tr>
                <tr>
                    <td><strong>RAID 6</strong></td>
                    <td>4</td>
                    <td>✅ 2</td>
                    <td>(N−2)/N</td>
                    <td>双校验</td>
                </tr>
                <tr>
                    <td><strong>RAID 10</strong></td>
                    <td>4，且为偶数</td>
                    <td>任意 1 盘；每对至多 1 盘时最多 N/2</td>
                    <td>50%</td>
                    <td>按双盘镜像对做条带</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

## 容错怎么算

6 块盘的常规 RAID 10 由 3 个双盘镜像对组成。任意 1 块盘失效仍有副本；如果 2 块故障盘属于同一镜像对，则不能依赖 RAID 恢复完整数据。只有故障分散在不同镜像对、每对最多 1 块时，才可能承受最多 3 块盘失效。因此，“最多 3 盘”不能作为保证容错数。

本工具采用常规双盘镜像对 RAID 10，不覆盖特殊复制布局或多阵列存储池。RAID 1 按多盘保存同一镜像的通用模型计算；具体设备允许的盘数和布局须查型号说明。2–24 是本工具的输入范围，并非所有设备均支持。

RAID 提供硬盘故障冗余，不能替代独立备份，也不保证在重建读取错误、误删、勒索软件或整机损坏时恢复。重要数据请另做备份，并验证恢复过程。

## 公式来源

- [Synology DSM 存储池与 RAID 类型说明](https://kb.synology.com/helpfile/DSM/6.2.3/dsm/enu/StorageManager/general.html)：最少盘数、容量与容错条件。
- [Synology NAS 用户指南（DSM 6.0，RAID Groups）](https://global.download.synology.com/download/Document/Software/UserGuide/Firmware/DSM/6.0/enu/Syno_UsersGuide_NAServer_enu.pdf)：RAID 10 按镜像组分布的失效条件。

<script>
function raidCalculator() {
    return {
        diskCount: 4,
        diskSize: 8,
        selectedMode: '5',
        warning: '',
        valid: false,
        raidModes: [
            { id: '0', name: 'RAID 0', desc: '条带，无冗余' },
            { id: '1', name: 'RAID 1', desc: '完整镜像' },
            { id: '5', name: 'RAID 5', desc: '单校验' },
            { id: '6', name: 'RAID 6', desc: '双校验' },
            { id: '10', name: 'RAID 10', desc: '镜像对 + 条带' }
        ],
        result: {
            usableCapacity: '0 TB',
            rawCapacity: '0',
            faultTolerance: 0,
            conditionalMaxFailures: 0,
            efficiency: 0,
            waste: 0
        },
        selectMode(mode) {
            this.selectedMode = mode;
            this.calculate();
        },
        calculate() {
            const count = Number(this.diskCount);
            const size = Number(this.diskSize);
            this.warning = '';
            this.valid = false;
            this.result = { usableCapacity: '0 TB', rawCapacity: '0', faultTolerance: 0, conditionalMaxFailures: 0, efficiency: 0, waste: 0 };

            if (String(this.diskCount).trim() === '' || !Number.isInteger(count) || count < 2 || count > 24) {
                this.warning = '请输入 2–24 之间的整数盘数。';
                return;
            }
            if (String(this.diskSize).trim() === '' || !Number.isFinite(size) || size <= 0 || !Number.isFinite(count * size)) {
                this.warning = '请输入有效的正数单盘容量（TB）。';
                return;
            }
            const minimum = { '0': 2, '1': 2, '5': 3, '6': 4, '10': 4 }[this.selectedMode];
            if (!minimum) {
                this.warning = '请选择支持的 RAID 模式。';
                return;
            }
            if (count < minimum) {
                this.warning = 'RAID ' + this.selectedMode + ' 至少需要 ' + minimum + ' 块成员硬盘。';
                return;
            }
            if (this.selectedMode === '10' && count % 2 !== 0) {
                this.warning = '常规 RAID 10 需要偶数块成员硬盘（至少 4 块）。';
                return;
            }
            
            const raw = count * size;
            let usable = 0;
            let faultTolerance = 0;
            let conditionalMaxFailures = 0;
            
            switch(this.selectedMode) {
                case '0':
                    usable = raw;
                    faultTolerance = 0;
                    break;
                case '1':
                    usable = size;
                    faultTolerance = count - 1;
                    break;
                case '5':
                    usable = (count - 1) * size;
                    faultTolerance = 1;
                    break;
                case '6':
                    usable = (count - 2) * size;
                    faultTolerance = 2;
                    break;
                case '10':
                    const mirrorPairs = count / 2;
                    usable = mirrorPairs * size;
                    faultTolerance = 1;
                    conditionalMaxFailures = mirrorPairs;
                    break;
            }
            
            const efficiency = raw > 0 ? Math.round((usable / raw) * 100) : 0;
            const waste = raw - usable;
            const formatCapacity = value => {
                const rounded = Number(value.toPrecision(12));
                return Number.isInteger(rounded) ? rounded.toFixed(1) : String(rounded);
            };
            
            this.result = {
                usableCapacity: formatCapacity(usable) + ' TB',
                rawCapacity: formatCapacity(raw),
                faultTolerance: faultTolerance,
                conditionalMaxFailures: conditionalMaxFailures,
                efficiency: efficiency,
                waste: formatCapacity(waste)
            };
            this.valid = true;
        }
    }
}
</script>

<style>
.raid-calculator [x-cloak] { display: none !important; }
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
    .raid-calculator { padding: 20px; }
    .raid-calculator .config-row { grid-template-columns: 1fr; }
    .raid-calculator .raid-config,
    .raid-calculator .raid-info { padding: 16px; }
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
    box-sizing: border-box;
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

.raid-conditional { margin-top: 10px; line-height: 1.6; }
.raid-info { overflow-x: auto; }
.raid-mode-btn:focus-visible { outline: 3px solid #a0a0ff; outline-offset: 3px; }

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

.article-content .raid-info h3 {
    font-size: 18px;
    margin-bottom: 16px;
    color: white;
}

.raid-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
}

.article-content .raid-table th,
.article-content .raid-table td {
    padding: 12px;
    text-align: left;
    border: 1px solid rgba(255,255,255,0.1);
}

.article-content .raid-table th {
    background: rgba(255,255,255,0.05);
    color: #a0a0ff;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 12px;
    letter-spacing: 1px;
}

.article-content .raid-table td {
    color: rgba(255,255,255,0.8);
}

.raid-table tr:hover td {
    background: rgba(255,255,255,0.05);
}
</style>

<!-- Alpine.js -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
