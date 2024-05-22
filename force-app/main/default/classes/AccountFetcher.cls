public class AccountFetcher {
    public static List<Account> fetchAccounts() {
        // Query to fetch 10 account records with Id and Name fields
        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 10];
        return accounts; 
    }
}
