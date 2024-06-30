import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';
bool haveOverlay = false;

class LockOverlay {
  static LockOverlay? _instance;
  final ValueNotifier<OverlayEntry?> _overlayEntry = ValueNotifier(null);

  LockOverlay._internal() {
    _instance = this;
  }

  factory LockOverlay() => _instance ?? LockOverlay._internal();

  void showLoadingOverlay(context,{bool buildAfterRebuild= false,bool showLoderOnly= false}) {
    if (haveOverlay) return;
    if (buildAfterRebuild) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showLoadingOverlay(context);
      });
      return;
    }
    if(context==null){
      return;
    }
    OverlayState? overlayState =Overlay.of(context);

    final _myoverlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        if(showLoderOnly){
          return  Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  ),
                ),
              ),
            ],
          );
        }
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.white,
              child: const Icon(Icons.downloading, color: AppColors.appMainColor,),
            ),
          ],
        );
      },
    );
    _overlayEntry.value = _myoverlayEntry;

    overlayState.insert(_overlayEntry.value!);
    haveOverlay = true;
  }

  closeOverlay() {
    if (_overlayEntry.value == null) return;
    haveOverlay = false;
    _overlayEntry.value!.remove();
    _overlayEntry.value = null;
  }
}
