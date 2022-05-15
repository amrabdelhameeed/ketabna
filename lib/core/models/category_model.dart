class CategoryModel {
  List<CategoryModel> categories = [
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Biography.jpg',
        categoryName: 'Biography'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Children.jpg',
        categoryName: 'Children'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Fantasy.jpg',
        categoryName: 'Fantasy'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Graphic Novels.jpg',
        categoryName: 'Graphic Novels'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/History.jpg',
        categoryName: 'History'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Horror.jpg',
        categoryName: 'Horror'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Romance.jpg',
        categoryName: 'Romance'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Science Fiction.jpg',
        categoryName: 'Science Fiction'),
  ];
  bool isSelected;
  String imagePath;
  String categoryName;
  CategoryModel(
      {required this.isSelected,
      required this.imagePath,
      required this.categoryName});
}
