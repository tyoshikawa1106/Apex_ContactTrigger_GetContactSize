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
public with sharing class ContactTriggerAction {
	
	/*
	 * コンストラクタ
	 * @param	: なし
	 * @return	: なし
	 */
	public ContactTriggerAction() {
		
	}
	
	/*
	 * 取引先ID取得
	 * @param	: 取引先責任者	[prmContacts]
	 * @return	: 取引先ID
	 */
	public Set<Id> getAccountId(List<Contact> prmContacts) {
		System.debug('◆◆◆◆getAccountId:START');
		
		Set<Id> accountIds = new Set<Id>();
		for (Contact c : prmContacts) {
			accountIds.add(c.AccountId);
		}
		
		System.debug('◆◆◆◆getAccountId:END');
		return accountIds;
	}
	
	/*
	 * 取引先ID取得
	 * @param	: 取引先責任者更新後	[prmContactNews]
	 * @param	: 取引先責任者更新前	[prmContactOlds]
	 * @return	: 取引先ID
	 */
	public Set<Id> getAccountId(List<Contact> prmContactNews, List<Contact> prmContactOlds) {
		System.debug('◆◆◆◆getAccountId:START');
		
		Set<Id> accountIds = new Set<Id>();
		for (Integer i = 0; i < prmContactNews.size(); i++) {
			if (prmContactNews[i].AccountId != prmContactOlds[i].AccountId) {
				accountIds.add(prmContactNews[i].AccountId);
				accountIds.add(prmContactOlds[i].AccountId);
			}
		}
		
		System.debug('◆◆◆◆getAccountId:END');
		return accountIds;
	}
	
	/*
	 * 取引先取得
	 * @param	: 取引先ID	[prmAccountIds]
	 * @return	: 取引先
	 */
	public List<Account> getAccounts(Set<Id> prmAccountIds) {
		return [
			select
				Id
				,(select Id from Contacts)
			from
				Account
			where
				Id IN: prmAccountIds
		];
	}
	
	/*
	 * 取引先の更新値をセット
	 * @param	: 取引先
	 * @return	: 取引先
	 */
	public List<Account> getUpdateAccounts(List<Account> prmAccounts) {
		System.debug('◆◆◆◆getUpdateAccounts:START');
		
		for (Account account : prmAccounts) {
			// 取引先責任者件数
			account.ContactCnt__c = account.Contacts.size();
		}
		
		System.debug('◆◆◆◆getUpdateAccounts:END');
		return prmAccounts;
	}
}