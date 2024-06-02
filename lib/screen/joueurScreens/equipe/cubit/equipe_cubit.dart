import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert' as convert;

import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/equipe_model.dart';
import 'package:pfeprojet/Model/user_model.dart';

import '../../../../Model/error_model.dart';

part 'equipe_state.dart';

class EquipeCubit extends Cubit<EquipeState> {
  EquipeCubit() : super(EquipeInitial());
  static EquipeCubit get(context) => BlocProvider.of<EquipeCubit>(context);

  void resetValue() {
    equipeData = [];
    cursorId = "";
    equipes = [];
    cursorid = "";
    equipeImInData = [];
    cursorId1 = "";
    equipeInviteData = [];
    cursorId2 = "";
    isSelected = [true, false, false, false];
    joueuraccepted = DataJoueurModel();
    joueur = DataJoueurModel();
    emit(ResetEquipeState());
  }

  List<bool> isSelected = [true, false, false, false];
  void changeTogelButton(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = false;
    }
    isSelected[index] = true;
    emit(ChangeIndexNavBarState());
  }

//------------------ equipe creer---------------------
  Future<void> creerEquipe(
      {required String nom,
      required String numero_joueurs,
      String? wilaya,
      String? commune}) async {
    emit(CreerEquipeLoadingState());

    Map<String, dynamic> _model = {
      "nom": nom,
      "numero_joueurs": numero_joueurs,
      "wilaya": wilaya,
      "commune": commune
    };

    await Httplar.httpPost(path: ADDEQUIPE, data: _model).then((value) {
      if (value.statusCode == 201) {
        emit(CreerEquipeStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(CreerEquipeStateBad());
    });
  }

  //----------------- get my terrain--------------------
  List<EquipeData> equipeData = [];
  String cursorId = "";
  Future<void> getMyEquipe({String cursor = '', bool? vertial}) async {
    emit(GetMyEquipeLoading());

    await Httplar.httpget(
        path: GETMYEQUIPE,
        query: {'cursor': cursor, 'vertial': vertial.toString()}).then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          equipeData = [];
          cursorId = "";
        }
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        EquipeModel model = EquipeModel.fromJson(jsonResponse);
        equipeData.addAll(model.data);
        cursorId = model.nextCursor;
        print(jsonResponse['nom']);
        emit(GetMyEquipeStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetMyEquipeStateBad());
    });
  }

  //-------------------------delete equipe ---------------------------------
  Future<void> deleteEquipe({required String id}) async {
    emit(DeleteEquipeLoadingState());

    await Httplar.httpdelete(path: DELETEEQUIPE + id).then((value) {
      if (value.statusCode == 204) {
        emit(DeleteEquipeStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(DeleteEquipeStateBad());
    });
  }

  //----------------- update equipe -------------------------------
  Future<void> updateEquipe(
      {required String id,
      required String nom,
      required String numero_joueurs,
      String? wilaya,
      String? commune}) async {
    emit(UpdateEquipeLoadingState());

    Map<String, dynamic> _model = {
      "nom": nom,
      "numero_joueurs": numero_joueurs,
      "wilaya": wilaya,
      "commune": commune
    };
    await Httplar.httpPut(path: UPDATEEQUIPE + id, data: _model).then((value) {
      if (value.statusCode == 200) {
        emit(UpdateEquipeStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(UpdateEquipeStateBad());
    });
  }

  Future<void> updateJoueursEquipe(
      {required List<String?> joueursId,
      required List<String?> attente_joueursID,
      required String equipeId}) async {
    emit(UpdateJoueursEquipeLoadingState());
    print(joueursId);
    await Httplar.httpPut(path: UPDATEJOUEURSEQUIPE + equipeId, data: {
      'joueurs': joueursId,
      'attente_joueurs': attente_joueursID,
    }).then((value) {
      if (value.statusCode == 200) {
        emit(UpdateJoueursEquipeStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(UpdateJoueursEquipeStateBad());
    });
  }

  //-------------------- get all equipes ----------------------------
  List<EquipeData> equipes = [];
  // cusrsorid mdeclari lfug
  String cursorid = "";
  Future<void> getAllEquipe(
      {String cursor = '', String capitanId = '', bool? vertial}) async {
    emit(GetAllEquipeLoading());
    await Httplar.httpget(
        path: GETALLEQUIPE,
        query: {'cursor': cursor, 'vertial': vertial.toString()}).then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          equipes = [];
          cursorid = "";
        }

        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;

        EquipeModel model = EquipeModel.fromJson(jsonResponse);
        print(capitanId);
        model.data.forEach((element) {
          if (element.capitaineId.id != capitanId) {
            equipes.add(element);
          }
        });
        // equipes.addAll(model.data);
        cursorid = model.nextCursor;

        emit(GetAllEquipeStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetAllEquipeStateBad());
    });
  }

  //------------------ equipes im in
  List<EquipeData> equipeImInData = [];
  String cursorId1 = "";
  Future<void> getEquipeImIn({String cursor = '', bool? vertial}) async {
    emit(GetEquipeImInLoading());

    await Httplar.httpget(
        path: GETEQUIPEIMIN,
        query: {'cursor': cursor, 'vertial': vertial.toString()}).then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          equipeImInData = [];
          cursorId1 = "";
        }
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        EquipeModel model = EquipeModel.fromJson(jsonResponse);
        equipeImInData.addAll(model.data);
        cursorId1 = model.nextCursor;

        emit(GetEquipeImInStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetEquipeImInStateBad());
    });
  }

  List<EquipeData> equipeInviteData = [];
  String cursorId2 = "";
  Future<void> getEquipeInvite({String cursor = ''}) async {
    emit(GetEquipeInviteLoading());

    await Httplar.httpget(path: GETEQUIPEINVITE, query: {'cursor': cursor})
        .then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          equipeInviteData = [];
          cursorId2 = "";
        }
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        EquipeModel model = EquipeModel.fromJson(jsonResponse);
        equipeInviteData.addAll(model.data);
        cursorId2 = model.nextCursor;

        emit(GetEquipeInviteStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetEquipeInviteStateBad());
    });
  }

  //-------------- acceoter invitation pour rejoindre equipe----
  Future<void> accepterInvitation(
      {required String id,
      required String joueurname,
      required String joueurId}) async {
    emit(AccepterInvLoadingState());

    Map<String, dynamic> _model = {};

    await Httplar.httpPost(path: ACCEPTERINVITATION + id, data: _model)
        .then((value) {
      if (value.statusCode == 200) {
        emit(AccepterInvStateGood(joueurname: joueurname, joueurId: joueurId));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(AccepterInvStateBad());
    });
  }

  //-------------- refuser invitation pour rejoindre equipe----
  Future<void> refuserInvitation({required String id}) async {
    emit(RefuserInvLoadingState());

    Map<String, dynamic> _model = {};

    await Httplar.httpPost(path: REFUSERINVITATION + id, data: _model)
        .then((value) {
      if (value.statusCode == 200) {
        emit(RefuserInvStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(RefuserInvStateBad());
    });
  }

//-------------------------- demander rejoindre equipe--------
  Future<void> demanderRejoindreEquipe({required String id}) async {
    emit(DemandeRejoindreEquipeLoadingState());

    Map<String, dynamic> _model = {};

    await Httplar.httpPost(path: DEMANDERREJOINDREEQUIPE + id, data: _model)
        .then((value) {
      if (value.statusCode == 200) {
        emit(DemandeRejoindreEquipeStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(DemandeRejoindreEquipeInvStateBad());
    });
  }

  //-------------annuler demande rejoindre equipe-------------------------

  Future<void> annulerRejoindreEquipe({required String id}) async {
    emit(AnnulerRejoindreEquipeLoadingState());

    Map<String, dynamic> _model = {};

    await Httplar.httpPost(path: ANNULERREJOINDREEQUIPE + id, data: _model)
        .then((value) {
      if (value.statusCode == 200) {
        emit(AnnulerRejoindreEquipeStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(AnnulerRejoindreEquipeInvStateBad());
    });
  }

  //---------------------------------------------------------------
  //--------------CAPITAINE ACCEPT DEMANDE JOUEUR-----------------
  late DataJoueurModel joueuraccepted;
  Future<void> capitaineAceeptJoueur(
      {required String equipeId,
      required String joueurId,
      required String equipename}) async {
    emit(CapitaineAceeptJoueurLoadingState());

    Map<String, dynamic> _model = {};
    print(CAPITAINEACCEPTJOUEUR + equipeId + '/' + joueurId);
    await Httplar.httpPost(
            path: CAPITAINEACCEPTJOUEUR + equipeId + '/' + joueurId,
            data: _model)
        .then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        joueuraccepted = DataJoueurModel.fromJson(jsonResponse);
        print('ala ala');
        emit(CapitaineAceeptJoueurStateGood(
            equipename: equipename, joueurId: joueurId));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(CapitaineAceeptJoueurStateBad());
    });
  }

  //---------------------CAPITAINE refuse DEMANDE JOUEUR-----------------
  Future<void> capitaineRefuseJoueur(
      {required String equipeId, required String joueurId}) async {
    emit(CapitaineRefuseJoueurLoadingState());

    Map<String, dynamic> _model = {};

    await Httplar.httpPost(
            path: CAPITAINEREFUSEJOUEUR + equipeId + '/' + joueurId,
            data: _model)
        .then((value) {
      if (value.statusCode == 200) {
        emit(CapitaineRefuseJoueurStateGood(idJoueur: joueurId));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(CapitaineRefuseJoueurStateBad());
    });
  }

  //---------------------CAPITAINE invite JOUEUR-----------------
  late DataJoueurModel joueur;
  Future<void> capitaineInviteJoueur(
      {required String equipeId,
      required String joueurId,
      required String equipename}) async {
    emit(CapitaineInviteJoueurLoadingState());

    Map<String, dynamic> _model = {};
    print(CAPITAINEINVITEJOUEUR + equipeId + '/' + joueurId);

    await Httplar.httpPost(
            path: CAPITAINEINVITEJOUEUR + equipeId + '/' + joueurId,
            data: _model)
        .then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        joueur = DataJoueurModel.fromJson(jsonResponse);
        emit(CapitaineInviteJoueurStateGood(
            equipename: equipename, joueurId: joueurId));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;

        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(CapitaineInviteJoueurStateBad());
    });
  }

  //---------------------CAPITAINE annuler invitation JOUEUR-----------------
  Future<void> capitaineAnnuleInvitationJoueur(
      {required String equipeId, required String joueurId}) async {
    emit(CapitaineAnnuleInvitationJoueurLoadingState());

    Map<String, dynamic> _model = {};

    await Httplar.httpPost(
            path: CAPITAINEANNULEINVITATIONJOUEUR + equipeId + '/' + joueurId,
            data: _model)
        .then((value) {
      if (value.statusCode == 200) {
        emit(CapitaineAnnuleInvitationJoueurStateGood(idJoueur: joueurId));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(CapitaineAnnuleInvitationJoueurStateBad());
    });
  }

  //--------------quiter equipe ------------------------
  Future<void> quiterEquipe(
      {required String equipeId, required String joueurId}) async {
    emit(QuiterEquipeLoadingState());

    Map<String, dynamic> _model = {};

    await Httplar.httpPost(
            path: QUITEREQUIPE + equipeId + '/' + joueurId, data: _model)
        .then((value) {
      if (value.statusCode == 200) {
        emit(QuiterEquipeStateGood(idJoueur: joueurId));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(QuiterEquipeStateBad());
    });
  }

  //-------------------- check by usernme -------------------------
  Future<void> checkUserByUsername({required String username}) async {
    emit(LoadinCheckUserByUsernameState());
    await Httplar.httpget(
      path: getJouerByUsername + username,
    ).then((value) {
      // print(getJouerByUsername + username);
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        // print(jsonResponse);
        // emit(TerrainViewToggled());

        emit(CheckUserByUsernameStateGood(
            dataJoueurModel: DataJoueurModel.fromJson(jsonResponse)));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(CheckUserByUsernameStateBad());
    });
  }
}
