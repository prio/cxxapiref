<?xml version="1.0" encoding="UTF-8" ?>
<!--
 (C) Copyright Nokia Corporation and/or its subsidiary(-ies) 2009 - 2011. All rights reserved.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dita2html="http://dita-ot.sourceforge.net/ns/200801/dita2html"
                version="1.0"
                exclude-result-prefixes="dita2html">

  <xsl:include href="utilities.xsl"/>

  <xsl:strip-space elements="cxxFunctionParameterDeclaredType"/>
  
  <!-- Styling -->
  <!-- ===================================================================== -->

  <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="gen-user-styles">
    <link rel="stylesheet" type="text/css" href="{$PATH2PROJ}{$CSSPATH}nokiacxxref.css"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' apiRef/apiRef ')]" mode="gen-user-head">
    <meta name="keywords" content="api"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' cxxClass/cxxClass ') or
                          contains(@class, ' cxxStruct/cxxStruct ') or
                          contains(@class, ' cxxUnion/cxxUnion ')]//
                          *[contains(@class, ' topic/link ')][@role='parent']" priority="2000"/>
  <xsl:template match="*[contains(@class,' cxxClass/cxxClass ') or
                          contains(@class, ' cxxStruct/cxxStruct ') or
                          contains(@class, ' cxxUnion/cxxUnion ')]//
                          *[contains(@class, ' topic/link ')]
                           [@role='child' or @role='descendant']" priority="2000"/>

  <!-- Common API reference overrides -->
  <!-- ===================================================================== -->

  <xsl:template match="*[contains(@class,' topic/shortdesc ')]" mode="section-fmt">
    <xsl:if test="node()">
      <div class="section">
        <xsl:call-template name="start-revflag"/>      
        <p><xsl:apply-templates select="node()"/></p>
        <xsl:call-template name="end-revflag"/>
      </div>
    </xsl:if>
  </xsl:template> 

  <!-- Member API description -->  
  <xsl:template match="*[contains(@class,' apiRef/apiDesc ')]" mode="get-output-class">
    <xsl:text>section apidesc</xsl:text>    
  </xsl:template>  
  <!-- Remove title from apiDesc -->   
  <xsl:template match="*[contains(@class,' apiRef/apiDesc ')]" mode="section-fmt">    
      <xsl:call-template name="start-revflag"/>  
	     <!--
	     <xsl:apply-templates select="." mode="sectionTitle">
	       <xsl:with-param name="titleType" select="$titleType"/>
	     </xsl:apply-templates>
	     -->	 
	    <xsl:if test="node()">
          <xsl:apply-templates select="node()[not(contains(@class,' topic/title ')) and not(@otherprops='linkagainst')]"/>        
        </xsl:if>
      <xsl:call-template name="end-revflag"/>      
  </xsl:template>
  
  <!--  Class/Struct/Union/File API description -->
  <xsl:template match="*[contains(@class,' cxxClass/cxxClassDetail ') or
                          contains(@class, ' cxxStruct/cxxStructDetail ') or
                          contains(@class, ' cxxFile/cxxFileDetail ') or
                          contains(@class, ' cxxUnion/cxxUnionDetail ')]/*[contains(@class,' apiRef/apiDesc ')]">
        <xsl:call-template name="topic.section"/>     
  </xsl:template>
  <xsl:template match="*[contains(@class,' cxxClass/cxxClassDetail ') or
                          contains(@class, ' cxxStruct/cxxStructDetail ') or
                          contains(@class, ' cxxFile/cxxFileDetail ') or
                          contains(@class, ' cxxUnion/cxxUnionDetail ')]/*[contains(@class,' apiRef/apiDesc ')]" mode="get-output-class">
    <xsl:text>section apidesc</xsl:text>    
  </xsl:template>
  <xsl:template match="*[contains(@class,' cxxClass/cxxClassDetail ') or
                          contains(@class, ' cxxStruct/cxxStructDetail ') or
                          contains(@class, ' cxxFile/cxxFileDetail ') or
                          contains(@class, ' cxxUnion/cxxUnionDetail ')]/*[contains(@class,' apiRef/apiDesc ')]" mode="section-fmt">    
      <xsl:call-template name="start-revflag"/>
	    <xsl:if test="exists(*[not(contains(@otherprops,'linkagainst'))])">
	      <xsl:call-template name="sect-heading">
      		<xsl:with-param name="defaulttitle">Detailed Description</xsl:with-param>
    	  </xsl:call-template>
          <xsl:apply-templates select="node()[not(contains(@class,' topic/title ')) and not(@otherprops='linkagainst')]"/>        
        </xsl:if>
      <xsl:call-template name="end-revflag"/>      
  </xsl:template>     
    
  <!-- Link Against -->
  <xsl:template match="*[contains(@class,' apiRef/apiDesc ')]/p[@otherprops='linkagainst']">
    <xsl:if test="string-length(node()) > 0">
        <!-- topic.section is defined in the base dita ot xslt. 
             It creates a div with class text given by the match on this node in get-output-class mode (see below)
             It also applies templates on this node in mode section-fmt (also see below)
        -->
        <xsl:call-template name="topic.section"/>
    </xsl:if>     
  </xsl:template>
  <xsl:template match="*[contains(@class,' apiRef/apiDesc ')]/p[@otherprops='linkagainst']" mode="get-output-class">
    <xsl:text>section linkagainst</xsl:text>    
  </xsl:template>
  <xsl:template match="*[contains(@class,' apiRef/apiDesc ')]/p[@otherprops='linkagainst']" mode="section-fmt">
	  <xsl:variable name="flagrules">
	    <xsl:call-template name="getrules"/>
	  </xsl:variable>
	  <xsl:call-template name="start-revflag">
	    <xsl:with-param name="flagrules" select="$flagrules"/>  
	  </xsl:call-template>
	  <p>Link against: <xsl:apply-templates select="*[not(contains(@class,' topic/title '))] | text() | comment() | processing-instruction()"/></p>
	  <xsl:call-template name="end-revflag">
	    <xsl:with-param name="flagrules" select="$flagrules"/>  
	  </xsl:call-template>    
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' apiRef/apiDesc ')]/p[simpletable]" mode="retval">
        <!-- topic.section is defined in the base dita ot xslt. 
             It creates a div with class text given by the match on this node in get-output-class mode (see below)
             It also applies templates on this node in mode section-fmt (also see below)
        -->
        <xsl:call-template name="topic.section"/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' apiRef/apiDesc ')]/p[simpletable]" mode="section-fmt">
        <!-- topic.section is defined in the base dita ot xslt. 
             It creates a div with class text given by the match on this node in get-output-class mode (see below)
             It also applies templates on this node in mode section-fmt (also see below)
        -->
        <xsl:apply-templates select="simpletable[@class='retval']" mode="retval"/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' apiRef/apiDesc ')]/p[simpletable]" mode="get-output-class">
    <xsl:text>section retval</xsl:text>    
  </xsl:template>
  
  <xsl:template match="simpletable[@class='retval']" mode="retval">
    <h4 class="sectiontitle">Return Values</h4>
      <table class="retvals">
<!--
      <thead>
          <tr>
            <th colspan="2">
              <xsl:value-of select="'Return Values'"/>
            </th>
          </tr>
        </thead>
        -->
        <tbody>
          <xsl:apply-templates select="strow" mode="retval">
            <xsl:sort select="stentry[1]"/>
          </xsl:apply-templates>
        </tbody>
      </table>
  </xsl:template>
  
  <!-- empty when no mode is applied so it doesn't output a table when apply templates is done on apiDesc-->
  <xsl:template match="simpletable[@class='retval']">
  </xsl:template>
  
  <xsl:template match="simpletable[@class='retval']/strow" mode="retval">
      <tr>
        <td class="retval"><xsl:value-of select="stentry[1]"/></td>
        <td><xsl:value-of select="stentry[2]"/></td>
      </tr>
  </xsl:template>
 
  <!-- FIXME/TODO - to be refactored out of title templates -->
  <!-- 
  <xsl:template name="insert-link">
    <xsl:if test="@id">
        <xsl:element name="a">
          <xsl:attribute name="name" select="@id"/>
          <xsl:comment></xsl:comment>
        </xsl:element>
    </xsl:if>    
  </xsl:template>
   -->
  
  <!-- Define/Function/Enumeration/Typedef/Variable Title -->
  <xsl:template match="*[contains(@class, ' apiOperation/apiOperation ') or
  						 contains(@class, ' apiValue/apiValue ')]/*[contains(@class, ' topic/title ')]">
    <!-- Anchor added for link inserter which puts an id on apiName elements -->
    <xsl:if test="@id">
        <xsl:element name="a">
          <xsl:attribute name="name" select="@id"/>
          <xsl:comment></xsl:comment>
        </xsl:element>
    </xsl:if>
    <xsl:call-template name="sect-heading">
      <xsl:with-param name="defaulttitle"><xsl:apply-templates select="." mode="cxxapiref.title-fmt"/></xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates select="../*[contains(@class, ' cxxFile/cxxFileAPIItemLocation ')]/*[contains(@class, ' cxxFile/cxxFileDeclarationFile ')]" mode="include"/>    
  </xsl:template>
  
  <!-- Class/Struct/Union/File Title -->
  <xsl:template match="*[contains(@class,' apiClassifier/apiClassifier ') or
                         contains(@class, ' apiPackage/apiPackage ')]/*[contains(@class, ' topic/title ')]">                           
    <!-- Anchor added for link inserter which puts an id on apiName elements -->
    <xsl:if test="@id">
        <xsl:element name="a">
          <xsl:attribute name="name" select="@id"/>
          <xsl:comment></xsl:comment>
        </xsl:element>
    </xsl:if>  
	<h1 class="sectiontitle"><xsl:apply-templates select="." mode="cxxapiref.title-fmt"/></h1>
    <xsl:apply-templates select="../*[contains(@class, ' cxxFile/cxxFileAPIItemLocation ')]/*[contains(@class, ' cxxFile/cxxFileDeclarationFile ')]" mode="include"/>    
  </xsl:template>
  
  <!-- API Reference topic title content -->
  <xsl:template match="*[contains(@class,' topic/title ')]" mode="cxxapiref.title-fmt" priority="0">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Disable API reference body processing that adds a horizontal rule --> 
  <xsl:template match="*[contains(@class,' apiRef/apiDetail ')]" priority="0">
    <xsl:call-template name="topic.body"/>
  </xsl:template>

  <!-- File -->
  <!-- ===================================================================== -->
  
  <!-- File title content -->
  <xsl:template match="*[contains(@class, ' cxxFile/cxxFile ')]/*[contains(@class,' topic/title ')]" mode="cxxapiref.title-fmt">
    <xsl:apply-templates/>
    <xsl:text> </xsl:text>
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'File Reference'"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' cxxFile/cxxFileAPIItemLocation ')]"/>

  <!-- Struct -->
  <!-- ===================================================================== -->
  
  <!-- Struct title content -->
  <xsl:template match="*[contains(@class, ' cxxStruct/cxxStruct ')]/*[contains(@class,' topic/title ')]" mode="cxxapiref.title-fmt">
    <xsl:apply-templates/>
    <xsl:call-template name="cxxapiref.title-fmt.suffix">
      <xsl:with-param name="type" select="'Struct'"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Union -->
  <!-- ===================================================================== -->

  <!-- Class or union title content -->
  <xsl:template match="*[contains(@class, ' cxxUnion/cxxUnion ')]/
                         *[contains(@class,' topic/title ')]" mode="cxxapiref.title-fmt">
    <xsl:apply-templates/>
    <xsl:call-template name="cxxapiref.title-fmt.suffix">
      <xsl:with-param name="type" select="'Union'"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Class -->
  <!-- ===================================================================== -->
  
  <!-- Override API reference with base processing -->
  <xsl:template match="/*[contains(@class,' cxxClass/cxxClass ') or
                          contains(@class, ' cxxStruct/cxxStruct ') or
                          contains(@class, ' cxxFile/cxxFile ') or
                          contains(@class, ' cxxUnion/cxxUnion ')]">
    <xsl:call-template name="chapter-setup"/>
  </xsl:template>
  
  <!-- Class or union title content -->
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClass ')]/
                         *[contains(@class,' topic/title ')]" mode="cxxapiref.title-fmt">
    <xsl:apply-templates/>
    <xsl:call-template name="cxxapiref.title-fmt.suffix">
      <xsl:with-param name="type" select="'Class'"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="cxxapiref.title-fmt.suffix">
    <xsl:param name="type"/>    
    <xsl:variable name="templates"
                  select="../*[contains(@class, ' cxxClass/cxxClassDetail ') or
                               contains(@class, ' cxxStruct/cxxStructDetail ') or
                               contains(@class, ' cxxUnion/cxxUnionDetail ')]/
                               *[contains(@class, ' cxxClass/cxxClassDefinition ') or
                                 contains(@class, ' cxxStruct/cxxStructDefinition ') or
                                 contains(@class, ' cxxUnion/cxxUnionDefinition ')]/
                                 *[contains(@class, ' cxxClass/cxxClassTemplateParamList ') or
                                   contains(@class, ' cxxStruct/cxxStructTemplateParamList ') or
                                   contains(@class, ' cxxUnion/cxxUnionTemplateParamList ')]"/>
    <xsl:for-each select="$templates">
      <xsl:text>&lt; </xsl:text>
        <xsl:for-each select="*[contains(@class, ' cxxClass/cxxClassTemplateParameter ') or
                                contains(@class, ' cxxStruct/cxxStructTemplateParameter ') or
                                contains(@class, ' cxxUnion/cxxUnionTemplateParameter ')]">
          <xsl:if test="not(position() = 1)">, </xsl:if>
          <xsl:value-of select="*[contains(@class, ' cxxClass/cxxClassTemplateParamDeclarationName ') or
                                  contains(@class, ' cxxStruct/cxxStructTemplateParamDeclarationName ') or
                                  contains(@class, ' cxxUnion/cxxUnionTemplateParamDeclarationName ')]"/>
        </xsl:for-each>
        <xsl:text> &gt;</xsl:text>
    </xsl:for-each>
    <xsl:text> </xsl:text>
    <xsl:choose>
      <xsl:when test="contains(., '&lt;') or $templates">
        <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="concat($type, ' Template Reference')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="concat($type, ' Reference')"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Class and struct derivation section -->
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassDerivations ') or
                         contains(@class, ' cxxStruct/cxxStructDerivations ')]">
    <xsl:call-template name="topic.section"/>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassDerivations ') or
                         contains(@class, ' cxxStruct/cxxStructDerivations ')]" mode="get-output-class">
    <xsl:text>section derivation</xsl:text>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassDerivations ') or
                         contains(@class, ' cxxStruct/cxxStructDerivations ')]" mode="section-fmt">
    <xsl:variable name="flagrules">
      <xsl:call-template name="getrules"/>
    </xsl:variable>
    <xsl:call-template name="start-revflag">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
    <xsl:call-template name="sect-heading">
      <xsl:with-param name="defaulttitle">
        <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="'cxxBaseClass'"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <ul class="derivation derivation-root">
      <xsl:apply-templates select="ancestor::*[contains(@class, ' cxxClass/cxxClass ') or
                                               contains(@class, ' cxxStruct/cxxStruct ')][1]" mode="derivation"/>
    </ul>
    <!--
    <xsl:call-template name="sect-heading">
      <xsl:with-param name="defaulttitle">Reverse inheritance path</xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates select="ancestor::*[contains(@class, ' cxxClass/cxxClass ') or
                                             contains(@class, ' cxxStruct/cxxStruct ')][1]" mode="derivation.reverse"/>
    -->
    <xsl:call-template name="end-revflag">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:template>
  
  <!-- Class and struct derivation walker -->
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClass ') or
                         contains(@class, ' cxxStruct/cxxStruct ')]"
                mode="derivation">
    <xsl:param name="link" select="/.."/>
    <xsl:param name="depth" select="0"/>
    <xsl:param name="class"/>
    <li class="derivation-depth-{$depth} {$class}">
      <xsl:choose>
        <xsl:when test="$link">
          <xsl:apply-templates select="$link"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="*[contains(@class, ' topic/title ')]"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="derivation"
                    select="*[contains(@class, ' topic/body ')]/
                              *[contains(@class, ' apiRef/apiDef ')]/
                                *[contains(@class, ' cxxClass/cxxClassDerivations ') or
                                  contains(@class, ' cxxStruct/cxxStructDerivations ')]/
                                  *[contains(@class, ' cxxClass/cxxClassDerivation ') or
                                    contains(@class, ' cxxStruct/cxxStructDerivation ')]"/>
      <xsl:if test="$derivation">
        <ul class="derivation">
         <xsl:for-each select="$derivation">
          <xsl:variable name="cls">
            <xsl:if test="not(position() = last())">derivation-has-next</xsl:if>
          </xsl:variable>
          <xsl:variable name="base" select="*[contains(@class, ' cxxClass/cxxClassBaseClass ') or
                                              contains(@class, ' cxxClass/cxxClassBaseStruct ') or
                                              contains(@class, ' cxxClass/cxxClassBaseUnion ') or
                                              contains(@class, ' cxxStruct/cxxStructBaseClass ') or
                                              contains(@class, ' cxxStruct/cxxStructBaseStruct ') or
                                              contains(@class, ' cxxStruct/cxxStructBaseUnion ')]"/>
          <xsl:variable name="url"> 
            <xsl:call-template name="strip-url-fragment">
              <xsl:with-param name="url" select="$base/@href"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="normalize-space($url)"><!-- infinite loop guard -->
            <xsl:variable name="doc" select="document($url, .)"/>
            <xsl:apply-templates select="$doc/*[contains(@class, ' cxxClass/cxxClass ') or
                                                contains(@class, ' cxxStruct/cxxStruct ')]"
                                 mode="derivation">
               <xsl:with-param name="link" select="$base"/>
               <xsl:with-param name="depth" select="$depth + 1"/>
               <xsl:with-param name="class" select="$cls"/>
             </xsl:apply-templates>
           </xsl:if>
         </xsl:for-each>
        </ul>
      </xsl:if>
    </li>
  </xsl:template>
  
  <!-- Class and struct derivation walker. The walker inverts the tree. -->
  <!--
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClass ') or
                         contains(@class, ' cxxStruct/cxxStruct ')]"
                mode="derivation.reverse">
    <xsl:param name="link" select="/.."/>
    <xsl:param name="contents"/>
    
    <xsl:variable name="title">
      <xsl:choose>
        <xsl:when test="$link">
          <xsl:apply-templates select="$link"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="*[contains(@class, ' topic/title ')]"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="derivation"
                  select="*[contains(@class, ' topic/body ')]/
                            *[contains(@class, ' apiRef/apiDef ')]/
                              *[contains(@class, ' cxxClass/cxxClassDerivations ') or
                                contains(@class, ' cxxStruct/cxxStructDerivations ')]/
                                *[contains(@class, ' cxxClass/cxxClassDerivation ') or
                                  contains(@class, ' cxxStruct/cxxStructDerivation ')]"/>
    <xsl:choose>
      <xsl:when test="$derivation">
       <xsl:for-each select="$derivation">
         <xsl:variable name="base" select="*[contains(@class, ' cxxClass/cxxClassBaseClass ') or
                                             contains(@class, ' cxxClass/cxxClassBaseStruct ') or
                                             contains(@class, ' cxxClass/cxxClassBaseUnion ') or
                                             contains(@class, ' cxxStruct/cxxStructBaseClass ') or
                                             contains(@class, ' cxxStruct/cxxStructBaseStruct ') or
                                             contains(@class, ' cxxStruct/cxxStructBaseUnion ')]"/>
         <xsl:variable name="url"> 
           <xsl:call-template name="strip-url-fragment">
             <xsl:with-param name="url" select="$base/@href"/>
           </xsl:call-template>
         </xsl:variable>
         <xsl:if test="normalize-space($url)">
           <xsl:variable name="doc" select="document($url, .)"/>

           <xsl:apply-templates select="$doc/*[contains(@class, ' cxxClass/cxxClass ') or
                                               contains(@class, ' cxxStruct/cxxStruct ')]"
                                mode="derivation.reverse">
             <xsl:with-param name="contents">
               <li>
                 <xsl:copy-of select="$title"/>
                 <xsl:if test="normalize-space($contents)">
                   <ul>
                     <xsl:copy-of select="$contents"/>
                   </ul>  
                 </xsl:if>
               </li>
             </xsl:with-param>
             <xsl:with-param name="link" select="$base"/>
           </xsl:apply-templates>
         </xsl:if>
       </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <ul class="derivation-root">
          <li>
            <xsl:copy-of select="$title"/>
            <ul>
              <xsl:copy-of select="$contents"/>
            </ul>
          </li>
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  -->

  <xsl:template name="get-functions">
  	<xsl:param name="nodes"/>
    <xsl:value-of select="$nodes[contains(@class, ' cxxFunction/cxxFunction ')]"/>
  </xsl:template>
  
  <!-- Class, struct, or union body -->
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassDetail ') or
                         contains(@class, ' cxxStruct/cxxStructDetail ') or
                         contains(@class, ' cxxUnion/cxxUnionDetail ') or
						 contains(@class, ' cxxNamespace/cxxNamespaceDetail ')]">

    <xsl:apply-templates select="*[contains(@class, ' cxxClass/cxxClassDefinition ') or
                                   contains(@class, ' cxxStruct/cxxStructDefinition ') or
                                   contains(@class, ' cxxUnion/cxxUnionDefinition ')]" mode="include"/>
    <xsl:apply-templates select="*[contains(@class,' apiRef/apiDesc ')]/p[@otherprops='linkagainst']"/>
                                   
    <xsl:apply-templates select="*[contains(@class, ' cxxClass/cxxClassDefinition ') or
                                   contains(@class, ' cxxStruct/cxxStructDefinition ') or
                                   contains(@class, ' cxxUnion/cxxUnionDefinition ')]" mode="signature"/>
                                   
    <xsl:apply-templates select="../*[contains(@class,' topic/shortdesc ')]" mode="section-fmt"/>        
                                      
    <xsl:apply-templates select="*[contains(@class, ' cxxClass/cxxClassDefinition ') or
                                   contains(@class, ' cxxStruct/cxxStructDefinition ')]/
                                   *[contains(@class, ' cxxClass/cxxClassDerivations ') or
                                     contains(@class, ' cxxStruct/cxxStructDerivations ')]"/>

	<!--  TODO - Should NestedDetails be output here??? -->                              
    <xsl:apply-templates select="../*[contains(@class, ' cxxClass/cxxClassNested ') or
                                      contains(@class, ' cxxStruct/cxxStructNested ') or
                                      contains(@class, ' cxxUnion/cxxUnionNested ')]/
                                      *[contains(@class, ' cxxClass/cxxClassNestedDetail ') or
                                        contains(@class, ' cxxStruct/cxxStructNestedDetail ') or
                                        contains(@class, ' cxxUnion/cxxUnionNestedDetail ')]"/>
                                           
    <div class="section member-index">
      <xsl:for-each select="..">
        <xsl:variable name="inherited" select="*[contains(@class, ' cxxClass/cxxClassInherits ') or
                                                 contains(@class, ' cxxStruct/cxxStructInherits ')]/
                                                 *[contains(@class, ' cxxClass/cxxClassInheritsDetail ') or
                                                   contains(@class, ' cxxStruct/cxxStructInheritsDetail ')]"/>
<!--
        <xsl:call-template name="member-index-block">
          <xsl:with-param name="title" select="'Member Nested Classes'"/>
          <xsl:with-param name="nodes" select="*[contains(@class, ' cxxClass/cxxClassNested ')]"/>
        </xsl:call-template>
-->
        <xsl:call-template name="member-index-group">
          <xsl:with-param name="title" select="'Member Type Definitions'"/>
          <xsl:with-param name="nodes" select="*[contains(@class, ' cxxTypedef/cxxTypedef ')]"/>
        </xsl:call-template>
        
        <xsl:call-template name="member-index-group">
          <xsl:with-param name="title" select="'Attributes'"/>
          <xsl:with-param name="nodes" select="*[contains(@class, ' cxxVariable/cxxVariable ') and not(contains(@otherprops,'property'))]"/>
        </xsl:call-template>        
              
        <xsl:call-template name="member-index-group">
          <xsl:with-param name="title" select="'Member Enumerations'"/>
          <xsl:with-param name="nodes" select="*[contains(@class, ' cxxEnumeration/cxxEnumeration ')]"/>
        </xsl:call-template>
        
        <xsl:call-template name="member-index-group">
          <xsl:with-param name="title" select="'Properties'"/>
          <xsl:with-param name="nodes" select="*[contains(@class, ' cxxVariable/cxxVariable ') and (contains(@otherprops,'property'))]"/>
        </xsl:call-template>                      
        
        <xsl:call-template name="member-index-group">
          <xsl:with-param name="title" select="'Member Functions'"/>
          <xsl:with-param name="nodes" select="*[contains(@class, ' cxxFunction/cxxFunction ')
          											and not(contains(@otherprops,'slot') or contains(@otherprops,'signal'))]"/>
        </xsl:call-template>      

        <xsl:call-template name="member-index-group">
          <xsl:with-param name="title" select="'Slots'"/>
          <xsl:with-param name="nodes" select="*[contains(@class, ' cxxFunction/cxxFunction ') and contains(@otherprops,'slot')]"/>
        </xsl:call-template>                

        <xsl:call-template name="member-index-group">
          <xsl:with-param name="title" select="'Signals'"/>
          <xsl:with-param name="nodes" select="*[contains(@class, ' cxxFunction/cxxFunction ') and contains(@otherprops,'signal')]"/>
        </xsl:call-template>        

        <xsl:call-template name="member-index-block">
          <xsl:with-param name="title" select="'Inherited Attributes'"/>
          <xsl:with-param name="nodes" select="$inherited/*[contains(@class, ' cxxClass/cxxClassVariableInherited ') or
                                                            contains(@class, ' cxxStruct/cxxStructVariableInherited ')]"/>
        </xsl:call-template>
        
        <xsl:call-template name="member-index-block">
          <xsl:with-param name="title" select="'Inherited Enumerations'"/>
          <xsl:with-param name="nodes" select="$inherited/*[contains(@class, ' cxxClass/cxxClassEnumerationInherited ') or
                                                            contains(@class, ' cxxStruct/cxxStructEnumerationInherited ')]"/>
        </xsl:call-template>
        
        <xsl:call-template name="member-index-block">
          <xsl:with-param name="title" select="'Inherited Functions'"/>
          <xsl:with-param name="nodes" select="$inherited/*[contains(@class, ' cxxClass/cxxClassFunctionInherited ') or
                                                            contains(@class, ' cxxStruct/cxxStructFunctionInherited ')]"/>
        </xsl:call-template>
        <xsl:call-template name="member-index-block">
          <xsl:with-param name="title" select="'Inherited Type Definitions'"/>
          <xsl:with-param name="nodes" select="$inherited/*[contains(@class, ' cxxClass/cxxClassTypedefInherited ') or
                                                            contains(@class, ' cxxStruct/cxxStructTypedefInherited ')]"/>
        </xsl:call-template>
      </xsl:for-each>
    </div>
    <xsl:for-each select="..">
      <xsl:for-each select="*[contains(@class, ' topic/related-links ')]">
        <xsl:call-template name="topic.related-links"/>
      </xsl:for-each>
    </xsl:for-each>
   
    <!--  API description etc. -->
    <xsl:apply-templates select="*[(contains(@class, ' topic/section ') or
                                    contains(@class, ' topic/example ')) and
                                   not(contains(@class, ' apiRef/apiDef '))]"/>    

	<!-- Detailed Member Documentation -->
    <xsl:variable name="typedefs" select="../*[contains(@class, ' cxxTypedef/cxxTypedef ')]"/>
    <xsl:if test="$typedefs">
      <xsl:call-template name="sect-heading">
        <xsl:with-param name="defaulttitle">Member Type Definition Documentation</xsl:with-param>
      </xsl:call-template>    
      <xsl:apply-templates select="$typedefs" mode="child.topic">
        <xsl:sort select="*[contains(@class, ' topic/title ')]"/>
      </xsl:apply-templates>
    </xsl:if>
    <xsl:variable name="variables" select="../*[contains(@class, ' cxxVariable/cxxVariable ') and not(contains(@otherprops,'property'))]"/>
    <xsl:if test="$variables">
      <xsl:call-template name="sect-heading">
        <xsl:with-param name="defaulttitle">Member Attribute Documentation</xsl:with-param>
      </xsl:call-template>           
      <xsl:apply-templates select="$variables" mode="child.topic">
        <xsl:sort select="*[contains(@class, ' topic/title ')]"/>
      </xsl:apply-templates>
    </xsl:if>
    <xsl:variable name="enums" select="../*[contains(@class, ' cxxEnumeration/cxxEnumeration ')]"/>
    <xsl:if test="$enums">
      <xsl:call-template name="sect-heading">
        <xsl:with-param name="defaulttitle">Member Enumeration Documentation</xsl:with-param>
      </xsl:call-template>      
      <xsl:apply-templates select="$enums" mode="child.topic">
        <xsl:sort select="*[contains(@class, ' topic/title ')]"/>
      </xsl:apply-templates>
    </xsl:if>
    <xsl:variable name="properties" select="../*[contains(@class, ' cxxVariable/cxxVariable ') and contains(@otherprops,'property')]"/>
    <xsl:if test="$properties">
      <xsl:call-template name="sect-heading">
        <xsl:with-param name="defaulttitle">Properties Documentation</xsl:with-param>
      </xsl:call-template>           
      <xsl:apply-templates select="$properties" mode="child.topic">
        <xsl:sort select="*[contains(@class, ' topic/title ')]"/>
      </xsl:apply-templates>
    </xsl:if>
        
    <!-- Pull nested topics into groups, normal fall-through is disabled -->
    <xsl:variable name="all-functions" select="../*[contains(@class, ' cxxFunction/cxxFunction ')]"/>
    <xsl:variable name="constructor" select="$all-functions[*[contains(@class, ' apiRef/apiDetail ')]/*[contains(@class, ' apiRef/apiDef ')]/*[contains(@class, ' apiRef/apiQualifier ')][@name = 'constructor']]"/>      	
    <xsl:variable name="destructor" select="$all-functions[*[contains(@class, ' apiRef/apiDetail ')]/*[contains(@class, ' apiRef/apiDef ')]/*[contains(@class, ' apiRef/apiQualifier ')][@name = 'destructor']]"/>
    <xsl:if test="$constructor | $destructor">
      <xsl:call-template name="sect-heading">
        <xsl:with-param name="defaulttitle">Constructor &amp; Destructor Documentation</xsl:with-param>
      </xsl:call-template>            
      <xsl:apply-templates select="$constructor" mode="child.topic">
        <xsl:sort select="*[contains(@class, ' topic/title ')]"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="$destructor" mode="child.topic">
        <xsl:sort select="*[contains(@class, ' topic/title ')]"/>
      </xsl:apply-templates>
    </xsl:if>
    <xsl:variable name="functions" select="$all-functions[not(count($constructor | $destructor) = count(. | $constructor | $destructor))]"/>
    <xsl:if test="$functions">
      <xsl:call-template name="sect-heading">
        <xsl:with-param name="defaulttitle">Member Function Documentation</xsl:with-param>
      </xsl:call-template>                      
      <xsl:apply-templates select="$functions" mode="child.topic">
        <xsl:sort select="*[contains(@class, ' topic/title ')]"/>
      </xsl:apply-templates>
    </xsl:if>
    <xsl:variable name="structures" select="../*[contains(@class, ' cxxStruct/cxxStruct ')]"/>
    <xsl:if test="$structures">
      <xsl:call-template name="sect-heading">
        <xsl:with-param name="defaulttitle">Member Structure Documentation</xsl:with-param>
      </xsl:call-template>                
      <xsl:apply-templates select="$structures" mode="child.topic">
        <xsl:sort select="*[contains(@class, ' topic/title ')]"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:template>
  
  <!-- Omit, pulled by class/struct body -->
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClass ') or
                         contains(@class, ' cxxStruct/cxxStruct ') or
                         contains(@class, ' cxxUnion/cxxUnion ') or
						 contains(@class, ' cxxNamespace/cxxNamespace ')]/
                         *[contains(@class, ' topic/topic ') or
                           contains(@class, ' topic/related-links ')]"/>

  <!-- Class and struct body class -->
  <!-- 
  <xsl:template match="*[contains(@class,' cxxClass/cxxClass ') or
                         contains(@class, ' cxxStruct/cxxStruct ') or
                         contains(@class, ' cxxUnion/cxxUnion ')]/
                         *[contains(@class,' topic/topic ')]/
                           *[contains(@class,' topic/body ')]"
                mode="get-output-class">
    <xsl:text>topicbody</xsl:text>
    <xsl:value-of select="count(ancestor-or-self::*[contains(@class,' topic/topic ')])"/> 
  </xsl:template>
   -->  

  <!-- Member index group -->
  <xsl:template name="member-index-group">
    <xsl:param name="title"/>
    <xsl:param name="nodes"/>
    <xsl:call-template name="member-index-block">
      <xsl:with-param name="nodes"
                      select="$nodes[*[contains(@class, ' apiRef/apiDetail ')]/*[contains(@class, ' apiRef/apiDef ')]/
                                       *[contains(@class, ' apiRef/apiQualifier ')][@name = 'access' and @value = 'public']]"/>
      <xsl:with-param name="title" select="concat('Public ', $title)"/>
    </xsl:call-template>
    <xsl:call-template name="member-index-block">
      <xsl:with-param name="nodes"
                      select="$nodes[*[contains(@class, ' apiRef/apiDetail ')]/*[contains(@class, ' apiRef/apiDef ')]/
                                       *[contains(@class, ' apiRef/apiQualifier ')][@name = 'access' and @value = 'protected']]"/>
      <xsl:with-param name="title" select="concat('Protected ', $title)"/>
    </xsl:call-template>
    <xsl:call-template name="member-index-block">
      <xsl:with-param name="nodes"
                      select="$nodes[*[contains(@class, ' apiRef/apiDetail ')]/*[contains(@class, ' apiRef/apiDef ')]/
                                       *[contains(@class, ' apiRef/apiQualifier ')][@name = 'access' and @value = 'private']]"/>
      <xsl:with-param name="title" select="concat('Private ', $title)"/>
    </xsl:call-template>
  </xsl:template>
  
  <!-- Member index table -->
  <xsl:template name="member-index-block">
    <xsl:param name="nodes" select="/.."/>
    <xsl:param name="title"/>
    <xsl:if test="$nodes">
      <table  class="member-index">
        <thead>
          <tr>
            <th colspan="2">
              <xsl:value-of select="$title"/>
            </th>
          </tr>
        </thead>
        <tbody>
          <xsl:apply-templates select="$nodes" mode="class-members">
            <xsl:sort select="number(boolean(*[contains(@class, ' apiRef/apiDetail ')]/
                                               *[contains(@class, ' apiRef/apiDef ')]/
                                                 *[contains(@class, ' apiRef/apiQualifier ')]
                                                  [@name = 'constructor' or @name = 'destructor']))"
                      data-type="number" order="descending"/>
            <xsl:sort select="*[contains(@class, ' topic/title ')]"/>
          </xsl:apply-templates>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassFunctionInherited ') or 
                         contains(@class, ' cxxClass/cxxClassVariableInherited ') or 
						 contains(@class, ' cxxClass/cxxClassTypedefInherited ') or 
                         contains(@class, ' cxxClass/cxxClassEnumerationInherited ') or 
                         contains(@class, ' cxxClass/cxxClassEnumeratorInherited ')]"
                mode="class-members">
    <tr>
      <xsl:if test="position() mod 2 = 0">
        <xsl:attribute name="class">bg</xsl:attribute>  
      </xsl:if>
      <td><xsl:text> </xsl:text></td>
      <td>
        <xsl:apply-templates select="."/>
      </td>
    </tr>
  </xsl:template>
  
  <!-- Add links to all inherited members when the API item doing the inheriting is a struct -->
  <xsl:template match="*[contains(@class, ' cxxStruct/cxxStructFunctionInherited ') or 
                         contains(@class, ' cxxStruct/cxxStructVariableInherited ') or 
						 contains(@class, ' cxxStruct/cxxStructTypedefInherited ') or 
                         contains(@class, ' cxxStruct/cxxStructEnumerationInherited ') or 
                         contains(@class, ' cxxStruct/cxxStructEnumeratorInherited ')]"
                mode="class-members">
    <tr>
      <xsl:if test="position() mod 2 = 0">
        <xsl:attribute name="class">bg</xsl:attribute>  
      </xsl:if>
      <td><xsl:text> </xsl:text></td>
      <td>
        <xsl:apply-templates select="."/>
      </td>
    </tr>
  </xsl:template>  
  <!--
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassFunctionInherited ') or 
                         contains(@class, ' cxxClass/cxxClassVariableInherited ') or 
                         contains(@class, ' cxxClass/cxxClassEnumerationInherited ') or 
                         contains(@class, ' cxxClass/cxxClassEnumeratorInherited ')]/text()">
    <xsl:variable name="t" select="substring-after(., '::')"/>
    <xsl:choose>
      <xsl:when test="contains($t, '(')">
        <xsl:value-of select="substring-before($t, '(')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$t"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  -->

  <!-- Default member index row -->
  <xsl:template match="*" mode="class-members" priority="0">
    <tr>
      <xsl:if test="position() mod 2 = 0">
        <xsl:attribute name="class">bg</xsl:attribute>  
      </xsl:if>
      <td><xsl:text> </xsl:text></td>
      <td>
        <a href="#{@id}">
          <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="cxxapiref.title-fmt"/>
         </a>
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassDefinition ') or
                         contains(@class, ' cxxStruct/cxxStructDefinition ') or
                         contains(@class, ' cxxUnion/cxxUnionDefinition ')]"
                 mode="include">
    <xsl:apply-templates select="*[contains(@class, ' cxxClass/cxxClassAPIItemLocation ') or
                         contains(@class, ' cxxStruct/cxxStructAPIItemLocation ') or
                         contains(@class, ' cxxUnion/cxxUnionAPIItemLocation ')]/
                       *[contains(@class, ' cxxClass/cxxClassDeclarationFile ') or
                         contains(@class, ' cxxStruct/cxxStructDeclarationFile ') or
                         contains(@class, ' cxxUnion/cxxUnionDeclarationFile ')]" mode="include"/>    
  </xsl:template>
<!--
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassDeclarationFile ') or
                         contains(@class, ' cxxStruct/cxxStructDeclarationFile ') or
                         contains(@class, ' cxxUnion/cxxUnionDeclarationFile ') or
                         contains(@class, ' cxxFile/cxxFileDeclarationFile ')]"
                 mode="include">
    <div class="include">
        <xsl:variable name="includePath" select="@value"/>
        <p>#include 
            <xsl:choose>
                <xsl:when test="contains(@value, 'epoc32/include')">
                    &lt;<xsl:value-of select="substring-after($includePath,'epoc32/include/')"/>&gt;
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="includeFile">
                        <xsl:call-template name="substring-after-last">
                            <xsl:with-param name="delimiter" select="'/'"/>
                            <xsl:with-param name="string" select="$includePath"/>
                        </xsl:call-template>                    
                    </xsl:variable>
                    &quot;<xsl:value-of select="$includeFile"/>&quot;
                </xsl:otherwise>
            </xsl:choose>
         </p>
    </div>
  </xsl:template>
-->
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassDeclarationFile ') or
                         contains(@class, ' cxxStruct/cxxStructDeclarationFile ') or
                         contains(@class, ' cxxUnion/cxxUnionDeclarationFile ') or
                         contains(@class, ' cxxFile/cxxFileDeclarationFile ')]"
                 mode="include">

        <!-- topic.section is defined in the base dita ot xslt. 
             It creates a div with class text given by the match on this node in get-output-class mode (see below)
             It also applies templates on this node in mode section-fmt (also see below)
        -->
        <xsl:call-template name="topic.section"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassDeclarationFile ') or
                         contains(@class, ' cxxStruct/cxxStructDeclarationFile ') or
                         contains(@class, ' cxxUnion/cxxUnionDeclarationFile ') or
                         contains(@class, ' cxxFile/cxxFileDeclarationFile ')]" mode="get-output-class">
    <xsl:text>section include</xsl:text>    
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassDeclarationFile ') or
                         contains(@class, ' cxxStruct/cxxStructDeclarationFile ') or
                         contains(@class, ' cxxUnion/cxxUnionDeclarationFile ') or
                         contains(@class, ' cxxFile/cxxFileDeclarationFile ')]" mode="section-fmt">
      <xsl:variable name="flagrules">
	    <xsl:call-template name="getrules"/>
	  </xsl:variable>
	  <xsl:call-template name="start-revflag">
	    <xsl:with-param name="flagrules" select="$flagrules"/>  
	  </xsl:call-template>
      <xsl:variable name="includePath" select="@value"/>
        <p>#include 
            <xsl:choose>
                <xsl:when test="contains(@value, 'epoc32/include')">
                    &lt;<xsl:value-of select="substring-after($includePath,'epoc32/include/')"/>&gt;
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="includeFile">
                        <xsl:call-template name="substring-after-last">
                            <xsl:with-param name="delimiter" select="'/'"/>
                            <xsl:with-param name="string" select="$includePath"/>
                        </xsl:call-template>                    
                    </xsl:variable>
                    &quot;<xsl:value-of select="$includeFile"/>&quot;
                </xsl:otherwise>
            </xsl:choose>
         </p>
      <xsl:call-template name="end-revflag">
	    <xsl:with-param name="flagrules" select="$flagrules"/>  
	  </xsl:call-template>    
  </xsl:template>
  
  <!-- Class or struct signature --> 
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassDefinition ') or
                         contains(@class, ' cxxStruct/cxxStructDefinition ') or
                         contains(@class, ' cxxUnion/cxxUnionDefinition ')]"
                 mode="signature">
    <xsl:variable name="templates"
                  select="*[contains(@class, ' cxxClass/cxxClassTemplateParamList ') or
                            contains(@class, ' cxxStruct/cxxStructTemplateParamList ') or
                            contains(@class, ' cxxUnion/cxxUnionTemplateParamList ')]/
                            *[contains(@class, ' cxxClass/cxxClassTemplateParameter ') or
                              contains(@class, ' cxxStruct/cxxStructTemplateParameter ') or
                              contains(@class, ' cxxUnion/cxxUnionTemplateParameter ')]"/>
    <xsl:variable name="title">
      <xsl:value-of select="ancestor::*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]"/>
    </xsl:variable>
    <div class="section signature">
    <table class="signature">
      <xsl:if test="contains($title, '&lt;') or $templates">
        <tr>
          <td>
            <xsl:text>template &lt;</xsl:text>
            <xsl:for-each select="$templates">
              <xsl:if test="not(position() = 1)">, </xsl:if>
              <xsl:value-of select="*[contains(@class, ' cxxClass/cxxClassTemplateParamType ') or
                                      contains(@class, ' cxxStruct/cxxStructTemplateParamType ') or
                                      contains(@class, ' cxxUnion/cxxUnionTemplateParamType ')]"/>
              
              <xsl:text> </xsl:text>
              <xsl:value-of select="*[contains(@class, ' cxxClass/cxxClassTemplateParamDeclarationName ') or
                                      contains(@class, ' cxxStruct/cxxStructTemplateParamDeclarationName ') or
                                      contains(@class, ' cxxUnion/cxxUnionTemplateParamDeclarationName ')]"/>
            </xsl:for-each>
            <xsl:text>&gt;</xsl:text>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td>
          <xsl:choose>
            <xsl:when test="self::*[contains(@class, ' cxxClass/cxxClassDefinition ')]">class</xsl:when>
            <xsl:when test="self::*[contains(@class, ' cxxStruct/cxxStructDefinition ')]">struct</xsl:when>
            <xsl:when test="self::*[contains(@class, ' cxxUnion/cxxUnionDefinition ')]">union</xsl:when>
          </xsl:choose>
          <xsl:text> </xsl:text>
          <xsl:value-of select="$title"/>
          <xsl:variable name="derivation"
                        select="*[contains(@class, ' cxxClass/cxxClassDerivations ') or
                                  contains(@class, ' cxxStruct/cxxStructDerivations ')]/
                                  *[contains(@class, ' cxxClass/cxxClassDerivation ') or
                                    contains(@class, ' cxxStruct/cxxStructDerivation ')]"/>
          <xsl:if test="$derivation">
            <xsl:text> : </xsl:text>
            <xsl:for-each select="$derivation">
              <xsl:if test="not(position() = 1)">, </xsl:if>
              <xsl:value-of select="*[contains(@class, ' apiRef/apiQualifier ')][@name = 'access']/@value"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="*[contains(@class, ' cxxClass/cxxClassBaseClass ') or
                                      contains(@class, ' cxxClass/cxxClassBaseStruct ') or
                                      contains(@class, ' cxxClass/cxxClassBaseUnion ') or
                                      contains(@class, ' cxxStruct/cxxStructBaseClass ') or
                                      contains(@class, ' cxxStruct/cxxStructBaseStruct ') or
                                      contains(@class, ' cxxStruct/cxxStructBaseUnion ')]/text()"/>
            </xsl:for-each>
          </xsl:if>
        </td>
      </tr>
    </table>
    </div>
  </xsl:template>  

  <!-- Namespace members -->
  <!-- ===================================================================== -->

  <xsl:template match="*[contains(@class, ' cxxNamespace/cxxNamespaceMembers ')]" mode="get-output-class">
    <xsl:text>section namespace</xsl:text>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' cxxNamespace/cxxNamespaceMembers ')]">
    <xsl:call-template name="topic.section"/>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxNamespace/cxxNamespaceMembers ')]" mode="section-fmt">
	<xsl:apply-templates select="cxxNamespaceMembersDetail" mode="section-fmt"/>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxNamespace/cxxNamespaceMembersDetail ')]" mode="section-fmt">
	<h2 class="sectiontitle">
      <xsl:text>Member Class/Struct/Union/Namespaces</xsl:text>
    </h2>
    <ul>
      <xsl:for-each select="*[contains(@class, ' cxxNamespace/cxxNamespaceMemberClass ') or
                              contains(@class, ' cxxNamespace/cxxNamespaceMemberStruct ') or
                              contains(@class, ' cxxNamespace/cxxNamespaceMemberUnion ') or
                              contains(@class, ' cxxNamespace/cxxNamespaceMemberNamespace ')]">
        <xsl:sort select="."/>
        <li>
          <xsl:apply-templates select="."/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  
  <!-- Nested class -->
  <!-- ===================================================================== -->
  
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassNestedDetail ') or
                         contains(@class, ' cxxStruct/cxxStructNestedDetail ') or
                         contains(@class, ' cxxUnion/cxxUnionNestedDetail ')]" priority="10">
    <xsl:call-template name="topic.section"/>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassNestedDetail ') or
                         contains(@class, ' cxxStruct/cxxStructNestedDetail ') or
                         contains(@class, ' cxxUnion/cxxUnionNestedDetail ')]" mode="get-output-class" priority="10">
    <xsl:text>section nested</xsl:text>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxClass/cxxClassNestedDetail ') or
                         contains(@class, ' cxxStruct/cxxStructNestedDetail ') or
                         contains(@class, ' cxxUnion/cxxUnionNestedDetail ')]" mode="section-fmt">
    <xsl:variable name="flagrules">
      <xsl:call-template name="getrules"/>
    </xsl:variable>
    <xsl:call-template name="start-revflag">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
    <!-- default will output h3 instead of h2
    <xsl:call-template name="sect-heading">
      <xsl:with-param name="defaulttitle">
        <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="'cxxBaseClass'"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    -->    
    <h2 class="sectiontitle">
      <xsl:text>Nested Classes and Structures</xsl:text>
    </h2>
    <ul>
      <xsl:for-each select="*[contains(@class, ' cxxClass/cxxClassNestedClass ') or
                              contains(@class, ' cxxClass/cxxClassNestedStruct ') or
                              contains(@class, ' cxxClass/cxxClassNestedUnion ') or
                              contains(@class, ' cxxStruct/cxxStructNestedClass ') or
                              contains(@class, ' cxxStruct/cxxStructNestedStruct ') or
                              contains(@class, ' cxxStruct/cxxStructNestedUnion ') or
                              contains(@class, ' cxxUnion/cxxUnionNestedClass ') or
                              contains(@class, ' cxxUnion/cxxUnionNestedStruct ') or
                              contains(@class, ' cxxUnion/cxxUnionNestedUnion ')]">
        <xsl:sort select="."/>
        <li>
          <xsl:apply-templates select="."/>
        </li>
      </xsl:for-each>
    </ul>
    <xsl:call-template name="end-revflag">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Function -->
  <!-- ===================================================================== -->
  
  <xsl:template name="is-constructor">    
    <xsl:value-of select="boolean(*[contains(@class, ' apiRef/apiDetail ')]/
                                    *[contains(@class, ' apiRef/apiDef ')]/
                                      *[contains(@class, ' apiRef/apiQualifier ')]
                                       [@name = 'constructor' or @name = 'destructor'])"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunction ')]" mode="class-members">
    <xsl:variable name="is-constructor">
      <xsl:call-template name="is-constructor"/>
    </xsl:variable>
    <tr>
      <xsl:if test="position() mod 2 = 0">
        <xsl:attribute name="class">bg</xsl:attribute>  
      </xsl:if>
      <td align="right" class="code">
        <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionDetail ')]/
                                     *[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]/
                                         *[contains(@class, ' cxxFunction/cxxFunctionVirtual ')]"/> 
        <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionDetail ')]/
                                       *[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]/
                                         *[contains(@class, ' cxxFunction/cxxFunctionPureVirtual ')]"/>                   
        <xsl:if test="not($is-constructor = 'true')">
          <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionDetail ')]/
                                         *[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]/
                                           *[contains(@class, ' cxxFunction/cxxFunctionDeclaredType ')]/node()"/>
        </xsl:if>
      </td>
      <td>
        <a href="#{@id}">
          <xsl:apply-templates select="*[contains(@class, ' topic/title ')]/node()"/><!--mode="cxxapiref.title-fmt"-->
        </a>
        <xsl:text>(</xsl:text>
        <xsl:for-each select="*[contains(@class, ' cxxFunction/cxxFunctionDetail ')]/
                                *[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]/
                                  *[contains(@class, ' cxxFunction/cxxFunctionParameters ')]/
                                    *[contains(@class, ' cxxFunction/cxxFunctionParameter ')]">
          <xsl:if test="not(position() = 1)">, </xsl:if>
          <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionParameterDeclaredType ')]/node()"/>
        </xsl:for-each>
        <xsl:text>)</xsl:text>
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionVirtual ')]">
    <xsl:value-of select="@value"/>
    <xsl:text> </xsl:text> 
  </xsl:template>  
  
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionPureVirtual ')]">
    <xsl:value-of select="@value"/>
    <xsl:text> </xsl:text>
  </xsl:template>
  
  <!--
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunction ')]/*[contains(@class, ' topic/title ')]" mode="class-members">
    <xsl:apply-templates select="../*[contains(@class, ' cxxFunction/cxxFunctionDetail ')]/
                                      *[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]/
                                        *[contains(@class, ' cxxFunction/cxxFunctionPrototype ')]/
                                          node()"/>
  </xsl:template>
  -->
  
  <!-- Function title -->
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunction ')]/*[contains(@class, ' topic/title ')]" mode="cxxapiref.title-fmt">

    <xsl:apply-templates/>

    <xsl:text> ( </xsl:text>
    <xsl:for-each select="../*[contains(@class, ' cxxFunction/cxxFunctionDetail ')]/
                              *[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]/
                                *[contains(@class, ' cxxFunction/cxxFunctionParameters ')]/
                                  *[contains(@class, ' cxxFunction/cxxFunctionParameter ')]">     
      <xsl:if test="not(position() = 1)">, </xsl:if>
      <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionParameterDeclaredType ')]/node()"/>
    </xsl:for-each>
    <xsl:text> )</xsl:text>    
  </xsl:template>
  
  <!-- Function body -->  
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionDetail ')]">
    <xsl:call-template name="topic.section"/>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionDetail ')]" mode="get-output-class">
    <xsl:text>section functiondetail</xsl:text>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionDetail ')]" mode="section-fmt">	
    <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]" mode="signature"/>
    <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]/*[contains(@class, ' cxxFunction/cxxFunctionReimplemented ')]" mode="reimplemented"/>
	<!-- Exception specification -->
    <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]/*[contains(@class, ' cxxFunction/cxxFunctionExceptionSpecification ')]" mode="exception"/>
    <xsl:apply-templates select="../*[contains(@class,' topic/shortdesc ')]" mode="section-fmt"/>
    <xsl:apply-templates select="*[(contains(@class, ' topic/section ') or
                                    contains(@class, ' topic/example ')) and
                                   not(contains(@class, ' apiRef/apiDef '))]"/>
    <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]/*[contains(@class, ' cxxFunction/cxxFunctionParameters ')]"/>
	<xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]/*[contains(@class,' cxxFunction/cxxFunctionReturnDesc ')]" />
    <xsl:apply-templates select="*[contains(@class,' apiRef/apiDesc ')]/p[simpletable]" mode="retval" />  
  </xsl:template>
   
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionPrototype ')]">
    <pre>
      <xsl:for-each select="../*[contains(@class, ' apiRef/apiQualifier ')][@name = 'access']">
        <!--xsl:if test="@value = 'private' or @value = 'protected'"-->
          <xsl:value-of select="@value"/>
          <xsl:text>: </xsl:text>
        <!--/xsl:if-->  
      </xsl:for-each>
      <xsl:apply-templates/>
    </pre>
  </xsl:template>
  
  <!-- common meta -->
  <xsl:template name="meta-signature">
    <xsl:variable name="m">      
      <xsl:for-each select="*[contains(@class, ' apiRef/apiQualifier ')][@name = 'access'][not(@value = 'public')]">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="@value"/>
      </xsl:for-each>
      <xsl:for-each select="*[contains(@class, ' apiRef/apiQualifier ')][@name = 'static']">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="@value"/>
      </xsl:for-each>
      <xsl:for-each select="*[contains(@class, ' apiRef/apiQualifier ')][@name = 'inline']">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="@value"/>
      </xsl:for-each>
      <xsl:for-each select="*[contains(@class, ' apiRef/apiQualifier ')][@name = 'pure virtual']">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="@value"/>
      </xsl:for-each>
      <xsl:for-each select="*[contains(@class, ' apiRef/apiQualifier ')][@name = 'virtual']">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="@value"/>
      </xsl:for-each>
      <xsl:for-each select="*[contains(@class, ' apiRef/apiQualifier ')][@name = 'explicit']">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="@value"/>
      </xsl:for-each>
      <xsl:if test="../..[contains(@otherprops,'slot')]">, slot </xsl:if>
      <xsl:if test="../..[contains(@otherprops,'signal')]">, signal </xsl:if>      
    </xsl:variable>
    <xsl:if test="normalize-space($m)">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="normalize-space(substring($m, 2))"/>
      <xsl:text>]</xsl:text>  
    </xsl:if>
  </xsl:template>
  
  <!-- Method signature -->
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionDefinition ')]" mode="signature">
    <xsl:variable name="parameters" select="*[contains(@class, ' cxxFunction/cxxFunctionParameters ')]/*[contains(@class, ' cxxFunction/cxxFunctionParameter ')]"/>
    <xsl:variable name="meta">   
      <xsl:for-each select="*[contains(@class, ' apiRef/apiQualifier ')][@name = 'const']">
        <xsl:value-of select="@value"/>
        <xsl:text> </xsl:text>
      </xsl:for-each>
      <xsl:call-template name="meta-signature"/>
    </xsl:variable>
    <xsl:variable name="has-type" select="boolean(*[contains(@class, ' cxxFunction/cxxFunctionDeclaredType ')]/node())"/>
    <div class="section signature">
    <table class="signature">
      <tr>
        <xsl:if test="$has-type">
          <td>
            <!--
            <xsl:value-of select="*[contains(@class, ' cxxFunction/cxxFunctionStorageClassSpecifierStatic ')]/@value"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="*[contains(@class, ' cxxFunction/cxxFunctionInline ')]/@value"/>
            <xsl:text> </xsl:text>
            -->
            <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionDeclaredType ')]/node()"/>
          </td>
        </xsl:if>
        <td>
          <xsl:apply-templates select="../../*[contains(@class, ' apiRef/apiName ')]/node()"/>
        </td>
        <td>(</td>
        <xsl:apply-templates select="$parameters[1]" mode="signature">
          <xsl:with-param name="hasNext" select="count($parameters) > 1"/>
        </xsl:apply-templates>
        <xsl:if test="count($parameters) &lt;= 1">
          <td>
             <xsl:text>)</xsl:text>
          </td>
          <td>
             <xsl:copy-of select="$meta"/>
          </td>
        </xsl:if>        
      </tr>
      <xsl:for-each select="$parameters[not(position() = 1)]">
        <tr>
          <!--xsl:if test="$has-type">
            <td><xsl:text> </xsl:text></td>
          </xsl:if>
          <td><xsl:text> </xsl:text></td-->
          <td colspan="{2 + number($has-type)}"><xsl:text> </xsl:text></td>
          <xsl:apply-templates select="." mode="signature">
            <xsl:with-param name="hasNext" select="not(position() = count($parameters) - 1)"/>
          </xsl:apply-templates>
        </tr>
      </xsl:for-each>
      <xsl:if test="count($parameters) > 1">
        <tr>
          <!--xsl:if test="$has-type">
            <td><xsl:text> </xsl:text></td>
          </xsl:if-->
          <td colspan="{1 + number($has-type)}"><xsl:text> </xsl:text></td>
          <td>)</td>
          <td colspan="2">
            <xsl:copy-of select="$meta"/>
          </td>
          <!--td><xsl:text> </xsl:text></td-->
        </tr>
      </xsl:if>
    </table>
    </div>
  </xsl:template>

  
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionParameter ')]" mode="signature">
    <xsl:param name="hasNext" select="false"/>
    <td>
      <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionParameterDeclaredType ')]/node()"/>
    </td>
    <td>
      <span class="parameter"><xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionParameterDeclarationName ')]/node()"/></span>
      <xsl:if test="*[contains(@class, ' cxxFunction/cxxFunctionParameterDefaultValue ')]">
        <xsl:text>&#xA0;=&#xA0;</xsl:text>
        <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionParameterDefaultValue ')]/node()"/>
      </xsl:if>
      <xsl:if test="$hasNext">,</xsl:if>
    </td>
  </xsl:template>

  <!-- Reimplemented function -->
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionReimplemented ')]" mode="reimplemented">
        <div>
            <p>Reimplemented from <xsl:apply-templates select="."/></p>
        </div>    
  </xsl:template>
  
  <!-- Function Exception specification -->
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionExceptionSpecification ')]" mode="exception">
        <div>
            <p>Exception specification: <xsl:apply-templates select="."/></p>
        </div>    
  </xsl:template>
  
  
  
  <!-- Return type -->
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionDeclaredType ')]">
    <xsl:call-template name="topic.section"/>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionDeclaredType ')]" mode="get-output-class">
    <xsl:text>section return</xsl:text>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionDeclaredType ')]" mode="section-fmt">
    <xsl:variable name="flagrules">
      <xsl:call-template name="getrules"/>
    </xsl:variable>
    <xsl:call-template name="start-revflag">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
    <xsl:call-template name="sect-heading">
      <xsl:with-param name="defaulttitle">Returns</xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates/>
    <xsl:call-template name="end-revflag">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:template>
  
  <!-- Parameters -->
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionParameters ')]">
    <xsl:if test="*[contains(@class, ' cxxFunction/cxxFunctionParameter ')]">
      <xsl:call-template name="topic.section"/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionParameters ')]" mode="get-output-class">
    <xsl:text>section parameters</xsl:text>
  </xsl:template>  
  <xsl:template match="*[contains(@class, ' cxxFunction/cxxFunctionParameters ')]" mode="section-fmt">  
    <xsl:variable name="flagrules">
      <xsl:call-template name="getrules"/>
    </xsl:variable>    
    <xsl:call-template name="start-revflag">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>        
    <!--  Find all apiDefNote function parameter documentation. -->
    <xsl:variable name="apidefnotes">
    	<xsl:for-each select="cxxFunctionParameter">
    		  <xsl:value-of select="apiDefNote"></xsl:value-of>
    	</xsl:for-each>
    </xsl:variable>        
    <!-- If any parameter documentation exists create a parameter table  -->
    <xsl:if test="string-length($apidefnotes) > 0">
      <!-- 
	  <h4 class="sectiontitle">
	    <xsl:call-template name="getString"><xsl:with-param name="stringName" select="'cxxParameters'"/></xsl:call-template>
	  </h4>
	   --> 
	  <table  class="parameters">
		  <tr><th>Parameters</th></tr>
	      <xsl:for-each select="*[contains(@class, ' cxxFunction/cxxFunctionParameter ')]">
	        <xsl:if test="string-length(apiDefNote) > 0">	            
		        <tr>
		          <xsl:if test="position() mod 2 = 0">
		            <xsl:attribute name="class">bg</xsl:attribute>  
		          </xsl:if>          
		          <td class="parameter">
		            <xsl:apply-templates select="*[contains(@class, ' cxxFunction/cxxFunctionParameterDeclarationName ')]/node()"/>
		          </td>
		          <td>
		            <xsl:apply-templates select="*[contains(@class, ' apiRef/apiDefNote ')]/node()"/>
		            <xsl:text> </xsl:text>
		          </td>
		        </tr>
	        </xsl:if>
	      </xsl:for-each>
      </table>
    </xsl:if>    
    <xsl:call-template name="end-revflag">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:template>
  
  <!-- Return Value -->
  <xsl:template match="*[contains(@class,' cxxFunction/cxxFunctionReturnDesc ')]">    
    <xsl:if test="string-length(node()) > 0">
     	<xsl:call-template name="topic.section"/>
    </xsl:if>     
  </xsl:template>  
  <xsl:template match="*[contains(@class,' cxxFunction/cxxFunctionReturnDesc ')]" mode="get-output-class">
    <xsl:text>section returnsdoc</xsl:text>    
  </xsl:template>
  <xsl:template match="*[contains(@class,' cxxFunction/cxxFunctionReturnDesc ')]" mode="section-fmt">
	  <xsl:variable name="flagrules">
	    <xsl:call-template name="getrules"/>
	  </xsl:variable>
	  <xsl:call-template name="start-revflag">
	    <xsl:with-param name="flagrules" select="$flagrules"/>  
	  </xsl:call-template>	  
	  <dl class="returnsdoc">
	  	<dt class="dlterm">Return Value</dt>
	  	<dd><xsl:apply-templates select="*[not(contains(@class,' topic/title '))] | text() | comment() | processing-instruction()"/></dd>
	  </dl>
	  <xsl:call-template name="end-revflag">
	    <xsl:with-param name="flagrules" select="$flagrules"/>  
	  </xsl:call-template>    
  </xsl:template>  
  
  <!-- Variable -->
  <!-- ===================================================================== -->
  
  <!-- Variable title -->
  <xsl:template match="*[contains(@class, ' cxxVariable/cxxVariable ')]/*[contains(@class, ' topic/title ')]" mode="cxxapiref.title-fmt">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- Variable member index row -->
  <xsl:template match="*[contains(@class, ' cxxVariable/cxxVariable ')]" mode="class-members">
    <tr>
      <xsl:if test="position() mod 2 = 0">
        <xsl:attribute name="class">bg</xsl:attribute>  
      </xsl:if>
      <td align="right" valign="top" class="code">
        <xsl:apply-templates select="*[contains(@class, ' cxxVariable/cxxVariableDetail ')]/*[contains(@class, ' cxxVariable/cxxVariableDefinition ')]/*[contains(@class, ' cxxVariable/cxxVariableDeclaredType ')]/node()"/>
      </td>
      <td>
        <a href="#{@id}">
          <xsl:apply-templates select="*[contains(@class, ' topic/title ')]/node()"/>
        </a>
      </td>
    </tr>
  </xsl:template>
  
  <!-- Variable body -->
  <xsl:template match="*[contains(@class, ' cxxVariable/cxxVariableDetail ')]">
    <xsl:apply-templates select="*[contains(@class, ' cxxVariable/cxxVariableDefinition ')]" mode="signature"/>
    <xsl:apply-templates select="../*[contains(@class,' topic/shortdesc ')]" mode="section-fmt"/>    
    <xsl:apply-templates select="*[(contains(@class, ' topic/section ') or
                                    contains(@class, ' topic/example ')) and
                                   not(contains(@class, ' apiRef/apiDef '))]"/>
  </xsl:template>
  
  <!-- Variable signature -->
  <xsl:template match="*[contains(@class, ' cxxVariable/cxxVariableDefinition ')]" mode="signature">
    <xsl:variable name="meta">
      <xsl:call-template name="meta-signature"/>
    </xsl:variable>
    <div class="section signature">
    <table class="signature">
      <tr>
        <td>
          <xsl:apply-templates select="*[contains(@class, ' cxxVariable/cxxVariableDeclaredType ')]/node()"/>
        </td>
        <td>
          <xsl:apply-templates select="ancestor::*[contains(@class, ' cxxVariable/cxxVariable ')][1]/*[contains(@class, ' topic/title ')]/node()"/>
        </td>
        <xsl:if test="normalize-space($meta)">
          <td>
            <xsl:value-of select="normalize-space($meta)"/>
          </td>
        </xsl:if>
      </tr>
    </table>
    </div>
  </xsl:template>
  
  <!-- Enumeration -->
  <!-- ===================================================================== -->
  
  <!-- Enumeration title -->
  <xsl:template match="*[contains(@class, ' cxxEnumeration/cxxEnumeration ')]/*[contains(@class, ' topic/title ')]" mode="cxxapiref.title-fmt">
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'Enum'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:choose>
      <xsl:when test="starts-with(., '@')">
        <xsl:text>anonymous</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Enumeration member index row -->
  <xsl:template match="*[contains(@class, ' cxxEnumeration/cxxEnumeration ')]" mode="class-members">
    <tr>
      <xsl:if test="position() mod 2 = 0">
        <xsl:attribute name="class">bg</xsl:attribute>  
      </xsl:if>
      <td align="right" valign="top" class="code">
        <xsl:text>enum</xsl:text>
      </td>
      <td>
        <a href="#{@id}">
          <xsl:choose>
           <xsl:when test="starts-with(*[contains(@class, ' topic/title ')], '@')">
             <xsl:text>anonymous</xsl:text>
           </xsl:when>
           <xsl:otherwise>
             <xsl:apply-templates select="*[contains(@class, ' topic/title ')]/node()"/>
           </xsl:otherwise>
         </xsl:choose>
        </a>
        <xsl:text> { </xsl:text>
        <xsl:variable name="enumerators"
                      select="*[contains(@class, ' cxxEnumeration/cxxEnumerationDetail ')]/
                                *[contains(@class, ' cxxEnumeration/cxxEnumerationDefinition ')]/
                                  *[contains(@class, ' cxxEnumeration/cxxEnumerators ')]/
                                    *[contains(@class, ' cxxEnumeration/cxxEnumerator ')]"/>
        
        <xsl:for-each select="*[contains(@class, ' cxxEnumeration/cxxEnumerationDetail ')]/
                                *[contains(@class, ' cxxEnumeration/cxxEnumerationDefinition ')]/
                                  *[contains(@class, ' cxxEnumeration/cxxEnumerators ')]/
                                    *[contains(@class, ' cxxEnumeration/cxxEnumerator ')]">
          <xsl:if test="not(position() > 4)">
	          <xsl:if test="not(position() = 1)">, </xsl:if>
	          <a href="#{@id}">
	            <xsl:apply-templates select="*[contains(@class, ' apiRef/apiName ')]/node()"/>  
	          </a>
          </xsl:if>          
          <xsl:if test="position() = count($enumerators)">
            <xsl:if test="count($enumerators) > 5">
              <xsl:text>, ...</xsl:text>
            </xsl:if>
            <xsl:if test="count($enumerators) > 4">
              <xsl:text>, </xsl:text>
		      <a href="#{@id}">
		        <xsl:apply-templates select="*[contains(@class, ' apiRef/apiName ')]/node()"/>  
		      </a>
	        </xsl:if>
          </xsl:if>
        </xsl:for-each>
        <xsl:text> }</xsl:text>                        
      </td>
    </tr>
  </xsl:template>
  
  <!-- Enumeration body -->
  <xsl:template match="*[contains(@class, ' cxxEnumeration/cxxEnumerationDetail ')]">
    <xsl:call-template name="topic.section"/>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxEnumeration/cxxEnumerationDetail ')]" mode="get-output-class">
    <xsl:text>section enumerationdetail</xsl:text>
  </xsl:template>  
  <xsl:template match="*[contains(@class, ' cxxEnumeration/cxxEnumerationDetail ')]" mode="section-fmt">
    <xsl:apply-templates select="../*[contains(@class,' topic/shortdesc ')]" mode="section-fmt"/> 
    <xsl:apply-templates select="*[(contains(@class, ' topic/section ') or
                                    contains(@class, ' topic/example ')) and
                                   not(contains(@class, ' apiRef/apiDef '))]"/>
                                  
    <xsl:apply-templates select="*[contains(@class, ' cxxEnumeration/cxxEnumerationDefinition ')]/*[contains(@class, ' cxxEnumeration/cxxEnumerators ')]"/>    
  </xsl:template>  
  
  <xsl:template match="*[contains(@class, ' cxxEnumeration/cxxEnumerators ')]">
    <xsl:call-template name="topic.section"/>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxEnumeration/cxxEnumerators ')]" mode="get-output-class">
    <xsl:text>section enumerators</xsl:text>
  </xsl:template>
  <xsl:template match="*[contains(@class, ' cxxEnumeration/cxxEnumerators ')]" mode="section-fmt">
    <xsl:variable name="flagrules">
      <xsl:call-template name="getrules"/>
    </xsl:variable>
    <xsl:call-template name="start-revflag">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
    
    <!-- <h4 class="sectiontitle">Enumerators</h4>  -->    
    <xsl:variable name="enumerators" select="*[contains(@class, ' cxxEnumeration/cxxEnumerator ')]"/>
    <xsl:if test="$enumerators">
      <table  class="enumerators">
        <thead><tr><th>Enumerator</th><th>Value</th><th>Description</th></tr></thead>
        <xsl:for-each select="$enumerators">
          <tr>
            <xsl:if test="position() mod 2 = 0">
              <xsl:attribute name="class">bg</xsl:attribute>  
            </xsl:if>
            <td>
              <xsl:call-template name="commonattributes"/>
              <a name="{@id}" />
              <span class="enumerator"><xsl:apply-templates select="*[contains(@class, ' apiRef/apiName ')]/node()"/></span>    
            </td>
            <td>
              <xsl:for-each select="*[contains(@class, ' cxxEnumeration/cxxEnumeratorInitialiser ')]">
                <xsl:apply-templates select="@value"/>
              </xsl:for-each>            
            </td>
            <td>
			  <xsl:apply-templates select="*[contains(@class,' topic/shortdesc ')]/node()" />
              <xsl:apply-templates select="*[contains(@class, ' apiRef/apiDesc ')]/node()"/>
              <xsl:text> </xsl:text>
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </xsl:if>
    
    <xsl:call-template name="end-revflag">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Type definition-->
  <!-- ===================================================================== -->
  
  <!-- Type definition title -->
  <xsl:template match="*[contains(@class, ' cxxTypedef/cxxTypedef ')]/*[contains(@class, ' topic/title ')]" mode="cxxapiref.title-fmt">
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'Typedef'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' cxxTypedef/cxxTypedef ')]" mode="class-members">
    <tr>
      <xsl:if test="position() mod 2 = 0">
        <xsl:attribute name="class">bg</xsl:attribute>  
      </xsl:if>
      <td align="right" valign="top" class="code">
        <xsl:text>typedef</xsl:text>
      </td>
      <td>
        <xsl:apply-templates select="*[contains(@class, ' cxxTypedef/cxxTypedefDetail ')]/
                                       *[contains(@class, ' cxxTypedef/cxxTypedefDefinition ')]/
                                         *[contains(@class, ' cxxTypedef/cxxTypedefDeclaredType ')]/node()"/>
        <xsl:text> </xsl:text>
        <a href="#{@id}">
          <xsl:apply-templates select="*[contains(@class, ' topic/title ')]/node()"/>
        </a>
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' cxxTypedef/cxxTypedefDetail ')]">
    <xsl:apply-templates select="*[contains(@class, ' cxxTypedef/cxxTypedefDefinition ')]" mode="signature"/>
    <xsl:apply-templates select="../*[contains(@class,' topic/shortdesc ')]" mode="section-fmt"/>    
    <xsl:apply-templates select="*[(contains(@class, ' topic/section ') or
                                    contains(@class, ' topic/example ')) and
                                   not(contains(@class, ' apiRef/apiDef '))]"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' cxxTypedef/cxxTypedefDefinition ')]" mode="signature">
    <xsl:variable name="meta">
      <xsl:call-template name="meta-signature"/>
    </xsl:variable>
    <div class="section signature">
    <table class="signature">
      <tr>
        <td>
          <xsl:text>typedef </xsl:text>
          <xsl:apply-templates select="*[contains(@class, ' cxxTypedef/cxxTypedefDeclaredType ')]/node()"/>
        </td>
        <td>
          <xsl:apply-templates select="ancestor::*[contains(@class, ' cxxTypedef/cxxTypedef ')][1]/*[contains(@class, ' topic/title ')]/node()"/>
        </td>
        <xsl:if test="normalize-space($meta)">
          <td>
            <xsl:value-of select="normalize-space($meta)"/>
          </td>
        </xsl:if>
      </tr>
    </table>
    </div>
  </xsl:template>
  
</xsl:stylesheet>