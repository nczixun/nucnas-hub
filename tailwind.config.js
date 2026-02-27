/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./layouts/**/*.html", "./content/**/*.md"],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        // MiniMax 风格深色主题 - 更纯粹的深灰/黑色
        'mm-bg': '#0A0A0B',
        'mm-card': '#141416',
        'mm-border': '#2A2A2E',
        'mm-hover': '#1E1E22',
        // 渐变强调色 - 紫蓝色系
        'mm-accent': '#8B5CF6',
        'mm-accent-light': '#A78BFA',
        'mm-gradient-start': '#6366F1',
        'mm-gradient-end': '#8B5CF6',
        // 文字颜色
        'mm-text': '#FAFAFA',
        'mm-text-secondary': '#A1A1AA',
        'mm-text-muted': '#71717A',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['JetBrains Mono', 'monospace'],
        cn: ['Noto Sans SC', 'Inter', 'sans-serif'],
      },
      backgroundImage: {
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
        'gradient-primary': 'linear-gradient(135deg, #6366F1 0%, #8B5CF6 100%)',
      }
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
