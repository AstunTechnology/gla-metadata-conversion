<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:gml="http://www.opengis.net/gml/3.2"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gmx="http://www.isotc211.org/2005/gmx"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:srv="http://www.isotc211.org/2005/srv"
    xmlns:gco="http://www.isotc211.org/2005/gco"
    xmlns:gmi="http://www.isotc211.org/2005/gmi"
    xmlns:gts="http://www.isotc211.org/2005/gts"
    xmlns:gsr="http://www.isotc211.org/2005/gsr"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns="http://www.isotc211.org/2005/gmd"
    xmlns:geonet="http://www.fao.org/geonetwork" version="2.0">

    <!--This script should be used as a post-processing step when harvesting metadata from the GLA ESRI ArcServer instance. -->

    <xsl:output indent="yes"/>

    <!-- declare abstract variable in advance --> 
    <xsl:variable name="messyabstract" select="//gmd:abstract/gco:CharacterString"/>

    <xsl:template match="/root">
        <xsl:apply-templates select="gmd:*"/>

    </xsl:template>
    
<!--    <xsl:template match="gmd:MD_Metadata">
        <xsl:variable name="maintainer">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='maintainer'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="maintainer_email">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='maintainer_email'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:copy-of select="@*" />
            <xsl:copy-of select="gmd:fileIdentifier" />
            <xsl:copy-of select="gmd:language" />
            <xsl:copy-of select="gmd:characterSet" />
            <xsl:copy-of select="gmd:hierarchyLevel" />
        <gmd:contact>
            <gmd:CI_ResponsibleParty>
                <gmd:organisationName>
                    <gco:CharacterString><xsl:value-of select="$maintainer" /></gco:CharacterString>
                </gmd:organisationName>
                <gmd:contactInfo>
                     <gmd:CI_Contact>
                         <gmd:address>
                             <gmd:CI_Address>
                                 <gmd:electronicMailAddress>
                                     <gco:CharacterString><xsl:value-of select="$maintainer_email"/></gco:CharacterString>
                                 </gmd:electronicMailAddress>
                             </gmd:CI_Address>
                         </gmd:address>
                         <gmd:onlineResource>
                             <gmd:CI_OnlineResource>
                                 <gmd:linkage>
                                     <gmd:URL>https://gla.gov.uk</gmd:URL>
                                 </gmd:linkage>
                                 <gmd:description>
                                     <gco:CharacterString>GLA Website</gco:CharacterString>
                                 </gmd:description>
                             </gmd:CI_OnlineResource>
                         </gmd:onlineResource>
                     </gmd:CI_Contact>
                 </gmd:contactInfo>
                 <gmd:role>
            <gmd:CI_RoleCode codeList="./resources/codeList.xml#CI_RoleCode" codeListValue="pointOfContact"/>
            </gmd:role>
            </gmd:CI_ResponsibleParty>
        </gmd:contact>
        <xsl:copy-of select="gmd:dateStamp" />
        <xsl:copy-of select="gmd:metadataStandardName" />
        <xsl:copy-of select="gmd:metadataStandardVersion" />
        <xsl:copy-of select="gmd:referenceSystemInfo" />
        <gmd:identificationInfo>
            <gmd:MD_DataIdentification>
                <xsl:call-template name="DataID"/>
            </gmd:MD_DataIdentification>      
        
        </gmd:identificationInfo>
        </xsl:copy>
    </xsl:template>-->
    
    <xsl:template match="gmd:topicCategory">
        <xsl:message>===Hard-coding TopicCategory for now===</xsl:message>
        <gmd:topicCategory>
            <gmd:MD_TopicCategoryCode>Location</gmd:MD_TopicCategoryCode>
        </gmd:topicCategory>
    </xsl:template>
    
    <xsl:template match="gmd:contact">
        <xsl:message>===Updating contact with maintainer details===</xsl:message>
        <xsl:variable name="maintainer">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='maintainer'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="maintainer_email">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='maintainer_email'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        
        <gmd:contact>
            <gmd:CI_ResponsibleParty>
                <gmd:organisationName>
                    <gco:CharacterString><xsl:value-of select="$maintainer" /></gco:CharacterString>
                </gmd:organisationName>
                <gmd:contactInfo>
                    <gmd:CI_Contact>
                        <gmd:address>
                            <gmd:CI_Address>
                                <gmd:electronicMailAddress>
                                    <gco:CharacterString><xsl:value-of select="$maintainer_email"/></gco:CharacterString>
                                </gmd:electronicMailAddress>
                            </gmd:CI_Address>
                        </gmd:address>
                        <gmd:onlineResource>
                            <gmd:CI_OnlineResource>
                                <gmd:linkage>
                                    <gmd:URL>https://gla.gov.uk</gmd:URL>
                                </gmd:linkage>
                                <gmd:description>
                                    <gco:CharacterString>GLA Website</gco:CharacterString>
                                </gmd:description>
                            </gmd:CI_OnlineResource>
                        </gmd:onlineResource>
                    </gmd:CI_Contact>
                </gmd:contactInfo>
                <gmd:role>
                    <gmd:CI_RoleCode codeList="./resources/codeList.xml#CI_RoleCode" codeListValue="pointOfContact"/>
                </gmd:role>
            </gmd:CI_ResponsibleParty>
        </gmd:contact>
        
    </xsl:template>


    <xsl:template match="gmd:MD_DataIdentification" name="DataID">
        
        <xsl:variable name="description">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='description'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="author">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='author'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="author_email">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='author_email'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="update_frequency">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='update_frequency'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="tags">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='tags'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="topics">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='topics'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="licence">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='licence'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="london_smallest_geography">
            <xsl:for-each select="tokenize($messyabstract, '\|')">
                <xsl:if test="substring-before(.,':')='london_smallest_geography'">
                    <xsl:value-of select="substring-after(.,':')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

    
     <xsl:copy>
         <xsl:copy-of select="@*" /> 

        <xsl:copy-of select="gmd:citation" />
         <xsl:message>===Abstract with description element===</xsl:message>
         <gmd:abstract>
              <gco:CharacterString><xsl:value-of select="$description" /></gco:CharacterString>             
         </gmd:abstract>
        <xsl:copy-of select="gmd:purpose" />
        <xsl:copy-of select="gmd:credit" />
        <xsl:copy-of select="gmd:status" />
         <gmd:pointOfContact>
             <gmd:CI_ResponsibleParty>
                 <gmd:organisationName>
                     <gco:CharacterString><xsl:value-of select="$author"/></gco:CharacterString>
                 </gmd:organisationName>
                 <gmd:contactInfo>
                     <gmd:CI_Contact>
                         <gmd:address>
                             <gmd:CI_Address>
                                 <gmd:electronicMailAddress>
                                     <gco:CharacterString><xsl:value-of select="$author_email"/></gco:CharacterString>
                                 </gmd:electronicMailAddress>
                             </gmd:CI_Address>
                         </gmd:address>
                         <gmd:onlineResource>
                             <gmd:CI_OnlineResource>
                                 <gmd:linkage>
                                     <gmd:URL>https://gla.gov.uk</gmd:URL>
                                 </gmd:linkage>
                                 <gmd:description>
                                     <gco:CharacterString>GLA Website</gco:CharacterString>
                                 </gmd:description>
                             </gmd:CI_OnlineResource>
                         </gmd:onlineResource>
                     </gmd:CI_Contact>
                 </gmd:contactInfo>
                 <gmd:role>
                     <gmd:CI_RoleCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact" codeSpace="ISOTC211/19115">pointOfContact</gmd:CI_RoleCode>
                 </gmd:role>
             </gmd:CI_ResponsibleParty>
         </gmd:pointOfContact>
         <gmd:resourceMaintenance>
             <gmd:MD_MaintenanceInformation>
                 <gmd:maintenanceAndUpdateFrequency>
                 <gmd:MD_MaintenanceFrequencyCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/gmxCodelists.xml#MD_MaintenanceFrequencyCode"
                     codeListValue="{$update_frequency}"/>
                 </gmd:maintenanceAndUpdateFrequency>
                 </gmd:MD_MaintenanceInformation>

         </gmd:resourceMaintenance>
        <xsl:copy-of select="gmd:graphicOverview" />
        <xsl:copy-of select="gmd:resourceFormat" />
         <xsl:message>===Updating keywords with tags===</xsl:message>
         <gmd:descriptiveKeywords>
             <gmd:MD_Keywords>
                 <xsl:for-each select="tokenize(substring-before(substring-after($tags,'['),']'), ';')">
                     <xsl:variable name="tag" select="."/>
                    <gmd:keyword>
                        <gco:CharacterString><xsl:value-of select="$tag" /></gco:CharacterString>
                    </gmd:keyword>
                 </xsl:for-each>
                 <gmd:type>
                     <gmd:MD_KeywordTypeCode codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#MD_KeywordTypeCode"
                         codeListValue="theme"/>
                 </gmd:type>
                 <gmd:thesaurusName>
                     <gmd:CI_Citation>
                         <gmd:title>
                             <gco:CharacterString>GLA tags</gco:CharacterString>
                         </gmd:title>
                         <gmd:date>
                             <gmd:CI_Date>
                                 <gmd:date>
                                     <gco:Date>2019-12-05</gco:Date>
                                 </gmd:date>
                                 <gmd:dateType>
                                     <gmd:CI_DateTypeCode codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#CI_DateTypeCode"
                                         codeListValue="publication"/>
                                 </gmd:dateType>
                             </gmd:CI_Date>
                         </gmd:date>
                         <gmd:identifier>
                             <gmd:MD_Identifier>
                                 <gmd:code>
                                     <gmx:Anchor xlink:href="https://geonet38.astuntechnology.com:/geonetwork/srv/eng/thesaurus.download?ref=external.theme.gla-tags">geonetwork.thesaurus.external.theme.gla-tags</gmx:Anchor>
                                 </gmd:code>
                             </gmd:MD_Identifier>
                         </gmd:identifier>
                     </gmd:CI_Citation>
                 </gmd:thesaurusName>
             </gmd:MD_Keywords>
         </gmd:descriptiveKeywords>
         <gmd:descriptiveKeywords>
             <xsl:message>===Updating keywords with topics===</xsl:message>
                 <gmd:MD_Keywords>
                     <xsl:for-each select="tokenize(substring-before(substring-after($topics,'['),']'), ';')">
                         <xsl:variable name="topic" select="."/>
                     <gmd:keyword>
                         <gco:CharacterString><xsl:value-of select="$topic" /></gco:CharacterString>
                     </gmd:keyword>
                     </xsl:for-each>
                     <gmd:type>
                         <gmd:MD_KeywordTypeCode codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#MD_KeywordTypeCode"
                             codeListValue="theme"/>
                     </gmd:type>
                     <gmd:thesaurusName>
                         <gmd:CI_Citation>
                             <gmd:title>
                                 <gco:CharacterString>GLA Topics</gco:CharacterString>
                             </gmd:title>
                             <gmd:date>
                                 <gmd:CI_Date>
                                     <gmd:date>
                                         <gco:Date>2019-12-05</gco:Date>
                                     </gmd:date>
                                     <gmd:dateType>
                                         <gmd:CI_DateTypeCode codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#CI_DateTypeCode"
                                             codeListValue="publication"/>
                                     </gmd:dateType>
                                 </gmd:CI_Date>
                             </gmd:date>
                             <gmd:identifier>
                                 <gmd:MD_Identifier>
                                     <gmd:code>
                                         <gmx:Anchor xlink:href="https://geonet38.astuntechnology.com:/geonetwork/srv/eng/thesaurus.download?ref=external.theme.gla-topic">geonetwork.thesaurus.external.theme.gla-topic</gmx:Anchor>
                                     </gmd:code>
                                 </gmd:MD_Identifier>
                             </gmd:identifier>
                         </gmd:CI_Citation>
                     </gmd:thesaurusName>
                 </gmd:MD_Keywords>
             </gmd:descriptiveKeywords>
        <xsl:copy-of select="gmd:resourceSpecificUsage" />
         <xsl:message>===Updating licence===</xsl:message>
         <gmd:resourceConstraints>
             <gmd:MD_LegalConstraints>
                 <gmd:useConstraints>
                     <gmd:MD_RestrictionCode codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#MD_RestrictionCode"
                         codeListValue="otherRestrictions"/>
                 </gmd:useConstraints>
                 <gmd:otherConstraints>
                     <gmx:Anchor xlink:href="https://os.uk/business/licences/index.html">Licence: <xsl:value-of select="$licence" /></gmx:Anchor>
                 </gmd:otherConstraints>
             </gmd:MD_LegalConstraints>
         </gmd:resourceConstraints>
        <xsl:copy-of select="gmd:aggregationInfo" />
        <xsl:copy-of select="gmd:spatialRepresentationType" />
        <xsl:copy-of select="gmd:spatialResolution" />
        <xsl:copy-of select="gmd:language" />
        <xsl:copy-of select="gmd:characterSet" />
        <xsl:copy-of select="gmd:environmentDescription" />
        <xsl:copy-of select="gmd:extent" />
         <gmd:supplementalInformation>
             <xsl:message>===Updating supplemental info with London Smallest Geography===</xsl:message>
             <gco:CharacterString>London Smallest Geography: <xsl:value-of select="$london_smallest_geography" /></gco:CharacterString>
         </gmd:supplementalInformation>
        </xsl:copy>
 
    </xsl:template>
    
 


    <xsl:template match="gmd:MD_Distribution">
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:copy-of select="gmd:distributionFormat" />
      <xsl:if test="not(gmd:distributionFormat)" >
        <gmd:distributionFormat>
            <gmd:MD_Format>
               <gmd:name>
                  <gco:CharacterString xmlns:gco="http://www.isotc211.org/2005/gco"></gco:CharacterString>
               </gmd:name>
               <gmd:version>
                  <gco:CharacterString xmlns:gco="http://www.isotc211.org/2005/gco"></gco:CharacterString>
               </gmd:version>
            </gmd:MD_Format>
         </gmd:distributionFormat>
      </xsl:if>
      <xsl:copy-of select="gmd:transferOptions" />

    </xsl:copy>
    </xsl:template>
        
        
   

    
 <!-- Do a copy of every nodes and attributes recursively -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Remove geonet:* elements. -->
    <xsl:template match="geonet:*" priority="2"/>


</xsl:stylesheet>