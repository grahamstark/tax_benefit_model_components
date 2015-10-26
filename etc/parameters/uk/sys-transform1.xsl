<?xml version="1.0" encoding="UTF-8"?>
<!-- bbc-ve-output.xsl -->
<!-- output for bbc election service, modelled on JNP's budget one -->
<!-- this version GKS 2/5/2001 -->
<!-- RCS
   $Log: election-output.xsl,v $
   Revision 1.1.1.1  2001/08/10 14:27:16  graham_s
   re-import 10th aug 01

    made /images -> images
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="iso-8859-1" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:include href="header.html" />

  <!-- Top-level rule -->
  <!-- ============== -->
  <!-- Top-level rule -->
  <!-- ============== -->
  <xsl:template match="/">
  <html>
   <xsl:call-template name="header">
    <xsl:with-param name="title" select="''" />
    <xsl:with-param name="subject" select="''" />
    <xsl:with-param name="Description" select="''" />
    <xsl:with-param name="author" select="'XX'" />
  </xsl:call-template>
  
  <body>  
  
      <xsl:message terminate="no">Main rule <xsl:value-of select="//ParameterSet/@instanceName"/></xsl:message>
        <table class='XX'>
        <tr><td>
        <xsl:call-template name="main">
          <xsl:with-param name="sys" select="//ParameterSystem"/>
        </xsl:call-template>
        </td></tr></table>
      </body>
     </html>   
  </xsl:template>
  
  
  <xsl:template name="print_parameter">
        <xsl:param name="class"/>
        <xsl:param name="Parameter" />
        <xsl:param name="values" />
        <tr class="{$class}">
                
                <td width="100"><xsl:value-of select="$Parameter/@name"/></td>
                <td width="500"><xsl:value-of select="$Parameter/Description/text()"/></td>
        </tr>
        <tr class="$class" >
                <td colspan="2" align="right">
                        <table class="{$class}">
                                <tr class="{$class}"><th>Date</th><th>Why</th><th>value</th></tr>
                                <xsl:for-each select="$values/History/Event" >
                                     <xsl:sort select="@date"/>
                                        <tr class="output-number" align="right">
                                                <td>
                                                        <xsl:value-of select="@date"/>
                                                </td>
                                                <td>
                                                        <xsl:value-of select="Description/text()"/>
                                                        <xsl:for-each select="OneVal">
                                                                <xsl:value-of select="@val"/>,
                                                        </xsl:for-each>
                                                </td>
                                        </tr>
                                     
                                </xsl:for-each>
                        </table>
                </td>
        </tr>      
  </xsl:template>
  
  <xsl:template name="indexedGroup">
     <xsl:param name="param" />
     <xsl:param name="values" />
     <table class="highlight-med">
     	<xsl:for-each select="$values/History/Event">
	   <table class="highlight">
	   <tr>
	   	<th><xsl:value-of select="Description/p/text()"/></th>
	   </tr>
	   <xsl:for-each select="Values/OneVal">
		<xsl:variable name="class">
			<xsl:choose>
			        <xsl:when test="(position() mod 2) = 0">highlight-med</xsl:when>
				<xsl:otherwise>highlight</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<tr class="{$class}">
			<td><xsl:value-of select="@index"/></td>
			<td><xsl:value-of select="@val"/></td>
		</tr>
	   </xsl:for-each>
	   </table>
	</xsl:for-each>
     </table>
  </xsl:template>
  
  <xsl:template name="onearraycol">
        <xsl:param name="group"/>
        <xsl:param name="class" />
        <xsl:param name="values" />
        <xsl:for-each select="$group/Parameter">
        <tr class="{$class}">
                
                <td width="100"><xsl:value-of select="@name"/></td>
                <td width="500"><xsl:value-of select="Description/text()"/></td>
        </tr>
        </xsl:for-each>
        <tr class="$class" >
        <xsl:for-each select="$group/Parameter">
                <xsl:variable name="instanceName" select="@instanceName" />
                   <xsl:message terminate="no">instancename=<xsl:value-of select="$instanceName"/></xsl:message>
                   <xsl:for-each select="$values/ParameterValue">
                       <xsl:message terminate="no">values=<xsl:value-of select="@instanceName"/></xsl:message>
                   </xsl:for-each>
                <xsl:variable name="arrayValues" select="$values/ParameterValue[@instanceName=$instanceName]" />
                <td colspan="2" align="right">
                        <table class="{$class}">
                                <tr class="{$class}"><th>Date</th><th>Why</th><th>value</th></tr>
                                <xsl:for-each select="$arrayValues/History/Event" >
                                   <xsl:message terminate="no">event=<xsl:value-of select="."/></xsl:message>
 
                                     <xsl:sort select="@date"/>
                                        <tr class="output-number" align="right">
                                                <td>
                                                        <xsl:value-of select="@date"/>
                                                </td>
                                                <td>
                                                        <xsl:value-of select="Description/text()"/>
                                                </td>
                                                </tr>
                                         <tr class="output-number" align="right">
                                                 <td colspan="2">
                                                        <table>
                                                        <xsl:for-each select="Values/OneVal">
                                                            <tr class="output-number" >
                                                                <td>
                                                                <xsl:value-of select="@index" />
                                                                </td>
                                                                <td>
                                                                <xsl:value-of select="@val"/>
                                                                </td></tr>
                                                        </xsl:for-each>
                                                        </table>
                                                </td>
                                        </tr>
                                     
                                </xsl:for-each>
                        </table>
                </td>
        </xsl:for-each>
        </tr>
  </xsl:template>
  
  <xsl:template name="main">
    <xsl:param name="sys"/>
    <xsl:param name="values" />
    <!--
    <xsl:message terminate="no">values<xsl:value-of select="$values"/></xsl:message>
    -->
    <table cellspacing="0" cellpadding="6">
    
    <tr>
       <th colspan="2"><xsl:value-of select="$sys/@name"/></th>
    </tr>
    
    <xsl:for-each select="$sys/Parameter">
        <xsl:variable name="indexName" select="@indexName" /> 
	<xsl:variable name="instanceName" select="@instanceName" />
        <xsl:call-template name="print_parameter">
                <xsl:with-param name="Parameter" select="." />
                <xsl:with-param name="values" se0-lect="$values/ParameterValue[@instanceName=$instanceName]" />
                <xsl:with-param name="class" select="'highlight-med'" />
        </xsl:call-template>
    </xsl:for-each>
    
        <xsl:for-each select="$sys/ParameterSystem">
           <xsl:variable name="thistype" select="@type" />
           <xsl:message terminate="no">thistype=<xsl:value-of select="$thistype"/></xsl:message>
 
                 <tr class="highlight-med">
                         <td width="40">&#160;</td>
                         <td colspan="2" align="right" border="1">
                          <xsl:call-template name="main">
                            <xsl:with-param name="sys" select="."/>
                            <xsl:with-param name="values" select="//*/ParameterSystemValues[ @type = $thistype ]"/>
                         </xsl:call-template>
                      </td>
                    </tr>
        </xsl:for-each>
	
	
     </table>
  </xsl:template>
</xsl:stylesheet>

