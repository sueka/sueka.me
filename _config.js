import {
  autoprefixer,
  lume,
  codeHighlight,
  date,
  postcss,
  relativeUrls,
  slugifyUrls,
  parse,
  ja,
  postcssHasPseudo,
  octicons,
  abbr,
  anchor,
  attrs,
  bracketedSpans,
  collapsible,
  deflist,
  footnote,
  mark,
  multimdTable,
  namedCodeBlocks,
  ruby,
  postcssCustomSelectors,
  postcssExtendRule,
  postcssPresetEnv
} from './deps.ts'

import getIncipit from './lib/getIncipit.ts'

const data = parse(await Deno.readTextFile('./src/_data/site.yml'))

const site = lume({
  src: 'src',
  location: new URL(data.url),
  prettyUrls: false,
}, {
  markdown: {
    plugins: [
      abbr,
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
      collapsible,
      deflist,
      footnote,
      mark,
      [
        multimdTable,
        {
          multiline: true,
        },
      ],
      namedCodeBlocks,
      ruby,
    ],
  },
})
.copy('assets/images/Logo blue.svg', 'assets/images/twitter-logo.svg')
.copy('favicon.ico')
.use(codeHighlight())
.use(date({ locales: { ja } }))
.use(postcss({
  plugins: [
    postcssPresetEnv({
      features: {
        'font-variant-property': false,
        'nesting-rules': true,
      },
    }),
    autoprefixer(),
    postcssCustomSelectors(),
    postcssExtendRule(),
    postcssHasPseudo(),
    // csso({ restructure: false }),
  ],
  sourceMap: true,
}))
.use(relativeUrls())
.use(slugifyUrls())
.filter('encodeUri', encodeURI)
.filter('getIncipit', getIncipit)
.helper('env', (name) => Deno.env.get(name), {
  type: 'tag',
})
.helper('octicon', (symbol, ...args) => octicons[symbol].toSVG(...args), {
  type: 'tag',
})
.preprocess(['.html'], page => {
  page.data.src = `${ page.src.path }${ page.src.ext }`
})

// Remove the origin from an absolute URL; NOTE: Retains feed.xml
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
