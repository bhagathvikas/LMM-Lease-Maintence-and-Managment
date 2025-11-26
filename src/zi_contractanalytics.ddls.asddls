@AbapCatalog.sqlViewName: 'ZLMM_CONTRACT_A'
@AbapCatalog.compiler.compareFilter: true

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'analytics of Contracts'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_contractAnalytics as select from zlmm_contract
{

key assetid,
  count( distinct contractid ) as contract_count,
  sum( rent_amt )     as total_rent,
  avg( rent_amt )     as avg_rent
    
}
group by assetid;
