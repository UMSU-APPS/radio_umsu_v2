import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_umsu/common/api/music_api.dart';
import 'package:radio_umsu/pages/music/bloc/music_bloc.dart';

class MusicController {
  static final MusicController _instance = MusicController._internal();
  factory MusicController() => _instance;
  MusicController._internal();

  late BuildContext context;

  final AudioPlayer _audioPlayer = AudioPlayer();

  void init(BuildContext context) {
    this.context = context;
    _loadRadioConfig();

    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      if (context.mounted) {
        context.read<MusicBloc>().add(MusicPlayerStatusChanged(isPlaying));
      }

      if (processingState == ProcessingState.completed) {
        _audioPlayer.stop();
      }
    });

    FlutterVolumeController.updateShowSystemUI(true);
  }

  Future<void> _loadRadioConfig() async {
    context.read<MusicBloc>().add(TriggerLoadingEvent());

    try {
      var response = await MusicApi.getRadioConfig();

      if (response.statusCode == 200 && response.data != null) {
        if (context.mounted) {
          context.read<MusicBloc>().add(MusicDataLoadedEvent(response.data!));
        }
      } else {
        if (context.mounted) {
          context.read<MusicBloc>().add(
            MusicErrorEvent(response.message ?? "Gagal mengambil data config"),
          );
        }
      }
    } catch (e) {
      print("Error Controller: $e");
      if (context.mounted) {
        context.read<MusicBloc>().add(
          MusicErrorEvent("Terjadi kesalahan koneksi"),
        );
      }
    }
  }

  void retryLoad() {
    _loadRadioConfig();
  }

  // Fungsi Play/Stop Radio
  Future<void> playRadio(String? url) async {
    if (url == null) return;

    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.stop();
      } else {
        print("Mencoba memutar: $url");

        // --- UBAH BAGIAN INI ---
        // Tambahkan headers agar dianggap sebagai browser
        await _audioPlayer.setUrl(
          url,
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            // Opsional: Kadang perlu Icy-MetaData
            'Icy-MetaData': '1',
          },
        );
        // -----------------------

        await _audioPlayer.play();
      }
    } catch (e) {
      print("Error memutar audio: $e");

      // Kirim error ke Bloc agar user tahu (Opsional tapi bagus)
      if (context.mounted) {
        // Pastikan kamu punya import MusicErrorEvent
        context.read<MusicBloc>().add(
          MusicErrorEvent("Gagal memutar radio: $e"),
        );
      }
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  Future<void> adjustVolume(double step) async {
    // Ambil volume HP saat ini (nilainya 0.0 sampai 1.0)
    double? currentVol = await FlutterVolumeController.getVolume();
    currentVol ??= 0.5; // Default jika null

    double newVol = currentVol + step;

    // Batasi agar tidak lebih dari 100% atau kurang dari 0%
    if (newVol > 1.0) newVol = 1.0;
    if (newVol < 0.0) newVol = 0.0;

    // Set Volume HP Langsung
    await FlutterVolumeController.setVolume(newVol);

    print("System Volume diatur ke: ${(newVol * 100).toInt()}%");
  }
}
