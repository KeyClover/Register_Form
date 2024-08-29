// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_registration_app/models/profile.dart';
import 'package:flutter_registration_app/pages/registration_list.dart';
import 'package:flutter_registration_app/provider/images_provider.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:circular_menu/circular_menu.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final Profile _profile = Profile(
      firstName: 'firstName',
      lastName: 'lastName',
      email: 'email',
      imageRef: 'null');

  void getImage(BuildContext context, String field) async {
    final ImagePicker _picker =
        ImagePicker(); // if code is not working comment this
    final selectedFile = await _picker.pickImage(source: ImageSource.camera);

    if (selectedFile == null) return;

    final imageFile = File(selectedFile.path);
    Provider.of<ImagesProvider>(context, listen: false)
        .setSelectedImageFile(field, imageFile);
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider =
        Provider.of<ImagesProvider>(context); //comment this if not working

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrationListPage()),
                );
              },
            ),
            const SizedBox(width: 8),
            const Text('Registration',
                style: TextStyle(color: Colors.black, fontSize: 24)),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('First Name'),
                TextFormField(
                  validator: RequiredValidator(
                          errorText: 'Please enter your firstname ')
                      .call,
                  onSaved: (String? firstName) {
                    _profile.firstName = firstName.toString();
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('Last Name'),
                TextFormField(
                  validator:
                      RequiredValidator(errorText: 'Please enter your lastname')
                          .call,
                  onSaved: (String? lastName) {
                    _profile.lastName = lastName.toString();
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('Email'),
                TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Please put your email.'),
                    EmailValidator(
                        errorText: 'Not correct email please try again.'),
                  ]).call,
                  onSaved: (String? email) {
                    _profile.email = email.toString();
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('Picture'),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        getImage(
                            context, 'profilePicture'); //get the context out
                      },
                      child: imageProvider
                                  .selectedImageFiles['profilePicture'] !=
                              null // if error change this to _selectedImageFile!
                          ? Image.file(imageProvider.selectedImageFiles[
                              'profilePicture']!) // if error change this to _selectedImageFile!
                          : const SizedBox(
                              height: 150,
                              child: Center(
                                child: Icon(Icons.camera_alt),
                              )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('ID Card Picture'),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        getImage(context, 'idCardPicture');
                      },
                      child:
                          imageProvider.selectedImageFiles['idCardPicture'] !=
                                  null
                              ? Image.file(imageProvider
                                  .selectedImageFiles['idCardPicture']!)
                              : const SizedBox(
                                  height: 150,
                                  child: Center(
                                    child: Icon(Icons.camera_alt),
                                  ),
                                ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final profileImage =
                            imageProvider.selectedImageFiles['profilePicture'];
                        final idCardImage =
                            imageProvider.selectedImageFiles['idCardPicture'];

                        final profile = Profile(
                          firstName: _profile.firstName,
                          lastName: _profile.lastName,
                          email: _profile.email,
                          imageRef: profileImage?.path,
                        );

                        await Provider.of<ImagesProvider>(context,
                                listen: false)
                            .addNewRegistrationForm(profile);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile Saved!')),
                        );
                      }
                    },
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: CircularMenu(
        alignment: Alignment.bottomRight,
        toggleButtonColor: Colors.blue,
        items: [
          CircularMenuItem(
            icon: Icons.accessibility,
            color: Colors.red,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationListPage()),
            ),
          ),
          CircularMenuItem(
            icon: Icons.brush,
            color: Colors.blue,
            onTap: () => print('Second Button'),
          ),
          CircularMenuItem(
            icon: Icons.keyboard_voice,
            color: Colors.green,
            onTap: () => print('Third Button'),
          ),
        ],
      ),
    );
  }
}
