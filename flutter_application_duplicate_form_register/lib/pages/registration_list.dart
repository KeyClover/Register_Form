import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:flutter_registration_app/models/profile.dart';
import 'package:flutter_registration_app/provider/images_provider.dart';

class RegistrationListPage extends StatefulWidget {
  RegistrationListPage({super.key});

  @override
  _RegistrationListPageState createState() => _RegistrationListPageState();
}

class _RegistrationListPageState extends State<RegistrationListPage> {
  @override
  void initState() {
    super.initState();
    // Fetch profiles when the page is initialized
    Provider.of<ImagesProvider>(context, listen: false).fetchProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registered Profiles'),
        backgroundColor: Colors.blue[300],
      ),
      
      body: Consumer<ImagesProvider>(
          builder:
              (BuildContext context, ImagesProvider provider, Widget? child) {
            return FutureBuilder(
              future: provider.fetchProfiles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: provider.profiles.length,
                    itemBuilder: (context, index) {
                      Profile profile = provider.profiles[index];
                      return Card(
                        shadowColor: Colors.blue[500],
                        child: ListTile(
                          leading: profile.imageRef != null && profile.imageRef!.isEmpty
                              ? Image.file(File(profile.imageRef!))
                              : const Icon(Icons.person),
                          title:
                              Text('${profile.firstName} ${profile.lastName}'),
                          subtitle: Text(profile.email),
                        ),
                      );
                    },
                  );
                }
              },
            );
          },
          ),
          
    );
  }
}
