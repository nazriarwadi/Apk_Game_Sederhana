class TileModel {
  String? imageAssetPath;
  bool? isSelected;

  void setImageAssetPath(String imagePath) {
    this.imageAssetPath = imagePath;
  }

  void setIsSelected(bool isSelected) {
    this.isSelected = isSelected;
  }

  String? getImageAssetPath() {
    return imageAssetPath;
  }

  bool? getIsSelected() {
    return isSelected;
  }
}
