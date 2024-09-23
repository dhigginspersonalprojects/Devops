trigger GolfRoundTrigger on Golf_Round__c (before insert) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            GolfRoundTriggerHandler.beforeInsertHandler(Trigger.new);
        }
    }

}