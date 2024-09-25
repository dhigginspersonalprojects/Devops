public with sharing class GolfCourseClass {
    public static Set<Id> idsOfGolfCoursesToCheckIfCourseIsOnDatabase = new Set<Id>(); 
    public static List<Golf_Round__c> golfRoundsWhereCourseARENOTStoredOnDatabaseList = new List<Golf_Round__c>(); 
    public static List<Golf_Round__c> golfRoundsWhereCourseAREStoredOnDatabaseList = new List<Golf_Round__c>(); 

    public static List<Golf_Round__c> golfRoundsWhereCourseAreStoredOnDatabase(List<Golf_Round__c> golfRoundRecordsToCheck){
        Set<Id> golfRoundIds = new Set<Id>(); 
        for(Golf_Round__c triggerRecords : golfRoundRecordsToCheck){
            golfRoundIds.add(triggerRecords.Id); 
        }
        Set<Id> setOfGolfCoursesForRoundsThatAreStoredOnDatabase = golfCourseIdsForCoursesStoredOnDatabaseForRoundsCreated(golfRoundRecordsToCheck); 
        if(!setOfGolfCoursesForRoundsThatAreStoredOnDatabase.isEmpty()){
            golfRoundsWhereCourseAREStoredOnDatabaseList = [SELECT Course__c FROM Golf_Round__c WHERE Course__c IN : setOfGolfCoursesForRoundsThatAreStoredOnDatabase AND Id IN :golfRoundIds];     
        }
        if(!golfRoundsWhereCourseAREStoredOnDatabaseList.isEmpty()){
            return golfRoundsWhereCourseAREStoredOnDatabaseList; 
        } else {
            return null; 
        }
    }

    public static List<Golf_Round__c> golfRoundsWhereCourseAreNOTStoredOnDatabase(List<Golf_Round__c> golfRoundRecordsToCheck){
        Set<Id> golfRoundIds = new Set<Id>(); 
        for(Golf_Round__c triggerRecords : golfRoundRecordsToCheck){
            golfRoundIds.add(triggerRecords.Id); 
        }
        Set<Id> setOfGolfCoursesForRoundsThatAreNotStoredOnDatabase = golfCourseIdsForCoursesNOTStoredOnDatabaseForRoundsCreated(golfRoundRecordsToCheck); 
        if(!setOfGolfCoursesForRoundsThatAreNotStoredOnDatabase.isEmpty()){
            golfRoundsWhereCourseARENOTStoredOnDatabaseList = [SELECT Course__c FROM Golf_Round__c WHERE Course__c  IN : setOfGolfCoursesForRoundsThatAreNotStoredOnDatabase AND Id IN :golfRoundIds ];     
        }
        if(!golfRoundsWhereCourseARENOTStoredOnDatabaseList.isEmpty()){
            return golfRoundsWhereCourseARENOTStoredOnDatabaseList; 
        } else {
            return null; 
        }
    }


    public static set<Id> golfCourseIdsForCoursesStoredOnDatabaseForRoundsCreated(List<Golf_Round__c> golfRoundRecordsToCheckFor){
        Set<Id> coursesToCheck = new Set<Id>(); 
        Set<Id> setOfGolfCoursesForRoundsThatAreStoredOnDatabase = new Set<Id>(); 
        if(!golfRoundRecordsToCheckFor.isEmpty()){
            for(Golf_Round__c round : golfRoundRecordsToCheckFor){
                coursesToCheck.add(round.Course__c); 
            }
        }
        List<Golf_Course_Hole__c> golfHolesListLocal = new List<Golf_Course_Hole__c>([SELECT Course__c FROM Golf_Course_Hole__c WHERE Course__c IN : coursesToCheck ]);
        if(!golfHolesListLocal.isEmpty()){
            for(Golf_Course_Hole__c hole : golfHolesListLocal){
                setOfGolfCoursesForRoundsThatAreStoredOnDatabase.add(hole.Course__c); 
            }
        }
        return setOfGolfCoursesForRoundsThatAreStoredOnDatabase; 
   
    }

    public static set<Id> golfCourseIdsForCoursesNOTStoredOnDatabaseForRoundsCreated(List<Golf_Round__c> golfRoundRecordsToCheckFor){
        Set<Id> coursesToCheck = new Set<Id>(); 
        Set<Id> allGolfHolesCourseSet = new Set<Id>(); 
        Set<Id> setOfGolfCoursesForRoundsThatNOTAreStoredOnDatabase = new Set<Id>(); 
        if(!golfRoundRecordsToCheckFor.isEmpty()){
            for(Golf_Round__c round : golfRoundRecordsToCheckFor){
                coursesToCheck.add(round.Course__c); 
            }
        }
        List<Membership_Course__c> membershipCourses = new List<Membership_Course__c>([SELECT Id FROM Membership_Course__c WHERE Id IN :coursesToCheck]);
        List<Golf_Course_Hole__c> golfHolesList = new List<Golf_Course_Hole__c>([SELECT Course__c FROM Golf_Course_Hole__c]); 
        for(Golf_Course_Hole__c courseHole : golfHolesList){
            allGolfHolesCourseSet.add(courseHole.Course__c); 
        } 
        for(Membership_Course__c membSh : membershipCourses){
            if(!allGolfHolesCourseSet.contains(membSh.Id)){
                setOfGolfCoursesForRoundsThatNOTAreStoredOnDatabase.add(membSh.Id); 
            }
        }
        return setOfGolfCoursesForRoundsThatNOTAreStoredOnDatabase; 
   
    }

}