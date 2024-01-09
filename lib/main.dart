import 'package:flutter/material.dart';

void main() {
  runApp(BMIApp());
}

class BMIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Display the SplashScreen initially
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay before navigating to the main screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                'Your BMI App🏋️',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = "";
  var bgcolor = Colors.blue.shade100;
  var showResult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Text('Your BMI APP 🏋️'),
        ),
      ),
      body: Container(
        color: bgcolor,
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BMI',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 21),
                TextField(
                  controller: wtController,
                  decoration: InputDecoration(
                      labelText: 'Enter your Weight in Kg.',
                      prefixIcon: Icon(Icons.line_weight)),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextField(
                  controller: ftController,
                  decoration: InputDecoration(
                      labelText: 'Enter your Height in feet.',
                      prefixIcon: Icon(Icons.height)),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextField(
                  controller: inController,
                  decoration: InputDecoration(
                      labelText: 'Enter your Height in Inch.',
                      prefixIcon: Icon(Icons.height)),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    var wt = wtController.text;
                    var ft = ftController.text;
                    var inch = inController.text;
                    if (wt != "" && ft != "" && inch != "") {
                      // BMI CALCULATION
                      // value converted into integer
                      var iwt = int.parse(wt);
                      var ift = int.parse(ft);
                      var iInch = int.parse(inch);

                      var tInch = (ift * 12) + iInch;
                      var tCm = tInch * 2.54;
                      var tM = tCm / 100;

                      var bmi = iwt / (tM * tM);
                      var msg = "";

                      if (bmi > 25) {
                        msg = "You are OverWeight!!";
                        bgcolor = Colors.orange;
                      } else if (bmi < 18) {
                        msg = "You are UnderWeight!!";
                        bgcolor = Colors.red;
                      } else {
                        msg = "You are Healthy!!";
                        bgcolor = Colors.green;
                      }
                      setState(() {
                        result =
                        "$msg \n Your BMI is 🏋️ : ${bmi.toStringAsFixed(2)}";
                        showResult = true;
                      });
                    } else {
                      setState(() {
                        result = "Please fill all the required blanks !!";
                        showResult = false;
                      });
                    }
                  },
                  child: Text('Calculate'),
                ),
                SizedBox(height: 11),
                ElevatedButton(
                  onPressed: () {
                    wtController.clear();
                    ftController.clear();
                    inController.clear();
                    setState(() {
                      result = "";
                      bgcolor = Colors.blue.shade100;
                      showResult = false;
                    });
                  },
                  child: Text('Clear'),
                ),
                SizedBox(height: 11),
                Text(
                  showResult ? result : "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
