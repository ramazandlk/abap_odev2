@AbapCatalog.sqlViewName: 'ZRD_V2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds2'
define view zrd_odev_cds2
  as select from zrd_odev_cds1 as cds1
{

  cds1.vbeln,
  @Semantics.amount.currencyCode: 'VBRK.WAERK'
  sum(cds1.conversion_netwr)                                                               as conversion_netwr2,
  cds1.kunnr,
  count(*)                                                                                 as total_billing_items,
  @Semantics.amount.currencyCode: 'VBRK.WAERK'
  division( cast( sum(cds1.conversion_netwr) as netwr), cast ( count(*) as abap.int4 ), 2) as avg_price,

  substring( cds1.fkdat, 1, 4)                                                             as bill_year,
  substring( cds1.fkdat, 5, 2)                                                             as bill_month,
  substring( cds1.fkdat, 7, 2)                                                             as bill_day,
  substring( cds1.fkdat, 1, 3)                                                             as incoterm
}
group by
  cds1.vbeln,
  cds1.kunnr,
  cds1.fkdat
