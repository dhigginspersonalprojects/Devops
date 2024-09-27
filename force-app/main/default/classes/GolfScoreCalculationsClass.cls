public with sharing class GolfScoreCalculationsClass {
    public static void updateGolfRoundHighLevelCalculations(List<Golf_Round__c> golfRoundsToUpdateScoresFor, Map<Id,Golf_Round__c> oldMap){
        List<Golf_Round__c> recordsInScopeForCalculation = GolfValidatorClass.returnGolfRoundRecordsInScopeForValidation(golfRoundsToUpdateScoresFor,oldMap);
        Set<Id> golfRounIds = new Set<Id>(); 
        if(recordsInScopeForCalculation !=null){
            for(Golf_Round__c golfround : recordsInScopeForCalculation ){
                golfRounIds.add(golfround.Id); 
            }
        }
        if(!golfRounIds.isEmpty()){
            List<Golf_Round_Score__c> allScorecardsForAllRoundsInScope = new List<Golf_Round_Score__c>([SELECT Id,Par_of_Hole__c, Score__c FROM Golf_Round_Score__c WHERE Golf_Round__c IN :golfRounIds]);
        }
        
        
    }
}