/**
 * Created by metro on 11.09.2020.
 */

public with sharing class CreateNewAccountLogic {

    @InvocableMethod(label = 'Insert Accounts' description = 'Inserts new Task if Account is created.' category= 'Account')
    public static void ifAccountCreateThen(List<Account> accountsList) {
        Account account = accountsList.get(0);
        Task task = new Task();
        task.Subject = 'Negotiations with ' + account.Name;
        task.WhatId = account.Id;
        insert task;
    }
}