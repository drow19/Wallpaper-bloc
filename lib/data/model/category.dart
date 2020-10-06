class Category {
  String id;
  String img;

  Category({this.id, this.img});
}

List<Category> getCategory() {
  List<Category> categoryTile = new List<Category>();

  Category categoryModel = new Category();
  categoryModel.id = "Nature";
  categoryModel.img =
  "https://images.pexels.com/photos/775201/pexels-photo-775201.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  categoryModel = new Category();
  categoryModel.id = "City";
  categoryModel.img =
  "https://images.pexels.com/photos/830891/pexels-photo-830891.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categoryTile.add(categoryModel);

  categoryModel = new Category();
  categoryModel.id = "Graffiti";
  categoryModel.img =
  "https://images.pexels.com/photos/1570264/pexels-photo-1570264.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  categoryModel = new Category();
  categoryModel.id = "Urban";
  categoryModel.img =
  "https://images.pexels.com/photos/1236701/pexels-photo-1236701.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  categoryModel = new Category();
  categoryModel.id = "Animal";
  categoryModel.img =
  "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  categoryModel = new Category();
  categoryModel.id = "Fashion";
  categoryModel.img =
  "https://images.pexels.com/photos/322207/pexels-photo-322207.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  categoryModel = new Category();
  categoryModel.id = "Black & White";
  categoryModel.img =
  "https://images.pexels.com/photos/3780365/pexels-photo-3780365.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  return categoryTile;
}