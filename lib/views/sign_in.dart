import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:welvaart/services/firebase_auth_service.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart' as buttons;
import 'sign_in_viewmodel.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(context.read),
      builder: (_, child) {
        return const Scaffold(
          body: SignInViewBody._(),
        );
      },
    );
  }
}

class SignInViewBody extends StatelessWidget {
  const SignInViewBody._({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final isLoading =
        context.select((SignInViewModel viewModel) => viewModel.isLoading);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: size.height * .3),
          Container(
            height: size.height * 0.2,
            child: CachedNetworkImage(
              fit: BoxFit.fitHeight,
              imageUrl: 'https://i.imgur.com/PcLJHqc.png',
              placeholder: (context, url) => Image.asset('su.png'),
            ),
          ),
          SizedBox(height: size.height * .01),
          Expanded(
            child:
                isLoading ? _loadingIndicator() : _signInButtons(context, size),
          ),
        ],
      ),
    );
  }

  Center _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column _signInButtons(BuildContext context, Size size) {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            context.read<SignInViewModel>().signInAnonymously();
          },
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.01,
            vertical: size.width * 0.01,
          ),
          color: Colors.green,
          child: Text(
            'Anoniem inloggen',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width * 0.01,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * .03),
        buttons.GoogleSignInButton(
          onPressed: () {
            context.read<FirebaseAuthService>().signInWithGoogle();
          },
          darkMode: true,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
