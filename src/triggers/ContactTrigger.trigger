/*
 * 取引先責任者トリガー
 * © 2013 Force.com Developer
 * ----------------------------------------
 * @createdName      : Taiki,Yoshikawa
 * @lastModifiedName : Taiki,Yoshikawa
 * ----------------------------------------
 */
trigger ContactTrigger on Contact (after delete, after insert, after update, after undelete) {
    System.debug('ContactTrigger:START');
    
    // Handlerクラス
    ContactTriggerHandler handler = new ContactTriggerHandler();
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            // 取引先に紐付く取引先責任者件数更新
            handler.updateContactCnt(Trigger.new);
            
        } else if (Trigger.isUpdate) {
            // 取引先に紐付く取引先責任者件数更新
            handler.updateContactCnt(Trigger.new, Trigger.old);
            
        } else if (Trigger.isDelete) {
            // 取引先に紐付く取引先責任者件数更新
            handler.updateContactCnt(Trigger.old);
            
        } else if (Trigger.isUnDelete) {
            // 取引先に紐付く取引先責任者件数更新
            handler.updateContactCnt(Trigger.new);
        }
    }

    System.debug('ContactTrigger:END');
}