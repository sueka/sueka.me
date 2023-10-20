<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="2.0"
  xmlns:a="http://www.w3.org/2005/Atom"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
  <xsl:output encoding="utf-8" method="html" />

  <xsl:strip-space elements="*" />

  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="a:feed/a:title/text()" />
        </title>
        <link rel="stylesheet" href="feed.css" />
      </head>
      <body>
        <xsl:apply-templates />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="a:feed">
    <xsl:apply-templates select="a:title" />
    <dl>
      <xsl:apply-templates select="a:*[name() != 'title'][name() != 'entry']" />
    </dl>
    <xsl:apply-templates select="a:entry" />
  </xsl:template>

  <xsl:template match="a:title">
    <h1>
      <xsl:value-of select="text()" />
    </h1>
  </xsl:template>

  <xsl:template match="a:link/@href">
    <a href="{.}">
      <xsl:value-of select="." />
    </a>
  </xsl:template>

  <xsl:template match="a:author/a:name">
    <xsl:value-of select="text()" />
  </xsl:template>

  <xsl:template match="a:entry">
    <section>
      <xsl:apply-templates select="a:title" />
      <dl>
        <xsl:apply-templates select="a:*[name() != 'title']" />
      </dl>
    </section>
  </xsl:template>

  <xsl:template match="a:*">
    <dt>
      <xsl:value-of select="name()" />
    </dt>
    <dd>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </dd>
  </xsl:template>

  <xsl:template match="a:entry/a:content/text()">
    <div class="content">
      <xsl:value-of select="." disable-output-escaping="yes" />
    </div>
  </xsl:template>

  <!-- fallback -->
  <xsl:template match="@*" />
</xsl:transform>
