/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/assets/stylesheets/**/*.css',
  ],
  theme: {
    extend: {
      colors: {
        // 必要に応じてここにカスタムカラーを足せますが、
        // orange-50などは標準で入っているので設定不要です。
      },
    },
  },
  plugins: [],
}