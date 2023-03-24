import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool isEdit = true;
  String editNumber = "010-7894-7894";
  String editEmail = "sungmi@sungmi.com";
  String editAddress = "경기도 고양시 덕양구 고양동 중부대 828호 줄바꿈도 돼";
  final numController = TextEditingController(); //텍스트컨트롤러를 생성하여 필드에 할당
  final emailController = TextEditingController();
  final addController = TextEditingController();

  bool isValidEmailFormat() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this as String);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isEdit
          ? AppBar(
              title: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Image.asset(
                  "assets/img/whitelogo.png",
                  height: 80,
                ),
              ),
              automaticallyImplyLeading: false, //기본 왼ㅉ고 토굴 안생기게
              backgroundColor: Color(0xff0099FF),
              toolbarHeight: 80,
              elevation: 0.0, //앱바 입체감 없애기
              actions: [
                IconButton(
                  icon: Icon(Icons.menu),
                  iconSize: 30,
                  onPressed: () {
                    fullMenu();
                  },
                )
              ],
            )
          : AppBar(
              backgroundColor: Color(0xff0099FF),
              toolbarHeight: 70,
              elevation: 0.0, //앱바 입체감 없애기
              leading: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: () {
                    setState(() {
                      numController.text = editNumber;
                      emailController.text = editEmail;
                      addController.text = editAddress;
                      isEdit = !isEdit;
                    });
                  },
                  child: Text(
                    "취소",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                    ),
                    onPressed: () {
                      setState(() {
                        editNumber = numController.text;
                        editEmail = emailController.text;
                        editAddress = addController.text;
                        isEdit = !isEdit;
                      });
                    },
                    child: Text("완료",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )))
              ],
            ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //글자들이 왼쪽에 붙게
            children: [
              Stack(//Positioned 를 쓸수있음
                  children: [
                Positioned(
                  //Stack 안에서만 사용가능
                  left: 0,
                  top: 40,
                  child: Container(
                    width: 450,
                    height: 2,
                    color: Color(0xff9C9C9C),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                  child: Row(
                    children: [
                      profileImage(),
                      SizedBox(
                        width: 17.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                            width: 100,
                            height: 25,
                            child: Text(
                              "김성미 (여)",
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5A5A5A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ), //프로필 이름 소개
                isEdit
                    ? Positioned(
                        right: 0,
                        top: 50,
                        child: IconButton(
                          icon: Icon(Icons.create),
                          color: Color(0xff9C9C9C),
                          onPressed: () {
                            setState(() {
                              isEdit = !isEdit;
                            });
                          },
                        ),
                      )
                    : Positioned(
                        left: 113,
                        top: 75,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  width: 1, color: Color(0xff9c9c9c))),
                          child: IconButton(
                            padding: EdgeInsets.all(3),
                            constraints: BoxConstraints(), //아이콘위젯 패딩아예없애는법
                            icon: Icon(Icons.photo_camera),
                            color: Color(0xff9C9C9C),
                            onPressed: () {
                              showModalBottomSheet(
                                  //밑에서 열리는 메뉴
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Column(
                                                mainAxisSize:
                                                    MainAxisSize.min, //크기만큼만 차지
                                                children: [
                                              SizedBox(
                                                //카드형식 높이주기위해 감쌈
                                                height: 52,
                                                child: Card(
                                                  //카드형식
                                                  elevation: 0,
                                                  child: ListTile(
                                                    leading: Icon(
                                                        Icons.photo_camera),
                                                    iconColor:
                                                        Color(0xff9c9c9c),
                                                    title: Text('카메라',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff9c9c9c),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    subtitle:
                                                        Divider(thickness: 1),
                                                    onTap: () {},
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 52,
                                                child: Card(
                                                  elevation: 0,
                                                  child: ListTile(
                                                    leading: Icon(Icons.photo),
                                                    iconColor:
                                                        Color(0xff9c9c9c),
                                                    title: Text('라이브러리',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff9c9c9c),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    subtitle:
                                                        Divider(thickness: 1),
                                                    onTap: () {},
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ])));
                                  });
                            },
                          ),
                        ),
                      ),
              ]),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 280,
                margin: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                child: isEdit ? profileForm() : editProfileForm(),
              ), //프로필 정보
              SizedBox(
                height: 25.0,
              ),
              Center(
                child: isEdit
                    ? Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        width: 130,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Color(0xff9C9C9C),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(0),
                          ),
                          child: Text(
                            "학적부 열람",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff0099FF),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      )
                    : Container(),
              ), //학적부 열람
              SizedBox(
                height: 40.0,
              ),
              isEdit ? guardProfile() : editGuardProfile(),
            ],
          ),
        ),
      ),
    );
  }

  Future fullMenu() {
    return showModalBottomSheet(
        //밑에서 열리는 메뉴
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        builder: (BuildContext context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              color: Colors.white,
              child: Center(
                  child: Column(
                      mainAxisSize: MainAxisSize.min, //크기만큼만 차지
                      children: [
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.circleUser),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('프로필',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 52,
                      child: Card(
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.chartPie),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('시간표',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.qrcode),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('출석 QR',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/qr');
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.clipboardCheck),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('출석 현황',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.userPen),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('시험',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.book),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('과제',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.envelopeOpen),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('건의사항',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.gear),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('설정',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ])));
        });
  }

  Widget profileImage() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
          border: Border.all(width: 2, color: Color(0xff9c9c9c))),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/img/profilebasic.png'),
        radius: 55.0,
      ),
    );
  }

  Widget profileForm() {
    return Form(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              SizedBox(
                height: 25.0,
              ),
              Text.rich(
                //Default Textstyle을 기본적으로 적용 - RichText는 기본스타일을 명시해줘야함
                TextSpan(
                  //글자, ,문장을 모아 문단을 구성
                  children: <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Color(0xffFA2A2A),
                          letterSpacing: 2.0,
                        )),
                    TextSpan(text: '학교'),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text("생년월일"),
              SizedBox(
                height: 25.0,
              ),
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Color(0xffFA2A2A),
                          letterSpacing: 2.0,
                        )),
                    TextSpan(text: '번호'),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Color(0xffFA2A2A),
                          letterSpacing: 2.0,
                        )),
                    TextSpan(text: '이메일'),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text("주소"),
            ],
          ),
          SizedBox(
            width: 30.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.0,
              ),
              Text("서정중학교 2학년"),
              SizedBox(
                height: 25.0,
              ),
              Text("2001년 02월 07일"),
              SizedBox(
                height: 25.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                child: Text(editNumber),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                child: Text(editEmail),
              ),
              SizedBox(
                height: 25.0,
                width: 50.0,
              ),
              Container(
                width: 230, //너비를 지정해주면
                margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                child: Text(
                  editAddress,
                  overflow: TextOverflow.ellipsis, //줄바꿈
                  maxLines: 3, //개수
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget editProfileForm() {
    return Form(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              SizedBox(
                height: 25.0,
              ),
              Text.rich(
                //Default Textstyle을 기본적으로 적용 - RichText는 기본스타일을 명시해줘야함
                TextSpan(
                  //글자, ,문장을 모아 문단을 구성
                  children: <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Color(0xffFFB0B0),
                          letterSpacing: 2.0,
                        )),
                    TextSpan(
                        text: '학교',
                        style: TextStyle(
                          color: Color(0xffCFCFCF),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                "생년월일",
                style: TextStyle(
                  color: Color(0xffCFCFCF),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Color(0xffFA2A2A),
                          letterSpacing: 2.0,
                        )),
                    TextSpan(
                        text: '번호',
                        style: TextStyle(
                          color: Color(0xff9C9C9C),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Color(0xffFA2A2A),
                          letterSpacing: 2.0,
                        )),
                    TextSpan(text: '이메일'),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text("주소"),
            ],
          ),
          SizedBox(
            width: 30.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 230,
                height: 32,
                padding: EdgeInsets.fromLTRB(10.0, 3.0, 0.0, 0.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Color(0xffCFCFCF),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "서정중학교 2학년",
                  style: TextStyle(
                    color: Color(0xffCFCFCF),
                  ),
                ),
              ),
              SizedBox(
                height: 17.0,
              ),
              Container(
                width: 230,
                height: 32,
                padding: EdgeInsets.fromLTRB(10.0, 3.0, 0.0, 0.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Color(0xffCFCFCF),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "2001년 02월 07일",
                  style: TextStyle(color: Color(0xffCFCFCF)),
                ),
              ),
              SizedBox(
                height: 17.0,
              ),
              Container(
                  width: 230,
                  height: 32,
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color(0xff9c9c9c),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: numController, //컨트롤러롤 넘컨트롤러에 값을 박아
                    style: TextStyle(
                      color: Color(0xff9c9c9c),
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none, //테두리없앰
                        hintStyle: TextStyle(color: Color(0xff9c9c9c))),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, //숫자만
                      NumberFormatter(),
                      LengthLimitingTextInputFormatter(13) //최대 13글자
                    ],
                  )),
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: 230,
                height: 32,
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 1.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Color(0xff9c9c9c),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      color: Color(0xff9c9c9c), fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      border: InputBorder.none, //테두리없앰
                      hintStyle:
                          TextStyle(fontSize: 14, color: Color(0xff9c9c9c))),
                ),
              ),
              SizedBox(
                height: 15.0,
                width: 50.0,
              ),
              Flexible(
                child: Container(
                  width: 230, //너비를 지정해주면
                  height: 65,
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color(0xff9c9c9c),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: addController,
                    maxLines: 5,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xff9c9c9c),
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: InputBorder.none, //테두리없앰
                        hintStyle:
                            TextStyle(fontSize: 14, color: Color(0xff9c9c9c))),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget guardProfile() {
    return Form(
      child: Stack(children: [
        Positioned(
          top: 13,
          child: Container(
            width: 450,
            height: 2,
            color: Color(0xff9C9C9C),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
          width: 114.0,
          height: 30.0,
          color: Colors.white,
          child: Text(
            "보호자 프로필",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff5A5A5A),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ), //보호자프로필
        Container(
          height: 200,
          margin: EdgeInsets.fromLTRB(65.0, 30.0, 0.0, 0.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "성함",
                    style: TextStyle(
                        color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "번호",
                    style: TextStyle(
                        color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                width: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "박신비",
                    style: TextStyle(
                        color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                    child: Text(
                      "010-7894-4949",
                      style: TextStyle(
                          color: Color(0xff9C9C9C),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
        ), //보호자 프로필
      ]),
    );
  }

  Widget editGuardProfile() {
    return Form(
      child: Stack(children: [
        Positioned(
          top: 13,
          child: Container(
            width: 450,
            height: 2,
            color: Color(0xffCFCFCF),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
          width: 110.0,
          height: 30.0,
          color: Colors.white,
          child: Text(
            "보호자 프로필",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffCFCFCF),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ), //보호자프로필
        Container(
          margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
          child: Row(
            children: [
              SizedBox(
                width: 65.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "성함",
                    style: TextStyle(
                        color: Color(0xffCFCFCF), fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "번호",
                    style: TextStyle(
                        color: Color(0xffCFCFCF), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    width: 230,
                    height: 32,
                    padding: EdgeInsets.fromLTRB(10.0, 3.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Color(0xffCFCFCF),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "박신비",
                      style: TextStyle(
                          color: Color(0xffCFCFCF),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: 230,
                    height: 32,
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Color(0xffCFCFCF),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "010-7894-4949",
                      style: TextStyle(
                          color: Color(0xffCFCFCF),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ), //보호자 프로필
      ]),
    );
  }
}

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer(); //동기화를 보장, wirte를 호출하여 기존에 문자열추가
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); //문자열 추가
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }
    var string = buffer.toString(); //버퍼의 내용을 문자열로 만들기위함
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
