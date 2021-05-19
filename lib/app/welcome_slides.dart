import 'package:flutter/material.dart';
import 'package:intro_slider/slide_object.dart';

List<Slide> welcomeSlides = [
  new Slide(
    title: "Bienvenido/a a SITEICA",
    description: "Gracias por descargar la aplicación de rastreo SITEICA."
        "Con su uso estás ayudando a mantener controlada la enfermedad infecciosa.",
    pathImage: "assets/images/thanks.png",
    backgroundColor: Colors.white,
    styleTitle: _welcomeTitleStyle,
    styleDescription: _welcomeDescriptionStyle,
  ),
  new Slide(
    title: "Totalmente anónimo",
    description: "SITEICA no recopila datos personales de ningún tipo.",
    pathImage: "assets/images/secure.png",
    backgroundColor: Colors.white,
    styleTitle: _welcomeTitleStyle,
    styleDescription: _welcomeDescriptionStyle,
  ),
  new Slide(
    title: "Siempre informado",
    description:
        "Te mantendremos informado del estado de la enfermedad en todo momento.",
    pathImage: "assets/images/info.png",
    backgroundColor: Colors.white,
    styleTitle: _welcomeTitleStyle,
    styleDescription: _welcomeDescriptionStyle,
  ),
  new Slide(
    title: "Política de privacidad",
    description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    marginDescription:
        EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
    backgroundColor: Colors.white,
    styleTitle: _welcomeTitleStyle,
    styleDescription: _welcomeDescriptionStyle,
  ),
];


Widget renderNextBtn() {
  return Icon(
    Icons.navigate_next,
    color: Color(0xff6C63FF),
  );
}

Widget renderDoneBtn() {
  return Icon(
    Icons.done,
    color: Color(0xff6C63FF),
  );
}

Widget renderSkipBtn() {
  return Icon(
    Icons.skip_next,
    color: Color(0xff6C63FF),
  );
}

const TextStyle _welcomeTitleStyle = TextStyle(
    color: Color(0xff000000),
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'RobotoMono');
const TextStyle _welcomeDescriptionStyle = TextStyle(
    color: Color(0xff000000),
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'RobotoMono');
