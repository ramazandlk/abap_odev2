@AbapCatalog.sqlViewName: 'ZRD_V1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds1'

define view zrd_odev_cds1 as select from vbrp
inner join vbrk on vbrp.vbeln = vbrk.vbeln
inner join mara on vbrp.matnr = mara.matnr
left outer join vbak on vbrp.aubel = vbak.vbeln
left outer join kna1 on kna1.kunnr = vbak.kunnr
left outer join makt on mara.matnr = mara.matnr
                    and makt.spras = $session.system_language

{
    vbrp.vbeln,
    vbrp.posnr,
    vbrp.aubel,
    vbrp.aupos,
    vbak.kunnr,
    concat_with_space(kna1.name1, kna1.name2, 1) as kunnrAd,
    currency_conversion( amount => vbrp.netwr , source_currency => vbrk.waerk, target_currency => cast('EUR' as abap.cuky( 5 )) , exchange_rate_date => vbrk.fkdat  ) as conversion_netwr,
    left( vbak.kunnr, 3 ) as left_kunnr,
    length(mara.matnr) as matnr_length,
    case when vbrk.fkart = 'FAS' then 'Peşinat Talebi İptali'
         when vbrk.fkart = 'FAZ' then 'Peşinat Talebi'
                                 else 'Fatura' end as fatura_turu,
    vbrk.fkdat               
}
