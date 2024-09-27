trigger GolfRoundTrigger on Golf_Round__c (before insert, after Insert, before update, after update) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            GolfRoundTriggerHandler.beforeInsertHandler(Trigger.new);
        }
        when AFTER_INSERT {
            GolfRoundTriggerHandler.afterInsertHandler(Trigger.new);
        }
        when BEFORE_UPDATE {
            GolfRoundTriggerHandler.beforeUpdateHandler(Trigger.new, Trigger.oldMap); 
             
        }
    }

}