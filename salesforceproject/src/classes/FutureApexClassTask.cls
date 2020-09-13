/**
 * Created by metro on 13.09.2020.
 */

global class FutureApexClassTask {

    @Future
    public static void updateContactIfAddressExists() {
        List<Account> accountList = [SELECT Id, Name, BillingAddress, (SELECT Id, Is_Synced__c, Processed_By_Future__c FROM Contacts) FROM Account LIMIT 150];
        List<Contact> contactsList = new List<Contact>();

        for (Account acc: accountList) {
            if (acc.BillingAddress != null) {
                List<Contact> tempContacts = acc.Contacts;
                contactsList.addAll(tempContacts);
            }
        }

        for (Contact con: contactsList) {
            con.Is_Synced__c = false;
            con.Processed_By_Future__c = true;
        }

        update contactsList;
    }
}