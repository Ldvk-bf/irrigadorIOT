class Plant {
  String imageUrl;
  String name;
  int? intervalo;
  String description;
  late bool automatico;
  List<String> horario;

  Plant({
    required this.imageUrl,
    required this.name,
    required this.intervalo,
    required this.description,
    required this.automatico,
    required this.horario,
  });
}

final List<Plant> plants = [
  Plant(
    imageUrl: 'imagens/orquideas.jpg',
    name: 'Orquidias e Bromélias',
    automatico: true,
    intervalo: 0,
    horario: [],
    description:
        'Aloe vera is a succulent plant species of the genus Aloe. It\'s medicinal uses and air purifying ability make it an awesome plant.',
  ),
  Plant(
    imageUrl: 'assets/images/plant1.png',
    name: 'Frutiferas e folhagens',
    automatico: true,
    intervalo: 0,
    horario: [],
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porta risus id urna luctus efficitur.',
  ),
  Plant(
    imageUrl: 'assets/images/plant2.png',
    name: 'Suculentas',
    automatico: true,
    intervalo: 0,
    horario: [],
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porta risus id urna luctus efficitur. Suspendisse vulputate faucibus est, a vehicula sem eleifend quis.',
  ),
];
