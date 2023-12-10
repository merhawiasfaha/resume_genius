import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class ResumePreviewPage extends StatefulWidget {
  final String generatedResume;

  const ResumePreviewPage({super.key, required this.generatedResume});

  @override
  State<ResumePreviewPage> createState() => _ResumePreviewPageState();
}

class _ResumePreviewPageState extends State<ResumePreviewPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResumeGenius - Preview'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 8,),
            const Text(
              'Resume preview:',
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 124, 124, 196), fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.generatedResume,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            if (isLoading) ...[
              const SizedBox(height: 16),
              const SpinKitThreeBounce(
                color: Color.fromARGB(255, 78, 145, 199),
                size: 25,
              ),
            ],
            if (!isLoading) 
            ElevatedButton(
              onPressed: () async {
                 setState(() {
                      isLoading = true;
                    });
                await saveAsPdf(context, widget.generatedResume);
                // ignore: use_build_context_synchronously
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Download Resume (PDF)'),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Future<void> saveAsPdf(BuildContext context, String resumeContent) async {
    try {
      final pdf = pw.Document();
      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(resumeContent),
          );
        },
      ));

      // Get the directory for the Downloads folder
      final Directory? directory = await getDownloadsDirectory();
      final String filePath = '${directory?.path}/resume.pdf';

      // Save the PDF to local storage (Downloads folder)
      final File file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        isLoading = false;
      });

      print('PDF saved to: $filePath');

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Resume downloaded successfully as PDF.'),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));

      // Open the file after it's downloaded
      OpenFile.open(filePath);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error downloading resume as PDF.'),
        ),
      );
      print('Error: $e');
    }
  }
}
