class OnboardingContent {
  String image;
  String title;
  String discription;

  OnboardingContent(
      {required this.image, required this.title, required this.discription});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: 'Identifikasi Tanaman',
      image: 'assets/images/onboarding1.png',
      discription: "Identifikasi tanaman yang tidak diketahui "
          "melalui kamera"),
  OnboardingContent(
      title: 'Pelajari Banyak Spesies Tumbuhan',
      image: 'assets/images/onboarding2.png',
      discription: "Belajar tentang banyak spesies tumbuhan"
          "yang ada di Dunia"),
  OnboardingContent(
      title: 'Tersedia Artikel',
      image: 'assets/images/onboarding3.png',
      discription: "Pelajari tentang tanaman lebih lanjut "
          "dengan beragam artikel yang tersedia"),
];
