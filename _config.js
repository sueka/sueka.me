import lume from 'lume/mod.ts'
import date from 'lume/plugins/date.ts'
import postcss from 'lume/plugins/postcss.ts'
import relativeUrls from 'lume/plugins/relative_urls.ts'
import anchor from 'https://jspm.dev/markdown-it-anchor'
import deflist from 'https://jspm.dev/markdown-it-deflist'
import postcssPresetEnv from 'https://jspm.dev/postcss-preset-env'

const site = lume({
  src: 'src',
  location: new URL('https://sueka.me'), // TODO: Use {{ site.data.url }}
  prettyUrls: false,
}, {
  markdown: {
    plugins: [
      [anchor, { level: 2, permalink: anchor.permalink.headerLink() }],
      deflist,
    ],
  },
})
.use(date())
.use(postcss({
  plugins: [
    postcssPresetEnv({
      features: {
        'logical-properties-and-values': false,
        'nesting-rules': true,
      },
    }),
  ],
  sourceMap: true,
}))
.use(relativeUrls())
.filter('encodeUri', encodeURI)

export default site
