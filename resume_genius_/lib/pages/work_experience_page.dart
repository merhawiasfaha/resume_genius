import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_genius/formatters/month_year_input_formatter.dart';
import 'package:resume_genius/formatters/month_year_input_formatter_present.dart';
import 'package:resume_genius/models/work_experience.dart';
import 'package:resume_genius/models/education.dart';
import 'skills_page.dart';

class WorkExperiencePage extends StatefulWidget {
  final String name;
  final Education education;

  const WorkExperiencePage({super.key, required this.name, required this.education});

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage> {
  List<WorkExperience> workExperiences = [];

@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResumeGenius  - Work Experience'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter Your Work Experience:', style: TextStyle(color: Color.fromARGB(255, 124, 124, 196), fontWeight: FontWeight.bold, fontSize: 15),),
              const SizedBox(height: 8,),
              _buildExperienceSection(),
              ElevatedButton(
                onPressed: () {
                  _addExperience(context);
                },
                child: const Text('Add Work Experience', style: TextStyle(color: Color.fromARGB(255, 124, 124, 196), fontWeight: FontWeight.bold),),
              ),
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

  Future<void> _addExperience(BuildContext context) async {
  TextEditingController companyController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Work Experience', style: TextStyle(color: Color.fromARGB(255, 124, 124, 196), fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView(
            children: [
              _buildTextField('Company Name', companyController),
              _buildTextField('Position Title', positionController),
              _buildTextField('Start Date (MM/YYYY)', startDateController),
              _buildTextField('End Date (MM/YYYY or "P")', endDateController),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _validateAndAddExperience(
                context,
                companyController.text,
                positionController.text,
                startDateController.text,
                endDateController.text,
              );
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}



  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Work Experiences:'),
        for (var experience in workExperiences)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                const Icon(Icons.arrow_right),
                const SizedBox(width: 8),
                Expanded(
                child: Text(
                    '${experience.company} - ${experience.position} (${experience.startDate} - ${experience.endDate})',
                    maxLines: 2, // Adjust maxLines as needed
                    overflow: TextOverflow.ellipsis, // Use ellipsis for overflow
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller, [int maxLength = 0]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength > 0 ? maxLength : null,
        decoration: InputDecoration(labelText: labelText),
        inputFormatters: labelText == 'Start Date (MM/YYYY)' ? [FilteringTextInputFormatter.digitsOnly, MonthYearInputFormatter()] :(labelText == 'End Date (MM/YYYY or "P")'
              ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9pP]')), MonthYearInputFormatterPresent()]
              : null),
      ),
    );
  }

  void _validateAndAddExperience(
    BuildContext context,
    String company,
    String position,
    String startDate,
    String endDate,
  ) {
    if (_validateFields(company, position, startDate, endDate)) {
      setState(() {
        workExperiences.add(
          WorkExperience(
            company: company,
            position: position,
            startDate: startDate,
            endDate: endDate,
          ),
        );
      });
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  bool _validateFields(String company, String position, String startDate, String endDate) {
    if (company.isEmpty || position.isEmpty || startDate.isEmpty || endDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill in all required fields.'),
      ));
      return false;
    }
    return true;
  }

  void _validateAndNavigate(BuildContext context) {
    if (workExperiences.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SkillsPage(name: widget.name, education: widget.education, experiences: workExperiences),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please add at least one work experience.'),
      ));
    }
  }
}

