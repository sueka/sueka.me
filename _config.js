import { autoprefixer, postcssNesting } from 'lume/deps/postcss.ts'
import lume from 'lume/mod.ts'
import bundler from 'lume/plugins/bundler.ts'
import codeHighlight from 'lume/plugins/code_highlight.ts'
import date from 'lume/plugins/date.ts'
import postcss from 'lume/plugins/postcss.ts'
import relativeUrls from 'lume/plugins/relative_urls.ts'
// import csso from 'https://esm.sh/postcss-csso'
import postcssHasPseudo from 'https://jspm.dev/css-has-pseudo/postcss'
import octicons from 'https://jspm.dev/@primer/octicons'
import anchor from 'https://jspm.dev/markdown-it-anchor'
import attrs from 'https://jspm.dev/markdown-it-attrs'
import bracketedSpans from 'https://jspm.dev/markdown-it-bracketed-spans'
import deflist from 'https://jspm.dev/markdown-it-deflist'
import footnote from 'https://jspm.dev/markdown-it-footnote'
import postcssExtendRule from 'https://dev.jspm.io/postcss-extend-rule'
// import postcssPresetEnv from 'https://jspm.dev/postcss-preset-env'

import getIncipit from './lib/getIncipit.ts'
import text from './lib/text.ts'

const site = lume({
  src: 'src',
  location: new URL('https://sueka.me'), // TODO: Use {{ site.data.url }}
  prettyUrls: false,
}, {
  markdown: {
    plugins: [
      [
        anchor,
        {
          level: 2,
          tabIndex: false,
          permalink: anchor.permalink.linkInsideHeader({
            symbol: '&para;',
            placement: 'before',
            ariaHidden: true,
          }),
        },
      ],
      attrs,
      bracketedSpans,
      deflist,
      footnote,
    ],
  },
})
.copy('assets/images/Logo blue.svg', 'assets/images/twitter-logo.svg')
.use(bundler())
.use(codeHighlight())
.use(date())
.use(postcss({
  plugins: [
    // postcssPresetEnv({
    //   features: {
    //     'font-variant-property': false,
    //     'logical-properties-and-values': false,
    //     'nesting-rules': true,
    //   },
    // }),
    autoprefixer(),
    postcssNesting(),
    postcssExtendRule(),
    postcssHasPseudo(),
    // csso({ restructure: false }),
  ],
  sourceMap: true,
}))
.use(relativeUrls())
.filter('encodeUri', encodeURI)
.filter('getIncipit', getIncipit)
.filter('text', text)
.helper('octicon', (symbol, ...args) => octicons[symbol].toSVG(...args), {
  type: 'tag',
})
.preprocess(['.html'], page => {
  page.data.src = `${ page.src.path }${ page.src.ext }`
})

// Remove the origin from an absolute URL; NOTE: Retains feed.xml and sitemap.xml
site.process(['.html', '.js'], page => {
  page.content = page.content.replace(new RegExp(`(?<=")${ site.options.location.origin }(?=/)`, 'g'), '')
  // page.content = page.content.replace(new RegExp(`(?<=")${ site.options.location.origin }(?=")`, 'g'), '/')
})

const process = Deno.run({
  env: {
    GIT_PAGER: '',
  },
  cmd: ['git', 'show', '-s', '--format=%H'],
  stdout: 'piped',
})

const status = await process.status()

// TODO: Abort building in a more normal way
if (!status.success) {
  throw new Error
}

site.data('gitCommitHash', new TextDecoder().decode(await process.output()).trimEnd())

export default site
