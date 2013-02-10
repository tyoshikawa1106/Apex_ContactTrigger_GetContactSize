/*
 * 取引先責任者トリガー・Handlerテストクラス
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
        User objUser = getUser();
        
        // テスト実施
        System.RunAs(objUser) {
            
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
        User objUser = getUser();
        
        // テスト実施
        System.RunAs(objUser) {
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先テストデータ作成
            Account objAccount = createAccount();
            // 取引先が登録されていることを確認
            System.assertEquals(String.isEmpty(objAccount.Id), false);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(objAccount.ContactCnt__c, 0);
            
            // テスト開始
            Test.startTest();
            
            // 取引先責任者INSERT
            Contact objContact = createContact(objAccount.Id);
            // 取引先が登録されていることを確認
            System.assertEquals(String.isEmpty(objContact.AccountId), false);
            
            // 取引先取得
            Account result = new Account();
            result = getAccount(objAccount.Id);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(result.ContactCnt__c, 1);
            
            // 取引先責任者DELETE
            delete objContact;
            
            // 取引先取得
            result = getAccount(objAccount.Id);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(result.ContactCnt__c, 0);
            
            // 取引先取得(削除済み)
            List<Contact> objContactDels = getContactAllRows();
            System.assertEquals(objContactDels.size(), 1);
            
            // 取引先復元
            undelete objContactDels;
            
            // 取引先取得
            result = getAccount(objAccount.Id);
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
        User objUser = getUser();
        
        // テスト実施
        System.RunAs(objUser) {
            
            // カレントページにパラメータを設定
            PageReference pageRef = getPageReference();
            Test.setCurrentPage(pageRef);
            
            // 取引先テストデータ作成(更新前用)
            Account objAccountOld = createAccount();
            // 取引先が登録されていることを確認
            System.assertEquals(String.isEmpty(objAccountOld.Id), false);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(objAccountOld.ContactCnt__c, 0);
            
            // 取引先責任者INSERT
            Contact objContact = createContact(objAccountOld.Id);
            // 取引先が登録されていることを確認
            System.assertEquals(String.isEmpty(objContact.AccountId), false);
            
            // 取引先取得
            Account resultOld = new Account();
            resultOld = getAccount(objAccountOld.Id);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(resultOld.ContactCnt__c, 1);
            
            // 取引先テストデータ作成(更新後用)
            Account objAccountNew = createAccount();
            // 取引先が登録されていることを確認
            System.assertEquals(String.isEmpty(objAccountNew.Id), false);
            // 取引先に紐付く取引先責任者件数の確認
            System.assertEquals(objAccountNew.ContactCnt__c, 0);
            
            // テスト開始
            Test.startTest();
            
            // 取引先責任者の紐付き先変更
            objContact.AccountId = objAccountNew.Id;
            update objContact;
            
            // 取引先に紐付く取引先責任者件数の確認
            resultOld = getAccount(objAccountOld.Id);
            System.assertEquals(resultOld.ContactCnt__c, 0);
            
            Account resultNew = getAccount(objAccountNew.Id);
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
    	insert objContact;
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