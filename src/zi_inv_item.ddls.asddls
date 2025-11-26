@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for invoice ITem'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_INV_ITEM as select from zlmm_inv_item

{
    
    key itemno,
  description,
  quantity,
  unit,
  unit_price,
  line_total,
  tax_percent
}
