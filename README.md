# GLA WMS to Gemini Conversion

## How to install

Clone or otherwise download this repository and extract `gla_wms_gemini.xsl`. Place it the following location (relative to either the `schema_plugins` folder if deploying in a war file, or `schemas\iso19139.gemini23\src\main\plugin` if running using jetty):

* `iso19139.gemini23\process`

## Setting up the harvest

In settings, set "Allow editing on harvested records" and save.
Create a harvester of type **OGC Web Services** with the following options:

* Node name and logo: the name will appear in the "Provided By" search facet in the editor/contribute tab. The logo will appear on the records
* Set the group and user as required
* Service URL: https://maps.london.gov.uk/gla/services/opendata/maplondon2/MapServer/WMSServer?
* Service Type: WMS 1.3.0
* Create record for each layer only using GetCapabilities information should be ticked
* Import record for each layer using MetadataURL attributes should be ticked
* Leave templates blank (for now at least)
* Create Thumbnail: can be ticked
* Output schema: iso19139.gemini23
* Validate records before import: should be set to "Accept all metadata without validation"
* XSL transformation to apply: should be blank

## Running as a batch process directive

### Basic setup

Set up the harvest as above. Save and harvest the records.

### Add the directive to the batch processing config

Edit the file `catalog\config\batch-process-cfg.json` and add the following entry:

	{
	"key": "gla_wms_gemini",
	"type": "fixed-params",
	"params": []
	},

Note that the key must exactly match the name of the xsl.

To provide a translated label for the process, edit `catalog\locale\en-custom.json` and add the following:

	"gla_wms_gemini": "Convert GLA WMS to Gemini"

### Running the batch process

Go to `Admin console -> Tools -> Batch process` and select the records you wish to transform. In the "Configure a process" section, choose gla_wms_gemini (or whatever you named it as) from the list. Click the blue `Run` button- the results will be listed below.

## Notes

**This conversion script won't produce totally valid Gemini 2.x records as that requires additional metadata**

The following mapping has been used:

| GLA Field | Metadata XPATH |
| ----------| ---------------| 
| license | /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentifiation/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useConstraints |
| author | /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:organisationName |
| author_email | /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress |
| maintainer | /gmd:MD_Metadata/gmd:contact/gmd:CI_ResponsibleParty/gmd:organisationName |
| maintainer_email | /gmd:MD_Metadata/gmd:contact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress |
| description | /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract |
| update_frequency | /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency |
| tags | /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword |
| topics | /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword |
| london_smallest_geometry | /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:supplementalInformation |

* tags and topics are both mapped to keywords, but grouped separately. Thesauri have been created (included) which list the known tags and topics, these can be added to Geonetwork using the `Admin Console -> Classification Systems -> Thesauri` dialog to make them useable within the catalog.
* **Topic Category** and **Lineage** are hard-coded at present, as are elements of the Contact Details.

