// const URLHTTP = '192.168.1.23:3000';
// const URLHTTP = '192.168.1.2:3000';

// const URLHTTP = '192.168.1.20:3000'; //IP houssem

const URLHTTP = '192.168.227.142:3000'; //IP ala


// const URLHTTP = '10.0.2.2:3000';

const CREATEEQUIPEVERTIAL = '/api/equipe/vertial';
const CONFIRMCONNECTEQUIPE = '/api/reservation/connected/equipe';
const GETMYRESERVE = '/api/reservation/my';

const SENDNOTIFICATIONTOADMIN = '/api/notification/admin/';
const SENDNOTIFICATIONTOJOUEUR = '/api/notification/joueur/';

const SEARCHJOUEURPAGINATION = '/api/joueur/search/';
const SEARCHMYEQUIPEPAGINATION = '/api/equipe/my';
const SEARCHEQUIPEPAGINATION = '/api/equipe/search/';

const ADDORUPDATETOKENFCMADMIN = '/api/addOrUpdateTokenAdmin/';
const REMOVETETOKENFCMADMIN = '/api/removeTokenFcmAdmin/';
const ADDORUPDATETOKENFCMJoueur = '/api/addOrUpdateTokenJoueur/';
const REMOVETETOKENFCMJoueur = '/api/removeTokenFcmJoueur/';

const ReservationJoueur = '/api/reservation/';
const DELETGROUPRESERVATION = '/api/Reservation/groupe/'; // delete group reservation or one reservation but payment is true
const RESERVERTERRAINWITHADMIN = '/api/reservation/admin/';
const SETRESERVEWITHADMIN = '/api/reservation/set/admin/';
const FILTERRESERVATION = '/api/reservations/filter';
const FILTERRESERVATIONPagination = '/api/reservations/pagination/filter';
const MYRESERVATIONWITHOTHER = '/api/reservations/with/other/';
const ADDTERRAIN = '/api/terrain';
const DELETETERRAIN = '/api/terrain/';
const DELETETERRAINPHOTO =
    '/api/terrain/'; // rani fl function nkml /terrain/:id/photo/
const UPDATETERRAIN = '/api/terrain/';


const GETMYTERRAINS = '/api/terrains/my';

const SEARCHTERRAIN = '/api/search/terrain';
const SEARCHMYTERRAIN = '/api/search/myterrain';

const GETAllTerrain = '/api//terrains';
const Loginjoueur = '/api/joueur/login';
const REGISTERJOUER = '/api/joueur';
const GETMYINFORMATIONJOUEUR = '/api/joueur/information';
const GETMYINFORMATIONADMIN = '/api/admin/information';
const UPDATEJOUEUR = '/api/joueur';
const UPDATEADMIN = '/api/admin';
const UPDATEMDPADMIN = '/api/admins/password';
const UPDATEMDPJOUEUR = '/api/joueurs/password';
const ADDANNONCE = '/api/annonce';
const DELETEANNONCE = '/api/annonce/';
const GETMYANNONCEJOUEUR = '/api/annonces/my/joueur/';
const GETMYANNONCEADMIN = '/api/annonces/my/admin/';
const UPDATEANNONCE = '/api/annonce/';
const GETANNONCEBYID = '/api/annonce/';
const RECOVERPASSWORD = '/api/joueur/recoverpassword';
const RECOVERPASSWORDADMIN = '/api/admin/recoverpassword';
const RESETPASSWORD = '/api/joueur/resetpassword';
const RESETPASSWORDADMIN = '/api/admin/resetpassword';
const VERIFYJOUEURCODE = '/api/joueurs/verifytoken';
const VERIFYADMINCODE = '/api/admins/verifytoken';
const GETALLANNONCE = '/api/annonce';
//------------equipe
const ADDEQUIPE = '/api/equipe';
const GETALLEQUIPEDEMEANDER = '/api/joueur/demandes';
const UPDATEEQUIPE = '/api/equipe/';
const DELETEEQUIPE = '/api/equipe/';
const GETALLEQUIPE = '/api/equipe';
const GETMYEQUIPE = '/api/equipe/my';
const GETEQUIPEIMIN = '/api/equipe/imin';
const GETEQUIPEINVITE = '/api/equipes/invite';

const ACCEPTERINVITATION = '/api/joueur/accepter/';
const REFUSERINVITATION = '/api/joueur/refuser/';
const DEMANDERREJOINDREEQUIPE = '/api/joueur/rejoindre/';
const ANNULERREJOINDREEQUIPE = '/api/joueur/annuler/';

const CAPITAINEACCEPTJOUEUR = '/api/joueur/capitaine/accept/';
const CAPITAINEREFUSEJOUEUR = '/api/joueur/capitaine/refuser/';
const CAPITAINEINVITEJOUEUR = '/api/joueur/capitaine/demande/';
const CAPITAINEANNULEINVITATIONJOUEUR = '/api/joueur/capitaine/annuler/';
const QUITEREQUIPE = '/api/joueur/supprimer/';

const Loginadmin = '/api/admin/login';
const getJouerById = '/api/joueur/';
const getJouerByUsername = '/api/joueur/username/';
String PATH = Loginjoueur;
String PATH1 = RECOVERPASSWORD;
String PATH2 = VERIFYJOUEURCODE;
String PATH3 = RESETPASSWORD;
