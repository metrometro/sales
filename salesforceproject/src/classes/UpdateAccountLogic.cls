/**
 * Created by metro on 11.09.2020.
 */

public with sharing class UpdateAccountLogic {

    @InvocableMethod(label = 'Update Accounts' description = 'Redirect tasks to the random user if there are more than 3 tasks' category= 'Account')
    public static void ifAccountUpdateThen(List<Account> accountsList) {
        Account account = accountsList.get(0);
        List<Task> accountTasksList =  account.Tasks;
        if (accountTasksList.size() > 3) {
            //Find all users
            List<User> allUsersList = [SELECT Id FROM User];
            //Find number of users and get random user
            Integer numberOfUsers = allUsersList.size();
            Integer numberOfRandomUser = (Integer) ( Math.random() * (numberOfUsers + 1) );
            User chosenUser = allUsersList.get(numberOfRandomUser);
            //Assigned tasks to chosen user
            for (Task element: accountTasksList) {
                element.OwnerId = chosenUser.Id;
            }
            update accountTasksList;
        }
    }
}