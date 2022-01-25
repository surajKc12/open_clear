class MyCard
{

  static const CARD_OWNER_ID = 'cardOwnerId';
  static const EMAIL = 'email';
  static const CARD_DESCRIPTION = 'cardDescription';
  static const PHOTO_URL = 'photoURL';
  static const PHOTO_FILENAME = 'photofilename';
  static const TIMESTAMP = 'timestamp';




  String? docId;
  late String cardOwnerId;
  late String cardDescription;
  late String email;
  late String photoFilename;
  late String photoURL;
  DateTime? timestamp;


  MyCard({
    this.docId,
    this.cardOwnerId = '',
    this.cardDescription = '',
    this.email = '',
    this.photoFilename = '',
    this.photoURL = '',
    this.timestamp,
  });



  Map<String, dynamic> toFirestoreDoc() {
    return {
      CARD_OWNER_ID: this.cardOwnerId,
      EMAIL: this.email,
      CARD_DESCRIPTION: this.cardDescription,
      PHOTO_URL: this.photoURL,
      PHOTO_FILENAME: this.photoFilename,
      TIMESTAMP: this.timestamp,

    };
  }


  factory MyCard.fromJson(Map<dynamic, dynamic> doc, String docId)
  {
    return MyCard(
      docId: docId,
      cardOwnerId: doc[CARD_OWNER_ID] ??= 'N/A',
      cardDescription: doc[CARD_DESCRIPTION] ??= 'N/A',
      email: doc[EMAIL] ??= 'N/A',
      photoURL: doc[PHOTO_URL] ??= 'N/A',
      photoFilename: doc[PHOTO_FILENAME] ??= [],
      timestamp: doc[TIMESTAMP] != null
          ? DateTime.fromMillisecondsSinceEpoch(
          doc[TIMESTAMP].millisecondsSinceEpoch)
          : DateTime.now(),
    );
  }
  MyCard.clone(MyCard p) {
    this.docId = p.docId;
    this.cardOwnerId = p.cardOwnerId;
    this.cardDescription = p.cardDescription;
    this.photoFilename = p.photoFilename;
    this.photoURL = p.photoURL;
    this.timestamp = p.timestamp;
  }

  void assign(MyCard p) {
    this.docId = p.docId;
    this.cardOwnerId = p.cardOwnerId;
    this.cardDescription = p.cardDescription;
    this.photoFilename = p.photoFilename;
    this.photoURL = p.photoURL;
    this.timestamp = p.timestamp;
  }
  static MyCard? fromFirestoreDoc(
      {required Map<String, dynamic> doc, required String docId}) {
    for (var key in doc.keys) {
      if (doc[key] == null) return null;
    }
    return MyCard(
      docId: docId,
      cardOwnerId: doc[CARD_OWNER_ID] ??= 'N/A',
      cardDescription: doc[CARD_DESCRIPTION] ??= 'N/A',
      email: doc[EMAIL] ??= 'N/A',
      photoURL: doc[PHOTO_URL] ??= 'N/A',
      photoFilename: doc[PHOTO_FILENAME] ??= [],
      timestamp: doc[TIMESTAMP] != null
          ? DateTime.fromMillisecondsSinceEpoch(
          doc[TIMESTAMP].millisecondsSinceEpoch)
          : DateTime.now(),
    );
  }



}