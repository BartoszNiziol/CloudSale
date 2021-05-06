/**
 * Created by BRITENET on 06.05.2021.
 */

trigger RC_GenerateLinkForAttachmentsTrigger on ContentDocumentLink (before insert, after insert) {

    if(Trigger.isBefore){

        System.debug('Is before');

        List<ContentDocumentLink> contentDocumentLinks =  Trigger.new;
        for(ContentDocumentLink link : contentDocumentLinks){
            link.Visibility ='AllUsers';
        }
    }

    if(Trigger.isAfter){

        List<ContentDocumentLink> contentDocumentLinks = Trigger.new;
        List<String> contentDocumentLinksIds = new List<String>();
        for(ContentDocumentLink links : contentDocumentLinks){
            contentDocumentLinksIds.add(links.ContentDocumentId);
        }


        List<ContentDocument> documents =  [Select Id ,Title FROM ContentDocument WHERE ID In : contentDocumentLinksIds];
        List<String> contentDocumentIds = new List<String>();

        for(ContentDocument doc : documents){
            contentDocumentIds.add(doc.Id);
        }

        List<ContentVersion> versions = [SELECT Id,Title FROM ContentVersion WHERE ContentDocumentId IN : contentDocumentIds];


        List<ContentDistribution> contentDistributions = new List<ContentDistribution>();

            for (ContentVersion contentVersion : versions) {
                ContentDistribution contentDistribution = new ContentDistribution();
                contentDistribution.ContentVersionId = contentVersion.Id;
                contentDistribution.Name = contentVersion.Title;
                contentDistribution.PreferencesAllowOriginalDownload = true;
                contentDistribution.PreferencesAllowViewInBrowser = true;
                contentDistribution.PreferencesNotifyOnVisit = false;
                contentDistributions.add(contentDistribution);
            }

        insert contentDistributions;




    }
}