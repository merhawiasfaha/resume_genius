import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_genius/formatters/month_year_input_formatter_present.dart';
import 'package:resume_genius/models/education.dart';
import 'work_experience_page.dart';
import 'package:resume_genius/formatters/month_year_input_formatter.dart';

class EducationPage extends StatefulWidget {
  final String name;

  const EducationPage({super.key, required this.name});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResumeGenius - Education'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter Your Education Details:', style: TextStyle(color: Color.fromARGB(255, 124, 124, 196), fontWeight: FontWeight.bold),),
              _buildTextField('School Name', schoolNameController, 30),
              _buildTextField('Course', courseController, 20),
              _buildTextField('Location (City and Province)', locationController, 20),
              _buildTextField('Start Date (MM/YYYY)', startDateController),
              _buildTextField('End Date (MM/YYYY or Press "P" for "Present")', endDateController),
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

  Widget _buildTextField(String labelText, TextEditingController controller, [int maxLength = 0]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength > 0 ? maxLength : null,
        decoration: InputDecoration(labelText: labelText),
        inputFormatters: labelText == 'Start Date (MM/YYYY)' ? [FilteringTextInputFormatter.digitsOnly, MonthYearInputFormatter()] :(labelText == 'End Date (MM/YYYY or Press "P" for "Present")'
              ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9pP]')), MonthYearInputFormatterPresent()]
              : null),
      ),
    );
  }

  


  void _validateAndNavigate(BuildContext context) {
    if (_validateFields()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkExperiencePage(
            name: widget.name,
            education: Education(
              schoolName: schoolNameController.text,
              course: courseController.text,
              location: locationController.text,
              startDate: startDateController.text,
              endDate: endDateController.text,
            ),
          ),
        ),
      );
    }
  }

  bool _validateFields() {
    if (schoolNameController.text.isEmpty ||
        courseController.text.isEmpty ||
        locationController.text.isEmpty ||
        startDateController.text.isEmpty ||
        endDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('All fields are required. Please fill in All fields.'),
      ));
      return false;
    }
    return true;
  }
}