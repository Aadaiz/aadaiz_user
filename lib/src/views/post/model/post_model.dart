class PostModel {
  final String name;
  final String profileImage;
  final String postImage;
  final String description;
  final String likesText;
  final String commentsCount;

  PostModel({
    required this.name,
    required this.profileImage,
    required this.postImage,
    required this.description,
    required this.likesText,
    required this.commentsCount,
  });
}
class ProfileModel {
  final String name;
  final String profileImage;
  final String coverImage;
  final String bio;
  final String followers;
  final String following;
  final List<String> posts;

  ProfileModel({
    required this.name,
    required this.profileImage,
    required this.coverImage,
    required this.bio,
    required this.followers,
    required this.following,
    required this.posts,
  });
}