class FigureContext {
  final String assetPair;
  final String broker;

  FigureContext(this.assetPair, this.broker);

  Map<String, dynamic> toJSON() {
    return {'asset_pair': assetPair, 'broker': broker};
  }
}
