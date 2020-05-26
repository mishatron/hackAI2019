import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackai/src/data/local/preference_manager.dart';
import 'package:hackai/src/data/repositories/auth_repository.dart';
import 'package:hackai/src/domain/ClientModel.dart';

class AuthRepositoryImpl extends AuthRepository {

  AuthRepositoryImpl() {}

  var _auth = FirebaseAuth.instance;

  @override
  Future<bool> getIsFirstLaunch() async {
    return PreferenceManager().getIsFirstLaunch();
  }

  @override
  Future<bool> setIsSecondLaunch() async {
    return PreferenceManager().setFirstLaunch(false);
  }

  Future<void> createUser(ClientModel model) async {
    final user = await _auth.currentUser();
    final isExists =
        (await Firestore.instance.collection('users').document(user.uid).get())
            .exists;
    if (!isExists) {
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .setData(model.toJson(), merge: true);
    }
  }

  Future<ClientModel> getUser() async {
    var user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot ds =
        await Firestore.instance.collection('users').document(user.uid).get();
    return ClientModel.fromJson(ds.data);
  }
}
