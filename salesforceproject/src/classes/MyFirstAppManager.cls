/**
 * Created by metro on 20.09.2020.
 */

public with sharing class MyFirstAppManager {

    public static void getAccountInfo(String id) {
        HttpResponse res = new HttpResponse();
        Oauth objAuthInfo = getAccess();

        if (objAuthInfo.access_token != null) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ap16.salesforce.com/services/apexrest/Accounts/' + id);
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', objAuthInfo.token_type + ' ' + objAuthInfo.access_token);
            Http http = new Http();
            HttpResponse res = new HttpResponse();
            res = http.send(req);
            System.debug('Response auth --- ' + res.getBody());
        }
    }

    public static void postAccountInfo(String name) {
        HttpResponse res = new HttpResponse();
        Oauth objAuthInfo = getAccess();
        Account account = new Account(Name = name);

        if (objAuthInfo.access_token != null) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ap16.salesforce.com/services/apexrest/Accounts/');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', objAuthInfo.token_type + ' ' + objAuthInfo.access_token);
            req.setBody(createAccountJson(account));
            Http http = new Http();
            res = http.send(req);
            System.debug('Response auth --- ' + res.getBody());
        }
    }

    public static void deleteAccountInfo(String id) {
        HttpResponse res = new HttpResponse();
        Oauth objAuthInfo = getAccess();

        if (objAuthInfo.access_token != null) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ap16.salesforce.com/services/apexrest/Accounts/' + id);
            req.setMethod('DELETE');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', objAuthInfo.token_type + ' ' + objAuthInfo.access_token);
            Http http = new Http();
            res = http.send(req);
            System.debug('Response auth --- ' + res.getBody());
        }
    }

    public static void putAccountInfo(String name, String id) {
        HttpResponse res = new HttpResponse();
        Oauth objAuthInfo = getAccess();

        if (objAuthInfo.access_token != null) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ap16.salesforce.com/services/apexrest/Accounts/' + id);
            req.setMethod('PUT');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', objAuthInfo.token_type + ' ' + objAuthInfo.access_token);
            Http http = new Http();
            res = http.send(req);
            System.debug('Response auth --- ' + res.getBody());
        }
    }

    private static Oauth getAccess() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://ap16.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9n_HvETGhr3CvgTj4kF4KoyJ4w_fZLmuWkMPzfGlKuc7iRFcBowSiAx54fSSL9CSOlj9GQGF2Yl4oIr91&client_secret=6C5BC9A687E65EE0C95688C869947387E4F7B3478FE5F4497B73B41AD1E37C38&username=1twist31@mail.ru&password=6291318Metro');
        req.setMethod('POST');
        Http http = new Http();
        HttpResponse res = new HttpResponse();
        res = http.send(req);
        System.debug('Response auth --- ' + res.getBody());
        Oauth objAuthInfo = (Oauth)JSON.deserialize(res.getBody(), Oauth.class);
        return objAuthInfo;
    }

    private static String createAccountJson(Account account) {
        Map<String, Object> params = new Map<String, Object>();
        params.put('Name', account.Name);
        return JSON.serialize(params);
    }
}