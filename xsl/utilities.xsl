<?xml version="1.0" encoding="UTF-8" ?>
<!--
 (C) Copyright Nokia Corporation and/or its subsidiary(-ies) 2009  - 2011. All rights reserved.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">  

  <xsl:template name="strip-url-fragment">
    <xsl:param name="url"/>
    <xsl:choose>
      <xsl:when test="contains($url, '#')">
        <xsl:value-of select="substring-before($url, '#')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$url"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <xsl:template name="substring-after-last">
      <xsl:param name="string" />
      <xsl:param name="delimiter" />
      <xsl:choose>
        <xsl:when test="contains($string, $delimiter)">
          <xsl:call-template name="substring-after-last">
            <xsl:with-param name="string"
              select="substring-after($string, $delimiter)" />
            <xsl:with-param name="delimiter" select="$delimiter" />
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$string" /></xsl:otherwise>
      </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
