import 'dart:io';

import 'package:authentication/model/user_model.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controller/edit_profile_controller.dart';
import 'widgets.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<EditProfileController>(context, listen: false);
    data.displayName();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 192, 119),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 216, 192, 119),
        elevation: 1,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: FutureBuilder<UserModel?>(
            future: EditProfileController.readUser(),
            builder: (context, snapshot) {
              return Consumer(
                builder: (context, EditProfileController value, child) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    value.nameController.text = snapshot.data!.name;
                    value.ageController.text = snapshot.data!.age;
                  }

                  return ListView(
                    children: [
                      const Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            value.img == null
                                ? value.downloadUrl != null
                                    ? Container(
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 4,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  value.downloadUrl!)),
                                        ),
                                      )
                                    : Container(
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 4,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor),
                                            shape: BoxShape.circle,
                                            image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png"),
                                            )),
                                      )
                                : Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              FileImage(File(value.img!.path)),
                                        )),
                                  ),
                            IconButton(
                                onPressed: (() {
                                  data.getImage();
                                }),
                                icon: const Icon(Icons.camera))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextField(
                        readOnly: false,
                        controller: data.nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          hintText: 'Input Name',
                        ),
                        // controller: displayNameController,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        readOnly: false,
                        controller: data.ageController,
                        decoration: const InputDecoration(
                          labelText: "Age",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          hintText: 'Input Age',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Button(
                            text: 'CANCEL',
                            function: (() => Navigator.pop(context)),
                          ),
                          Button(
                            text: 'SAVE',
                            function: () async {
                              EditProfileController.createUser(
                                name: data.nameController.text,
                                age: data.ageController.text,
                              );
                              await data.uploadImage(
                                context,
                              );
                            },
                          )
                        ],
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
