import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poop_tracker/objects.dart';
import 'package:poop_tracker/widgets/poop_tile.dart';

User user = User();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const Start(),
    );
  }
}

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);
  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {

  int selectedScreen = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedScreen = index;
    });
  }

  List navBarScreens = [
    const PoopHome(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: navBarScreens[selectedScreen],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedScreen,
          onTap: onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            )
          ],
        )
    );
  }
}

class PoopHome extends StatefulWidget {
  const PoopHome({super.key});

  @override
  State<PoopHome> createState() => _PoopHomeState();
}

class _PoopHomeState extends State<PoopHome> {

  Dog? selectedDog;

  late TextEditingController dogNameController;
  late TextEditingController dogBreedController;
  late TextEditingController dogWeightController;
  late TextEditingController poopWeightController;
  late TextEditingController poopColorController;

  @override
  void initState() {
    super.initState();
    dogNameController = TextEditingController();
    dogBreedController = TextEditingController();
    dogWeightController = TextEditingController();
    poopWeightController = TextEditingController();
    poopColorController = TextEditingController();
  }

  @override
  void dispose() {
    dogNameController.dispose();
    dogBreedController.dispose();
    dogWeightController.dispose();
    poopWeightController.dispose();
    poopColorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pooping_dog.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 24,),

                  const Text(
                    'Welcome,',
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                  Text(
                    user.getName,
                    style: const TextStyle(
                        fontSize: 24
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              user.dogList.addAll([
                                Dog('Morkva', 'Shepherd', 35),
                                Dog('Roscoe', 'Hamilton', 24),
                                Dog('Kotleta', 'Bulldog', 13),
                                Dog('Targan', 'Retriever', 28),
                                Dog('Kvas', 'Husky', 30),
                                Dog('Boris', 'Collie', 20),
                                Dog('Duke', 'Poodle', 15),
                              ]);
                            });
                          },
                          icon: const Icon(Icons.pets)
                      ),
                      const Text(
                        'Choose your doggie:',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              selectedDog?.poops.addAll([
                                Poop(DateTime.now(), 1, 'chocolate'),
                                Poop(DateTime.now(), 2, 'red'),
                                Poop(DateTime.now(), 3, 'blue'),
                                Poop(DateTime.now(), 4, 'purple'),
                                Poop(DateTime.now(), 5, 'pink'),
                                Poop(DateTime.now(), 6, 'grey'),
                                Poop(DateTime.now(), 7, 'white'),
                                Poop(DateTime.now(), 8, 'green'),
                              ]);
                            });
                          },
                          icon: const Icon(Icons.location_on)
                      ),
                    ],
                  ),

                  const SizedBox(height: 24,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      height: 30,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...user.dogList.map((dog) => GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14.0),
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: selectedDog == dog ? Border.all(width: 2, color: Colors.black) : null
                              ),
                              child: Center(child: Text(dog.name)),
                            ),
                            onTap: () {
                              setState(() {
                                selectedDog = dog;
                              });
                            },
                          )),
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade200,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const Center(child: Text('Add')),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text('Your new dog'),
                                          const SizedBox(height: 24,),
                                          TextFormField(
                                            controller: dogNameController,
                                            decoration: InputDecoration(
                                              hintText: 'Dog name',
                                              hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
                                            ),
                                          ),
                                          const SizedBox(height: 12,),
                                          TextFormField(
                                            controller: dogBreedController,
                                            decoration: InputDecoration(
                                              hintText: 'Dog breed',
                                              hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
                                            ),
                                          ),
                                          const SizedBox(height: 12,),
                                          TextFormField(
                                            controller: dogWeightController,
                                            decoration: InputDecoration(
                                              hintText: 'Dog weight',
                                              hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
                                            ),
                                          ),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            dogNameController.clear();
                                            dogBreedController.clear();
                                            dogWeightController.clear();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (dogNameController.text.isNotEmpty &&
                                                dogBreedController.text.isNotEmpty &&
                                                dogWeightController.text.codeUnits.every(
                                                        (element) => element >= 0x30 && element < 0x3A)
                                            ) {
                                              int? weight = int.tryParse(dogWeightController.text);
                                              if (weight == null) return;
                                              setState(() {
                                                user.dogList.add(
                                                    Dog(dogNameController.text, dogBreedController.text, weight)
                                                );
                                              });
                                              Navigator.of(context).pop();
                                              dogNameController.clear();
                                              dogBreedController.clear();
                                              dogWeightController.clear();
                                            } else {
                                              Fluttertoast.showToast(msg: 'Something is wrong!');
                                            }
                                          },
                                          child: const Text('Add'),
                                        ),
                                      ],
                                    );
                                  }
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24,),
                ],
              ),
            ),

            selectedDog == null
                ?
            const Expanded(
              child: Center(
                child: Text(
                  'Select a dog!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
                :
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
                      decoration: BoxDecoration(
                        color: Colors.red[200],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Center(child: Text('Add poop')),
                    ),
                    onTap: () async {
                      DateTime? dt = await _chooseDateTime();
                      if (dt != null) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('New dog\'s poop'),
                                    const SizedBox(height: 24,),
                                    TextFormField(
                                      controller: poopWeightController,
                                      decoration: InputDecoration(
                                        hintText: 'Poop weight',
                                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
                                      ),
                                    ),
                                    const SizedBox(height: 12,),
                                    TextFormField(
                                      controller: poopColorController,
                                      decoration: InputDecoration(
                                        hintText: 'Poop color',
                                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
                                      ),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      poopWeightController.clear();
                                      poopColorController.clear();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (poopColorController.text.isNotEmpty &&
                                          poopWeightController.text.codeUnits.every(
                                                  (element) => element >= 0x30 && element < 0x3A)
                                      ) {
                                        int? weight = int.tryParse(poopWeightController.text);
                                        if (weight == null) return;
                                        setState(() {
                                          selectedDog!.poops.add(
                                              Poop(dt, weight, poopColorController.text)
                                          );
                                        });
                                        Navigator.of(context).pop();
                                        poopWeightController.clear();
                                        poopColorController.clear();
                                      } else {
                                        Fluttertoast.showToast(msg: 'Something is wrong!');
                                      }
                                    },
                                    child: const Text('Add'),
                                  ),
                                ],
                              );
                            }
                        );
                      } else {
                        Fluttertoast.showToast(msg: 'Something is wrong!');
                      }
                    },
                  ),
                  ...?selectedDog?.poops.map((poop) => PoopTile(poop: poop)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _chooseDateTime() async {
    DateTime? date = await _selectDate();
    if (date == null) {
      return null;
    }
    TimeOfDay? time = await _selectTime();
    if (time == null) {
      return null;
    }

    final selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return selectedDateTime;
  }

  Future<DateTime?> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    return picked;
  }

  Future<TimeOfDay?> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    return picked;
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late TextEditingController userNameController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
  }
  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // NAME
            InkWell(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  children: [
                    const SizedBox(width: 16,),
                    const Icon(Icons.edit),
                    const SizedBox(width: 16,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('User name'),
                        const SizedBox(height: 4,),
                        Row(
                          children: [
                            Text(user.getName, style: TextStyle(fontSize: 12, color: Colors.grey[500]),),
                          ],
                        ),
                      ],
                    )
                  ],
                ),

              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      userNameController.text = user.getName;
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('User name'),
                            TextFormField(
                              autofocus: true,
                              controller: userNameController,
                              decoration: InputDecoration(
                                hintText: 'User name',
                                hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
                              ),
                            )
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (userNameController.text.isEmpty){
                                Fluttertoast.showToast(msg: 'Name is empty');
                              } else {
                                setState(() {
                                  user.name = userNameController.text;
                                });
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      );
                    }
                );
              },
            ),

            // DELETE DOGS
            InkWell(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: const Row(
                  children: [
                    SizedBox(width: 16,),
                    Icon(Icons.delete),
                    SizedBox(width: 16,),
                    Text('Delete dogs')
                  ],
                ),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text('Are you sure you want to delete all your dogs?'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              user.dogList.clear();
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                  color: Colors.red
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

