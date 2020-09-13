/**
 * Created by metro on 13.09.2020.
 */

public with sharing class BatchApexClassIterableTask implements Database.batchable<sObject> {

    public Iterable<SObject> start(Database.BatchableContext BC) {
        System.debug('START');
        return (Iterable<SObject>) new CustomIterable();
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