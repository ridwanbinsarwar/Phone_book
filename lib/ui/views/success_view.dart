import 'package:flutter_demo/core/scoped_models/success_model.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter_demo/ui/widgets/busy_overlay.dart';
import 'package:flutter/material.dart';

class SuccessView extends StatelessWidget {
  final String title;

  SuccessView({this.title});

  @override
  Widget build(BuildContext context) {
    return BaseView<SuccessModel>(
        onModelReady: (model) => model.fetchDuplicatedText(title),
        builder: (context, child, model) => BusyOverlay(
              child: Scaffold(
                body: Center(
                  child: Text(model.title),
                ),
              ),
            ));
  }
}
