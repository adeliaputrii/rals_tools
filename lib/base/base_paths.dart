const String base_url_dev = "http://172.16.126.221:8002/";
// const String base_url_dev = "https://dev-android-api.ramayana.co.id:8305/";
const String base_url_prod = "https://android-api.ramayana.co.id:8304/";
const String base_url_dev_tms = "https://dev-ris.ramayana.co.id/";
const String base_url_prod_tms = "https://ris.ramayana.co.id/";

const String contentType = 'application/json';
const String accept = 'application/json';

const String api_login = "api/v1/auth/signin";
const String api_logout = "api/v1/auth/logout";
const String api_reset_pass = 'api/v1/auth/reset.password';
// const String api_my_log = 'api/v1/activity/createmylog';

//Membercard
const String api_membercard_customer = "api/v1/membercards/tbl_customer";

//Activity
const String api_get_task_user = 'api/v1/activity/task/get-task';
const String api_activity_list_project = 'api/v1/activity/list-project';
const String api_activity_task_by_id = 'api/v1/activity/list-task?project_id=';
const String api_activity_create_daily = 'api/v1/activity/create_daily_activity';
const String api_activity_clock_daily = 'api/v1/activity/clock_daily_activity';
const String api_activity_update = 'api/v1/activity/updateDailyActivity';
const String api_count_task = 'api/v1/activity/task/count-unread/';

//SuratJalan
const String api_tracking_scan = 'api/v1/tracking/scan-sj-tracking?no_sj=';
const String api_tracking_update_storeline = 'api/v1/tracking/update-tracking/storeline';
const String api_tracking_update_supplier = 'api/v1/tracking/update-tracking/supplier';
const String api_tracking_update_tracking = 'api/v1/tracking/update-tracking';
const String api_tracking_sj = 'api/v1/tracking/track-sj?no_sj=';

const String api_comcheck_approve = 'activity/updateApproveCommcheck';

//CompanyCard
const String api_get_company_card = 'api/v1/companycard/tbl_companyCard';
const String api_get_company_card_detail = 'api/v1/companycard/detail_companyCard';
const String api_get_company_card_history = 'api/v1/companycard/history_companyCard';
const String api_get_company_card_history_year = 'api/v1/companycard/history_companyCardYY';
const String api_get_company_card_history_month = 'api/v1/companycard/history_companyCardMM';
const String api_get_company_card_history_day = 'api/v1/companycard/history_companyCardDD';

//News
const String api_get_news_list = 'api/v1/news/get-active-news';

//Report
const String api_report_list = 'api/v1/report/get';
const String api_report_list_pagination = 'api/v1/report/get?cursor=';
const String api_report_insert_viewer = 'api/v1/report/insert_viewer';
const String api_report_get_viewer = 'api/v1/report/get_viewer';
