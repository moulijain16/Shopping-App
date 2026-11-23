import "package:flutter/material.dart";
import 'dart:typed_data';
import "package:shoppingapp/main.dart";
import "package:shoppingapp/pages/onboarding.dart";

import "package:firebase_auth/firebase_auth.dart";
import "package:shoppingapp/services/auth.dart";
import 'dart:convert';
import "package:shoppingapp/services/shared_pref.dart";
import "package:random_string/random_string.dart";
import 'package:http/http.dart' as http;
import "package:firebase_storage/firebase_storage.dart";
import "package:shoppingapp/services/database.dart";
import "package:shoppingapp/widget/support_widget.dart";
import "package:image_picker/image_picker.dart";
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  TextEditingController namecontroller = TextEditingController();
  String? name,email,image,value;
   final ImagePicker _picker=ImagePicker();
  Uint8List? selectedImage;
  // getthesharedpref()async{
  //   image=await SharedPreferenceHelper.userImagekey;
  //   name=await SharedPreferenceHelper.userNamekey;
  //   email=await SharedPreferenceHelper.userEmailkey;
  //   setState(() {
      
  //   });
  // }

  getthesharedpref() async {
  image = await SharedPreferenceHelper().getUserImage();
  name = await SharedPreferenceHelper().getUserName();
  email = await SharedPreferenceHelper().getUserEmail();
  setState(() {});
}

  @override
  void initState(){
    getthesharedpref();
    super.initState();
  }

  Future getImage() async {
  var image = await _picker.pickImage(
   
    source: ImageSource.gallery,
  );

  if (image != null) {
    selectedImage = await image.readAsBytes();
     await uploadItem();
    setState(() {});
  }
}



  
bool uploading = false;

uploadItem() async {
  final XFile? pickedFile = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );
  if (pickedFile == null) return;

  selectedImage = await pickedFile.readAsBytes();
  setState(() => uploading = true);

  try {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.cloudinary.com/v1_1/r6gnz2pv/image/upload"),
    )
      ..fields["upload_preset"] = "shoppingapp_unsigned"
      ..fields["public_id"] =
          "profile_${DateTime.now().millisecondsSinceEpoch}" // always a new link
      ..files.add(http.MultipartFile.fromBytes(
        "file",
        selectedImage!,
        filename: pickedFile.name,
      ));

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception("Upload failed: $body");
    }

    final url = jsonDecode(body)["secure_url"] as String;

    await SharedPreferenceHelper().saveUserImage(url);

    final userId = await SharedPreferenceHelper().getUserId();
    if (userId != null) {
      await DatabaseMethods().updateUserImage(userId, url);
    }

    image = url;
    if (!mounted) return;
    setState(() => uploading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile image saved")),
    );
  } catch (e) {
    debugPrint("Profile image error: $e");
    if (!mounted) return;
    setState(() => uploading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Image not saved: $e")),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        centerTitle: true,
        title: Text(
          "Profile",
          style: AppWidget.boldTextFeildStyle(),
        ),
      ),
        backgroundColor: Color(0xfff2f2f2),
      body:
      name==null? Center(child: CircularProgressIndicator()):
      Container(
        child:Center(
          child: Column(
            children: [
           GestureDetector(
  onTap: uploadItem,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(60),
    child: selectedImage != null
        ? Image.memory(selectedImage!,
            height: 150.0, width: 150.0, fit: BoxFit.cover)
        : (image != null && image!.isNotEmpty)
            ? Image.network(image!,
                height: 150.0, width: 150.0, fit: BoxFit.cover)
            :Container(
                height: 150,
                width: 150,
                color: Colors.grey.shade300,
                child: Icon(Icons.person, size: 90, color: Colors.white),
              ),
  ),
),
SizedBox(height:20),
Container(
  margin: EdgeInsets.only(left:20.0,right:20.0),
  child: Material(
    elevation:3.0,
    borderRadius:BorderRadius.circular(10),
    child: Container(
      padding:EdgeInsets.only(left:10.0,right:10.0,top:10.0,bottom:10.0),
      width:MediaQuery.of(context).size.width,
    decoration:BoxDecoration(color:Colors.white,),
    child:Row(children: [
      Icon(Icons.person_outline,size:35.0),
      SizedBox(width:10.0),
        Column(
      children:[
        Text("Name",style:AppWidget.lightTextFeildStyle()),
        Text(name!,style:AppWidget.semiboldTextFeildStyle()),]
    )],)),
  ),
),
SizedBox(height:20),
Container(
  margin: EdgeInsets.only(left:20.0,right:20.0),
  child: Material(
    elevation:3.0,
    borderRadius:BorderRadius.circular(10),
    child: Container(
      padding:EdgeInsets.only(left:10.0,right:10.0,top:10.0,bottom:10.0),
      width:MediaQuery.of(context).size.width,
    decoration:BoxDecoration(color:Colors.white,),
    child:Row(children: [
      Icon(Icons.mail_outline,size:35.0),
      SizedBox(width:10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Text("Email",style:AppWidget.lightTextFeildStyle()),
        Text(email!,style:AppWidget.semiboldTextFeildStyle()),]
    )],)),
  ),
),
SizedBox(height:20),

GestureDetector(
 onTap: () async {
  await AuthMethods().SignOut();

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Onboarding()),
  );
},
  child: Container(
    margin: EdgeInsets.only(left:20.0,right:20.0),
    child: Material(
      elevation:3.0,
      borderRadius:BorderRadius.circular(10),
      child: Container(
        padding:EdgeInsets.only(left:10.0,right:10.0,top:10.0,bottom:10.0),
        width:MediaQuery.of(context).size.width,
      decoration:BoxDecoration(color:Colors.white,),
      child:Row(children: [
        Icon(Icons.logout_outlined,size:35.0),
        SizedBox(width:10.0),
          Text("Logout",style:AppWidget.semiboldTextFeildStyle()),
          Spacer(),
          Icon(Icons.arrow_forward_ios_outlined),],)),
    ),
  ),
),
SizedBox(height:20),
GestureDetector(
  onTap:()async{
  await AuthMethods().deleteuser().then((value){
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Onboarding()));
  });
  },
  child: Container(
    margin: EdgeInsets.only(left:20.0,right:20.0),
    child: Material(
      elevation:3.0,
      borderRadius:BorderRadius.circular(10),
      child: Container(
        padding:EdgeInsets.only(left:10.0,right:10.0,top:10.0,bottom:10.0),
        width:MediaQuery.of(context).size.width,
      decoration:BoxDecoration(color:Colors.white,),
      child:Row(children: [
        Icon(Icons.delete_outline,size:35.0),
        SizedBox(width:10.0),
          Text("Delete Account",style:AppWidget.semiboldTextFeildStyle()),
          Spacer(),
          Icon(Icons.arrow_forward_ios_outlined),],)),
    ),
  ),
)
            ],
          ),
        )
      )
    );
  }
}


