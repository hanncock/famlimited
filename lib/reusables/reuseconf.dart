import '../../services/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';




final AuthService auth = AuthService();

List images = [
  // 'thindigua_gardens.png',
  'Homepahe_1.webp',
  'thindigua_gardens.webp',
  'RV1.webp'
  // 'Homepage2.jpg',
  // 'homepage3.jpg',
  // 'homepage4.jpg',
  // 'bg2.jpg',
  // 'bg3.jpg',
  // 'bg4.jpg',
];

List services = [

  {
    "serviceTitle":"Rafiki Gardens",
    "image":"trees.webp"
  },
  {
    "serviceTitle":"Ruiru Villas",
    "image":"homepage4.webp"
  },
  {
    "serviceTitle":"Thindigua Gardens",
    "image":"thindigua_gardens.webp"
  },
 /* {
    "serviceTitle":"Farm Outreach",
    "image":"farmoutreach.jpeg"
  },*/
];

List whysus =[
  {
    "title":"Proven Expertise",
    "descr":"Our seasoned team excels in real estate with years of successful market navigation, offering informed decisions and optimal results."
  },
  {
    "title":"Customized Solution",
    "descr":"We pride ourselves on crafting personalized strategies to match your unique goals, ensuring a seamless real estate journey."
  },
  {
    "title":"Transparent Partnership",
    "descr":"Transparency is key in our client relationships. We prioritize clear communication and ethical practices, fostering trust and reliability throughout."
  }
];


formatCurrency(value) {
  if (value != null) {
    final formatCurrency =  NumberFormat.currency(
        locale: 'en_US', symbol: '', decimalDigits: 2);
    return formatCurrency.format(value);
  }
  return 0;
}

launchwhtsapp(messo)async{
  final Uri uri = Uri.parse("https://wa.me/+254716544543?text=${Uri.encodeComponent("${messo}")}");
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // Ensures a new tab is opened
    );
  } else {
    throw "Could not launch $uri";
  }
}