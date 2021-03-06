
    global class GoogleAuthentication implements Auth.RegistrationHandler{


        global User createUser(Id portalId, Auth.UserData data){

            if(data.attributeMap.containsKey('sfdc_networkid')) {
                //We have a community id, so create a user with community access
                //TODO: Get an actual account
                Account a = [SELECT Id FROM account WHERE name='Community Loger'];
                Contact c = new Contact();
                c.accountId = a.Id;
                c.email = data.email;
                c.firstName = data.firstName;
                c.lastName = data.lastName;
                insert(c);

                //TODO: Customize the username and profile. Also check that the username doesn't already exist and
                //possibly ensure there are enough org licenses to create a user. Must be 80 characters or less.
                User u = new User();
                Profile p = [SELECT Id FROM profile WHERE name='Red Carpet Customer'];
                System.debug(p);
                System.debug(p);
                u.username = data.lastName + data.firstName + '@RedCarpet.com';
                u.email = data.email;
                u.lastName = data.lastName;
                u.firstName = data.firstName;
                String alias = data.firstName + ' ' + data.lastName ;
                System.debug(alias);

                //Alias must be 8 characters or less
                if(alias.length() > 8) {
                    alias = alias.substring(0, 8);
                }
                u.alias = alias;
                System.debug(u.alias);
                u.languagelocalekey = UserInfo.getLanguage();
                u.localesidkey = UserInfo.getLocale();
                u.emailEncodingKey = 'UTF-8';
                u.timeZoneSidKey = 'Europe/Berlin';
                u.profileId = p.Id;
                u.contactId = c.Id;
                return u;
            } else {
                //This is not a community, so create a regular standard user
                User u = new User();
                Profile p = [SELECT Id FROM profile WHERE name='Standard User'];
                System.debug(p);
                //TODO: Customize the username. Also check that the username doesn't already exist and
                //possibly ensure there are enough org licenses to create a user. Must be 80 characters
                //or less.
                u.username = data.username + '@myorg.com';
                u.email = data.email;
                u.lastName = data.lastName;
                u.firstName = data.firstName;

                String alias = data.firstName + ' ' + data.lastName;
                System.debug(alias);
                System.debug('elsealias');
                //Alias must be 8 characters or less
                if(alias.length() > 8) {
                    alias = alias.substring(0, 8);
                }
                u.alias = alias;
                System.debug('elseu.alias');
                System.debug(u.alias);
                u.languagelocalekey = UserInfo.getLocale();
                u.localesidkey = UserInfo.getLocale();
                u.emailEncodingKey = 'UTF-8';
                u.timeZoneSidKey = 'America/Los_Angeles';
                u.profileId = p.Id;
                return u;
            }
        }

        global void updateUser(Id userId, Id portalId, Auth.UserData data){
            User u = new User(id=userId);
            //TODO: Customize the username. Must be 80 characters or less.
            //u.username = data.username + '@myorg.com';
            u.email = data.email;
            u.lastName = data.lastName;
            u.firstName = data.firstName;
            //String alias = data.username;
            //Alias must be 8 characters or less
            //if(alias.length() > 8) {
            //alias = alias.substring(0, 8);
            //}
            //u.alias = alias;
            update(u);
        }
    }
