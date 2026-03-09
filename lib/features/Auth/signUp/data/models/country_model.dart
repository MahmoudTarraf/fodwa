class CountryModel {
  final int id;
  final String name;
  final String isoCode;
  final List<CityModel> cities;

  const CountryModel({
    required this.id,
    required this.name,
    required this.isoCode,
    required this.cities,
  });
}

class CityModel {
  final int id;
  final String name;

  const CityModel({required this.id, required this.name});
}

final List<CountryModel> countriesList = [
  CountryModel(
    id: 1,
    name: 'Egypt',
    isoCode: 'EG',
    cities: const [
      CityModel(id: 1, name: 'Cairo'),
      CityModel(id: 2, name: 'Giza'),
      CityModel(id: 3, name: 'Alexandria'),
      CityModel(id: 4, name: 'Mansoura'),
    ],
  ),
  CountryModel(
    id: 2,
    name: 'Iraq',
    isoCode: 'IQ',
    cities: const [
      CityModel(id: 5, name: 'Baghdad'),
      CityModel(id: 6, name: 'Basra'),
      CityModel(id: 7, name: 'Erbil'),
      CityModel(id: 8, name: 'Najaf'),
    ],
  ),
  CountryModel(
    id: 3,
    name: 'Saudi Arabia',
    isoCode: 'SA',
    cities: const [
      CityModel(id: 9, name: 'Riyadh'),
      CityModel(id: 10, name: 'Jeddah'),
      CityModel(id: 11, name: 'Dammam'),
      CityModel(id: 12, name: 'Mecca'),
    ],
  ),
];
