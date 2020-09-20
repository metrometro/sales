
@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {

    @HttpGet
    global static Account getAccountById() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String urlId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        Account account = [SELECT Id, Name FROM Account WHERE Id =: urlId];
        return account;
    }

    @HttpPost
    global static void createAccount(String name) {
        RestRequest req = RestContext.request;
//        Map<String, String> paramMap = req.headers;
//        String name = paramMap.get('name');
        Account thisAccount = new Account(Name = name);
        insert thisAccount;
    }

    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Account thisAccount = [SELECT Id FROM Account WHERE Id =: accountId];
        delete thisAccount;
    }

    @HttpPut
    global static void upsertAccount() {
        RestRequest req = RestContext.request;
        Map<String, String> paramMap = req.headers;
        String name = paramMap.get('name');
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        Account thisAccount = [SELECT Id FROM Account WHERE Id =: accountId];
        thisAccount.Name = name;
        upsert thisAccount;
    }

    @HttpPatch
    global static void updateAccountFields() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Account thisAccount = [SELECT Id FROM Account WHERE Id = :accountId];
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        for(String fieldName : params.keySet()) {
            thisAccount.put(fieldName, params.get(fieldName));
        }
        update thisAccount;
    }
}
