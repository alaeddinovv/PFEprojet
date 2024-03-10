import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:meta/meta.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/error_model.dart';
import 'dart:convert' as convert;

import 'package:pfeprojet/Model/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
// ! data t3 UserModel
  DataJoueurModel? joueurDataModel;
  ErrorModel? errorGetMyInfoModel;

  void getMyInfo() {
    emit(GetMyInformationLoading());
    Httplar.httpget(path: GETMYINFORMATION).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        joueurDataModel = DataJoueurModel.fromJson(jsonResponse);
        emit(GetMyInformationStateGood(model: joueurDataModel!));
      } else if (value.statusCode == 401) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        errorGetMyInfoModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: errorGetMyInfoModel!));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetMyInformationStateBad());
    });
  }

  Future<void> updateJoueur(
      {required String nom,
      required String prenom,
      required String telephone,
      required String age,
      required String wilaya}) async {
    emit(UpdateJoueurLoadingState());

    if (imageCompress != null) {
      await updateProfileImg();
    }
    Map<String, dynamic> _model = {
      "nom": nom,
      "prenom": prenom,
      "telephone": telephone,
      "age": age,
      "wilaya": wilaya,
      if (linkProfileImg != null) "photo": linkProfileImg ?? ""
    };
    await Httplar.httpPut(path: UPDATEJOUEUR, data: _model).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        joueurDataModel = DataJoueurModel.fromJson(jsonResponse);

        print('badalt info user');
        print(joueurDataModel!.email);
        emit(UpdateJoueurStateGood());
      } else {
        print(value.body);
      }
    }).catchError((e) {
      print(e.toString());
      emit(UpdateJoueurStateBad());
    });
  }

  // !--------imagepicker with Compress
  // XFile? imageProfile;
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
        emit(ImagePickerProfileJoueurStateGood());
      });
    }).catchError((e) {
      emit(ImagePickerProfileJoueurStateBad());
    });
  }

  String? linkProfileImg;
  Future<void> updateProfileImg() async {
    await deleteOldImageFirebase();
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
        emit(UploadProfileJoueurImgAndGetUrlStateBad());
      });
    });
  }

  Future<void> deleteOldImageFirebase() async {
    if (joueurDataModel?.photo != '') {
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(joueurDataModel!.photo!)
          .delete()
          .then((_) {
        print('Old image deleted successfully');
      }).catchError((error) {
        print('Failed to delete old image: $error');
      });
    }
  }
}
