enum NetworkRoutes {
  baseUrlProduction,
}

extension NetwrokRoutesString on NetworkRoutes {
  String get rawValue {
    switch (this) {
      case NetworkRoutes.baseUrlProduction:
        return 'https://test.lifeplus.website';
      default:
        throw Exception('Routes Not FouND');
    }
  }
}
