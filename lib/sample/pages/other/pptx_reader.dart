import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart'; // SystemChrome uchun
import 'package:easy_docs_viewer/easy_docs_viewer.dart';

import '../../../controllers/api_controller.dart';

class PptxReader extends StatelessWidget {
  final String url;
  const PptxReader({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // Ekranni albom rejimiga majburiy qilish
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      body: NetworkPPTXViewer(url: url),
    );
  }
}

class NetworkPPTXViewer extends StatefulWidget {
  final String url;

  const NetworkPPTXViewer({super.key, required this.url});

  @override
  State<NetworkPPTXViewer> createState() => _NetworkPPTXViewerState();
}

class _NetworkPPTXViewerState extends State<NetworkPPTXViewer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Ekran orientatsiyasini qayta tiklash
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    ApiController().getSubject();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyDocsViewer(
        url: widget.url
      )
    );
  }
}