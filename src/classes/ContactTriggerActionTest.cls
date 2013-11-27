/**
 * 取引先責任者トリガー
 * © 2013 Force.com Developer
 * ----------------------------------------
 * @createdName      : Taiki,Yoshikawa
 * @lastModifiedName : Taiki,Yoshikawa
 * ----------------------------------------
 */
@isTest
private class ContactTriggerActionTest {
    
    private static Integer LIST_LIMIT = 10;

    /**
     * 取引先ID取得・テスト
     * 取引先責任者なし
     */
    static testMethod void getAccountIdTest1() {
            
        // Actionクラス
        ContactTriggerAction action = new ContactTriggerAction();
        
        // 取引先責任者
        List<Contact> contacts = new List<Contact>();
        
        Test.startTest();            
        
        // 取引先ID
        Set<Id> accountIds = action.getAccountId(contacts);
        System.assertEquals(accountIds.size(), 0);
        
        Test.stopTest();
    }
    
    /**
     * 取引先ID取得・テスト
     * 取引先責任者あり
     */
    static testMethod void getAccountIdTest2() {
            
        // Actionクラス
        ContactTriggerAction action = new ContactTriggerAction();
        
        // 取引先取得
        Account account = createAccount();
        
        // 取引先責任者
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < LIST_LIMIT; i++) {
            contacts.add(createContact(account.Id));
        }
        
        Test.startTest();
        
        // 取引先ID
        Set<Id> accountIds = action.getAccountId(contacts);
        for (Integer i = 0; i < contacts.size(); i++) {
            System.assertEquals(accountIds.contains(contacts[i].accountId), true);
        }
        
        Test.stopTest();
    }
    
    /**
     * 取引先ID取得
     * 取引先責任者あり
     */
    static testMethod void getAccountIdTest3() {
            
        // Actionクラス
        ContactTriggerAction action = new ContactTriggerAction();
        
        // 取引先取得
        Account accountNew = createAccount();
        Account accountOld = createAccount();
        
        // 取引先責任者
        List<Contact> contactNews = new List<Contact>();
        List<Contact> contactOlds = new List<Contact>();
        for (Integer i = 0; i < LIST_LIMIT; i++) {
            contactNews.add(createContact(accountNew.Id));
            contactOlds.add(createContact(accountOld.Id));
        }
        
        Test.startTest();
        
        // 取引先ID
        Set<Id> accountIds = action.getAccountId(contactNews, contactOlds);
        
        Test.stopTest();
    }
    
    /**
     * 取引先取得
     * 取引先責任者なし
     */
    static testMethod void getAccountsTest1() {
            
        // Actionクラス
        ContactTriggerAction action = new ContactTriggerAction();
        
        // 取引先取得
        Set<Id> accountIds = new Set<Id>();
        Account accountNew = createAccount();
        Account accountOld = createAccount();
        accountIds.add(accountNew.Id);
        accountIds.add(accountOld.Id);
        
        Test.startTest();
        
        // 取引先ID
        List<Account> accounts = action.getAccounts(accountIds);
        for (Account account : accounts) {
            System.assertEquals(account.Contacts.size(), 0);
        }
        
        Test.stopTest();
    }
    
    /**
     * 取引先取得
     * 取引先責任者あり
     */
    static testMethod void getAccountsTest2() {
            
        // Actionクラス
        ContactTriggerAction action = new ContactTriggerAction();
        
        // 取引先取得
        Set<Id> accountIds = new Set<Id>();
        Account accountNew = createAccount();
        Account accountOld = createAccount();
        accountIds.add(accountNew.Id);
        accountIds.add(accountOld.Id);
        
        // 取引先責任者
        Contact contactNew = createContact(accountNew.Id);
        insert contactNew;
        
        Contact contactOld = createContact(accountOld.Id);
        insert contactOld;
        
        Test.startTest();
        
        // 取引先ID
        List<Account> accounts = action.getAccounts(accountIds);
        for (Account account : accounts) {
            System.assertEquals(account.Contacts.size(), 1);
        }
        
        Test.stopTest();
    }
    
    /**
     * 取引先取得
     * 取引先責任者あり
     */
    static testMethod void getAccountsTes3() {
            
        // Actionクラス
        ContactTriggerAction action = new ContactTriggerAction();
        
        // 取引先取得
        Set<Id> accountIds = new Set<Id>();
        Account accountNew = createAccount();
        Account accountOld = createAccount();
        accountIds.add(accountNew.Id);
        accountIds.add(accountOld.Id);
        
        // 取引先責任者
        Contact contactNew = createContact(accountNew.Id);
        insert contactNew;
        
        Contact contactOld = createContact(accountOld.Id);
        insert contactOld;
        
        Test.startTest();
        
        // 取引先ID
        List<Account> accounts = action.getAccounts(accountIds);
        for (Account account : accounts) {
            System.assertEquals(account.Contacts.size(), 1);
        }
        
        Test.stopTest();
    }
    
    /**
     * 取引先の更新値をセット
     * 取引先なし
     */
    static testMethod void getUpdateAccountsTest1() {
            
        // Actionクラス
        ContactTriggerAction action = new ContactTriggerAction();
        
        // 取引先ID
        List<Account> accounts = new List<Account>();
        
        Test.startTest();
        
        // 取引先の更新値をセット
        accounts = action.getUpdateAccounts(accounts);
        System.assertEquals(accounts.isEmpty(), true);
        
        Test.stopTest();
    }
    
    /**
     * 取引先の更新値をセット・テスト
     * 取引先あり
     */
    static testMethod void getUpdateAccountsTest2() {
            
        // Actionクラス
        ContactTriggerAction action = new ContactTriggerAction();
        
        // 取引先取得
        Set<Id> accountIds = new Set<Id>();
        Account accountNew = createAccount();
        Account accountOld = createAccount();
        accountIds.add(accountNew.Id);
        accountIds.add(accountOld.Id);
        
        // 取引先責任者
        Contact contactNew = createContact(accountNew.Id);
        insert contactNew;
        
        Contact contactOld = createContact(accountOld.Id);
        insert contactOld;
        
        // 取引先ID
        List<Account> accounts = action.getAccounts(accountIds);
        for (Account account : accounts) {
            System.assertEquals(account.Contacts.size(), 1);
        }
        
        Test.startTest();
        
        // 取引先の更新値をセット
        accounts = action.getUpdateAccounts(accounts);
        for (Account account : accounts) {
            System.assertEquals(account.Contacts.size(), account.ContactCnt__c);
        }
        
        Test.stopTest();
    }
    
    /**
     * 取引先テストデータ作成
     * @param   : none
     * @return  : 取引先テストデータ
     */
    private static Account createAccount() {
        Account account = new Account(
             Name = 'Test Company'
            ,ContactCnt__c = 0
        );
        insert account;
        return account;
    }
    
    /**
     * 取引先責任者テストデータ作成
     * @param   : 取引先ID [prmAccountId]
     * @return  : 取引先責任者テストデータ
     */
    private static Contact createContact(Id prmAccountId) {
        Contact contact = new Contact(
             LastName = 'Yoshkawa'
            ,FirstName = 'Taiki'
            ,AccountId = prmAccountId
        );
        return contact;
    }
    
    /**
     * 取引先取得
     * @param   : 取引先ID [prmAccountId]
     * @return  : 取引先テストデータ
     */
    private static Account getAccount(Id prmAccountId) {
        List<Account> accounts = [
            select
                Id
                ,ContactCnt__c
            from
                Account
            where
                Id =: prmAccountId
            limit 1
        ];
        if (accounts.isEmpty() != true) {
            return accounts[0];
        }
        return new Account();
    }
    
    /**
     * 取引先責任者取得(削除済)
     * @param   : none
     * @return  : 取引先責任者テストデータ
     */
    private static List<Contact> getContactAllRows() {
        return [
            select
                Id
            from
                Contact
            ALL ROWS
        ];
    }
}