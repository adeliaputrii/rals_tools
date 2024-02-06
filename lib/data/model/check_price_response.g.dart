// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_price_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPriceResponse _$CheckPriceResponseFromJson(Map<String, dynamic> json) =>
    CheckPriceResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckPriceResponseToJson(CheckPriceResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      site: json['site'] as String?,
      siteMaris: json['site_maris'] as String?,
      md: json['md'] as String?,
      dept: json['dept'] as String?,
      classe: json['classe'] as String?,
      sclass: json['sclass'] as String?,
      article: json['article'] as String?,
      skuCode: json['sku_code'] as String?,
      skuDescL: json['sku_desc_l'] as String?,
      skuDescS: json['sku_desc_s'] as String?,
      pricing: json['pricing'] as String?,
      defy: json['defy'] as String?,
      hjTglStart: json['hj_tgl_start'] as String?,
      hargajual: json['hargajual'] as String?,
      defn: json['defn'] as String?,
      dateUpdate: json['date_update'] as String?,
      mclass: json['mclass'] as String?,
      def01: json['def01'] as String?,
      def02: json['def02'] as String?,
      def03: json['def03'] as String?,
      avgcost: json['avgcost'] as String?,
      empty01: json['empty01'] as String?,
      empty02: json['empty02'] as String?,
      uomSales: json['uom_sales'] as String?,
      dateCreate: json['date_create'] as String?,
      defa1: json['defa1'] as String?,
      sku13: json['sku13'] as String?,
      pajak: json['pajak'] as String?,
      productType: json['product_type'] as String?,
      empty03: json['empty03'] as String?,
      emptyn: json['emptyn'] as String?,
      skuTimbangan: json['sku_timbangan'] as String?,
      expireDay: json['expire_day'] as String?,
      promodisc1: json['promodisc1'] as String?,
      promodisc2: json['promodisc2'] as String?,
      promoprice1: json['promoprice1'] as String?,
      promodisc3: json['promodisc3'] as String?,
      tglml: json['tglml'] as String?,
      tglsd: json['tglsd'] as String?,
      empty04: json['empty04'] as String?,
      oldHargaJual: json['old_harga_jual'] as String?,
      lastProses: json['last_proses'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'site': instance.site,
      'site_maris': instance.siteMaris,
      'md': instance.md,
      'dept': instance.dept,
      'classe': instance.classe,
      'sclass': instance.sclass,
      'article': instance.article,
      'sku_code': instance.skuCode,
      'sku_desc_l': instance.skuDescL,
      'sku_desc_s': instance.skuDescS,
      'pricing': instance.pricing,
      'defy': instance.defy,
      'hj_tgl_start': instance.hjTglStart,
      'hargajual': instance.hargajual,
      'defn': instance.defn,
      'date_update': instance.dateUpdate,
      'mclass': instance.mclass,
      'def01': instance.def01,
      'def02': instance.def02,
      'def03': instance.def03,
      'avgcost': instance.avgcost,
      'empty01': instance.empty01,
      'empty02': instance.empty02,
      'uom_sales': instance.uomSales,
      'date_create': instance.dateCreate,
      'defa1': instance.defa1,
      'sku13': instance.sku13,
      'pajak': instance.pajak,
      'product_type': instance.productType,
      'empty03': instance.empty03,
      'emptyn': instance.emptyn,
      'sku_timbangan': instance.skuTimbangan,
      'expire_day': instance.expireDay,
      'promodisc1': instance.promodisc1,
      'promodisc2': instance.promodisc2,
      'promoprice1': instance.promoprice1,
      'promodisc3': instance.promodisc3,
      'tglml': instance.tglml,
      'tglsd': instance.tglsd,
      'empty04': instance.empty04,
      'old_harga_jual': instance.oldHargaJual,
      'last_proses': instance.lastProses,
    };
