import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcq_cbt/models/api_response.dart';
import 'package:mcq_cbt/models/subject_model.dart';
import 'package:mcq_cbt/pages/instruction_page.dart';
import 'package:mcq_cbt/services/subject_service.dart';

class PickSubjectPage extends StatefulWidget {
  @override
  _PickSubjectPageState createState() => _PickSubjectPageState();
}

class _PickSubjectPageState extends State<PickSubjectPage> {

  SubjectService get service => GetIt.I<SubjectService>();
  APIResponse<List<SubjectModel>> _apiResponse;

  bool isLoading = false;

  _fetchTransactions() async {
    if (_apiResponse != null) _apiResponse.data.clear();
    setState(() {
      isLoading = true;
    });

    _apiResponse = await service.getSubjectList();
    //await prefs.setString("giftcards", GiftcardModel.encodeList(_apiResponse.data));

    setState(() {
      isLoading = false;
    });
  }

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    _fetchTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _height = _size.height;
    final _width = _size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF00642B),),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: Center(child: Text('UBTH MCQ', style: GoogleFonts.adamina(color: Color(0xFF00642B)),)),
        actions: [
          SizedBox(width: 50.0,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 64.0, right: 64.0),
        child: CustomScrollView(
          slivers: [

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text('Courses', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 24.0, fontWeight: FontWeight.bold),),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 32.0,),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text('Select the desired course', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                ),
              ),
            ),

            getCourses(context),
          ],
        ),
      ),
    );
  }

  Widget getCourses(BuildContext context){
    return isLoading ?
    SliverToBoxAdapter(child: Center(child: CupertinoActivityIndicator(radius: 30.0,)))
        :
        _apiResponse.error ? SliverToBoxAdapter(child: Center(child: Text(_apiResponse.message, style: GoogleFonts.roboto(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),))
            :
    SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        crossAxisCount: 2,
      ),
      delegate: new SliverChildBuilderDelegate((BuildContext context, int index){
        SubjectModel model = _apiResponse.data[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>  InstructionPage(model.name, model.id)
              ));
            },
            child: Material(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: model.image,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(model.name, style: GoogleFonts.roboto(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
        childCount: _apiResponse.data.length
      ),
    );
  }

  void showSnackBar(BuildContext context, String message){
    var snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(label: "Ok", onPressed: (){
        _scaffoldKey.currentState.hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      }),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}
