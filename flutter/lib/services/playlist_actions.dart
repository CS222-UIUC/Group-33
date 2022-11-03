import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'model/playlist.dart';
import 'services/spotify_api.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaylistActions {
  static Future<void> openInSpotify(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      CustomToast.showTextToast(
          text: 'Failed to open spotify link', toastType: ToastType.error);
    }
  }

  static Future<void> savePlaylist(String userId, Playlist playlist) async {
    await FirebaseDB().savePlaylist(userId: userId, playlist: playlist);
    CustomToast.showTextToast(
        text: 'Playlist added to "SAVED PLAYLISTS"',
        toastType: ToastType.success);
  }

  static Future<void> unsavePlaylist(String userId, String playlistId) async {
    await FirebaseDB().unsavePlaylist(userId: userId, playlistId: playlistId);
    CustomToast.showTextToast(
        text: 'Playlist removed from "SAVED PLAYLISTS"',
        toastType: ToastType.success);
  }

  static Future<void> shareAsLink(Playlist playlist) async {
    final isPublic = await SpotifyApi.getPlaylist(playlist.id)
        .then((playlist) => playlist.isPublic);
    if (isPublic) {
      final url = playlist.deepLinkUri;
      Share.share(url, subject: 'Open "${playlist.name}" in Storify');
    } else {
      OverlayModal.show(
          icon: Icon(
            Icons.warning,
            color: Colors.orange,
            size: 72.0,
          ),
          message:
          'You can only share a public playlist. Open spotify and make your playlist "Public"',
          actionText: 'OPEN SPOTIFY',
          onConfirm: () async {
            final url = playlist.externalUrl;
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              CustomToast.showTextToast(
                text: 'Failed to open spotify link',
                toastType: ToastType.error,
              );
            }
          });
    }
  }
}