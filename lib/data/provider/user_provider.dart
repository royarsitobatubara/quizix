import 'package:flutter/cupertino.dart';
import 'package:quizix/data/database/user_service.dart';
import 'package:quizix/data/user_preferences.dart';
import 'package:quizix/models/user_model.dart';
import 'package:quizix/utils/app_images.dart';

class UserProvider extends ChangeNotifier {

  // VARIABLE
  String _name = '';
  String _email = '';
  String _profile = '';
  String _rank = '';
  int _point = 0;
  List<UserModel> _userList = [];

  // GET DATA VARIABLE
  String get name => _name;
  String get profile => _profile;
  String get email => _email;
  String get rank => _rank;
  int get point => _point;
  List<UserModel> get userList => _userList;

  UserProvider(){
    loadAllData();
  }

  void loadAllData() async {
    final id = await UserPreferences.getIdUser();
    if(id == null){
      // user belum login → isi data default
      _name = "Guest";
      _email = "someone@example.com";
      _rank = "beginner";
      _point = 0;
      _profile = AppImages.defaultProfile;
      notifyListeners();
      return;
    }

    // kalau ada id, baru load
    loadUserList();
    loadProfile();
    loadName();
    loadPoint();
    loadRank();
    loadEmail();
  }


  // FUNCTION
  Future<void> loadUserList() async {
    try{
      final data = await UserService.getAllUser();
      _userList = data;
    }catch(e){
     _userList=[];
      debugPrint('Terjadi kesalahan pada loadUserList: $e');
    }
    notifyListeners();
  }

  Future<void> loadName() async {
    try {
      final savedUser = await UserService.getUserById();
      if (savedUser == null) {
        _name = "Guest";
      } else {
        _name = savedUser.name.isEmpty ? "Guest" : savedUser.name;
      }
    } catch (e) {
      debugPrint('Terjadi kesalahan pada loadName: $e');
      _name = 'Guest';
    }
    notifyListeners();
  }


  Future<void> loadPoint() async {
    try {
      final data = await UserService.getUserById();
      _point = data?.point ?? 0;
    } catch (e) {
      debugPrint('Terjadi kesalahan pada loadPoint: $e');
      _point = 0;
    }
    notifyListeners();
  }


  Future<void> loadEmail() async {
    try {
      final data = await UserService.getUserById();
      _email = (data == null || data.email.isEmpty)
          ? 'someone@example.com'
          : data.email;
    } catch (e) {
      debugPrint('Terjadi kesalahan pada loadEmail: $e');
      _email = 'someone@example.com';
    }
    notifyListeners();
  }


  Future<void> loadRank() async {
    try {
      final data = await UserService.getUserById();
      _rank = (data == null || data.rank.isEmpty)
          ? 'beginner'
          : data.rank;
    } catch (e) {
      debugPrint('Terjadi kesalahan pada loadRank: $e');
      _rank = 'beginner';
    }
    notifyListeners();
  }


  Future<void> loadProfile() async {
    try {
      final data = await UserService.getUserById();

      if (data == null) {
        debugPrint('Profile : $data');
        _profile = AppImages.defaultProfile;
      } else {
        debugPrint('Profile : $data');
        _profile = data.profile;
      }
      debugPrint('Profile : $data');
    } catch (e) {
      _profile = AppImages.defaultProfile;
    }
    notifyListeners();
  }



}