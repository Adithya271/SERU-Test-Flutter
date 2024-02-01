import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wizard1.dart'; 
import 'wizard2.dart'; 
import 'wizard3.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WizardData()),
      
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:
          MyWizardNavigator(), 
    );
  }
}

class MyWizardNavigator extends StatefulWidget {
  const MyWizardNavigator({super.key});

  @override
  _MyWizardNavigatorState createState() => _MyWizardNavigatorState();
}

class _MyWizardNavigatorState extends State<MyWizardNavigator> {
  int currentWizard =
      1; 

  @override
  Widget build(BuildContext context) {
    Widget currentWizardWidget;

  
    switch (currentWizard) {
      case 1:
        currentWizardWidget = MyWizard1();
        break;
      case 2:
        currentWizardWidget = MyWizard2();
        break;
      case 3:
        currentWizardWidget = MyWizard3();
        break;
      default:
        currentWizardWidget =
            MyWizard1(); 
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Wizard $currentWizard'),
      ),
      body: currentWizardWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentWizard - 1, 
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: 'Wizard 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: 'Wizard 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: 'Wizard 3',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentWizard = index + 1; 
          });
        },
      ),
    );
  }
}
