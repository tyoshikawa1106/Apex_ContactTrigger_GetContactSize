/*
 * 取引先責任者トリガー・Actionテストクラス
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
        User objUser = getUser();
        
        // テスト実施
        System.RunAs(objUser) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先責任者
            List<Contact> objContacts = new List<Contact>();
            
            // テスト開始
            Test.startTest();            
            
            // 取引先ID
            Set<Id> accountIds = action.getAccountId(objContacts);
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
        User objUser = getUser();
        
        // テスト実施
        System.RunAs(objUser) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先取得
            Account objAccount = createAccount();
            
            // 取引先責任者
            List<Contact> objContacts = new List<Contact>();
            for (Integer i = 0; i < LIST_LIMIT; i++) {
            	objContacts.add(createContact(objAccount.Id));
            }
            
            // テスト開始
            Test.startTest();
            
            // 取引先ID
            Set<Id> accountIds = action.getAccountId(objContacts);
            for (Integer i = 0; i < objContacts.size(); i++) {
            	System.assertEquals(accountIds.contains(objContacts[i].accountId), true);
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
        User objUser = getUser();
        
        // テスト実施
        System.RunAs(objUser) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先取得
            Account objAccountNew = createAccount();
            Account objAccountOld = createAccount();
            
            // 取引先責任者
            List<Contact> objContactNews = new List<Contact>();
            List<Contact> objContactOlds = new List<Contact>();
            for (Integer i = 0; i < LIST_LIMIT; i++) {
            	objContactNews.add(createContact(objAccountNew.Id));
            	objContactOlds.add(createContact(objAccountOld.Id));
            }
            
            // テスト開始
            Test.startTest();
            
            // 取引先ID
            Set<Id> accountIds = action.getAccountId(objContactNews, objContactOlds);
            
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
        User objUser = getUser();
        
        // テスト実施
        System.RunAs(objUser) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先取得
            Set<Id> accountIds = new Set<Id>();
            Account objAccountNew = createAccount();
            Account objAccountOld = createAccount();
            accountIds.add(objAccountNew.Id);
            accountIds.add(objAccountOld.Id);
            
            // テスト開始
            Test.startTest();
            
            // 取引先ID
            List<Account> objAccounts = action.getAccounts(accountIds);
            for (Account objAccount : objAccounts) {
            	System.assertEquals(objAccount.Contacts.size(), 0);
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
        User objUser = getUser();
        
        // テスト実施
        System.RunAs(objUser) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先取得
            Set<Id> accountIds = new Set<Id>();
            Account objAccountNew = createAccount();
            Account objAccountOld = createAccount();
            accountIds.add(objAccountNew.Id);
            accountIds.add(objAccountOld.Id);
            
            // 取引先責任者
            Contact objContactNew = createContact(objAccountNew.Id);
            insert objContactNew;
            
            Contact objContactOld = createContact(objAccountOld.Id);
            insert objContactOld;
            
            // テスト開始
            Test.startTest();
            
            // 取引先ID
            List<Account> objAccounts = action.getAccounts(accountIds);
            for (Account objAccount : objAccounts) {
            	System.assertEquals(objAccount.Contacts.size(), 1);
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
        User objUser = getUser();
        
        // テスト実施
        System.RunAs(objUser) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先取得
            Set<Id> accountIds = new Set<Id>();
            Account objAccountNew = createAccount();
            Account objAccountOld = createAccount();
            accountIds.add(objAccountNew.Id);
            accountIds.add(objAccountOld.Id);
            
            // 取引先責任者
            Contact objContactNew = createContact(objAccountNew.Id);
            insert objContactNew;
            
            Contact objContactOld = createContact(objAccountOld.Id);
            insert objContactOld;
            
            // テスト開始
            Test.startTest();
            
            // 取引先ID
            List<Account> objAccounts = action.getAccounts(accountIds);
            for (Account objAccount : objAccounts) {
            	System.assertEquals(objAccount.Contacts.size(), 1);
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
        User objUser = getUser();
        
        // テスト実施
        System.RunAs(objUser) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先ID
            List<Account> objAccounts = new List<Account>();
            
            // テスト開始
            Test.startTest();
            
            // 取引先の更新値をセット
            objAccounts = action.getUpdateAccounts(objAccounts);
            System.assertEquals(objAccounts.isEmpty(), true);
            
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
        User objUser = getUser();
        
        // テスト実施
        System.RunAs(objUser) {
        	
        	// Actionクラス
        	ContactTriggerAction action = new ContactTriggerAction();
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先取得
            Set<Id> accountIds = new Set<Id>();
            Account objAccountNew = createAccount();
            Account objAccountOld = createAccount();
            accountIds.add(objAccountNew.Id);
            accountIds.add(objAccountOld.Id);
            
            // 取引先責任者
            Contact objContactNew = createContact(objAccountNew.Id);
            insert objContactNew;
            
            Contact objContactOld = createContact(objAccountOld.Id);
            insert objContactOld;
            
            // 取引先ID
            List<Account> objAccounts = action.getAccounts(accountIds);
            for (Account objAccount : objAccounts) {
            	System.assertEquals(objAccount.Contacts.size(), 1);
            }
            
            // テスト開始
            Test.startTest();
            
            // 取引先の更新値をセット
            objAccounts = action.getUpdateAccounts(objAccounts);
            for (Account objAccount : objAccounts) {
            	System.assertEquals(objAccount.Contacts.size(), objAccount.ContactCnt__c);
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
    	Account objAccount = new Account();
    	objAccount.Name = 'Test Company';
    	objAccount.ContactCnt__c = 0;
    	insert objAccount;
    	return objAccount;
    }
    
    /*
     * 取引先責任者テストデータ作成
     * @param	: 取引先ID	[prmAccountId]
     * @return	: 取引先責任者テストデータ
     */
    private static Contact createContact(Id prmAccountId) {
    	Contact objContact = new Contact();
    	objContact.LastName = 'Yoshkawa';
    	objContact.FirstName = 'Taiki';
    	objContact.AccountId = prmAccountId;
    	return objContact;
    }
    
    /*
     * 取引先取得
     * @param	: 取引先ID	[prmAccountId]
     * @return	: 取引先テストデータ
     */
    private static Account getAccount(Id prmAccountId) {
    	List<Account> objAccounts = [
    		select
    			Id
    			,ContactCnt__c
    		from
    			Account
    		where
    			Id =: prmAccountId
    		limit 1
    	];
    	if (objAccounts.isEmpty() != true) {
    		return objAccounts[0];
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