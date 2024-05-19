class Plant{
  String? name;
  String? sunlight;
  String? description;
  String? watering;
  String? type;
  String? cycle;
  String? origin;
  String? scientificName;
  String? imgURL;
  Map<String, dynamic>? images;


  Plant({this.name, this.sunlight, this.imgURL , this.description,this.watering, this.images,this.type,this.cycle, this.origin,this.scientificName});
}