class Environment {
  static const String apiUrl = 'https://pokeapi.co/api/v2';
  //image URL
  static String imageUrl(id) =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$id.png';
}
