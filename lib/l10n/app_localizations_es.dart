// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Duolingo Clone';

  @override
  String get retry => 'Reintentar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get loadErrorDefault => 'No se pudieron cargar los datos';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get signUp => 'Crear cuenta';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get haveAccount => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get noAccount => '¿No tienes cuenta? Regístrate';

  @override
  String get homeLoadError => 'No se pudo cargar tu camino';

  @override
  String get challengesLoadError => 'No se pudieron cargar los desafíos';

  @override
  String get giveCheer => 'Dar toque';

  @override
  String get giveGift => 'Dar regalo';

  @override
  String get dailyChallenges => 'Desafíos del día';

  @override
  String get hoursLeft => '12H';

  @override
  String get emptyChallenges => 'No hay desafíos activos por ahora';

  @override
  String challengeOf(String month) {
    return 'Desafío de $month';
  }

  @override
  String daysLeftShort(int days) {
    return '$days DÍAS';
  }

  @override
  String earnPoints(int target) {
    return 'Gana $target puntos de desafío';
  }

  @override
  String get challengeComplete => '¡Desafío completado!';

  @override
  String pointsRemaining(int remaining) {
    return 'Te faltan $remaining puntos';
  }

  @override
  String get leagueLoadError => 'No se pudo cargar la liga';

  @override
  String get profileLoadError => 'No se pudo cargar el perfil';

  @override
  String joinedOn(String handle, int year) {
    return '$handle · SE UNIÓ EN $year';
  }

  @override
  String get addFriends => 'Agrega amigos';

  @override
  String get summary => 'Resumen';

  @override
  String get friendStreaks => 'Rachas entre amigos';

  @override
  String get superFamily => 'Súper familia';

  @override
  String get manage => 'Administrar';

  @override
  String get courses => 'Cursos';

  @override
  String get following => 'Siguiendo';

  @override
  String get followers => 'Seguidores';

  @override
  String daysCount(String count) {
    return '$count días';
  }

  @override
  String expValue(String value) {
    return '$value EXP';
  }

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get signOutConfirm => '¿Seguro que quieres salir de tu cuenta?';

  @override
  String superSince(int year) {
    return 'En Súper desde $year';
  }

  @override
  String get superBadge => 'SÚPER';

  @override
  String get changePhoto => 'Cambiar foto';

  @override
  String get choosePhoto => 'Elige tu foto';

  @override
  String get gallery => 'Galería';

  @override
  String get camera => 'Cámara';

  @override
  String changePhotoError(String error) {
    return 'No se pudo cambiar la foto: $error';
  }

  @override
  String get streakLoadError => 'No se pudo cargar la racha';

  @override
  String get streakDaysTitle => 'Días de racha';

  @override
  String get personalTab => 'PERSONAL';

  @override
  String get friendsTab => 'AMIGOS';

  @override
  String get streakSociety => 'SOCIEDAD DE RACHAS EXTENSAS';

  @override
  String get daysOfStreak => 'días de racha';

  @override
  String get perfectStreakPre => 'Has mantenido una ';

  @override
  String get perfectStreak => 'Racha perfecta';

  @override
  String perfectStreakPost(int weeks) {
    return ' durante $weeks semanas. ¡Impresionante!';
  }

  @override
  String get noFriends => 'Aún no sigues a nadie';

  @override
  String monthYear(String month, int year) {
    return '$month de $year';
  }

  @override
  String get practiceDays => 'días de práctica';

  @override
  String get freezesUsed => 'Protectores usados';

  @override
  String get weekdays => 'D,L,Ma,Mi,J,V,S';

  @override
  String get check => 'Comprobar';

  @override
  String get correct => '¡Correcto!';

  @override
  String get correctAnswer => 'Respuesta correcta:';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get lessonComplete => '¡Lección completada!';

  @override
  String get lessonCompleteSubtitle =>
      'Sigue así, cada lección te acerca a tu meta.';

  @override
  String get totalExp => 'EXP TOTAL';

  @override
  String get accuracy => 'PRECISIÓN';

  @override
  String get chooseTranslation => 'Elige la traducción correcta';

  @override
  String get translateSentence => 'Traduce esta oración';

  @override
  String get tapWords => 'Toca las palabras para formar la oración';

  @override
  String get completeSentence => 'Completa la oración';

  @override
  String get matchPairs => 'Empareja las parejas';

  @override
  String get navHome => 'Inicio';

  @override
  String get navPractice => 'Práctica';

  @override
  String get navGems => 'Gemas';

  @override
  String get navHearts => 'Corazones';

  @override
  String get navLeague => 'Liga';

  @override
  String get navMore => 'Más';

  @override
  String a11yLessonNode(int position) {
    return 'Lección $position';
  }

  @override
  String a11yAvatarPreset(int index) {
    return 'Avatar $index';
  }

  @override
  String a11yStatStreak(int days) {
    return 'Racha de $days días';
  }

  @override
  String a11yFriendStreak(String name, int days) {
    return 'Racha con $name: $days días';
  }
}
