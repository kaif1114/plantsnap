import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  Future<List<Map<String, dynamic>>> getAllDocuments(
      String collectionName) async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection(collectionName).get();
      List<Map<String, dynamic>> docsData = [];

      
      querySnapshot.docs
          .forEach((doc) {
            docsData.add({
              ...doc.data() as Map<String, dynamic>,
              "docId": doc.id,
            });
            
          });
  
      return docsData;
    } catch (e) {
      print('Error fetching documents: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<void> createNewCollection(String collectionName) async {
    // Get a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a new document in the specified collection
    await firestore.collection(collectionName).doc("dummy").set({
      'created_at': FieldValue.serverTimestamp(),
      'sample_data': 'This is a new collection',
      'plantName': "dummy",
    });

    print('New collection "$collectionName" created with a document.');
  }

  Future<List<String>> getAllDocumentsIds(
      String collectionName) async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection(collectionName).get();
      return querySnapshot.docs
          .map((doc) => doc.id)
          .toList();
    } catch (e) {
      print('Error fetching documents: $e');
      return []; // Return an empty list in case of an error
    }
  }

  // Example: Add a new document to a collection
  Future<void> addDocument(String collectionName, Map<String, dynamic> data) async {
    try{
      await _firestore.collection(collectionName).add(data);
    }
    catch(error){
      print(error);
    }
  }

    Future<void> addNamedDocument(String collectionName, String documentName, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).doc(documentName).set(data);
      print('Document added successfully');
    } catch (error) {
      print('Failed to add document: $error');
    }
  }


  // Example: Update a document in a collection
  Future<void> updateDocument(String collectionName, String documentId,
      Map<String, dynamic> data) async {
    await _firestore.collection(collectionName).doc(documentId).update(data);
  }

  // Example: Delete a document from a collection
  Future<void> deleteDocument(String collectionName, String documentId) async {
    await _firestore.collection(collectionName).doc(documentId).delete();
  }


  Future<User?> SignUp(String email, String password)async {
    try{
      UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    catch(error){
      print(error);
    }
    
  }

  Future<User?> SignIn(String email, String password)async {
    try{
      UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    catch(error){
      print(error);
    }
  }
}
