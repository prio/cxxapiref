<!-- ================================================================= -->
<!--                    HEADER                                         -->
<!-- ================================================================= -->
<!--  MODULE:    C++ File DTD                                          -->
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
PUBLIC "-//NOKIA//DTD DITA C++ API File Reference Type v0.7.0//EN"
      Delivered as file "cxxFile.dtd"                                  -->
 
<!-- ================================================================= -->
<!-- SYSTEM:     Darwin Information Typing Architecture (DITA)         -->
<!--                                                                   -->
<!-- PURPOSE:    C++ API Reference for Files                           -->
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
<!--  2010-02-18 VOG: Updated                                          -->
<!--  2010-02-10 PaulRoss: Updated.                                    -->
<!--  2009-11-16 PaulRoss: Initial design.                             -->
<!--                                                                   -->
<!-- ================================================================= -->

<!--
Copyright (c) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
All rights reserved.
-->

<!-- ============ Hooks for domain extension ============ -->
<!ENTITY % cxxFile                          "cxxFile">
<!ENTITY % cxxFileDetail                    "cxxFileDetail">
<!ENTITY % cxxFileAPIItemLocation           "cxxFileAPIItemLocation">
<!ENTITY % cxxFileDeclarationFile           "cxxFileDeclarationFile">

<!-- we use the rest from apiRef -->

<!-- ============ Hooks for shell DTD ============ -->
<!ENTITY % cxxFile-types-default  "cxxFunction | cxxDefine | cxxVariable | cxxEnumeration | cxxTypedef">
<!ENTITY % cxxFile-info-types     "%cxxFile-types-default;">

<!ENTITY included-domains "">

<!-- ============ Topic specializations ============ -->
<!ELEMENT cxxFile     (
                        (%apiSyntax;)?,
                        (%apiName;),
                        (%shortdesc;)?,
                        (%prolog;)?,
                        (%cxxFileDetail;),
                        (%related-links;)?,
                        (%cxxFile-info-types;)*
                       )
>
<!ATTLIST cxxFile     id ID #REQUIRED
                          conref CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          %arch-atts;
                          domains CDATA "&included-domains;"
                          %select-atts;
>

<!ELEMENT cxxFileDetail  ((%cxxFileAPIItemLocation;)?, (%apiDesc;)?, (%example; | %section; | %apiImpl;)*)>
<!ATTLIST cxxFileDetail  %id-atts;
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFileAPIItemLocation   (%cxxFileDeclarationFile;)
>
<!ATTLIST cxxFileAPIItemLocation    %univ-atts;
                                    outputclass CDATA #IMPLIED
>

<!ELEMENT cxxFileDeclarationFile  EMPTY>
<!ATTLIST cxxFileDeclarationFile  name CDATA #FIXED "filePath"
                                  value CDATA #REQUIRED
                                  %univ-atts;
                                  outputclass CDATA #IMPLIED
>

<!-- ============ Class attributes for type ancestry ============ -->
<!ATTLIST cxxFile   %global-atts;
    class  CDATA "- topic/topic reference/reference apiRef/apiRef apiPackage/apiPackage cxxFile/cxxFile ">
<!ATTLIST cxxFileDetail   %global-atts;
    class  CDATA "- topic/body reference/refbody apiRef/apiDetail apiClassifier/apiClassifierDetail cxxFile/cxxFileDetail ">
<!ATTLIST cxxFileAPIItemLocation   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiPackage/apiDefItem cxxFile/cxxFileAPIItemLocation ">
<!ATTLIST cxxFileDeclarationFile   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiPackage/apiQualifier cxxFile/cxxFileDeclarationFile ">