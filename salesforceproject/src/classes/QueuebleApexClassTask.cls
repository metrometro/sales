/**
 * Created by metro on 13.09.2020.
 */

public with sharing class QueuebleApexClassTask implements Queueable{

    public static void execute(QueueableContext context) {
        Account acc = [SELECT Id, Name, BillingAddress, (SELECT Id, Is_Synced__c, Processed_By_Future__c FROM Contacts) FROM Account LIMIT 1];
        List<Contact> contactsList = new List<Contact>();

        if (acc.BillingAddress != null) {
            contactsList = acc.Contacts;
        }

        for (Contact con: contactsList) {
            con.Is_Synced__c = false;
            con.Processed_By_Future__c = true;
        }

        update contactsList;
    }
}