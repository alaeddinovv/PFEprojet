part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetMyInformationLoading extends ProfileState {}

final class GetMyInformationStateGood extends ProfileState {
  final DataJoueurModel model;
  GetMyInformationStateGood({required this.model});
}

final class ErrorState extends ProfileState {
  final ErrorModel model;
  ErrorState({required this.model});
}

final class GetMyInformationStateBad extends ProfileState {}

final class ImagePickerProfileJoueurStateGood extends ProfileState {}

final class ImagePickerProfileJoueurStateBad extends ProfileState {}

final class UploadProfileJoueurImgAndGetUrlStateBad extends ProfileState {}

final class UpdateJoueurLoadingState extends ProfileState {}

final class UpdateJoueurStateGood extends ProfileState {}

final class UpdateJoueurStateBad extends ProfileState {}
