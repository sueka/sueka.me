import lume from 'lume/mod.ts'
import codeHighlight from 'lume/plugins/code_highlight.ts'
import date from 'lume/plugins/date.ts'
import postcss from 'lume/plugins/postcss.ts'
import relativeUrls from 'lume/plugins/relative_urls.ts'
import csso from 'https://esm.sh/postcss-csso'
import postcssHasPseudo from 'https://jspm.dev/css-has-pseudo/postcss'
import anchor from 'https://jspm.dev/markdown-it-anchor'
import deflist from 'https://jspm.dev/markdown-it-deflist'
import postcssPresetEnv from 'https://jspm.dev/postcss-preset-env'
import postcssExtendRule from 'https://jspm.dev/postcss-extend-rule'

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
.use(codeHighlight())
.use(date())
.use(postcss({
  plugins: [
    postcssPresetEnv({
      features: {
        'font-variant-property': false,
        'logical-properties-and-values': false,
        'nesting-rules': true,
      },
    }),
    postcssExtendRule(),
    postcssHasPseudo(),
    csso(),
  ],
  sourceMap: true,
}))
.use(relativeUrls())
.filter('encodeUri', encodeURI)

export default site
