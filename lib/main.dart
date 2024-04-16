import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TwoTextInputs(),
    );
  }
}

class TwoTextInputs extends StatefulWidget {
  const TwoTextInputs({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TwoTextInputsState createState() => _TwoTextInputsState();
}

class _TwoTextInputsState extends State<TwoTextInputs> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _controller1,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _controller2,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NextScreen()),
    );
  },
  child: const Text('Submit'),
),

          ],
        ),
      ),
    );
    

  }
}


class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MySales()),
    );
  },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: const Text('My Sales'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequiredMaterials()),
    ); // Add your logic here for the second button action
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: const Text('Required Materials'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
            Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubmitPage()),
    );  // Add your logic here for the third button action
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: const Text('Upload Photo'),
            ),
          ),
        ],
      ),
    );
  }
}



class MySales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Sales'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          MonthSelectionRow(label: 'Today Sales   '),
          MonthSelectionRow(label: 'Last Day Sales'),
          MonthSelectionRow(label: 'Monthly Sales '),
        ],
      ),
    );
  }
}

class MonthSelectionRow extends StatefulWidget {
  final String label;

  MonthSelectionRow({required this.label});

  @override
  _MonthSelectionRowState createState() => _MonthSelectionRowState();
}

class _MonthSelectionRowState extends State<MonthSelectionRow> {
  String selectedMonth = 'January'; // Default value

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20,),
        Text(widget.label),
        SizedBox(width: 20),
        DropdownButton<String>(
          value: selectedMonth,
          onChanged: (String? newValue) {
            setState(() {
              selectedMonth = newValue!;
            });
          },
          items: <String>[
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}


class RequiredMaterials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Required Materials'),
      ),
      body: Column(
        children: [
          Text("daily Requirements"),
          NumberSelectionRow(label: 'Dal'),
          NumberSelectionRow(label: 'onion'),
          NumberSelectionRow(label: 'chilli'),
          SizedBox(height: 30,),
          Text("Weekly Requirements"),
          NumberSelectionRow(label: 'Dal'),
          NumberSelectionRow(label: 'onion'),
          NumberSelectionRow(label: 'chilli'),
          
        ],
      ),
    );
  }
}

class NumberSelectionRow extends StatefulWidget {
  final String label;

  NumberSelectionRow({required this.label});

  @override
  _NumberSelectionRowState createState() => _NumberSelectionRowState();
}

class _NumberSelectionRowState extends State<NumberSelectionRow> {
  int selectedNumber = 1; // Default value

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 30,),
        Text(widget.label),
        SizedBox(width: 20),
        DropdownButton<int>(
          value: selectedNumber,
          onChanged: (int? newValue) {
            setState(() {
              selectedNumber = newValue!;
            });
          },
          items: List.generate(12, (index) => index + 1).map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class SubmitPage extends StatefulWidget {
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<SubmitPage> {
  final TextEditingController _textInputController = TextEditingController();
  File? _image;

  Future<void> _captureImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Photo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' ${DateTime.now().toString().substring(0, 10)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _captureImage,
              child: Text('Capture Image'),
            ),
            SizedBox(height: 20),
            _image != null
                ? Image.file(
                    _image!,
                    height: 200,
                  )
                : Container(),
            SizedBox(height: 20),
            TextField(
              controller: _textInputController,
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your submit logic here
                print('Submitted');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
