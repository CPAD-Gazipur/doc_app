import 'package:doc_app/components/components.dart';
import 'package:doc_app/models/auth_model.dart';
import 'package:doc_app/providers/dio_provider.dart';
import 'package:doc_app/screens/screens.dart';
import 'package:doc_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doctor = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Doctor Details',
        icon: const FaIcon(Icons.arrow_back_ios),
        actions: [
          IconButton(
            onPressed: () async {
              final favList =
                  Provider.of<AuthModel>(context, listen: false).getFavorite;

              if (favList.contains(doctor['doc_id'])) {
                favList.removeWhere((id) => id == doctor['doc_id']);
              } else {
                favList.add(doctor['doc_id']);
              }

              Provider.of<AuthModel>(context, listen: false)
                  .setFavorite(favList);

              final tokenTemp = await SharedPreferencesService.getToken() ?? '';

              if (tokenTemp != '') {
                final result = await DioProvider().storeFavoriteDoctor(
                  token: tokenTemp.toString(),
                  favoriteDoctors: favList,
                );
                if (result) {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                }
              }
            },
            icon: FaIcon(
              isFavorite ? Icons.favorite_rounded : Icons.favorite_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              DoctorProfileInfoSection(
                doctor: doctor,
              ),
              DoctorProfileDetailsSection(
                doctor: doctor,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/booking-screen',
                      arguments: {
                        'doctor_id': doctor['doc_id'],
                      },
                    );
                  },
                  width: double.infinity,
                  title: 'Book Appointment',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
