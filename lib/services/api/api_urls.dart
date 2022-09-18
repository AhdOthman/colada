class ApiUrls {
  static const String baseUrl =
      'http://ec2-13-232-184-163.ap-south-1.compute.amazonaws.com:8080';

  // auth
  static const createOtp = baseUrl + '/users/createOTP';
  static const verifyOTP = baseUrl + '/users/verifyOTP';
  static const signUp = baseUrl + '/users/signUp';

  //user
  static const createUser = baseUrl + '/users';
  static const getUser = baseUrl + '/users/user';
  static const getGenerateReferralCode =
      baseUrl + '/users/generateReferralCode';
  static const uploadUserPhoto = baseUrl + '/uploads/uploadUserPhoto';
  static const frequentAskedQuestion = baseUrl + '/frequentAskedQuestion';

  //stores
  static const getStores = baseUrl + '/stores/getStores';
  static const getFilters = baseUrl + '/stores/filterStores';
  static const getsearchStores = baseUrl + '/stores/searchStores';

  //visits
  static const getCurrentVisits = baseUrl + '/visits/currentVisits';
  static const getUserVisits = baseUrl + '/visits/getUserVisits';
  static const getCreateUserVisits = baseUrl + '/visits/createVisit';
  static const getCreateVisitReview = baseUrl + '/visits/createVisitReview';
  static const getCheckoutDetails = baseUrl + '/visits/checkoutDetails';

  //offers
  static const getOffers = baseUrl + '/offers/getStoreOffers';
  static const getActiveOffers = baseUrl + '/offers/allActiveOffers';
  static const getOffersDetails = baseUrl + '/offers/getOfferDetails';

  // Favorite
  static const getFavoriteStores = baseUrl + '/favorites/getFavoriteStores';
  static const addFavoriteStores = baseUrl + '/favorites/addFavoriteStore';
  static const removeFavoriteStores =
      baseUrl + '/favorites/removeFavoriteStore';

  // Transaction
  static const getUserTransactions =
      baseUrl + '/transactions/getUserTransactions';

  // Notification
  static const getUserNotification =
      baseUrl + '/notifications/getUserNotification';

  // QR Code
  static const getValidateQR = baseUrl + '/qr/validateQR';
  static const getCheckInQR = baseUrl + '/qr/checkin';
  static const generateVisitQR = baseUrl + '/qr/generateVisitQR';
}
