import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:semaphoreci_flutter_demo/pages/camera.dart';
import 'package:semaphoreci_flutter_demo/pages/player.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Logger _logger = Logger(
    //filter: CustomLogFilter(), // custom logfilter can be used to have logs in release mode
    printer: PrettyPrinter(
      printTime: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: const ValueKey('Home App'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MoodSpot'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  key: const ValueKey('button.login'),
                  width: 0.8 * MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: loginButton,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      elevation: MaterialStateProperty.all(5),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Login to Spotify',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                          ),
                        ),
                        const Expanded(
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 23,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> loginButton() async {
    if (await getAccessToken()) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const Camera(),
        ),
      );
    }
  }

  Future<bool> getAccessToken() async {
    try {
      final authenticationToken = await SpotifySdk.getAccessToken(
        clientId: dotenv.env['CLIENT_ID'].toString(),
        redirectUrl: dotenv.env['REDIRECT_URL'].toString(),
        scope: 'app-remote-control, '
            'user-modify-playback-state, '
            'playlist-read-private, '
            'playlist-modify-public,user-read-currently-playing',
      );
      setStatus('Got a token: $authenticationToken');
      return true;
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      setStatus('not implemented');
      return Future.error('not implemented');
    }
  }

  void setStatus(String code, {String? message}) {
    final text = message ?? '';
    _logger.i('$code$text');
  }
}
