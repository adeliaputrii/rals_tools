import 'package:json_annotation/json_annotation.dart';

part 'check_price_response.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)

class CheckPriceResponse{
  int? status;
  String? message;
  List<Data>? data;

  CheckPriceResponse({this.status, this.message, this.data});

  CheckPriceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
@JsonSerializable(fieldRename: FieldRename.snake)
class Data {
  String? site;
  String? siteMaris;
  String? md;
  String? dept;
  String? classe;
  String? sclass;
  String? article;
  String? skuCode;
  String? skuDescL;
  String? skuDescS;
  String? pricing;
  String? defy;
  String? hjTglStart;
  String? hargajual;
  String? defn;
  String? dateUpdate;
  String? mclass;
  String? def01;
  String? def02;
  String? def03;
  String? avgcost;
  String? empty01;
  String? empty02;
  String? uomSales;
  String? dateCreate;
  String? defa1;
  String? sku13;
  String? pajak;
  String? productType;
  String? empty03;
  String? emptyn;
  String? skuTimbangan;
  String? expireDay;
  String? promodisc1;
  String? promodisc2;
  String? promoprice1;
  String? promodisc3;
  String? tglml;
  String? tglsd;
  String? empty04;
  String? oldHargaJual;
  String? lastProses;

  Data(
      {this.site,
      this.siteMaris,
      this.md,
      this.dept,
      this.classe,
      this.sclass,
      this.article,
      this.skuCode,
      this.skuDescL,
      this.skuDescS,
      this.pricing,
      this.defy,
      this.hjTglStart,
      this.hargajual,
      this.defn,
      this.dateUpdate,
      this.mclass,
      this.def01,
      this.def02,
      this.def03,
      this.avgcost,
      this.empty01,
      this.empty02,
      this.uomSales,
      this.dateCreate,
      this.defa1,
      this.sku13,
      this.pajak,
      this.productType,
      this.empty03,
      this.emptyn,
      this.skuTimbangan,
      this.expireDay,
      this.promodisc1,
      this.promodisc2,
      this.promoprice1,
      this.promodisc3,
      this.tglml,
      this.tglsd,
      this.empty04,
      this.oldHargaJual,
      this.lastProses});

  Data.fromJson(Map<String, dynamic> json) {
    site = json['site'];
    siteMaris = json['site_maris'];
    md = json['md'];
    dept = json['dept'];
    classe = json['classe'];
    sclass = json['sclass'];
    article = json['article'];
    skuCode = json['sku_code'];
    skuDescL = json['sku_desc_l'];
    skuDescS = json['sku_desc_s'];
    pricing = json['pricing'];
    defy = json['defy'];
    hjTglStart = json['hj_tgl_start'];
    hargajual = json['hargajual'];
    defn = json['defn'];
    dateUpdate = json['date_update'];
    mclass = json['mclass'];
    def01 = json['def01'];
    def02 = json['def02'];
    def03 = json['def03'];
    avgcost = json['avgcost'];
    empty01 = json['empty01'];
    empty02 = json['empty02'];
    uomSales = json['uom_sales'];
    dateCreate = json['date_create'];
    defa1 = json['defa1'];
    sku13 = json['sku13'];
    pajak = json['pajak'];
    productType = json['product_type'];
    empty03 = json['empty03'];
    emptyn = json['emptyn'];
    skuTimbangan = json['sku_timbangan'];
    expireDay = json['expire_day'];
    promodisc1 = json['promodisc1'];
    promodisc2 = json['promodisc2'];
    promoprice1 = json['promoprice1'];
    promodisc3 = json['promodisc3'];
    tglml = json['tglml'];
    tglsd = json['tglsd'];
    empty04 = json['empty04'];
    oldHargaJual = json['old_harga_jual'];
    lastProses = json['last_proses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['site'] = this.site;
    data['site_maris'] = this.siteMaris;
    data['md'] = this.md;
    data['dept'] = this.dept;
    data['classe'] = this.classe;
    data['sclass'] = this.sclass;
    data['article'] = this.article;
    data['sku_code'] = this.skuCode;
    data['sku_desc_l'] = this.skuDescL;
    data['sku_desc_s'] = this.skuDescS;
    data['pricing'] = this.pricing;
    data['defy'] = this.defy;
    data['hj_tgl_start'] = this.hjTglStart;
    data['hargajual'] = this.hargajual;
    data['defn'] = this.defn;
    data['date_update'] = this.dateUpdate;
    data['mclass'] = this.mclass;
    data['def01'] = this.def01;
    data['def02'] = this.def02;
    data['def03'] = this.def03;
    data['avgcost'] = this.avgcost;
    data['empty01'] = this.empty01;
    data['empty02'] = this.empty02;
    data['uom_sales'] = this.uomSales;
    data['date_create'] = this.dateCreate;
    data['defa1'] = this.defa1;
    data['sku13'] = this.sku13;
    data['pajak'] = this.pajak;
    data['product_type'] = this.productType;
    data['empty03'] = this.empty03;
    data['emptyn'] = this.emptyn;
    data['sku_timbangan'] = this.skuTimbangan;
    data['expire_day'] = this.expireDay;
    data['promodisc1'] = this.promodisc1;
    data['promodisc2'] = this.promodisc2;
    data['promoprice1'] = this.promoprice1;
    data['promodisc3'] = this.promodisc3;
    data['tglml'] = this.tglml;
    data['tglsd'] = this.tglsd;
    data['empty04'] = this.empty04;
    data['old_harga_jual'] = this.oldHargaJual;
    data['last_proses'] = this.lastProses;
    return data;
  }
}
