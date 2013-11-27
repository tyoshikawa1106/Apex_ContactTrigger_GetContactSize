/**
 * 取引先責任者トリガー
 * © 2013 Force.com Developer
 * ----------------------------------------
 * @createdName      : Taiki,Yoshikawa
 * @lastModifiedName : Taiki,Yoshikawa
 * ----------------------------------------
 */
public with sharing class ContactTriggerHandler {
    
    // Actionクラス
    private ContactTriggerAction action;
    
    /**
     * コンストラクタ
     */
    public ContactTriggerHandler() {
        // Actionクラス
        this.action = new ContactTriggerAction(); 
    }
    
    /**
     * 取引先に紐付く取引先責任者件数更新
     * @param   : 取引先責任者    [prmContacts]
     * @return  : none
     */
    public void updateContactCnt(List<Contact> prmContacts) {
        System.debug('updateContactCnt:START');
        
        // 取引先ID取得
        Set<Id> accountIds = this.action.getAccountId(prmContacts);
        // 取引先取得
        List<Account> accounts = this.action.getAccounts(accountIds);
        // 取引先の更新値取得
        accounts = this.action.getUpdateAccounts(accounts);
        // 取引先更新
        update accounts;
        
        System.debug('updateContactCnt:END');
    }
    
    /**
     * 取引先に紐付く取引先責任者件数更新
     * @param   : 取引先責任者更新後 [prmContactNews]
     * @param   : 取引先責任者更新前 [prmContactOlds]
     * @return  : none
     */
    public void updateContactCnt(List<Contact> prmContactNews, List<Contact> prmContactOlds) {
        System.debug('updateContactCnt:START');
        
        // 取引先ID取得
        Set<Id> accountIds = this.action.getAccountId(prmContactNews, prmContactOlds);
        // 取引先取得
        List<Account> accounts = this.action.getAccounts(accountIds);
        // 取引先の更新値取得
        accounts = this.action.getUpdateAccounts(accounts);
        // 取引先更新
        update accounts;
        
        System.debug('updateContactCnt:END');
    }
}