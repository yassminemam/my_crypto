class AppAssets {
  static const profile_active_ic = 'assets/icon/bar/profile_active_ic.svg';
  static const profile_ic = 'assets/icon/bar/profile_ic.svg';
  static const countries_active_ic = 'assets/icon/bar/countries_active_ic.svg';
  static const countries_ic = 'assets/icon/bar/countries_ic.svg';
  static const services_active_ic = 'assets/icon/bar/services_active_ic.svg';
  static const services_ic = 'assets/icon/bar/services_ic.svg';
  static const avatar_placeholder_ic = "assets/icon/avatar_placeholder_ic.jpg";
  static const add_img_ic = 'assets/icon/add_img_ic.svg';
  static const password_ic = 'assets/icon/password_ic.svg';
  static const calendar_ic = 'assets/icon/calendar_ic.svg';
  static const delete_tag_ic = 'assets/icon/delete_tag_ic.svg';
  static const back_ic = 'assets/icon/back_ic.svg';
  static const login_bg = 'assets/bg/login_bg.svg';
  static const error_ic = 'assets/icon/error_ic.svg';
  static const subtract_ic = 'assets/icon/subtract_ic.svg';
  static const add_ic = 'assets/icon/add_ic.svg';
  static const rating_ic = 'assets/icon/rating_ic.svg';
  static const shopping_cart_ic = 'assets/icon/shopping_cart_ic.svg';
  static const done_ic = 'assets/icon/done_ic.svg';
  static const gray_circle_ic = 'assets/icon/gray_circle_ic.svg';
  static const birthDate = "Birth Date";
  static const male = "Male";
  static const female = "Female";
  static const salary = "Salary";
  static const skills = "Skills";
  static const gender = "Gender";
  static const errorEnterValidEmail = "Please enter a valid email";
  static const errorRequiredField = "requiredField";
  static const submit = "Submit";
  static const errorSelectFromList = 'Please select only from available.';
  static const errorSelectedBefore = 'You already entered that before.';
  static const errorPasswordLength =
      "Please enter a valid password at least 8 characters.";
  static const errorPasswordNotMatching = "Please enter a matching password.";
  static const errorAboutLength =
      "Please enter a valid bio at least 10 characters.";
  static const yes = "Yes";
  static const no = "No";
  static const profileHeader = "Who am I";
  static const favSocialMedia = "Favourite Social Media";
  static const countriesHeader = "Countries";
  static const servicesHeader = "Services";
  static const popularServicesHeader = "Popular Services";
  static const country = "Country";
  static const capital = "Capital";
  static const error = "Sorry something went wrong!";
  static const countriesPageHint =
      "Scroll horizontally to show more pages numbers.";

  static String getSocialMediaAssets({required String value}){
    return "assets/icon/${value}_ic.svg";
  }
}