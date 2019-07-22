declare module "@salesforce/apex/AddProductController.getAllProductByRegion" {
  export default function getAllProductByRegion(): Promise<any>;
}
declare module "@salesforce/apex/AddProductController.getProductBySearchTerm" {
  export default function getProductBySearchTerm(param: {searchKey: any}): Promise<any>;
}
declare module "@salesforce/apex/AddProductController.getOpportunityProducts" {
  export default function getOpportunityProducts(param: {oppId: any}): Promise<any>;
}
declare module "@salesforce/apex/AddProductController.saveOpportunityProducts" {
  export default function saveOpportunityProducts(param: {oppProds: any}): Promise<any>;
}
declare module "@salesforce/apex/AddProductController.deleteOpportunityProducts" {
  export default function deleteOpportunityProducts(param: {oppProductId: any, oppId: any}): Promise<any>;
}
