import 'package:flutter/material.dart';
import 'resume_preview_page.dart';

class ResumeCustomizationPage extends StatefulWidget {
  final String generatedResume;

  const ResumeCustomizationPage({super.key, required this.generatedResume});

  @override
  State<ResumeCustomizationPage> createState() => _ResumeCustomizationPageState();
}

class _ResumeCustomizationPageState extends State<ResumeCustomizationPage> {
  late TextEditingController resumeController;

  @override
  void initState() {
    super.initState();
    resumeController = TextEditingController(text: widget.generatedResume);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResumeGenius - Customization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Customize Your Resume:',
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 124, 124, 196), fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: resumeController,
                maxLines: null, // Allows the TextField to dynamically expand
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  labelText: 'Resume Content',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform customization logic here if needed
                // You can access the customized resume using: resumeController.text
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResumePreviewPage(generatedResume: resumeController.text),
                  ),
                );
              },
              child: const Text('Save and Preview'),
            ),
          ],
        ),
      ),
    );
  }
}