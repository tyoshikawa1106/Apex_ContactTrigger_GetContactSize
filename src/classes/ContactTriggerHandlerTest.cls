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
private class ContactTriggerHandlerTest {

    /*
	 * 取引先に紐付く取引先責任者件数更新・テスト
	 * 取引先なし
	 */
    static testMethod void updateContactCntTest1() {
        System.debug('◆◆◆◆updateContactCntTest1:START');
        
        // ユーザ取得
        User user = getUser();
        
        // テスト実施
        System.RunAs(user) {
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // テスト開始
            Test.startTest();
            
            // 取引先責任者INSERT
            Contact result = createContact(null);
            // 取引先がNULLで登録されていることを確認
            System.assertEquals(String.isEmpty(result.AccountId), true);
            
            // テスト終了
            Test.stopTest();
        }
        
        System.debug('◆◆◆◆updateContactCntTest1:END');
    }
    
    /*
	 * 取引先に紐付く取引先責任者件数更新・テスト
	 * 取引先あり
	 */
    static testMethod void updateContactCntTest2() {
        System.debug('◆◆◆◆updateContactCntTest2:START');
        
        // ユーザ取得
        User user = getUser();
        
        // テスト実施
        System.RunAs(user) {
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先テストデータ作成
            Account account = createAccount();
            // 取引先が登録されていることを確認
            System.assertEquals(String.isEmpty(account.Id), false);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(account.ContactCnt__c, 0);
            
            // テスト開始
            Test.startTest();
            
            // 取引先責任者INSERT
            Contact contact = createContact(account.Id);
            // 取引先が登録されていることを確認
            System.assertEquals(String.isEmpty(contact.AccountId), false);
            
            // 取引先取得
            Account result = new Account();
            result = getAccount(account.Id);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(result.ContactCnt__c, 1);
            
            // 取引先責任者DELETE
            delete contact;
            
            // 取引先取得
            result = getAccount(account.Id);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(result.ContactCnt__c, 0);
            
            // 取引先取得(削除済み)
            List<Contact> contactDels = getContactAllRows();
            System.assertEquals(contactDels.size(), 1);
            
            // 取引先復元
            undelete contactDels;
            
            // 取引先取得
            result = getAccount(account.Id);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(result.ContactCnt__c, 1);
            
            // テスト終了
            Test.stopTest();
        }
        
        System.debug('◆◆◆◆updateContactCntTest2:END');
    }
    
    /*
	 * 取引先に紐付く取引先責任者件数更新・テスト
	 * 取引先の変更
	 */
    static testMethod void updateContactCntTest3() {
        System.debug('◆◆◆◆updateContactCntTest3:START');
        
        // ユーザ取得
        User user = getUser();
        
        // テスト実施
        System.RunAs(user) {
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先テストデータ作成(更新前用)
            Account accountOld = createAccount();
            // 取引先が登録されていることを確認
            System.assertEquals(String.isEmpty(accountOld.Id), false);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(accountOld.ContactCnt__c, 0);
            
            // 取引先責任者INSERT
            Contact contact = createContact(accountOld.Id);
            // 取引先が登録されていることを確認
            System.assertEquals(String.isEmpty(contact.AccountId), false);
            
            // 取引先取得
            Account resultOld = new Account();
            resultOld = getAccount(accountOld.Id);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(resultOld.ContactCnt__c, 1);
            
            // 取引先テストデータ作成(更新後用)
            Account accountNew = createAccount();
            // 取引先が登録されていることを確認
            System.assertEquals(String.isEmpty(accountNew.Id), false);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(accountNew.ContactCnt__c, 0);
            
            // テスト開始
            Test.startTest();
            
            // 取引先責任者の紐付き先変更
            contact.AccountId = accountNew.Id;
            update contact;
            
            // 取引先に紐付く取引先責任者件数の確認
            resultOld = getAccount(accountOld.Id);
            System.assertEquals(resultOld.ContactCnt__c, 0);
            
            Account resultNew = getAccount(accountNew.Id);
            System.assertEquals(resultNew.ContactCnt__c, 1);
            
            // テスト終了
            Test.stopTest();
        }
        
        System.debug('◆◆◆◆updateContactCntTest3:END');
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
    	insert contact;
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