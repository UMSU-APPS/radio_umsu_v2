import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:radio_umsu/common/values/colors.dart';
import 'package:radio_umsu/pages/music/bloc/music_bloc.dart';
import 'package:radio_umsu/pages/music/music_controller.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  // Mengambil instance singleton controller
  final MusicController _controller = MusicController();
  double currentSliderValue = 10;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller (Load data & Setup Audio Listener)
    _controller.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: BlocBuilder<MusicBloc, MusicState>(
          builder: (context, state) {
            // 1. TAMPILAN LOADING
            if (state.status == MusicStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            // 2. TAMPILAN ERROR
            if (state.status == MusicStatus.failure ||
                state.currentRadio == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Error: ${state.errorMessage}",
                      style: TextStyle(color: AppColors.gray500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _controller.retryLoad(),
                      child: const Text("Coba Lagi"),
                    ),
                  ],
                ),
              );
            }

            // 3. TAMPILAN PLAYER (DATA ADA)
            final radio = state.currentRadio!;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // --- HEADER ---
                  Center(
                    child: Text(
                      "Radio UMSU",
                      style: TextStyle(
                        color: AppColors.gray500,
                        fontSize: 16,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // --- ARTWORK DENGAN LOTTIE & GAMBAR TENGAH ---
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.black,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.5),
                          blurRadius: 20,
                          offset: const Offset(5, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 280,
                            height: 280,
                            child: Lottie.asset(
                              'assets/animations/radio2.json',
                              fit: BoxFit.cover,
                              animate: state.isPlaying,
                            ),
                          ),
                        ),

                        Container(
                          width: 65.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              color: AppColors.white.withValues(alpha: 0.2),
                              width: 2,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(radio.artwork ?? ""),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- TITLE & ARTIST ---
                  Column(
                    children: [
                      Text(
                        radio.title ?? "-",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        radio.artist ?? "-",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.gray500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // --- SLIDER (Static / Full / Locked) ---
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      disabledActiveTrackColor: AppColors.primary,
                      disabledInactiveTrackColor: AppColors.gray900,
                      disabledThumbColor: AppColors.white,
                      trackHeight: 4.0,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6.0,
                      ),
                    ),
                    child: Slider(
                      value: 100,
                      min: 0,
                      max: 100,
                      onChanged: null,
                    ),
                  ),

                  // Label Live
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LIVE",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "STREAM",
                          style: TextStyle(color: AppColors.gray500),
                        ),
                      ],
                    ),
                  ),

                  // --- CONTROLS ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildControlIcon(
                        MdiIcons.volumeMinus,
                        onTap: () {
                          _controller.adjustVolume(-0.1);
                        },
                      ),

                      // TOMBOL PLAY / PAUSE
                      GestureDetector(
                        onTap: () {
                          // Panggil fungsi playRadio di controller
                          _controller.playRadio(radio.url);
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [AppColors.primary, AppColors.primary],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            // LOGIC ICON BERUBAH DISINI
                            state.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),

                      _buildControlIcon(
                        MdiIcons.volumePlus,
                        onTap: () {
                          // Tambah volume sebesar 10% (0.1)
                          _controller.adjustVolume(0.1);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildControlIcon(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.gray900,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}
