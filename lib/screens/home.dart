import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;


class LICCalculator extends StatefulWidget {
  @override
  _LICCalculatorState createState() => _LICCalculatorState();
}

class _LICCalculatorState extends State<LICCalculator> {
  String? _selectedPlan; 
  List<String> plans = ['Loading...']; 

  @override
  void initState() {
    super.initState();
    fetchLICData();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIC Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedPlan, // Use _selectedPlan directly
              items: plans.map((plan) {
                return DropdownMenuItem<String>(
                  value: plan,
                  child: Text(plan),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPlan = value; // Update _selectedPlan
                });
              },
              decoration: InputDecoration(
                labelText: 'Choose Plan',
                border: OutlineInputBorder(),
              ),
            ),
                        SizedBox(height: 20),

             TextFormField(
              decoration: InputDecoration(
                labelText: 'Basic Sum Assured',
                border: OutlineInputBorder(),
              ),
            ),
                 SizedBox(height: 20),

             TextFormField(
              decoration: InputDecoration(
                labelText: 'Basic Sum Assured',
                border: OutlineInputBorder(),
              ),
            ),
                 SizedBox(height: 20),

             TextFormField(
              decoration: InputDecoration(
                labelText: 'Basic Sum Assured',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
           

            ElevatedButton(
              style: ButtonStyle(    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
),
              onPressed: () async {
                await fetchLICData();
              },
              child: Text('Calculate',style: TextStyle(color:Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchLICData() async {
    try {
      final response = await http.get(Uri.parse('https://www.licpremiumcalculator.in/'));

      if (response.statusCode == 200) {
        final document = parser.parse(response.body);

        final elements = document.querySelectorAll('#table'); 

        final fetchedPlans = elements.map((element) => element.text.trim()).toList();

        final uniquePlans = fetchedPlans.toSet().toList();

        setState(() {
          plans = uniquePlans;
          _selectedPlan = uniquePlans.isNotEmpty ? uniquePlans.first : null; 
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as parser;
// import 'package:html/dom.dart' as dom;

// void main() {
//   runApp(MaterialApp(
//     home: LICCalculator(),
//   ));333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
// }

// class LICCalculator extends StatefulWidget {
//   @override
//   _LICCalculatorState createState() => _LICCalculatorState();
// }

// class _LICCalculatorState extends State<LICCalculator> {
//   String _selectedPlan = '';
//   List<String> plans = [''];

//   String _selectedAge = '20';
//   String _selectedTerm = '12';

//   List<String> ages = List.generate(100, (index) => (index + 1).toString());
//   List<String> terms = List.generate(35, (index) => (index + 1).toString());

//   bool _showPlanList = false; // Track whether to show the plan list

//   @override
//   void initState() {
//     super.initState();
//     fetchLICData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('LIC Calculator'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
            
//             SizedBox(height: 20),
//             DropdownButtonFormField<String>(
//               value: _selectedPlan,
//               items: plans.map((plan) {
//                 return DropdownMenuItem<String>(
//                   value: plan,
//                   child: Text(plan),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedPlan = value!;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Choose Plan',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Basic Sum Assured',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             DropdownButtonFormField<String>(
//               value: _selectedAge,
//               items: ages.map((age) {
//                 return DropdownMenuItem<String>(
//                   value: age,
//                   child: Text(age),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedAge = value!;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Current Age',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             DropdownButtonFormField<String>(
//               value: _selectedTerm,
//               items: terms.map((term) {
//                 return DropdownMenuItem<String>(
//                   value: term,
//                   child: Text(term),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedTerm = value!;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Policy Term',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await fetchLICData();
//               },
//               child: Text('Scrape LIC Data'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> fetchLICData() async {
//     final response = await http.get(Uri.parse('https://www.licpremiumcalculator.in/'));
//     if (response.statusCode == 200) {
//       final document = parser.parse(response.body);
//    //   log(response.body);

//      final planElements = document.querySelectorAll('table');
// plans = planElements.map((element) => element.text.trim()).toList();


//       final ageElements = document.querySelectorAll('age');
//       ages = ageElements.map((element) => element.text.trim()).toList();

//       final termElements = document.querySelectorAll('term');
//       terms = termElements.map((element) => element.text.trim()).toList();

//       setState(() {});
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }

