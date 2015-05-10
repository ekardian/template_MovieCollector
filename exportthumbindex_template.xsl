<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:param name="details">false</xsl:param>
<xsl:param name="absolutelinks">false</xsl:param>
<xsl:param name="thumbnails"><THUMBNAILS/></xsl:param>
<xsl:param name="indextablecols"><TABLECOLS/></xsl:param>
<xsl:param name="thumbshowcaption"><THUMBSHOWCAPTION/></xsl:param>

<!-- process a lookup item -->
<xsl:template match="node()[displayname!='']">
  <xsl:choose>
    <xsl:when test="url!=''">
      <a href="{url}"><xsl:value-of select="displayname"/></a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="displayname"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- the main template -->
<xsl:template match="/">
  <HEAD>
    <LINK REL="StyleSheet" TYPE="text/css" HREF="<STYLESHEET/>"></LINK>
    <link rel="icon" type="image/x-icon" href="images/biosfilm.ico" />
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta property="og:title" content="Yacuiba - Bolivia: http://info.biosxtreme.net" />
			<meta property="og:url" content="http://film.biosxtreme.net/" />
			<meta property="og:type" content="website" />
			<meta property="og:description" content="A la venta --> Colección  		Películas - Documentales - Videotutoriales - Películas Cristianas - Películas Cristianas infantiles - Películas motivacionales" />
			<meta property="og:image" content="http://film.biosxtreme.net/images/filmbiosxtreme.jpg" />
    <TITLE><REPORTHEADER/></TITLE>
  </HEAD>
  <BODY>
    <div align="center">
    <span class="title"><REPORTHEADER/></span>
    <!--added-->
<div id="nav">
    <ul>
        <li><a href="http://film.biosxtreme.net" target="new">Inicio film</a></li>
        <li><a href="http://apps.biosxtreme.net" target="new">Aplicaciones</a></li>
        <li><a href="http://juegos.biosxtreme.net" target="new">Juegos</a></li>
        <li><a href="http://info.biosxtreme.net" target="new">info.biosxtreme.net</a></li>
        <li><a href="https://facebook.com/biosxtreme" target="new">facebook</a></li>
        <li><a href="http://wiki.biosxtreme.net" target="new">wiki</a></li>
    </ul>
</div>
<!--end added-->
<br/>
<span class="subtitle">Dirección: Calle Comercio casi esquina Beneméritos, Yacuiba - Bolivia, Descarga a pedido Cel: 68422040</span><br/>
    <span class="title"><font color="Red">IMPORTANTE: </font>Las películas-videos-documentales-clips en esta lista ya están descargados</span><br/>
    <p><a href="http://film.biosxtreme.net/movies.zip" style="text-decoration:none" target="New"><span style="font-family: 'DejaVu Sans', Arial, Helvetica, sans-serif; color: #ffffff; font-size: 14px; line-height: 1.2578125; font-weight: bold;">descargar lista de películas</span></a></p>
    <span class="subtitle">Buscar en esta página</span>
    <br/>
    <xsl:apply-templates select="movieinfo/navigation"/>    
    <br/>
    <table>    
    <xsl:apply-templates select="movieinfo/movielist"/>
    </table>
    <xsl:if test="'<SHOWREPORTDATE/>'='Yes'">
      <br/>
      <div class="value"><xsl:value-of select="//@creationdate"/></div>
    </xsl:if>
    </div>
  </BODY>
</xsl:template>

<xsl:template match="movielist">
  <xsl:choose>
    <xsl:when test="$indextablecols = 1">
      <xsl:for-each select="movie">
        <tr>
          <xsl:apply-templates select=". | following-sibling::movie[position() &lt; $indextablecols]"/>
        </tr>
      </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
      <xsl:for-each select="movie[position() mod $indextablecols = 1]">
        <tr>
          <xsl:apply-templates select=". | following-sibling::movie[position() &lt; $indextablecols]"/>
        </tr>
      </xsl:for-each>
    </xsl:otherwise>            
  </xsl:choose>
</xsl:template>

<xsl:template match="movie">
  <xsl:choose>
    <xsl:when test="$details = 'true'">
      <xsl:variable name="the_href">details/<xsl:value-of select="id"/>.html</xsl:variable>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$absolutelinks = 'true'">
          <xsl:if test="coverfront!=''">
            <xsl:variable name="the_href">file:///<xsl:value-of select="coverfront"/></xsl:variable>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="coverfront!=''">
            <!--<xsl:variable name="the_href">https://googledrive.com/host/0B4IL_NIjd8oWOWxsM2dHNzBmcFU/<xsl:value-of select="id"/>f.jpg</xsl:variable>-->
		<xsl:variable name="the_href">images/<xsl:value-of select="id"/>f.jpg</xsl:variable>
          </xsl:if>
        </xsl:otherwise>            
      </xsl:choose>
    </xsl:otherwise>            
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="thumbfilepath!=''">
      <!--<xsl:variable name="the_img_src">https://googledrive.com/host/0B4IL_NIjd8oWOWxsM2dHNzBmcFU/<xsl:value-of select="id"/>t.jpg</xsl:variable>-->
	<xsl:variable name="the_img_src">images/<xsl:value-of select="id"/>t.jpg</xsl:variable>
    </xsl:when>
    <xsl:otherwise>
      <!--<xsl:variable name="the_img_src">https://googledrive.com/host/0B4IL_NIjd8oWOWxsM2dHNzBmcFU/mainitem.jpg</xsl:variable>-->
	<xsl:variable name="the_img_src">images/mainitem.jpg</xsl:variable>
    </xsl:otherwise>            
  </xsl:choose>
  <xsl:variable name="the_caption"><xsl:value-of select="title"/></xsl:variable>
  
  <td valign="top">
  <a href="{$the_href}" title="{$the_caption}" id="thumbimage"><img src="{$the_img_src}"/></a>
  <xsl:if test="$thumbshowcaption = 'true'">
  <br/><a href="{$the_href}" title="{$the_caption}"><xsl:value-of select="$the_caption"/></a>
  </xsl:if>
  </td>

   <xsl:if test="(last() &gt; $indextablecols) and (last()=position()) and (position() mod $indextablecols &gt; 0)">
      <xsl:variable name="filledCells" select="position() mod $indextablecols"/>
      <td colspan="{$indextablecols - $filledCells}">&#160;</td>
   </xsl:if>   
</xsl:template>

<xsl:template match="navigation">
  <div class="navigation" align="center">
    <xsl:if test="count(pagelink) > 1">
      <div class="navigationline">
        <xsl:for-each select="pagelink">
          <xsl:choose>
            <xsl:when test="@url!=''">      
              <div class="navlink"><a href="{@url}"><xsl:value-of select="@pagenum"/></a></div>
            </xsl:when>
            <xsl:otherwise>
              <div class="navlink" id="current"><xsl:value-of select="@pagenum"/></div>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="position()!=last()"></xsl:if>
        </xsl:for-each>  
        </div>
        <div class="navigationline">
        <xsl:choose>
          <xsl:when test="firstlink/@url!=''">
            <div class="navlink"><a href="{firstlink/@url}"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttFirst']/@label"/></a></div>
          </xsl:when>
          <xsl:otherwise>
            <div class="navlink"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttFirst']/@label"/></div>
          </xsl:otherwise>
        </xsl:choose>   
        <xsl:choose>
          <xsl:when test="prevlink/@url!=''">
            <div class="navlink"><a href="{prevlink/@url}"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttPrev']/@label"/></a></div>
          </xsl:when>
          <xsl:otherwise>
            <div class="navlink"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttPrev']/@label"/></div>
          </xsl:otherwise>
        </xsl:choose>   
        <xsl:choose>
          <xsl:when test="nextlink/@url!=''">
            <div class="navlink"><a href="{nextlink/@url}"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttNext']/@label"/></a></div>
          </xsl:when>
          <xsl:otherwise>
            <div class="navlink"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttNext']/@label"/></div>
          </xsl:otherwise>
        </xsl:choose>   
        <xsl:choose>
          <xsl:when test="lastlink/@url!=''">
            <div class="navlink"><a href="{lastlink/@url}"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttLast']/@label"/></a></div>
          </xsl:when>
          <xsl:otherwise>
            <div class="navlink"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttLast']/@label"/></div>
          </xsl:otherwise>
        </xsl:choose> 
      </div>
    </xsl:if>
  </div>
</xsl:template>

</xsl:stylesheet>
