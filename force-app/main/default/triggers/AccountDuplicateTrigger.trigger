trigger AccountDuplicateTrigger on Account (before insert) {
    AccountDuplicateTriggerHandler.checkforduplicates(Trigger.new, Trigger.operationType);

}