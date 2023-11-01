@AbapCatalog.sqlViewName: 'ZRD_V2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds2'
define view zrd_odev_cds2 as select from zrd_odev_cds1 as zcds1 
{

    zcds1 .vbeln,
    @Semantics.amount.currencyCode: 'VBRK.WAERK'
    sum(zcds1 .conversion_netwr) as total_nprice,
    zcds1 .kunnr,
    count(*) as total_billing_items,
    @Semantics.amount.currencyCode: 'VBRK.WAERK'
    division( cast( sum(zcds1.conversion_netwr) as netwr), cast ( count(*) as abap.int4 ), 2) as avg_price,

    substring( zcds1 .fkdat, 1, 4) as bill_year,
    substring( zcds1 .fkdat, 5, 2) as bill_month,
    substring( zcds1 .fkdat, 7, 2) as bill_day,
    substring( zcds1 .fkdat, 1, 3) as incoterm
}
group by zcds1 .vbeln, zcds1 .kunnr, zcds1 .fkdat
