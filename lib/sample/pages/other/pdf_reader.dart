import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart'; // SystemChrome uchun

class PdfReader extends StatelessWidget {
  final String url;
  const PdfReader({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // Ekranni albom rejimiga majburiy qilish
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      body: NetworkPDFViewer(url: url),
    );
  }
}

class NetworkPDFViewer extends StatefulWidget {
  final String url;

  const NetworkPDFViewer({super.key, required this.url});

  @override
  State<NetworkPDFViewer> createState() => _NetworkPDFViewerState();
}

class _NetworkPDFViewerState extends State<NetworkPDFViewer> {
  String? localFilePath;

  @override
  void initState() {
    super.initState();
    _downloadPDF();
  }

  @override
  void dispose() {
    // Ekran orientatsiyasini qayta tiklash (ixtiyoriy)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  Future<void> _downloadPDF() async {
    try {
      final url = Uri.parse(widget.url);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getApplicationDocumentsDirectory();
        final file = File("${dir.path}/temp.pdf");

        await file.writeAsBytes(bytes, flush: true);

        setState(() {
          localFilePath = file.path;
        });
      } else {
        throw Exception("Failed to load PDF");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: localFilePath != null
          ? PDFView(
        filePath: localFilePath,
        swipeHorizontal: false, // Gorizontal surish
        pageFling: true,
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}