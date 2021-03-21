class CustomRoute {
  final String name;
  final Object arguments;
  final bool isVoiceable;

  const CustomRoute(this.name, [this.arguments, this.isVoiceable = false]);
}
