import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:semaphoreci_flutter_demo/pages/camera.dart';
import 'package:semaphoreci_flutter_demo/util/app_styling_constants.dart';
import 'package:semaphoreci_flutter_demo/util/background_drawer.dart';
import 'package:semaphoreci_flutter_demo/util/color_constant.dart';
import 'package:semaphoreci_flutter_demo/util/size_util.dart';
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

    final alignTopRightColumn = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  width: getHorizontalSize(220),
                  margin: getMargin(right: 10),
                  child: Text(
                      'lbl_mood_spot'.tr,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtInterExtraBold7855.copyWith(
                          height: 1,
                      ),
                  ),
              ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: getHorizontalSize(232),
                  margin: getMargin(
                      left: 10,
                      top: 63,
                  ),
                  child: Text(
                      'msg_the_mood_detect'.tr,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtInterSemiBold20,
                  ),
              ),
          ),
        ],
    );

    final alignTopRight = Align(
        alignment: Alignment.topRight,
        child: Container(
            height: getVerticalSize(579),
            width: getHorizontalSize(395),
            margin: getMargin(left: 10, bottom: 10),
            child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Align(alignment: Alignment.centerLeft),
                  Align(
                      alignment:
                      Alignment.topRight,
                      child: Container(
                          width: getHorizontalSize(344),
                          margin: getMargin(
                              left: 10,
                              top: 37,
                              right: 9,
                              bottom: 37,
                          ),
                          child: alignTopRightColumn,
                      ),
                  ),
                ],
            ),
        ),
    );

    final alignBottomLeftColumn = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment:
              Alignment
                  .centerLeft,
              child: Container(
                  color: ColorConstant.clearColor,
                  width: getHorizontalSize(196),
                  margin: getMargin(right: 10),
                  child: Text(
                      'msg_let_s_get_start'.tr,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtInterExtraBold45,
                  ),
              ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: getPadding(left: 66, top: 119, right: 66),
                  child: Text(
                      'msg_login_with_spot'.tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtRobotoRomanMedium20,
                  ),
              ),
          ),
          Align(
              alignment:
              Alignment.centerRight,
              child: GestureDetector(
                  onTap: loginButton,
                  child: Container(
                      margin: getMargin(left: 10, top: 57),
                      padding: getPadding(
                          left: 30,
                          top: 21,
                          right: 33,
                          bottom: 16,
                      ),
                      decoration: AppDecoration.txtFillBlack900.copyWith(
                          borderRadius: BorderRadiusStyle.txtRoundedBorder30,
                      ),
                      child: Text(
                          'lbl_login'.tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtInterRegular24,
                      ),
                  ),
              ),
          ),
        ],
    );

    final alignBottomLeft = Align(
        alignment: Alignment.bottomLeft,
        child: Container(
            color: ColorConstant.clearColor,
            height: getVerticalSize(543),
            width: deviceSize.width,
            margin:
            getMargin(top: 20, bottom: 20),
            child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  const Align(alignment: Alignment.centerLeft),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: getPadding(
                              left: 14,
                              top: 83,
                              right: 14,
                              bottom: 83,
                          ),
                          child: alignBottomLeftColumn,
                      ),
                  ),
                ],
            ),
        ),
    );

    final mainContainer = SizedBox(
        height: getVerticalSize(887),
        width: deviceSize.width,
        child: Stack(
            alignment: Alignment.bottomLeft,
            children: [ alignTopRight, alignBottomLeft ],
        ),
    );

    final mainScaffold = Scaffold(
        backgroundColor: ColorConstant.clearColor,
        body: SizedBox(
            width: deviceSize.width,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: mainContainer,
                      )
                    ],
                ),
            ),
        ),
    );

    return SafeArea(
        child: CustomPaint(painter: BackgroundMoodSpot(),child: mainScaffold),
    );
  }

  Future<void> loginButton() async {
    if (await getAccessToken()) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => Camera(_logger),
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
      logMessage('Got a token: $authenticationToken');
      return true;
    } on PlatformException catch (e) {
      logMessage(e.code, message: e.message);
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      logMessage('not implemented');
      return Future.error('not implemented');
    }
  }

  void logMessage(String code, {String? message}) {
    final text = message ?? '';
    _logger.i('$code$text');
  }
}
