public with sharing class GolfScorecardClass {
    public static void createGolfScorecardAfterRoundIsCreatedForUnknownCourse(List<Golf_Round__c> golfRoundRecords){
        system.debug('golf round records passed through'+golfRoundRecords); 
        List<Golf_Round_Score__c> newGolfScoresToCreate = new List<Golf_Round_Score__c>(); 
        List<Golf_Scorecard__mdt> scorecards = Golf_Scorecard__mdt.getAll().values();
        String loggedInUser = returnGolfUserAccountForLoggedInUser(); 
        if(!scorecards.isEmpty()){
            if(!golfRoundRecords.isEmpty()){
                for(Golf_Round__c golfRound : golfRoundRecords ){
                    for(Golf_Scorecard__mdt scoreCardMtd : scorecards){
                        Golf_Round_Score__c score = new Golf_Round_Score__c();
                        score.Hole_Number__c =scoreCardMtd.Hole_Number__c; 
                        score.Score__c = scoreCardMtd.Hole_Score__c;
                        score.Par_of_Hole__c = scoreCardMtd.Par_of_Hole__c; 
                        score.Golf_Round__c= golfRound.Id; 
                        score.Golf_User_Account__c = loggedInUser; 
                        score.Hole_Distance_Yards__c = 0; 
                        newGolfScoresToCreate.add(score); 
                    }
                }
            }
        }
        if(!newGolfScoresToCreate.isEmpty()){
            insert newGolfScoresToCreate; 
        }
    }

    public static void createGolfScorecardAfterRoundIsCreatedForKNOWNCourse(List<Golf_Round__c> golfRoundRecords){
        system.debug('golf round records passed through'+golfRoundRecords); 
        List<Golf_Round_Score__c> newGolfScoresToCreate = new List<Golf_Round_Score__c>(); 
        List<Golf_Course_Hole__c> golfCourseHoles = new List<Golf_Course_Hole__c>();
        String loggedInUser = returnGolfUserAccountForLoggedInUser(); 
        Set<Id> courseIds = new Set<Id>(); 
        if(!golfRoundRecords.isEmpty()){
            for(Golf_Round__c rnd : golfRoundRecords){
                courseIds.add(rnd.Course__c); 
            }
        }
        golfCourseHoles= [SELECT Id, Course__c, Hole_Number__c, Par_of_Hole__c,Hole_Distance_Yards__c FROM Golf_Course_Hole__c WHERE Course__c IN :courseIds ]; 
        for(Golf_Round__c golfRoundRecs : golfRoundRecords ){
            for(Golf_Course_Hole__c holes : golfCourseHoles){
                Golf_Round_Score__c score = new Golf_Round_Score__c();
                score.Hole_Number__c =holes.Hole_Number__c; 
                score.Score__c = '0';
                score.Par_of_Hole__c = holes.Par_of_Hole__c; 
                score.Golf_Round__c= golfRoundRecs.Id; 
                score.Golf_User_Account__c = loggedInUser; 
                score.Hole_Distance_Yards__c = holes.Hole_Distance_Yards__c;
                newGolfScoresToCreate.add(score);
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