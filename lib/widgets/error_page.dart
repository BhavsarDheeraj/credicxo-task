import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  ErrorPage({@required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Image.asset(
          'assets/images/no-internet.png',
          height: 100,
          width: 100,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subhead,
        ),
        (onRetry != null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide: BorderSide(color: Colors.yellow, width: 2),
                      focusColor: Colors.yellow,
                      highlightedBorderColor: Colors.yellow,
                      child: Text(
                        'RETRY',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      onPressed: onRetry,
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
