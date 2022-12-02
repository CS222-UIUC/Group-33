import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miniplayer/miniplayer.dart';

import 'package:semaphoreci_flutter_demo/util/audio_object.dart';
import 'package:semaphoreci_flutter_demo/model/data_models/my_playlist_info.dart';
import 'package:semaphoreci_flutter_demo/model/data_models/my_track.dart';
import 'package:semaphoreci_flutter_demo/models/crossfade_state.dart';
import 'package:semaphoreci_flutter_demo/models/image_uri.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

final ValueNotifier<double> playerExpandProgress =
    ValueNotifier(playerMinHeight);

final MiniplayerController controller = MiniplayerController();

const double playerMinHeight = 70;
const double playerMaxHeight = 370;
const miniplayerPercentageDeclaration = 0.2;

class DetailedPlayer extends StatelessWidget {
  final AudioObject audioObject;
  final MyPlaylistInfo myPlaylistInfo;
  DetailedPlayer(
      {Key? key, required this.myPlaylistInfo, required this.audioObject})
      : super(key: key);
  CrossfadeState? crossfadeState;
  late ImageUri? currentTrackImageUri;

  Future<void> play() async {
    try {
      await SpotifySdk.play(spotifyUri: myPlaylistInfo.tracks.first.trackUri);
    } on PlatformException catch (e) {
      // setStatus(e.code, message: e.message);
    } on MissingPluginException {
      // setStatus('not implemented');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
      valueNotifier: playerExpandProgress,
      minHeight: 70,
      maxHeight: 370,
      controller: controller,
      elevation: 4,
      onDismissed: () {},
      builder: (height, percentage) {
        final miniplayer = percentage < miniplayerPercentageDeclaration;
        final width = MediaQuery.of(context).size.width;
        final maxImgSize = width * 0.4;

        final img = Image.asset('img/sample_album_img.png');
        const text = Text('Song Name');
        const buttonPlay = IconButton(
          icon: Icon(Icons.pause),
          onPressed: onTap,
        );
        const progressIndicator = LinearProgressIndicator(value: 0.3);

        //Declare additional widgets (eg. SkipButton) and variables
        if (!miniplayer) {
          var percentageExpandedPlayer = percentageFromValueInRange(
            min: playerMaxHeight * miniplayerPercentageDeclaration +
                playerMinHeight,
            max: playerMaxHeight,
            value: height,
          );
          if (percentageExpandedPlayer < 0) percentageExpandedPlayer = 0;
          final paddingVertical = valueFromPercentageInRange(
            min: 0,
            max: 10,
            percentage: percentageExpandedPlayer,
          );
          final heightWithoutPadding = height - paddingVertical * 2;
          final imageSize = heightWithoutPadding > maxImgSize
              ? maxImgSize
              : heightWithoutPadding;
          final paddingLeft = valueFromPercentageInRange(
                min: 0,
                max: width - imageSize,
                percentage: percentageExpandedPlayer,
              ) /
              2;

          const buttonSkipForward = IconButton(
            icon: Icon(Icons.forward_30),
            iconSize: 33,
            onPressed: onTap,
          );
          const buttonSkipBackwards = IconButton(
            icon: Icon(Icons.replay_10),
            iconSize: 33,
            onPressed: onTap,
          );
          const buttonPlayExpanded = IconButton(
            icon: Icon(Icons.pause_circle_filled),
            iconSize: 50,
            onPressed: onTap,
          );

          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: paddingLeft,
                    top: paddingVertical,
                    bottom: paddingVertical,
                  ),
                  child: SizedBox(
                    height: imageSize,
                    child: img,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33),
                  child: Opacity(
                    opacity: percentageExpandedPlayer,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Flexible(child: text),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              buttonSkipBackwards,
                              buttonPlayExpanded,
                              buttonSkipForward
                            ],
                          ),
                        ),
                        const Flexible(child: progressIndicator),
                        Container(),
                        Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        //Miniplayer
        final percentageMiniplayer = percentageFromValueInRange(
          min: playerMinHeight,
          max: playerMaxHeight * miniplayerPercentageDeclaration +
              playerMinHeight,
          value: height,
        );
        final elementOpacity = 1 - 1 * percentageMiniplayer;
        final progressIndicatorHeight = 4 - 4 * percentageMiniplayer;

        return Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: maxImgSize),
                    child: img,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Opacity(
                        opacity: elementOpacity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              audioObject.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 16),
                            ),
                            Text(
                              audioObject.subtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color!
                                        .withOpacity(0.55),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.fullscreen),
                    onPressed: () {
                      controller.animateToHeight(state: PanelState.MAX);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Opacity(
                      opacity: elementOpacity,
                      child: buttonPlay,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: progressIndicatorHeight,
              child: Opacity(
                opacity: elementOpacity,
                child: progressIndicator,
              ),
            ),
          ],
        );
      },
    );
  }
}

void onTap() {}
