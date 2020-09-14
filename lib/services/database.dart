import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seapp/models/feed.dart';
import 'package:seapp/models/module.dart';
import 'package:seapp/models/student.dart';
import 'package:seapp/models/user.dart';

class DatabaseService {

  final String uid;
  final String day;

  DatabaseService({ this.uid, this.day});

  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection('users');
  final CollectionReference timetableCollection = FirebaseFirestore.instance
      .collection('timtable');
  final CollectionReference feedCollection = FirebaseFirestore.instance
      .collection('feeds');

  Future updateUserData(String name, String sno, String nic, String mob,
      String gpa) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'sno': sno,
      'nic': nic,
      'mob': mob,
      'gpa': gpa,
    });
  }

  // user list from snapshot
  List<Student> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Student(
        name: doc.data()['name'] ?? '',
        sno: doc.data()['sno'] ?? '',
        nic: doc.data()['nic'] ?? '',
        mob: doc.data()['mob'] ?? '',
        gpa: doc.data()['gpa'] ?? '',
      );
    }).toList();
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      sno: snapshot.data()['sno'],
      nic: snapshot.data()['nic'],
      mob: snapshot.data()['mob'],
      gpa: snapshot.data()['gpa'],

    );
  }

  // get users stream
  Stream<List<Student>> get users {
    return userCollection.orderBy("sno").snapshots()
        .map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  // timetable list from snapshot
  List<Module> _moduleListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Module(
        morning: doc.data()['1'] ?? '',
        evening: doc.data()['2'] ?? '',
      );
    }).toList();
  }
  
  //timetableData from snapshot
  TimetableData _timetableDataFromSnapshot(DocumentSnapshot snapshot) {
    return TimetableData(
      day: day,
      morning: snapshot.data()['1'],
      evening: snapshot.data()['2'],
      morningLecturer: snapshot.data()['3'],
      eveningLecturer: snapshot.data()['4'],
    );
  }

  // get timetable stream
  Stream<List<Module>> get timetable {
    return timetableCollection.snapshots()
        .map(_moduleListFromSnapshot);
  }

  // get timetable doc stream
  Stream<TimetableData> get timetableData {
    return timetableCollection.doc(day).snapshots()
        .map(_timetableDataFromSnapshot);
  }

  // feed list from snapshot
  List<Feed> _feedListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Feed(
        by: doc.data()['by'] ?? '',
        desc: doc.data()['desc'] ?? '',
        title: doc.data()['title'] ?? '',
      );
    }).toList();
  }

  // get feeds stream
  Stream<List<Feed>> get feeds {
    return feedCollection.snapshots()
        .map(_feedListFromSnapshot);
  }

}