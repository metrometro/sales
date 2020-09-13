/**
 * Created by metro on 13.09.2020.
 */

public with sharing class BatchApexClassTask implements Database.Batchable<sObject> {

    /** Use query
        SELECT Name, Account.Updated_By_Contact__c,
        Account.BillingCountry,
        Account.BillingCity,
        Account.BillingGeocodeAccuracy,
        Account.BillingPostalCode,
        Account.BillingState,
        Account.BillingStreet FROM Contact WHERE Is_Synced__c = FALSE
     */

    private final String query = '';

    public BatchApexClassTask(String query) {
        this.query = query;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('START');
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Contact> contactList) {

        for (Contact con: contactList) {
            con.MailingCity = con.Account.BillingCity;
            con.MailingCountry = con.Account.BillingCountry;
            con.MailingGeocodeAccuracy = con.Account.BillingGeocodeAccuracy;
            con.MailingPostalCode = con.Account.BillingPostalCode;
            con.MailingState = con.Account.BillingState;
            con.MailingStreet = con.Account.BillingStreet;
            con.Is_Synced__c = true;
            con.Account.Updated_By_Contact__c = true;
        }
        update contactList;
        System.debug('EXECUTE DONE');
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('FINISH');
    }
}