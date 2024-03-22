part of 'profile_admin_cubit.dart';

@immutable
sealed class ProfileAdminState {}

final class ProfileAdminInitial extends ProfileAdminState {}

final class UpdateAdminLoadingState extends ProfileAdminState {}

final class UpdateAdminStateGood extends ProfileAdminState {
  final DataAdminModel dataAdminModel;

  UpdateAdminStateGood({required this.dataAdminModel});
}

final class ErrorState extends ProfileAdminState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}

final class UpdateAdminStateBad extends ProfileAdminState {}

final class ImagePickerProfileAdminStateGood extends ProfileAdminState {}

final class ImagePickerProfileAdminStateBad extends ProfileAdminState {}

final class UploadProfileAdminImgAndGetUrlStateBad extends ProfileAdminState {}


//----------------------mdp----------------------

final class UpdateMdpAdminLoadingState extends ProfileAdminState {}
final class NewPasswordWrong extends ProfileAdminState {}
// final class NewPasswordCorrect extends ProfileAdminState {}


final class UpdateMdpAdminStateGood extends ProfileAdminState {}
final class UpdateMdpAdminStateBad extends ProfileAdminState {}




