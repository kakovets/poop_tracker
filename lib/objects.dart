class User {
  String _name = 'Victor Ivankin';
  List<Dog> dogList = [];

  String get getName => _name;

  set name (String newName) {
    _name = newName;
  }
}

class Dog {
  String name;
  String breed;
  int weight;
  List<Poop> poops = [];

  Dog(this.name, this.breed, this.weight);

  Dog.germanShepherd(String name, int weight) :
        this(name, 'German Shepherd', weight);

}

class Poop {
  DateTime dateTime;
  int weight;
  String color;

  Poop(DateTime dateTime, int weight, String color):
        this.dateTime = dateTime,
        this.weight = weight,
        this.color = color;
}