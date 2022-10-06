class ProfileModel {
  String img;
  String name;
  String description;
  int numPosts;
  int numFollowers;
  int numFollowing;
  List<String> listImgPosts;

  ProfileModel(
    this.img,
    this.name,
    this.description,
    this.numPosts,
    this.numFollowers,
    this.numFollowing,
    this.listImgPosts,
  );
}
