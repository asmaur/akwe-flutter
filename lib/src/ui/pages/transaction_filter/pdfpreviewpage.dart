import 'package:akwe/src/ui/pages/transaction_filter/pdfexport.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import 'invoices.dart';

class PdfPreviewPage extends StatelessWidget {
  final Invoice invoice;
  const PdfPreviewPage({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice),
      ),
    );
  }
}