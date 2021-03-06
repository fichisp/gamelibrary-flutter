import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'data.dart';

void main() {
  runApp(MaterialApp(
    title: 'Home',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => HomeScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/game/new': (context) => NewGameScreen(),
    },
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/game/new');
          },
        ),
      ),
    );
  }
}

class NewGameScreen extends StatefulWidget {
  @override
  NewGameState createState() {
    return NewGameState();
  }
}

class NewGameState extends State<NewGameScreen> {
  File _image;

//https://pub.dev/packages/image_picker#-readme-tab-
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  ImageProvider _loadImage() {
    if(_image == null) {
        return AssetImage('assets/nophoto.png');
    } else {
        return FileImage(_image);
    }
    

}

  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormFieldState> _specifyTextFieldKey =
      GlobalKey<FormFieldState>();

  ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FormBuilder Example"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: _image == null
              //           ? Text('No image selected.')
              //           : Image.file(_image),

              //     ),
              //     SizedBox(
              //       width: 20,
              //     ),
              //     Expanded(
              //       child: MaterialButton(
              //         color: Theme.of(context).accentColor,
              //         child: Text(
              //           "Load photo",
              //           style: TextStyle(color: Colors.white),
              //         ),
              //         onPressed: getImage,
              //       ),
              //     ),
              //   ],
              // ),
              FormBuilder(
                // context,
                key: _fbKey,
                autovalidate: true,
                initialValue: {
                  'movie_rating': 5,
                },
                // readOnly: true,
                child: Column(
                  children: <Widget>[
                    // Row(
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: _image == null
                    //           ? Text('No image selected.')
                    //           : Image.file(_image),
                    //     ),
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //     Expanded(
                    //       child: MaterialButton(
                    //         color: Theme.of(context).accentColor,
                    //         child: Text(
                    //           "Load photo",
                    //           style: TextStyle(color: Colors.white),
                    //         ),
                    //         onPressed: getImage,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    FormBuilderCustomField(
                      attribute: "image",
                      validators: [
                        //FormBuilderValidators.required(),
                      ],
                      formField: FormField(
                        enabled: true,
                        builder: (FormFieldState<String> field) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelText: "Select option",
                              contentPadding:
                                  EdgeInsets.only(top: 10.0, bottom: 0.0),
                              border: InputBorder.none,
                              errorText: field.errorText,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Image(
                                    image: _loadImage(),      
                                  ),
                                ),
                                // Expanded(
                                //   child: _image == null
                                //       ? Text('No image selected.')
                                //       : Image.file(_image),
                                // ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    color: Theme.of(context).accentColor,
                                    child: Text(
                                      "Load photo",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: getImage,
                                  ),
                                ),
                              ],
                            ),
                            
                          );
                        },
                      ),
                    ),
                    FormBuilderCustomField(
                      attribute: "name",
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                      formField: FormField(
                        enabled: true,
                        builder: (FormFieldState<dynamic> field) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelText: "Select option",
                              contentPadding:
                                  EdgeInsets.only(top: 10.0, bottom: 0.0),
                              border: InputBorder.none,
                              errorText: field.errorText,
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              items: ["One", "Two"].map((option) {
                                return DropdownMenuItem(
                                  child: Text("$option"),
                                  value: option,
                                );
                              }).toList(),
                              value: field.value,
                              onChanged: (value) {
                                field.didChange(value);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    FormBuilderChipsInput(
                      decoration: InputDecoration(labelText: "Chips"),
                      attribute: 'chips_test',
                      onChanged: _onChanged,
                      initialValue: [
                        Contact('Andrew', 'stock@man.com',
                            'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                      ],
                      maxChips: 5,
                      findSuggestions: (String query) {
                        if (query.length != 0) {
                          var lowercaseQuery = query.toLowerCase();
                          return contacts.where((profile) {
                            return profile.name
                                    .toLowerCase()
                                    .contains(query.toLowerCase()) ||
                                profile.email
                                    .toLowerCase()
                                    .contains(query.toLowerCase());
                          }).toList(growable: false)
                            ..sort((a, b) => a.name
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(b.name
                                    .toLowerCase()
                                    .indexOf(lowercaseQuery)));
                        } else {
                          return const <Contact>[];
                        }
                      },
                      chipBuilder: (context, state, profile) {
                        return InputChip(
                          key: ObjectKey(profile),
                          label: Text(profile.name),
                          avatar: CircleAvatar(
                            backgroundImage: NetworkImage(profile.imageUrl),
                          ),
                          onDeleted: () => state.deleteChip(profile),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        );
                      },
                      suggestionBuilder: (context, state, profile) {
                        return ListTile(
                          key: ObjectKey(profile),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(profile.imageUrl),
                          ),
                          title: Text(profile.name),
                          subtitle: Text(profile.email),
                          onTap: () => state.selectSuggestion(profile),
                        );
                      },
                    ),
                    FormBuilderDateTimePicker(
                      attribute: "date",
                      onChanged: _onChanged,
                      inputType: InputType.time,
                      decoration:
                          InputDecoration(labelText: "Appointment Time"),
                      // readonly: true,
                    ),
                    FormBuilderDateRangePicker(
                      attribute: "date_range",
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2020),
                      format: DateFormat("yyyy-MM-dd"),
                      onChanged: _onChanged,
                      decoration: InputDecoration(labelText: "Date Range"),
                    ),
                    FormBuilderSlider(
                      attribute: "slider",
                      validators: [FormBuilderValidators.min(6)],
                      onChanged: _onChanged,
                      min: 0.0,
                      max: 10.0,
                      initialValue: 7.0,
                      divisions: 20,
                      activeColor: Colors.red,
                      inactiveColor: Colors.pink[100],
                      decoration: InputDecoration(
                        labelText: "Number of things",
                      ),
                    ),
                    FormBuilderRangeSlider(
                      attribute: "range_slider",
                      validators: [FormBuilderValidators.min(6)],
                      onChanged: _onChanged,
                      min: 0.0,
                      max: 100.0,
                      initialValue: RangeValues(4, 7),
                      divisions: 20,
                      activeColor: Colors.red,
                      inactiveColor: Colors.pink[100],
                      decoration: InputDecoration(
                        labelText: "Price Range",
                      ),
                    ),
                    FormBuilderCheckbox(
                      attribute: 'accept_terms',
                      initialValue: false,
                      onChanged: _onChanged,
                      leadingInput: true,
                      label: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'I have read and agree to the ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("launch url");
                                },
                            ),
                          ],
                        ),
                      ),
                      validators: [
                        FormBuilderValidators.requiredTrue(
                          errorText:
                              "You must accept terms and conditions to continue",
                        ),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: "age",
                      decoration: InputDecoration(
                        labelText: "Age",
                      ),
                      onChanged: _onChanged,
                      valueTransformer: (text) => num.tryParse(text),
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(70),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    FormBuilderDropdown(
                      attribute: "gender",
                      decoration: InputDecoration(
                        labelText: "Gender",
                      ),
                      // initialValue: 'Male',
                      hint: Text('Select Gender'),
                      validators: [FormBuilderValidators.required()],
                      items: genderOptions
                          .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text('$gender'),
                              ))
                          .toList(),
                    ),
                    FormBuilderTypeAhead(
                      decoration: InputDecoration(
                        labelText: "Country",
                      ),
                      attribute: 'country',
                      onChanged: _onChanged,
                      itemBuilder: (context, country) {
                        return ListTile(
                          title: Text(country),
                        );
                      },
                      controller: TextEditingController(text: ''),
                      initialValue: "Uganda",
                      suggestionsCallback: (query) {
                        if (query.length != 0) {
                          var lowercaseQuery = query.toLowerCase();
                          return allCountries.where((country) {
                            return country
                                .toLowerCase()
                                .contains(lowercaseQuery);
                          }).toList(growable: false)
                            ..sort((a, b) => a
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(
                                    b.toLowerCase().indexOf(lowercaseQuery)));
                        } else {
                          return allCountries;
                        }
                      },
                    ),
                    FormBuilderTypeAhead(
                      decoration: InputDecoration(
                        labelText: "Contact Person",
                      ),
                      initialValue: contacts[0],
                      attribute: 'contact_person',
                      onChanged: _onChanged,
                      itemBuilder: (context, Contact contact) {
                        return ListTile(
                          title: Text(contact.name),
                          subtitle: Text(contact.email),
                        );
                      },
                      selectionToTextTransformer: (Contact c) => c.email,
                      suggestionsCallback: (query) {
                        if (query.length != 0) {
                          var lowercaseQuery = query.toLowerCase();
                          return contacts.where((contact) {
                            return contact.name
                                .toLowerCase()
                                .contains(lowercaseQuery);
                          }).toList(growable: false)
                            ..sort((a, b) => a.name
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(b.name
                                    .toLowerCase()
                                    .indexOf(lowercaseQuery)));
                        } else {
                          return contacts;
                        }
                      },
                    ),
                    FormBuilderRadio(
                      decoration:
                          InputDecoration(labelText: 'My chosen language'),
                      attribute: "best_language",
                      leadingInput: true,
                      onChanged: _onChanged,
                      validators: [FormBuilderValidators.required()],
                      options: [
                        "Dart",
                        "Kotlin",
                        "Java",
                        "Swift",
                        "Objective-C"
                      ]
                          .map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                    ),
                    FormBuilderSegmentedControl(
                      decoration:
                          InputDecoration(labelText: "Movie Rating (Archer)"),
                      attribute: "movie_rating",
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      options: List.generate(5, (i) => i + 1)
                          .map((number) => FormBuilderFieldOption(
                                value: number,
                                child: Text(
                                  "$number",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ))
                          .toList(),
                      onChanged: _onChanged,
                    ),
                    FormBuilderSwitch(
                      label: Text('I Accept the tems and conditions'),
                      attribute: "accept_terms_switch",
                      initialValue: true,
                      onChanged: _onChanged,
                    ),
                    FormBuilderStepper(
                      decoration: InputDecoration(labelText: "Stepper"),
                      attribute: "stepper",
                      initialValue: 10,
                      step: 1,
                    ),
                    FormBuilderRate(
                      decoration: InputDecoration(labelText: "Rate this form"),
                      attribute: "rate",
                      iconSize: 32.0,
                      initialValue: 1,
                      max: 5,
                      onChanged: _onChanged,
                    ),
                    FormBuilderCheckboxList(
                      decoration: InputDecoration(
                          labelText: "The language of my people"),
                      attribute: "languages",
                      initialValue: ["Dart"],
                      leadingInput: true,
                      options: [
                        FormBuilderFieldOption(value: "Dart"),
                        FormBuilderFieldOption(value: "Kotlin"),
                        FormBuilderFieldOption(value: "Java"),
                        FormBuilderFieldOption(value: "Swift"),
                        FormBuilderFieldOption(value: "Objective-C"),
                      ],
                      onChanged: _onChanged,
                    ),
                    FormBuilderCustomField(
                      attribute: 'custom',
                      valueTransformer: (val) {
                        if (val == "Other")
                          return _specifyTextFieldKey.currentState.value;
                        return val;
                      },
                      formField: FormField(
                        builder: (FormFieldState<String> field) {
                          var languages = [
                            "English",
                            "Spanish",
                            "Somali",
                            "Other"
                          ];
                          return InputDecorator(
                            decoration: InputDecoration(
                                labelText: "What's your preferred language?"),
                            child: Column(
                              children: languages
                                  .map(
                                    (lang) => Row(
                                      children: <Widget>[
                                        Radio<dynamic>(
                                          value: lang,
                                          groupValue: field.value,
                                          onChanged: (dynamic value) {
                                            field.didChange(lang);
                                          },
                                        ),
                                        lang != "Other"
                                            ? Text(lang)
                                            : Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      lang,
                                                    ),
                                                    SizedBox(width: 20),
                                                    Expanded(
                                                      child: TextFormField(
                                                        key:
                                                            _specifyTextFieldKey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  )
                                  .toList(growable: false),
                            ),
                          );
                        },
                      ),
                    ),
                    FormBuilderSignaturePad(
                      decoration: InputDecoration(labelText: "Signature"),
                      attribute: "signature",
                      // height: 250,
                      clearButtonText: "Start Over",
                      onChanged: _onChanged,
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_fbKey.currentState.saveAndValidate()) {
                          print(_fbKey.currentState.value);
                        } else {
                          print(_fbKey.currentState.value);
                          print("validation failed");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _fbKey.currentState.reset();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("Second Screen"),
//     ),
//     body: Center(
//       child: RaisedButton(
//         onPressed: () {
//           // Navigate back to the first screen by popping the current route
//           // off the stack.
//           Navigator.pop(context);
//         },
//         child: Text('Go back!'),
//       ),
//     ),
//   );
// }
// }

// import 'package:flutter/widgets.dart';
// import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
// import 'package:path/path.dart' as path;
// import 'package:sqflite/sqflite.dart';

// import 'model/game.dart';
// import 'model/platform.dart';
// import 'model/platformgame.dart';

// /// The adapter
// SqfliteAdapter _adapter;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Sqflite.devSetDebugModeOn(true);
//   var sb = StringBuffer();
//   sb.writeln("Jaguar ORM showcase:");

//   sb.writeln('--------------');
//   sb.write('Connecting ...');
//   var dbPath = await getDatabasesPath();
//   _adapter = SqfliteAdapter(path.join(dbPath, "test.db"));

//   try {
//     await _adapter.connect();
//     sb.writeln(' successful!');
//     sb.writeln('--------------');

//     final gameBean = GameBean(_adapter);
//     final platformBean = PlatformBean(_adapter);
//     final platformGameBean = PlatformGameBean(_adapter);

//     // Delete tables
//     await gameBean.drop();
//     await platformBean.drop();
//     await platformGameBean.drop();

//     sb.write('Creating table ...');
//     await gameBean.createTable();
//     await platformBean.createTable();
//     await platformGameBean.createTable();
//     sb.writeln(' successful!');
//     sb.writeln('--------------');

//     // Delete all
//     sb.write('Removing old rows (if any) ...');
//     await gameBean.removeAll();
//     sb.writeln(' successful!');
//     sb.writeln('--------------');

//     // Insert some games
//     sb.writeln('Inserting sample rows ...');
//     var game = new Game.make(1, 'Game 1', false, [
//       new Platform.make(1, 'Platform 1'),
//       new Platform.make(2, 'Platform 2')
//     ]);
//     int id1 = await gameBean.insert(game, cascade: true);
//     sb.writeln(
//         'Inserted successfully row with id: $id1 and one to many relation!');

//     sb.writeln('--------------');

//     // Find one post
//     sb.writeln('Reading row with id $id1 with one to one relation...');
//     Game game1 = await gameBean.find(id1, preload: true);
//     sb.writeln(game1);
//     sb.writeln('--------------');

//     sb.writeln('Removing row with id $id1 ...');
//     await gameBean.remove(id1);
//     sb.writeln('--------------');

//     sb.write('Closing the connection ...');
//     await _adapter.close();
//     sb.writeln(' successful!');
//     sb.writeln('--------------');
//   } finally {
//     print(sb.toString());
//   }

//   runApp(SingleChildScrollView(
//       child: Text(sb.toString(), textDirection: TextDirection.ltr)));
// }
