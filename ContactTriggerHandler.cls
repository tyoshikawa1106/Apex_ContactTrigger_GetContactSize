/*
 * 取引先責任者トリガー・Handlerクラス
 * © 2013 Force.com Developer
 * ----------------------------------------
 * @createdDate      : 2013/01/01
 * @createdName      : TAIKI,YOSHIKAWA
 * ----------------------------------------
 * @lastModifiedDate : 2013/01/01
 * @lastModifiedName : TAIKI,YOSHIKAWA
 * ----------------------------------------
 */
public with sharing class ContactTriggerHandler {
	
	// Actionクラス
	private ContactTriggerAction action;
	
	/*
	 * コンストラクタ
	 * @param	: なし
	 * @return	: なし
	 */
	public ContactTriggerHandler() {
		// Actionクラス
		this.action = new ContactTriggerAction(); 
	}
	
	/*
	 * 取引先に紐付く取引先責任者件数更新
	 * @param	: 取引先責任者	[prmContacts]
	 * @return	: なし
	 */
	public void updateContactCnt(List<Contact> prmContacts) {
		System.debug('◆◆◆◆updateContactCnt:START');
		
		// 取引先ID取得
		Set<Id> accountIds = this.action.getAccountId(prmContacts);
		// 取引先取得
		List<Account> objAccounts = this.action.getAccounts(accountIds);
		// 取引先の更新値取得
		objAccounts = this.action.getUpdateAccounts(objAccounts);
		// 取引先更新
		update objAccounts;
		
		System.debug('◆◆◆◆updateContactCnt:END');
	}
	
	/*
	 * 取引先に紐付く取引先責任者件数更新
	 * @param	: 取引先責任者更新後	[prmContactNews]
	 * @param	: 取引先責任者更新前	[prmContactOlds]
	 * @return	: なし
	 */
	public void updateContactCnt(List<Contact> prmContactNews, List<Contact> prmContactOlds) {
		System.debug('◆◆◆◆updateContactCnt:START');
		
		// 取引先ID取得
		Set<Id> accountIds = this.action.getAccountId(prmContactNews, prmContactOlds);
		// 取引先取得
		List<Account> objAccounts = this.action.getAccounts(accountIds);
		// 取引先の更新値取得
		objAccounts = this.action.getUpdateAccounts(objAccounts);
		// 取引先更新
		update objAccounts;
		
		System.debug('◆◆◆◆updateContactCnt:END');
	}
}