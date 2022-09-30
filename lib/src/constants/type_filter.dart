// ignore_for_file: constant_identifier_names

///Filter to restrict the result set of autocomplete
///predictions to certain types.
enum TypeFilter {
  ///Only return geocoding results with a precise address.
  ADDRESS,

  ///Return any result matching the LOCALITY and
  ///ADMINISTRATIVE_AREA_LEVEL_3.
  CITIES,

  ///Only return results that are classified as businesses.
  ESTABLISHMENT,

  ///Only return geocoding results, rather than business
  ///results. For example, parks, cities and street addresses.
  GEOCODE,

  ///Return any result matching the
  ///LOCALITY,
  ///SUBLOCALITY,
  ///POSTAL_CODE,
  ///COUNTRY,
  ///ADMINISTRATIVE_AREA_LEVEL_1,
  ///ADMINISTRATIVE_AREA_LEVEL_2
  REGIONS,
}
