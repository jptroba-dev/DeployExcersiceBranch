public with sharing class UserSelectorService {


    public static void logUsersStartingWithJ() {
       
        List<User> usersWithJ = [
            SELECT Id, Name
            FROM User
            WHERE Name LIKE 'J%'
            ORDER BY Name
        ];

   
        if (usersWithJ.isEmpty()) {
            System.debug('No se encontraron usuarios que empiecen con J.');
            return;
        }

 
        for (User usr : usersWithJ) {
            System.debug('Usuario: ' + usr.Name);
        }
    }
}

//excecute 
//UserSelectorService.logUsersStartingWithJ();