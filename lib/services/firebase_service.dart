import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mbap_project_app/models/item.dart';
import 'package:mbap_project_app/models/recipe.dart';
import 'package:mbap_project_app/models/user.dart';
import 'package:path/path.dart'; 

class FirebaseService {

  //mapping the category images with the category name
  Map<String, String>categoryImagePath = {
    'Meat':'images/meat.png',
    'Cooked':'images/cooked.png',
    'Fruits' : 'images/fruits.png',
    'Canned':'images/canned.png',
    'Drinks' : 'images/drinks.png',
    'Vegetables' : 'images/vegetables.png',
    'Frozen' : 'images/frozen.png',
    'Ingredients' : 'images/ingredients.png'
  };

  //adding item 
  Future<void> addItem(String description, String selectedCategory, int reminder, DateTime bestBefore) async{
    String imagePath = categoryImagePath[selectedCategory]??'';
    await FirebaseFirestore.instance.collection('items').add({
      'userid': getCurrentUser()!.uid, 
      'email': getCurrentUser()!.email,
      'description': description,
      'reminder': reminder,
      'bestBefore': Timestamp.fromDate(bestBefore),
      'category': selectedCategory,
      'createdDate': Timestamp.fromDate(DateTime.now()),
      'imagePath': imagePath
    });

  }

  //get item 
  Stream<List<Item>> getItems({DateTime? date, String? category}) {
    Query query = FirebaseFirestore.instance.collection('items');
    
    //for sorting with category
    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }

    //for calendar usage, passing the expiry date in
    if(date != null){
      DateTime startOfDay = DateTime(date.year, date.month, date.day);
      DateTime endOfDay = startOfDay.add(Duration(days: 1));
      query = query.where('bestBefore', isGreaterThanOrEqualTo: startOfDay).where('bestBefore', isLessThan: endOfDay);
    }
    return query.where('email', isEqualTo: getCurrentUser()!.email).orderBy('createdDate', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return Item(
          id: doc.id,
          description: data['description'] ?? '',
          category: data['category'] ?? '',
          bestBeforeDate: (data['bestBefore'] as Timestamp?)?.toDate().toString() ?? '',
          createdDate: (data['createdDate'] as Timestamp?)?.toDate().toString() ?? '',
          imagePath: data['imagePath'] ?? '',
          reminder: data['reminder'] ?? 0,
        );
      }).toList();
    });
  }

  //sort item by category name
  Stream<List<Item>> getItemsByCategory(String category){
    return getItems(category: category);
  }

  Stream<List<Item>> getItemsByExpiry (DateTime date){
    return getItems(date: date);
  }

  //update item
  Future <void> updateItem (String id, String category, String description, DateTime bestBefore, int reminder){
    String imagePath = categoryImagePath[category]??'';
    return FirebaseFirestore.instance.collection('items').doc(id).update({'category': category, 'description': description, 'bestBefore':  bestBefore, 'reminder': reminder,'imagePath': imagePath});
  }

  //delete item 
  Future<void>deleteItem(String id){
    return FirebaseFirestore.instance.collection('items').doc(id).delete();
  }

  //add recipe
  Future<void> addRecipe(String title, String description, String recipe, String foodImagePath) async{
    await FirebaseFirestore.instance.collection('recipes').add({
      'uid': getCurrentUser()!.uid,
      'email': getCurrentUser()!.email,
      'title': title,
      'description': description,
      'recipe': recipe,
      'createdDate': Timestamp.fromDate(DateTime.now()),
      'foodImagePath': foodImagePath
    });
  }

  //get recipe
  Stream<List<Recipe>> getRecipes() {
    Query query = FirebaseFirestore.instance.collection('recipes');
    return query.where('email', isEqualTo: getCurrentUser()!.email).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return Recipe(
          id: doc.id,
          FoodImagePath: data['foodImagePath']?? '', 
          Title: data['title']?? '', 
          RecipeDetail: data['recipe']?? '', 
          Description: data ['description']?? '', 
          Timestamp:(data['createdDate'] as Timestamp ?)?.toDate().toString() ?? ''); 
      }).toList();
    });
  }

  //update recipe
  Future <void> updateRecipe (String id, String title, String description, String recipe, String foodImagePath){
    return FirebaseFirestore.instance.collection('recipes').doc(id).update({'title': title, 'description': description, 'recipe': recipe, 'foodImagePath': foodImagePath});
  }

  //delete recipe
  Future<void>deleteRecipe(String id){
    return FirebaseFirestore.instance.collection('recipes').doc(id).delete();
  }

  //add recipe photo
  Future<String?> addRecipePhoto(File recipePhoto) {
    return FirebaseStorage.instance.ref().child   (DateTime.now().toString() + '_' +
    basename(recipePhoto.path)).
    putFile(recipePhoto).then((task) {
      return task.ref.getDownloadURL().then((imageUrl) {
        return imageUrl;
      });
    });
  }


  //register user
  Future<UserCredential> register(email, password){
    return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }

  //Login user
  Future<UserCredential> login(email, password){
    return FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  //Forgot password
  Future<void> forgotPassword(email){
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Stream<User?> getAuthUser(){
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<void> logOut()async{
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  //adding user details
  Future<void> addUser(String uid, String email, String username, {String? profilePic}){
    return FirebaseFirestore.instance.collection('users').doc(uid).set({'username': username, 'profilePic' : profilePic ?? '', 'email': email});
  }

  //getting current user
  User? getCurrentUser(){
    return FirebaseAuth.instance.currentUser;
  }

  //signing in with google
  Future<UserCredential>signInWithGoogle() async{
    final GoogleSignInAccount ? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential;
  }

  //to check if the email is in the users database
  Future <bool> userExists(User user)async{
    String email = user.email!;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(email).get();
    return userDoc.exists;
  }

  //getting user info 
  Stream<FirestoreUser> getAuthUserFromFirestore(){
    return FirebaseFirestore.instance.collection('users')
      .doc(getCurrentUser()!.uid)
      .snapshots()
      .map<FirestoreUser>((doc) => FirestoreUser(
        uid: doc.id,
        username: doc.data()!['username']?? '', 
        profilePic: doc.data()!['profilePic']??'', 
        email: doc.data()!['email']?? ''));
  }
}
