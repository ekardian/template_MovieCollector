<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:param name="details">false</xsl:param>
<xsl:param name="absolutelinks">false</xsl:param>
<xsl:param name="thumbnails"><THUMBNAILS/></xsl:param>

<xsl:include href="<STANDARDTEMPLATESFOLDER/>shared_templates.xsl"/>

<!-- the main template -->
<xsl:template match="/">
  <HEAD>
    <TITLE><REPORTHEADER/></TITLE>
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="<STYLESHEET/>" type="text/css"/>
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
<br/>
<span class="subtitle">Dirección: Calle Comercio casi esquina Beneméritos, Yacuiba - Bolivia, Descarga a pedido Cel: 68422040</span><br/>
    <span class="title"><font color="Red">IMPORTANTE: </font>Las películas-videos-documentales-clips en esta lista ya están descargados</span><br/>
    <p><center><a href="http://apps.biosxtreme.net/apps/appspdf.zip" target="New" title="Descargar"><span style="font-family: 'DejaVu Sans', Arial, Helvetica, sans-serif; color: #3B5998; font-size: 12px; line-height: 1.2578125; font-weight: bold;" title="Descargar">Descargar lista en PDF</span></a></center></p>
    <p><span style="font-family: 'DejaVu Sans', Arial, Helvetica, sans-serif; color: #FF0400; font-size: 12px; line-height: 1.2578125; font-weight: bold;">NOTA: Para hacer búsquedas presionar CTRL+F</span></p>
    <br/>
    <!--end added-->
    <xsl:apply-templates select="movieinfo/navigation"/>        
    <table>
      <xsl:if test="$thumbnails = 'true'"><th class="header">&nbsp;</th></xsl:if>
      
<HEADERDATA/>
      
      <xsl:if test="$details = 'true'"><th class="header">&nbsp;</th></xsl:if>
    <xsl:apply-templates select="movieinfo/movielist"/>    
    </table>
    <xsl:if test="'<SHOWREPORTDATE/>'='Yes'">
      <br/>
      <div class="value"><xsl:value-of select="//@creationdate"/></div>
    </xsl:if>
    </div>
  </BODY>
</xsl:template>

<xsl:template match="movie">

 <tr>
    <xsl:if test="'<SHOWROWSHADING/>'='Yes'">
      <xsl:if test="position() mod 2 = 0"><xsl:attribute name="class">shading</xsl:attribute></xsl:if>
    </xsl:if>

   <xsl:if test="$thumbnails = 'true'">
   <td class="value">
     <xsl:if test="coverfront!=''">
            <xsl:choose>
              <xsl:when test="$absolutelinks = 'true'">
                <a href="file:///{coverfront}"><img src="images/{id}t.jpg" border="0"/></a>
              </xsl:when>
              <xsl:otherwise>
             <xsl:variable name="extf"><xsl:call-template name="extractfileextension"><xsl:with-param name="filepath" select="coverfront"/></xsl:call-template></xsl:variable>
		<a href="images/{id}f.{$extf}"><img src="images/{id}t.jpg" border="0"/></a>
              </xsl:otherwise>
            </xsl:choose>
     </xsl:if>
   </td>
   </xsl:if>

  
<BODYDATA/>

    <xsl:if test="$details">
      <td class="value">
        <a href="details/{id}.html">Details</a>
      </td>
    </xsl:if>

 </tr> 
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

