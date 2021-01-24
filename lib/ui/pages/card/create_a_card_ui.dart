import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/helpers/helpers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateACardUi extends StatelessWidget {

  final String uid;
  final CardUserModel cardUserModel;

  const CreateACardUi({Key key, this.uid, this.cardUserModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final labels = AppLocalizations.of(context);
    final fx = Get.put(FormXController());

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.linearToSrgbGamma(),
          image: NetworkImage(
              "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('create-a-card'.tr),
            backgroundColor: Colors.white10,
            elevation: 0,
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: GetX<AuthController>(
                initState: (state) => AuthController(),
                builder: (disposable) {
                  if (disposable?.firestoreUser?.value?.uid == null) {
                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    fx.cardUserModel.value.id = disposable?.firestoreUser?.value?.uid;
                  }
                  return Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              AvatarCard(cardUserModel),
                              SizedBox(height: 48.0),
                              //TODO titre pro link to elasticsearch
                              //TODO titreFormField translate to labels on card
                              //TODO titre pro to validator list
                              FormInputFieldWithIcon(
                                controller: fx.jobTitle.value,
                                iconPrefix: Icons.business,
                                labelText: labels?.auth?.nameFormField,
                                validator: Validator(labels).name,
                                keyboardType: TextInputType.name,
                                onChanged: (value) => fx.jobTitle.value,
                                onSaved: (value) =>
                                    fx.cardUserModel.value.job = value,
                                maxLines: 1,
                              ),
                              FormVerticalSpace(),
                              //TODO lieu controller link to elasticsearch
                              //TODO lieu translate to labels on card
                              FormInputFieldWithIcon(
                                controller: fx.jobLocation.value,
                                iconPrefix: Icons.location_on,
                                labelText: labels?.auth?.nameFormField,
                                // validator: Validator(labels).streetAdress,
                                keyboardType: TextInputType.streetAddress,
                                onChanged: (value) => fx.jobAddress.value,
                                onSaved: (value) =>
                                    fx.cardUserModel.value.location = value,
                                maxLines: 2,
                              ),
                              FormVerticalSpace(),
                              FormInputFieldWithIcon(
                                controller: fx.jobActivitySector.value,
                                iconPrefix: Icons.local_activity,
                                labelText: labels?.auth?.nameFormField,
                                // validator: Validator(labels).streetAdress,
                                keyboardType: TextInputType.name,
                                onChanged: (value) => fx.jobActivitySector.value,
                                onSaved: (value) =>
                                fx.cardUserModel.value.activity = value,
                                maxLines: 2,
                              ),
                              FormVerticalSpace(),
                              //TODO Description pro
                              //TODO DescriptionFormField translate to labels on card
                              //TODO Description to validator list
                              FormInputFieldWithIcon(
                                controller: fx.jobDesc.value,
                                iconPrefix: Icons.description,
                                labelText: labels?.auth?.nameFormField,
                                validator: Validator(labels).name,
                                keyboardType: TextInputType.multiline,
                                onChanged: (value) => fx.jobDesc.value,
                                onSaved: (value) =>
                                    fx.cardUserModel.value.description = value,
                                maxLines: 5,
                              ),
                              FormVerticalSpace(),
                              //TODO Contact pro
                              //TODO ContactFormField translate to labels on card
                              //TODO Contact to validator list
                              FormInputFieldWithIcon(
                                controller: fx.jobContact.value,
                                iconPrefix: Icons.contact_page,
                                labelText: labels?.auth?.emailFormField,
                                validator: Validator(labels).email,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) => fx.jobContact.value,
                                onSaved: (value) =>
                                    fx.cardUserModel.value.contact = value,
                                maxLines: 2,
                              ),
                              FormVerticalSpace(),
                              //TODO Horaire pro
                              //TODO HoraireFormField translate to labels on card
                              //TODO Horaire to validator list
                              FormInputFieldWithIcon(
                                controller: fx.jobNumber.value,
                                iconPrefix: Icons.call,
                                labelText: labels?.auth?.nameFormField,
                                validator: Validator(labels).number,
                                keyboardType: TextInputType.datetime,
                                onChanged: (value) => fx.jobNumber.value,
                                onSaved: (value) =>
                                    fx.cardUserModel.value.number = value,
                                maxLines: 2,
                              ),
                              FormVerticalSpace(),
                              //TODO Reference pro
                              //TODO ReferenceFormField translate to labels on card
                              //TODO Reference to validator list
                              FormInputFieldWithIcon(
                                controller: null,
                                iconPrefix: Icons.image,
                                labelText: labels?.auth?.nameFormField,
                                keyboardType: TextInputType.url,
                                // onChanged: (value) => cardController.updateCard(context),
                                onSaved: (value) => null,
                                maxLines: 2,
                              ),
                              FormVerticalSpace(),
                              //TODO Disponibility pro
                              //TODO DisponibilityFormField translate to labels on card
                              //TODO Disponibility to validator list
                              FormInputFieldWithIcon(
                                controller: fx.jobSchedules.value,
                                iconPrefix: Icons.event_busy,
                                labelText: labels?.auth?.nameFormField,
                                onChanged: (value) => fx.jobSchedules.value,
                                onSaved: (value) =>
                                fx.cardUserModel.value.dateCreated = value,
                                maxLines: 2,
                              ),
                              FormVerticalSpace(),
                              Obx(
                                () => fx.jobAvailability.value
                                    ? Container(
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          backgroundColor: Colors.green,
                                        )),
                                      )
                                    : FlatButton(
                                        onPressed: () async {
                                          if (_formKey.currentState.validate()) {
                                            fx.submitFunc.value;
                                            fx.updateTheValues();
                                            Database().saveACard(fx.cardUserModel.value, disposable?.firestoreUser?.value?.uid);
                                          }
                                        },
                                        child: Text(
                                          "Change the value",
                                          style: TextStyle(color: Colors.white),
                                        )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )),
    );
  }
}
