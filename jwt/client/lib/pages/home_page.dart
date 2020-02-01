import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/auth_utils.dart';
import '../utils/network_utils.dart';

class HomePage extends StatefulWidget {
	static final String routeName = 'home';

	@override
	State<StatefulWidget> createState() {
		return new _HomePageState();
	}

}

class _HomePageState extends State<HomePage> {
	GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
	Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

	SharedPreferences _sharedPreferences;
	var _authToken, _id, _name, _homeResponse;

	@override
	void initState() {
		super.initState();
		_fetchSessionAndNavigate();
	}

	_fetchSessionAndNavigate() async {
		_sharedPreferences = await _prefs;
		String authToken = AuthUtils.getToken(_sharedPreferences);
		var id = _sharedPreferences.getString(AuthUtils.userIdKey);
		var name = _sharedPreferences.getString(AuthUtils.nameKey);

		print(authToken);

		_fetchHome(authToken);

		setState(() {
			_authToken = authToken;
			_id = id;
			_name = name;
		});

		if(_authToken == null) {
			_logout();
		}
	}

	_fetchHome(String authToken) async {
		var responseJson = await NetworkUtils.fetch(authToken, '/api/v1/home');

		if(responseJson == null) {

			NetworkUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');

		} else if(responseJson == 'NetworkError') {

			NetworkUtils.showSnackBar(_scaffoldKey, null);

		} else if(responseJson['errors'] != null) {

			_logout();

		}

		setState(() {
		  _homeResponse = responseJson.toString();
		});
	}

	_logout() {
		NetworkUtils.logoutUser(_scaffoldKey.currentContext, _sharedPreferences);
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			key: _scaffoldKey,
			appBar: new AppBar(
				title: new Text('Home'),
			),
			body: new Container(
				margin: const EdgeInsets.symmetric(horizontal: 16.0),
				child: new Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: <Widget>[
						new Container(
							padding: const EdgeInsets.all(8.0),
							child: new Text(
								"USER_ID: $_id \nUSER_NAME: $_name \nHOME_RESPONSE: $_homeResponse",
								style: new TextStyle(
									fontSize: 24.0,
									color: Colors.grey.shade700
								),
							),
						),
						new MaterialButton(
							color: Theme.of(context).primaryColor,
							child: new Text(
								'Logout',
								style: new TextStyle(
									color: Colors.white
								),
							),
							onPressed: _logout
						),
					]
				),
			)
		);
	}

}
