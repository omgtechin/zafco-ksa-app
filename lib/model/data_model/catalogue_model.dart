class CatalogueModel {
  CatalogueModel({
    required this.catalogues,
  });
  late final List<Catalogues> catalogues;

  CatalogueModel.fromJson(Map<String, dynamic> json){
    catalogues = List.from(json['catalogues']).map((e)=>Catalogues.fromJson(e)).toList();
  }
}

class Catalogues {
  Catalogues({
    required this.files,
    required this.brand,
  });
  late final List<FileData> files;
  late final Brand brand;

  Catalogues.fromJson(Map<String, dynamic> json){
    files = List.from(json['files']).map((e)=>FileData.fromJson(e)).toList();
    brand = Brand.fromJson(json['brand']);
  }

}

class FileData {
  FileData({
    required this.id,
    required this.brandId,
    required this.name,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int brandId;
  late final String name;
  late final String file;
  late final String createdAt;
  late final String updatedAt;

  FileData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    brandId = json['brand_id'];
    name = json['name'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Brand {
  Brand({
    required this.id,
    required this.brandId,
    required this.name,
    required this.image,
    required this.brandCode,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int brandId;
  late final String name;
  late final String image;
  late final String brandCode;
  late final String createdAt;
  late final String updatedAt;

  Brand.fromJson(Map<String, dynamic> json){
    id = json['id'];
    brandId = json['brand_id'];
    name = json['name'];
    image = json['image'];
    brandCode = json['brand_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}