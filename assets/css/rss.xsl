<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />
	<xsl:variable name="title" select="/rss/channel/title"/>
	<xsl:variable name="feedUrl" select="/rss/channel/atom:link[@ref='self']/@href" xmlns:atom="http://www.w3.org/2005/Atom"/>
	<xsl:variable name="srclink" select="/rss/channel/link"/>
	<xsl:template match="/">
		<xsl:element name="html">
			<head>
				<title>
					<xsl:value-of select="$title"/>
				</title>
				<link rel="stylesheet" href="/css/t1.css" type="text/css" />
				<link rel="alternate" type="application/rss+xml" title="RSS" href="{$feedUrl}" />
				<xsl:element name="script">
					<xsl:attribute name="type">text/javascript</xsl:attribute>
					<xsl:attribute name="src">/js/xsl.js</xsl:attribute>
				</xsl:element>
				<xsl:element name="script">
					<xsl:attribute name="type">text/javascript</xsl:attribute>
					<xsl:attribute name="src">/js/tip.js</xsl:attribute>
				</xsl:element>
				<xsl:element name="script">
					<xsl:attribute name="type">text/javascript</xsl:attribute>
					<xsl:attribute name="src">/js/download.js</xsl:attribute>
				</xsl:element>
				<xsl:element name="script">
					<xsl:attribute name="type">text/javascript</xsl:attribute>
					<xsl:attribute name="src">/js/common.js</xsl:attribute>
				</xsl:element>
				<xsl:element name="base">
					<xsl:attribute name="href"><xsl:value-of select="$srclink"/></xsl:attribute>
				</xsl:element>
			</head>
			<xsl:apply-templates select="rss/channel"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="channel">
		<body id="mainbody">
			<div id="cometestme" style="display:none;">
				<xsl:text disable-output-escaping="yes" >&amp;amp;</xsl:text>
			</div>
			<div id="left">
				<xsl:apply-templates select="image"/>
					<center><div id="at">
						<h3>
							<a href="{link}" style="color:#FF7C1A;text-decoration:none;">
								<xsl:value-of select="$title"/>
							</a>
						</h3>
						<p><xsl:value-of select="description" disable-output-escaping="yes"/></p>
					</div></center>
			</div>
			<div id="postcontent">
				<ul>
					<xsl:apply-templates select="item"/>
				</ul>
			</div>
		</body>
	</xsl:template>
	<xsl:template match="item">
		<xsl:if test="position() = 1">
		</xsl:if>
		<ul style="padding:0;margin:0;" xmlns="http://www.w3.org/1999/xhtml">
			<li class="regularitem">
				<h3 class="itemtitle">
          <a name="#{position()}"></a>
					<a href="{link}">
						<xsl:value-of select="title"/>
					</a>
				</h3>
		<h5 class="itemposttime"><xsl:value-of select="pubDate"/></h5>
		<div name="decodeable" class="itemcontent"><xsl:call-template name="outputContent"/></div>
				<xsl:if test="count(child::enclosure)=1">
					<p>
						<a href="{enclosure/@url}">
						</a>
					</p>
				</xsl:if>
			</li>
		</ul>
	</xsl:template>
	<xsl:template match="image">
    <a href="{link}">
		<xsl:element name="img" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="border">
        0
      </xsl:attribute>
			<xsl:attribute name="src">
				<xsl:value-of select="url"/>
			</xsl:attribute>
			<xsl:attribute name="alt">Link to <xsl:value-of select="title"/>
			</xsl:attribute>
			<xsl:attribute name="id">feedimage</xsl:attribute>
		</xsl:element>
		<xsl:text> </xsl:text>
    </a>
	</xsl:template>
	<xsl:template name="outputContent">
		<xsl:choose>
			<xsl:when test="xhtml:body" xmlns:xhtml="http://www.w3.org/1999/xhtml">
				<xsl:copy-of select="xhtml:body/*"/>
			</xsl:when>
			<xsl:when test="xhtml:div" xmlns:xhtml="http://www.w3.org/1999/xhtml">
				<xsl:copy-of select="xhtml:div"/>
			</xsl:when>
			<xsl:when test="content:encoded" xmlns:content="http://purl.org/rss/1.0/modules/content/">
				<xsl:value-of select="content:encoded" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:when test="description">
				<xsl:value-of select="description" disable-output-escaping="yes"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
