import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

criarPDF(int numero) async {
  final pdf = Document();
  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat(
        75 * PdfPageFormat.mm,
        150 * PdfPageFormat.mm,
      ),
      build: (Context context) {
        return Center(child: Text("Novo teste de PDF ${numero.toString()}"));
      },
    ),
  );

  final externalStorage = await getExternalStorageDirectory();
  Directory directory =
      await Directory("${externalStorage.path}/SommusVendas").create();
  final File file = File("${directory.path}/sommus_${numero.toString()}.pdf");
  file.writeAsBytesSync(pdf.save());
}
