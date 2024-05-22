@isTest
public class AccountFetcherTest {
    @testSetup
    static void setup() {
        // Create 10 account records for testing
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;
    }

    @isTest
    static void testFetchAccounts() {
        // Call the method to fetch accounts
        List<Account> accounts = AccountFetcher.fetchAccounts();
        
        // Verify that 10 records are returned
        System.assertEquals(10, accounts.size(), 'Expected to fetch 10 accounts');
        
        // Verify that each account has Id and Name populated
        for (Account acc : accounts) {
            System.assertNotEquals(null, acc.Id, 'Account Id should not be null');
            System.assertNotEquals(null, acc.Name, 'Account Name should not be null');
        }
    }
}
