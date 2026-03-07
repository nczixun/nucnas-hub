/**
 * Toutiao Auto Publisher
 * 今日头条自动发布脚本
 * 
 * 功能：自动登录 → 填写文章 → 勾选广告 → 发布
 * 使用：node toutiao_publisher.js [article_path]
 */

const fs = require('fs');
const path = require('path');

// ============ 配置 ============
const CONFIG = {
    // 浏览器配置
    browser: {
        headless: false,
        // 使用 Chrome 用户数据目录保持登录状态
        userDataDir: 'C:\\Users\\nczix\\AppData\\Local\\Google\\Chrome\\User Data',
        executablePath: 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
    },
    
    // 发布页面
    urls: {
        publish: 'https://mp.toutiao.com/profile/v4/graphic/publish',
        home: 'https://mp.toutiao.com/'
    },
    
    // 选择器配置
    selectors: {
        // 登录状态检测
        loginCheck: ['.user-avatar', '.user-name', '.account-info'],
        
        // 标题输入框
        title: [
            'input[placeholder*="标题"]',
            'input[placeholder*="title"]',
            '.title-input input',
            '#title'
        ],
        
        // 正文编辑器
        content: [
            'div[contenteditable="true"]',
            '.ql-editor',
            '.article-content .edit-area',
            '#editor'
        ],
        
        // 分类选择器
        category: '.category-selector',
        
        // 投放广告复选框
        adCheckbox: [
            'input[type="checkbox"]',
            '.ad-toggle input',
            '[data-action="toggle-ad"]',
            'label:has-text("投放广告")',
            'span:has-text("投放广告赚收益")'
        ],
        
        // 头条首发复选框
        originalCheckbox: [
            'input[type="checkbox"]',
            '.original-toggle input',
            '[data-action="toggle-original"]',
            'label:has-text("原创")',
            'span:has-text("头条首发")'
        ],
        
        // 发布按钮
        publish: [
            'button:has-text("发布")',
            '.publish-btn',
            'button[type="submit"]',
            '.btn-publish'
        ],
        
        // 封面图上传
        coverUpload: [
            '.cover-upload',
            'input[type="file"]',
            '.upload-btn'
        ]
    },
    
    // 发布设置
    publish: {
        autoAd: true,        // 自动勾选"投放广告赚收益"
        autoOriginal: true,  // 自动勾选"头条首发"
        coverType: 'single', // single/triple/none
        retryTimes: 3,
        retryDelay: 5000
    }
};

// ============ 工具函数 ============

/**
 * 随机等待
 */
function randomWait(min, max) {
    const delay = Math.floor(Math.random() * (max - min + 1)) + min;
    return new Promise(resolve => setTimeout(resolve, delay));
}

/**
 * 通知老板
 */
function notifyBoss(message) {
    console.log(`[通知] ${message}`);
    // 实际可以集成飞书/微信通知
}

/**
 * 读取文章文件
 */
function readArticle(filePath) {
    if (!fs.existsSync(filePath)) {
        throw new Error(`文件不存在：${filePath}`);
    }
    
    const content = fs.readFileSync(filePath, 'utf-8');
    
    // 解析 Front Matter
    const frontMatterMatch = content.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
    if (!frontMatterMatch) {
        return {
            title: path.basename(filePath, '.md'),
            content: content
        };
    }
    
    const frontMatter = frontMatterMatch[1];
    const body = frontMatterMatch[2];
    
    // 提取标题
    const titleMatch = frontMatter.match(/title:\s*["']?([^"'\n]+)["']?/);
    const title = titleMatch ? titleMatch[1].trim() : path.basename(filePath, '.md');
    
    return {
        title,
        content: body.trim()
    };
}

// ============ Playwright 自动化 ============

async function runPublisher() {
    console.log('🚀 今日头条自动发布脚本启动');
    console.log('================================');
    
    // 检查 Playwright
    let playwright;
    try {
        playwright = require('playwright');
    } catch (e) {
        console.error('❌ Playwright 未安装，请先运行：npm install playwright');
        process.exit(1);
    }
    
    const articlePath = process.argv[2];
    if (!articlePath) {
        console.log('用法：node toutiao_publisher.js [文章路径]');
        console.log('示例：node toutiao_publisher.js articles/2026-03-08-01.md');
        process.exit(1);
    }
    
    // 读取文章
    let article;
    try {
        article = readArticle(articlePath);
        console.log(`📄 已加载文章：${article.title}`);
    } catch (e) {
        console.error(`❌ 读取文章失败：${e.message}`);
        process.exit(1);
    }
    
    // 启动浏览器
    console.log('🌐 启动浏览器...');
    let browser;
    let context;
    let page;
    
    try {
        // 检查用户数据目录是否存在
        const userDataExists = fs.existsSync(CONFIG.browser.userDataDir);
        if (!userDataExists) {
            console.log('⚠️  用户数据目录不存在，将使用临时配置');
            console.log('💡 建议：先用 Chrome 登录头条号，然后关闭浏览器再运行此脚本');
        }
        
        browser = await playwright.chromium.launch({
            headless: CONFIG.browser.headless,
            executablePath: CONFIG.browser.executablePath,
            args: [
                '--no-sandbox',
                '--disable-setuid-sandbox',
                '--disable-dev-shm-usage'
            ]
        });
        
        // 使用持久化上下文保持登录状态
        context = await browser.newContext({
            userDataDir: userDataExists ? CONFIG.browser.userDataDir : undefined,
            viewport: { width: 1920, height: 1080 },
            locale: 'zh-CN'
        });
        
        page = context.pages()[0] || await context.newPage();
        
        // 打开发布页面
        console.log('📝 打开发布页面...');
        await page.goto(CONFIG.urls.publish, { 
            waitUntil: 'networkidle',
            timeout: 60000 
        });
        
        await randomWait(3000, 5000);
        
        // 检查登录状态
        console.log('🔐 检查登录状态...');
        const isLoggedIn = await checkLoginStatus(page);
        
        if (!isLoggedIn) {
            console.log('❌ 未登录，请扫码登录头条号');
            console.log('💡 登录后，脚本会自动继续...');
            
            // 等待登录（最多 5 分钟）
            await waitForLogin(page, 300000);
            console.log('✅ 登录成功！');
        }
        
        // 填写标题
        console.log('✏️  填写标题...');
        await fillTitle(page, article.title);
        await randomWait(1000, 2000);
        
        // 填写正文
        console.log('📝 填写正文...');
        await fillContent(page, article.content);
        await randomWait(2000, 3000);
        
        // 勾选"投放广告赚收益"
        if (CONFIG.publish.autoAd) {
            console.log('💰 勾选"投放广告赚收益"...');
            await toggleAdCheckbox(page);
            await randomWait(500, 1000);
        }
        
        // 勾选"头条首发"
        if (CONFIG.publish.autoOriginal) {
            console.log('✅ 勾选"头条首发"...');
            await toggleOriginalCheckbox(page);
            await randomWait(500, 1000);
        }
        
        // 选择封面（可选）
        // await selectCover(page);
        
        // 点击发布
        console.log('🚀 点击发布...');
        const published = await clickPublish(page);
        
        if (published) {
            console.log('✅ 发布成功！');
            notifyBoss(`文章发布成功：${article.title}`);
        } else {
            console.log('❌ 发布失败，请检查原因');
            notifyBoss(`文章发布失败：${article.title}`);
        }
        
    } catch (e) {
        console.error('❌ 执行出错:', e.message);
        notifyBoss(`头条发布脚本出错：${e.message}`);
    } finally {
        // 关闭浏览器
        if (browser) {
            console.log('👋 关闭浏览器...');
            await browser.close();
        }
    }
}

/**
 * 检查登录状态
 */
async function checkLoginStatus(page) {
    for (const selector of CONFIG.selectors.loginCheck) {
        try {
            const element = await page.$(selector);
            if (element) {
                return true;
            }
        } catch (e) {
            continue;
        }
    }
    return false;
}

/**
 * 等待登录
 */
async function waitForLogin(page, timeout) {
    const startTime = Date.now();
    
    while (Date.now() - startTime < timeout) {
        const isLoggedIn = await checkLoginStatus(page);
        if (isLoggedIn) {
            return true;
        }
        await randomWait(2000, 3000);
    }
    
    throw new Error('登录超时');
}

/**
 * 填写标题
 */
async function fillTitle(page, title) {
    for (const selector of CONFIG.selectors.title) {
        try {
            await page.waitForSelector(selector, { timeout: 3000 });
            await page.fill(selector, title);
            console.log(`  ✓ 标题已填写：${title}`);
            return true;
        } catch (e) {
            continue;
        }
    }
    
    // 尝试用 JS 直接设置
    try {
        await page.evaluate((title) => {
            const input = document.querySelector('input[placeholder*="标题"]');
            if (input) {
                input.value = title;
                input.dispatchEvent(new Event('input', { bubbles: true }));
            }
        }, title);
        console.log(`  ✓ 标题已通过 JS 填写`);
        return true;
    } catch (e) {
        console.error('  ✗ 标题填写失败');
        return false;
    }
}

/**
 * 填写正文
 */
async function fillContent(page, content) {
    for (const selector of CONFIG.selectors.content) {
        try {
            await page.waitForSelector(selector, { timeout: 3000 });
            await page.click(selector);
            
            // 模拟打字（避免被检测）
            const chars = content.split('');
            for (const char of chars) {
                await page.keyboard.type(char, { delay: 10 + Math.random() * 20 });
            }
            
            console.log(`  ✓ 正文已填写 (${content.length} 字)`);
            return true;
        } catch (e) {
            continue;
        }
    }
    
    console.error('  ✗ 正文填写失败');
    return false;
}

/**
 * 勾选投放广告
 */
async function toggleAdCheckbox(page) {
    // 尝试多种方法
    for (const selector of CONFIG.selectors.adCheckbox) {
        try {
            const element = await page.$(selector);
            if (element) {
                const isChecked = await element.evaluate(el => 
                    el.tagName === 'INPUT' ? el.checked : el.querySelector('input')?.checked
                );
                
                if (!isChecked) {
                    await element.click();
                    console.log('  ✓ 已勾选"投放广告赚收益"');
                    return true;
                } else {
                    console.log('  ✓ "投放广告赚收益" 已勾选');
                    return true;
                }
            }
        } catch (e) {
            continue;
        }
    }
    
    // 尝试用文本查找
    try {
        const adLabel = await page.$('span:text("投放广告赚收益")');
        if (adLabel) {
            await adLabel.click();
            console.log('  ✓ 已勾选"投放广告赚收益" (文本查找)');
            return true;
        }
    } catch (e) {}
    
    console.log('  ⚠️  未找到"投放广告赚收益"选项，可能需要手动勾选');
    return false;
}

/**
 * 勾选头条首发
 */
async function toggleOriginalCheckbox(page) {
    for (const selector of CONFIG.selectors.originalCheckbox) {
        try {
            const element = await page.$(selector);
            if (element) {
                const isChecked = await element.evaluate(el => 
                    el.tagName === 'INPUT' ? el.checked : el.querySelector('input')?.checked
                );
                
                if (!isChecked) {
                    await element.click();
                    console.log('  ✓ 已勾选"头条首发"');
                    return true;
                } else {
                    console.log('  ✓ "头条首发" 已勾选');
                    return true;
                }
            }
        } catch (e) {
            continue;
        }
    }
    
    console.log('  ⚠️  未找到"头条首发"选项');
    return false;
}

/**
 * 点击发布
 */
async function clickPublish(page) {
    for (const selector of CONFIG.selectors.publish) {
        try {
            await page.waitForSelector(selector, { timeout: 5000 });
            await page.click(selector);
            console.log('  ✓ 已点击发布按钮');
            
            // 等待发布结果
            await randomWait(3000, 5000);
            
            // 检查是否发布成功
            const currentUrl = page.url();
            if (currentUrl.includes('success') || currentUrl.includes('list')) {
                return true;
            }
            
            // 检查是否有错误提示
            const errorEl = await page.$('.error, .toast-error');
            if (errorEl) {
                const errorMsg = await errorEl.textContent();
                console.log(`  ✗ 发布错误：${errorMsg}`);
                return false;
            }
            
            return true;
        } catch (e) {
            continue;
        }
    }
    
    console.error('  ✗ 未找到发布按钮');
    return false;
}

// ============ 启动 ============
runPublisher().catch(console.error);
