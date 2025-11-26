@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS invoce header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_INV_HDR as select from zlmm_inv_hdr

{
   key invid,
  contractid,
  tenantid,
  invoice_date,
  due_date,
  period_from,
  period_to,
  net_amt,
  tax_amt,
  total_amt,
  currency,
  payment_terms,
  billing_street,
  billing_city,
  billing_state,
  billing_postal,
  billing_country,
  invoice_pdf_url,
  status,
  created_by,
  created_on
}
