import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Duolingo Clone'**
  String get appTitle;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @loadErrorDefault.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron cargar los datos'**
  String get loadErrorDefault;

  /// No description provided for @nameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get nameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get passwordLabel;

  /// No description provided for @signUp.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get signUp;

  /// No description provided for @signIn.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get signIn;

  /// No description provided for @haveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta? Inicia sesión'**
  String get haveAccount;

  /// No description provided for @noAccount.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta? Regístrate'**
  String get noAccount;

  /// No description provided for @homeLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar tu camino'**
  String get homeLoadError;

  /// No description provided for @challengesLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron cargar los desafíos'**
  String get challengesLoadError;

  /// No description provided for @giveCheer.
  ///
  /// In es, this message translates to:
  /// **'Dar toque'**
  String get giveCheer;

  /// No description provided for @giveGift.
  ///
  /// In es, this message translates to:
  /// **'Dar regalo'**
  String get giveGift;

  /// No description provided for @friendChallenge.
  ///
  /// In es, this message translates to:
  /// **'Desafío entre amigos'**
  String get friendChallenge;

  /// No description provided for @friendChallengeHours.
  ///
  /// In es, this message translates to:
  /// **'1H'**
  String get friendChallengeHours;

  /// No description provided for @sent.
  ///
  /// In es, this message translates to:
  /// **'Enviado'**
  String get sent;

  /// No description provided for @you.
  ///
  /// In es, this message translates to:
  /// **'Tú'**
  String get you;

  /// No description provided for @earnExp.
  ///
  /// In es, this message translates to:
  /// **'Gana {target} EXP'**
  String earnExp(int target);

  /// No description provided for @dailyChallenges.
  ///
  /// In es, this message translates to:
  /// **'Desafíos del día'**
  String get dailyChallenges;

  /// No description provided for @hoursLeft.
  ///
  /// In es, this message translates to:
  /// **'3H'**
  String get hoursLeft;

  /// No description provided for @emptyChallenges.
  ///
  /// In es, this message translates to:
  /// **'No hay desafíos activos por ahora'**
  String get emptyChallenges;

  /// No description provided for @challengeOf.
  ///
  /// In es, this message translates to:
  /// **'Desafío de {month}'**
  String challengeOf(String month);

  /// No description provided for @daysLeftShort.
  ///
  /// In es, this message translates to:
  /// **'{days} DÍAS'**
  String daysLeftShort(int days);

  /// No description provided for @earnPoints.
  ///
  /// In es, this message translates to:
  /// **'Gana {target} puntos de desafío'**
  String earnPoints(int target);

  /// No description provided for @challengeComplete.
  ///
  /// In es, this message translates to:
  /// **'¡Desafío completado!'**
  String get challengeComplete;

  /// No description provided for @pointsRemaining.
  ///
  /// In es, this message translates to:
  /// **'Te faltan {remaining} puntos'**
  String pointsRemaining(int remaining);

  /// No description provided for @leagueLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar la liga'**
  String get leagueLoadError;

  /// No description provided for @profileLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar el perfil'**
  String get profileLoadError;

  /// No description provided for @joinedOn.
  ///
  /// In es, this message translates to:
  /// **'{handle} · SE UNIÓ EN {year}'**
  String joinedOn(String handle, int year);

  /// No description provided for @addFriends.
  ///
  /// In es, this message translates to:
  /// **'Agrega amigos'**
  String get addFriends;

  /// No description provided for @summary.
  ///
  /// In es, this message translates to:
  /// **'Resumen'**
  String get summary;

  /// No description provided for @friendStreaks.
  ///
  /// In es, this message translates to:
  /// **'Rachas entre amigos'**
  String get friendStreaks;

  /// No description provided for @superFamily.
  ///
  /// In es, this message translates to:
  /// **'Súper familia'**
  String get superFamily;

  /// No description provided for @manage.
  ///
  /// In es, this message translates to:
  /// **'Administrar'**
  String get manage;

  /// No description provided for @addMember.
  ///
  /// In es, this message translates to:
  /// **'Agregar miembro'**
  String get addMember;

  /// No description provided for @monthlyMedals.
  ///
  /// In es, this message translates to:
  /// **'Medallas mensuales'**
  String get monthlyMedals;

  /// No description provided for @achievements.
  ///
  /// In es, this message translates to:
  /// **'Logros'**
  String get achievements;

  /// No description provided for @courses.
  ///
  /// In es, this message translates to:
  /// **'Cursos'**
  String get courses;

  /// No description provided for @following.
  ///
  /// In es, this message translates to:
  /// **'Siguiendo'**
  String get following;

  /// No description provided for @followers.
  ///
  /// In es, this message translates to:
  /// **'Seguidores'**
  String get followers;

  /// No description provided for @daysCount.
  ///
  /// In es, this message translates to:
  /// **'{count} días'**
  String daysCount(String count);

  /// No description provided for @expValue.
  ///
  /// In es, this message translates to:
  /// **'{value} EXP'**
  String expValue(String value);

  /// No description provided for @signOut.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get signOut;

  /// No description provided for @signOutConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Seguro que quieres salir de tu cuenta?'**
  String get signOutConfirm;

  /// No description provided for @superSince.
  ///
  /// In es, this message translates to:
  /// **'En Súper desde {year}'**
  String superSince(int year);

  /// No description provided for @superBadge.
  ///
  /// In es, this message translates to:
  /// **'SÚPER'**
  String get superBadge;

  /// No description provided for @changePhoto.
  ///
  /// In es, this message translates to:
  /// **'Cambiar foto'**
  String get changePhoto;

  /// No description provided for @choosePhoto.
  ///
  /// In es, this message translates to:
  /// **'Elige tu foto'**
  String get choosePhoto;

  /// No description provided for @gallery.
  ///
  /// In es, this message translates to:
  /// **'Galería'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In es, this message translates to:
  /// **'Cámara'**
  String get camera;

  /// No description provided for @changePhotoError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cambiar la foto: {error}'**
  String changePhotoError(String error);

  /// No description provided for @streakLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar la racha'**
  String get streakLoadError;

  /// No description provided for @streakDaysTitle.
  ///
  /// In es, this message translates to:
  /// **'Días de racha'**
  String get streakDaysTitle;

  /// No description provided for @personalTab.
  ///
  /// In es, this message translates to:
  /// **'PERSONAL'**
  String get personalTab;

  /// No description provided for @friendsTab.
  ///
  /// In es, this message translates to:
  /// **'AMIGOS'**
  String get friendsTab;

  /// No description provided for @streakSociety.
  ///
  /// In es, this message translates to:
  /// **'SOCIEDAD DE RACHAS EXTENSAS'**
  String get streakSociety;

  /// No description provided for @daysOfStreak.
  ///
  /// In es, this message translates to:
  /// **'días de racha'**
  String get daysOfStreak;

  /// No description provided for @perfectStreakPre.
  ///
  /// In es, this message translates to:
  /// **'Has mantenido una '**
  String get perfectStreakPre;

  /// No description provided for @perfectStreak.
  ///
  /// In es, this message translates to:
  /// **'Racha perfecta'**
  String get perfectStreak;

  /// No description provided for @perfectStreakPost.
  ///
  /// In es, this message translates to:
  /// **' durante {weeks} semanas. ¡Impresionante!'**
  String perfectStreakPost(int weeks);

  /// No description provided for @noFriends.
  ///
  /// In es, this message translates to:
  /// **'Aún no sigues a nadie'**
  String get noFriends;

  /// No description provided for @monthYear.
  ///
  /// In es, this message translates to:
  /// **'{month} de {year}'**
  String monthYear(String month, int year);

  /// No description provided for @practiceDays.
  ///
  /// In es, this message translates to:
  /// **'días de práctica'**
  String get practiceDays;

  /// No description provided for @freezesUsed.
  ///
  /// In es, this message translates to:
  /// **'Protectores usados'**
  String get freezesUsed;

  /// No description provided for @weekdays.
  ///
  /// In es, this message translates to:
  /// **'D,L,Ma,Mi,J,V,S'**
  String get weekdays;

  /// No description provided for @start.
  ///
  /// In es, this message translates to:
  /// **'Empezar'**
  String get start;

  /// No description provided for @check.
  ///
  /// In es, this message translates to:
  /// **'Comprobar'**
  String get check;

  /// No description provided for @correct.
  ///
  /// In es, this message translates to:
  /// **'¡Correcto!'**
  String get correct;

  /// No description provided for @correctAnswer.
  ///
  /// In es, this message translates to:
  /// **'Respuesta correcta:'**
  String get correctAnswer;

  /// No description provided for @continueLabel.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get continueLabel;

  /// No description provided for @noHeartsTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Te quedaste sin corazones!'**
  String get noHeartsTitle;

  /// No description provided for @noHeartsBody.
  ///
  /// In es, this message translates to:
  /// **'Recarga tus corazones para seguir practicando.'**
  String get noHeartsBody;

  /// No description provided for @refillHearts.
  ///
  /// In es, this message translates to:
  /// **'Recargar'**
  String get refillHearts;

  /// No description provided for @exitLesson.
  ///
  /// In es, this message translates to:
  /// **'Salir'**
  String get exitLesson;

  /// No description provided for @a11yHearts.
  ///
  /// In es, this message translates to:
  /// **'Corazones: {count}'**
  String a11yHearts(String count);

  /// No description provided for @lessonComplete.
  ///
  /// In es, this message translates to:
  /// **'¡Lección completada!'**
  String get lessonComplete;

  /// No description provided for @lessonCompleteSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Sigue así, cada lección te acerca a tu meta.'**
  String get lessonCompleteSubtitle;

  /// No description provided for @totalExp.
  ///
  /// In es, this message translates to:
  /// **'EXP TOTAL'**
  String get totalExp;

  /// No description provided for @accuracy.
  ///
  /// In es, this message translates to:
  /// **'PRECISIÓN'**
  String get accuracy;

  /// No description provided for @chooseTranslation.
  ///
  /// In es, this message translates to:
  /// **'Elige la traducción correcta'**
  String get chooseTranslation;

  /// No description provided for @translateSentence.
  ///
  /// In es, this message translates to:
  /// **'Traduce esta oración'**
  String get translateSentence;

  /// No description provided for @tapWords.
  ///
  /// In es, this message translates to:
  /// **'Toca las palabras para formar la oración'**
  String get tapWords;

  /// No description provided for @completeSentence.
  ///
  /// In es, this message translates to:
  /// **'Completa la oración'**
  String get completeSentence;

  /// No description provided for @matchPairs.
  ///
  /// In es, this message translates to:
  /// **'Empareja las parejas'**
  String get matchPairs;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navChallenges.
  ///
  /// In es, this message translates to:
  /// **'Desafíos'**
  String get navChallenges;

  /// No description provided for @navLeague.
  ///
  /// In es, this message translates to:
  /// **'Liga'**
  String get navLeague;

  /// No description provided for @navProfile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// No description provided for @a11yLessonNode.
  ///
  /// In es, this message translates to:
  /// **'Lección {position}'**
  String a11yLessonNode(int position);

  /// No description provided for @a11yAvatarPreset.
  ///
  /// In es, this message translates to:
  /// **'Avatar {index}'**
  String a11yAvatarPreset(int index);

  /// No description provided for @a11yStatStreak.
  ///
  /// In es, this message translates to:
  /// **'Racha de {days} días'**
  String a11yStatStreak(int days);

  /// No description provided for @a11yFriendStreak.
  ///
  /// In es, this message translates to:
  /// **'Racha con {name}: {days} días'**
  String a11yFriendStreak(String name, int days);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
