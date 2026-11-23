import "package:cloud_firestore/cloud_firestore.dart";
class DatabaseMethods{

  Future addUserDetails(Map<String,dynamic>userInfoMap,String id)async{
    return await FirebaseFirestore.instance
    .collection("users")
    .doc(id)
    .set(userInfoMap);
  }


  Future addAllProducts(Map<String,dynamic>userInfoMap)async{
    return await FirebaseFirestore.instance
    .collection("Products")
    .add(userInfoMap);
  }


  Future addProduct(Map<String,dynamic>userInfoMap,String categoryname)async{
      userInfoMap["Category"] = categoryname;
    return await FirebaseFirestore.instance
    .collection(categoryname)
    .add(userInfoMap);
  }
  Stream<QuerySnapshot>getProducts(String category){
    return FirebaseFirestore.instance.collection(category).snapshots();

  } 
  Future<Stream<QuerySnapshot>> getOrders(String email) async {
  return FirebaseFirestore.instance
      .collection("Orders")
      .where("Email", isEqualTo: email)
      .snapshots();
}
Stream<QuerySnapshot> getAllOrders() {
  return FirebaseFirestore.instance.collection("Orders").snapshots();
}

Future<void> updateOrderStatus(String docId, String status) async {
  await FirebaseFirestore.instance
      .collection("Orders")
      .doc(docId)
      .update({"Status": status});
}
  Future orderDetails(Map<String,dynamic>userInfoMap)async{
    return await FirebaseFirestore.instance
    .collection("Orders")
    .add(userInfoMap);
  }
 Stream<QuerySnapshot> getAllProductsStream() {
  return FirebaseFirestore.instance.collection("Products").snapshots();
}

Future<QuerySnapshot> search(String firstLetter) async {
  return await FirebaseFirestore.instance
      .collection("Products")
      .where("Searchkey", isEqualTo: firstLetter.substring(0, 1).toUpperCase())
      .get();
}

Future<void> updateUserImage(String id, String imageUrl) async {
  await FirebaseFirestore.instance
      .collection("users")
      .doc(id)
      .set({"Image": imageUrl}, SetOptions(merge: true));
}
}