// 機械翻訳などによって <html lang> が "ja" 以外の値に変更された場合、縦書き用のスタイルシートを無効化し、デフォルトで横書き表示されるようにする。代替スタイルシートは残す。
;(() => {
  const jaStyles = document.querySelectorAll('link.for-ja')
  const nonJaStyles = document.querySelectorAll('link.not-for-ja')

  // Skip on horizontal-writing pages
  if (jaStyles.length === 0 && nonJaStyles.length === 0) {
    return
  }

  window.addEventListener('DOMContentLoaded', () => {
    const observer = new MutationObserver((mutations) => {
      for (const mutation of mutations) {
        if (mutation.type === 'attributes' && mutation.attributeName === 'lang') {
          for (const jaStyle of jaStyles) {
            jaStyle.disabled = !isJa(mutation.target.lang)
          }

          for (const nonJaStyle of nonJaStyles) {
            nonJaStyle.disabled = isJa(mutation.target.lang)
          }
        }
      }
    })

    observer.observe(document.documentElement, { attributes: true })
  })

  function isJa(lang) {
    return lang === 'ja' || lang === 'jpn-archaic'
  }
})()
