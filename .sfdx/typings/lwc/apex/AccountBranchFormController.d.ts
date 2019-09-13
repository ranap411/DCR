declare module "@salesforce/apex/AccountBranchFormController.branch_details" {
  export default function branch_details(param: {branchID: any}): Promise<any>;
}
declare module "@salesforce/apex/AccountBranchFormController.getAccount" {
  export default function getAccount(param: {accId: any}): Promise<any>;
}
declare module "@salesforce/apex/AccountBranchFormController.saveAccount" {
  export default function saveAccount(param: {acc: any}): Promise<any>;
}
declare module "@salesforce/apex/AccountBranchFormController.saveChunk" {
  export default function saveChunk(param: {parentId: any, fileName: any, base64Data: any, contentType: any, fileId: any}): Promise<any>;
}
declare module "@salesforce/apex/AccountBranchFormController.getDependentMap" {
  export default function getDependentMap(param: {objDetail: any, contrfieldApiName: any, depfieldApiName: any}): Promise<any>;
}
