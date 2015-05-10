<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
<xsl:output method="html"/>

<xsl:param name="pageheight">200</xsl:param>
<xsl:param name="pagewidth">400</xsl:param>
<xsl:param name="templatetype">view</xsl:param>
<xsl:param name="absolutelinks">true</xsl:param>
<xsl:param name="stylesheet">view_item_details_blue.css</xsl:param>
<xsl:param name="mybasepath"></xsl:param>

<xsl:include href="shared_templates.xsl"/>

<!-- handle myrating field - set stars -->
<xsl:template name="star">
  <xsl:param name="num" select="0"/>
  	<xsl:variable name="rating">
			<xsl:choose>
			   <xsl:when test="contains($num, '%')">
						<xsl:variable name="percentage">			   
			         <xsl:value-of select="substring-before($num,'%')"/>
						</xsl:variable>
						<xsl:value-of select="$percentage div 10"/>
			   </xsl:when>
			   <xsl:otherwise>		
			       <xsl:value-of select="$num"/>
			   </xsl:otherwise>
			</xsl:choose>
	</xsl:variable>
  <xsl:choose>
    <xsl:when test="$templatetype!='exportdetails'">	
      <a href="http://editrating.html"><img src="{$mybasepath}rating{$rating}.png" border="0"/></a>
    </xsl:when>
    <xsl:otherwise>
      <span class="fieldvaluelarge">  
        <xsl:value-of select="$rating"/>*
      </span>
    </xsl:otherwise>    
  </xsl:choose>     
</xsl:template>

<!-- crew -->
<xsl:template name="personimages">
    <xsl:param name="roleid" select="dfProducer"/>
    <xsl:if test="crew/crewmember[./role[@id=$roleid]]!=''">
	    <tr>
	    <td nowrap="1" class="role image">
	       <xsl:value-of select="/movieinfo/moviemetadata/field[@id=$roleid]/@label"/>
	    </td>
	    <td class="person narrow">
            <table class="person-list">
            <xsl:for-each select="crew/crewmember[./role[@id=$roleid]]">
                <tr class="crew-member">
                <td class="person">
                    <xsl:apply-templates select="person"/>
                </td>
                <td class="picture">
                <xsl:choose>
                    <xsl:when test="person/imageurl!=''">
                        <xsl:call-template name="personimagelink">
                            <xsl:with-param name="nameimglink" select="person/imageurl"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="person/templateimage!=''">
                         <xsl:call-template name="personimagelink">
                           <xsl:with-param name="nameimglink" select="person/templateimage"/>
                         </xsl:call-template>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                </td>
                </tr>
                <xsl:if test="position()!=last()"><xsl:text></xsl:text></xsl:if>
             </xsl:for-each>
            </table>
          </td>
        </tr>
    </xsl:if>
</xsl:template>


<xsl:template name="crewrole">
  <xsl:param name="roleid" select="dfProducer"/>
    <xsl:if test="crew/crewmember[./role[@id=$roleid]]!=''">
      <tr>
         <td nowrap="1" class="role">
           <xsl:value-of select="/movieinfo/moviemetadata/field[@id=$roleid]/@label"/>
         </td>
         <td class="person">
            <xsl:for-each select="crew/crewmember[./role[@id=$roleid]]">                        
                <xsl:apply-templates select="person"/><br />
              <xsl:if test="position()!=last()"><xsl:text></xsl:text></xsl:if>
            </xsl:for-each>
         </td>
      </tr>
    </xsl:if>
</xsl:template>

<!-- crew episodes -->
<xsl:template name="crewrole2">
  <xsl:param name="roleid" select="dfProducer"/>
    <xsl:if test="crew/crewmember[./role[@id=$roleid]]!=''">
           <b><xsl:value-of select="/movieinfo/moviemetadata/field[@id=$roleid]/@label"/>:</b>&nbsp;
            <xsl:for-each select="crew/crewmember[./role[@id=$roleid]]">
                <xsl:apply-templates select="person"/>&nbsp;
              <xsl:if test="position()!=last()"><xsl:text>/&nbsp;</xsl:text></xsl:if>
            </xsl:for-each>
    </xsl:if>
</xsl:template>

<!-- backdrop / poster-->
<xsl:template name="backdropposter">
  <xsl:param name="nameimg" select="''"/>
  <xsl:if test="$templatetype='view' or 'print'">
    <xsl:if test="$nameimg!=''">
      <a href="http://image.html"><img src="file:///{$nameimg}" border="0" style="height:150px;"/></a>
    </xsl:if>
  </xsl:if>
</xsl:template>

<!-- episode image -->
<xsl:template name="imagelinkep">
  <xsl:param name="nameimglink" select="''"/>
  <xsl:if test="$templatetype='view'">
    <xsl:if test="$nameimglink!=''">
      <a href="http://episode.html"><img src="{$nameimglink}" border="0" style="width:100px;"/></a>
    </xsl:if>
  </xsl:if>
</xsl:template>

<!-- personal image -->
<xsl:template name="personimagelink">
  <xsl:param name="nameimglink" select="''"/>
  <xsl:if test="$templatetype='view'">
    <xsl:if test="$nameimglink!=''">
      <a href="http://personimage.html"><img class="personheadshot" src="{$nameimglink}" border="0"/></a>
    </xsl:if>
  </xsl:if>
</xsl:template>


<xsl:template name="boxsetcover">
  <xsl:param name="name" select="''"/>

  <xsl:if test="$templatetype='view'">
    <xsl:if test="$name!=''">
    <div id="boxsetcover">
      <a href="http://image.html"><img src="file:///{$name}" border="0" class="coverimage"/></a>
    </div>
    </xsl:if>
  </xsl:if>
</xsl:template>

<xsl:template name="imdblink">
  <xsl:choose>
    <xsl:when test="$templatetype!='exportdetails'"><img src="{$mybasepath}imdblogo.gif" border="0" alt=""/></xsl:when>
    <xsl:otherwise>IMDB</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="cover">
  <xsl:param name="in_viewhref" select="''"/>
  <xsl:param name="in_cover" select="''"/>
  <xsl:param name="in_id" select="''"/>
  <xsl:param name="in_postfix" select="''"/>

  <xsl:choose>
    <xsl:when test="$templatetype='view'">
       <a href="{$in_viewhref}">
         <img src="file:///{$in_cover}" border="0" class="coverimage"/>
       </a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
       <xsl:when test="$absolutelinks = 'true'">
         <a href="$in_cover"><img src="file:///{$in_cover}" class="coverimage"/></a>
       </xsl:when>
       <xsl:otherwise>
         <xsl:variable name="extf"><xsl:call-template name="extractfileextension"><xsl:with-param name="filepath" select="$in_cover"/></xsl:call-template></xsl:variable>
         <a href="../images/{$in_id}{$in_postfix}.{$extf}"><img src="../images/{$in_id}{$in_postfix}.{$extf}" class="coverimage"/></a>
       </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="collection_status">
  <xsl:param name="in_listid" select="''"/>
  <xsl:param name="in_status" select="''"/>

  <xsl:choose>
    <xsl:when test="$templatetype='view'">
      <img src="{$mybasepath}ic_{$in_listid}_24.png" alt="" border="0"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$in_status"/><br/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="imagelink">
  <xsl:param name="in_viewhref" select="''"/>
  <xsl:param name="in_url" select="''"/>
  
	<xsl:variable name="prefix">
  <xsl:choose>
  		<xsl:when test="contains(in_url, 'http://')"></xsl:when>
			<xsl:otherwise>file:///</xsl:otherwise>
  	</xsl:choose>
	</xsl:variable>
	
  <xsl:choose>
    <xsl:when test="$templatetype='view'">
      <a href="{$in_viewhref}"><img src="{$prefix}{$in_url}" border="0" class="imagefile" /></a>
    </xsl:when>
    <xsl:otherwise>
      <a href="file:///{$in_url}"><img src="file:///{$in_url}" class="imagefile"/></a>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="plot">
	<xsl:call-template name="break"><xsl:with-param name="text" select=".\"/></xsl:call-template> 
</xsl:template>

<!-- the main template -->
<xsl:template match="/">
<html>
  <HEAD>    
    <LINK REL="StyleSheet" TYPE="text/css" HREF="{$mybasepath}{$stylesheet}"></LINK>
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
	 <TITLE>
    <xsl:value-of select="movieinfo/movielist/movie/title"/>
		<xsl:if test="movieinfo/movielist/movie/titleextension!=''">
      <xsl:text> - </xsl:text>
      <xsl:value-of select="movieinfo/movielist/movie/titleextension"/>
    </xsl:if>
    <xsl:if test="movieinfo/movielist/movie/originaltitle!=''">
      <xsl:value-of select="movieinfo/movielist/movie/originaltitle"/>
    </xsl:if>   
    <xsl:if test="movieinfo/movielist/movie/releasedate!=''">
      <xsl:choose>
        <xsl:when test="movieinfo/movielist/movie/releasedate/date!=''">    
          <xsl:text></xsl:text>&#160;(<xsl:value-of select="movieinfo/movielist/movie/releasedate/date"/>)
        </xsl:when>          
        <xsl:otherwise>    
          <xsl:text></xsl:text>&#160;(<xsl:value-of select="movieinfo/movielist/movie/releasedate/year"/>)
        </xsl:otherwise>          
      </xsl:choose>      
    </xsl:if>    
    </TITLE>
  </HEAD>
  <BODY onload="initPage();">      
    <xsl:apply-templates select="movieinfo/navigation"/>
    <xsl:apply-templates select="movieinfo/movielist"/>    
  </BODY>
</html>  
</xsl:template>

<xsl:template match="movie">
  <xsl:if test="$stylesheet='view_item_details_blue_v8.css'"> 
	 	<xsl:variable name="apos">'</xsl:variable>
		<xsl:variable name="fixedbackdrop">
			<xsl:call-template name="replace-string">
				<xsl:with-param name="text" select="backgroundbackdrop"/>
				<xsl:with-param name="replace" select="$apos"/>				
				<xsl:with-param name="with" select="concat('\', $apos)"/>				
			</xsl:call-template>
		</xsl:variable> 
	  <xsl:if test="backgroundbackdrop!=''">
	    <style type="text/css">
			body {background:url('<xsl:value-of select="$fixedbackdrop"/>');background-size:100%;background-attachment:fixed;}	    
			</style>
	  </xsl:if>
  </xsl:if>	
  
  <xsl:if test="boxset!=''">
		<div id="boxset" class="opacity">
      <xsl:call-template name="boxsetcover"><xsl:with-param name="name" select="boxset/frontcover"/></xsl:call-template>
      <xsl:call-template name="boxsetcover"><xsl:with-param name="name" select="boxset/backcover"/></xsl:call-template>
			<span id="movietitle"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfBoxSet']/@label"/>:&nbsp;<xsl:value-of select="boxset/displayname"/></span>
      <table class="valuestable" border="0" cellspacing="0" cellpadding="0">
	      <xsl:if test="boxset/upc!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfUPC']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/upc"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/releasedate!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfDVDReleaseDate']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/releasedate/date"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/purchasedate!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfPurchaseDate']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/purchasedate/date"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/purchaseprice!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfPurchasePrice']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/purchaseprice"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/store!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfStore']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/store/displayname"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/condition!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfCondition']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/condition/displayname"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/currentvalue!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfCurrentValue']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/currentvalue"/></td>
	         </tr>
	      </xsl:if>
			</table>
		  <xsl:if test="boxset/notes!=''">
				<div id="notes">
		    <xsl:call-template name="break">
		      <xsl:with-param name="text" select="boxset/notes"/>
		    </xsl:call-template>
				</div>
		  </xsl:if>
		</div>
	<hr/>
  </xsl:if>

<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top">
     <xsl:choose>    
	    <xsl:when test="coverfront!=''">
	    <div id="frontcover">
	      <xsl:call-template name="cover">
	        <xsl:with-param name="in_viewhref">http://front.html</xsl:with-param>
	        <xsl:with-param name="in_cover" select="coverfront"/>
	        <xsl:with-param name="in_id" select="id"/>
	        <xsl:with-param name="in_postfix">f</xsl:with-param>
	      </xsl:call-template>
	    </div>
	    </xsl:when>
	    <xsl:otherwise>
		    <div id="frontcover">
		    	<a href="http://searchcover.html">
		    		<img src="{$mybasepath}coverplaceholder.png" border="0" class="coverimage"/>
		    	</a>
		    </div>
	    </xsl:otherwise>
    </xsl:choose>
    </td>
    <td valign="top" width="100%">
	<table border="0" cellpadding="0" cellspacing="0" class="opacity nomargintop">
	  <tr><td>
		   <span id="movietitle">
			  <xsl:value-of select="title"/>
		     <xsl:if test="titleextension!=''">
             <xsl:text> - </xsl:text>
             <xsl:value-of select="titleextension"/>
           </xsl:if>
       </span>
		 </td></tr>
	  <tr><td>
		   <span class="fieldvaluelarge">
           <xsl:if test="studios!=''">
			    <xsl:for-each select="studios/studio">
	            <xsl:value-of select="displayname"/>
	            <xsl:if test="position()!=last()"><xsl:text> / </xsl:text></xsl:if>
    	       </xsl:for-each>
           </xsl:if>
           <xsl:if test="releasedate!=''">
             <xsl:choose>
             <xsl:when test="releasedate/date!=''">    
               <xsl:text></xsl:text>&#160;(<xsl:value-of select="releasedate/date"/>)
             </xsl:when>          
             <xsl:otherwise>    
               <xsl:text></xsl:text>&#160;(<xsl:value-of select="releasedate/year"/>)
             </xsl:otherwise>          
             </xsl:choose>      
           </xsl:if>
		  </span>
		 </td></tr>
	    <tr><td>
		   <span class="fieldvaluedefault export">
		   <xsl:if test="genres!=''">
           <xsl:for-each select="genres/genre">
           <xsl:value-of select="displayname"/>
           <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
           </xsl:for-each>
	      </xsl:if>
			</span>
		 </td></tr>
	    <tr><td>
		   <div style="margin-top:5px;"><xsl:if test="collectionstatus !=''">
           <xsl:call-template name="collection_status">
           <xsl:with-param name="in_listid" select="collectionstatus/@listid"/>
           <xsl:with-param name="in_status" select="collectionstatus"/>
           </xsl:call-template>
         </xsl:if>
         <xsl:if test="index!='0'"><span id="indexvalue" class="export">#<xsl:value-of select="index"/></span></xsl:if></div>
		 </td></tr>
	    <tr><td>
		   <xsl:if test="myrating!=''">
           <div style="margin-top:3px;"><xsl:call-template name="star"><xsl:with-param name="num" select="myrating"/></xsl:call-template></div> 
         </xsl:if>
		 </td></tr>
	    <tr><td>
	     <table border="0" cellspacing="0" cellpadding="0">
		    <tr>
			  <td valign="top">
			   <div style="margin-top:4px;" class="export">
              <xsl:if test="$templatetype='view' and (links//*[urltype='Movie']!='')"><a href="http://playall.html"><img src="{$mybasepath}playthemovie.png" style="float:left;border:none;margin-right:7px;margin-top:6px;" /></a></xsl:if>	
				  <b style="font-weight:normal;"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfSeenIt']/@label"/></b>:&nbsp;
              <xsl:choose>
	             <xsl:when test="viewingdate/date!='' and seenwhere!=''">
	           	   <b><xsl:value-of select="seenit"/></b><br/>(<xsl:value-of select="viewingdate/date"/>&#160;<xsl:value-of select="seenwhere"/>)
	             </xsl:when>		
	             <xsl:when test="seenwhere!=''">
	               <b><xsl:value-of select="seenit"/></b><br/>(<xsl:value-of select="seenwhere"/>)
	             </xsl:when>			           
	             <xsl:when test="viewingdate/date!=''">
	               <b><xsl:value-of select="seenit"/></b><br/>(<xsl:value-of select="viewingdate/date"/>)
	             </xsl:when>	
	             <xsl:otherwise>	
	               <b><xsl:value-of select="seenit"/></b>
				    </xsl:otherwise>
              </xsl:choose>				
				<xsl:if test="upc!=''"><br /><b><xsl:value-of select="upc"/></b></xsl:if>
            </div>
				</td>
		      <td valign="top">
				<div style="float:right;margin-top:7px;margin-bottom:2px;margin-left:20px;">
				  <xsl:if test="imdbnum!='' and imdbnum!='0'">
                <span style="margin-top:0px;"><a href="{imdburl}"><xsl:call-template name="imdblink"/></a></span>
              </xsl:if>
			     <xsl:if test="imdbrating!='' and imdbrating!='0' and imdbrating!='0.0'">
		          <i style="font-size:12pt;" class="imdb" title="IMDb">&nbsp;<b><a href="{imdburl}" class="imdb"><xsl:value-of select="imdbrating"/></a></b></i>
              </xsl:if>
            </div>
			   </td>
				</tr></table>
	         <table border="0" cellspacing="0" cellpadding="0" width="100%">
				<tr><td>
			   <xsl:if test="runtimeminutes!=''"><b><xsl:value-of select="runtimeminutes"/>&nbsp;</b></xsl:if>
                <xsl:choose>
                    <xsl:when test="country/templateimage!='' and $templatetype!='exportdetails'"><img><xsl:attribute name="src"><xsl:value-of select="country/templateimage"/></xsl:attribute></img></xsl:when>
                    <xsl:otherwise>
				        <xsl:if test="country!=''"><xsl:value-of select="country/displayname"/></xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="language/templateimage!='' and $templatetype!='exportdetails' ">&nbsp;/&nbsp;<img><xsl:attribute name="src"><xsl:value-of select="language/templateimage"/></xsl:attribute></img></xsl:when>
                    <xsl:otherwise>
				        <xsl:if test="language!=''">&nbsp;/&nbsp;<xsl:value-of select="language/displayname"/></xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
		   </td>
		   </tr><tr>
		    <td colspan="2" style="padding-top:8px;">
   <xsl:if test="$templatetype!='exportdetails'">
				<xsl:choose>		
				  <xsl:when test="format/templateimage!=''">
				    <span style="margin-right:7px;">
				      <img><xsl:attribute name="src"><xsl:value-of select="format/templateimage"/></xsl:attribute></img>
				    </span>
				  </xsl:when>
				  <xsl:otherwise>
				    <xsl:value-of select="format/displayname"/>&nbsp;
				  </xsl:otherwise>
				</xsl:choose>	
  			   <xsl:for-each select="regions/region">
				  <xsl:choose>
				    <xsl:when test="templateimage!=''">
				       <span style="margin-right:7px;">
				         <img><xsl:attribute name="src"><xsl:value-of select="templateimage"/></xsl:attribute></img>
				       </span>
				    </xsl:when>
				    <xsl:otherwise>
				      <xsl:value-of select="displayname"/>
				        <xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>&nbsp;
				    </xsl:otherwise>
				  </xsl:choose>
		   	</xsl:for-each>
				<xsl:choose>		
				  <xsl:when test="mpaarating/templateimage!=''">
				    <span style="margin-right:7px;">
				      <img><xsl:attribute name="src"><xsl:value-of select="mpaarating/templateimage"/></xsl:attribute></img>
				    </span>
				  </xsl:when>
				  <xsl:otherwise>
				    <b><xsl:value-of select="mpaarating/displayname"/></b>
				  </xsl:otherwise>
				</xsl:choose>
     </xsl:if>
     <xsl:if test="$templatetype='exportdetails'">
       <span style="font-size:10pt;">
       <xsl:if test="format/displayname!=''">
		   <b><xsl:value-of select="format/displayname"/></b>&nbsp;
       </xsl:if>
       <xsl:if test="regions/region!=''">
  	      <xsl:for-each select="regions/region">
			  <xsl:value-of select="displayname"/>
			  <xsl:if test="position()!=last()"><xsl:text>,&nbsp;</xsl:text></xsl:if>
			</xsl:for-each> 
       </xsl:if>
       <xsl:if test="mpaarating/displayname!=''">
         &nbsp;<b><xsl:value-of select="mpaarating/displayname"/></b>
       </xsl:if>
       </span>
     </xsl:if>
			    </td></tr>
			  </table>
		   </td></tr> 
		 </table>
    </td>
    <td valign="top">
  <xsl:if test="coverback!=''">
    <div id="backcover">
      <xsl:call-template name="cover">
        <xsl:with-param name="in_viewhref">http://back.html</xsl:with-param>
        <xsl:with-param name="in_cover" select="coverback"/>
        <xsl:with-param name="in_id" select="id"/>
        <xsl:with-param name="in_postfix">b</xsl:with-param>
      </xsl:call-template>
    </div>
  </xsl:if> 
    </td>
  </tr>
</table>

  <div style="clear:both;">	

	 <span style="float:left;" class="opacity">
	 <xsl:if test="cast!=''">
      <table class="valuestable" border="0" cellspacing="1" cellpadding="0">
        <xsl:for-each select="cast/star">
          <tr>
            <td nowrap="1">
          	<xsl:choose>          		
				  		<xsl:when test="person/imageurl!=''">
                 <xsl:call-template name="personimagelink">
                   <xsl:with-param name="nameimglink" select="person/imageurl"/>
                 </xsl:call-template>
							</xsl:when>
          		<xsl:otherwise>
							<xsl:if test="person/templateimage!=''">
               <xsl:call-template name="personimagelink">
                 <xsl:with-param name="nameimglink" select="person/templateimage"/>
               </xsl:call-template>
		            </xsl:if>
                    <xsl:if test="person/templateimage=''and $templatetype='view'">
					  <img class="actorheadshot" src="{$mybasepath}actorhead.png" border="0"/>
		            </xsl:if>		            
		          </xsl:otherwise>
		        </xsl:choose>							             
            </td>
            <td class="castactor" nowrap="1">
				  <xsl:apply-templates select="person"/>
				</td>
            <td class="castcharacter">
				  <xsl:if test="character!=''"><xsl:value-of select="character"/></xsl:if>
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </xsl:if>
	 </span>

	 <span style="float:left;margin-left:25px;" class="opacity">
	 <xsl:if test="crew!=''">
      <table class="person-list crew">
      	<xsl:call-template name="personimages"><xsl:with-param name="roleid">dfDirector</xsl:with-param></xsl:call-template>        
        <xsl:call-template name="crewrole"><xsl:with-param name="roleid">dfProducer</xsl:with-param></xsl:call-template>
        <xsl:call-template name="crewrole"><xsl:with-param name="roleid">dfWriter</xsl:with-param></xsl:call-template>
        <xsl:call-template name="crewrole"><xsl:with-param name="roleid">dfCamera</xsl:with-param></xsl:call-template>
        <xsl:call-template name="crewrole"><xsl:with-param name="roleid">dfMusic</xsl:with-param></xsl:call-template>
        <xsl:call-template name="crewrole"><xsl:with-param name="roleid">dfUserCredit1</xsl:with-param></xsl:call-template>
        <xsl:call-template name="crewrole"><xsl:with-param name="roleid">dfUserCredit2</xsl:with-param></xsl:call-template>
      </table>
     </xsl:if>
	 </span>
</div>

<div style="clear:both;">
<span style="float:left;">
  <xsl:if test="$templatetype='view'">
    <xsl:if test="links!=''">
    <xsl:if test="links//*[urltype='Trailer URL']!=''">    
      <div style="float:left;margin-top:2px;width:305px;margin-right:5px;" id="trailers">            
	     <xsl:for-each select="links//*[urltype='Trailer URL']"><p/>	     
		    <xsl:call-template name="trailer">        
		      <xsl:with-param name="in_url" select="url"/>
					<xsl:with-param name="width" select="300"/>		      
					<xsl:with-param name="height" select="200"/>		      
		    </xsl:call-template>
		  </xsl:for-each> 
      </div>
    </xsl:if>
    </xsl:if>
    </xsl:if>
 </span>

<xsl:if test="$templatetype='view'">
 <xsl:if test="plot!=''"><br/>
   <div style="font-size:130%;text-align:justify;margin-bottom:10px;" class="opacity marginbackdrop">
     <xsl:call-template name="break"><xsl:with-param name="text" select="plot"/></xsl:call-template>    
   </div>
 </xsl:if>
</xsl:if>

<xsl:if test="$templatetype='print'">
 <xsl:if test="plot!=''"><br/>
   <div style="font-size:8pt;text-align:justify;margin-bottom:10px;" class="opacity marginbackdrop">
     <xsl:call-template name="break"><xsl:with-param name="text" select="plot"/></xsl:call-template>    
   </div>
 </xsl:if>
</xsl:if>

<xsl:if test="$templatetype='exportdetails'">
<table>
  <tr>
    <td valign="top"><xsl:if test="links!=''">
  <xsl:if test="links//*[urltype='Trailer URL']!=''">
    <div style="margin-top:2px;width:305px;margin-right:5px;" id="trailers">
	   <xsl:for-each select="links//*[urltype='Trailer URL']"><p/>
		  <xsl:call-template name="trailer">        
				<xsl:with-param name="width" select="300"/>		      
				<xsl:with-param name="height" select="200"/>			  
		    <xsl:with-param name="in_url" select="url"/>
		  </xsl:call-template>
		</xsl:for-each> 
    </div>
  </xsl:if>
  </xsl:if></td>
    <td valign="top"><xsl:if test="plot!=''">
      <div style="margin-top:2px;font-size:10pt;text-align:justify;">
      <br/><xsl:call-template name="break"><xsl:with-param name="text" select="plot"/></xsl:call-template>    
	 </div>
  </xsl:if></td>
  </tr>
</table>
</xsl:if>
</div>

   <div style="clear:both;">	
    <xsl:if test="count(discs/disc/episodes/episode) > 0">
      <xsl:variable name="episodecount">
        <xsl:value-of select="count(discs/disc/episodes/episode)"/>
      </xsl:variable>
      <div id="episodes">
        <div class="header opacity"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttEpisodeDetails']/@label"/></div>
		  <xsl:for-each select="discs/disc">
          <xsl:if test="count(episodes/episode) > 0">
              <table border="0" cellspacing="0" cellpadding="0" class="episodetitle opacity" style="width=100%">
              <tr><td colspan="2">
				<xsl:if test="count(episodes/episode)!=$episodecount">
              <b><i><xsl:value-of select="title"/></i></b>
            </xsl:if>
				 </td></tr>
				<xsl:for-each select="episodes/episode">
			       <tr>
					   <td valign="top" colspan="2" class="episodeborder">
 <!-- view and export -->   <xsl:if test="$templatetype!='print'">
						  <span style="float:right;">
	             <xsl:choose>
						    <xsl:when test="seenit/@boolvalue='1'">
							    <xsl:choose>
							    	<xsl:when test="$templatetype!='exportdetails'">
							      	&nbsp;&nbsp;<img src="{$mybasepath}seenyes.png" border="none" title="Seen it: Yes"/>&nbsp;
							      </xsl:when>
							      <xsl:otherwise>
							      	&nbsp;&nbsp;&nbsp;&nbsp;Seen it: Yes&nbsp;
							      </xsl:otherwise>
							    </xsl:choose>
								<xsl:if test="viewingdate/date!=''">
								  &nbsp;<i><xsl:value-of select="viewingdate/date"/></i>
								</xsl:if>
								<xsl:if test="seenwhere!=''">								
								  <i>&nbsp;@&nbsp;<xsl:value-of select="seenwhere"/></i>&nbsp;
								</xsl:if>
						    </xsl:when>
							 <xsl:otherwise>
							 </xsl:otherwise>
		              </xsl:choose>						  
						    <xsl:if test="runtime!=''">
							   &nbsp;<xsl:value-of select="runtime"/>&nbsp;
							 </xsl:if>
						    <xsl:if test="firstairdate/date!=''">
							   &nbsp;<b><xsl:value-of select="firstairdate/date"/></b>&nbsp;
							 </xsl:if> 
						    <xsl:if test="$templatetype='view'">
							   <xsl:if test="imdburl!=''">
							     &nbsp;<a><xsl:attribute name="href"><xsl:value-of select="imdburl"/></xsl:attribute><img src="{$mybasepath}imdbepisode.png" border="none"/></a>&nbsp;
							   </xsl:if>
							 </xsl:if>
						    <xsl:if test="$templatetype!='exportdetails'">
							   <xsl:if test="movielink!=''">	
                          &nbsp;<a href="http://playepisode_{movielink}.html" class="link">
							       <img src="{$mybasepath}playepisode.png" border="none" title="Play Episode"/>
                          </a>&nbsp;
                        </xsl:if>
                      </xsl:if>
                    </span>
						  <b class="episodestitle"><xsl:value-of select="sequencenumber"/>.</b>&nbsp;
						  <xsl:choose>
                      <xsl:when test="link!=''">
								<a class="episodefont"><xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute><b class="episodestitle"><xsl:value-of select="title"/></b></a>
                      </xsl:when>
                      <xsl:otherwise>
                        <b class="episodestitle"><xsl:value-of select="title"/></b>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:if>
 <!-- print -->   <xsl:if test="$templatetype='print'">
					    <b class="episodestitle"><xsl:value-of select="sequencenumber"/>.</b>&nbsp;
                   <b class="episodestitle"><xsl:value-of select="title"/></b>
						    <xsl:if test="runtime!=''">
							   &nbsp;&nbsp;<xsl:value-of select="runtime"/>&nbsp;
							 </xsl:if>
						    <xsl:if test="firstairdate/date!=''">
							   &nbsp;<b><xsl:value-of select="firstairdate/date"/></b>&nbsp;
							 </xsl:if> 
		              <xsl:choose>
						    <xsl:when test="seenit/@boolvalue='1'">
						      &nbsp;&nbsp;Seen it: Yes
						    </xsl:when>
							 <xsl:otherwise>
							 </xsl:otherwise>
		              </xsl:choose>						  			 
                  </xsl:if>
						</td>
					 </tr>
					 <tr>
                <xsl:if test="$templatetype!='exportdetails'">
		            <td valign="top" style="float:left;">				
							<xsl:if test="image!=''">
		                 <xsl:call-template name="imagelinkep">
		                   <xsl:with-param name="nameimglink" select="image"/>
		                 </xsl:call-template>
		               </xsl:if>
					   </td>
                 </xsl:if>
                 <xsl:if test="$templatetype='exportdetails'">					  
                   <td>
						 <xsl:if test="image">
                     <img><xsl:attribute name="src"><xsl:value-of select="image"/></xsl:attribute></img>
                   </xsl:if>
						 </td>
                 </xsl:if>
						<td valign="top" style="padding-left:8px;">
						  <xsl:if test="plot!=''"><div style="margin-top:5px;text-align:justify;" class="plot"><xsl:apply-templates select="plot"/></div></xsl:if>
						 <xsl:if test="crew!='' or cast!=''">
						  <div style="xmargin-top:3px;">
							 <table border="0" cellspacing="0" cellpadding="0">
							 <xsl:if test="crew!=''">
							 <tr><td class="export" style="padding-top:4px;padding-bottom:4px;">
                        <span class="episodecredits"><xsl:call-template name="crewrole2"><xsl:with-param name="roleid">dfDirector</xsl:with-param></xsl:call-template>
                        <xsl:call-template name="crewrole2"><xsl:with-param name="roleid">dfWriter</xsl:with-param></xsl:call-template></span>
                      </td></tr>
                      </xsl:if>
						    <xsl:if test="cast!=''">
							 <tr><td class="export" style="padding-top:4px;padding-bottom:4px;">
							   <span class="episodecredits"><b>Guest starring:</b>&nbsp;
                        <xsl:for-each select="cast/star"><xsl:apply-templates select="person"/><xsl:if test="position()!=last()"><xsl:text>,&nbsp;</xsl:text></xsl:if></xsl:for-each></span>
                      </td></tr>
						    </xsl:if>
                      </table>
						  </div>
						 </xsl:if>
						  </td>
			       </tr>
            </xsl:for-each>	
		        </table>	 	
          </xsl:if>
        </xsl:for-each>
      </div>
    </xsl:if>
   </div>

  <div style="clear:both;">
    <table class="details opacity" width="100%" style="margin-top:3px;" border="0"><tr>
    <td valign="top" width="50%">
    <div id="editiondetails" class="marginbackdrop">
      <table  class="valuestable" border="0" cellspacing="0" cellpadding="0">
       <tr><td class="header" colspan="2"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttProductDetails']/@label"/></td></tr>
      <xsl:if test="edition!=''">
         <tr valign="top">
           <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfEdition']/@label"/></td>
           <td class="fieldvalue"><xsl:value-of select="edition/displayname"/></td>
         </tr>
      </xsl:if>
	   <xsl:if test="originaltitle!=''">
         <tr valign="top">
           <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfOriginalTitle']/@label"/></td>
           <td class="fieldvalue"><xsl:value-of select="originaltitle"/></td>
         </tr>
      </xsl:if>			
		<xsl:if test="series!=''">
          <tr valign="top">
            <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfSeries']/@label"/></td>
            <td class="fieldvalue"><xsl:value-of select="series/displayname"/></td>
          </tr>
      </xsl:if>
      <xsl:if test="distributor!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfDistributor']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="distributor/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="chapters!='' and chapters!='0'">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfChapters']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="chapters"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="dvdreleasedate!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfDVDReleaseDate']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="dvdreleasedate/date"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="package!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfPackage']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="package/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="ratios/ratio!=''">
        <tr valign="top">
          <td class="fieldlabel" nowrap="1">
            <xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfRatio']/@label"/>
          </td>
          <td class="fieldvalue">
             <xsl:for-each select="ratios/ratio">
               <xsl:value-of select="displayname"/>
               <xsl:if test="position()!=last()"><br/></xsl:if>
             </xsl:for-each>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="subtitles/subtitle!=''">
        <tr valign="top">
          <td class="fieldlabel" nowrap="1">
            <xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfSubtitles']/@label"/>
          </td>
          <td class="fieldvalue">
             <xsl:for-each select="subtitles/subtitle">
               <xsl:value-of select="displayname"/>
               <xsl:if test="position()!=last()"><xsl:text>; </xsl:text></xsl:if>
             </xsl:for-each>
          </td>
        </tr>
      </xsl:if>      
      <xsl:if test="$templatetype!='exportdetails'">
		<xsl:if test="audios/audio!=''">
        <tr valign="top">
          <td class="fieldlabel" nowrap="1">
            <xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfAudio']/@label"/>
          </td>
          <td class="fieldvalue">
  			   <xsl:for-each select="audios/audio">
				  <xsl:choose>
				    <xsl:when test="templateimage!=''">
 	 			      <img><xsl:attribute name="src"><xsl:value-of select="templateimage"/></xsl:attribute></img>
                  &nbsp;<xsl:value-of select="displayname"/><br/>
				    </xsl:when>
				    <xsl:otherwise>
				      <xsl:value-of select="displayname"/><br/>
				    </xsl:otherwise>
				  </xsl:choose>
		   	</xsl:for-each>
          </td>
        </tr>
      </xsl:if>
      </xsl:if>
      <xsl:if test="$templatetype='exportdetails'">
		<xsl:if test="audios/audio!=''">
        <tr valign="top">
          <td class="fieldlabel" nowrap="1">
            <xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfAudio']/@label"/>
          </td>
          <td class="fieldvalue">
  			   <xsl:for-each select="audios/audio">
				  <xsl:value-of select="displayname"/><br/>
		   	</xsl:for-each>
          </td>
        </tr>
      </xsl:if>		
      </xsl:if>		
      <xsl:if test="layersnum!='' and layersnum!='4'">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfLayers']/@label" /></td>
          <td class="fieldvalue"><xsl:value-of select="layers" /></td>
         </tr>
      </xsl:if>
      <xsl:if test="nritems!=''">
        <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfNrItems']/@label" /></td>
          <td class="fieldvalue"><xsl:value-of select="nritems"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="extras!=''">
         <tr valign="top">
            <td nowrap="1" class="fieldlabel">
              <xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfExtras']/@label"/>
            </td>
            <td class="fieldvalue">
               <xsl:for-each select="extras/extra">
                 <xsl:value-of select="displayname"/>
                 <xsl:if test="position()!=last()"><xsl:text>; </xsl:text></xsl:if>
               </xsl:for-each>
            </td>
         </tr>
     </xsl:if>
     </table>
   </div>	
 </td>
 <td valign="top" width="50%">
   <div id="personaldetails" class="marginbackdrop">
      <table class="valuestable" border="0" cellspacing="0" cellpadding="0">
       <tr><td class="header" colspan="2"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttPersonalDetails']/@label"/></td></tr>
      <xsl:if test="purchasedate!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfPurchaseDate']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="purchasedate/date"/></td>
         </tr>
      </xsl:if>
		<xsl:if test="loan/loanedto!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfLoaner']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="loan/loanedto/displayname"/>&#160;@&#160;<xsl:value-of select="loan/loandate/date"/></td>
         </tr>
      </xsl:if>
		<xsl:if test="location!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfLocation']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="location/displayname"/></td>
         </tr>
      </xsl:if>
		<xsl:if test="owner!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfOwner']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="owner/displayname"/></td>
         </tr>
      </xsl:if>		
		<xsl:if test="store!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfStore']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="store/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="purchaseprice!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfPurchasePrice']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="purchaseprice"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="condition!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfCondition']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="condition/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="currentvalue!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfCurrentValue']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="currentvalue"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="quantity>'1'">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfQuantity']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="quantity"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="tapelabel!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfTapeLabel']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="tapelabel/displayname"/></td>
         </tr>
      </xsl:if>      
      <xsl:if test="tapespeed/@listid!='0'">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfTapeSpeed']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="tapespeed"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="startpos!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfStartPos']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="startpos"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="tags!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfTag']/@label"/></td>
          <td class="fieldvalue"><xsl:for-each select="tags/tag">
             <xsl:value-of select="displayname"/>
             <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
           </xsl:for-each></td>
         </tr>
      </xsl:if>
      <xsl:if test="userlookup1!=''"> 
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfUserLookup1']/@label"/></td>
          <td class="fieldvalue"><xsl:apply-templates select="userlookup1"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="userlookup2!=''"> 
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfUserLookup2']/@label"/></td>
          <td class="fieldvalue"><xsl:apply-templates select="userlookup2"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="usertext1!=''"> 
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfUserText1']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="usertext1"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="usertext2!=''"> 
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfUserText2']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="usertext2"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="links!=''">
        <xsl:if test="links//*[urltype='URL']!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfLinks']/@label"/></td>
          <td class="fieldvalue">
            <xsl:apply-templates select="links//*[urltype='URL']"/>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="links//*[urltype='Trailer']!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1">Trailer Links</td>
          <td class="fieldvalue">
            <xsl:apply-templates select="links//*[urltype='Trailer']"/>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="$absolutelinks = 'true'">
        <xsl:if test="(links//*[urltype='Movie']!='')">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfMovieLinks']/@label"/></td>
          <td class="fieldvalue">
            <xsl:apply-templates select="(links//*[urltype='Movie'])"/>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="(links//*[urltype='Other']!='')">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfOtherLinks']/@label"/></td>
          <td class="fieldvalue">
            <xsl:apply-templates select="(links//*[urltype='Other'])"/>
          </td>
         </tr>
        </xsl:if>
        </xsl:if>	  
      </xsl:if>	
      <xsl:if test="count(discs/disc/storageslot) > 0 or count(discs/disc/storagedevice) > 0">
        <xsl:for-each select="discs/disc">
          <xsl:if test="storageslot!='' or storagedevice/displayname!=''">
            <xsl:if test="position()=1">   
              <tr><td class="header" colspan="2"><br/><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfStorageDevice']/@label"/></td></tr>          
            </xsl:if>
            <tr valign="top">
              <td class="fieldlabel" nowrap="1"><xsl:value-of select="title"/></td>
              <td class="fieldvalue"><xsl:value-of select="storagedevice/displayname"/>:&#160;<xsl:value-of select="storageslot"/></td>
            </tr>
          </xsl:if>
        </xsl:for-each>
     </xsl:if>
     </table>
   </div>
  </td></tr>
  <tr><td colspan="2">

     <xsl:if test="count(discs/disc/features/feature) > 0 or count(discs/disc/extrafeatures) > 0">
       <div id="features" class="marginbackdrop">
         <p/>
         <div class="header extraheaderfeat"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfFeatures']/@label"/></div>
           <table class="valuestable" border="0" cellspacing="0" cellpadding="0">
           <xsl:for-each select="discs/disc">
             <xsl:if test="features!='' or extrafeatures!=''">
               <tr valign="top">
                 <xsl:if test="count(../disc) > 1">
                   <td class="fieldlabel" style="white-space:nowrap;"><xsl:value-of select="title"/></td>
                 </xsl:if>
                 <td class="fieldvalue">
                 <xsl:if test="features/feature!=''">
                   <xsl:for-each select="features/feature">
                     <xsl:value-of select="displayname"/><br/>
                   </xsl:for-each>
                 </xsl:if>
                 </td>
                 <td class="fieldvalue">
                 <xsl:if test="extrafeatures!=''">
						 <xsl:call-template name="break">
                     <xsl:with-param name="text" select="extrafeatures"/>
                   </xsl:call-template>
                 </xsl:if>
                 </td>
               </tr>
             </xsl:if>
           </xsl:for-each>
         </table>
       </div>
    </xsl:if>
  
  </td></tr>
</table>

<div style="float:left;margin-right:5px;margin-top:5px;">
  <xsl:if test="$absolutelinks = 'true'">
    <xsl:if test="links!=''">
      <xsl:if test="links//*[urltype='Image']!=''">
      <div id="imagefiles">
        <div class="header opacity" style="font-size:10pt;"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttImageLinkDetails']/@label"/></div>
          <xsl:for-each select="links//*[urltype='Image']">
            <xsl:call-template name="imagelink">
              <xsl:with-param name="in_viewhref">http://image.html</xsl:with-param>
              <xsl:with-param name="in_url" select="url"/>
            </xsl:call-template>
          </xsl:for-each>
      </div>
      </xsl:if>
      </xsl:if>
    </xsl:if>
</div>
<xsl:if test="$templatetype!='exportdetails'">
<xsl:if test="poster!=''">
  <div style="float:left;margin-right:5px;margin-top:5px;">
    <div class="header opacity" style="font-size:10pt;">Movie Poster</div>
		<xsl:if test="poster!=''">
		  <xsl:call-template name="backdropposter">
		    <xsl:with-param name="nameimg" select="poster"/>
		  </xsl:call-template>
		</xsl:if>
  </div>
</xsl:if>
<xsl:if test="backdropurl!=''">
  <div style="float:left;margin-right:5px;margin-top:5px;">
    <div class="header opacity" style="font-size:10pt;">Backdrop</div>	
		  <xsl:call-template name="backdropposter">
		    <xsl:with-param name="nameimg" select="backdropurl"/>
		  </xsl:call-template>
  </div>
</xsl:if>
</xsl:if>

<xsl:if test="notes!=''">
      <br/>
    <div id="notes" class="opacity" style="text-align:justify;">
      <div class="header extraheader"><xsl:value-of select="/movieinfo/moviemetadata/field[@id='dfNotes']/@label"/></div>
      <xsl:call-template name="break">
        <xsl:with-param name="text" select="notes"/>
      </xsl:call-template>
    </div>
  </xsl:if>
  </div>	
<xsl:if test="position()!=last()">
  <p style="page-break-before: always">&nbsp;</p>
</xsl:if>  
</xsl:template>

<xsl:template match="navigation">
  <div align="center">
  <div class="navigation" align="center">
    <div class="navigationline">
      <xsl:choose>
        <xsl:when test="firstlink/@url!=''">
          <div class="navlink" id="first"><a href="{firstlink/@url}"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttFirst']/@label"/></a></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="navlink" id="first"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttFirst']/@label"/></div>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="prevlink/@url!=''">
          <div class="navlink" id="prev"><a href="{prevlink/@url}"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttPrev']/@label"/></a></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="navlink" id="prev"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttPrev']/@label"/></div>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="uplink/@url!=''">
          <div class="navlink" id="up"><a href="{uplink/@url}"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttUp']/@label"/></a></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="navlink" id="up"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttUp']/@label"/></div>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="nextlink/@url!=''">
          <div class="navlink" id="next"><a href="{nextlink/@url}"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttNext']/@label"/></a></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="navlink" id="next"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttNext']/@label"/></div>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="lastlink/@url!=''">
          <div class="navlink" id="last"><a href="{lastlink/@url}"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttLast']/@label"/></a></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="navlink" id="last"><xsl:value-of select="/movieinfo/localizedtemplatetexts/field[@id='ttLast']/@label"/></div>
        </xsl:otherwise>
      </xsl:choose>   
    </div>
  </div>
  </div>
</xsl:template>

</xsl:stylesheet>
