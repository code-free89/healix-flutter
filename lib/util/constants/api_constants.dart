int TIME_OUT_SECONDS = 60;
int HEALTH_DATA_SYNC_INTERVAL = 60;
int SECONDS_IN_A_MIN = 60;
int MILLIS_IN_SEC = 1000;

const String googleMapsAPIkey = "AIzaSyBdRPuueSVnNx8rHl0IEmppFePEmQc5ml4";

/// api routes
const String BASEURL =
    'https://us-central1-smarte-cloudservice-846b2.cloudfunctions.net';
final String putHealthDataApiUrl = '$BASEURL/save_health_data';
final String getHealthDataApiUrl = '$BASEURL/get_health_data';
final String getCustomizedUrl = '$BASEURL/get_customized_response';
final String getQuoteData = '$BASEURL/get_final_quote';
final String addUserData = '$BASEURL/add_user_profile';
final String getUserData = '$BASEURL/get_user_profile';
final String addUserLocationData = '$BASEURL/save_location';
final String saveFcmTokenUrl = '$BASEURL/save_fcm_token';
final String setNotificationResponseUrl = '$BASEURL/save_user_feedback';
final String getNotificationContentUrl = '$BASEURL/get_notification_content';
final String addBillingDataUrl = '$BASEURL/save_payment_info';
