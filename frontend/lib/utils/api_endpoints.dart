const String backendUrl = 'http://localhost:5001';
const String registerEndpoint = '$backendUrl/auth/register';
const String loginEndpoint = '$backendUrl/auth/login';
const String logoutEndpoint = '$backendUrl/auth/logout';
const String meEndpoint = '$backendUrl/auth/me';

const String addToWatchlistEndpoint = '$backendUrl/watchlist';

String deleteFromWatchlistEndpoint(String id) => '$backendUrl/watchlist/$id';
String updateWatchlistEndpoint(String id) => '$backendUrl/watchlist/$id';
