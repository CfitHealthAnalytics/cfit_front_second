class AppConstants {
  static const String APP_NAME = 'CFIT';
  static const int APP_VERSION = 1;
  static const int SLOT_IN_MINUTE = 30;
  static const int DIGITS_AFTER_POINT = 2;

  //static const String BASE_URL = 'http://localhost/teste/stackfood';
  //static const String BASE_URL = 'https://ecode.codephix.com';
  static const String BASE_URL = 'api.vivendocfit.com.br';

  static const String AUTHENTICATION = '/authentication/';

  static const String CATEGORY_URI = '/api/v1/categories';
  static const String BANNER_URI = '/api/v1/banners';
  static const String RESTAURANT_PRODUCT_URI = '/api/v1/products/latest';
  static const String POPULAR_PRODUCT_URI = '/api/v1/products/popular';
  static const String REVIEWED_PRODUCT_URI = '/api/v1/products/most-reviewed';
  static const String SEARCH_PRODUCT_URI = '/api/v1/products/details/';
  static const String SUB_CATEGORY_URI = '/api/v1/categories/childes/';
  static const String CATEGORY_PRODUCT_URI = '/api/v1/categories/products/';
  static const String CATEGORY_RESTAURANT_URI =
      '/api/v1/categories/restaurants/';
  static const String CONFIG_URI = '/api/v1/config';
  static const String TRACK_URI = '/api/v1/customer/order/track?order_id=';
  static const String MESSAGE_URI = '/api/v1/customer/message/get';
  static const String SEND_MESSAGE_URI = '/api/v1/customer/message/send';
  static const String FORGET_PASSWORD_URI = '/api/v1/auth/forgot-password';
  static const String VERIFY_TOKEN_URI = '/api/v1/auth/verify-token';
  static const String RESET_PASSWORD_URI = '/api/v1/auth/reset-password';
  static const String VERIFY_PHONE_URI = '/api/v1/auth/verify-phone';
  static const String CHECK_EMAIL_URI = '/api/v1/auth/check-email';
  static const String VERIFY_EMAIL_URI = '/api/v1/auth/verify-email';


  static const String GET_IGP_BY_DATE_URI = '/get_bioimpedance_by_date';
  static const String GET_BIO_INFO = '/user_bioimpedance';

  static const String REGISTER_URI = '/register_user/';
  static const String LOGIN_URI = '/authentication/';
  static const String GET_USER = '/get_user_info/';
  static const String GET_USERS_ADMIN = '/get_users_admin';
  static const String REFRESH_TOKEN = '/refreshtoken/';
  static const String RECOVER_PASSWORD = '/send_reset_password_email/';

  static const String CHECKOUT_CITY_EVENTS = '/checkout_city_events/';
  static const String CHECKIN_CITY_EVENTS = '/checkin_city_events/';

  static const String CHECKOUT_PUBLIC_EVENTS = '/checkout_public_events/';
  static const String CHECKIN_PUBLIC_EVENTS = '/checkin_public_events/';

  static String CONFIRMATION_PUBLIC_EVENTS(String eventId) =>
      '/public_events/$eventId/comfirmation';

  static String DECLINE_PUBLIC_EVENTS(String eventId) =>
      '/public_events/$eventId/reject_user';

  static const String REGISTER_EVENT = '/create_public_events/';
  static const String EDIT_EVENT = '/update_public_events';
  static const String GET_EVENT = '/get_public_event_by_id';
  static const String DELETE_EVENT = '/delete_public_events';

  static const String REGISTER_EVENT2 =
      '/create_city_events_collection_in_district/';

  /// City Events

  static const String GET_HALL_EVENTS = '/city_hall_events';
  static const String CONFIRMATION_HALL_EVENTS = '/comfirmation_in_events/';
  static const String GET_CITY_EVENTS = '/get_city_events/';
  static const String GET_PUBLIC_EVENTS = '/get_public_events/';
  static const String GET_MODALIDADES_EVENTS = '/modalidades';
  static const String GET_MY_CITY_EVENTS = '/get_city_events/my_city_events';
  static const String GET_MY_PUBLIC_EVENTS =
      '/get_public_events/my_public_events';
  static const String GET_MY_EVENTS = '/get_my_created_events';

  static const String TOKEN_URI = '/api/v1/customer/cm-firebase-token';
  static const String PLACE_ORDER_URI = '/api/v1/customer/order/place';
  static const String ADDRESS_LIST_URI = '/api/v1/customer/address/list';
  static const String ZONE_URI = '/api/v1/config/get-zone-id';
  static const String REMOVE_ADDRESS_URI =
      '/api/v1/customer/address/delete?address_id=';
  static const String ADD_ADDRESS_URI = '/api/v1/customer/address/add';
  static const String UPDATE_ADDRESS_URI = '/api/v1/customer/address/update/';
  static const String SET_MENU_URI = '/api/v1/products/set-menu';
  static const String CUSTOMER_INFO_URI = '/api/v1/customer/info';
  static const String COUPON_URI = '/api/v1/coupon/list';
  static const String COUPON_APPLY_URI = '/api/v1/coupon/apply?code=';
  static const String RUNNING_ORDER_LIST_URI =
      '/api/v1/customer/order/running-orders';
  static const String HISTORY_ORDER_LIST_URI = '/api/v1/customer/order/list';
  static const String ORDER_CANCEL_URI = '/api/v1/customer/order/cancel';
  static const String COD_SWITCH_URL = '/api/v1/customer/order/payment-method';
  static const String ORDER_DETAILS_URI =
      '/api/v1/customer/order/details?order_id=';
  static const String WISH_LIST_GET_URI = '/api/v1/customer/wish-list';
  static const String ADD_WISH_LIST_URI = '/api/v1/customer/wish-list/add?';
  static const String REMOVE_WISH_LIST_URI =
      '/api/v1/customer/wish-list/remove?';
  static const String NOTIFICATION_URI = '/api/v1/customer/notifications';
  static const String UPDATE_PROFILE_URI = '/api/v1/customer/update-profile';
  static const String SEARCH_URI = '/api/v1/';
  static const String REVIEW_URI = '/api/v1/products/reviews/submit';
  static const String PRODUCT_DETAILS_URI = '/api/v1/products/details/';
  static const String LAST_LOCATION_URI =
      '/api/v1/delivery-man/last-location?order_id=';
  static const String DELIVER_MAN_REVIEW_URI =
      '/api/v1/delivery-man/reviews/submit';
  static const String RESTAURANT_URI = '/api/v1/restaurants/get-restaurants';
  static const String POPULAR_RESTAURANT_URI = '/api/v1/restaurants/popular';
  static const String LATEST_RESTAURANT_URI = '/api/v1/restaurants/latest';
  static const String RESTAURANT_DETAILS_URI = '/api/v1/restaurants/details/';
  static const String BASIC_CAMPAIGN_URI = '/api/v1/campaigns/basic';
  static const String ITEM_CAMPAIGN_URI = '/api/v1/campaigns/item';
  static const String BASIC_CAMPAIGN_DETAILS_URI =
      '/api/v1/campaigns/basic-campaign-details?basic_campaign_id=';
  static const String INTEREST_URI = '/api/v1/customer/update-interest';
  static const String SUGGESTED_FOOD_URI = '/api/v1/customer/suggested-foods';
  static const String RESTAURANT_REVIEW_URI = '/api/v1/restaurants/reviews';
  static const String DISTANCE_MATRIX_URI = '/api/v1/config/distance-api';
  static const String SEARCH_LOCATION_URI =
      '/api/v1/config/place-api-autocomplete';
  static const String PLACE_DETAILS_URI = '/api/v1/config/place-api-details';
  static const String GEOCODE_URI = '/api/v1/config/geocode-api';
  static const String SOCIAL_LOGIN_URL = '/api/v1/auth/social-login';
  static const String SOCIAL_REGISTER_URL = '/api/v1/auth/social-register';

  static const String UPDATE_ZONE_URL = '/api/v1/customer/update-zone';

  // Shared Key
  static const String THEME = 'theme';

  static const String TOKEN = 'cfit_token';
  static const String TOKEN_REFRESH = 'cfit_refreshToken';
  static const String TOKEN_EXPIRESIN = 'cfit_expiresIn';

  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';

  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_EMAIL = 'user_email';
  static const String USER_COUNTRY_CODE = 'user_country_code';
  static const String USER_DATE_BIRTH = 'user_date_birth';
  static const String USER_GENDER = 'user_gender';
  static const String USER_NAME = 'user_name';
  static const String USER_ID = 'user_id';

  static const String NOTIFICATION = 'notification';
  static const String SEARCH_HISTORY = 'search_history';
  static const String INTRO = 'intro';
  static const String NOTIFICATION_COUNT = 'notification_count';
  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';
  static const String LOCALIZATION_KEY = 'X-localization';

  static const String USER_NUMBER = 'cfit_user_number';
}
