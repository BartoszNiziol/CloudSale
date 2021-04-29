/**
 * Created by BRITENET on 27.04.2021.
 */

global  class RC_GoogleAuthentic implements Auth.RegistrationHandler{
    global User createUser(Id portalId, Auth.UserData data){

        if(data.attributeMap.containsKey(Label.Map_attribute_sfdc_networkid)) {

            Account a = [SELECT Id FROM account WHERE id= '0010900000HXrUyAAL'];
            Contact c = new Contact();
            c.accountId = a.Id;
            c.email = data.email;
            c.firstName = data.firstName;
            c.lastName = data.lastName;
            insert(c);
            User u = new User();
//            Profile p = [SELECT Id FROM profile WHERE name=:Label.Red_Carpet_Customer_Profile_Label];
            Profile p = [SELECT Id FROM profile WHERE id= '00e09000001Ekg2AAC'];
            u.username = data.lastName + data.firstName + Label.RedCarpet_Profile_Suffix;
            u.email = data.email;
            u.lastName = data.lastName;
            u.firstName = data.firstName;
            String alias = data.firstName + ' ' + data.lastName ;
            if(alias.length() > 8) {
                alias = alias.substring(0, 8);
            }
            u.alias = alias;
            u.languagelocalekey = UserInfo.getLanguage();
            u.localesidkey = UserInfo.getLocale();
            u.emailEncodingKey = Label.UTF_8_Label;
            u.timeZoneSidKey = Label.Europe_Berlin_Time_Zone_Label;
            u.profileId = p.Id;
            u.contactId = c.Id;
            return u;
        } else {
            User u = new User();
            Profile p = [SELECT Id FROM profile WHERE name =:  Label.Standard_User];
            u.username = data.username + Label.RedCarpet_Profile_Suffix;
            u.email = data.email;
            u.lastName = data.lastName;
            u.firstName = data.firstName;
            String alias = data.firstName + ' ' + data.lastName;

            if(alias.length() > 8) {
                alias = alias.substring(0, 8);
            }
            u.alias = alias;
            u.languagelocalekey = UserInfo.getLocale();
            u.localesidkey = UserInfo.getLocale();
            u.emailEncodingKey = Label.UTF_8_Label;
            u.timeZoneSidKey = Label.Europe_Berlin_Time_Zone_Label ;
            u.profileId = p.Id;
            return u;
        }
    }

    global void updateUser(Id userId, Id portalId, Auth.UserData data){
        User u = new User(id=userId);
        u.email = data.email;
        u.lastName = data.lastName;
        u.firstName = data.firstName;

        update(u);
    }

}