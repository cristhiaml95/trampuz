import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'sl', 'es'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? slText = '',
    String? esText = '',
  }) =>
      [enText, slText, esText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // create_account
  {
    'hma5gxno': {
      'en': 'Trampuž warehouse',
      'es': 'Almacén Trampuž',
      'sl': 'Trampužovo skladišče',
    },
    'h4z0a3z3': {
      'en': 'Create an account',
      'es': 'Crear una cuenta',
      'sl': 'Ustvari račun',
    },
    'vyc1ujqk': {
      'en': 'Let\'s get started by filling out the form below.',
      'es': 'Comencemos rellenando el formulario que aparece a continuación.',
      'sl': 'Začnimo z izpolnitvijo spodnjega obrazca.',
    },
    '86s8kzxx': {
      'en': 'Name',
      'es': 'Nombre',
      'sl': 'Ime',
    },
    'iirmn0zw': {
      'en': 'Last name',
      'es': 'Apellido',
      'sl': 'Priimek',
    },
    '889gd7ck': {
      'en': 'User type',
      'es': 'Tipo de usuario',
      'sl': 'Vrsta uporabnika',
    },
    '2is4mjzb': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '99r8wugx': {
      'en': 'administrator',
      'es': 'administrator',
      'sl': 'administrator',
    },
    'jw8uoqy2': {
      'en': 'employee',
      'es': 'employee',
      'sl': 'employee',
    },
    '2lk9a7co': {
      'en': 'superadmin',
      'es': 'superadmin',
      'sl': 'superadmin',
    },
    'ui7rta8c': {
      'en': 'Status',
      'es': 'Estado',
      'sl': 'Stanje',
    },
    'txcpsr93': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'dqqkgfoq': {
      'en': 'active',
      'es': 'active',
      'sl': 'active',
    },
    'kgxxej2s': {
      'en': 'inactive',
      'es': 'inactive',
      'sl': 'inactive',
    },
    '617idpiw': {
      'en': 'Photo',
      'es': 'Foto',
      'sl': 'Fotografija',
    },
    'ec3kgh69': {
      'en': 'Job role',
      'es': 'Rol del puesto',
      'sl': 'Delovno mesto',
    },
    'kjxck9ix': {
      'en': 'Email',
      'es': 'Correo electrónico',
      'sl': 'E-pošta',
    },
    '7w95o0si': {
      'en': 'Password',
      'es': 'Contraseña',
      'sl': 'Geslo',
    },
    'oxnb6qlg': {
      'en': 'Confirm Password',
      'es': 'confirmar Contraseña',
      'sl': 'Potrdite geslo',
    },
    'e7x3js7r': {
      'en': 'Create Account',
      'es': 'Crear una cuenta',
      'sl': 'Ustvari račun',
    },
    'dpf4qbt5': {
      'en': 'Already have an account? ',
      'es': '¿Ya tienes una cuenta?',
      'sl': 'Že imate račun?',
    },
    '2ugy5uag': {
      'en': '  Sign In here',
      'es': 'Inicia sesión aquí',
      'sl': 'Prijavite se tukaj',
    },
    'qbuzwfrg': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'qextis7e': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'b4h2xe93': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'y5z9nlac': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'wvmon1ja': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    '7dzc0vda': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'oa53wqny': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'ygtm5rh2': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'oc3ogl6u': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'yhqpvm48': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'wz4omj7v': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    '29tsnkk4': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    '8b5ekxog': {
      'en': 'Home',
      'es': 'Hogar',
      'sl': 'Domov',
    },
  },
  // login
  {
    'xbr8v6ey': {
      'en': 'Welcome Back',
      'es': 'Bienvenido de nuevo',
      'sl': 'Dobrodošli nazaj',
    },
    'rs4dwwg2': {
      'en': 'Let\'s get started by filling out the form below.',
      'es': 'Comencemos rellenando el formulario que aparece a continuación.',
      'sl': 'Začnimo z izpolnitvijo spodnjega obrazca.',
    },
    'hw9fduru': {
      'en': 'Email',
      'es': 'Correo electrónico',
      'sl': 'E-pošta',
    },
    'ltkqidid': {
      'en': 'Password',
      'es': 'Contraseña',
      'sl': 'Geslo',
    },
    'ahqc4aox': {
      'en': 'Sign In',
      'es': 'Iniciar sesión',
      'sl': 'Prijava',
    },
    'bsw4hd4t': {
      'en': 'Home',
      'es': 'Hogar',
      'sl': 'Domov',
    },
  },
  // users
  {
    '4jqoquse': {
      'en': 'Trampuž',
      'es': 'Trampolín',
      'sl': 'Trampuž',
    },
    '8fwhjzmc': {
      'en': 'Reports',
      'es': 'Informes',
      'sl': 'Poročila',
    },
    '04dk6qvh': {
      'en': 'Order warehouse',
      'es': 'Almacén de pedidos',
      'sl': 'Skladišče naročil',
    },
    'za21j1f4': {
      'en': 'Warehouse 2',
      'es': 'Almacén 2',
      'sl': 'Skladišče 2',
    },
    'cujche2h': {
      'en': 'Calendar',
      'es': 'Calendario',
      'sl': 'Koledar',
    },
    '9v0yc5h4': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    'e2dey9vb': {
      'en': 'Settings',
      'es': 'Ajustes',
      'sl': 'Nastavitve',
    },
    'yib8xul7': {
      'en': 'Users',
      'es': 'Usuarios',
      'sl': 'Uporabniki',
    },
    'xsvkgu9p': {
      'en': 'Explore',
      'es': 'Explorar',
      'sl': 'Razišči',
    },
    'pww61gn0': {
      'en': 'Users',
      'es': 'Usuarios',
      'sl': 'Uporabniki',
    },
    'dxa0ddlv': {
      'en': 'Users',
      'es': 'Usuarios',
      'sl': 'Uporabniki',
    },
    '0inci51p': {
      'en': 'Create account',
      'es': 'Crear una cuenta',
      'sl': 'Ustvari račun',
    },
    'w3t1ro5y': {
      'en': 'Below are the details of your available users.',
      'es':
          'A continuación se muestran los detalles de sus usuarios disponibles.',
      'sl': 'Spodaj so podrobnosti o vaših razpoložljivih uporabnikih.',
    },
    '35m2g51k': {
      'en': 'Id',
      'es': 'Identificación',
      'sl': 'ID',
    },
    '2tbhql7j': {
      'en': 'Created time',
      'es': 'Hora de creación',
      'sl': 'Čas ustvarjanja',
    },
    'mh9vrq5g': {
      'en': 'Full name',
      'es': 'Nombre completo',
      'sl': 'Polno ime',
    },
    'mvh0j0ys': {
      'en': 'Email',
      'es': 'Correo electrónico',
      'sl': 'E-pošta',
    },
    '8cvb8jex': {
      'en': 'User type',
      'es': 'Tipo de usuario',
      'sl': 'Vrsta uporabnika',
    },
    '1iu2936f': {
      'en': 'Status',
      'es': 'Estado',
      'sl': 'Stanje',
    },
    'ch5dldsy': {
      'en': 'Job role',
      'es': 'Rol del puesto',
      'sl': 'Delovno mesto',
    },
    'dl4ag5nq': {
      'en': 'Password',
      'es': 'Contraseña',
      'sl': 'Geslo',
    },
    '7wv4l9ei': {
      'en': 'Image',
      'es': 'Imagen',
      'sl': 'Slika',
    },
    '17xi50wo': {
      'en': 'Edit',
      'es': 'Editar',
      'sl': 'Uredi',
    },
    '4lda3i2a': {
      'en': 'Order Details',
      'es': 'Detalles del pedido',
      'sl': 'Podrobnosti naročila',
    },
  },
  // warehouse2
  {
    'c79jd9mp': {
      'en': 'Trampuž',
      'es': 'Trampolín',
      'sl': 'Trampuž',
    },
    'herxqh9m': {
      'en': 'Reports',
      'es': 'Informes',
      'sl': 'Poročila',
    },
    'q3z2kzhq': {
      'en': 'Order warehouse',
      'es': 'Almacén de pedidos',
      'sl': 'Skladišče naročil',
    },
    '9xz0x26y': {
      'en': 'Warehouse 2',
      'es': 'Almacén 2',
      'sl': 'Skladišče 2',
    },
    'abhnwadp': {
      'en': 'Calendar',
      'es': 'Calendario',
      'sl': 'Koledar',
    },
    'asy0wtm9': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    'onsxf48i': {
      'en': 'Settings',
      'es': 'Ajustes',
      'sl': 'Nastavitve',
    },
    'r8wv2y24': {
      'en': 'Users',
      'es': 'Usuarios',
      'sl': 'Uporabniki',
    },
    '5vf7vs5q': {
      'en': 'Explore',
      'es': 'Explorar',
      'sl': 'Razišči',
    },
    'uqmisslm': {
      'en': 'Warehouse 2',
      'es': 'Almacén 2',
      'sl': 'Skladišče 2',
    },
    'gewq9u1w': {
      'en': 'Movements',
      'es': 'Movimientos',
      'sl': 'Gibanja',
    },
    'pkwucw9j': {
      'en': 'Below are the details of your inventory movements.',
      'es':
          'A continuación se muestran los detalles de los movimientos de su inventario.',
      'sl': 'Spodaj so podrobnosti o gibanju vaših zalog.',
    },
    'lzzntp6o': {
      'en': 'Updates:',
      'es': 'Actualizaciones:',
      'sl': 'Posodobitve:',
    },
    'fpybr0sz': {
      'en': 'Inventory status',
      'es': 'Estado del inventario',
      'sl': 'Stanje zalog',
    },
    '793l94ba': {
      'en': 'Order No.',
      'es': 'N.º de pedido',
      'sl': 'Številka naročila',
    },
    'ragnfncj': {
      'en': 'Client',
      'es': 'Cliente',
      'sl': 'Stranka',
    },
    '3ndo5buw': {
      'en': 'Create new record',
      'es': 'Crear nuevo registro',
      'sl': 'Ustvari nov zapis',
    },
  },
  // explore
  {
    'jmbjo6gt': {
      'en': 'Trampuž',
      'es': 'Trampolín',
      'sl': 'Trampuž',
    },
    'yp8ed6x3': {
      'en': 'Reports',
      'es': 'Informes',
      'sl': 'Poročila',
    },
    'kzzdt5g6': {
      'en': 'Order warehouse',
      'es': 'Almacén de pedidos',
      'sl': 'Skladišče naročil',
    },
    '2apulfqc': {
      'en': 'Warehouse 2',
      'es': 'Almacén 2',
      'sl': 'Skladišče 2',
    },
    'fj8bla5j': {
      'en': 'Calendar',
      'es': 'Calendario',
      'sl': 'Koledar',
    },
    '1i1b2shf': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    'kjn32hsn': {
      'en': 'Settings',
      'es': 'Ajustes',
      'sl': 'Nastavitve',
    },
    'xfut7kxz': {
      'en': 'Users',
      'es': 'Usuarios',
      'sl': 'Uporabniki',
    },
    'xzbclzca': {
      'en': 'Explore',
      'es': 'Explorar',
      'sl': 'Razišči',
    },
    'qn4hiip7': {
      'en': 'Explore',
      'es': 'Explorar',
      'sl': 'Razišči',
    },
    '70sojiw8': {
      'en': 'Static tables',
      'es': 'Tablas estáticas',
      'sl': 'Statične tabele',
    },
    '2qgg50no': {
      'en': 'Below are the details of your static tables.',
      'es': 'A continuación se muestran los detalles de sus tablas estáticas.',
      'sl': 'Spodaj so podrobnosti vaših statičnih tabel.',
    },
    'vxsfzvqg': {
      'en': 'Refresh tables',
      'es': 'Actualizar tablas',
      'sl': 'Osveži tabele',
    },
    '51h0n2ji': {
      'en': 'Warehouses',
      'es': 'Almacenes',
      'sl': 'Skladišča',
    },
    '7edbksh3': {
      'en': 'Warehouse',
      'es': 'Depósito',
      'sl': 'Skladišče',
    },
    'n04rcicr': {
      'en': 'Clients',
      'es': 'Clientela',
      'sl': 'Stranke',
    },
    'kn8z4zmk': {
      'en': 'Client',
      'es': 'Cliente',
      'sl': 'Stranka',
    },
    'nf9pfdmm': {
      'en': 'Address',
      'es': 'DIRECCIÓN',
      'sl': 'Naslov',
    },
    'jj9gq5l5': {
      'en': 'City',
      'es': 'Ciudad',
      'sl': 'Mesto',
    },
    'vo6vujav': {
      'en': 'Country',
      'es': 'País',
      'sl': 'Država',
    },
    '6vbkf8db': {
      'en': 'Name aiss',
      'es': 'Nombre aiss',
      'sl': 'Ime aiss',
    },
    'ce3ze44x': {
      'en': 'Vat no',
      'es': 'N.º de IVA',
      'sl': 'DDV št.',
    },
    'l681o904': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    '6al7qlnh': {
      'en': 'Custom',
      'es': 'Costumbre',
      'sl': 'Po meri',
    },
    'qjp3n2kp': {
      'en': 'Goods',
      'es': 'Bienes',
      'sl': 'Blago',
    },
    'f0h08w8g': {
      'en': 'Good',
      'es': 'Bien',
      'sl': 'Dobro',
    },
    'vj3tfbys': {
      'en': 'Good descriptions',
      'es': 'Buenas descripciones',
      'sl': 'Dobri opisi',
    },
    'ulbprri0': {
      'en': 'Good description',
      'es': 'Buena descripción',
      'sl': 'Dober opis',
    },
    'nn518qwk': {
      'en': 'Packagings',
      'es': 'Embalajes',
      'sl': 'Embalaža',
    },
    'tkwn2ymj': {
      'en': 'Packaging',
      'es': 'Embalaje',
      'sl': 'Embalaža',
    },
    'srfb3a9b': {
      'en': 'Abreviation',
      'es': 'Abreviatura',
      'sl': 'Okrajšava',
    },
    'vfgoswxs': {
      'en': 'Manipulations',
      'es': 'Manipulaciones',
      'sl': 'Manipulacije',
    },
    'it5cqdjv': {
      'en': 'Manipulation',
      'es': 'Manipulación',
      'sl': 'Manipulacija',
    },
    'qd5tvk8d': {
      'en': 'Thresholds',
      'es': 'Umbrales',
      'sl': 'Pragovi',
    },
    'j3ob3w2l': {
      'en': 'Threshold',
      'es': 'Límite',
      'sl': 'Prag',
    },
    '3luq1znc': {
      'en': 'Date',
      'es': 'Fecha',
      'sl': 'Datum',
    },
    'wkc914ty': {
      'en': 'Modifier',
      'es': 'Modificador',
      'sl': 'Modifikator',
    },
    'bt0i7sba': {
      'en': 'Order Details',
      'es': 'Detalles del pedido',
      'sl': 'Podrobnosti naročila',
    },
  },
  // calendar
  {
    'pccjrsyx': {
      'en': 'Trampuž',
      'es': 'Trampolín',
      'sl': 'Trampuž',
    },
    'e81lwjk0': {
      'en': 'Reports',
      'es': 'Informes',
      'sl': 'Poročila',
    },
    'r2yzm09a': {
      'en': 'Order warehouse',
      'es': 'Almacén de pedidos',
      'sl': 'Skladišče naročil',
    },
    'dr5xxudp': {
      'en': 'Warehouse 2',
      'es': 'Almacén 2',
      'sl': 'Skladišče 2',
    },
    '38h9lzty': {
      'en': 'Calendar',
      'es': 'Calendario',
      'sl': 'Koledar',
    },
    'dc1jvfjh': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    'z9acdbvy': {
      'en': 'Settings',
      'es': 'Ajustes',
      'sl': 'Nastavitve',
    },
    '1fryj9i0': {
      'en': 'Users',
      'es': 'Usuarios',
      'sl': 'Uporabniki',
    },
    'dt3rvtis': {
      'en': 'Explore',
      'es': 'Explorar',
      'sl': 'Razišči',
    },
    'xi5pl87s': {
      'en': 'Calendar',
      'es': 'Calendario',
      'sl': 'Koledar',
    },
    '081bbeg6': {
      'en': 'Upcoming appointments.',
      'es': 'Próximas citas.',
      'sl': 'Prihajajoči sestanki.',
    },
    'hjdhyanu': {
      'en': 'Below are the details of your nearest scheduled appointments.',
      'es':
          'A continuación se muestran los detalles de sus citas programadas más cercanas.',
      'sl': 'Spodaj so podrobnosti o vaših najbližjih načrtovanih terminih.',
    },
    'hvgqwx33': {
      'en': 'Refresh manually',
      'es': 'Actualizar manualmente',
      'sl': 'Ročno osveži',
    },
    '3szriht0': {
      'en': 'Search',
      'es': 'Buscar',
      'sl': 'Iskanje',
    },
    'hnmx914k': {
      'en': 'Warehouse...',
      'es': 'Depósito...',
      'sl': 'Skladišče...',
    },
    '2i4u5g3o': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'm1tv1qol': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
  },
  // reports
  {
    'yakl8w1o': {
      'en': 'Trampuž',
      'es': 'Trampolín',
      'sl': 'Trampuž',
    },
    '7uqhp8pp': {
      'en': 'Reports',
      'es': 'Informes',
      'sl': 'Poročila',
    },
    'i1pfz7zq': {
      'en': 'Order warehouse',
      'es': 'Almacén de pedidos',
      'sl': 'Skladišče naročil',
    },
    'et4sokhi': {
      'en': 'Warehouse 2',
      'es': 'Almacén 2',
      'sl': 'Skladišče 2',
    },
    'wywtkc0i': {
      'en': 'Calendar',
      'es': 'Calendario',
      'sl': 'Koledar',
    },
    'zucv118b': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    '18763ku5': {
      'en': 'Settings',
      'es': 'Ajustes',
      'sl': 'Nastavitve',
    },
    'e9bl6o82': {
      'en': 'Users',
      'es': 'Usuarios',
      'sl': 'Uporabniki',
    },
    'atnu4jxq': {
      'en': 'Explore',
      'es': 'Explorar',
      'sl': 'Razišči',
    },
    'fcpvqdd4': {
      'en': 'Reports',
      'es': 'Informes',
      'sl': 'Poročila',
    },
    'xcnmxdqs': {
      'en': 'Reports',
      'es': 'Informes',
      'sl': 'Poročila',
    },
    'x6z5lxox': {
      'en':
          'Here you have the general and stock report of your inventory movements.',
      'es':
          'Aquí tienes el informe general y de stock de tus movimientos de inventario.',
      'sl':
          'Tukaj imate splošno poročilo in poročilo o zalogah o gibanju vaših zalog.',
    },
    '4nd2o6gw': {
      'en': 'Updates:',
      'es': 'Actualizaciones:',
      'sl': 'Posodobitve:',
    },
    '1s82femk': {
      'en': 'Get csv',
      'es': 'Obtener csv',
      'sl': 'Pridobi CSV',
    },
    'h90z5128': {
      'en': 'General report',
      'es': 'Informe general',
      'sl': 'Splošno poročilo',
    },
    'lk2foi05': {
      'en': 'Stock report',
      'es': 'Informe de acciones',
      'sl': 'Poročilo o zalogah',
    },
  },
  // order_warehouse
  {
    'pndo8yxo': {
      'en': 'Trampuž',
      'es': 'Trampolín',
      'sl': 'Trampuž',
    },
    'lylin1wr': {
      'en': 'Reports',
      'es': 'Informes',
      'sl': 'Poročila',
    },
    'j602wsdt': {
      'en': 'Order warehouse',
      'es': 'Almacén de pedidos',
      'sl': 'Skladišče naročil',
    },
    'u09580ec': {
      'en': 'Warehouse 2',
      'es': 'Almacén 2',
      'sl': 'Skladišče 2',
    },
    'kgotqw8e': {
      'en': 'Calendar',
      'es': 'Calendario',
      'sl': 'Koledar',
    },
    '6hqs0t4w': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    'fyhezuql': {
      'en': 'Settings',
      'es': 'Ajustes',
      'sl': 'Nastavitve',
    },
    '8q9xj2n2': {
      'en': 'Users',
      'es': 'Usuarios',
      'sl': 'Uporabniki',
    },
    'j7p06qzs': {
      'en': 'Explore',
      'es': 'Explorar',
      'sl': 'Razišči',
    },
    'n93kx1hi': {
      'en': 'Order warehouse V4.0.5',
      'es': 'Almacén de pedidos V4.0.5',
      'sl': 'Skladišče naročil V4.0.5',
    },
    't3kkdl4l': {
      'en': 'Movements',
      'es': 'Movimientos',
      'sl': 'Gibanja',
    },
    'lajbsmm6': {
      'en': 'Below are the details of your inventory movements.',
      'es':
          'A continuación se muestran los detalles de los movimientos de su inventario.',
      'sl': 'Spodaj so podrobnosti o gibanju vaših zalog.',
    },
    'm92wo0i8': {
      'en': 'Updates:',
      'es': 'Actualizaciones:',
      'sl': 'Posodobitve:',
    },
    '807ab1w8': {
      'en': 'Quantity balance:',
      'es': 'Saldo de cantidad:',
      'sl': 'Količinsko stanje:',
    },
    'p1aro1bt': {
      'en': 'Inventory status',
      'es': 'Estado del inventario',
      'sl': 'Stanje zalog',
    },
    'ipet2wod': {
      'en': 'Order No.',
      'es': 'N.º de pedido',
      'sl': 'Številka naročila',
    },
    'jwvc4zl3': {
      'en': 'Client',
      'es': 'Cliente',
      'sl': 'Stranka',
    },
    'usjnsdde': {
      'en': 'Available quantity',
      'es': 'Cantidad disponible',
      'sl': 'Razpoložljiva količina',
    },
    'j3zffrgj': {
      'en': 'Select grid',
      'es': 'Seleccionar cuadrícula',
      'sl': 'Izberite mrežo',
    },
    'ctu3mper': {
      'en': 'Search...',
      'es': 'Buscar...',
      'sl': 'Iskanje ...',
    },
    'jckz4nc1': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'oobdhsj8': {
      'en': 'Option 2',
      'es': 'Opción 2',
      'sl': 'Možnost 2',
    },
    'eligtkqe': {
      'en': 'Option 3',
      'es': 'Opción 3',
      'sl': 'Možnost 3',
    },
    'sfuh8dl0': {
      'en': 'rows...',
      'es': 'filas...',
      'sl': 'vrstice ...',
    },
    '8ssuu897': {
      'en': 'all',
      'es': 'all',
      'sl': 'all',
    },
    'olwk09ha': {
      'en': 'available',
      'es': 'available',
      'sl': 'available',
    },
    '7sys5903': {
      'en': 'disassociated',
      'es': 'disassociated',
      'sl': 'disassociated',
    },
    '59dfe1a7': {
      'en': 'error',
      'es': 'error',
      'sl': 'error',
    },
    '8h9bxrgw': {
      'en': 'all',
      'es': 'all',
      'sl': 'all',
    },
    '060myq9m': {
      'en': 'Create new record',
      'es': 'Crear nuevo registro',
      'sl': 'Ustvari nov zapis',
    },
  },
  // customs_view
  {
    'i9sf0gpu': {
      'en': 'Trampuž',
      'es': 'Trampolín',
      'sl': 'Trampuž',
    },
    'he2yjkvl': {
      'en': 'Reports',
      'es': 'Informes',
      'sl': 'Poročila',
    },
    'sdt6gjp9': {
      'en': 'Order warehouse',
      'es': 'Almacén de pedidos',
      'sl': 'Skladišče naročil',
    },
    'v0lhge0c': {
      'en': 'Warehouse 2',
      'es': 'Almacén 2',
      'sl': 'Skladišče 2',
    },
    'd6cn5hp1': {
      'en': 'Calendar',
      'es': 'Calendario',
      'sl': 'Koledar',
    },
    'ut34cmou': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    'z543utip': {
      'en': 'Settings',
      'es': 'Ajustes',
      'sl': 'Nastavitve',
    },
    '8oq6xlf3': {
      'en': 'Users',
      'es': 'Usuarios',
      'sl': 'Uporabniki',
    },
    'ncy6lk05': {
      'en': 'Explore',
      'es': 'Explorar',
      'sl': 'Razišči',
    },
    'nohujav5': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    'w6900p22': {
      'en': 'Movements',
      'es': 'Movimientos',
      'sl': 'Gibanja',
    },
    'g72mb9o7': {
      'en': 'Below are the details of your inventory movements.',
      'es':
          'A continuación se muestran los detalles de los movimientos de su inventario.',
      'sl': 'Spodaj so podrobnosti o gibanju vaših zalog.',
    },
    'pv3lclop': {
      'en': 'Updates:',
      'es': 'Actualizaciones:',
      'sl': 'Posodobitve:',
    },
    'vewoecpn': {
      'en': 'Quantity balance:',
      'es': 'Saldo de cantidad:',
      'sl': 'Količinsko stanje:',
    },
    '8yy6j8nm': {
      'en': 'Get csv',
      'es': 'Obtener csv',
      'sl': 'Pridobi CSV',
    },
    'xhqhi36i': {
      'en': 'Customs garantee',
      'es': 'Garantía aduanera',
      'sl': 'Carinska garancija',
    },
    'uusy78oc': {
      'en': 'Order No.',
      'es': 'N.º de pedido',
      'sl': 'Številka naročila',
    },
    'rt73tmk7': {
      'en': 'Burdened guarantee',
      'es': 'Garantía cargada',
      'sl': 'Obremenjeno jamstvo',
    },
    'th9g1ght': {
      'en': 'Free warranty',
      'es': 'Garantía gratuita',
      'sl': 'Brezplačna garancija',
    },
    'q75ko544': {
      'en': 'Threshold',
      'es': 'Límite',
      'sl': 'Prag',
    },
    '8b7rngl0': {
      'en': 'rows...',
      'es': 'filas...',
      'sl': 'vrstice ...',
    },
    'nq8gl8sf': {
      'en': 'Create new record',
      'es': 'Crear nuevo registro',
      'sl': 'Ustvari nov zapis',
    },
  },
  // newForm
  {
    'myvnmlf0': {
      'en': 'Order no',
      'es': 'Número de pedido',
      'sl': 'Številka naročila',
    },
    'ldfv1plb': {
      'en': 'Client:',
      'es': 'Cliente:',
      'sl': 'Stranka:',
    },
    '9mc2zj27': {
      'en': 'Flow:',
      'es': 'Fluir:',
      'sl': 'Pretok:',
    },
    '7grmxm5b': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    'di7y5lpa': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '0g3h7gq5': {
      'en': 'in',
      'es': 'in',
      'sl': 'in',
    },
    'n5lql6na': {
      'en': 'out',
      'es': 'out',
      'sl': 'out',
    },
    '1132s9cq': {
      'en': 'Estimated arrival:',
      'es': 'Llegada estimada:',
      'sl': 'Predviden prihod:',
    },
    'k4mhu65r': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'a5hb87bz': {
      'en': 'Order status:',
      'es': 'Estado del pedido:',
      'sl': 'Stanje naročila:',
    },
    'jr6qta0z': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'y4fpf4e6': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    'hgzypyd3': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'unndup8o': {
      'en': 'novo naročilo',
      'es': 'novo naročilo',
      'sl': 'novo naročilo',
    },
    'z9gmf81o': {
      'en': 'izvajanje',
      'es': 'izvajanje',
      'sl': 'izvajanje',
    },
    'ibvn62lr': {
      'en': 'zaključeno',
      'es': 'zaključeno',
      'sl': 'zaključeno',
    },
    'ywvkhizs': {
      'en': 'Warehouse:',
      'es': 'Depósito:',
      'sl': 'Skladišče:',
    },
    'fm6qf3xz': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    'xe05kxe3': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '30okb5fx': {
      'en': 'Creation date:',
      'es': 'Fecha de creación:',
      'sl': 'Datum nastanka:',
    },
    'jt2mc8hr': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '039jg69s': {
      'en': 'Admin:',
      'es': 'Administración:',
      'sl': 'Skrbnik:',
    },
    'qyibqghv': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '8tx9cb63': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'dpcisrg0': {
      'en': 'Custom:',
      'es': 'Costumbre:',
      'sl': 'Po meri:',
    },
    'sz8wivcn': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'l24yies8': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '26erxt6c': {
      'en': 'Internal reference number custom:',
      'es': 'Número de referencia interno personalizado:',
      'sl': 'Notranja referenčna številka po meri:',
    },
    'x3re6tx1': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'qe3dgydx': {
      'en': 'Internal accounting:',
      'es': 'Contabilidad interna:',
      'sl': 'Notranje računovodstvo:',
    },
    'qftwuxou': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'e01av4ns': {
      'en': 'Documents:',
      'es': 'Documentos:',
      'sl': 'Dokumenti:',
    },
    '3hs1solf': {
      'en': 'Announcement',
      'es': 'Anuncio',
      'sl': 'Objava',
    },
    'romzshty': {
      'en': 'Inventory status:',
      'es': 'Estado del inventario:',
      'sl': 'Stanje zalog:',
    },
    'wn1dupak': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    'pwiquqt1': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'gykf8qmh': {
      'en': 'najava',
      'es': 'najava',
      'sl': 'najava',
    },
    'qbn00ie1': {
      'en': 'obdelava',
      'es': 'obdelava',
      'sl': 'obdelava',
    },
    '3uyshhd2': {
      'en': 'izdano',
      'es': 'izdano',
      'sl': 'izdano',
    },
    'okyefbja': {
      'en': 'zaloga',
      'es': 'zaloga',
      'sl': 'zaloga',
    },
    'ed17h3ad': {
      'en': 'Announced time 1:',
      'es': 'Hora anunciada 1:',
      'sl': 'Napovedani čas 1:',
    },
    'es07apt0': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '9wghks10': {
      'en': 'Arrival:',
      'es': 'Llegada:',
      'sl': 'Prihod:',
    },
    '7g6v0s3v': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '6lwal717': {
      'en': 'Loading gate:',
      'es': 'Puerta de carga:',
      'sl': 'Nakladalna vrata:',
    },
    'mi8kstv2': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'fof47w4s': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '7s32ynah': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'bb9mp7zs': {
      'en': 'Loading gate sequence:',
      'es': 'Secuencia de puerta de carga:',
      'sl': 'Zaporedje nakladalnih vrat:',
    },
    '16a21weo': {
      'en': 'Start (up/unload):',
      'es': 'Inicio (carga/descarga):',
      'sl': 'Zagon (dviganje/razkladanje):',
    },
    '098o0pt1': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'ddugpy9f': {
      'en': 'Stop (up/unload):',
      'es': 'Parada (subir/descargar):',
      'sl': 'Ustavitev (gor/razkladanje):',
    },
    'js5grfcw': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'b8ghglso': {
      'en': 'Sequence, times',
      'es': 'Secuencia, tiempos',
      'sl': 'Zaporedje, časi',
    },
    's45vfdkj': {
      'en': 'Licence plate No:',
      'es': 'Número de matrícula:',
      'sl': 'Številka registrske tablice:',
    },
    'gpck39rz': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'lak26rxi': {
      'en': 'Improvement:',
      'es': 'Mejora:',
      'sl': 'Izboljšanje:',
    },
    'j34oqwfv': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '0odguf8p': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '8071a2hn': {
      'en': 'kont.-20\"',
      'es': 'kont.-20\"',
      'sl': 'kont.-20\"',
    },
    '34iug5uu': {
      'en': 'kont.-40\"',
      'es': 'kont.-40\"',
      'sl': 'kont.-40\"',
    },
    '129g0l33': {
      'en': 'kont.-45\"',
      'es': 'kont.-45\"',
      'sl': 'kont.-45\"',
    },
    'kembf9mg': {
      'en': 'cerada',
      'es': 'cerada',
      'sl': 'cerada',
    },
    '2kkd6x2m': {
      'en': 'hladilnik',
      'es': 'hladilnik',
      'sl': 'hladilnik',
    },
    'ly59xnzd': {
      'en': 'silos',
      'es': 'silos',
      'sl': 'silos',
    },
    'xl522nwl': {
      'en': 'Container no:',
      'es': 'Número de contenedor:',
      'sl': 'Številka posode:',
    },
    '5nnla3ay': {
      'en': 'Unit:',
      'es': 'Unidad:',
      'sl': 'Enota:',
    },
    '7uyhd5vr': {
      'en': 'Weight:',
      'es': 'Peso:',
      'sl': 'Teža:',
    },
    'jirg8wxi': {
      'en': 'Quantity:',
      'es': 'Cantidad:',
      'sl': 'Količina:',
    },
    'id63avle': {
      'en': 'Pallet position:',
      'es': 'Posición del palé:',
      'sl': 'Položaj palete:',
    },
    'o9cihefx': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'hsiy19v2': {
      'en': 'Pre-check:',
      'es': 'Comprobación previa:',
      'sl': 'Predhodno preverjanje:',
    },
    '8a36e68o': {
      'en': 'Check:',
      'es': 'Controlar:',
      'sl': 'Preveri:',
    },
    'ssfgwasr': {
      'en': 'Comment:',
      'es': 'Comentario:',
      'sl': 'Komentar:',
    },
    '6xatlsis': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'etdlfes3': {
      'en': 'Licence, quanitty',
      'es': 'Licencia, cantidad',
      'sl': 'Dovoljenje, količina',
    },
    '8uw73zi6': {
      'en': 'Other manipulations:',
      'es': 'Otras manipulaciones:',
      'sl': 'Druge manipulacije:',
    },
    'y7clk0wz': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'qpx3g0wp': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '34l1ar21': {
      'en': 'paletiranje',
      'es': 'paletiranje',
      'sl': 'paletiranje',
    },
    'qem7bpw9': {
      'en': 'čiščenje',
      'es': 'čiščenje',
      'sl': 'čiščenje',
    },
    'whb9j91g': {
      'en': 'ovijanje-folija',
      'es': 'ovijanje-folija',
      'sl': 'ovijanje-folija',
    },
    'nw3ozokr': {
      'en': 'povezovanje',
      'es': 'povezovanje',
      'sl': 'povezovanje',
    },
    'e6bz7row': {
      'en': 'Type of un/upload:',
      'es': 'Tipo de des/subida:',
      'sl': 'Vrsta nalaganja/odstranjevanja:',
    },
    'hca65qks': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'jftp3h1t': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'x29nan4s': {
      'en': 'viličar',
      'es': 'viličar',
      'sl': 'viličar',
    },
    'bynrr0f1': {
      'en': 'ročno',
      'es': 'ročno',
      'sl': 'ročno',
    },
    '75o5et0g': {
      'en': 'Type of un/upload 2:',
      'es': 'Tipo de des/subida 2:',
      'sl': 'Vrsta nalaganja/odstranjevanja 2:',
    },
    'qd386ml8': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'adeg4msz': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'vna0g45h': {
      'en': 'viličar',
      'es': 'viličar',
      'sl': 'viličar',
    },
    'juoec8wd': {
      'en': 'ročno',
      'es': 'ročno',
      'sl': 'ročno',
    },
    'c5c2cito': {
      'en': 'Responsible:',
      'es': 'Responsable:',
      'sl': 'Odgovorni:',
    },
    '8tqq4n1g': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'bq8tdubc': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '7xmbrzn2': {
      'en': 'Assistant 1:',
      'es': 'Asistente 1:',
      'sl': 'Pomočnik 1:',
    },
    'od2eubec': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'tpeum0wg': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '564exrbi': {
      'en': 'Assistant 2:',
      'es': 'Asistente 2:',
      'sl': 'Pomočnik 2:',
    },
    'idfjwzfs': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'wqztunqs': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'lnpclduy': {
      'en': 'Manipulations, load type',
      'es': 'Manipulaciones, tipo de carga',
      'sl': 'Manipulacije, vrsta obremenitve',
    },
    'g4ebsnyw': {
      'en': 'Universal ref No:',
      'es': 'Número de referencia universal:',
      'sl': 'Univerzalna referenčna št.:',
    },
    'ly4b5rhe': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'pa9bkc30': {
      'en': 'FMS ref:',
      'es': 'Referencia FMS:',
      'sl': 'Referenca FMS:',
    },
    '36iotigb': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'v1o045gm': {
      'en': 'Load ref/dvh:',
      'es': 'Cargar ref/dvh:',
      'sl': 'Naloži ref/dvh:',
    },
    '7ungau0b': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'kmwyuuvy': {
      'en': 'Good:',
      'es': 'Bien:',
      'sl': 'Dobro:',
    },
    'xf0m3jpn': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    '9llhslhe': {
      'en': '',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje predmeta ...',
    },
    'dqsx6w4r': {
      'en': 'Good description:',
      'es': 'Buena descripción:',
      'sl': 'Dober opis:',
    },
    'uncwqt3w': {
      'en': 'Packaging:',
      'es': 'Embalaje:',
      'sl': 'Embalaža:',
    },
    '1bt0leir': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    'x4i4dmmp': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'p1itx1az': {
      'en': 'Barcodes:',
      'es': 'Códigos de barras:',
      'sl': 'Črtne kode:',
    },
    'w74eify8': {
      'en': 'Repeated barcodes:',
      'es': 'Códigos de barras repetidos:',
      'sl': 'Ponavljajoče se črtne kode:',
    },
    'scy84f5u': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'kl8q7db3': {
      'en': 'Non-existent barcodes:',
      'es': 'Códigos de barras inexistentes:',
      'sl': 'Neobstoječe črtne kode:',
    },
    'tj490ibn': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'is6xma3g': {
      'en': 'Goods, ref no, barcodes',
      'es': 'Mercancías, número de referencia, códigos de barras',
      'sl': 'Blago, referenčna št., črtne kode',
    },
    '6q5ack8b': {
      'en': 'Taric code:',
      'es': 'Código Taric:',
      'sl': 'Taric koda:',
    },
    't2twna3b': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'ir968exf': {
      'en': 'Customs %:',
      'es': 'Aduanas %:',
      'sl': 'Carinski %:',
    },
    'uyrwvcnc': {
      'en': 'Velue between 0 and 100',
      'es': 'Velue entre 0 y 100',
      'sl': 'Vrednost med 0 in 100',
    },
    '0zhre3by': {
      'en': '0',
      'es': '0',
      'sl': '0',
    },
    'f6hy2l2o': {
      'en': 'Velue between 0 and 100 is required',
      'es': 'Se requiere un valor entre 0 y 100',
      'sl': 'Zahtevana je vrednost med 0 in 100.',
    },
    'ay7ro51w': {
      'en': 'Velue between 0 and 100 is required',
      'es': 'Se requiere un valor entre 0 y 100',
      'sl': 'Zahtevana je vrednost med 0 in 100.',
    },
    'hzv784tg': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'q7dkw5wb': {
      'en': 'Cost:',
      'es': 'Costo:',
      'sl': 'Stroški:',
    },
    '4kb3622e': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'w5klp87j': {
      'en': '0',
      'es': '0',
      'sl': '0',
    },
    'ymf4bunb': {
      'en': 'Currency:',
      'es': 'Divisa:',
      'sl': 'Valuta:',
    },
    'xy446rk8': {
      'en': 'Dolar',
      'es': 'Dólar',
      'sl': 'Dolar',
    },
    '7tx1wddw': {
      'en': 'Euro',
      'es': 'Euro',
      'sl': 'Evro',
    },
    '53xuxvs7': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '52z682i5': {
      'en': 'Exchange rate:',
      'es': 'Tipo de cambio:',
      'sl': 'Menjalni tečaj:',
    },
    'pxn40vzm': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    'qj6h1wdb': {
      'en': 'Cancel',
      'es': 'Cancelar',
      'sl': 'Prekliči',
    },
    'wvsx06jw': {
      'en': 'SAVE NEW RECORD',
      'es': 'GUARDAR NUEVO RÉCORD',
      'sl': 'SHRANI NOV ZAPIS',
    },
    'wa9slhfj': {
      'en': 'Home',
      'es': 'Hogar',
      'sl': 'Domov',
    },
  },
  // editForm
  {
    'riant0t5': {
      'en': 'CREATE - OUT ORDER',
      'es': 'CREAR - FUERA DE ORDEN',
      'sl': 'USTVARJANJE - IZVEN NAROČILA',
    },
    'xc2ice4w': {
      'en': 'CREATE -IN ORDER',
      'es': 'CREAR -EN ORDEN',
      'sl': 'USTVARITE - PO VRSTU',
    },
    'p35ma2oq': {
      'en': 'Order no',
      'es': 'Número de pedido',
      'sl': 'Številka naročila',
    },
    't5e7aqi8': {
      'en': 'Client:',
      'es': 'Cliente:',
      'sl': 'Stranka:',
    },
    'icy19fot': {
      'en': 'Flow:',
      'es': 'Fluir:',
      'sl': 'Pretok:',
    },
    'wrv1s4i8': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    'jsx751pg': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'fqm22pzs': {
      'en': 'in',
      'es': 'in',
      'sl': 'in',
    },
    'fs6cejc5': {
      'en': 'out',
      'es': 'out',
      'sl': 'out',
    },
    '3uam36q8': {
      'en': 'Estimated arrival:',
      'es': 'Llegada estimada:',
      'sl': 'Predviden prihod:',
    },
    'evbzfwpc': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'x6cazg9f': {
      'en': 'Order status:',
      'es': 'Estado del pedido:',
      'sl': 'Stanje naročila:',
    },
    'ogynrufo': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    '6dc75qmp': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'zcc13gj7': {
      'en': 'novo naročilo',
      'es': 'novo naročilo',
      'sl': 'novo naročilo',
    },
    '2uf6hfin': {
      'en': 'izvajanje',
      'es': 'izvajanje',
      'sl': 'izvajanje',
    },
    '17g7f98a': {
      'en': 'zaključeno',
      'es': 'zaključeno',
      'sl': 'zaključeno',
    },
    'lydepu4j': {
      'en': 'Warehouse:',
      'es': 'Depósito:',
      'sl': 'Skladišče:',
    },
    'zwp9c246': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    '23f18k4n': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'oahcxkmo': {
      'en': 'Creation date:',
      'es': 'Fecha de creación:',
      'sl': 'Datum nastanka:',
    },
    'i6vs95ib': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'zrdnqyb3': {
      'en': 'Admin:',
      'es': 'Administración:',
      'sl': 'Skrbnik:',
    },
    'bql4bmcz': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'rlqjtc4b': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '10h2hpka': {
      'en': 'Custom:',
      'es': 'Costumbre:',
      'sl': 'Po meri:',
    },
    'z9oa2pzm': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    '65gey00l': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'l6nrr7m1': {
      'en': 'Internal reference number custom:',
      'es': 'Número de referencia interno personalizado:',
      'sl': 'Notranja referenčna številka po meri:',
    },
    'l2y1c8df': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'd2zkrsus': {
      'en': 'Internal accounting:',
      'es': 'Contabilidad interna:',
      'sl': 'Notranje računovodstvo:',
    },
    'z7n17dd3': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'u7o35oz5': {
      'en': 'Documents:',
      'es': 'Documentos:',
      'sl': 'Dokumenti:',
    },
    '5xqh9mmb': {
      'en': 'Announcement',
      'es': 'Anuncio',
      'sl': 'Objava',
    },
    'xo6c2pvl': {
      'en': 'Inventory status:',
      'es': 'Estado del inventario:',
      'sl': 'Stanje zalog:',
    },
    'vi9uukv9': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    '1p487xnl': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'dqgnwmgd': {
      'en': 'najava',
      'es': 'najava',
      'sl': 'najava',
    },
    'y332fji4': {
      'en': 'obdelava',
      'es': 'Obdelava',
      'sl': 'obdelava',
    },
    '5xa85p2k': {
      'en': 'izdano',
      'es': 'izdano',
      'sl': 'izdano',
    },
    '7s4qp2ow': {
      'en': 'zaloga',
      'es': 'zaloga',
      'sl': 'zaloga',
    },
    'w9hz2gff': {
      'en': 'Announced time 1:',
      'es': 'Hora anunciada 1:',
      'sl': 'Napovedani čas 1:',
    },
    'g5k2sbou': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '4wbu8b97': {
      'en': 'Arrival:',
      'es': 'Llegada:',
      'sl': 'Prihod:',
    },
    'rqhn41x1': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'o33653rr': {
      'en': 'Loading gate:',
      'es': 'Puerta de carga:',
      'sl': 'Nakladalna vrata:',
    },
    'k9ckuo0u': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    'satvjvpj': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'fs3bib2p': {
      'en': 'Loading gate sequence:',
      'es': 'Secuencia de puerta de carga:',
      'sl': 'Zaporedje nakladalnih vrat:',
    },
    'txvq28xk': {
      'en': 'Start (up/unload):',
      'es': 'Inicio (carga/descarga):',
      'sl': 'Zagon (dviganje/razkladanje):',
    },
    'xiby4v3x': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'e7kuxjnl': {
      'en': 'Stop (up/unload):',
      'es': 'Parada (subir/descargar):',
      'sl': 'Ustavitev (gor/razkladanje):',
    },
    'so066r6i': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'b9tuu7tv': {
      'en': 'Sequence, times',
      'es': 'Secuencia, tiempos',
      'sl': 'Zaporedje, časi',
    },
    'xdjndp41': {
      'en': 'Licence plate No:',
      'es': 'Número de matrícula:',
      'sl': 'Številka registrske tablice:',
    },
    '3hm3qn7w': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'cb2aepry': {
      'en': 'Improvement:',
      'es': 'Mejora:',
      'sl': 'Izboljšanje:',
    },
    'imson3io': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'm3k9nuqy': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'zllit664': {
      'en': 'kont.-20\"',
      'es': 'cont.-20\"',
      'sl': 'kont.-20\"',
    },
    'k3mnizes': {
      'en': 'kont.-40\"',
      'es': 'cont.-40\"',
      'sl': 'kont.-40\"',
    },
    'f1siz9is': {
      'en': 'kont.-45\"',
      'es': 'cont.-45\"',
      'sl': 'kont.-45\"',
    },
    'q2lbc0zu': {
      'en': 'cerada',
      'es': 'cerada',
      'sl': 'cerada',
    },
    '01kdxfmz': {
      'en': 'hladilnik',
      'es': 'hladilnik',
      'sl': 'hladilnik',
    },
    '8y6wmvw5': {
      'en': 'silos',
      'es': 'silos',
      'sl': 'silosi',
    },
    '75pjdeo5': {
      'en': 'Container no:',
      'es': 'Número de contenedor:',
      'sl': 'Številka posode:',
    },
    '8aidjqpy': {
      'en': 'Unit:',
      'es': 'Unidad:',
      'sl': 'Enota:',
    },
    'r13i81v0': {
      'en': 'Weight:',
      'es': 'Peso:',
      'sl': 'Teža:',
    },
    '7nsc6k9p': {
      'en': 'Quantity:',
      'es': 'Cantidad:',
      'sl': 'Količina:',
    },
    'yeaed14k': {
      'en': 'Pallet position:',
      'es': 'Posición del palé:',
      'sl': 'Položaj palete:',
    },
    'cydoa94p': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'wxzlnqbf': {
      'en': 'Pre-check:',
      'es': 'Comprobación previa:',
      'sl': 'Predhodno preverjanje:',
    },
    '4e1cvs2n': {
      'en': 'Check:',
      'es': 'Controlar:',
      'sl': 'Preveri:',
    },
    '4g6a9v3p': {
      'en': 'Comment:',
      'es': 'Comentario:',
      'sl': 'Komentar:',
    },
    'btegr7cb': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'uacnewsy': {
      'en': 'Licence, quanitty',
      'es': 'Licencia, cantidad',
      'sl': 'Dovoljenje, količina',
    },
    'ligugf6y': {
      'en': 'Other manipulations:',
      'es': 'Otras manipulaciones:',
      'sl': 'Druge manipulacije:',
    },
    'z753zthk': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'l1h4a2aj': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'ohaep03c': {
      'en': 'paletiranje',
      'es': 'paletiranje',
      'sl': 'paletiranje',
    },
    'waep7w64': {
      'en': 'čiščenje',
      'es': 'čiščenje',
      'sl': 'čiščenje',
    },
    'bnchlvjj': {
      'en': 'ovijanje-folija',
      'es': 'ovijanje-folija',
      'sl': 'ovijanje-folija',
    },
    'v089iu1d': {
      'en': 'povezovanje',
      'es': 'povezovanje',
      'sl': 'povezovanje',
    },
    '38nrigmd': {
      'en': 'Type of un/upload:',
      'es': 'Tipo de des/subida:',
      'sl': 'Vrsta nalaganja/odstranjevanja:',
    },
    'py7krvs2': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'on9ioyln': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '83ur13q8': {
      'en': 'viličar',
      'es': 'viličar',
      'sl': 'viličar',
    },
    '0vah8el6': {
      'en': 'ročno',
      'es': 'ročno',
      'sl': 'ročno',
    },
    'wc9xhomy': {
      'en': 'Type of un/upload 2:',
      'es': 'Tipo de des/subida 2:',
      'sl': 'Vrsta nalaganja/odstranjevanja 2:',
    },
    'dec6hg5a': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'u3mku87a': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'rpbv21fo': {
      'en': 'viličar',
      'es': 'viličar',
      'sl': 'viličar',
    },
    'nl70dilf': {
      'en': 'ročno',
      'es': 'ročno',
      'sl': 'ročno',
    },
    'jocyivud': {
      'en': 'Responsible:',
      'es': 'Responsable:',
      'sl': 'Odgovorni:',
    },
    '8woojs61': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '9e38vwk7': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '16na3oqv': {
      'en': 'Assistant 1:',
      'es': 'Asistente 1:',
      'sl': 'Pomočnik 1:',
    },
    'r4t02w98': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'cha0sezk': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '0dhtifvc': {
      'en': 'Assistant 2:',
      'es': 'Asistente 2:',
      'sl': 'Pomočnik 2:',
    },
    'efkn8trp': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'ceqo4vrm': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'ujth7i6r': {
      'en': 'Manipulations, load type',
      'es': 'Manipulaciones, tipo de carga',
      'sl': 'Manipulacije, vrsta obremenitve',
    },
    '7gy6tc9r': {
      'en': 'Universal ref No:',
      'es': 'Número de referencia universal:',
      'sl': 'Univerzalna referenčna št.:',
    },
    'jye2bhu7': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'atq3v0jq': {
      'en': 'FMS ref:',
      'es': 'Referencia FMS:',
      'sl': 'Referenca FMS:',
    },
    'jsw0rk28': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'vya267g7': {
      'en': 'Load ref/dvh:',
      'es': 'Cargar ref/dvh:',
      'sl': 'Naloži ref/dvh:',
    },
    '5t8mbrke': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    '2pyzpjsh': {
      'en': 'Good:',
      'es': 'Bien:',
      'sl': 'Dobro:',
    },
    'x1ra8mu5': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    'qso9uy3a': {
      'en': '',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje predmeta ...',
    },
    'eb67z9hu': {
      'en': 'Good description:',
      'es': 'Buena descripción:',
      'sl': 'Dober opis:',
    },
    'mdi3uwks': {
      'en': 'Packaging:',
      'es': 'Embalaje:',
      'sl': 'Embalaža:',
    },
    'v1yy9bh8': {
      'en': '',
      'es': 'Por favor seleccione...',
      'sl': 'Prosim izberite...',
    },
    'tvjhe86k': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '2dxkqi3h': {
      'en': 'Barcodes:',
      'es': 'Códigos de barras:',
      'sl': 'Črtne kode:',
    },
    '2q7uvf6e': {
      'en': 'Repeated barcodes:',
      'es': 'Códigos de barras repetidos:',
      'sl': 'Ponavljajoče se črtne kode:',
    },
    'dkpeutuu': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'k771zg40': {
      'en': 'Non-existent barcodes:',
      'es': 'Códigos de barras inexistentes:',
      'sl': 'Neobstoječe črtne kode:',
    },
    'mp164gpg': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'o8h14uy2': {
      'en': 'Goods, ref no, barcodes',
      'es': 'Mercancías, número de referencia, códigos de barras',
      'sl': 'Blago, referenčna št., črtne kode',
    },
    '5nirw5ip': {
      'en': 'Taric code:',
      'es': 'Código Taric:',
      'sl': 'Taric koda:',
    },
    'rkvoyucf': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'q6jcs1pg': {
      'en': 'Customs %:',
      'es': 'Aduanas %:',
      'sl': 'Carinski %:',
    },
    'pocise0n': {
      'en': 'Velue between 0 and 100',
      'es': 'Velue entre 0 y 100',
      'sl': 'Vrednost med 0 in 100',
    },
    '64iaaaxm': {
      'en': 'Velue between 0 and 100 is required',
      'es': 'Se requiere un valor entre 0 y 100',
      'sl': 'Zahtevana je vrednost med 0 in 100.',
    },
    'y1ecbzlb': {
      'en': 'Velue between 0 and 100 is required',
      'es': 'Se requiere un valor entre 0 y 100',
      'sl': 'Zahtevana je vrednost med 0 in 100.',
    },
    '6mrsclbo': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'bpmbjzyh': {
      'en': 'Cost:',
      'es': 'Costo:',
      'sl': 'Stroški:',
    },
    'ndpigpd5': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    '08wyvwkn': {
      'en': 'Quantity balance:',
      'es': 'Saldo de cantidad:',
      'sl': 'Količinsko stanje:',
    },
    'we5y2zhm': {
      'en': 'Insurance Threshold:',
      'es': 'Umbral de seguro:',
      'sl': 'Prag zavarovanja:',
    },
    'yna74myi': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'z4edj20n': {
      'en': 'Currency:',
      'es': 'Divisa:',
      'sl': 'Valuta:',
    },
    'pn7uysyl': {
      'en': 'Dolar',
      'es': 'Dólar',
      'sl': 'Dolar',
    },
    'hyw891z0': {
      'en': 'Euro',
      'es': 'Euro',
      'sl': 'Evro',
    },
    'jyjqxyg3': {
      'en': 'Exchange rate:',
      'es': 'Tipo de cambio:',
      'sl': 'Menjalni tečaj:',
    },
    'toyo6lqp': {
      'en': 'Today exchange rate:',
      'es': 'Tipo de cambio de hoy:',
      'sl': 'Današnji menjalni tečaj:',
    },
    'ka4ecn1k': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    'szmwfduf': {
      'en': 'print PDF',
      'es': 'imprimir PDF',
      'sl': 'natisni PDF',
    },
    '0lcne31l': {
      'en': 'Cancel',
      'es': 'Cancelar',
      'sl': 'Prekliči',
    },
    'ol5m20hz': {
      'en': 'UPDATE RECORD',
      'es': 'ACTUALIZAR REGISTRO',
      'sl': 'POSODOBITEV ZAPISOV',
    },
    '8uz9wisn': {
      'en': 'Home',
      'es': 'Hogar',
      'sl': 'Domov',
    },
  },
  // details
  {
    'ej3c0qzx': {
      'en': 'Details',
      'es': 'Detalles',
      'sl': 'Podrobnosti',
    },
    'n91zm2rr': {
      'en': 'Orden No:',
      'es': 'Orden No:',
      'sl': 'Številka naročila:',
    },
    'pyz0k5rt': {
      'en': 'Select barcode...',
      'es': 'Seleccione código de barras...',
      'sl': 'Izberite črtno kodo ...',
    },
    '34nyg3g4': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '719rj85w': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
  },
  // forms
  {
    '4w4fampe': {
      'en': 'Edit record',
      'es': 'Editar registro',
      'sl': 'Uredi zapis',
    },
    's2ln34za': {
      'en': 'Announcement',
      'es': 'Anuncio',
      'sl': 'Objava',
    },
    'ixgnt5vg': {
      'en': 'Vehicle, quantity',
      'es': 'Vehículo, cantidad',
      'sl': 'Vozilo, količina',
    },
    'slij6xnt': {
      'en': 'Time, ramp',
      'es': 'Tiempo, rampa',
      'sl': 'Čas, rampa',
    },
    '7mz1zveh': {
      'en': 'Manipulations, warehouses',
      'es': 'Manipulaciones, almacenes',
      'sl': 'Manipulacije, skladišča',
    },
    '06cqog9s': {
      'en': 'Goods, ref. no, barcode',
      'es': 'Mercancía, n.º de referencia, código de barras',
      'sl': 'Blago, referenčna št., črtna koda',
    },
    'tquuujvr': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    '2fq4wgnt': {
      'en': 'Order No:  ',
      'es': 'N.º de pedido:',
      'sl': 'Številka naročila:',
    },
    'ej4ffm0k': {
      'en': 'Client:  ',
      'es': 'Cliente:',
      'sl': 'Stranka:',
    },
    'iaur83ra': {
      'en': 'Input/output:  ',
      'es': 'Entrada/salida:',
      'sl': 'Vhod/izhod:',
    },
    'cocrs8uw': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'beno68e9': {
      'en': 'in',
      'es': 'in',
      'sl': 'in',
    },
    '4f68f0jj': {
      'en': 'out',
      'es': 'out',
      'sl': 'out',
    },
    '0pln6r7m': {
      'en': 'Estimated arrival:  ',
      'es': 'Llegada estimada:',
      'sl': 'Predviden prihod:',
    },
    'er1iflkk': {
      'en': 'Order status:  ',
      'es': 'Estado del pedido:',
      'sl': 'Stanje naročila:',
    },
    '2920vcxf': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'vinazm7z': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '4mm5s45u': {
      'en': 'novo naročilo',
      'es': 'novo naročilo',
      'sl': 'novo naročilo',
    },
    'q8evheu3': {
      'en': 'izvajanje',
      'es': 'izvajanje',
      'sl': 'izvajanje',
    },
    'c7ae11xt': {
      'en': 'zaključeno',
      'es': 'zaključeno',
      'sl': 'zaključeno',
    },
    'rvm1e9wy': {
      'en': 'Warehouse:  ',
      'es': 'Depósito:',
      'sl': 'Skladišče:',
    },
    'uyruzdr8': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '3s4hp8em': {
      'en': 'Creation date:  ',
      'es': 'Fecha de creación:',
      'sl': 'Datum nastanka:',
    },
    'n2o8wfi4': {
      'en': 'Admin:  ',
      'es': 'Administración:',
      'sl': 'Skrbnik:',
    },
    'uh5dxl5p': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'x6to0e7v': {
      'en': 'Custom:  ',
      'es': 'Costumbre:',
      'sl': 'Po meri:',
    },
    'ynfr932b': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'p7usehyk': {
      'en': 'Internal reference number - customs:  ',
      'es': 'Número de referencia interno - aduanas:',
      'sl': 'Interna referenčna številka - carina:',
    },
    'jruby3lr': {
      'en': 'Internal accounting:  ',
      'es': 'Contabilidad interna:',
      'sl': 'Notranje računovodstvo:',
    },
    '52lqeszm': {
      'en': 'Documents:  ',
      'es': 'Documentos:',
      'sl': 'Dokumenti:',
    },
    '51d0v2pi': {
      'en': 'Inventory status:  ',
      'es': 'Estado del inventario:',
      'sl': 'Stanje zalog:',
    },
    'n5adkyve': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'd2ay29dq': {
      'en': 'najava',
      'es': 'najava',
      'sl': 'najava',
    },
    '9mqiqqmd': {
      'en': 'obdelava',
      'es': 'obdelava',
      'sl': 'obdelava',
    },
    'ak1nrnrl': {
      'en': 'izdano',
      'es': 'izdano',
      'sl': 'izdano',
    },
    'ck4ekony': {
      'en': 'zaloga',
      'es': 'zaloga',
      'sl': 'zaloga',
    },
    'g5m6fbuf': {
      'en': 'Announced time 1:  ',
      'es': 'Hora anunciada 1:',
      'sl': 'Napovedani čas 1:',
    },
    'uoxtbao7': {
      'en': 'Announced time 2:  ',
      'es': 'Hora anunciada 2:',
      'sl': 'Napovedani čas 2:',
    },
    'b63594nl': {
      'en': 'Arrival:  ',
      'es': 'Llegada:',
      'sl': 'Prihod:',
    },
    '7pkfn8ib': {
      'en': 'Loading gate:  ',
      'es': 'Puerta de carga:',
      'sl': 'Nakladalna vrata:',
    },
    'o6gubyim': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'ggnfr75d': {
      'en': 'Loading gate sequence:  ',
      'es': 'Secuencia de puerta de carga:',
      'sl': 'Zaporedje nakladalnih vrat:',
    },
    '5b3d3y3h': {
      'en': 'Start (upload/unload):  ',
      'es': 'Inicio (carga/descarga):',
      'sl': 'Začetek (nalaganje/razlaganje):',
    },
    'p0vxwlax': {
      'en': 'Stop (upload/unload):  ',
      'es': 'Parada (carga/descarga):',
      'sl': 'Ustavi (nalaganje/razkladanje):',
    },
    'jsq2xkyk': {
      'en': 'Licence plate No:  ',
      'es': 'Número de matrícula:',
      'sl': 'Številka registrske tablice:',
    },
    'e0d8yka2': {
      'en': 'Improvement:  ',
      'es': 'Mejora:',
      'sl': 'Izboljšanje:',
    },
    '9c8qpw3n': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'l8k0xuaf': {
      'en': 'kont.-20\"',
      'es': 'kont.-20\"',
      'sl': 'kont.-20\"',
    },
    '4citue3o': {
      'en': 'kont.-40\"',
      'es': 'kont.-40\"',
      'sl': 'kont.-40\"',
    },
    '4y1sq1d7': {
      'en': 'kont.-45\"',
      'es': 'kont.-45\"',
      'sl': 'kont.-45\"',
    },
    '2572s363': {
      'en': 'cerada',
      'es': 'cerada',
      'sl': 'cerada',
    },
    'aj0w8yyo': {
      'en': 'hladilnik',
      'es': 'hladilnik',
      'sl': 'hladilnik',
    },
    'onw3427g': {
      'en': 'silos',
      'es': 'silos',
      'sl': 'silos',
    },
    '241xgsk0': {
      'en': 'Container No:  ',
      'es': 'Contenedor No:',
      'sl': 'Številka posode:',
    },
    '1luorh6t': {
      'en': 'Comment:  ',
      'es': 'Comentario:',
      'sl': 'Komentar:',
    },
    '2x6bir61': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    '6v4a337z': {
      'en': 'Quantity:  ',
      'es': 'Cantidad:',
      'sl': 'Količina:',
    },
    'n93uyp2z': {
      'en': 'Pallet position:  ',
      'es': 'Posición del palé:',
      'sl': 'Položaj palete:',
    },
    '963ibpdr': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'bbrh0h2w': {
      'en': 'Pre - Check:  ',
      'es': 'Pre-comprobación:',
      'sl': 'Predhodno preverjanje:',
    },
    '8c0v3o3c': {
      'en': 'Check:  ',
      'es': 'Controlar:',
      'sl': 'Preveri:',
    },
    'x7scfgzz': {
      'en': 'Unit:  ',
      'es': 'Unidad:',
      'sl': 'Enota:',
    },
    '3lpe3obr': {
      'en': 'Weight:  ',
      'es': 'Peso:',
      'sl': 'Teža:',
    },
    'swxjzyjy': {
      'en': 'Other manipulations:  ',
      'es': 'Otras manipulaciones:',
      'sl': 'Druge manipulacije:',
    },
    'iep49uhs': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '1nhh5v4p': {
      'en': 'paletiranje',
      'es': 'paletiranje',
      'sl': 'paletiranje',
    },
    '0hdkxipi': {
      'en': 'čiščenje',
      'es': 'čiščenje',
      'sl': 'čiščenje',
    },
    'dicagqab': {
      'en': 'ovijanje-folija',
      'es': 'ovijanje-folija',
      'sl': 'ovijanje-folija',
    },
    'jvt03f0c': {
      'en': 'povezovanje',
      'es': 'povezovanje',
      'sl': 'povezovanje',
    },
    'k3bvaxvd': {
      'en': 'Type of un/upload:  ',
      'es': 'Tipo de des/subida:',
      'sl': 'Vrsta nalaganja/odstranjevanja:',
    },
    'gc8cy7x7': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'c1g1mv1p': {
      'en': 'viličar',
      'es': 'viličar',
      'sl': 'viličar',
    },
    'xt5iyzud': {
      'en': 'ročno',
      'es': 'ročno',
      'sl': 'ročno',
    },
    '4ys80k7p': {
      'en': 'Type of un/upload 2:  ',
      'es': 'Tipo de des/subida 2:',
      'sl': 'Vrsta nalaganja/odstranjevanja 2:',
    },
    'qxb7w2sx': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'dfdjkscf': {
      'en': 'viličar',
      'es': 'viličar',
      'sl': 'viličar',
    },
    'gaxkwc6b': {
      'en': 'ročno',
      'es': 'ročno',
      'sl': 'ročno',
    },
    'nnew7c7t': {
      'en': 'Responsible: ',
      'es': 'Responsable:',
      'sl': 'Odgovorni:',
    },
    '5j26f3oh': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'rxkrrxst': {
      'en': 'Assistant 1:  ',
      'es': 'Asistente 1:',
      'sl': 'Pomočnik 1:',
    },
    'w00it0yk': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'odfaa90q': {
      'en': 'Assistant 2:  ',
      'es': 'Asistente 2:',
      'sl': 'Pomočnik 2:',
    },
    '86gnzb1r': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '42o4cwkv': {
      'en': 'Assistant 3:  ',
      'es': 'Asistente 3:',
      'sl': 'Pomočnik 3:',
    },
    'y9wemh7m': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'uxlc78ll': {
      'en': 'Assistant 4:  ',
      'es': 'Asistente 4:',
      'sl': 'Pomočnik 4:',
    },
    'cyhz6mld': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'dh2jv6vo': {
      'en': 'Assistant 5:  ',
      'es': 'Asistente 5:',
      'sl': 'Pomočnik 5:',
    },
    '2rezj3dd': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'iigw54yp': {
      'en': 'Assistant 6:  ',
      'es': 'Asistente 6:',
      'sl': 'Pomočnik 6:',
    },
    'gvqo5j88': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '27brn9o8': {
      'en': 'Universal ref num:  ',
      'es': 'Número de referencia universal:',
      'sl': 'Univerzalna referenčna številka:',
    },
    'w2vc2fpp': {
      'en': 'FMS ref:  ',
      'es': 'Referencia FMS:',
      'sl': 'Referenca FMS:',
    },
    'qx5ac8t1': {
      'en': 'Load ref/dvh:  ',
      'es': 'Cargar ref/dvh:',
      'sl': 'Naloži ref/dvh:',
    },
    'xcuhjh74': {
      'en': 'Good:  ',
      'es': 'Bien:',
      'sl': 'Dobro:',
    },
    'nstuvhay': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '6f042ri4': {
      'en': 'Item description:',
      'es': 'Descripción del artículo:',
      'sl': 'Opis artikla:',
    },
    '18qvpp0q': {
      'en': 'Packaging:  ',
      'es': 'Embalaje:',
      'sl': 'Embalaža:',
    },
    '2gywf2o3': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'spunb0qj': {
      'en': 'Barcodes:  ',
      'es': 'Códigos de barras:',
      'sl': 'Črtne kode:',
    },
    'x1apz81p': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'm7gpyzpy': {
      'en': 'Repeated barcodes:  ',
      'es': 'Códigos de barras repetidos:',
      'sl': 'Ponavljajoče se črtne kode:',
    },
    's7iw07q6': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'u3jax3cb': {
      'en': 'Non-existent barcodes:  ',
      'es': 'Códigos de barras inexistentes:',
      'sl': 'Neobstoječe črtne kode:',
    },
    'wh7caubp': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'hynfks1q': {
      'en': 'Taric code:  ',
      'es': 'Código Taric:',
      'sl': 'Taric koda:',
    },
    'gqg8cd2q': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'cpgkypfq': {
      'en': 'Customs %:  ',
      'es': 'Aduanas %:',
      'sl': 'Carinski %:',
    },
    '7wp40f2e': {
      'en': 'Value between 0 and 100',
      'es': 'Valor entre 0 y 100',
      'sl': 'Vrednost med 0 in 100',
    },
    'aykejmha': {
      'en': 'Cost:  ',
      'es': 'Costo:',
      'sl': 'Stroški:',
    },
    'y1s1edcn': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    '8su4w4ph': {
      'en': 'Currency: ',
      'es': 'Divisa:',
      'sl': 'Valuta:',
    },
    'vqtq9jnm': {
      'en': 'Dolar',
      'es': 'Dólar',
      'sl': 'Dolar',
    },
    '4k3rj4dp': {
      'en': 'Euro',
      'es': 'Euro',
      'sl': 'Evro',
    },
    'z4rr18as': {
      'en': 'Exchange rate:  ',
      'es': 'Tipo de cambio:',
      'sl': 'Menjalni tečaj:',
    },
    'v1jmv6hh': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    '2u5y5xg9': {
      'en': 'taric_code is required',
      'es': 'Se requiere taric_code',
      'sl': 'Taric_code je obvezen element',
    },
    '7a59b191': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'yrxc7nar': {
      'en': 'Value between 0 and 100 is required',
      'es': 'Se requiere un valor entre 0 y 100',
      'sl': 'Zahtevana je vrednost med 0 in 100.',
    },
    'r003tiua': {
      'en': 'Velue between 0 and 100 is required',
      'es': 'Se requiere un valor entre 0 y 100',
      'sl': 'Zahtevana je vrednost med 0 in 100.',
    },
    'x48t0duo': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    '7ftltl7i': {
      'en': 'init_cost is required',
      'es': 'init_cost es obligatorio',
      'sl': 'Polje init_cost je obvezno',
    },
    'os1eq1h2': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'm9ajwem6': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'fxqac531': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'kgb68azj': {
      'en': 'Save changes',
      'es': 'Guardar cambios',
      'sl': 'Shrani spremembe',
    },
  },
  // sureQuery
  {
    '2b7kj1vi': {
      'en': 'Are you sure?',
      'es': '¿Está seguro?',
      'sl': 'Si prepričan/a?',
    },
    'd0fh7lyk': {
      'en': 'Yes',
      'es': 'Sí',
      'sl': 'Da',
    },
    'wb1becmn': {
      'en': 'No',
      'es': 'No',
      'sl': 'Ne',
    },
  },
  // editDetails
  {
    'j79j5yyd': {
      'en': 'Edit record',
      'es': 'Editar registro',
      'sl': 'Uredi zapis',
    },
    'eby9i6es': {
      'en': 'Good:  ',
      'es': 'Bien:',
      'sl': 'Dobro:',
    },
    'zwxjnc97': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    '7piqz5sc': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'qfqrlwsg': {
      'en': 'Description:  ',
      'es': 'Descripción:',
      'sl': 'Opis:',
    },
    '67o19ah6': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'uloafuuz': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'q3fbzpds': {
      'en': 'Packaging:  ',
      'es': 'Embalaje:',
      'sl': 'Embalaža:',
    },
    'dp689g4e': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'slwgvnbp': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '2pmsi25l': {
      'en': 'Warehouse position:  ',
      'es': 'Posición del almacén:',
      'sl': 'Položaj skladišča:',
    },
    'qpecaokf': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'b01g0obk': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'ebn4opmu': {
      'en': 'Barcode:  ',
      'es': 'Código de barras:',
      'sl': 'Črtna koda:',
    },
    'orv8tifl': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'mor3o7pl': {
      'en': 'Save changes',
      'es': 'Guardar cambios',
      'sl': 'Shrani spremembe',
    },
  },
  // clientsTF
  {
    'tfcqb0zh': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
  },
  // editClients
  {
    '2g5zhl8k': {
      'en': 'Client details',
      'es': 'Datos del cliente',
      'sl': 'Podrobnosti o stranki',
    },
    'j8d5n29t': {
      'en': 'Client:  ',
      'es': 'Cliente:',
      'sl': 'Stranka:',
    },
    '2d19wu1s': {
      'en': 'Address:  ',
      'es': 'DIRECCIÓN:',
      'sl': 'Naslov:',
    },
    '8mh3bzf7': {
      'en': 'City:  ',
      'es': 'Ciudad:',
      'sl': 'Mesto:',
    },
    '0ybgfuw5': {
      'en': 'Country:  ',
      'es': 'País:',
      'sl': 'Država:',
    },
    'm7pcjtgw': {
      'en': 'Name aiss:  ',
      'es': 'Nombre aiss:',
      'sl': 'Ime aiss:',
    },
    'jpkyman4': {
      'en': 'Vat no:  ',
      'es': 'N.º de IVA:',
      'sl': 'DDV št.:',
    },
    'zp0khhb7': {
      'en': 'Save changes',
      'es': 'Guardar cambios',
      'sl': 'Shrani spremembe',
    },
  },
  // customsTF
  {
    'va0e7fje': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
  },
  // goodsTF
  {
    '28p1yis3': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
  },
  // goodsDescriptionsTF
  {
    'x40isfgi': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
  },
  // editPackaging
  {
    'x0hs380u': {
      'en': 'Packaging details',
      'es': 'Detalles del embalaje',
      'sl': 'Podrobnosti o embalaži',
    },
    'mb8km6s7': {
      'en': 'Packaging:  ',
      'es': 'Embalaje:',
      'sl': 'Embalaža:',
    },
    'x6cs6pqp': {
      'en': 'Abbreviation:  ',
      'es': 'Abreviatura:',
      'sl': 'Okrajšava:',
    },
    'wfvsoosu': {
      'en': 'Save changes',
      'es': 'Guardar cambios',
      'sl': 'Shrani spremembe',
    },
  },
  // warehouseDetails
  {
    'dcyr07l8': {
      'en': 'Warehouse details',
      'es': 'Detalles del almacén',
      'sl': 'Podrobnosti o skladišču',
    },
    'cpabvyqv': {
      'en': 'Warehouse positions',
      'es': 'Puestos de almacén',
      'sl': 'Delovna mesta v skladišču',
    },
    'tffmk5em': {
      'en': 'Position',
      'es': 'Posición',
      'sl': 'Položaj',
    },
    'j7v7zf4e': {
      'en': 'Loading gates',
      'es': 'Puertas de carga',
      'sl': 'Nakladalna vrata',
    },
    'jiqtvl3p': {
      'en': 'Ramp',
      'es': 'Rampa',
      'sl': 'Klančina',
    },
  },
  // warehousePositionsTF
  {
    'bm78l3b3': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
  },
  // loadingGatesTF
  {
    '2rk32fe5': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
  },
  // manipulationsTF
  {
    '2adki1rz': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
  },
  // createRecord
  {
    'icazai1q': {
      'en': 'Create record',
      'es': 'Crear registro',
      'sl': 'Ustvari zapis',
    },
    'awyh9clr': {
      'en': 'Announcement',
      'es': 'Anuncio',
      'sl': 'Objava',
    },
    'oqag4g4z': {
      'en': 'Vehicle, quantity',
      'es': 'Vehículo, cantidad',
      'sl': 'Vozilo, količina',
    },
    '7gxoffrz': {
      'en': 'Time, ramp',
      'es': 'Tiempo, rampa',
      'sl': 'Čas, rampa',
    },
    'ciz89uu4': {
      'en': 'Manipulations, warehouses',
      'es': 'Manipulaciones, almacenes',
      'sl': 'Manipulacije, skladišča',
    },
    'c28mc4jt': {
      'en': 'Goods, ref. no, barcode',
      'es': 'Mercancía, ref. n.°, código de barras',
      'sl': 'Blago, referenčna št., črtna koda',
    },
    'ooalmxgf': {
      'en': 'Customs',
      'es': 'Aduanas',
      'sl': 'Carina',
    },
    'ky1fkyq8': {
      'en': 'Order No:  ',
      'es': 'N.º de pedido:',
      'sl': 'Številka naročila:',
    },
    'd4pgq4wh': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'n4lv60m3': {
      'en': 'Client:  ',
      'es': 'Cliente:',
      'sl': 'Stranka:',
    },
    '4t7wu43q': {
      'en': 'Input/output:  ',
      'es': 'Entrada/salida:',
      'sl': 'Vhod/izhod:',
    },
    '1hn2bb2c': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    '7ng7rqd2': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'mb6t6xsl': {
      'en': 'in',
      'es': 'in',
      'sl': 'in',
    },
    'uhas6n8o': {
      'en': 'out',
      'es': 'out',
      'sl': 'out',
    },
    'u3y2wa25': {
      'en': 'Estimated arrival:  ',
      'es': 'Llegada estimada:',
      'sl': 'Predviden prihod:',
    },
    'mdnjx34b': {
      'en': 'Order status:  ',
      'es': 'Estado del pedido:',
      'sl': 'Stanje naročila:',
    },
    'w7oxraah': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'wa3dr3qi': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'a4hkbbbs': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '6gbetm8e': {
      'en': 'novo naročilo',
      'es': 'novo naročilo',
      'sl': 'novo naročilo',
    },
    'u24qhs2i': {
      'en': 'izvajanje',
      'es': 'izvajanje',
      'sl': 'izvajanje',
    },
    'qld2hdoq': {
      'en': 'zaključeno',
      'es': 'zaključeno',
      'sl': 'zaključeno',
    },
    'yf58ods0': {
      'en': 'Warehouse:  ',
      'es': 'Depósito:',
      'sl': 'Skladišče:',
    },
    '2oi66ola': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'p9h1yasj': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'gyl4et1g': {
      'en': 'Creation date:  ',
      'es': 'Fecha de creación:',
      'sl': 'Datum nastanka:',
    },
    '3i8fpg3s': {
      'en': 'Admin:  ',
      'es': 'Administración:',
      'sl': 'Skrbnik:',
    },
    'o51pbopf': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'rsbq7dpb': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'wtl5gquy': {
      'en': 'Custom:  ',
      'es': 'Costumbre:',
      'sl': 'Po meri:',
    },
    'npwrukop': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    '6o1amf6g': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'y9nlr7l1': {
      'en': 'Internal reference number - customs:  ',
      'es': 'Número de referencia interno - aduanas:',
      'sl': 'Interna referenčna številka - carina:',
    },
    'nwod5dwl': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'u8csng2w': {
      'en': 'Internal number - accounting:  ',
      'es': 'Número interno - contabilidad:',
      'sl': 'Interna številka - računovodstvo:',
    },
    'jnxu2lw2': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    '97flenab': {
      'en': 'Documents:  ',
      'es': 'Documentos:',
      'sl': 'Dokumenti:',
    },
    'jfdgfk2h': {
      'en': 'Inventory status:  ',
      'es': 'Estado del inventario:',
      'sl': 'Stanje zalog:',
    },
    '1xbyxef0': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'jrmz0qkd': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'm6u9emjf': {
      'en': 'najava',
      'es': 'najava',
      'sl': 'najava',
    },
    'muuxrfd4': {
      'en': 'obdelava',
      'es': 'Obdelava',
      'sl': 'obdelava',
    },
    '8hy4f85f': {
      'en': 'izdano',
      'es': 'izdano',
      'sl': 'izdano',
    },
    'fsquvroe': {
      'en': 'zaloga',
      'es': 'zaloga',
      'sl': 'zaloga',
    },
    'byxykt3p': {
      'en': 'Announced time 1:  ',
      'es': 'Hora anunciada 1:',
      'sl': 'Napovedani čas 1:',
    },
    '5jx8ei1h': {
      'en': 'Arrival:  ',
      'es': 'Llegada:',
      'sl': 'Prihod:',
    },
    '7n1wz3dg': {
      'en': 'RAMPA:  ',
      'es': 'RAMPA:',
      'sl': 'RAMPA:',
    },
    'o1s3lijj': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'u0463ju1': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '2wf0bwqi': {
      'en': 'Loading gate sequence:  ',
      'es': 'Secuencia de puerta de carga:',
      'sl': 'Zaporedje nakladalnih vrat:',
    },
    'h6ak5k8v': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'zgrpo3te': {
      'en': 'Start (upload/unload):  ',
      'es': 'Inicio (carga/descarga):',
      'sl': 'Začetek (nalaganje/razlaganje):',
    },
    'bjs4ou59': {
      'en': 'Stop (upload/unload):  ',
      'es': 'Parada (carga/descarga):',
      'sl': 'Ustavi (nalaganje/razkladanje):',
    },
    '7o7laf2a': {
      'en': 'Licence plate No:  ',
      'es': 'Número de matrícula:',
      'sl': 'Številka registrske tablice:',
    },
    '040ubt2z': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    '8l4ktgnn': {
      'en': 'Improvement:  ',
      'es': 'Mejora:',
      'sl': 'Izboljšanje:',
    },
    'ipq9i6k0': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'oo7imzeb': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '2imyah2q': {
      'en': 'kont.-20\"',
      'es': 'cont.-20\"',
      'sl': 'kont.-20\"',
    },
    'zwo8ap52': {
      'en': 'kont.-40\"',
      'es': 'cont.-40\"',
      'sl': 'kont.-40\"',
    },
    '41rqmaea': {
      'en': 'kont.-45\"',
      'es': 'cont.-45\"',
      'sl': 'kont.-45\"',
    },
    '2hadsask': {
      'en': 'cerada',
      'es': 'cerada',
      'sl': 'cerada',
    },
    'k97naf92': {
      'en': 'hladilnik',
      'es': 'hladilnik',
      'sl': 'hladilnik',
    },
    'cvptjha4': {
      'en': 'silos',
      'es': 'silos',
      'sl': 'silosi',
    },
    'otst498k': {
      'en': 'Container No:  ',
      'es': 'Contenedor No:',
      'sl': 'Številka posode:',
    },
    'mq0tkjys': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'y9prqowd': {
      'en': 'Comment:  ',
      'es': 'Comentario:',
      'sl': 'Komentar:',
    },
    'jutridg4': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'z0krpsur': {
      'en': 'Quantity:  ',
      'es': 'Cantidad:',
      'sl': 'Količina:',
    },
    'z0zeitio': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'xhr03gwm': {
      'en': 'Pallet position:  ',
      'es': 'Posición del palé:',
      'sl': 'Položaj palete:',
    },
    'kwuyrj9a': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'od7hk99b': {
      'en': 'Unit:  ',
      'es': 'Unidad:',
      'sl': 'Enota:',
    },
    '913l23f5': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'yx7l9lto': {
      'en': 'Weight:  ',
      'es': 'Peso:',
      'sl': 'Teža:',
    },
    'c0ibmp0t': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'ht9lg19b': {
      'en': 'Other manipulations:  ',
      'es': 'Otras manipulaciones:',
      'sl': 'Druge manipulacije:',
    },
    '9ulabaix': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    '041hw8ml': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'v0605lcd': {
      'en': 'paletiranje',
      'es': 'paletiranje',
      'sl': 'paletiranje',
    },
    'tmtr4y35': {
      'en': 'čiščenje',
      'es': 'čiščenje',
      'sl': 'čiščenje',
    },
    '5khc979z': {
      'en': 'ovijanje-folija',
      'es': 'ovijanje-folija',
      'sl': 'ovijanje-folija',
    },
    'z88b9v9x': {
      'en': 'povezovanje',
      'es': 'povezovanje',
      'sl': 'povezovanje',
    },
    '4gp0ce5z': {
      'en': 'Type of un/upload:  ',
      'es': 'Tipo de des/subida:',
      'sl': 'Vrsta nalaganja/odstranjevanja:',
    },
    'ukdhot6n': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    '0adkqdb5': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'dmx4t6wo': {
      'en': 'viličar',
      'es': 'viličar',
      'sl': 'viličar',
    },
    'e2m4u9ep': {
      'en': 'ročno',
      'es': 'ročno',
      'sl': 'ročno',
    },
    '7ydq3891': {
      'en': 'Type of un/upload 2:  ',
      'es': 'Tipo de des/subida 2:',
      'sl': 'Vrsta nalaganja/odstranjevanja 2:',
    },
    'ts5hctjo': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'olzhk09c': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'fx5olq4n': {
      'en': 'viličar',
      'es': 'viličar',
      'sl': 'viličar',
    },
    'jq0mat9m': {
      'en': 'ročno',
      'es': 'ročno',
      'sl': 'ročno',
    },
    'zytdv2ys': {
      'en': 'Responsible: ',
      'es': 'Responsable:',
      'sl': 'Odgovorni:',
    },
    'wxjgz326': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'u80efgss': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'jnlfkmmw': {
      'en': 'Assistant 1:  ',
      'es': 'Asistente 1:',
      'sl': 'Pomočnik 1:',
    },
    'csazqy88': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'yhfsslm2': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    's426vfgc': {
      'en': 'Assistant 2:  ',
      'es': 'Asistente 2:',
      'sl': 'Pomočnik 2:',
    },
    'swcholxu': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    'qg1iiw0j': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'jgpsl4dd': {
      'en': 'Assistant 3:  ',
      'es': 'Asistente 3:',
      'sl': 'Pomočnik 3:',
    },
    'hlv8vfr3': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    't1v9iowk': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '661m7b63': {
      'en': 'Universal ref num:  ',
      'es': 'Número de referencia universal:',
      'sl': 'Univerzalna referenčna številka:',
    },
    '7ucthrgi': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'uzqbwrs4': {
      'en': 'FMS ref:  ',
      'es': 'Referencia FMS:',
      'sl': 'Referenca FMS:',
    },
    '4eyjotd7': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'm83558ve': {
      'en': 'Load ref/dvh:  ',
      'es': 'Cargar ref/dvh:',
      'sl': 'Naloži ref/dvh:',
    },
    'rifu34tn': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'gv7oe9hp': {
      'en': 'Good:  ',
      'es': 'Bien:',
      'sl': 'Dobro:',
    },
    'u695q7kd': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    's4gle6c6': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'hrowwhe2': {
      'en': 'Good description:  ',
      'es': 'Buena descripción:',
      'sl': 'Dober opis:',
    },
    '3vtdt1fk': {
      'en': 'Packaging:  ',
      'es': 'Embalaje:',
      'sl': 'Embalaža:',
    },
    'jlucklwu': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
      'sl': 'Prosimo, izberite ...',
    },
    '3p880det': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '2bivx6rb': {
      'en': 'Barcodes:  ',
      'es': 'Códigos de barras:',
      'sl': 'Črtne kode:',
    },
    'pk58e2bi': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'z40ar5s9': {
      'en': 'Taric code:  ',
      'es': 'Código Taric:',
      'sl': 'Taric koda:',
    },
    'ternrdmy': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'wfytc1iz': {
      'en': 'Customs %:  ',
      'es': 'Aduanas %:',
      'sl': 'Carinski %:',
    },
    'wgfmj8dy': {
      'en': 'Velue between 0 and 100',
      'es': 'Velue entre 0 y 100',
      'sl': 'Vrednost med 0 in 100',
    },
    'apawljvd': {
      'en': 'Cost:  ',
      'es': 'Costo:',
      'sl': 'Stroški:',
    },
    '6rqptsli': {
      'en': 'Insert new value...',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    '4iqt6d3v': {
      'en': 'Currency: ',
      'es': 'Divisa:',
      'sl': 'Valuta:',
    },
    'ewr16mhb': {
      'en': 'Dolar',
      'es': 'Dólar',
      'sl': 'Dolar',
    },
    '3tptor1h': {
      'en': 'Euro',
      'es': 'Euro',
      'sl': 'Evro',
    },
    'lfuju0vj': {
      'en': 'Exchange rate:  ',
      'es': 'Tipo de cambio:',
      'sl': 'Menjalni tečaj:',
    },
    'vm2va5wg': {
      'en': '',
      'es': 'Insertar nuevo valor...',
      'sl': 'Vstavi novo vrednost ...',
    },
    'jlj2a4kj': {
      'en': 'Insert new value... is required',
      'es': 'Insertar nuevo valor... es obligatorio',
      'sl': 'Vstavi novo vrednost ... je obvezno',
    },
    'ag5x2fms': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'yhc6wi7h': {
      'en': 'Velue between 0 and 100 is required',
      'es': 'Se requiere un valor entre 0 y 100',
      'sl': 'Zahtevana je vrednost med 0 in 100.',
    },
    'fbv5w8q1': {
      'en': 'Velue between 0 and 100 is required',
      'es': 'Se requiere un valor entre 0 y 100',
      'sl': 'Zahtevana je vrednost med 0 in 100.',
    },
    'ia1iimip': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'exo8eif2': {
      'en': 'Insert new value... is required',
      'es': 'Insertar nuevo valor... es obligatorio',
      'sl': 'Vstavi novo vrednost ... je obvezno',
    },
    'gtki1058': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    '2ker9n6k': {
      'en': 'todayExchangeType is required',
      'es': 'todayExchangeType es obligatorio',
      'sl': 'Vrsta menjave danes je obvezna',
    },
    'j21jbt2u': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'xhdbltbx': {
      'en': 'Save changes',
      'es': 'Guardar cambios',
      'sl': 'Shrani spremembe',
    },
  },
  // documents
  {
    'dfjn6g41': {
      'en': 'Documents',
      'es': 'Documentos',
      'sl': 'Dokumenti',
    },
    '0a2yk14h': {
      'en': 'Pdf',
      'es': 'PDF',
      'sl': 'PDF',
    },
    'url3h1t4': {
      'en': 'Name',
      'es': 'Nombre',
      'sl': 'Ime',
    },
  },
  // userDetails
  {
    'q2ttw3nx': {
      'en': 'Log out',
      'es': 'Finalizar la sesión',
      'sl': 'Odjava',
    },
  },
  // newWarehouse
  {
    'o97erejm': {
      'en': 'Warehouse: ',
      'es': 'Depósito:',
      'sl': 'Skladišče:',
    },
    'p1lfr17r': {
      'en': 'New warehouse...',
      'es': 'Nuevo almacén...',
      'sl': 'Novo skladišče ...',
    },
  },
  // newClient
  {
    'h6jtdngy': {
      'en': 'Client:  ',
      'es': 'Cliente:',
      'sl': 'Stranka:',
    },
    '1px7ctty': {
      'en': 'New client...',
      'es': 'Nuevo cliente...',
      'sl': 'Nova stranka ...',
    },
    'sjbvje91': {
      'en': 'Address: ',
      'es': 'DIRECCIÓN:',
      'sl': 'Naslov:',
    },
    'vz4q8jsk': {
      'en': 'New address...',
      'es': 'Nueva dirección...',
      'sl': 'Nov naslov ...',
    },
    '65cnxij8': {
      'en': 'City: ',
      'es': 'Ciudad:',
      'sl': 'Mesto:',
    },
    'enfhsq8e': {
      'en': 'New city...',
      'es': 'Nueva ciudad...',
      'sl': 'Novo mesto ...',
    },
    'kj7tuqhy': {
      'en': 'Country: ',
      'es': 'País:',
      'sl': 'Država:',
    },
    'dljeiog1': {
      'en': 'New country...',
      'es': 'Nuevo país...',
      'sl': 'Nova država ...',
    },
    'eslqukvn': {
      'en': 'Name aiss: ',
      'es': 'Nombre aiss:',
      'sl': 'Ime aiss:',
    },
    'mdbs2xhl': {
      'en': 'New name aiss...',
      'es': 'Nuevo nombre aiss...',
      'sl': 'Novo ime ...',
    },
    'jm18165z': {
      'en': 'Vat no: ',
      'es': 'N.º de IVA:',
      'sl': 'DDV št.:',
    },
    'tem12gym': {
      'en': 'New vat no...',
      'es': 'Nuevo n.º de IVA...',
      'sl': 'Nova številka DDV ...',
    },
    'h1eq3lya': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'j76z399g': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'h6pnjwkz': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'eerv76l0': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'rtp7499s': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'js7r29h2': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'ohi3ikuc': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'fw0xj1uq': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    '44nfv83y': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    '6cw4jtvg': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    '5oph71lk': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    '2scpc0r9': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
  },
  // newCustom
  {
    'gfr0zflc': {
      'en': 'Custom: ',
      'es': 'Costumbre:',
      'sl': 'Po meri:',
    },
    'cnq234w7': {
      'en': 'New custom...',
      'es': 'Nueva costumbre...',
      'sl': 'Nova po meri ...',
    },
    'u5vics5e': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'jtaa65zm': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
  },
  // newGoodDescription
  {
    'qbsp1a8h': {
      'en': 'Description: ',
      'es': 'Descripción:',
      'sl': 'Opis:',
    },
    'kmm0hkye': {
      'en': 'New description...',
      'es': 'Nueva descripción...',
      'sl': 'Nov opis ...',
    },
    'dj9hrp0p': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'yu78z8qo': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
  },
  // newGood
  {
    'xwu1uyct': {
      'en': 'Good: ',
      'es': 'Bien:',
      'sl': 'Dobro:',
    },
    '2un22j9z': {
      'en': 'New good...',
      'es': 'Nuevo bueno...',
      'sl': 'Novo dobro ...',
    },
    'sq2f2k0w': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    '64b7o6um': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
  },
  // newLoadingGate1
  {
    '95q7dja7': {
      'en': 'Warehouse: ',
      'es': 'Depósito:',
      'sl': 'Skladišče:',
    },
    '3696mz9p': {
      'en': 'Select warehouse...',
      'es': 'Seleccionar almacén...',
      'sl': 'Izberite skladišče ...',
    },
    'hz84ye0l': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'wx224juo': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'spkxcu4p': {
      'en': 'Ramp: ',
      'es': 'Rampa:',
      'sl': 'Klančina:',
    },
    'r5pyn0sn': {
      'en': 'New ramp...',
      'es': 'Nueva rampa...',
      'sl': 'Nova rampa ...',
    },
    'lwps3dsm': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    '8bzeqmly': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
  },
  // newManipulation
  {
    'y4j5k3yp': {
      'en': 'Manipulation: ',
      'es': 'Manipulación:',
      'sl': 'Manipulacija:',
    },
    'ke8apo4f': {
      'en': 'New manipulation...',
      'es': 'Nueva manipulación...',
      'sl': 'Nova manipulacija ...',
    },
    'tsup8plf': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    '5b1cdr4g': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
  },
  // newPackaging
  {
    '9mqkzgm4': {
      'en': 'Packaging: ',
      'es': 'Embalaje:',
      'sl': 'Embalaža:',
    },
    'b56ct651': {
      'en': 'New packaging...',
      'es': 'Nuevo embalaje...',
      'sl': 'Nova embalaža ...',
    },
    'hxgjg6fl': {
      'en': 'Abbreviation: ',
      'es': 'Abreviatura:',
      'sl': 'Okrajšava:',
    },
    'u3sqa3vh': {
      'en': 'New abbreviation...',
      'es': 'Nueva abreviatura...',
      'sl': 'Nova okrajšava ...',
    },
    'pmyl2hn9': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'fwiuhoz2': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
  },
  // newWarehousePosition
  {
    'fxao088z': {
      'en': 'Warehouse position: ',
      'es': 'Posición del almacén:',
      'sl': 'Položaj skladišča:',
    },
    '1a0c3b08': {
      'en': 'New warehouse position...',
      'es': 'Nueva posición en almacén...',
      'sl': 'Novo delovno mesto v skladišču ...',
    },
  },
  // newLoadingGate
  {
    '2t2g5v79': {
      'en': 'Loading gate: ',
      'es': 'Puerta de carga:',
      'sl': 'Nakladalna vrata:',
    },
    '67xoxtv5': {
      'en': 'New loading gate...',
      'es': 'Nueva puerta de carga...',
      'sl': 'Nova nakladalna vrata ...',
    },
  },
  // editAccount
  {
    '569byazq': {
      'en': 'Edit account',
      'es': 'Editar cuenta',
      'sl': 'Uredi račun',
    },
    'fkjnp44c': {
      'en': 'Let\'s get started by filling out the form below.',
      'es': 'Comencemos rellenando el formulario que aparece a continuación.',
      'sl': 'Začnimo z izpolnitvijo spodnjega obrazca.',
    },
    '8gfdxdke': {
      'en': 'Name',
      'es': 'Nombre',
      'sl': 'Ime',
    },
    'ch73p8if': {
      'en': 'Last name',
      'es': 'Apellido',
      'sl': 'Priimek',
    },
    'tctidibz': {
      'en': 'User type',
      'es': 'Tipo de usuario',
      'sl': 'Vrsta uporabnika',
    },
    'z29l1qwb': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '9m5mxg7y': {
      'en': 'administrator',
      'es': 'administrator',
      'sl': 'administrator',
    },
    'ononnqos': {
      'en': 'employee',
      'es': 'employee',
      'sl': 'employee',
    },
    'mi522foy': {
      'en': 'superadmin',
      'es': 'superadmin',
      'sl': 'superadmin',
    },
    'se61s3dd': {
      'en': 'Status',
      'es': 'Estado',
      'sl': 'Stanje',
    },
    'bgklx6w8': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'elbd5t7m': {
      'en': 'active',
      'es': 'active',
      'sl': 'active',
    },
    '8k0yud3h': {
      'en': 'inactive',
      'es': 'inactive',
      'sl': 'inactive',
    },
    'q4pev31f': {
      'en': 'Photo',
      'es': 'Foto',
      'sl': 'Fotografija',
    },
    '8zguilsy': {
      'en': 'Job role',
      'es': 'Rol del puesto',
      'sl': 'Delovno mesto',
    },
    'shg9qxqm': {
      'en': 'Edit account',
      'es': 'Editar cuenta',
      'sl': 'Uredi račun',
    },
    's3vvyxm6': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'bt7o842k': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    '259fkeou': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'cp896q5d': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    '0xfa5vwm': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'knpo9n99': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    '4rnb3pbu': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'tz8bgrky': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    'rgn0h99z': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'e6g57ay5': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
    '1hwmzrn9': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'uijjh2c5': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
  },
  // associateQuery
  {
    'dpzbgv5i': {
      'en': 'Associate order?',
      'es': '¿Orden de asociado?',
      'sl': 'Naročilo za partnerja?',
    },
    'ly6tq4ee': {
      'en': 'Yes',
      'es': 'Sí',
      'sl': 'Da',
    },
    'u0ajul0e': {
      'en': 'No',
      'es': 'No',
      'sl': 'Ne',
    },
  },
  // filtersPopUp-OrderWarehouse
  {
    'vg4uqgxo': {
      'en': 'Filter orderWarehouse',
      'es': 'Orden de filtro Almacén',
      'sl': 'Filtriraj naročiloSkladišče',
    },
    'i53p3rjy': {
      'en': 'Order no',
      'es': 'Número de pedido',
      'sl': 'Številka naročila',
    },
    'ibqppksb': {
      'en': 'Contains',
      'es': 'Contiene',
      'sl': 'Vsebuje',
    },
    '0lwyfpsx': {
      'en': 'Client',
      'es': 'Cliente',
      'sl': 'Stranka',
    },
    'pkt1zf1w': {
      'en': 'Inventory status',
      'es': 'Estado del inventario',
      'sl': 'Stanje zalog',
    },
    'b2qsfatg': {
      'en': 'Inv status...',
      'es': 'Estado de inv...',
      'sl': 'Stanje računa ...',
    },
    '0lziwmyf': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '4ta5ffx2': {
      'en': 'najava',
      'es': 'najava',
      'sl': 'najava',
    },
    '6trm8299': {
      'en': 'obdelava',
      'es': 'Obdelava',
      'sl': 'obdelava',
    },
    '9nhx4gpr': {
      'en': 'izdano',
      'es': 'izdano',
      'sl': 'izdano',
    },
    'ixu406dk': {
      'en': 'zaloga',
      'es': 'zaloga',
      'sl': 'zaloga',
    },
    'gszz2y0a': {
      'en': 'brez izbire',
      'es': 'brez izbire',
      'sl': 'brez izbire',
    },
    'wf07s6fy': {
      'en': 'Warehouse',
      'es': 'Depósito',
      'sl': 'Skladišče',
    },
    '7dayywt0': {
      'en': 'Warehouse...',
      'es': 'Depósito...',
      'sl': 'Skladišče...',
    },
    'ly7sujm5': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'mb9bugvx': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    '714xeowh': {
      'en': 'Order status',
      'es': 'Estado del pedido',
      'sl': 'Stanje naročila',
    },
    'ph3n4zhl': {
      'en': 'Order status...',
      'es': 'Estado del pedido...',
      'sl': 'Stanje naročila ...',
    },
    '9zgyxms3': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '3n86jt8v': {
      'en': 'novo naročilo',
      'es': 'novo naročilo',
      'sl': 'novo naročilo',
    },
    '8lkaso8d': {
      'en': 'priprava',
      'es': 'priprava',
      'sl': 'priprava',
    },
    'rdc5qwqf': {
      'en': 'izvajanje',
      'es': 'izvajanje',
      'sl': 'izvajanje',
    },
    'w3gtce4x': {
      'en': 'zaključeno',
      'es': 'zaključeno',
      'sl': 'zaključeno',
    },
    'ku4i1b33': {
      'en': 'Dates',
      'es': 'Fechas',
      'sl': 'Datumi',
    },
    'x2xvlng8': {
      'en': ' : ',
      'es': ':',
      'sl': ':',
    },
    'muli6ubm': {
      'en': 'Flow',
      'es': 'Fluir',
      'sl': 'Pretok',
    },
    's1u4heja': {
      'en': 'Flow...',
      'es': 'Fluir...',
      'sl': 'Pretok...',
    },
    'hf2o1yfa': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '0h51usfg': {
      'en': 'in',
      'es': 'in',
      'sl': 'in',
    },
    '3xgeorn9': {
      'en': 'out',
      'es': 'out',
      'sl': 'out',
    },
    '57vjisxd': {
      'en': '/',
      'es': '/',
      'sl': '/',
    },
    'oyjrhl2w': {
      'en': 'Licence',
      'es': 'Licencia',
      'sl': 'Dovoljenje',
    },
    '058enr0x': {
      'en': 'Licence',
      'es': 'Licencia',
      'sl': 'Dovoljenje',
    },
    'wpbll8pr': {
      'en': 'Improvement',
      'es': 'Mejora',
      'sl': 'Izboljšanje',
    },
    'zywdvytx': {
      'en': 'Improvement...',
      'es': 'Mejora...',
      'sl': 'Izboljšanje ...',
    },
    '2gjaukgz': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'lf2173ih': {
      'en': 'kont.-20\"',
      'es': 'cont.-20\"',
      'sl': 'kont.-20\"',
    },
    '39f93ypq': {
      'en': 'kont.-40\"',
      'es': 'cont.-40\"',
      'sl': 'kont.-40\"',
    },
    'ncigdqke': {
      'en': 'kont.-45\"',
      'es': 'cont.-45\"',
      'sl': 'kont.-45\"',
    },
    '7gbye58g': {
      'en': 'cerada',
      'es': 'cerada',
      'sl': 'cerada',
    },
    'uu0mg6fh': {
      'en': 'hladilnik',
      'es': 'hladilnik',
      'sl': 'hladilnik',
    },
    'j0tl3mj8': {
      'en': 'silos',
      'es': 'silos',
      'sl': 'silosi',
    },
    '0ux98pvo': {
      'en': '/',
      'es': '/',
      'sl': '/',
    },
    '4uiybugg': {
      'en': 'Container',
      'es': 'Recipiente',
      'sl': 'Posoda',
    },
    'j7y3rblx': {
      'en': 'Container no',
      'es': 'Número de contenedor',
      'sl': 'Številka posode',
    },
    'iref8rxa': {
      'en': 'Packaging',
      'es': 'Embalaje',
      'sl': 'Embalaža',
    },
    '8psc3is1': {
      'en': 'Packaging...',
      'es': 'Embalaje...',
      'sl': 'Embalaža...',
    },
    'v6ojzerm': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'osb2u16f': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    's0ds264w': {
      'en': 'Pallet position',
      'es': 'Posición del palé',
      'sl': 'Položaj palete',
    },
    'oj863cb3': {
      'en': 'Pallet position',
      'es': 'Posición del palé',
      'sl': 'Položaj palete',
    },
    'wwbahji9': {
      'en': 'Universal ref',
      'es': 'Referencia universal',
      'sl': 'Univerzalna referenca',
    },
    '7zx74bkb': {
      'en': 'Universal ref num',
      'es': 'Número de referencia universal',
      'sl': 'Univerzalna referenčna številka',
    },
    'a37dtztf': {
      'en': 'FMS ref',
      'es': 'Referencia FMS',
      'sl': 'Referenca FMS',
    },
    'lfd9ab7u': {
      'en': 'FMS ref',
      'es': 'Referencia FMS',
      'sl': 'Referenca FMS',
    },
    'ebw51yoo': {
      'en': 'Load ref',
      'es': 'Cargar referencia',
      'sl': 'Referenčna vrednost obremenitve',
    },
    'qudx2vlo': {
      'en': 'Load ref dvh',
      'es': 'Cargar referencia dvh',
      'sl': 'Naloži referenčno dvh',
    },
    'eywtjs2x': {
      'en': 'Custom',
      'es': 'Costumbre',
      'sl': 'Po meri',
    },
    '696f6x65': {
      'en': 'Custom...',
      'es': 'Costumbre...',
      'sl': 'Po meri...',
    },
    'j2zc6aw5': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'kb0osv0h': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'z8n9yzgn': {
      'en': 'Int custom',
      'es': 'Int personalizado',
      'sl': 'Notranja po meri',
    },
    'dbpzzwe2': {
      'en': 'Int custom',
      'es': 'Int personalizado',
      'sl': 'Notranja po meri',
    },
    'yfyzfa8r': {
      'en': 'Good',
      'es': 'Bien',
      'sl': 'Dobro',
    },
    'tnizrix6': {
      'en': 'Good...',
      'es': 'Bien...',
      'sl': 'Dobro ...',
    },
    '8dla0gah': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'yftxcu8r': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'ng9e9dnu': {
      'en': 'Good description',
      'es': 'Buena descripción',
      'sl': 'Dober opis',
    },
    'k22mfzjq': {
      'en': 'Assistant 1',
      'es': 'Asistente 1',
      'sl': 'Pomočnik 1',
    },
    '75kmqe0g': {
      'en': 'Assistant 1...',
      'es': 'Asistente 1...',
      'sl': 'Pomočnik 1...',
    },
    'kvv68dcp': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'hixum2aq': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'fslsmn2x': {
      'en': 'Assistant 2',
      'es': 'Asistente 2',
      'sl': 'Pomočnik 2',
    },
    'gxnxnzu6': {
      'en': 'Assistant 2...',
      'es': 'Asistente 2...',
      'sl': 'Pomočnik 2...',
    },
    'qvjpt6uf': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'brvwcaey': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'hb2gjx1l': {
      'en': 'Admin',
      'es': 'Administración',
      'sl': 'Skrbnik',
    },
    'qqkmkt8h': {
      'en': 'Admin...',
      'es': 'Administración...',
      'sl': 'Administrator ...',
    },
    'yrikqw2v': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    's398cyi1': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'goxetviy': {
      'en': 'Barcodes',
      'es': 'Códigos de barras',
      'sl': 'Črtne kode',
    },
    '1es2wo6h': {
      'en': 'Barcode',
      'es': 'Código de barras',
      'sl': 'Črtna koda',
    },
    'pd50vn0v': {
      'en': 'Search',
      'es': 'Buscar',
      'sl': 'Iskanje',
    },
    'sg7dt9y7': {
      'en': 'Reset filters',
      'es': 'Restablecer filtros',
      'sl': 'Ponastavi filtre',
    },
  },
  // detailsCopy
  {
    'ouh0nuof': {
      'en': 'Details',
      'es': 'Detalles',
      'sl': 'Podrobnosti',
    },
    'j4kri4ar': {
      'en': 'Orden No:',
      'es': 'Orden No:',
      'sl': 'Številka naročila:',
    },
    's1tvllxj': {
      'en': 'Select barcode...',
      'es': 'Seleccione código de barras...',
      'sl': 'Izberite črtno kodo ...',
    },
    '0ml3x8q3': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'femaiq78': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'xcxrnmtz': {
      'en': 'Packaging',
      'es': 'Embalaje',
      'sl': 'Embalaža',
    },
    '2x2w6o2g': {
      'en': 'Warehouse position',
      'es': 'Posición de almacén',
      'sl': 'Položaj v skladišču',
    },
    'nov10dl4': {
      'en': 'Barcode',
      'es': 'Código de barras',
      'sl': 'Črtna koda',
    },
    '74spupa0': {
      'en': 'Check',
      'es': 'Controlar',
      'sl': 'Preveri',
    },
    '008g0zam': {
      'en': 'Row',
      'es': 'Fila',
      'sl': 'Vrstica',
    },
    'snybh5y6': {
      'en': 'Edit',
      'es': 'Editar',
      'sl': 'Uredi',
    },
    'xrwvu6ag': {
      'en': 'Delete',
      'es': 'Borrar',
      'sl': 'Izbriši',
    },
  },
  // newThreshold
  {
    'zbuifoh6': {
      'en': 'Threshold amount: ',
      'es': 'Importe umbral:',
      'sl': 'Prag:',
    },
    'f89nbayg': {
      'en': 'New custom...',
      'es': 'Nueva costumbre...',
      'sl': 'Nova po meri ...',
    },
    'b5ym8ymx': {
      'en': 'Field is required',
      'es': 'El campo es obligatorio',
      'sl': 'Polje je obvezno',
    },
    'l4c3llsf': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, elija una opción del menú desplegable.',
      'sl': 'Izberite možnost iz spustnega menija',
    },
  },
  // filtersPopUp-Calendar
  {
    'xzozg88n': {
      'en': 'Filter calendar',
      'es': 'Calendario de filtros',
      'sl': 'Filtriraj koledar',
    },
    'znrh16lf': {
      'en': 'Warehouse',
      'es': 'Depósito',
      'sl': 'Skladišče',
    },
    'wnigknou': {
      'en': 'Warehouse...',
      'es': 'Depósito...',
      'sl': 'Skladišče...',
    },
    '72yauavx': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '3qfat10e': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'ibw9upsi': {
      'en': 'Order no',
      'es': 'Número de pedido',
      'sl': 'Številka naročila',
    },
    'b8kitnaf': {
      'en': 'Order no',
      'es': 'Número de pedido',
      'sl': 'Številka naročila',
    },
    'xtvgye10': {
      'en': 'Client',
      'es': 'Cliente',
      'sl': 'Stranka',
    },
    'qre8e4pv': {
      'en': 'Flow',
      'es': 'Fluir',
      'sl': 'Pretok',
    },
    'qcuxls8u': {
      'en': 'Flow...',
      'es': 'Fluir...',
      'sl': 'Pretok...',
    },
    'n847do86': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '0pa5ffde': {
      'en': 'in',
      'es': 'in',
      'sl': 'in',
    },
    'as2kpdnx': {
      'en': 'out',
      'es': 'out',
      'sl': 'out',
    },
    'f2cvqq5f': {
      'en': '/',
      'es': '/',
      'sl': '/',
    },
    'y68eavea': {
      'en': 'Inventory status',
      'es': 'Estado del inventario',
      'sl': 'Stanje zalog',
    },
    'az0uj41g': {
      'en': 'Inv status...',
      'es': 'Estado de la inversión...',
      'sl': 'Stanje računa ...',
    },
    '33doajwd': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'q03t7u96': {
      'en': 'najava',
      'es': 'najava',
      'sl': 'najava',
    },
    'd21sjl3f': {
      'en': 'obdelava',
      'es': 'Obdelava',
      'sl': 'obdelava',
    },
    't9mzk66c': {
      'en': 'izdano',
      'es': 'izdano',
      'sl': 'izdano',
    },
    'r4t24lx1': {
      'en': 'zaloga',
      'es': 'zaloga',
      'sl': 'zaloga',
    },
    'asbxyfbb': {
      'en': 'brez izbire',
      'es': 'brez izbire',
      'sl': 'brez izbire',
    },
    'alpuwz6a': {
      'en': 'Order status',
      'es': 'Estado del pedido',
      'sl': 'Stanje naročila',
    },
    'a83no5q7': {
      'en': 'Order status...',
      'es': 'Estado del pedido...',
      'sl': 'Stanje naročila ...',
    },
    'v7rqpu4v': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '97oa4y8j': {
      'en': 'novo naročilo',
      'es': 'novo naročilo',
      'sl': 'novo naročilo',
    },
    'owkt7a6v': {
      'en': 'priprava',
      'es': 'priprava',
      'sl': 'priprava',
    },
    'akcrd3z2': {
      'en': 'izvajanje',
      'es': 'izvajanje',
      'sl': 'izvajanje',
    },
    'mmh79d5y': {
      'en': 'zaključeno',
      'es': 'zaključeno',
      'sl': 'zaključeno',
    },
    '4mdp80vo': {
      'en': 'Dates',
      'es': 'Fechas',
      'sl': 'Datumi',
    },
    '032jvtku': {
      'en': ' : ',
      'es': ':',
      'sl': ':',
    },
    'y3mxc9ha': {
      'en': 'Improvement',
      'es': 'Mejora',
      'sl': 'Izboljšanje',
    },
    'b82t2okv': {
      'en': 'Improvement...',
      'es': 'Mejora...',
      'sl': 'Izboljšanje ...',
    },
    'tqd85edq': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'tjx28zkr': {
      'en': 'kont.-20\"',
      'es': 'cont.-20\"',
      'sl': 'kont.-20\"',
    },
    '2wggnghd': {
      'en': 'kont.-40\"',
      'es': 'cont.-40\"',
      'sl': 'kont.-40\"',
    },
    'ay57xy15': {
      'en': 'kont.-45\"',
      'es': 'cont.-45\"',
      'sl': 'kont.-45\"',
    },
    'yd3gm1gb': {
      'en': 'cerada',
      'es': 'cerada',
      'sl': 'cerada',
    },
    'tiek1m5q': {
      'en': 'hladilnik',
      'es': 'hladilnik',
      'sl': 'hladilnik',
    },
    'aqdouee1': {
      'en': 'silos',
      'es': 'silos',
      'sl': 'silosi',
    },
    '53qvvkar': {
      'en': '/',
      'es': '/',
      'sl': '/',
    },
    'p1g3p1fb': {
      'en': 'Admin',
      'es': 'Administración',
      'sl': 'Skrbnik',
    },
    'giwc7ntm': {
      'en': 'Admin...',
      'es': 'Administración...',
      'sl': 'Administrator ...',
    },
    '5b98tl93': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'vh3nbapv': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'qdvwifp9': {
      'en': 'Licence',
      'es': 'Licencia',
      'sl': 'Dovoljenje',
    },
    'i26b401b': {
      'en': 'Licence',
      'es': 'Licencia',
      'sl': 'Dovoljenje',
    },
    'vf7kmmwy': {
      'en': 'Search',
      'es': 'Buscar',
      'sl': 'Iskanje',
    },
    'iq3qlewh': {
      'en': 'Reset filters',
      'es': 'Restablecer filtros',
      'sl': 'Ponastavi filtre',
    },
  },
  // filtersPopUp-Warehouse2
  {
    'irgv8mk6': {
      'en': 'Filter warehouse2',
      'es': 'Almacén de filtros2',
      'sl': 'Filter skladišče2',
    },
    'z9f6zp50': {
      'en': 'Order no',
      'es': 'Número de pedido',
      'sl': 'Številka naročila',
    },
    'e94w74j9': {
      'en': 'Order no',
      'es': 'Número de pedido',
      'sl': 'Številka naročila',
    },
    'xtcgg2hp': {
      'en': 'Client',
      'es': 'Cliente',
      'sl': 'Stranka',
    },
    '4rwo974e': {
      'en': 'Inventory status',
      'es': 'Estado del inventario',
      'sl': 'Stanje zalog',
    },
    '9q194mmg': {
      'en': 'Inv status...',
      'es': 'Estado de inv...',
      'sl': 'Stanje računa ...',
    },
    'i9ybo7ij': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'a6jqx3xg': {
      'en': 'najava',
      'es': 'najava',
      'sl': 'najava',
    },
    'vuae1npv': {
      'en': 'obdelava',
      'es': 'Obdelava',
      'sl': 'obdelava',
    },
    'bdu6t0xf': {
      'en': 'izdano',
      'es': 'izdano',
      'sl': 'izdano',
    },
    'y9vii32h': {
      'en': 'zaloga',
      'es': 'zaloga',
      'sl': 'zaloga',
    },
    'ryj3sx9i': {
      'en': 'brez izbire',
      'es': 'brez izbire',
      'sl': 'brez izbire',
    },
    'ngfvnx3a': {
      'en': 'Warehouse',
      'es': 'Depósito',
      'sl': 'Skladišče',
    },
    'fbwk2eb1': {
      'en': 'Warehouse...',
      'es': 'Depósito...',
      'sl': 'Skladišče...',
    },
    'bjt8su72': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'kx5zcpyb': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'fosada66': {
      'en': 'Order status',
      'es': 'Estado del pedido',
      'sl': 'Stanje naročila',
    },
    'vf4gwvpi': {
      'en': 'Order status...',
      'es': 'Estado del pedido...',
      'sl': 'Stanje naročila ...',
    },
    'btsrmudt': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '7mt5192y': {
      'en': 'novo naročilo',
      'es': 'novo naročilo',
      'sl': 'novo naročilo',
    },
    'xuvy61hp': {
      'en': 'priprava',
      'es': 'priprava',
      'sl': 'priprava',
    },
    'z6d6f7a0': {
      'en': 'izvajanje',
      'es': 'izvajanje',
      'sl': 'izvajanje',
    },
    'h90stdsz': {
      'en': 'zaključeno',
      'es': 'zaključeno',
      'sl': 'zaključeno',
    },
    'hucfmlhy': {
      'en': 'Dates',
      'es': 'Fechas',
      'sl': 'Datumi',
    },
    'rut16gvt': {
      'en': ' : ',
      'es': ':',
      'sl': ':',
    },
    '7mig9sam': {
      'en': 'Flow',
      'es': 'Fluir',
      'sl': 'Pretok',
    },
    '3780sm2b': {
      'en': 'Flow...',
      'es': 'Fluir...',
      'sl': 'Pretok...',
    },
    'alwbeo6v': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'pm15yd41': {
      'en': 'in',
      'es': 'in',
      'sl': 'in',
    },
    '1ssmqwop': {
      'en': 'out',
      'es': 'out',
      'sl': 'out',
    },
    'qaa3brb2': {
      'en': '/',
      'es': '/',
      'sl': '/',
    },
    'n2ysjg34': {
      'en': 'Licence',
      'es': 'Licencia',
      'sl': 'Dovoljenje',
    },
    '2n8gfvay': {
      'en': 'Licence',
      'es': 'Licencia',
      'sl': 'Dovoljenje',
    },
    'cflpz8ug': {
      'en': 'Improvement',
      'es': 'Mejora',
      'sl': 'Izboljšanje',
    },
    'rw0jpd1m': {
      'en': 'Improvement...',
      'es': 'Mejora...',
      'sl': 'Izboljšanje ...',
    },
    'x218m80p': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '0bmyexge': {
      'en': 'kont.-20\"',
      'es': 'cont.-20\"',
      'sl': 'kont.-20\"',
    },
    'k4gbg7rq': {
      'en': 'kont.-40\"',
      'es': 'cont.-40\"',
      'sl': 'kont.-40\"',
    },
    'y8bnb6r4': {
      'en': 'kont.-45\"',
      'es': 'cont.-45\"',
      'sl': 'kont.-45\"',
    },
    'uadzr2va': {
      'en': 'cerada',
      'es': 'cerada',
      'sl': 'cerada',
    },
    'prwrhneb': {
      'en': 'hladilnik',
      'es': 'hladilnik',
      'sl': 'hladilnik',
    },
    'rgnztqkq': {
      'en': 'silos',
      'es': 'silos',
      'sl': 'silosi',
    },
    '8zgsjqcq': {
      'en': '/',
      'es': '/',
      'sl': '/',
    },
    'oeq2bawt': {
      'en': 'Container',
      'es': 'Recipiente',
      'sl': 'Posoda',
    },
    '9iyewsnl': {
      'en': 'Container no',
      'es': 'Número de contenedor',
      'sl': 'Številka posode',
    },
    '7j25m0zi': {
      'en': 'Packaging',
      'es': 'Embalaje',
      'sl': 'Embalaža',
    },
    'yyz35ptp': {
      'en': 'Packaging...',
      'es': 'Embalaje...',
      'sl': 'Embalaža...',
    },
    'uq9j36mh': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'ztdkjng3': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'zvvqqw4h': {
      'en': 'Pallet position',
      'es': 'Posición del palé',
      'sl': 'Položaj palete',
    },
    'q2g3nydw': {
      'en': 'Pallet position',
      'es': 'Posición del palé',
      'sl': 'Položaj palete',
    },
    'ad4tz59a': {
      'en': 'Universal ref',
      'es': 'Referencia universal',
      'sl': 'Univerzalna referenca',
    },
    'hmy93n8p': {
      'en': 'Universal ref num',
      'es': 'Número de referencia universal',
      'sl': 'Univerzalna referenčna številka',
    },
    'fbf472vj': {
      'en': 'FMS ref',
      'es': 'Referencia FMS',
      'sl': 'Referenca FMS',
    },
    'omgf2y6f': {
      'en': 'FMS ref',
      'es': 'Referencia FMS',
      'sl': 'Referenca FMS',
    },
    'r6e8uqkr': {
      'en': 'Load ref',
      'es': 'Cargar referencia',
      'sl': 'Referenčna vrednost obremenitve',
    },
    '6zz6lxft': {
      'en': 'Load ref dvh',
      'es': 'Cargar referencia dvh',
      'sl': 'Naloži referenčno dvh',
    },
    '0l8vap15': {
      'en': 'Custom',
      'es': 'Costumbre',
      'sl': 'Po meri',
    },
    'vc5g53is': {
      'en': 'Custom...',
      'es': 'Costumbre...',
      'sl': 'Po meri...',
    },
    'pjszqmsb': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'rksee64u': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    '30b2y6rf': {
      'en': 'Int custom',
      'es': 'Int personalizado',
      'sl': 'Notranja po meri',
    },
    'qgah646m': {
      'en': 'Int custom',
      'es': 'Int personalizado',
      'sl': 'Notranja po meri',
    },
    '7m9sok4b': {
      'en': 'Good',
      'es': 'Bien',
      'sl': 'Dobro',
    },
    '7ppupt80': {
      'en': 'Good...',
      'es': 'Bien...',
      'sl': 'Dobro ...',
    },
    'jf0gnovj': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '6yeon4bj': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'uznat6ma': {
      'en': 'Good description',
      'es': 'Buena descripción',
      'sl': 'Dober opis',
    },
    'ckhll3nh': {
      'en': 'Assistant 1',
      'es': 'Asistente 1',
      'sl': 'Pomočnik 1',
    },
    '1335lksi': {
      'en': 'Assistant 1...',
      'es': 'Asistente 1...',
      'sl': 'Pomočnik 1...',
    },
    'd21jugja': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'qye87143': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'flecrlqb': {
      'en': 'Assistant 2',
      'es': 'Asistente 2',
      'sl': 'Pomočnik 2',
    },
    'tfsyb03k': {
      'en': 'Assistant 2...',
      'es': 'Asistente 2...',
      'sl': 'Pomočnik 2...',
    },
    '61xl1zbm': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'lypgdglo': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'j0xlaaiq': {
      'en': 'Admin',
      'es': 'Administración',
      'sl': 'Skrbnik',
    },
    'bnylikx0': {
      'en': 'Admin...',
      'es': 'Administración...',
      'sl': 'Administrator ...',
    },
    'raurjpj7': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'u7b4t59j': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'fbspepwu': {
      'en': 'Barcodes',
      'es': 'Códigos de barras',
      'sl': 'Črtne kode',
    },
    'ma2yj487': {
      'en': 'Barcode',
      'es': 'Código de barras',
      'sl': 'Črtna koda',
    },
    'fr7srevj': {
      'en': 'Search',
      'es': 'Buscar',
      'sl': 'Iskanje',
    },
    '2jk9dgyw': {
      'en': 'Reset filters',
      'es': 'Restablecer filtros',
      'sl': 'Ponastavi filtre',
    },
  },
  // filtersPopUp-Customs
  {
    'o91bxnzf': {
      'en': 'Filter customs',
      'es': 'Filtrar costumbres',
      'sl': 'Filtriraj carino',
    },
    'z2jvfop7': {
      'en': 'Order no',
      'es': 'Número de pedido',
      'sl': 'Številka naročila',
    },
    '13lyvpan': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'zy5s5d0u': {
      'en': 'Client',
      'es': 'Cliente',
      'sl': 'Stranka',
    },
    'g2tcj80n': {
      'en': 'Dates',
      'es': 'Fechas',
      'sl': 'Datumi',
    },
    'jqy501na': {
      'en': ' : ',
      'es': ':',
      'sl': ':',
    },
    '5f1quhnj': {
      'en': 'Flow',
      'es': 'Fluir',
      'sl': 'Pretok',
    },
    '484qgai7': {
      'en': 'Flow...',
      'es': 'Fluir...',
      'sl': 'Pretok...',
    },
    'mo61735a': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '4xkuuyim': {
      'en': 'in',
      'es': 'in',
      'sl': 'in',
    },
    'xsaa7972': {
      'en': 'out',
      'es': 'out',
      'sl': 'out',
    },
    'aqy6rmn5': {
      'en': '/',
      'es': '/',
      'sl': '/',
    },
    'mwnyfcbg': {
      'en': 'Licence',
      'es': 'Licencia',
      'sl': 'Dovoljenje',
    },
    'h26eu5z9': {
      'en': 'Licence',
      'es': 'Licencia',
      'sl': 'Dovoljenje',
    },
    'yqphq6wb': {
      'en': 'Improvement',
      'es': 'Mejora',
      'sl': 'Izboljšanje',
    },
    'o7tz3kis': {
      'en': 'Improvement...',
      'es': 'Mejora...',
      'sl': 'Izboljšanje ...',
    },
    '9gil8guc': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '9wv8lnes': {
      'en': 'kont.-20\"',
      'es': 'cont.-20\"',
      'sl': 'kont.-20\"',
    },
    'uzeeltlo': {
      'en': 'kont.-40\"',
      'es': 'cont.-40\"',
      'sl': 'kont.-40\"',
    },
    '66k5zkd5': {
      'en': 'kont.-45\"',
      'es': 'cont.-45\"',
      'sl': 'kont.-45\"',
    },
    'rx231w7t': {
      'en': 'cerada',
      'es': 'cerada',
      'sl': 'cerada',
    },
    'r5r0eirm': {
      'en': 'hladilnik',
      'es': 'hladilnik',
      'sl': 'hladilnik',
    },
    '9hae6p0b': {
      'en': 'silos',
      'es': 'silos',
      'sl': 'silosi',
    },
    'zey2pmru': {
      'en': '/',
      'es': '/',
      'sl': '/',
    },
    'j526m3ek': {
      'en': 'Container',
      'es': 'Recipiente',
      'sl': 'Posoda',
    },
    'tp9lba94': {
      'en': 'Container no',
      'es': 'Número de contenedor',
      'sl': 'Številka posode',
    },
    'ybdeees6': {
      'en': 'FMS ref',
      'es': 'Referencia FMS',
      'sl': 'Referenca FMS',
    },
    '5ysj7t2n': {
      'en': 'FMS ref',
      'es': 'Referencia FMS',
      'sl': 'Referenca FMS',
    },
    'alz0szhi': {
      'en': 'Load ref',
      'es': 'Cargar referencia',
      'sl': 'Referenčna vrednost obremenitve',
    },
    'kh2exrm2': {
      'en': 'Load ref dvh',
      'es': 'Cargar referencia dvh',
      'sl': 'Naloži referenčno dvh',
    },
    '4888no79': {
      'en': 'Universal ref',
      'es': 'Referencia universal',
      'sl': 'Univerzalna referenca',
    },
    'i11qpfgd': {
      'en': 'Universal ref num',
      'es': 'Número de referencia universal',
      'sl': 'Univerzalna referenčna številka',
    },
    'ao1bkjej': {
      'en': 'Packaging',
      'es': 'Embalaje',
      'sl': 'Embalaža',
    },
    'pccma48p': {
      'en': 'Packaging...',
      'es': 'Embalaje...',
      'sl': 'Embalaža...',
    },
    'q00zz3xw': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'ogzmdhzn': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    '7ytu4gjp': {
      'en': 'Warehouse',
      'es': 'Depósito',
      'sl': 'Skladišče',
    },
    'n77shwrq': {
      'en': 'Warehouse...',
      'es': 'Depósito...',
      'sl': 'Skladišče...',
    },
    'j59pm6dv': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'gsle7g5m': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'xcc5fwab': {
      'en': 'Int custom',
      'es': 'Int personalizado',
      'sl': 'Notranja po meri',
    },
    'hoy8dy1w': {
      'en': 'Int custom',
      'es': 'Int personalizado',
      'sl': 'Notranja po meri',
    },
    '380dxdqd': {
      'en': 'Search',
      'es': 'Buscar',
      'sl': 'Iskanje',
    },
    'shm4cx3j': {
      'en': 'Reset filters',
      'es': 'Restablecer filtros',
      'sl': 'Ponastavi filtre',
    },
  },
  // filtersPopUp-Reports
  {
    'klpnlegm': {
      'en': 'Filter reports',
      'es': 'Filtrar informes',
      'sl': 'Filtriraj poročila',
    },
    'ctlvhe8m': {
      'en': 'Client',
      'es': 'Cliente',
      'sl': 'Stranka',
    },
    'nlif8vby': {
      'en': 'Inventory status',
      'es': 'Estado del inventario',
      'sl': 'Stanje zalog',
    },
    'q2cz57z9': {
      'en': ' : ',
      'es': ':',
      'sl': ':',
    },
    '8y283ko7': {
      'en': 'Flow',
      'es': 'Fluir',
      'sl': 'Pretok',
    },
    'xlg9vsr5': {
      'en': 'Flow...',
      'es': 'Fluir...',
      'sl': 'Pretok...',
    },
    's4havvam': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'i9jtxrjr': {
      'en': 'in',
      'es': 'in',
      'sl': 'in',
    },
    'tjmnpxn0': {
      'en': 'out',
      'es': 'out',
      'sl': 'out',
    },
    '6fde26ul': {
      'en': '/',
      'es': '/',
      'sl': '/',
    },
    '3cxu4i5h': {
      'en': 'Licence',
      'es': 'Licencia',
      'sl': 'Dovoljenje',
    },
    'pok59uc5': {
      'en': 'Licence',
      'es': 'Licencia',
      'sl': 'Dovoljenje',
    },
    'qqqnv43m': {
      'en': 'Improvement',
      'es': 'Mejora',
      'sl': 'Izboljšanje',
    },
    'qhuicnso': {
      'en': 'Improvement...',
      'es': 'Mejora...',
      'sl': 'Izboljšanje ...',
    },
    '3dqgymww': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    '56luw53b': {
      'en': 'kont.-20\"',
      'es': 'cont.-20\"',
      'sl': 'kont.-20\"',
    },
    'fgmut4we': {
      'en': 'kont.-40\"',
      'es': 'cont.-40\"',
      'sl': 'kont.-40\"',
    },
    '0gilmjsk': {
      'en': 'kont.-45\"',
      'es': 'cont.-45\"',
      'sl': 'kont.-45\"',
    },
    'sntjnssj': {
      'en': 'cerada',
      'es': 'cerada',
      'sl': 'cerada',
    },
    '0lu08001': {
      'en': 'hladilnik',
      'es': 'hladilnik',
      'sl': 'hladilnik',
    },
    'jclxtwgo': {
      'en': 'silos',
      'es': 'silos',
      'sl': 'silosi',
    },
    'nsxvukfd': {
      'en': '/',
      'es': '/',
      'sl': '/',
    },
    'hv57z3q5': {
      'en': 'Container',
      'es': 'Recipiente',
      'sl': 'Posoda',
    },
    'i5nger5o': {
      'en': 'Licence',
      'es': 'Licencia',
      'sl': 'Dovoljenje',
    },
    'uihvnbl2': {
      'en': 'Universal ref',
      'es': 'Referencia universal',
      'sl': 'Univerzalna referenca',
    },
    'zxgxzzao': {
      'en': 'Universal ref num',
      'es': 'Número de referencia universal',
      'sl': 'Univerzalna referenčna številka',
    },
    '07w267uh': {
      'en': 'FMS ref',
      'es': 'Referencia FMS',
      'sl': 'Referenca FMS',
    },
    '5bc2vthc': {
      'en': 'FMS ref',
      'es': 'Referencia FMS',
      'sl': 'Referenca FMS',
    },
    'atxbtokx': {
      'en': 'Load ref',
      'es': 'Cargar referencia',
      'sl': 'Referenčna vrednost obremenitve',
    },
    'o0jtr5to': {
      'en': 'Load ref dvh',
      'es': 'Cargar referencia dvh',
      'sl': 'Naloži referenčno dvh',
    },
    '6vodi7zx': {
      'en': 'Packaging',
      'es': 'Embalaje',
      'sl': 'Embalaža',
    },
    'qrsn9xrg': {
      'en': 'Packaging...',
      'es': 'Embalaje...',
      'sl': 'Embalaža...',
    },
    '8rv8k77x': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'yzzbrsrk': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    '6l5mnz1z': {
      'en': 'Good',
      'es': 'Bien',
      'sl': 'Dobro',
    },
    'r0bsn0ps': {
      'en': 'Good...',
      'es': 'Bien...',
      'sl': 'Dobro ...',
    },
    '8wjoh7gf': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'gr0vg2bf': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'kg5xkyd1': {
      'en': 'Good description',
      'es': 'Buena descripción',
      'sl': 'Dober opis',
    },
    'xpsfayu1': {
      'en': 'Order no',
      'es': 'Número de pedido',
      'sl': 'Številka naročila',
    },
    '0f7pc4nv': {
      'en': 'Order no',
      'es': 'Número de pedido',
      'sl': 'Številka naročila',
    },
    '40wc111k': {
      'en': 'Custom',
      'es': 'Costumbre',
      'sl': 'Po meri',
    },
    '811qg8b1': {
      'en': 'Custom...',
      'es': 'Costumbre...',
      'sl': 'Po meri...',
    },
    'unt6gzi4': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'gmv0szve': {
      'en': 'Option 1',
      'es': 'Opción 1',
      'sl': 'Možnost 1',
    },
    'jffinwfn': {
      'en': 'Int custom',
      'es': 'Int personalizado',
      'sl': 'Notranja po meri',
    },
    'ykvqlruq': {
      'en': 'Int custom',
      'es': 'Int personalizado',
      'sl': 'Notranja po meri',
    },
    'p13sdpmq': {
      'en': 'Inventory status',
      'es': 'Estado del inventario',
      'sl': 'Stanje zalog',
    },
    '0vkjnvhr': {
      'en': 'Inv status...',
      'es': 'Estado de la inversión...',
      'sl': 'Stanje računa ...',
    },
    'pzntsfgq': {
      'en': 'Search for an item...',
      'es': 'Buscar un artículo...',
      'sl': 'Iskanje elementa ...',
    },
    'j1xwunuc': {
      'en': 'najava',
      'es': 'najava',
      'sl': 'najava',
    },
    '3x4pdq3s': {
      'en': 'obdelava',
      'es': 'Obdelava',
      'sl': 'obdelava',
    },
    'bflysbp6': {
      'en': 'izdano',
      'es': 'izdano',
      'sl': 'izdano',
    },
    'fclbdcxv': {
      'en': 'zaloga',
      'es': 'zaloga',
      'sl': 'zaloga',
    },
    '6rixcbt5': {
      'en': 'brez izbire',
      'es': 'brez izbire',
      'sl': 'brez izbire',
    },
    'h06ycxxr': {
      'en': 'Search',
      'es': 'Buscar',
      'sl': 'Iskanje',
    },
    'l7g7trgf': {
      'en': 'Reset filters',
      'es': 'Restablecer filtros',
      'sl': 'Ponastavi filtre',
    },
  },
  // Miscellaneous
  {
    'k5pc0j8z': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'pwf0ghf1': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'ivaqlgfi': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'csrov8n9': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'rbtfyzf9': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'eez6rkdb': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'itz1hf3a': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '4x1hv0mu': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'odohdhvj': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'hwsma49d': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '3kxbw6bg': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'srz7eazo': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'f5zcz2oi': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'rivmqkjo': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'etrzh6wy': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'bsq5h3vg': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'czm8n72j': {
      'en': '',
      'es': '',
      'sl': '',
    },
    '6ujolk1u': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'lb236u7h': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'y5umfypx': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'y78gwke6': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'mdqz4w2b': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'bgnkabsd': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'dxo7iz23': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'otczd5kt': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'k4rb355g': {
      'en': '',
      'es': '',
      'sl': '',
    },
    'yp3jf95w': {
      'en': '',
      'es': '',
      'sl': '',
    },
  },
].reduce((a, b) => a..addAll(b));
