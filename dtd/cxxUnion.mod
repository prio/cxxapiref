<!-- ================================================================= -->
<!--                    HEADER                                         -->
<!-- ================================================================= -->
<!--  MODULE:    C++ Union DTD                                         -->
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
PUBLIC "-//NOKIA//DTD DITA C++ API Union Reference Type v0.7.0//EN"
      Delivered as file "cxxUnion.dtd"                                 -->
 
<!-- ================================================================= -->
<!-- SYSTEM:     Darwin Information Typing Architecture (DITA)         -->
<!--                                                                   -->
<!-- PURPOSE:    C++ API Reference for Unions                          -->
<!--                                                                   -->
<!-- ORIGINAL CREATION DATE:                                           -->
<!--             November 2009                                         -->
<!--                                                                   -->
<!-- Copyright (c) 2009-2011 Nokia Corporation and/or its subsidiary(-ies). -->
<!-- All rights reserved.                                              -->
<!--                                                                   -->
<!--  Change History (latest at top):                                  -->
<!--  +++++++++++++++++++++++++++++++                                  -->
<!--  2011-02-28 Nokia Sysdoc Tools Team, London: Updated to version 0.7.0 -->
<!--  2011-02-21 JonHarrington: Removing spurious Definition elements. -->
<!--  2010-05-14 PaulRoss: Fixed templates.                            -->
<!--  2010-02-16 VOG: Updated.                                         -->
<!--  2010-02-10 PaulRoss: Updated.                                    -->
<!--  2009-11-16 PaulRoss: Initial design.                             -->
<!--                                                                   -->
<!-- ================================================================= -->

<!--
Copyright (c) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
All rights reserved.
-->

<!-- ============ Hooks for domain extension ============ -->
<!ENTITY % cxxUnion                             "cxxUnion">
<!ENTITY % cxxUnionDetail                       "cxxUnionDetail">
<!ENTITY % cxxUnionDefinition                   "cxxUnionDefinition">
<!ENTITY % cxxUnionAccessSpecifier              "cxxUnionAccessSpecifier">
<!-- union has no inheritance  
<!ENTITY % cxxUnionDerivations                  "cxxUnionDerivations">
<!ENTITY % cxxUnionDerivation                   "cxxUnionDerivation">
-->
<!ENTITY % cxxUnionTemplateParameters           "cxxUnionTemplateParameters">
<!ENTITY % cxxUnionTemplateParameter            "cxxUnionTemplateParameter">
<!ENTITY % cxxUnionTemplateParameterType        "cxxUnionTemplateParameterType">

<!-- Derivation -->
<!-- union has no inheritance  
<!ENTITY % cxxUnionDerivationAccessSpecifier    "cxxUnionDerivationAccessSpecifier">
<!ENTITY % cxxUnionDerivationVirtual            "cxxUnionDerivationVirtual">
<!ENTITY % cxxUnionBaseClass                    "cxxUnionBaseClass">
<!ENTITY % cxxUnionBaseStruct                   "cxxUnionBaseStruct">
<!ENTITY % cxxUnionBaseUnion                    "cxxUnionBaseUnion">
<!ENTITY % cxxUnionInherits                     "cxxUnionInherits">
<!ENTITY % cxxUnionInheritsDetail               "cxxUnionInheritsDetail">

<!ENTITY % cxxUnionFunctionInherited            "cxxUnionFunctionInherited">
<!ENTITY % cxxUnionVariableInherited            "cxxUnionVariableInherited">
<!ENTITY % cxxUnionEnumerationInherited         "cxxUnionEnumerationInherited">
-->
<!-- Nested members -->
<!ENTITY % cxxUnionNested                       "cxxUnionNested">
<!ENTITY % cxxUnionNestedDetail                 "cxxUnionNestedDetail">
<!ENTITY % cxxUnionNestedClass                  "cxxUnionNestedClass">
<!ENTITY % cxxUnionNestedStruct                 "cxxUnionNestedStruct">
<!ENTITY % cxxUnionNestedUnion                  "cxxUnionNestedUnion">

<!-- Location elements -->
<!ENTITY % cxxUnionAPIItemLocation              "cxxUnionAPIItemLocation">
<!ENTITY % cxxUnionDeclarationFile              "cxxUnionDeclarationFile">
<!ENTITY % cxxUnionDeclarationFileLineStart     "cxxUnionDeclarationFileLineStart">
<!ENTITY % cxxUnionDeclarationFileLineEnd       "cxxUnionDeclarationFileLineEnd">

<!-- ============ Hooks for shell DTD ============ -->

<!ENTITY % cxxUnion-types-default
    "cxxUnionNested | cxxFunction | cxxVariable | cxxEnumeration | cxxTypedef">
<!ENTITY % cxxUnion-info-types  "%cxxUnion-types-default;">

<!ENTITY % cxxUnionNested-types-default "no-topic-nesting">
<!ENTITY % cxxUnionNested-info-types  "%cxxUnionNested-types-default;">

<!ENTITY included-domains "">

<!-- ============ Topic specializations ============ -->

<!ELEMENT cxxUnion   (
                        (%apiName;),
                        (%shortdesc;)?,
                        (%prolog;)?,
                        (%cxxUnionDetail;),
                        (%related-links;)?,
                        (%cxxUnion-info-types;)*
                      )
>
<!-- union has no inheritance    (%cxxUnionInherits;)*  -->
<!ATTLIST cxxUnion       id ID #REQUIRED
                          conref CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          %arch-atts;
                          domains CDATA "&included-domains;"
                          %select-atts;
>

<!ELEMENT cxxUnionDetail  ((%cxxUnionDefinition;)?, (%apiDesc;)?, (%example; | %section; | %apiImpl;)*)>
<!ATTLIST cxxUnionDetail  %id-atts;
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          outputclass CDATA #IMPLIED>

<!ELEMENT cxxUnionDefinition   (
                                    (%cxxUnionAccessSpecifier;)?,
                                    (%cxxUnionTemplateParameters;)?,
                                    (%cxxUnionAPIItemLocation;)
                               )
>
<!-- union has no inheritance       (%cxxUnionDerivations;)?,   -->
<!ATTLIST cxxUnionDefinition    spectitle CDATA #IMPLIED
                                  %univ-atts;
                                  outputclass CDATA #IMPLIED
>

<!ELEMENT cxxUnionAccessSpecifier  EMPTY>
<!ATTLIST cxxUnionAccessSpecifier  name CDATA #FIXED "access"
                          value (public|protected|private) "public"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!-- Templates-->
<!ELEMENT cxxUnionTemplateParameters   (%cxxUnionTemplateParameter;)+ >
<!ATTLIST cxxUnionTemplateParameters    %univ-atts;
										outputclass CDATA #IMPLIED
>

<!ELEMENT cxxUnionTemplateParameter   	(%cxxUnionTemplateParameterType;,
										(%apiDefNote;)?
										)
>
<!ATTLIST cxxUnionTemplateParameter    %univ-atts;
										outputclass CDATA #IMPLIED
>

<!ELEMENT cxxUnionTemplateParameterType   (#PCDATA | %apiRelation;)*>
<!ATTLIST cxxUnionTemplateParameterType    %univ-atts;
											outputclass CDATA #IMPLIED
>

<!-- Location -->
<!ELEMENT cxxUnionAPIItemLocation   (
                                        %cxxUnionDeclarationFile;,
                                        %cxxUnionDeclarationFileLineStart;,
                                        %cxxUnionDeclarationFileLineEnd;
                                     )
>
<!ATTLIST cxxUnionAPIItemLocation    %univ-atts;
                                    outputclass CDATA #IMPLIED
>

<!ELEMENT cxxUnionDeclarationFile  EMPTY>
<!ATTLIST cxxUnionDeclarationFile  name CDATA #FIXED "filePath"
                                  value CDATA #REQUIRED
                                  %univ-atts;
                                  outputclass CDATA #IMPLIED
>

<!ELEMENT cxxUnionDeclarationFileLineStart  EMPTY>
<!ATTLIST cxxUnionDeclarationFileLineStart   name CDATA #FIXED "lineNumber"
                                             value CDATA #REQUIRED
                                             %univ-atts;
                                             outputclass CDATA #IMPLIED
>

<!ELEMENT cxxUnionDeclarationFileLineEnd  EMPTY>
<!ATTLIST cxxUnionDeclarationFileLineEnd   name CDATA #FIXED "lineNumber"
                                             value CDATA #REQUIRED
                                             %univ-atts;
                                             outputclass CDATA #IMPLIED
>

<!-- Nested members -->
<!ELEMENT cxxUnionNested (
                        (%cxxUnionNestedDetail;),
                        (%cxxUnionNested-info-types;)*
                         )
>
<!ATTLIST cxxUnionNested  conref CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          %arch-atts;
                          domains CDATA "&included-domains;"
>

<!ELEMENT cxxUnionNestedDetail  ( (%cxxUnionNestedClass;) | (%cxxUnionNestedStruct;) | (%cxxUnionNestedUnion;) )+>
<!ATTLIST cxxUnionNestedDetail  %id-atts;
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          outputclass CDATA #IMPLIED
>


<!ELEMENT cxxUnionNestedClass  (#PCDATA)*>
<!ATTLIST cxxUnionNestedClass  href CDATA #IMPLIED
                              keyref CDATA #IMPLIED
                              type   CDATA  #IMPLIED
                              %univ-atts;
                              format        CDATA   #IMPLIED
                              scope (local | peer | external) #IMPLIED
                              outputclass CDATA #IMPLIED
>

<!ELEMENT cxxUnionNestedStruct  (#PCDATA)*>
<!ATTLIST cxxUnionNestedStruct  href CDATA #IMPLIED
                              keyref CDATA #IMPLIED
                              type   CDATA  #IMPLIED
                              %univ-atts;
                              format        CDATA   #IMPLIED
                              scope (local | peer | external) #IMPLIED
                              outputclass CDATA #IMPLIED
>

<!ELEMENT cxxUnionNestedUnion  (#PCDATA)*>
<!ATTLIST cxxUnionNestedUnion  href CDATA #IMPLIED
                              keyref CDATA #IMPLIED
                              type   CDATA  #IMPLIED
                              %univ-atts;
                              format        CDATA   #IMPLIED
                              scope (local | peer | external) #IMPLIED
                              outputclass CDATA #IMPLIED
>


<!-- ============ Class attributes for type ancestry ============ -->
<!ATTLIST cxxUnion   %global-atts;
    class  CDATA "- topic/topic reference/reference apiRef/apiRef apiClassifier/apiClassifier cxxUnion/cxxUnion ">
<!ATTLIST cxxUnionDetail   %global-atts;
    class  CDATA "- topic/body reference/refbody apiRef/apiDetail apiClassifier/apiClassifierDetail cxxUnion/cxxUnionDetail ">
<!ATTLIST cxxUnionDefinition   %global-atts;
    class  CDATA "- topic/section reference/section apiRef/apiDef apiClassifier/apiClassifierDef cxxUnion/cxxUnionDefinition ">
<!ATTLIST cxxUnionAccessSpecifier   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiClassifier/apiQualifier cxxUnion/cxxUnionAccessSpecifier ">

<!-- Templates -->
<!ATTLIST cxxUnionTemplateParameters   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiClassifier/apiDefItem cxxUnion/cxxUnionTemplateParameters ">
<!ATTLIST cxxUnionTemplateParameter   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiClassifier/apiDefItem cxxUnion/cxxUnionTemplateParameter ">
<!ATTLIST cxxUnionTemplateParameterType   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiClassifier/apiDefItem cxxUnion/cxxUnionTemplateParameterType ">
    
<!-- Nested members  -->
<!ATTLIST cxxUnionNested   %global-atts;
    class  CDATA "- topic/topic reference/reference apiRef/apiRef apiClassifier/apiClassifier cxxUnion/cxxUnionNested ">
<!ATTLIST cxxUnionNestedDetail   %global-atts;
    class  CDATA "- topic/body reference/refbody apiRef/apiDetail apiClassifier/apiDetail cxxUnion/cxxUnionNestedDetail ">    
<!ATTLIST cxxUnionNestedClass   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiClassifier/apiRelation cxxUnion/cxxUnionNestedClass ">
<!ATTLIST cxxUnionNestedStruct   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiClassifier/apiRelation cxxUnion/cxxUnionNestedStruct ">
<!ATTLIST cxxUnionNestedUnion   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiClassifier/apiRelation cxxUnion/cxxUnionNestedUnion ">

<!-- Location elements -->
<!ATTLIST cxxUnionAPIItemLocation   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiClassifier/apiDefItem cxxUnion/cxxUnionAPIItemLocation ">
<!ATTLIST cxxUnionDeclarationFile   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiClassifier/apiQualifier cxxUnion/cxxUnionDeclarationFile ">
<!ATTLIST cxxUnionDeclarationFileLineStart   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiUnionifier/apiQualifier cxxUnion/cxxUnionDeclarationFileLineStart ">
<!ATTLIST cxxUnionDeclarationFileLineEnd   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiUnionifier/apiQualifier cxxUnion/cxxUnionDeclarationFileLineEnd ">
