import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_registration_app/database/images_db_sqlite.dart';
import 'package:flutter_registration_app/models/profile.dart';


class ImagesProvider with ChangeNotifier  {

  List<Profile> _profiles = [];

  late ImagesDB _imagesDB;
  final  Map<String, File?> _selectedImageFiles = {}; // if the code not work this part

  List<Profile> get profiles => _profiles;
   Map<String, File?> get selectedImageFiles => _selectedImageFiles; // if the code not work this part


ImagesProvider(){
  _imagesDB = ImagesDB();
  
}
  


Future<void> addNewRegistrationForm(Profile profile) async{

  await _imagesDB.insertProfile(profile);
  // _profiles = await ImagesDB().getProfiles();
  await fetchProfiles();
  notifyListeners();
   
}


Future<void> fetchProfiles() async {

_profiles = await _imagesDB.getProfiles();
 for (var profile in _profiles) {
      if (profile.imageRef != null && profile.imageRef!.isNotEmpty) {
        _selectedImageFiles[profile.firstName] = File(profile.imageRef!);
      } else {
        _selectedImageFiles[profile.firstName] = null;
      }
    }
notifyListeners();
  
}

  void setSelectedImageFile(String field, File? file) {
    _selectedImageFiles[field] = file;
    notifyListeners();

  } 




}





