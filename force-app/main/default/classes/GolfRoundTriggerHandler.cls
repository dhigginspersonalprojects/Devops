public class GolfRoundTriggerHandler {

    public static String golfRoundName;  
    public static Date dateOfRound = Date.valueOf(system.now());
    public static void beforeInsertHandler(List<Golf_Round__c> newRecords){
        if(!newRecords.isEmpty()){
            for(Golf_Round__c gol : newRecords){
                String courseName = getCourseName(gol.Course__c);  
                gol.Name = courseName + ' ' + dateOfRound;
                gol.Date__c = dateOfRound;
            }
        }
    }

    public static void afterInsertHandler(List<Golf_Round__c> newRecords){
        GolfScorecardClass.createGolfScorecardAfterRoundIsCreated(newRecords); 
    }

    public static String getCourseName(Id courseId){
        return [SELECT Name FROM Membership_Course__c  WHERE Id = :courseId].Name !=null ? [SELECT Name FROM Membership_Course__c  WHERE Id = :courseId].Name : null ; 
    }
}