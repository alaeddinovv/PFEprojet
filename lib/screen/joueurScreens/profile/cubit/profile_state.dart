part of 'profile_cubit.dart';

@immutable
sealed class ProfileJoueurState {}

final class ProfileJoueurInitial extends ProfileJoueurState {}

final class UpdateJoueurLoadingState extends ProfileJoueurState {}

final class UpdateJoueurStateGood extends ProfileJoueurState {
  final DataJoueurModel dataJoueurModel;

  UpdateJoueurStateGood({required this.dataJoueurModel});
}

final class ErrorState extends ProfileJoueurState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}

final class UpdateJoueurStateBad extends ProfileJoueurState {}

final class ImagePickerProfileJoueurStateGood extends ProfileJoueurState {}

final class ImagePickerProfileJoueurStateBad extends ProfileJoueurState {}

final class UploadProfileJoueurImgAndGetUrlStateBad extends ProfileJoueurState {}

//----------------------mdp----------------------

final class UpdateMdpJoueurLoadingState extends ProfileJoueurState {}

final class UpdateMdpJoueurStateGood extends ProfileJoueurState {}

final class UpdateMdpJoueurStateBad extends ProfileJoueurState {}

final class PasswordVisibilityChanged extends ProfileJoueurState {}
