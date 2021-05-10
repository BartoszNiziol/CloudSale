/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_Image_Handler {

    @AuraEnabled
    public static List<String> getImagesLinks(String productId){
        Integer err = 1/0;
            List<ContentDocumentLink> lks = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :productId];
            List<String> strids = new List<String>();
            for (ContentDocumentLink cdl : lks) {
                strids.add(cdl.ContentDocumentId);
            }
            List<ContentDocument> dcs = [Select Id,Title,ArchivedDate,Description, (SELECT Id, DistributionPublicUrl,ContentDownloadUrl,PdfDownloadUrl FROM ContentDistributions) from ContentDocument Where ID In :strids];
            dcs.sort();

            List<String> downloadLinks = new List<String>();
            for (ContentDocument document : dcs) {
                if (document.Description == 'Main') {
                    downloadLinks.add(document.ContentDistributions.get(0).ContentDownloadUrl);
                    break;
                }
            }
            for (ContentDocument document : dcs) {
                if (document.Description != 'Main') {
                    downloadLinks.add(document.ContentDistributions.get(0).ContentDownloadUrl);
                }
            }
            return downloadLinks;
    }
}