import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class SubscriptionService {
  static subscribeToUserAccount(authenticatedUserId, otherUserId) {
    firestore.collection('Users').doc(authenticatedUserId).update({
      'subscription': FieldValue.arrayUnion([otherUserId])
    });

    return firestore.collection('Users').doc(otherUserId).update({
      'subscriber': FieldValue.arrayUnion([authenticatedUserId])
    });
  }

  static unsubscribeToUserAccount(authenticatedUserId, otherUserId) {
    firestore.collection('Users').doc(authenticatedUserId).update({
      'subscription': FieldValue.arrayRemove([otherUserId])
    });

    return firestore.collection('Users').doc(otherUserId).update({
      'subscriber': FieldValue.arrayRemove([authenticatedUserId])
    });
  }
}
