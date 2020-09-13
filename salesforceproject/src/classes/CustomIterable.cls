/**
 * Created by metro on 13.09.2020.
 */

global class CustomIterable implements Iterator<Contact>{

    List<Contact> contactsList {get; set;}
    Integer i {get; set;}

    public CustomIterable(){
        contactsList =  [SELECT Name, Account.Updated_By_Contact__c,
                Account.BillingCountry,
                Account.BillingCity,
                Account.BillingGeocodeAccuracy,
                Account.BillingPostalCode,
                Account.BillingState,
                Account.BillingStreet FROM Contact WHERE Is_Synced__c = FALSE];
        i = 0;
    }

    global boolean hasNext(){
        return (i < contactsList.size());
    }

    global Contact next(){
        if(i == 8) {
            return null;
        }
        i++;
        return contactsList[i-1];
    }
}