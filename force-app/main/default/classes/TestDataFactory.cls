public class TestDataFactory {

    // 1. MÉTODOS PARA USUARIO (User)
    public static User prepareUser(String profileName, String email,
                                   String firstName, String lastName, String roleName){
        User userRecord = new User();
        List<Profile> profileList = [Select Id, Name From Profile Where Name =:profileName ];
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueOf(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;

        if(!profileList.isEmpty()){
            userRecord = new User(Alias = uniqueName.substring(18, 23),
                                  Email = email,
                                  FirstName = firstName,
                                  LastName = lastName,
                                  EmailEncodingKey = 'UTF-8',
                                  LanguageLocaleKey = 'en_US',
                                  LocaleSidKey = 'en_US',
                                  ProfileId = profileList.get(0).Id,
                                  TimeZoneSidKey = 'America/Los_Angeles',
                                  UserName = uniqueName + '@test' + orgId + '.org');
        }

        List<UserRole> userRoleList = [Select Id, Name From UserRole Where Name =: roleName];
        if(!userRoleList.isEmpty()){
            userRecord.UserRoleId = userRoleList.get(0).Id;
        }
        return userRecord;
    }

    // 2. MÉTODOS PARA CUENTA (Account)
    public static Account prepareAccount(String Name, String Phone, String Web,
                                         String Rating, String Industry, Integer NumberOfEmployees){
        Account accountRecord = new Account( Name = Name, Phone = Phone, WebSite = Web,
                                             Rating = Rating, Industry = Industry, NumberOfEmployees = NumberOfEmployees );
        return accountRecord;
    }

    public static List<Account> prepareAccountList(String Name, String Phone, String Web,
                                                   String Rating, String Industry, Integer NumberOfEmployees,
                                                   Integer noOfAccounts){
        List<Account> accountList = new List<Account>();
        for(Integer i=0; i< noOfAccounts; i++){
            Account accountRecord = new Account( Name = Name+i, Phone = Phone+i, WebSite = Web,
                                                 Rating = Rating, Industry = Industry, NumberOfEmployees = NumberOfEmployees );
            accountList.add(accountRecord);
        }
        return accountList;
    }

    // 3. MÉTODOS PARA CONTACTO (Contact)
    public static Contact prepareContact(String FirstName, String LastName, String Email, String Phone, String accId){
        Contact contactRecord = new Contact(FirstName = FirstName, LastName=LastName, Email=Email, Phone=Phone,
                                            AccountId = accId);
        return contactRecord;
    }

    public static List<Contact> prepareContactList(String FirstName, String LastName,
                                                   String Email, String Phone, String accId, Integer noOfContact){
        List<Contact> contactList = new List<Contact>();
        for(Integer i=0; i< noOfContact; i++){
            Contact contactRecord = new Contact(FirstName = FirstName, LastName = LastName, Email = Email, Phone = Phone,
                                                AccountId = accId );
            contactList.add(contactRecord);
        }
        return contactList;
    }

    // 4. MÉTODOS PARA OPORTUNIDAD (Opportunity)
    public static Opportunity prepareOpportunity(String Name, String accId, Date closedDate, String StageName){
        Opportunity opportunityRecord = new Opportunity(Name = Name, AccountId = accId,
                                                        CloseDate = closedDate, StageName = StageName);
        return opportunityRecord;
    }

    public static List<Opportunity> prepareOpportunityList(String Name, String accId, Date closedDate, String StageName,
                                                           Integer onOfOpportunities){
        List<Opportunity> opportunityList = new List<Opportunity>();
        for(Integer i=0; i<onOfOpportunities; i++){
            Opportunity opportunityRecord = new Opportunity(Name = Name, AccountId = accId,
                                                            CloseDate = closedDate, StageName = StageName);
            opportunityList.add(opportunityRecord);
        }
        return opportunityList;
    }

    // 5. MÉTODOS PARA PRODUCTO Y PRECIO (Product2 & PricebookEntry)
    public static Product2 prepareProduct(String name, String productCode){
        Product2 productRecord = new Product2( Name = name, ProductCode = productCode, isActive = true );
        return productRecord;
    }

    public static PricebookEntry preparePriceBookEntry(String productId, String priceBookId){
        PricebookEntry pbEntry = new PricebookEntry( Pricebook2Id = priceBookId, Product2Id = productId,
                                                     UnitPrice = 100.00, IsActive = true );
        return pbEntry;
    }

    // 6. MÉTODO PARA CARGAR DATOS DESDE STATIC RESOURCE
    public static List<sObject> loadTestData(String nameOfStaticResource, String sobjectApiName){
        Schema.SObjectType objectType = Schema.getGlobalDescribe().get(sobjectApiName);
        List<sObject> sobjectList = Test.loadData(objectType, nameOfStaticResource);
        return sobjectList;
    }
}