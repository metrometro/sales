/**
 * Created by metro on 13.09.2020.
 */

global class CheduledApexClassTask implements Schedulable {

    private String query = 'Use query\n' +
            '        SELECT Name, Account.Updated_By_Contact__c,\n' +
            '        Account.BillingCountry,\n' +
            '        Account.BillingCity,\n' +
            '        Account.BillingGeocodeAccuracy,\n' +
            '        Account.BillingPostalCode,\n' +
            '        Account.BillingState,\n' +
            '        Account.BillingStreet FROM Contact WHERE Is_Synced__c = FALSE';
//    private String startTime = '0 30 0 * * ?';

    global void execute(SchedulableContext sc) {
        BatchApexClassTask b = new BatchApexClassTask(query);
        BatchApexClassIterableTask b2 = new BatchApexClassIterableTask();
        database.executebatch(b, 100);
        database.executebatch(b2, 100);
    }
}