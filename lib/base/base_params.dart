const String packageNameProd = 'com.rals.myactivity_project';
const String packageNameDev = 'com.rals.myactivity_project_dev';

// Dio attributes
const String contentType = 'Content-Type';
const String auth = 'Authorization';
const String appJson = 'application/json';

const String dash = '-';
const String noUrl = 'api url not found';

const String myApproval = 'Approval Title';

// Param hit API create my log
const String logProgname = 'RALS TOOLS';
const String logToken = 'R4M4Y4N4';
//*Log Login Page*//
const String logInfoLoginPage = 'Login Aplikasi RALS';
const String logInfoLoginSucc = 'Login Sukses';
const String logInfoLoginFail = 'Login Gagal';
//*Log Membercard //
const String logMembercardPage = 'Ramayana Membercard Page';
const String logAuthenticationSucc = 'Enter Password Membercard Success';
const String logAuthenticationfail = 'Enter Password Membercard Failed';
//*Log Reset Password Page*//
const String logInfoResetPage = 'Ramayana Reset Page';
const String logInfoResetSucc = 'Reset Password Sukses';
const String logInfoResetFail = 'Reset Password Gagal';
//*Log ID CASH Page*//
const String logInfoIdcashPage = 'Ramayana ID CASH Page';
const String logInfoIdcashSucc = 'Navigasi ke ID CASH';
const String logInfoIdcashBarcode = 'Barcode ID CASH';
const String logInfoIdcashHistory = 'Riwayat ID CASH';
const String logInfoIdcashFail = 'Reset Password Gagal';
//*Log Surat Jalan Page*//
const String logInfoScanSJPage = 'Ramayana Scan Surat Jalan Page';
const String logInfoScanSJSucc = 'Ramayana Scan Surat Berhasil';
const String logInfoScanDesc = 'Generate SJ No -';
const String logInfoScanSJFail = 'Ramayana Scan Surat Gagal';
const String logInfoTrackSJPage = 'Ramayana Track Surat Jalan Page';
const String logInfoTrackSJSucc = 'Ramayana Track Surat Berhasil';
const String logInfoTrackSJFail = 'Ramayana Track Surat Gagal';

//*Log Profile Page*//
const String logInfoProfilePage = 'Profile Page';
const String logInfoProfile = 'Logout Aplikasi RALS';
//*Log Cek Harga Page*//
const String logInfoCekHargaPage = 'Cek Harga Page';
const String logInfoCekHargaSucc = 'Cek Harga Sukses';
const String logInfoCekHargaFail = 'Cek Harga Fail';
//*Log Com Check Page*//
const String logInfoComCekApprPage = 'Competitor Checking - Approve Page';
const String logInfoComCekSucc = 'Com Cek Pengajuan';
const String logInfoComCekFail = 'Com Cek Fail';
//*Log Activity Page*//
const String logInfoActivityPage = 'My Activity Page';
const String logInfoActivityInputSucc = 'Input Activity Project - ';
const String logInfoActityEdit = 'My Activity - Edit My Activity Page';
const String logInfoActitySucc = 'My Activity - Edit My Activity';

//*Log Void Page*//
const String logInfoVoidPage = 'Void Page';
const String logInfoVoidSucc = 'Generate Void - ';
const String logInfoVoidOfflinePage = 'Void Offline Page';

//Popup Title or Description
const String pleaseCheck = "Mohon Cek Kembali";
const String usernameEmpty = "Username harus diisi";
const String passwordEmpty = "Password harus diisi";
const String usernameNotFound = "Username/Password tidak ditemukan";
const String usernameNotFoundDescription = "Username/Password tidak ditemukan";
const String usernameNotRegistered = "Username tidak terdaftar";
const String userCantAccessVoid = "User tidak memiliki akses void";
const String uniqeNumberAdmin = "Nomor unik admin salah. Harap coba lagi";
const String differentDevice =
    "Anda terdeteksi menggunakan device berbeda! Jika anda merasa tidak menggunakan device berbeda silahkan hubungi IT Helpdesk untuk dapat kembali login.";
const String pleaseCheckConnection = 'Please check your connection..';

//Login Offline//
const String logLoginOfflinePage = 'Login Offline Page';
const String logSucces = 'Login Offline Sukses';
const String logCantAccessVoid = 'Login Offline Gagal';
const String logDevice = 'Device tidak ditemukan.Pastikan Anda pernah login pada device ini';
const String logLoginCode = 'Anda terdeteksi menggunakan device berbeda/Login Code tidak sesuai';

//Popup SJ Title or Description
const String notFound = "Tidak ditemukan";
const String failed = "Gagal";
const String trackSJSuccess = 'Track Surat Jalan Sukses';
const String trackSJNavigate = 'Lihat Track SJ';
const String sjTrackTitle = 'Lacak Surat Jalan';
const String sjNoSuratJalan = 'No.Surat Jalan';
const String sjNoDokumen = 'No. Dokumen';
const String sjTipeDokumen = 'Tipe Dokumen';
const String sjAsal = 'Asal';
const String sjTujuan = 'Tujuan';
const String sjStatus = 'Status';
const String sjPetugas = 'Petugas';
const String sjNoMobil = 'No. Mobil';
const String sjLspb = 'LSPB';
const String sjKoliDiterima = 'Koli Diterima';
const String sjKoliHilang = 'Koli Hilang';
const String sjCatatan = 'Catatan';
//Popup Kartu Tambahan
const String companyCardTitle = 'Member Perusahaan';
const String cantempty = "Masukkan 6 digit kode POS";
const String notFoundTransaction = "Belum ada Transaksi";
const String cardNotFound = "Anda tidak mempunyai Kartu Perusahaan";
const String cardError = "Gagal mengambil data";
const String page = "Member Perusahaan Password";
const String cardSuccess = "Member Perusahaan Password Sukses";
const String cardFailed = "Member Perusahaan Password Gagal";
const String chooseCard = "Pilih Kartu";
const String trrCard = "Kartu TRR";
const String rmsCard = "Kartu RMS";
const String ifsCard = "Kartu IFS";
const String rmsCardPage = "Halaman Kartu RMS";
const String trrCardPage = "Halaman Kartu TRR";
const String ifsCardPage = "Halaman Kartu IFS";
const String navigatePayment = "Navigasi Pembayaran";
const String navigateHistory = "Navigasi Riwayat Transaksi";
const String paymentTrrPage = "Halaman Pembayaran Kartu TRR";
const String paymentRmsPage = "Halaman Pembayaran Kartu RMS";
const String paymentIfsPage = "Halaman Pembayaran Kartu IFS";
const String posCode = "Generate Kode POS - ";

//Tipe Transaksi Payment
const String typeA = "Transaksi Apps";
const String typeP = "Transaksi Poin POS";
const String typeT = "Tukar Poin";
const String typeC = "Sistem CRON/POS";
const String typeS = "Saldo Awal";
const String typeB = "Koreksi/Bonus Poin";
const String typeJ = "Penyesuaian Poin";
const String typeV = "Pembayaran dengan Poin";

const String menuGroupPersonal = 'Personal';
const menuGroupTools = 'Tools';
const menuGroupReport = 'Report';
const menuAll = 'All Menu';

const String menuIdCash = 'ID\nCash';
const String menuTukarPoin = 'Tukar\nPoin';
const String menuKartuPerusahaan = 'Kartu\nPerusahaan';

const String menuSuratJalan = 'Surat\nJalan';
const String menuMyActivity = 'My\nActivity';
const String menuVoid = 'Void\n  ';
const String menuCekHarga = 'Cek\nHarga';
const String menuComCheck = 'Competitor\nChecking';
const String menuApprReturn = 'Approval\nReturn';

const String menuLaporanSo = 'Laporan\nStok Opname';
const String menuLaporanSales = 'Laporan\nPenjualan';
const String menuLaporanPooling = 'Laporan\nPooling';

const String menuKeyIdCash = 'masteridcash.idcash';
const String menuKeyVoid = 'mastervoid.void';
const String menuKeyApprovalReturn = 'approvalreturn.approvalreturn';
const String menuKeyCekPrice = 'cekprice.cekprice';
const String menuKeyTukarPoin = 'tukarpoin.tukarpoin';
const String menuKeyMyActivity = 'myactivity.activity';
const String menuKeySj = 'tms.suratjalan';
const String menuKeyCompanyCard = 'kartu.kartuperusahaan';
const String menuKeyApprovedComCheck = 'comchek.approvedcomchek';
const String menuKeyHistoryComCheck = 'comchek.historycomchek';
const String menuKeyHomepageNews = 'homepage.news';
const String menuKeyMyListTask = 'homepage.mylisttask';
