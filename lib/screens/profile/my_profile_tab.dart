import 'package:college_cupid/models/user_info.dart';
import 'package:college_cupid/screens/profile/edit_profile.dart';
import 'package:college_cupid/stores/login_store.dart';
import 'package:college_cupid/widgets/profile/view_interests_grid.dart';
import 'package:flutter/material.dart';
import '../../shared/colors.dart';

class MyProfileTab extends StatefulWidget {
  const MyProfileTab({super.key});

  @override
  State<MyProfileTab> createState() => _MyProfileTabState();
}

class _MyProfileTabState extends State<MyProfileTab> {
  bool readMore = true;
  final userInfo = UserInfo.fromJson(LoginStore.userData);

  Widget aboutMe(var h) {
    print(userInfo.profilePicUrl);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(userInfo.profilePicUrl), fit: BoxFit.cover)),
      child: Column(
        children: [
          SizedBox(
            height: h / 2,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: CupidColors.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userInfo.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        userInfo.email,
                        textAlign: TextAlign.left,
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        '${userInfo.program}, ${userInfo.yearOfStudy.toLowerCase()}',
                        textAlign: TextAlign.right,
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
                const Text(
                  'About',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.left,
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
                SizedBox(
                  height: readMore ? 33 : null,
                  child: Text(userInfo.bio, overflow: TextOverflow.clip),
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
                GestureDetector(
                  child: Text(
                    !readMore ? "Show less" : "Read more",
                    style: const TextStyle(color: CupidColors.navBarIconColor),
                    textAlign: TextAlign.left,
                  ),
                  onTap: () {
                    setState(() {
                      readMore = !readMore;
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
                if (userInfo.interests.isNotEmpty)
                  ViewInterestsGrid(interests: userInfo.interests)
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var safeArea = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EditProfile()));
        },
        backgroundColor: CupidColors.pinkColor,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      backgroundColor: CupidColors.backgroundColor,
      body: SingleChildScrollView(
        child: aboutMe(safeArea.height),
      ),
    );
  }
}