import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:resume_genius/models/education.dart';
import 'package:resume_genius/models/work_experience.dart';
import 'resume_customization_page.dart';
import 'package:resume_genius/services/api_service.dart';

class OpenAIContentGenerationPage extends StatefulWidget {
  final String name;
  final List<WorkExperience> experiences;
  final String skills;
  final Education education;

  const OpenAIContentGenerationPage({
    super.key,
    required this.name,
    required this.experiences,
    required this.skills,
    required this.education,
  });

  @override
  State<OpenAIContentGenerationPage> createState() =>
      _OpenAIContentGenerationPageState();
}

class _OpenAIContentGenerationPageState
    extends State<OpenAIContentGenerationPage> {
  bool _isTyping = false;
  String generatedResume = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResumeGenius - Content'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100,),
                const Text(
                  'Resume will be generated for:',
                  style: TextStyle(
                    fontSize: 23,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 124, 124, 196),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Name: \n${widget.name}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Education: \n${widget.education.schoolName}, ${widget.education.course}, ${widget.education.location}, ${widget.education.startDate} - ${widget.education.endDate}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                _buildExperienceSection(),
                const SizedBox(height: 8),
                Text(
                  'Skills: \n${widget.skills}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        _isTyping = true;
                      });
                      generatedResume = await ApiService.getGeneratedResume(
                        fullName: widget.name,
                        education: widget.education.toMap(),
                        workExperiences: workExperiencesToMaps(widget.experiences),
                        skills: widget.skills,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResumeCustomizationPage(generatedResume: generatedResume),
                        ),
                      );
                    } catch (e) {
                      // Handle errors that occurred during resume generation
                      log("Error: $e");
                    } finally {
                      setState(() {
                        _isTyping = false;
                      });
                    }
                  },
                  child: const Text('Generate Resume and Customize'),
                ),
                if (_isTyping) ...[
                  const SizedBox(height: 16),
                  const SpinKitThreeBounce(
                    color: Color.fromARGB(255, 78, 145, 199),
                    size: 25,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Work Experiences:', style: TextStyle(fontSize: 16)),
        for (var experience in widget.experiences)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_right),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${experience.company} - ${experience.position} (${experience.startDate} - ${experience.endDate})',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
