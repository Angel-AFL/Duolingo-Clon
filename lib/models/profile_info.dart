/// Datos del perfil del usuario.
class ProfileInfo {
  const ProfileInfo({
    required this.name,
    required this.handle,
    required this.joinedYear,
    required this.superSince,
    required this.courses,
    required this.following,
    required this.followers,
    required this.league,
    required this.totalExp,
    this.avatarUrl,
  });

  final String name;

  /// URL de la foto de perfil.
  ///
  /// Puede ser una URL de Supabase Storage (`https://...`), una ruta de asset
  /// (`assets/...`) o un preset (`preset:<id>`). `null` usa el placeholder.
  final String? avatarUrl;

  /// Usuario con `@`.
  final String handle;

  /// Ano en que se unio.
  final int joinedYear;

  /// Ano desde que es Súper.
  final int superSince;

  /// Cursos activos.
  final int courses;

  /// Cuentas que sigue.
  final int following;

  /// Seguidores.
  final int followers;

  /// Liga actual (ej. "Diamante").
  final String league;

  /// Experiencia total acumulada.
  final int totalExp;

  factory ProfileInfo.fromJson(Map<String, dynamic> json) {
    return ProfileInfo(
      name: json['name'] as String,
      handle: json['handle'] as String,
      joinedYear: json['joined_year'] as int,
      superSince: json['super_since'] as int,
      courses: json['courses'] as int,
      following: json['following'] as int,
      followers: json['followers'] as int,
      league: json['league'] as String,
      totalExp: json['total_exp'] as int,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'handle': handle,
    'joined_year': joinedYear,
    'super_since': superSince,
    'courses': courses,
    'following': following,
    'followers': followers,
    'league': league,
    'total_exp': totalExp,
    'avatar_url': avatarUrl,
  };

  ProfileInfo copyWith({String? avatarUrl}) => ProfileInfo(
    name: name,
    handle: handle,
    joinedYear: joinedYear,
    superSince: superSince,
    courses: courses,
    following: following,
    followers: followers,
    league: league,
    totalExp: totalExp,
    avatarUrl: avatarUrl ?? this.avatarUrl,
  );
}
