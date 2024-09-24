public with sharing class GolfScorecardClass {
    public static void createGolfScorecardAfterRoundIsCreated(List<Golf_Round__c> newRecords){
        List<Golf_Round_Score__c> newGolfScoresToCreate = new List<Golf_Round_Score__c>(); 
        List<Golf_Scorecard__mdt> scorecards = Golf_Scorecard__mdt.getAll().values();
        String loggedInUser = returnGolfUserAccountForLoggedInUser(); 
        if(!scorecards.isEmpty()){
            if(!newRecords.isEmpty()){
                for(Golf_Round__c golfRound : newRecords ){
                    for(Golf_Scorecard__mdt scoreCardMtd : scorecards){
                        Golf_Round_Score__c score = new Golf_Round_Score__c();
                        score.Hole_Number__c =scoreCardMtd.Hole_Number__c; 
                        score.Score__c = scoreCardMtd.Hole_Score__c;
                        score.Par_of_Hole__c = scoreCardMtd.Par_of_Hole__c; 
                        score.Golf_Round__c= golfRound.Id; 
                        score.Golf_User_Account__c = loggedInUser; 
                        newGolfScoresToCreate.add(score); 
                    }
                }
            }
        }
        if(!newGolfScoresToCreate.isEmpty()){
            insert newGolfScoresToCreate; 
        }
    }

    public static Id returnGolfUserAccountForLoggedInUser(){
        Id loggedInUserId =  UserInfo.getUserId(); 
        Id golfUserAccountId = [SELECT Id FROM Golf_User_Account__c WHERE OwnerId = :loggedInUserId  LIMIT 1].Id;
        if(golfUserAccountId == null){
            return null;
        } else {
            return golfUserAccountId;
        }
    }
}