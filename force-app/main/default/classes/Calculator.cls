/********************************************
 * Version         Date         Name          Description
 * V1.0          18/04/2024    Developer2      Add Method Implemented 
 *********************************************/

/********************** 
Name:Calculator
Author: Diarmuid Higgins
Date: 10/04/2024
*********************/ 

public with sharing class Calculator {
    public Calculator() {

    }
    public integer sub(integer a, integer b){
        return a - b; 
    } 

    public integer add(integer a, integer b){
        return a + b; 
    }
  
}