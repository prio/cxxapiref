<!-- ================================================================= -->
<!--                    HEADER                                         -->
<!-- ================================================================= -->
<!--  MODULE:    C++ Friend DTD                                        -->
<!--  VERSION:   0.7.0                                                 -->
<!--  DATE:      2011-02-28                                            -->
<!--                                                                   -->
<!-- ================================================================= -->

<!-- ================================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION                -->
<!--                    TYPICAL INVOCATION                             -->
<!--                                                                   -->
<!--  Refer to this file by the following public identifier or an 
      appropriate system identifier 
PUBLIC "-//NOKIA//DTD DITA C++ API Function Reference Type v0.7.0//EN"
      Delivered as file "cxxFriend.dtd"                              -->
 
<!-- ================================================================= -->
<!-- SYSTEM:     Darwin Information Typing Architecture (DITA)         -->
<!--                                                                   -->
<!-- PURPOSE:    C++ API Reference for Friends                         -->
<!--                                                                   -->
<!-- ORIGINAL CREATION DATE:                                           -->
<!--             Februrary 2011                                        -->
<!--                                                                   -->
<!-- Copyright (c) 2009-2011 Nokia Corporation and/or its subsidiary(-ies). -->
<!-- All rights reserved.                                              -->
<!--                                                                   -->
<!--  Change History (latest at top):                                  -->
<!--  +++++++++++++++++++++++++++++++                                  -->
<!--  2011-02-28 Nokia Sysdoc Tools Team, London: Updated to version 0.7.0 -->
<!--  2011-02-22 PaulRoss: Initial design.                             -->
<!--                                                                   -->
<!-- ================================================================= -->

<!--
Copyright (c) 2009-2011 Nokia Corporation and/or its subsidiary(-ies).
All rights reserved.
-->

<!-- ============ Hooks for domain extension ============ -->
<!ENTITY % cxxFriend                                  "cxxFriend">
<!ENTITY % cxxFriendDetail                            "cxxFriendDetail">
<!ENTITY % cxxFriendDefinition                        "cxxFriendDefinition">

<!ENTITY % cxxFriendDeclaredType                      "cxxFriendDeclaredType">
<!ENTITY % cxxFriendReturnDesc                        "cxxFriendReturnDesc">
<!ENTITY % cxxFriendScopedName                        "cxxFriendScopedName">
<!ENTITY % cxxFriendPrototype                         "cxxFriendPrototype">
<!ENTITY % cxxFriendNameLookup                        "cxxFriendNameLookup">
<!ENTITY % cxxFriendExceptionSpecification            "cxxFriendExceptionSpecification">
<!ENTITY % cxxFriendReimplemented                     "cxxFriendReimplemented">

<!-- Parameters -->
<!ENTITY % cxxFriendParameters                        "cxxFriendParameters">
<!ENTITY % cxxFriendParameter                         "cxxFriendParameter">
<!ENTITY % cxxFriendParameterDeclaredType             "cxxFriendParameterDeclaredType">
<!ENTITY % cxxFriendParameterDeclarationName          "cxxFriendParameterDeclarationName">
<!ENTITY % cxxFriendParameterDefinitionName           "cxxFriendParameterDefinitionName">
<!ENTITY % cxxFriendParameterDefaultValue             "cxxFriendParameterDefaultValue">

<!-- Storage class specifiers and other qualifiers. -->
<!ENTITY % cxxFriendStorageClassSpecifierExtern       "cxxFriendStorageClassSpecifierExtern">
<!ENTITY % cxxFriendStorageClassSpecifierStatic       "cxxFriendStorageClassSpecifierStatic">
<!ENTITY % cxxFriendStorageClassSpecifierMutable      "cxxFriendStorageClassSpecifierMutable">
<!ENTITY % cxxFriendVolatile                          "cxxFriendVolatile">

<!ENTITY % cxxFriendExplicit                          "cxxFriendExplicit">
<!ENTITY % cxxFriendInline                            "cxxFriendInline">
<!ENTITY % cxxFriendVirtual                           "cxxFriendVirtual">
<!ENTITY % cxxFriendPureVirtual                       "cxxFriendPureVirtual">
<!ENTITY % cxxFriendConstructor                       "cxxFriendConstructor">
<!ENTITY % cxxFriendDestructor                        "cxxFriendDestructor">

<!-- Location information -->
<!ENTITY % cxxFriendAPIItemLocation                   "cxxFriendAPIItemLocation">
<!ENTITY % cxxFriendDeclarationFile                   "cxxFriendDeclarationFile">
<!ENTITY % cxxFriendDeclarationFileLine               "cxxFriendDeclarationFileLine">
<!ENTITY % cxxFriendDefinitionFile                    "cxxFriendDefinitionFile">
<!ENTITY % cxxFriendDefinitionFileLineStart           "cxxFriendDefinitionFileLineStart">
<!ENTITY % cxxFriendDefinitionFileLineEnd             "cxxFriendDefinitionFileLineEnd">

<!-- Templates  -->
<!ENTITY % cxxFriendTemplateParameters            	"cxxFriendTemplateParameters">
<!ENTITY % cxxFriendTemplateParameter            		"cxxFriendTemplateParameter">
<!ENTITY % cxxFriendTemplateParameterType        		"cxxFriendTemplateParameterType">

<!-- ============ Hooks for shell DTD ============ -->
<!ENTITY % cxxFriend-types-default  "no-topic-nesting">
<!ENTITY % cxxFriend-info-types     "%cxxFriend-types-default;">

<!ENTITY included-domains "">


<!-- ============ Topic specializations ============ -->
<!ELEMENT cxxFriend   ( (%apiName;), (%shortdesc;)?, (%prolog;)?, (%cxxFriendDetail;), (%related-links;)?, (%cxxFriend-info-types;)* )>
<!ATTLIST cxxFriend      id ID #REQUIRED
                          conref CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          %arch-atts;
                          domains CDATA "&included-domains;"
                          %select-atts;
>

<!ELEMENT cxxFriendDetail  (%cxxFriendDefinition;, (%apiDesc;)?, (%example; | %section; | %apiImpl;)*)>
<!ATTLIST cxxFriendDetail  %id-atts;
                              translate (yes|no) #IMPLIED
                              xml:lang NMTOKEN #IMPLIED
                              outputclass CDATA #IMPLIED>

<!ELEMENT cxxFriendDefinition   (
                                    (%cxxFriendStorageClassSpecifierExtern;)?,
                                    (%cxxFriendStorageClassSpecifierStatic;)?,
                                    (%cxxFriendStorageClassSpecifierMutable;)?,
                                    (%cxxFriendExplicit;)?,
                                    (%cxxFriendInline;)?,
                                    (%cxxFriendVirtual;)?,
                                    (%cxxFriendPureVirtual;)?,
                                    (%cxxFriendConstructor;)?,
                                    (%cxxFriendDestructor;)?,

                                    (%cxxFriendDeclaredType;)?,

                                    (%cxxFriendScopedName;)?,
                                    (%cxxFriendPrototype;)?,
                                    (%cxxFriendNameLookup;)?,
									(%cxxFriendExceptionSpecification;)?,

                                    (%cxxFriendReimplemented;)?,
									
									(%cxxFriendTemplateParameters;)?,
                                    (%cxxFriendParameters;)?,

                                    (%cxxFriendReturnDesc;)?,

                                    (%cxxFriendAPIItemLocation;)?
                                   )
>
<!ATTLIST cxxFriendDefinition    spectitle CDATA #IMPLIED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendDeclaredType   (
                                        #PCDATA
                                        | %apiRelation;
                                     )*
>
<!ATTLIST cxxFriendDeclaredType    %univ-atts;
                                        outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendReturnDesc   (
                                        #PCDATA
                                        | %apiRelation;
                                     )*
>
<!ATTLIST cxxFriendReturnDesc    %univ-atts;
                                        outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendScopedName   (#PCDATA)*>
<!ATTLIST cxxFriendScopedName     href CDATA #IMPLIED
                                    keyref CDATA #IMPLIED
                                    type   CDATA  #IMPLIED
                                    %univ-atts;
                                    outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendPrototype   (#PCDATA)*>
<!ATTLIST cxxFriendPrototype    %univ-atts;
                                    outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendNameLookup   (#PCDATA)*>
<!ATTLIST cxxFriendNameLookup    %univ-atts;
                                    outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendExceptionSpecification   (
                                        #PCDATA
                                        | %apiRelation;
                                     )*
>
<!ATTLIST cxxFriendExceptionSpecification    %univ-atts;
                                        outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendReimplemented  (#PCDATA)*>
<!ATTLIST cxxFriendReimplemented href CDATA #IMPLIED
                                      keyref CDATA #IMPLIED
                                      type   CDATA  #IMPLIED
                                      %univ-atts;
                                      format        CDATA   #IMPLIED
                                      scope (local | peer | external) #IMPLIED
                                      outputclass CDATA #IMPLIED
>

<!-- Friend Parameters -->
<!ELEMENT cxxFriendParameters   (%cxxFriendParameter;)* >
<!ATTLIST cxxFriendParameters    %univ-atts;
                                    outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendParameter  (
                                    %cxxFriendParameterDeclaredType;,
                                    (%cxxFriendParameterDeclarationName;)?,
                                    (%cxxFriendParameterDefinitionName;)?,
                                    (%cxxFriendParameterDefaultValue;)?,
                                    (%apiDefNote;)?
                                )
>
<!ATTLIST cxxFriendParameter  %univ-atts;
                                outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendParameterDeclaredType  (
                                                #PCDATA
                                                | %apiRelation;
                                            )*
>
<!ATTLIST cxxFriendParameterDeclaredType  %univ-atts;
                                            outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendParameterDeclarationName  (#PCDATA)*>
<!ATTLIST cxxFriendParameterDeclarationName  %univ-atts;
                                                outputclass CDATA #IMPLIED
>


<!ELEMENT cxxFriendParameterDefinitionName  (#PCDATA)*>
<!ATTLIST cxxFriendParameterDefinitionName  %univ-atts;
                                                outputclass CDATA #IMPLIED
>

<!-- TODO: This encloses PCDATA but linkifyTextDITA() is called. -->
<!ELEMENT cxxFriendParameterDefaultValue  (
                                                #PCDATA
                                                | %apiRelation;
                                            )*
>
<!ATTLIST cxxFriendParameterDefaultValue  %univ-atts;
                                            outputclass CDATA #IMPLIED
>


<!-- Storage class specifiers and other qualifiers. -->
<!ELEMENT cxxFriendStorageClassSpecifierExtern  EMPTY>
<!ATTLIST cxxFriendStorageClassSpecifierExtern  name CDATA #FIXED "extern"
                          value CDATA #FIXED "extern"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendStorageClassSpecifierStatic  EMPTY>
<!ATTLIST cxxFriendStorageClassSpecifierStatic  name CDATA #FIXED "static"
                          value CDATA #FIXED "static"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendStorageClassSpecifierMutable  EMPTY>
<!ATTLIST cxxFriendStorageClassSpecifierMutable  name CDATA #FIXED "mutable"
                          value CDATA #FIXED "mutable"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendVolatile EMPTY>
<!ATTLIST cxxFriendVolatile  name CDATA #FIXED "volatile"
                          value CDATA #FIXED "volatile"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendExplicit  EMPTY>
<!ATTLIST cxxFriendExplicit  name CDATA #FIXED "explicit"
                          value CDATA #FIXED "explicit"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendInline  EMPTY>
<!ATTLIST cxxFriendInline  name CDATA #FIXED "inline"
                          value CDATA #FIXED "inline"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendConstructor  EMPTY>
<!ATTLIST cxxFriendConstructor  name CDATA #FIXED "constructor"
                          value CDATA #FIXED "constructor"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendDestructor  EMPTY>
<!ATTLIST cxxFriendDestructor  name CDATA #FIXED "destructor"
                          value CDATA #FIXED "destructor"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendVirtual  EMPTY>
<!ATTLIST cxxFriendVirtual  name CDATA #FIXED "virtual"
                          value CDATA #FIXED "virtual"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendPureVirtual  EMPTY>
<!ATTLIST cxxFriendPureVirtual  name CDATA #FIXED "pure virtual"
                          value CDATA #FIXED "pure virtual"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!-- Location information -->
<!ELEMENT cxxFriendAPIItemLocation   (
                                            %cxxFriendDeclarationFile;,
                                            %cxxFriendDeclarationFileLine;,
                                            (%cxxFriendDefinitionFile;)?,
                                            (%cxxFriendDefinitionFileLineStart;)?,
                                            (%cxxFriendDefinitionFileLineEnd;)?
                                        )
>
<!ATTLIST cxxFriendAPIItemLocation    %univ-atts;
                                        outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendDeclarationFile  EMPTY>
<!ATTLIST cxxFriendDeclarationFile  name CDATA #FIXED "filePath"
                                      value CDATA #REQUIRED
                                      %univ-atts;
                                      outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendDeclarationFileLine  EMPTY>
<!ATTLIST cxxFriendDeclarationFileLine   name CDATA #FIXED "lineNumber"
                                            value CDATA #REQUIRED
                                            %univ-atts;
                                            outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendDefinitionFile  EMPTY>
<!ATTLIST cxxFriendDefinitionFile  name CDATA #FIXED "filePath"
                                      value CDATA #REQUIRED
                                      %univ-atts;
                                      outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendDefinitionFileLineStart  EMPTY>
<!ATTLIST cxxFriendDefinitionFileLineStart  name CDATA #FIXED "lineNumber"
                                                value CDATA #REQUIRED
                                                %univ-atts;
                                                outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendDefinitionFileLineEnd  EMPTY>
<!ATTLIST cxxFriendDefinitionFileLineEnd  name CDATA #FIXED "lineNumber"
                                            value CDATA #REQUIRED
                                            %univ-atts;
                                            outputclass CDATA #IMPLIED
>

<!-- Templates -->
<!ELEMENT cxxFriendTemplateParameters   (%cxxFriendTemplateParameter;)+ >
<!ATTLIST cxxFriendTemplateParameters    %univ-atts;
                                           outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendTemplateParameter   	( %cxxFriendTemplateParameterType;,
											(%apiDefNote;)?
																			)
>
<!ATTLIST cxxFriendTemplateParameter    %univ-atts;
											outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFriendTemplateParameterType   (#PCDATA | %apiRelation;)*>
<!ATTLIST cxxFriendTemplateParameterType    %univ-atts;
											outputclass CDATA #IMPLIED
>

<!-- ============ Class attributes for type ancestry ============ -->

<!ATTLIST cxxFriend   %global-atts; %select-atts;
    class  CDATA "- topic/topic reference/reference apiRef/apiRef apiOperation/apiOperation cxxFriend/cxxFriend ">
<!ATTLIST cxxFriendDetail   %global-atts;
    class  CDATA "- topic/body reference/refbody apiRef/apiDetail apiOperation/apiOperationDetail cxxFriend/cxxFriendDetail ">
<!ATTLIST cxxFriendDefinition   %global-atts;
    class  CDATA "- topic/section reference/section apiRef/apiDef apiOperation/apiOperationDef cxxFriend/cxxFriendDefinition ">
    
<!ATTLIST cxxFriendScopedName   %global-atts;
    class  CDATA "- topic/keyword reference/keyword apiRef/apiItemName apiOperation/apiItemName cxxFriend/cxxFriendScopedName ">   
<!ATTLIST cxxFriendNameLookup   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiDefItem cxxFriend/cxxFriendNameLookup ">   
<!ATTLIST cxxFriendPrototype   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiDefItem cxxFriend/cxxFriendPrototype ">     
<!ATTLIST cxxFriendReimplemented   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiOperation/apiRelation cxxFriend/cxxFriendReimplemented ">
<!ATTLIST cxxFriendExceptionSpecification   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiDefItem cxxFriend/cxxFriendExceptionSpecification ">     

<!-- Type information -->
<!ATTLIST cxxFriendDeclaredType   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiDefItem cxxFriend/cxxFriendDeclaredType ">    
<!ATTLIST cxxFriendReturnDesc   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefNote cxxFriend/cxxFriendReturnDesc ">    

<!-- Operation qualifiers -->
<!ATTLIST cxxFriendStorageClassSpecifierExtern   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendStorageClassSpecifierExtern ">
<!ATTLIST cxxFriendStorageClassSpecifierStatic   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendStorageClassSpecifierStatic ">
<!ATTLIST cxxFriendStorageClassSpecifierMutable   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendStorageClassSpecifierMutable ">
<!ATTLIST cxxFriendVolatile   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendVolatile ">
<!ATTLIST cxxFriendExplicit   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendExplicit ">
<!ATTLIST cxxFriendInline   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendInline ">
<!ATTLIST cxxFriendConstructor   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendConstructor ">
<!ATTLIST cxxFriendDestructor   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendDestructor ">
<!ATTLIST cxxFriendVirtual   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendVirtual ">
<!ATTLIST cxxFriendPureVirtual   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendPureVirtual ">
    
<!-- Location elements -->
<!ATTLIST cxxFriendAPIItemLocation   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiDefItem cxxFriend/cxxFriendAPIItemLocation ">
<!ATTLIST cxxFriendDeclarationFile   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendDeclarationFile ">
<!ATTLIST cxxFriendDeclarationFileLine   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendDeclarationFileLine ">
<!ATTLIST cxxFriendDefinitionFile   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendDefinitionFile ">
<!ATTLIST cxxFriendDefinitionFileLineStart   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendDefinitionFileLineStart ">
<!ATTLIST cxxFriendDefinitionFileLineEnd   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier cxxFriend/cxxFriendDefinitionFileLineEnd ">
        
    
<!-- Parameter elements -->
<!ATTLIST cxxFriendParameters   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiDefItem cxxFriend/cxxFriendParameters "> 
<!ATTLIST cxxFriendParameter   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiDefItem cxxFriend/cxxFriendParameter ">     
<!ATTLIST cxxFriendParameterDeclarationName   %global-atts;
    class  CDATA "-  topic/keyword reference/keyword apiRef/apiItemName apiOperation/apiItemName cxxFriend/cxxFriendParameterDeclarationName ">
<!ATTLIST cxxFriendParameterDefinitionName   %global-atts;
    class  CDATA "- topic/keyword reference/keyword apiRef/apiItemName apiOperation/apiItemName cxxFriend/cxxFriendParameterDefinitionName ">
<!ATTLIST cxxFriendParameterDefaultValue   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiData apiOperation/apiData cxxFriend/cxxFriendParameterDefaultValue ">   
<!ATTLIST cxxFriendParameterDeclaredType   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiDefItem cxxFriend/cxxFriendParameterDeclaredType ">    
    
<!-- Templates -->
<!ATTLIST cxxFriendTemplateParameters   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiDefItem cxxFriend/cxxFriendTemplateParameters ">
<!ATTLIST cxxFriendTemplateParameter   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiDefItem cxxFriend/cxxFriendTemplateParameter ">
<!ATTLIST cxxFriendTemplateParameterType   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiDefItem cxxFriend/cxxFriendTemplateParameterType ">
