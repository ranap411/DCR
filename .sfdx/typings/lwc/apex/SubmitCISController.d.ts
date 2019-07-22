declare module "@salesforce/apex/SubmitCISController.getBudgetOptions" {
  export default function getBudgetOptions(param: {recordId: any, headerId: any}): Promise<any>;
}
declare module "@salesforce/apex/SubmitCISController.saveCISRecord" {
  export default function saveCISRecord(param: {recordJSON: any, recordId: any, headerId: any, lastHeaderId: any}): Promise<any>;
}
declare module "@salesforce/apex/SubmitCISController.approveCISRecord" {
  export default function approveCISRecord(param: {headerId: any, status: any, comments: any}): Promise<any>;
}
