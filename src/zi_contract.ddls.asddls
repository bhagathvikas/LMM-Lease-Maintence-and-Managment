
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root view for contract'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZI_CONTRACT
  as select from zlmm_contract
{


  
  key contractid,

 
  assetid,

  
  tenantid,

  startdate,

  enddate,

  rent_amt,

 
  status
}
