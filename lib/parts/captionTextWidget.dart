import 'package:flutter/material.dart';
import 'package:app_a/parts/captionImageWidget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class CaptionTextWidget extends ConsumerWidget {
  const CaptionTextWidget({super.key});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isRequesting = watch(isRequestingProvider);
    final caption = watch(captionProvider);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: GestureDetector(
        onTap: () => {
          isRequesting.state = true
        },
        child: SizedBox(
            child: caption.state.isNotEmpty ? Text("hello") : const Text("")
        ),
      )
    );
  }
}

