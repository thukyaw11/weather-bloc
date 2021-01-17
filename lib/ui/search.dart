import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/bloc/search/bloc/search_bloc.dart';
import 'package:weather_app/ui/bloc_home.dart';
import 'package:weather_app/utils/routeFade.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);

    return Scaffold(
        resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 50,),

              Text(
                'Search by City Name',
                style: GoogleFonts.lato(
                  textStyle: TextStyle( letterSpacing: .5, fontSize: 30),
                ),
              ),
              SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child:TextFormField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: new InputDecoration(
                          labelText: "Search",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(
                            ),
                          ),
                          //fillColor: Colors.green
                        ),
                      ),),
                  ),

                  Container(
                    margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: IconButton(
                        onPressed: () {
                          if(_searchController.text != ''){
                            searchBloc..add(FetchCityEvent(cityName: _searchController.text));
                          }
                        },
                        icon: Icon(Icons.search,),
                      ),
                    ),

                ],
              ),

              SizedBox(height: 30,),
              BlocBuilder<SearchBloc, SearchState>(builder: (context, state){
                if(state is CityEmptyState) {
                  return Center(child: Text("Type to search"),);
                }

                if(state is CityLoadingState) {
                  return Center(child: CircularProgressIndicator(),);
                }

                if(state is CityNoResultState) {
                  return Center(child: Text("Result not found!"));
                }

                if(state is CityErrorState) {
                  return Center(child: Text(state.error),);
                }

                if(state is CityLoadedState) {
                  return Expanded(

                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.cityModels.length,
                      itemBuilder: (BuildContext context, int index){
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                              FadeRoute(page:  BlocHome(cityCode : state.cityModels[index].woeId))
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Card(
                              elevation: 0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.cloud, size: 50),
                                    title: Text('${state.cityModels[index].title}'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                return Text("hello");
              }),



            ],
          ),
        ),
      ),
    );
  }
}
