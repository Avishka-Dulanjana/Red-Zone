import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://firebasestorage.googleapis.com/v0/b/eredzone-bd711.appspot.com/o/flood_risk_maps%2Fflood%2FApril.html?alt=media&token=7016d46c-be8a-4c01-9990-7ed4ddb2ce62');

    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Web Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchUrl,
          child: const Text('Open Google'),
        ),
      ),
    );
  }
}
