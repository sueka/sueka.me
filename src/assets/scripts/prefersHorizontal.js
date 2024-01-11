// 機械翻訳などによって <html lang> が "ja" 以外の値に変更された場合、縦書き用のスタイルシートを無効化し、デフォルトで横書き表示されるようにする。代替スタイルシートは残す。
;(() => {
  const links = document.querySelectorAll('.linkToVerticalCss')

  // Skip on horizontal-writing pages
  if (links.length === 0) {
    return
  }

  window.addEventListener('DOMContentLoaded', () => {
    const observer = new MutationObserver((mutations) => {
      for (const mutation of mutations) {
        if (mutation.type === 'attributes' && mutation.attributeName === 'lang') {
          for (const link of links) {
            link.disabled = mutation.target.lang !== 'ja'
          }
        }
      }
    })

    observer.observe(document.documentElement, { attributes: true })
  })
})()
