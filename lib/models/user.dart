class SignedUser {
  final String uid;

  SignedUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sno;
  final String nic;
  final String mob;
  final String gpa;

  UserData({this.uid, this.name, this.sno, this.nic, this.mob, this.gpa});
}

class TimetableData {
  final String day;
  final String morning;
  final String evening;
  final String morningLecturer;
  final String eveningLecturer;
  TimetableData(
      {this.day,
        this.morning,
        this.evening,
        this.morningLecturer,
        this.eveningLecturer});
}
