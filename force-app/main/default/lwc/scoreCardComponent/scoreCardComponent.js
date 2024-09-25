import { LightningElement, wire, api } from "lwc";
import getAllScores from "@salesforce/apex/GolfScorecardController.getAllScores";
import { refreshApex } from "@salesforce/apex";
import { updateRecord } from "lightning/uiRecordApi";

import { ShowToastEvent } from "lightning/platformShowToastEvent";
import HOLENUMBERFIELD from "@salesforce/schema/Golf_Round_Score__c.Hole_Number__c";
import PAROFHOLE from "@salesforce/schema/Golf_Round_Score__c.Par_of_Hole__c";
import SCOREOFHOLE from "@salesforce/schema/Golf_Round_Score__c.Score__c";  
import HOLEDISTANCEYARDS from "@salesforce/schema/Golf_Round_Score__c.Hole_Distance_Yards__c";

const COLS = [
  {
    label: "Hole Number",
    fieldName: HOLENUMBERFIELD.fieldApiName,
    editable: true
  },
  {
    label: "Par of Hole",
    fieldName: PAROFHOLE.fieldApiName,
    editable: true
  },
  { label: "Score", fieldName: SCOREOFHOLE.fieldApiName, editable: true },
  {
    label: "Distance(Yards)",
    fieldName: HOLEDISTANCEYARDS.fieldApiName,
    editable: true
  }

];

export default class scoreCardComponent extends LightningElement {
  @api recordId;
  columns = COLS;
  draftValues = [];

  @wire(getAllScores, { golfRoundId: "$recordId" })
  scores;

  async handleSave(event) {
    const records = event.detail.draftValues.slice().map((draftValue) => {
      const fields = Object.assign({}, draftValue);
      return { fields };
    });
    this.draftValues = [];

    try {
      const recordUpdatePromises = records.map((record) => updateRecord(record));
      await Promise.all(recordUpdatePromises);
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Success",
          message: "scores updated",
          variant: "success"
        })
      );
      await refreshApex(this.scores);
    } catch (error) {
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error updating or reloading scores",
          message: error.body.message,
          variant: "error"
        })
      );
    }
  }
}