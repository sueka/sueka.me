import {
  lume, relativeUrls, slugifyUrls,
  // text
  codeHighlight, date, ja,
  // css
  postcss, autoprefixer, postcssNesting,
  // yaml
  parse
} from './deps.ts'

// media
import octicons from '@primer/octicons'

// markdown-it
import abbr from 'markdown-it-abbr'
import anchor from 'markdown-it-anchor'
import attrs from 'markdown-it-attrs'
import bracketedSpans from 'markdown-it-bracketed-spans'
import collapsible from 'markdown-it-collapsible'
import deflist from 'markdown-it-deflist'
import footnote from 'markdown-it-footnote'
import mark from 'markdown-it-mark'
import multimdTable from 'markdown-it-multimd-table'
import namedCodeBlocks from 'markdown-it-named-code-blocks'
import ruby from 'markdown-it-ruby'

// css
import postcssHasPseudo from 'css-has-pseudo'
import postcssCustomSelectors from 'postcss-custom-selectors'
import postcssExtendRule from 'postcss-extend-rule'

import getIncipit from './lib/getIncipit.ts'
import truncateHtml from './lib/truncateHtml.ts'
import wrapTables from './lib/wrapTables.ts'
import wrapDiagrams from './lib/wrapDiagrams.ts'
import addClassExternal from './lib/addClassExternal.ts'

const data = parse(await Deno.readTextFile('./src/_data/site.yaml'))

const markdown = {
  plugins: [
    abbr,
    [
      anchor,
      {
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
    collapsible,
    deflist,
    footnote,
    mark,
    [
      multimdTable,
      {
        multiline: true,
        headerless: true,
      },
    ],
    namedCodeBlocks,
    ruby,
  ],
}

const site = lume({
  src: 'src',
  location: new URL(data.url),
  prettyUrls: false,
}, { markdown })

site.copy('assets/images/Logo blue.svg', 'assets/images/twitter-logo.svg')
site.copy('favicon.ico')

site.use(codeHighlight())
site.use(date({ locales: { ja } }))

const plugins = [
  // postcssPresetEnv({
  //   features: {
  //     'font-variant-property': false,
  //     'logical-properties-and-values': false,
  //     'nesting-rules': true,
  //   },
  // }),
  autoprefixer(),
  postcssNesting(),
  postcssCustomSelectors(),
  postcssExtendRule(),
  postcssHasPseudo(),
  // csso({ restructure: false }),
]

site.use(postcss({ plugins, sourceMap: true }))
site.use(relativeUrls())
site.use(slugifyUrls())

site.filter('encodeUri', encodeURI)
site.filter('getIncipit', getIncipit)
site.filter('truncateHtml', truncateHtml)

// // Defines {% env 'PATH' %}
// site.helper('env', (name) => Deno.env.get(name), { type: 'tag' })

// Defines {% octicon 'mark-github', 32 %}
site.helper('octicon', (symbol, width) => octicons[symbol].toSVG({ width }), { type: 'tag' })

site.preprocess(['.html'], page => {
  page.data.src = `${ page.src.path }${ page.src.ext }`
})

site.process(['.html'], wrapTables)
site.process(['.html'], wrapDiagrams)
site.process(['.html'], addClassExternal) // class="external"

// Removes the origin from an absolute URL; NOTE: Retains feed.xml
site.process(['.html', '.js'], (page) => {
  // Origin between a quote and a slash. (e.g. Ithref="http://example.com/foo.html"
  const pattern = new RegExp(`(?<=")${ site.options.location.origin }(?=/)`, 'g')

  page.content = page.content.replace(pattern, '')
  // page.content = page.content.replace(new RegExp(`(?<=")${ site.options.location.origin }(?=")`, 'g'), '/')
})

// Defines {{ gitCommitHash }}
const process = Deno.run({
  env: {
    GIT_PAGER: '',
  },
  cmd: ['git', 'show', '-s', '--format=%H'],
  stdout: 'piped',
})

const status = await process.status()

// TODO: Abort the build in a more normal way
if (!status.success) {
  throw new Error
}

site.data('gitCommitHash', new TextDecoder().decode(await process.output()).trimEnd())

// Exports
export default site
