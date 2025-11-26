@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'for projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}





define root view entity ZC_CONTRACT as projection on ZI_CONTRACT
{
  key contractid,
  assetid,
  tenantid,
  startdate,
  enddate,
  rent_amt,
  status

}
