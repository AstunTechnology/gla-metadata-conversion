<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:gmd="http://www.isotc211.org/2005/gmd" 
    xmlns:gco="http://www.isotc211.org/2005/gco" 
    xpath-default-namespace="http://www.isotc211.org/2005/gmd"
    xmlns:geonet="http://www.fao.org/geonetwork" version="2.0">

    <!--This script should be used as a post-processing step when harvesting metadata from the GLA ESRI ArcServer instance. -->

    <xsl:output indent="yes"/>

    <!-- declare abstract variable in advance --> 
    <xsl:variable name="messyabstract" select="//gmd:abstract/gco:CharacterString"/>

    <xsl:template match="/root">
        <xsl:apply-templates select="gmd:*"/>

    </xsl:template>
    
    <xsl:template match="gmd:MD_Metadata">
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
            <xsl:call-template name="DataID"/>
        </gmd:identificationInfo>
        </xsl:copy>
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
                     <gco:CharacterString><xsl:value-of select="$update_frequency" /></gco:CharacterString>
                 </gmd:maintenanceAndUpdateFrequency>
             </gmd:MD_MaintenanceInformation>
         </gmd:resourceMaintenance>
        <xsl:copy-of select="gmd:graphicOverview" />
        <xsl:copy-of select="gmd:resourceFormat" />
         <gmd:descriptiveKeywords>
             <gmd:MD_Keywords>
                 <gmd:keyword>
                     <gco:CharacterString><xsl:value-of select="$tags" /></gco:CharacterString>
                 </gmd:keyword>
             </gmd:MD_Keywords>
             <gmd:MD_Keywords>
                 <gmd:keyword>
                     <gco:CharacterString><xsl:value-of select="$topics" /></gco:CharacterString>
                 </gmd:keyword>
             </gmd:MD_Keywords>
         </gmd:descriptiveKeywords>
        <xsl:copy-of select="gmd:resourceSpecificUsage" />
         <gmd:resourceConstraints>
             <gmd:MD_LegalConstraints>
                 <gmd:useConstraints>
                     <gco:CharacterString><xsl:value-of select="$licence" /></gco:CharacterString>
                 </gmd:useConstraints>
             </gmd:MD_LegalConstraints>
         </gmd:resourceConstraints>
        <xsl:copy-of select="gmd:aggregationInfo" />
        <xsl:copy-of select="gmd:spatialRepresentationType" />
        <xsl:copy-of select="gmd:spatialResolution" />
        <xsl:copy-of select="gmd:language" />
        <xsl:copy-of select="gmd:characterSet" />
        <xsl:copy-of select="gmd:topicCategory" />
        <xsl:copy-of select="gmd:environmentDescription" />
        <xsl:copy-of select="gmd:extent" />
         <gmd:supplementalInformation>
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