import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'dart:convert' as convert;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:pfeprojet/Model/admin_medel.dart';
import 'package:pfeprojet/Model/error_model.dart';

part 'profile_admin_state.dart';

class ProfileAdminCubit extends Cubit<ProfileAdminState> {
  // final DataAdminModel homeAdminCubit;

  ProfileAdminCubit() : super(ProfileAdminInitial());

  static ProfileAdminCubit get(context) => BlocProvider.of(context);

  Future<void> updateAdmin(
      {required String nom,
      required String prenom,
      required String telephone,
      required String wilaya,
      String? deleteOldImage}) async {
    emit(UpdateAdminLoadingState());

    if (imageCompress != null) {
      await updateProfileImg(deleteOldImage: deleteOldImage);
    }
    Map<String, dynamic> _model = {
      "nom": nom,
      "prenom": prenom,
      "telephone": telephone,
      "wilaya": wilaya,
      if (linkProfileImg != null) "photo": linkProfileImg
    };
    await Httplar.httpPut(path: UPDATEADMIN, data: _model).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(UpdateAdminStateGood(
            dataAdminModel: DataAdminModel.fromJson(jsonResponse)));
      } else {
        // print(value.body);
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(UpdateAdminStateBad());
    });
  }

  // !--------imagepicker with Compress
  File? imageCompress;

  Future<void> imagePickerProfile(ImageSource source) async {
    final ImagePicker _pickerProfile = ImagePicker();
    await _pickerProfile.pickImage(source: source).then((value) async {
      // imageProfile = value;
      await FlutterImageCompress.compressAndGetFile(
        File(value!.path).absolute.path,
        '${File(value.path).path}.jpg',
        quality: 10,
      ).then((value) {
        imageCompress = File(value!.path);
        emit(ImagePickerProfileAdminStateGood());
      });
    }).catchError((e) {
      emit(ImagePickerProfileAdminStateBad());
    });
  }

  String? linkProfileImg;

  Future<void> updateProfileImg({required String? deleteOldImage}) async {
    await deleteOldImageFirebase(deleteOldImage: deleteOldImage);
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageCompress!.path).pathSegments.last}')
        .putFile(imageCompress!)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        linkProfileImg = value;
        print(linkProfileImg);
        // emit(UploadProfileImgAndGetUrlStateGood());  //! bah matro7ch  LodingUpdateUserStateGood() t3 Widget LinearProgressIndicator
      }).catchError((e) {
        print(e.toString());
        emit(UploadProfileAdminImgAndGetUrlStateBad());
      });
    });
  }

  Future<void> deleteOldImageFirebase({required String? deleteOldImage}) async {
    if (deleteOldImage != null) {
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(deleteOldImage)
          .delete()
          .then((_) {
        print('Old image deleted successfully');
      }).catchError((error) {
        print('Failed to delete old image: $error');
      });
    }
  }

//--------------------------modifier mot de passe-----------------------------------------

  // void checknewpassword({required new1,required new2}) {
  //  if(new1!=new2) {
  //    emit(NewPasswordWrong());
  //
  //  }else {
  //    emit(NewPasswordCorrect());
  //  }
  // }

  Future<void> updateMdpAdmin({
    required String old,
    required String newPassword,
  }) async {
    emit(UpdateMdpAdminLoadingState());

    Map<String, dynamic> _model = {
      "oldPassword": old,
      "newPassword": newPassword,
    };
    await Httplar.httpPut(path: UPDATEMDPADMIN, data: _model).then((value) {
      if (value.statusCode == 200) {
        emit(UpdateMdpAdminStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(UpdateMdpAdminStateBad());
    });
  }

  Map<String, bool> isHidden = {
    "pass": true,
    "pass1": true,
    "pass2": true,
  };
  void togglePasswordVisibility(String fieldKey) {
    isHidden[fieldKey] = !isHidden[fieldKey]!;
    emit(PasswordVisibilityChanged());
  }
}
