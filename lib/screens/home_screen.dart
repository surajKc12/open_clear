import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_clear/constant.dart';
import 'package:open_clear/model/card.dart';
import 'package:open_clear/screens/card_preview_screen.dart';

import 'edit_card.dart';
import 'login_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MyCard> cards=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children:  [
            Align(
              alignment: Alignment.topRight,
                child: TextButton(onPressed: (){
                  FirebaseAuth.instance.signOut().then((value) {

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
                  });
                }, child: const Text('Logout'))),
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    height: 80.h,
                    child: Image.asset('assets/images/logo.png',height: 100,),
                  ),
                  Positioned(
                      right: 0,
                      top: 15.h,
                      child: Text("TM"))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.h),
              child: DottedBorder(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/addCardScreen');
                    },
                    child: Container(
                      color: Colors.blue.shade50,
                      padding: EdgeInsets.all(20.h),
                      alignment: Alignment.center,
                      child: const Text("+ Add a Card"),
                    ),
                  )),
            ),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection(Constant.CARDS_COLLECTION)
              .where(MyCard.CARD_OWNER_ID,isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
                builder: (context, snapshot) {
                cards.clear();
                  if(snapshot.hasData && snapshot.data!.docs.length>0)
                    {
                      MyCard card = MyCard();
                      for (var element in snapshot.data!.docs) {
                        Map map = element.data()as Map;
                        card = MyCard.fromJson(map,element.id);
                        if(!cards.contains(card)) {
                          cards.add(card);
                        }
                      }

                      return Expanded(
                        child: GridView.builder(
                          itemCount: cards.length,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 13.h),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0.h,
                            crossAxisSpacing: 10.0.w,
                            mainAxisExtent: 260,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  CardPreviewScreen(description: cards[index].cardDescription, imageUrl: cards[index].photoURL),));
                              },
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),

                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration:  BoxDecoration(
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                cards[index].photoURL,),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: const SizedBox(),
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    Text(cards[index].cardDescription),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children:  [
                                        IconButton(
                                          icon: const Icon(Icons.edit, color: Colors.green,),
                                          onPressed: () async {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditScreen(card: cards[index],),));
                                          }
                                          ,),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red,),
                                          onPressed: () async {
                                            await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                              await myTransaction.delete(snapshot.data!.docs[index].reference);
                                            });
                                            FirebaseStorage.instance.refFromURL(cards[index].photoURL).delete();

                                          }
                                          ,),

                                      ],),

                                    SizedBox(height: 30.h,),


                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );

                    }
                  if(!snapshot.hasData || snapshot.data!.docs.length<=0)
                    {
                      return const Center(child: Text("No Card Available"),);
                    }
                  return const Center(child: CircularProgressIndicator(),);
                },),




          ],
        ),
      ),
    );
  }
}
