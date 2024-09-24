public with sharing class GolfScorecardController {
@AuraEnabled(cacheable = true)
public static List<Golf_Round_Score__c> getAllScores(Id golfRoundId){
    return [SELECT Id, Hole_Number__c, Par_of_Hole__c, Score__c  FROM Golf_Round_Score__c WHERE Golf_Round__c = :golfRoundId  ORDER BY Hole_Number__c ASC ];
}
}