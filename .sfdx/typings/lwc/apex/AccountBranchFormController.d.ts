declare module "@salesforce/apex/AccountBranchFormController.getAccount" {
  export default function getAccount(param: {accId: any}): Promise<any>;
}
declare module "@salesforce/apex/AccountBranchFormController.saveAccount" {
  export default function saveAccount(param: {acc: any}): Promise<any>;
}
declare module "@salesforce/apex/AccountBranchFormController.saveChunk" {
  export default function saveChunk(param: {parentId: any, fileName: any, base64Data: any, contentType: any, fileId: any}): Promise<any>;
}
