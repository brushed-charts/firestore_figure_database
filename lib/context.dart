class FigureContext {
  final String assetPair;
  FigureContext(this.assetPair);

  Map<String, dynamic> toJSON() {
    return {'asset_pair': assetPair};
  }
}
