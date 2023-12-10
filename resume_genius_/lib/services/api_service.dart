import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resume_genius/constants/api_const.dart';
class ApiService {
  static Future<String> getGeneratedResume({required String fullName, required Map<String, dynamic> education, required List<Map<String, dynamic>> workExperiences, required String skills}) async {
    
    print("Inside the API service");
    
    try {
      // Construct the content prompt dynamically
      final contentPrompt = _constructContentPrompt(fullName, education, workExperiences, skills);

      final requestBody = {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': contentPrompt}
        ],
        'temperature': 0.7
      };

      final response = await http.post(
        Uri.parse('$BASE_URL/chat/completions'),
        headers: {
          'Authorization': 'Bearer $OPENAI_API_KEY',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      String resume = " ";

      if (response.statusCode == 200) {
        // final jsonResponse = json.decode(response.body);

        // Parse the JSON string
        Map<String, dynamic> json = jsonDecode(response.body);

        // Extract the content value
        String content = json['choices'][0]['message']['content'];

        // Print the content value
        print(content);
        resume = content;
        // Handle the JSON response here
        // print('Resume generated successfully: $jsonResponse');
      } else {
        // Handle other status codes here
        print('Failed to generate resume. Status code: ${response.statusCode}');
      }
      return resume;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  static String _constructContentPrompt(String fullName, Map<String, dynamic> education, List<Map<String, dynamic>> workExperiences, String skills) {
    // Construct the content prompt using the provided data
    final educationDetails = '- ${education['course']} from ${education['schoolName']}, located in ${education['location']}. Started in ${education['startDate']} and completed in ${education['endDate']}';

    final workExpDetails = workExperiences.map((exp) {
      return '[${exp['position']}] at [${exp['company']}] from [${exp['startDate']}] to [${exp['endDate']}]';
    }).join('. ');

    final skillsList = skills.split(',').map((skill) => '- $skill').join('\n');

    String exampleResume = '''
                Full Name

                Address | Telephone Number | Email

                Profile  

                Motivated and enthusiastic individual seeking full-time or part-time in the Mental or Physical Disability Support Work Industry. 
                Organized, reliable, and work well independently or as a part of a team. 
                Dependable, outgoing personality, and excellent team player. Flexible, reliable, and quick learner. 

                Work Experiences

                Dayah Wayrah, Edmonton, AB | Support Worker | Nov 2019 - Present
                - Assisted the patient in performing routine tasks.
                - Managed behavioral problems and provided the necessary support.
                - Documented details of the patient in the admission and performance reports of the patient.
                - Prepared and served meals and cleaned the client's place daily.
                - Administered the right medication always at the right time.

                Education

                City, Province, Country | Sep 2014 - June 2016
                - Course Taken

                Skills

                - Advanced Microsoft Word skills
                - Knowledge of email systems
                - Intermediate Microsoft Excel and social media skills
                - Introductory Microsoft PowerPoint 
      ''';

    // Construct the prompt for generating the resume
    return 'Build a min of 100 words and max 300 words professionally formatted resume(follow the formatting provided in the example) for Full Name: $fullName.\n\nEducation:\n$educationDetails.\n\nWork Experience:\n$workExpDetails.\n\nSkills:\n$skillsList\n. Follow the following sample resume format(do not use the data in your response, this is just a format exmaple): \n $exampleResume \n.';
  }
}
