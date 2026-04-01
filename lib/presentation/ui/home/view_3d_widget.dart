import 'package:flutter/material.dart';
import 'package:babylonjs_viewer/babylonjs_viewer.dart';

class View3dWidget extends StatefulWidget {
  final String modelSource;

  const View3dWidget({super.key, required this.modelSource});

  @override
  State<View3dWidget> createState() => _View3dWidgetState();
}

class _View3dWidgetState extends State<View3dWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RepaintBoundary(
      child: SizedBox.expand(child: BabylonJSViewer(src: widget.modelSource)),
    );
  }
}
