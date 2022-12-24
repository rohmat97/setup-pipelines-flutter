import 'package:flutter/material.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:kai_wisata/pdf_viewer_arguments.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({Key? key}) : super(key: key);

  static const routeName = '/pdf-viewer';

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PdfViewerArguments;
    // print('==>' + args.filename);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tiket"),
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       await saveFile(widget.url, "sample.pdf");
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(
        //           content: Text(
        //             'success',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //       );
        //     },
        //     icon: const Icon(Icons.download_rounded),
        //   ),
        // ],
      ),
      body: PDFView(
        // filePath: args.filename,
      ),
    );
  }
}
