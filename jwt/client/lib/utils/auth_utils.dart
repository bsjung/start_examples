import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {

	static final String endPoint = '/api/v1/auth';

	// Keys to store and fetch data from SharedPreferences
	static final String authTokenKey = 'token';
	static final String userIdKey = 'id';
	static final String nameKey = 'name';
	static final String roleKey = 'role';

	static String getToken(SharedPreferences prefs) {
		return prefs.getString(authTokenKey);
	}

	static insertDetails(SharedPreferences prefs, var response) {
		prefs.setString(authTokenKey, response['token']);
		prefs.setString(userIdKey, response['id']);
		prefs.setString(nameKey, response['name']);
	}
	
}
