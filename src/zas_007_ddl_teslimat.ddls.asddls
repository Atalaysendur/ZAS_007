@AbapCatalog.sqlViewName: 'ZAS007CDSTSLMT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Teslimat CDS View'
define view ZAS_007_DDL_TESLIMAT
  as select distinct from lips
    inner join            likp                   on likp.vbeln = lips.vbeln
    left outer join       ZAS_007_DDL_SIPARIS on  ZAS_007_DDL_SIPARIS.vbeln = lips.vgbel
                                                 and ZAS_007_DDL_SIPARIS.matnr = lips.matnr
    inner join            kna1                   on kna1.kunnr = likp.kunnr

{

  key lips.vgbel,
      lips.matnr,
      ZAS_007_DDL_SIPARIS.toplam_kwmeng,
      ZAS_007_DDL_SIPARIS.toplam_netwr,
      lips.lfimg,
      concat_with_space(kna1.name1,kna1.ort01,1) as adres,
      case
      when lips.lfimg > 5 then 'Büyük Teslimat'
      when lips.lfimg <= 5 then 'Küçük Teslimat'
      end                                        as Tip,
      division(lips.lfimg,5,2)                   as bolum
}
