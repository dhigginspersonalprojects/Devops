public class GolfRoundTriggerHandler {

    public static String golfRoundName;  
    public static Date dateOfRound = Date.valueOf(system.now());
    public static List<Golf_Round__c> golfRoundsWhereCoursesAREOnDatabase = new List<Golf_Round__c>();
    public static List<Golf_Round__c> golfRoundsWhereCoursesARENOTOnDatabase = new List<Golf_Round__c>(); 


    public static void beforeInsertHandler(List<Golf_Round__c> newRecords){
        if(!newRecords.isEmpty()){
            for(Golf_Round__c gol : newRecords){
                String courseName = getCourseName(gol.Course__c);  
                gol.Name = courseName + ' ' + dateOfRound;
                gol.Date__c = dateOfRound;
            }
        }
    }

    public static void afterInsertHandler(List<Golf_Round__c> newGolfRoundRecords){
        /**
         Identify the course a user is creating a round for, if it's on the database populate the scorecard with the holes
         and pars of the holes, if it's not on the database populate a blank scorecard 
         */
        golfRoundsWhereCoursesAREOnDatabase = GolfCourseClass.golfRoundsWhereCourseAreStoredOnDatabase(newGolfRoundRecords); 
        golfRoundsWhereCoursesARENOTOnDatabase = GolfCourseClass.golfRoundsWhereCourseAreNOTStoredOnDatabase(newGolfRoundRecords); 
        if(golfRoundsWhereCoursesARENOTOnDatabase !=null){
            GolfScorecardClass.createGolfScorecardAfterRoundIsCreatedForUnknownCourse(golfRoundsWhereCoursesARENOTOnDatabase); 
        }
        if(golfRoundsWhereCoursesAREOnDatabase !=null){
            GolfScorecardClass.createGolfScorecardAfterRoundIsCreatedForKNOWNCourse(golfRoundsWhereCoursesAREOnDatabase); 
        }   
    }

    public static String getCourseName(Id courseId){
        return [SELECT Name FROM Membership_Course__c  WHERE Id = :courseId].Name !=null ? [SELECT Name FROM Membership_Course__c  WHERE Id = :courseId].Name : null ; 
    }
}