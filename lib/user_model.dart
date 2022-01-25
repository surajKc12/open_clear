class Person
{

  static const EMAIL = 'email';
  static const TIMESTAMP = 'timestamp';
  static const PASSWORD = 'password';



  String? docId;
  late String userId;
  late String email;
  DateTime? timestamp;
  String? password;


  Person({
    this.docId,
    this.userId = '',
    this.email = '',
    this.timestamp,
    this.password='',

  });



  Map<String, dynamic> toFirestoreDoc() {
    return {
      EMAIL: this.email,
      TIMESTAMP: this.timestamp,
      PASSWORD: this.password,

    };
  }


  factory Person.fromJson(Map<dynamic, dynamic> doc, String docId)
  {
    return Person(
      docId: docId,
      email: doc[EMAIL] ??= 'N/A',
      password: doc[PASSWORD] ??= [],
      timestamp: doc[TIMESTAMP] != null
          ? DateTime.fromMillisecondsSinceEpoch(
          doc[TIMESTAMP].millisecondsSinceEpoch)
          : DateTime.now(),
    );
  }

  static Person? fromFirestoreDoc(
      {required Map<String, dynamic> doc, required String docId}) {
    for (var key in doc.keys) {
      if (doc[key] == null) return null;
    }
    return Person(
      docId: docId,
      email: doc[EMAIL] ??= 'N/A',
      password: doc[PASSWORD] ??= [],
      timestamp: doc[TIMESTAMP] != null
          ? DateTime.fromMillisecondsSinceEpoch(
          doc[TIMESTAMP].millisecondsSinceEpoch)
          : DateTime.now(),
    );
  }



}