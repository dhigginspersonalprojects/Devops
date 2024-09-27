public with sharing class GolfValidatorClass {
    public static void validateScorecardScoresCompletedBeforeCompletingRound(List<Golf_Round__c> newRecords, Map<Id,Golf_Round__c> oldMap){ 
        List<Golf_Round__c> recordsInScopeForValidation = returnGolfRoundRecordsInScopeForValidation(newRecords,oldMap);
        if(recordsInScopeForValidation !=null){
            validateGolfRoundScoresAreComplete(recordsInScopeForValidation); 
        }  
        
        
    }
    public static List<Golf_Round__c> returnGolfRoundRecordsInScopeForValidation(List<Golf_Round__c> newRecords, Map<Id,Golf_Round__c> oldMap){
        List<Golf_Round__c> recordsInScopeForValidationToReturn = new List<Golf_Round__c>(); 
        for(Golf_Round__c rnd : newRecords){
                if(rnd.Status__c == 'Completed' && oldMap.get(rnd.Id).Status__c !=rnd.Status__c ){
                    recordsInScopeForValidationToReturn.add(rnd); 
                }       
        }
        if(!recordsInScopeForValidationToReturn.isEmpty()){
            return recordsInScopeForValidationToReturn; 
        } else {
            return null; 
        }
    }

    public static void validateGolfRoundScoresAreComplete(List<Golf_Round__c> golfRoundRecordsToCheck){
        Set<Id> golfRoundIds = new Set<Id>(); 
        for(Golf_Round__c round : golfRoundRecordsToCheck ){
            golfRoundIds.add(round.Id); 
        }
        for(Golf_Round__c rnd : golfRoundRecordsToCheck ){
            for(Golf_Round_Score__c scoresToCheck :  [SELECT Id, Score__c FROM Golf_Round_Score__c WHERE Golf_Round__c IN :golfRoundIds]){
                if(scoresToCheck.Score__c == '0'){
                    rnd.addError('You must enter all scores on the scorecard before completing the round'); 
                }
            } 
        }
        
    }
}