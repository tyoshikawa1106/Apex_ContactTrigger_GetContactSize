/*
 * 取引先責任者トリガー
 * © 2013 Force.com Developer
 * ----------------------------------------
 * @createdDate      : 2013/01/01
 * @createdName      : TAIKI,YOSHIKAWA
 * ----------------------------------------
 * @lastModifiedDate : 2013/01/01
 * @lastModifiedName : TAIKI,YOSHIKAWA
 * ----------------------------------------
 */
@isTest
private class ContactTriggerActionTest {
	
	private static Integer LIST_LIMIT = 10;

    /*
	 * 取引先ID取得・テスト
	 * 取引先責任者なし
	 */
    static testMethod void getAccountIdTest1() {
        System.debug('◆◆◆◆getAccountIdTest1:START');
        
        // ユーザ取得
        User user = getUser();
        
        // テスト実施
        System.RunAs(user) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先責任者
            List<Contact> contacts = new List<Contact>();
            
            // テスト開始
            Test.startTest();            
            
            // 取引先ID
            Set<Id> accountIds = action.getAccountId(contacts);
            System.assertEquals(accountIds.size(), 0);
            
            // テスト終了
            Test.stopTest();
        }
        
        System.debug('◆◆◆◆getAccountIdTest1:END');
    }
    
    /*
	 * 取引先ID取得・テスト
	 * 取引先責任者あり
	 */
    static testMethod void getAccountIdTest2() {
        System.debug('◆◆◆◆getAccountIdTest2:START');
        
        // ユーザ取得
        User user = getUser();
        
        // テスト実施
        System.RunAs(user) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先取得
            Account account = createAccount();
            
            // 取引先責任者
            List<Contact> contacts = new List<Contact>();
            for (Integer i = 0; i < LIST_LIMIT; i++) {
            	contacts.add(createContact(account.Id));
            }
            
            // テスト開始
            Test.startTest();
            
            // 取引先ID
            Set<Id> accountIds = action.getAccountId(contacts);
            for (Integer i = 0; i < contacts.size(); i++) {
            	System.assertEquals(accountIds.contains(contacts[i].accountId), true);
            }
            
            // テスト終了
            Test.stopTest();
        }
        
        System.debug('◆◆◆◆getAccountIdTest2:END');
    }
    
    /*
	 * 取引先ID取得・テスト
	 * 取引先責任者あり
	 */
    static testMethod void getAccountIdTest3() {
        System.debug('◆◆◆◆getAccountIdTest3:START');
        
        // ユーザ取得
        User user = getUser();
        
        // テスト実施
        System.RunAs(user) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
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
            
            // テスト開始
            Test.startTest();
            
            // 取引先ID
            Set<Id> accountIds = action.getAccountId(contactNews, contactOlds);
            
            // テスト終了
            Test.stopTest();
        }
        
        System.debug('◆◆◆◆getAccountIdTest3:END');
    }
    
    /*
	 * 取引先取得・テスト
	 * 取引先責任者なし
	 */
    static testMethod void getAccountsTest1() {
        System.debug('◆◆◆◆getAccountsTest1:START');
        
        // ユーザ取得
        User user = getUser();
        
        // テスト実施
        System.RunAs(user) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先取得
            Set<Id> accountIds = new Set<Id>();
            Account accountNew = createAccount();
            Account accountOld = createAccount();
            accountIds.add(accountNew.Id);
            accountIds.add(accountOld.Id);
            
            // テスト開始
            Test.startTest();
            
            // 取引先ID
            List<Account> accounts = action.getAccounts(accountIds);
            for (Account account : accounts) {
            	System.assertEquals(account.Contacts.size(), 0);
            }
            
            // テスト終了
            Test.stopTest();
        }
        
        System.debug('◆◆◆◆getAccountsTest1:END');
    }
    
    /*
	 * 取引先取得・テスト
	 * 取引先責任者あり
	 */
    static testMethod void getAccountsTest2() {
        System.debug('◆◆◆◆getAccountsTest2:START');
        
        // ユーザ取得
        User user = getUser();
        
        // テスト実施
        System.RunAs(user) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
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
            
            // テスト開始
            Test.startTest();
            
            // 取引先ID
            List<Account> accounts = action.getAccounts(accountIds);
            for (Account account : accounts) {
            	System.assertEquals(account.Contacts.size(), 1);
            }
            
            // テスト終了
            Test.stopTest();
        }
        
        System.debug('◆◆◆◆getAccountsTest2:END');
    }
    
    /*
	 * 取引先取得・テスト
	 * 取引先責任者あり
	 */
    static testMethod void getAccountsTes3() {
        System.debug('◆◆◆◆getAccountsTes3:START');
        
        // ユーザ取得
        User user = getUser();
        
        // テスト実施
        System.RunAs(user) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
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
            
            // テスト開始
            Test.startTest();
            
            // 取引先ID
            List<Account> accounts = action.getAccounts(accountIds);
            for (Account account : accounts) {
            	System.assertEquals(account.Contacts.size(), 1);
            }
            
            // テスト終了
            Test.stopTest();
        }
        
        System.debug('◆◆◆◆getAccountsTes3:END');
    }
    
    /*
	 * 取引先の更新値をセット・テスト
	 * 取引先なし
	 */
    static testMethod void getUpdateAccountsTest1() {
        System.debug('◆◆◆◆getUpdateAccountsTest1:START');
        
        // ユーザ取得
        User user = getUser();
        
        // テスト実施
        System.RunAs(user) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先ID
            List<Account> accounts = new List<Account>();
            
            // テスト開始
            Test.startTest();
            
            // 取引先の更新値をセット
            accounts = action.getUpdateAccounts(accounts);
            System.assertEquals(accounts.isEmpty(), true);
            
            // テスト終了
            Test.stopTest();
        }
        
        System.debug('◆◆◆◆getUpdateAccountsTest1:END');
    }
    
    /*
	 * 取引先の更新値をセット・テスト
	 * 取引先あり
	 */
    static testMethod void getUpdateAccountsTest2() {
        System.debug('◆◆◆◆getUpdateAccountsTest2:START');
        
        // ユーザ取得
        User user = getUser();
        
        // テスト実施
        System.RunAs(user) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
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
            
            // テスト開始
            Test.startTest();
            
            // 取引先の更新値をセット
            accounts = action.getUpdateAccounts(accounts);
            for (Account account : accounts) {
            	System.assertEquals(account.Contacts.size(), account.ContactCnt__c);
            }
            
            // テスト終了
            Test.stopTest();
        }
        
        System.debug('◆◆◆◆getUpdateAccountsTest2:END');
    }
    
    /*
     * ログインユーザの情報取得
     * @param	: なし
     * @return	: ユーザ
     */
    private static User getUser() {
    	return [
    		select
    			Id
    		from
    			User
    		where
    			Id =: UserInfo.getUserId()
    		limit 1
    	];
    }
    
    /*
     * テスト用ページの取得
     * @param	: なし
     * @return	: テスト用ページ
     */
    private static PageReference getPageReference() {
    	return new PageReference('TestPage');
    }
    
    /*
     * 取引先テストデータ作成
     * @param	: なし
     * @return	: 取引先テストデータ
     */
    private static Account createAccount() {
    	Account account = new Account(
    		 Name = 'Test Company'
    		,ContactCnt__c = 0
    	);
    	insert account;
    	return account;
    }
    
    /*
     * 取引先責任者テストデータ作成
     * @param	: 取引先ID	[prmAccountId]
     * @return	: 取引先責任者テストデータ
     */
    private static Contact createContact(Id prmAccountId) {
    	Contact contact = new Contact(
	    	 LastName = 'Yoshkawa'
	    	,FirstName = 'Taiki'
	    	,AccountId = prmAccountId
    	);
    	return contact;
    }
    
    /*
     * 取引先取得
     * @param	: 取引先ID	[prmAccountId]
     * @return	: 取引先テストデータ
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
    
    /*
     * 取引先責任者取得(削除済)
     * @param	: なし
     * @return	: 取引先責任者テストデータ
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