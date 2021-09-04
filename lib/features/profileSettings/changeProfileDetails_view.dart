import 'dart:io';

import 'package:flutter/material.dart';

import 'changeProfileDetails_view_model.dart';

class ProfileSettingsView extends ProfileSettingViewModel {
  @override
  Widget build(BuildContext context) {
    return this.username == null && this.ppUrl == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Change Profile Details',
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Choose Option'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Divider(
                                  height: 1,
                                  color: Colors.blue,
                                ),
                                ListTile(
                                  onTap: () {
                                    openGallery(context);
                                  },
                                  title: Text("Gallery"),
                                  leading: Icon(
                                    Icons.account_box,
                                    color: Colors.blue,
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: Colors.blue,
                                ),
                                ListTile(
                                  onTap: () {
                                    openCamera(context);
                                  },
                                  title: Text("Camera"),
                                  leading: Icon(
                                    Icons.camera,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: imageFile == null
                            ? NetworkImage('${this.ppUrl}')
                            : FileImage(File(imageFile.path)),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    TextField(
                      controller: usernameController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          color: Colors.white,
                        ),
                        hintText: 'Old Username: ${this.username}',
                        labelText: 'Enter new Username',
                        prefixText: ' ',
                        hintStyle: TextStyle(color: Colors.white),
                        focusColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    Container(
                      width: 100.0,
                      height: 60.0,
                      child: OutlinedButton(
                        onPressed: () async {
                          changeDetails(usernameController.text, imageFile);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
