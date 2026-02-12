/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./layouts/**/*.html", "./content/**/*.md"],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        'tech-bg': '#0B0E14',
        'tech-card': '#151B26',
        'tech-border': '#2D3748',
        'neon-blue': '#00F0FF',
        'neon-green': '#39FF14',
        'text-main': '#E2E8F0',
        'text-muted': '#94A3B8',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['JetBrains Mono', 'monospace'],
      },
      backgroundImage: {
        'grid-pattern': "radial-gradient(circle, #2d3748 1px, transparent 1px)",
      }
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
