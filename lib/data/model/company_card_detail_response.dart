import 'package:json_annotation/json_annotation.dart';

part 'company_card_detail_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyCardDetailResponse {
  int? status;
  String? message;
  List<Data>? data;

  CompanyCardDetailResponse({this.status, this.message, this.data});

  CompanyCardDetailResponse.fromJson(Map<String, dynamic> json) {
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
  String? nokartu;
  String? nama;
  String? alamat;
  int? jeniskel;
  String? tgllahir;
  String? stkawin;
  int? pekerjaan;
  int? anakPria;
  int? anakWanita;
  int? kebangsaan;
  String? custBangsa;
  String? kelurahan;
  String? poin;
  String? noktp;
  String? notelpon;
  String? tgldaftar;
  String? userupd;
  String? tglupd;
  String? storigin;
  int? status;
  String? tglinaktif;
  String? t4lahir;
  String? rt;
  String? rw;
  String? kodepost;
  int? kota;
  int? agama;
  String? custAgama;
  String? tlprm;
  String? email;
  int? pendapatan;
  int? informasi;
  String? custInfo;
  int? pendidikan;
  String? custPendidikan;
  String? koran;
  String? custKoran;
  String? radio;
  String? custRadio;
  int? typeMc;
  String? saldo;
  String? pemakaian;
  String? divisi;
  String? several;
  String? custApps;
  String? nopin;
  String? personId;
  String? rmyId;
  String? tglKaryAktif;
  String? idLama;
  String? nomorHape;
  String? userUpdate1;
  String? dateUpdate1;

  Data(
      {this.nokartu,
      this.nama,
      this.alamat,
      this.jeniskel,
      this.tgllahir,
      this.stkawin,
      this.pekerjaan,
      this.anakPria,
      this.anakWanita,
      this.kebangsaan,
      this.custBangsa,
      this.kelurahan,
      this.poin,
      this.noktp,
      this.notelpon,
      this.tgldaftar,
      this.userupd,
      this.tglupd,
      this.storigin,
      this.status,
      this.tglinaktif,
      this.t4lahir,
      this.rt,
      this.rw,
      this.kodepost,
      this.kota,
      this.agama,
      this.custAgama,
      this.tlprm,
      this.email,
      this.pendapatan,
      this.informasi,
      this.custInfo,
      this.pendidikan,
      this.custPendidikan,
      this.koran,
      this.custKoran,
      this.radio,
      this.custRadio,
      this.typeMc,
      this.saldo,
      this.pemakaian,
      this.divisi,
      this.several,
      this.custApps,
      this.nopin,
      this.personId,
      this.rmyId,
      this.tglKaryAktif,
      this.idLama,
      this.nomorHape,
      this.userUpdate1,
      this.dateUpdate1});

  Data.fromJson(Map<String, dynamic> json) {
    nokartu = json['nokartu'];
    nama = json['nama'];
    alamat = json['alamat'];
    jeniskel = json['jeniskel'];
    tgllahir = json['tgllahir'];
    stkawin = json['stkawin'];
    pekerjaan = json['pekerjaan'];
    anakPria = json['anak_pria'];
    anakWanita = json['anak_wanita'];
    kebangsaan = json['kebangsaan'];
    custBangsa = json['cust_bangsa'];
    kelurahan = json['kelurahan'];
    poin = json['poin'];
    noktp = json['noktp'];
    notelpon = json['notelpon'];
    tgldaftar = json['tgldaftar'];
    userupd = json['userupd'];
    tglupd = json['tglupd'];
    storigin = json['storigin'];
    status = json['status'];
    tglinaktif = json['tglinaktif'];
    t4lahir = json['t4lahir'];
    rt = json['rt'];
    rw = json['rw'];
    kodepost = json['kodepost'];
    kota = json['kota'];
    agama = json['agama'];
    custAgama = json['cust_agama'];
    tlprm = json['tlprm'];
    email = json['email'];
    pendapatan = json['pendapatan'];
    informasi = json['informasi'];
    custInfo = json['cust_info'];
    pendidikan = json['pendidikan'];
    custPendidikan = json['cust_pendidikan'];
    koran = json['koran'];
    custKoran = json['cust_koran'];
    radio = json['radio'];
    custRadio = json['cust_radio'];
    typeMc = json['type_mc'];
    saldo = json['saldo'];
    pemakaian = json['pemakaian'];
    divisi = json['divisi'];
    several = json['several'];
    custApps = json['cust_apps'];
    nopin = json['nopin'];
    personId = json['person_id'];
    rmyId = json['rmy_id'];
    tglKaryAktif = json['tgl_kary_aktif'];
    idLama = json['id_lama'];
    nomorHape = json['nomor_hape'];
    userUpdate1 = json['user_update1'];
    dateUpdate1 = json['date_update1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nokartu'] = this.nokartu;
    data['nama'] = this.nama;
    data['alamat'] = this.alamat;
    data['jeniskel'] = this.jeniskel;
    data['tgllahir'] = this.tgllahir;
    data['stkawin'] = this.stkawin;
    data['pekerjaan'] = this.pekerjaan;
    data['anak_pria'] = this.anakPria;
    data['anak_wanita'] = this.anakWanita;
    data['kebangsaan'] = this.kebangsaan;
    data['cust_bangsa'] = this.custBangsa;
    data['kelurahan'] = this.kelurahan;
    data['poin'] = this.poin;
    data['noktp'] = this.noktp;
    data['notelpon'] = this.notelpon;
    data['tgldaftar'] = this.tgldaftar;
    data['userupd'] = this.userupd;
    data['tglupd'] = this.tglupd;
    data['storigin'] = this.storigin;
    data['status'] = this.status;
    data['tglinaktif'] = this.tglinaktif;
    data['t4lahir'] = this.t4lahir;
    data['rt'] = this.rt;
    data['rw'] = this.rw;
    data['kodepost'] = this.kodepost;
    data['kota'] = this.kota;
    data['agama'] = this.agama;
    data['cust_agama'] = this.custAgama;
    data['tlprm'] = this.tlprm;
    data['email'] = this.email;
    data['pendapatan'] = this.pendapatan;
    data['informasi'] = this.informasi;
    data['cust_info'] = this.custInfo;
    data['pendidikan'] = this.pendidikan;
    data['cust_pendidikan'] = this.custPendidikan;
    data['koran'] = this.koran;
    data['cust_koran'] = this.custKoran;
    data['radio'] = this.radio;
    data['cust_radio'] = this.custRadio;
    data['type_mc'] = this.typeMc;
    data['saldo'] = this.saldo;
    data['pemakaian'] = this.pemakaian;
    data['divisi'] = this.divisi;
    data['several'] = this.several;
    data['cust_apps'] = this.custApps;
    data['nopin'] = this.nopin;
    data['person_id'] = this.personId;
    data['rmy_id'] = this.rmyId;
    data['tgl_kary_aktif'] = this.tglKaryAktif;
    data['id_lama'] = this.idLama;
    data['nomor_hape'] = this.nomorHape;
    data['user_update1'] = this.userUpdate1;
    data['date_update1'] = this.dateUpdate1;
    return data;
  }
}
