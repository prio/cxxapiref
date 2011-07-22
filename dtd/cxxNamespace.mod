<!-- ================================================================= -->
<!--                    HEADER                                         -->
<!-- ================================================================= -->
<!--  MODULE:    C++ Namespace DTD                                     -->
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
PUBLIC "-//NOKIA//DTD DITA C++ API Namespace Reference Type v0.7.0//EN"
      Delivered as file "cxxNamespace.dtd"                             -->
 
<!-- ================================================================= -->
<!-- SYSTEM:     Darwin Information Typing Architecture (DITA)         -->
<!--                                                                   -->
<!-- PURPOSE:    C++ API Reference for Namespacees                     -->
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
<!--  2010-11-39 PaulRoss: Initial design.                             -->
<!--                                                                   -->
<!-- ================================================================= -->

<!--
Copyright (c) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
All rights reserved.
-->

<!-- ============ Hooks for domain extension ============ -->
<!ENTITY % cxxNamespace                             "cxxNamespace">
<!ENTITY % cxxNamespaceDetail                       "cxxNamespaceDetail">
<!ENTITY % cxxNamespaceDefinition                   "cxxNamespaceDefinition">

<!ENTITY % cxxNamespaceAPIItemLocation              "cxxNamespaceAPIItemLocation">
<!ENTITY % cxxNamespaceDeclarationFile              "cxxNamespaceDeclarationFile">

<!ENTITY % cxxNamespaceMembers                      "cxxNamespaceMembers">
<!ENTITY % cxxNamespaceMembersDetail                "cxxNamespaceMembersDetail">
<!ENTITY % cxxNamespaceMemberClass                  "cxxNamespaceMemberClass">
<!ENTITY % cxxNamespaceMemberStruct                 "cxxNamespaceMemberStruct">
<!ENTITY % cxxNamespaceMemberUnion                  "cxxNamespaceMemberUnion">
<!ENTITY % cxxNamespaceMemberNamespace              "cxxNamespaceMemberNamespace">

<!-- ============ Hooks for shell DTD ============ -->
<!ENTITY % cxxNamespace-types-default
    "cxxFunction | cxxVariable | cxxEnumeration | cxxTypedef">
<!ENTITY % cxxNamespace-info-types  "%cxxNamespace-types-default;">

<!ENTITY % cxxNamespaceNested-types-default "no-topic-nesting">
<!ENTITY % cxxNamespaceNested-info-types  "%cxxNamespaceNested-types-default;">

<!ENTITY included-domains "">

<!-- ============ Topic specializations ============ -->
<!-- (%cxxNamespace-info-types;)* -->

<!ELEMENT cxxNamespace   (
                        (%apiName;),
                        (%shortdesc;)?,
                        (%prolog;)?,
                        (%cxxNamespaceDetail;),
                        (%related-links;)?,
                        (%cxxNamespace-info-types;)*,
						(%cxxNamespaceMembers;)?
                      )
>
<!ATTLIST cxxNamespace       id ID #REQUIRED
                          conref CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          %arch-atts;
                          domains CDATA "&included-domains;"
                          %select-atts;
>

<!ELEMENT cxxNamespaceDetail  ((%cxxNamespaceDefinition;)?, (%apiDesc;)?, (%example; | %section; | %apiImpl;)*)>
<!ATTLIST cxxNamespaceDetail  %id-atts;
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          outputclass CDATA #IMPLIED
>

<!ELEMENT cxxNamespaceDefinition   (
                                    (%cxxNamespaceAPIItemLocation;)
                               )
>
<!ATTLIST cxxNamespaceDefinition    spectitle CDATA #IMPLIED
                                  %univ-atts;
                                  outputclass CDATA #IMPLIED
>

<!-- Location -->
<!ELEMENT cxxNamespaceAPIItemLocation   (
                                        (%cxxNamespaceDeclarationFile;)*
                                     )
>
<!ATTLIST cxxNamespaceAPIItemLocation    %univ-atts;
                                    outputclass CDATA #IMPLIED
>

<!ELEMENT cxxNamespaceDeclarationFile  EMPTY>
<!ATTLIST cxxNamespaceDeclarationFile  name CDATA #FIXED "filePath"
                                  value CDATA #REQUIRED
                                  %univ-atts;
                                  outputclass CDATA #IMPLIED
>

<!ELEMENT cxxNamespaceMembers   (
                                %cxxNamespaceMembersDetail;
                              )
>

<!ATTLIST cxxNamespaceMembers    %univ-atts;
                                outputclass CDATA #IMPLIED
                                domains CDATA "&included-domains;"
>

<!ELEMENT cxxNamespaceMembersDetail   (
                                (
                                    %cxxNamespaceMemberClass;
                                    | %cxxNamespaceMemberStruct;
                                    | %cxxNamespaceMemberUnion;
                                    | %cxxNamespaceMemberNamespace;
                                    | xref
                                )+
                              )
>

<!ATTLIST cxxNamespaceMembersDetail    %univ-atts;
                                outputclass CDATA #IMPLIED
                                domains CDATA "&included-domains;"
>

<!ELEMENT cxxNamespaceMemberClass  (#PCDATA)*>
<!ATTLIST cxxNamespaceMemberClass   href CDATA #IMPLIED
                                      keyref CDATA #IMPLIED
                                      type   CDATA  #IMPLIED
                                      %univ-atts;
                                      format        CDATA   #IMPLIED
                                      scope (local | peer | external) #IMPLIED
                                      outputclass CDATA #IMPLIED
>

<!ELEMENT cxxNamespaceMemberStruct  (#PCDATA)*>
<!ATTLIST cxxNamespaceMemberStruct   href CDATA #IMPLIED
                                      keyref CDATA #IMPLIED
                                      type   CDATA  #IMPLIED
                                      %univ-atts;
                                      format        CDATA   #IMPLIED
                                      scope (local | peer | external) #IMPLIED
                                      outputclass CDATA #IMPLIED
>

<!ELEMENT cxxNamespaceMemberUnion  (#PCDATA)*>
<!ATTLIST cxxNamespaceMemberUnion   href CDATA #IMPLIED
                                      keyref CDATA #IMPLIED
                                      type   CDATA  #IMPLIED
                                      %univ-atts;
                                      format        CDATA   #IMPLIED
                                      scope (local | peer | external) #IMPLIED
                                      outputclass CDATA #IMPLIED
>

<!ELEMENT cxxNamespaceMemberNamespace  (#PCDATA)*>
<!ATTLIST cxxNamespaceMemberNamespace   href CDATA #IMPLIED
                                      keyref CDATA #IMPLIED
                                      type   CDATA  #IMPLIED
                                      %univ-atts;
                                      format        CDATA   #IMPLIED
                                      scope (local | peer | external) #IMPLIED
                                      outputclass CDATA #IMPLIED
>

<!-- ============ Class attributes for type ancestry ============ -->
<!ATTLIST cxxNamespace   %global-atts;
    class  CDATA "- topic/topic reference/reference apiRef/apiRef apiClassifier/apiClassifier cxxNamespace/cxxNamespace ">
<!ATTLIST cxxNamespaceDetail   %global-atts;
    class  CDATA "- topic/body reference/refbody apiRef/apiDetail apiClassifier/apiClassifierDetail cxxNamespace/cxxNamespaceDetail ">
<!ATTLIST cxxNamespaceDefinition   %global-atts;
    class  CDATA "- topic/section reference/section apiRef/apiDef apiClassifier/apiClassifierDef cxxNamespace/cxxNamespaceDefinition ">

<!-- Location elements -->
<!ATTLIST cxxNamespaceAPIItemLocation   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiClassifier/apiDefItem cxxNamespace/cxxNamespaceAPIItemLocation ">
<!ATTLIST cxxNamespaceDeclarationFile   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiClassifier/apiQualifier cxxNamespace/cxxNamespaceDeclarationFile ">

	
<!-- Member references to topics -->
<!ATTLIST cxxNamespaceMembers   %global-atts;
    class  CDATA "- topic/topic reference/reference apiRef/apiRef apiClassifier/apiClassifier cxxNamespace/cxxNamespaceMembers ">  
<!ATTLIST cxxNamespaceMembersDetail   %global-atts;
    class  CDATA "- topic/body reference/refbody apiRef/apiDetail apiClassifier/apiDetail cxxNamespace/cxxNamespaceMembersDetail ">    

<!ATTLIST cxxNamespaceMemberClass   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiClassifier/apiRelation cxxNamespace/cxxNamespaceMemberClass ">
<!ATTLIST cxxNamespaceMemberStruct   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiClassifier/apiRelation cxxNamespace/cxxNamespaceMemberStruct ">
<!ATTLIST cxxNamespaceMemberUnion   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiClassifier/apiRelation cxxNamespace/cxxNamespaceMemberUnion ">     
<!ATTLIST cxxNamespaceMemberNamespace   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiClassifier/apiRelation cxxNamespace/cxxNamespaceMemberNamespace ">
     
