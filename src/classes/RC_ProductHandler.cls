/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_ProductHandler {

    public static List<String> searchForIds(String searchText) {

            String likeSearchText = '%' + searchText + '%';
            List<Product2> results = [SELECT Id,Name FROM Product2 WHERE Name LIKE :likeSearchText AND Family = :Label.Red_Carpet_Item_Family_Label];
            List<String> ProductsIds = new List<String>();
            for (Product2 p : results) {
                ProductsIds.add(p.Id);
            }
           // Integer err = 1/0;
            return ProductsIds;
    }

    @AuraEnabled
    public static List<String> getImagesLinks(String productId){
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