// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:resume_genius/models/education.dart';
import 'package:resume_genius/models/work_experience.dart';
import 'openai_content_generation_page.dart';


class SkillsPage extends StatefulWidget {
  final String name;
  Education education;
  final List<WorkExperience> experiences;

   SkillsPage({super.key, required this.name, required this.education, required this.experiences});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  TextEditingController skillsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResumeGenius - Skills'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter Your Skills (Max 200 Characters):'),
              _buildTextField('Skills', skillsController, maxLength: 200),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _validateAndNavigate(context);
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller, {int? maxLength}) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(labelText: labelText),
    );
  }

  void _validateAndNavigate(BuildContext context) {
    if (_validateFields(skillsController.text)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OpenAIContentGenerationPage(
            name: widget.name,
            education: widget.education,
            experiences: widget.experiences,
            skills: skillsController.text,
          ),
        ),
      );
    }
  }

  bool _validateFields(String skills) {
    if (skills.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill in all required fields.'),
      ));
      return false;
    }
    return true;
  }
}