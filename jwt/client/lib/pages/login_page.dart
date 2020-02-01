import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home_page.dart';
import '../utils/auth_utils.dart';
import '../utils/network_utils.dart';
import '../validators/email_validator.dart';
import '../components/error_box.dart';
import '../components/email_field.dart';
import '../components/password_field.dart';
import '../components/login_button.dart';

class LoginPage extends StatefulWidget {

	@override
	LoginPageState createState() => new LoginPageState();

}

class LoginPageState extends State<LoginPage> {
	final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
	Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
	SharedPreferences _sharedPreferences;
	bool _isError = false;
	bool _obscureText = true;
	bool _isLoading = false;
	TextEditingController _emailController, _passwordController;
	String _errorText, _emailError, _passwordError;

	@override
	void initState() {
		super.initState();
		_fetchSessionAndNavigate();
		_emailController = new TextEditingController();
		_passwordController = new TextEditingController();
	}

	_fetchSessionAndNavigate() async {
		_sharedPreferences = await _prefs;
		String authToken = AuthUtils.getToken(_sharedPreferences);
		if(authToken != null) {
			Navigator.of(_scaffoldKey.currentContext)
				.pushReplacementNamed(HomePage.routeName);
		}
	}

	_showLoading() {
		setState(() {
		  _isLoading = true;
		});
	}

	_hideLoading() {
		setState(() {
		  _isLoading = false;
		});
	}

	_authenticateUser() async {
		_showLoading();
		//if(_valid()) {
		if(true) {
			var responseJson = await NetworkUtils.authenticateUser(
				_emailController.text, _passwordController.text
			);

			print(responseJson);

			if(responseJson == null) {

				NetworkUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');
			} else if(responseJson == '{}') {

				NetworkUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');
			} else if(responseJson == 'NetworkError') {

				NetworkUtils.showSnackBar(_scaffoldKey, null);

			} else if(responseJson['errors'] != null) {

				NetworkUtils.showSnackBar(_scaffoldKey, 'Invalid Email/Password');

			} else {

				AuthUtils.insertDetails(_sharedPreferences, responseJson);
				/**
				 * Removes stack and start with the new page.
				 * In this case on press back on HomePage app will exit.
				 * **/
				Navigator.of(_scaffoldKey.currentContext)
					.pushReplacementNamed(HomePage.routeName);

			}
			_hideLoading();
		} else {
			setState(() {
				_isLoading = false;
				_emailError;
				_passwordError;
			});
		}
	}

	_valid() {
		bool valid = true;

		if(_emailController.text.isEmpty) {
			valid = false;
			_emailError = "Email can't be blank!";
		} else if(!_emailController.text.contains(EmailValidator.regex)) {
			valid = false;
			_emailError = "Enter valid email!";
		}

		if(_passwordController.text.isEmpty) {
			valid = false;
			_passwordError = "Password can't be blank!";
		} else if(_passwordController.text.length < 6) {
			valid = false;
			_passwordError = "Password is invalid!";
		}

		return valid;
	}

	Widget _loginScreen() {
		return new Container(
			child: new ListView(
				padding: const EdgeInsets.only(
					top: 100.0,
					left: 16.0,
					right: 16.0
				),
				children: <Widget>[
					new ErrorBox(
						isError: _isError,
						errorText: _errorText
					),
					new EmailField(
						emailController: _emailController,
						emailError: _emailError
					),
					new PasswordField(
						passwordController: _passwordController,
						obscureText: _obscureText,
						passwordError: _passwordError,
						togglePassword: _togglePassword,
					),
					new LoginButton(onPressed: _authenticateUser)
				],
			),
		);
	}

	_togglePassword() {
		setState(() {
			_obscureText = !_obscureText;
		});
	}

	Widget _loadingScreen() {
		return new Container(
			margin: const EdgeInsets.only(top: 100.0),
			child: new Center(
				child: new Column(
					children: <Widget>[
						new CircularProgressIndicator(
							strokeWidth: 4.0
						),
						new Container(
							padding: const EdgeInsets.all(8.0),
							child: new Text(
								'Please Wait',
								style: new TextStyle(
									color: Colors.grey.shade500,
									fontSize: 16.0
								),
							),
						)
					],
				)
			)
		);
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			key: _scaffoldKey,
			body: _isLoading ? _loadingScreen() : _loginScreen()
		);
	}

}
