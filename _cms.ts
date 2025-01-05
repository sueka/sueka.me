import lumeCMS from 'lume/cms/mod.ts'
import { Field } from 'lume/cms/types.ts'

const cms = lumeCMS()

cms.storage('src', 'src')

const commonFields: (string | Field)[] = [
  {
    name: 'layout',
    type: 'hidden',
    value: 'layouts/page.njk',
  },
  {
    name: 'title_rubied',
    type: 'text',
    description: 'Title with ruby (usually used in colophon)',
  },
  'url: text',
  {
    name: 'he',
    type: 'checkbox',
    label: 'Installs fonts for Hebrew',
    transform(value) {
      switch (value) {
        case 'true':
          return true
        case 'false':
          return
      }
    },
  },
  {
    name: 'writing',
    type: 'select',
    options: [
      {
        label: 'auto',
        value: '',
      },
      'horizontal',
      'vertical',
    ],
  },
  {
    name: 'useKaTeX',
    label: 'Uses KaTeX',
    type: 'checkbox',
    transform(value: string) {
      switch (value) {
        case 'true':
          return true
        case 'false':
          return
      }
    },
  },
  {
    name: 'nocolophon',
    label: 'Omits the Colophon',
    type: 'checkbox',
    transform(value: string) {
      switch (value) {
        case 'true':
          return true
        case 'false':
          return
      }
    },
  },
  {
    name: 'templateEngine',
    type: 'list',
    options: [
      'njk',
      'md',
    ],
    transform(value) {
      if (Array.isArray(value) && value.length === 0) {
        return null // TODO
      }

      return value
    },
  },
  {
    name: 'date',
    label: 'Publish Date',
    type: 'date',
    view: 'timestamp',
  },
  {
    name: 'lastmod',
    type: 'date',
    view: 'timestamp',
  },
]

cms.document({
  name: 'home',
  store: 'src:index.md',
  views: ['timestamp'],
  fields: [
    'title: text!',
    'content: markdown',
    ...commonFields,
  ],
})

cms.document({
  name: '404',
  store: 'src:404.md',
  views: ['timestamp'],
  fields: [
    'title: text',
    'content: markdown!',
    ...commonFields,
  ],
})

cms.document({
  name: 'about',
  store: 'src:about.md',
  views: ['timestamp'],
  fields: [
    'title: text!',
    'content: markdown!',
    ...commonFields,
  ],
})

cms.collection({
  name: 'pages',
  store: 'src:pages/**/*.md',
  views: ['timestamp'],
  fields: [
    'title: text!',
    'content: markdown!',
    ...commonFields,
  ],
})

export default cms
