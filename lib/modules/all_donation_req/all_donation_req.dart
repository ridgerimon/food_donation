import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_donation/layout/user_app/cubit/cubit.dart';
import 'package:food_donation/layout/user_app/cubit/states.dart';
import 'package:food_donation/models/request_model.dart';
import 'package:food_donation/modules/info_request/info_request_screen.dart';
import 'package:food_donation/shared/components/components.dart';

class AllDonationReqScreen extends StatelessWidget {
  const AllDonationReqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutAppCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'All Requests',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.separated(
                    itemBuilder: (context, index) => RequestList(
                        HomeLayoutAppCubit.get(context).allRequest[index],
                        context),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount:
                        HomeLayoutAppCubit.get(context).allRequest.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget RequestList(RequestModel model, context) => InkWell(
        onTap: () {
          navigateTo(context, InfoRequestScreen(requestModel: model));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/logo_name.png'),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.familyName}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model.familyNumber}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  '${model.familyMembers}',
                ),
              )
            ],
          ),
        ),
      );
}
