import 'package:faker/faker.dart';

class MockDataProvider {
  final int _userCount;
  final int _feedsCountPerUsers;
  final Faker faker = Faker();
  late List<User> users;
  late List<String> contents;

  MockDataProvider({int userCount = 20})
      : _feedsCountPerUsers = 54,
        _userCount = userCount {
    users = _generateUsers();
    contents = _generateContents();
  }

  List<User> _generateUsers() {
    List<User> users = [];
    for (int i = 0; i < _userCount; i++) {
      users.add(User(
          firstName: faker.person.firstName(),
          lastName: faker.person.lastName(),
          userName: RandomGenerator().boolean() ? '${faker.lorem.word()}_${faker.lorem.word()}' : faker.lorem.word()));
    }
    return users;
  }

  List<String> _generateContents() {
    List<String> contents = [];
    for (int i = 0; i < _feedsCountPerUsers; i++) {
      contents.add(faker.lorem.sentences(RandomGenerator().integer(5) + 1).join('\n'));
    }
    return contents;
  }

  User getUser([int? index]) {
    if (index == null || index < 0 || index >= _userCount) {
      index = RandomGenerator().integer(_userCount);
    }
    return users[index];
  }

  String getContents() {
    return contents[RandomGenerator().integer(_feedsCountPerUsers)];
  }

  String getImageAssetPath() {
    var assetImageIndex = RandomGenerator().integer(_feedsCountPerUsers) + 1;
    return 'assets/images/Image${assetImageIndex < 10 ? '0' : ''}$assetImageIndex.png';
  }

  String getLocation() {
    return '${faker.address.city()} ${faker.address.state()}';
  }
}

class User {
  final String _firstName;
  final String _lastName;
  final String _userName;
  late final String _email;

  User({required String firstName, required String lastName, required String userName})
      : _userName = userName,
        _lastName = lastName,
        _firstName = firstName {
    _email = '${_firstName}.${_lastName}@${faker.company.name()}.com';
  }

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get userName => _userName;
  String get email => _email;
}
