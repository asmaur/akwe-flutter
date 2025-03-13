import 'package:akwe/src/utils/app_transaction_export_header.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;

import 'invoices.dart';

Future<Uint8List> makePdf(Invoice invoice) async {
  final pdf = Document();
  var headers = getAppTransactionExportHeader();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/images/poupey-logo.png'))
          .buffer
          .asUint8List());
  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.landscape,
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Attention to: ${invoice.customer}"),
                    Text(invoice.address),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(imageLogo),
                )
              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: headers
                      .map(
                        (e) => Padding(
                          child: Text(
                            e,
                            style: Theme.of(context).header4,
                            textAlign: TextAlign.center,
                          ),
                          padding: const EdgeInsets.all(1),
                        ),
                      )
                      .toList(),
                  // [
                  //   Padding(
                  //     child: Text(
                  //       'INVOICE',
                  //       style: Theme.of(context).header4,
                  //       textAlign: TextAlign.center,
                  //     ),
                  //     padding: EdgeInsets.all(10),
                  //   ),
                  //   Padding(
                  //     child: Text(
                  //       'INVOICE',
                  //       style: Theme.of(context).header4,
                  //       textAlign: TextAlign.center,
                  //     ),
                  //     padding: EdgeInsets.all(10),
                  //   ),
                  //   Padding(
                  //     child: Text(
                  //       'INVOICE',
                  //       style: Theme.of(context).header4,
                  //       textAlign: TextAlign.center,
                  //     ),
                  //     padding: EdgeInsets.all(20),
                  //   ),
                  //   Padding(
                  //     child: Text(
                  //       'INVOICE',
                  //       style: Theme.of(context).header4,
                  //       textAlign: TextAlign.center,
                  //     ),
                  //     padding: EdgeInsets.all(20),
                  //   ),
                  // ],
                ),
                ...invoice.items.map(
                  (e) => TableRow(
                    children: [
                      Expanded(
                        child: PaddedText(e.description),
                        flex: 2,
                      ),
                      Expanded(
                        child: PaddedText("\$${e.cost}"),
                        flex: 1,
                      )
                    ],
                  ),
                ),
                // TableRow(
                //   children: [
                //     PaddedText('TAX', align: TextAlign.right),
                //     PaddedText('\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                //   ],
                // ),
                // TableRow(
                //   children: [PaddedText('TOTAL', align: TextAlign.right), PaddedText('\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')],
                // )
              ],
            ),

            // Padding(
            //   child: Text(
            //     "THANK YOU FOR YOUR CUSTOM!",
            //     style: Theme.of(context).header2,
            //   ),
            //   padding: EdgeInsets.all(20),
            // ),
            // Text("Please forward the below slip to your accounts payable department."),

            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    PaddedText('Account Number'),
                    PaddedText(
                      '1234 1234',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Account Name',
                    ),
                    PaddedText(
                      'ADAM FAMILY TRUST',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Total Amount to be Paid',
                    ),
                    PaddedText(
                        '\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                'Please ensure all cheques are payable to the ADAM FAMILY TRUST.',
                style: Theme.of(context).header3.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
