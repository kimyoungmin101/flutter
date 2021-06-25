import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  Widget get_in(text1, title){
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child:
          Text(
            text1,
            style: TextStyle(fontSize: 15),),
        ),
      ],
    );



  }
  final String first =
      "본 약관은 서비스 이용자가 뉴로어소시에이츠 주식회사(이하 회사라 합니다)가 제공하는 온라인 서비스 (이하 서비스라고 합니다)에 회원으로 가입하고 이를 이용함에 있어 회사와 그 이용자의 권리, 의무 및 책임 사항을 규정함을 목적으로 합니다.";
  final String second =
      "본 약관에서 사용하는 용어의 정의는 다음과 같습니다.\n 1. 서비스 : 이용자가 쇼핑몰에서의 판매활동을 통합적으로 관리·처리할 수 있도록 상품등록, 주문관리, 클레임처리 등을 할 수 있는 서비스를 말합니다.\n2. 이용자 : 본 약관에 따라 회사와 서비스 이용계약을 체결하고 회사가 제공하는 서비스를 이용하는 개인 또는 기업을 의미합니다.\n3. 아이디(ID) : 이용자의 서비스 이용을 위하여 생성하는 이용자 식별자를 의미합니다.\n4. 비밀번호 : 아이디(ID)와 일치된 이용자임을 확인하고, 이용자의 비밀을 보호하기 위해 이용자가 설정한 문자와 숫자의 조합을 의미합니다.\n5. 운영자 : 서비스의 전반적인 관리와 운영을 담당하는 회사의 직원을 말한다.\n6. 환불 : 결제자는 회사가 지정한 환불 가능 기간 내에 유료 서비스 이용을 철회한 경우 회사의 환불 정책에 따라 결제자에게 환불 가능한 금액을 지불한 수단으로 돌려주는 행위를 말한다.\n7. 유료서비스이용료 : 회사의 특화된 유료서비스를 이용하기 위하여 회원 일정 금액을 지불 하는 행위를 말 한다.\n8. 서비스 이용기간 : 회사의 유/무료 서비스 이용이 가능한 회원별 서비스 사용기간을 말한다\n9. 스팸 : 수신자가 원하지 않는데도 불구하고 정보통신망을 통해 일방적으로 전송 또는 게시되는 영리목적의 광고성 정보를 말합니다.\n10. 피싱메시지 : 메시지 내용 중 인터넷 주소를 클릭하면 악성코드가 설치되어 수신자가 모르는 사이에 금전적 피해 또는 개인·금융정보 탈취 피해를 야기하는 메시지를 말합니다.";
  final String third =
      "회사는 본 약관의 내용을 이용자가 쉽게 알 수 있도록 회원가입 페이지 및 기본정보 페이지에 게시합니다.\n회사는 전기통신사업법, 약관 규제에 관한 법률, 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 “정보통신망법”), 전자상거래 등에서의 소비자 보호에 관한 법률 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.\n회사가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 제1항의 방식에 따라 그 개정약관의 적용일자 7일 전부터 적용일자 전까지 홈페이지에 공지합니다.\n 다만, 이용자의 권리 또는 의무에 관한 중요한 규정의 변경은 최소한 30일 전에 공지하고 이용자가 사전에 등록한 이메일, 전화번호, 메일, 문자메시지 등의 전자적 수단을 통해 별도로 명확히 통지하도록 합니다.\n회사가 본 조 제3항에 따라 개정약관을 공지 또는 통지하면서 이용자에게 약관 변경 적용 일까지 거부의사를 표시하지 않으면 동의한 것으로 본다는 뜻을 명확하게 공지 또는 통지하였음에도 이용자가 명시적으로 거부의 의사표시를 하지 아니한 경우 이용자가 개정약관에 동의한 것으로 봅니다.\n이용자가 개정약관의 적용에 동의하지 않을 경우 회사는 개정약관의 내용을 적용할 수 없으며, 이 경우 이용자는 이용계약을 해지할 수 있습니다. 다만, 기존 약관을 적용할 수 없는 특별한 사정이 있는 경우에는 회사는 이용계약을 해지할 수 있습니다.\n본 약관은 이용자가 약관의 내용에 동의함으로써 효력이 발생하며 이용계약 종료 일까지 적용됩니다. 단, 채권 또는 채무관계가 있을 경우에는 채권, 채무의 완료 일까지로 규정합니다.";
  final String fourth =
      "본 약관에서 정하지 않은 사항과 본 약관의 해석에 관하여는 전기통신사업법, 개인정보보호법, 정보통신망법, 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제에 관한 법률 및 기타 관계법령 또는 상관례에 따릅니다.";
  final String fifth =
      "① 이용계약은 이용자가 되고자 하는 자(이하 입점사)가 약관의 내용에 대하여 동의를 한 다음 입점신청을 하고 회사가 이러한 신청에 대하여 승낙함으로써 체결됩니다.\n② 제1항에 따른 회사 승낙에도 불구하고 이용자는 회사와 서비스 이용에 대한 상담 또는 회사가 정한 기간 동안 무료서비스를 이용할 수 있을 뿐 이용요금을 선납하기 전까지는 유료서비스의 이용을 개시할 수 없습니다.\n③ 회사는 입점신청자의 신청에 대하여 서비스 이용을 승낙함을 원칙으로 합니다. 다만, 회사는 다음 각 호에 해당하는 신청에 대하여는 승낙을 하지 않거나 사후에 이용계약을 해지할 수 있습니다.\n1. 입점신청자가 본 약관에 의하여 이전에 이용자자격을 상실한 적이 있는 경우, 단 회사의 이용자 재가입 승낙을 얻을 경우에는 예외로 함\n2. 실명이 아니거나 타인의 명의를 이용한 경우\n3. 허위의 정보를 기재하거나, 회사가 제시하는 내용을 기재하지 않은 경우\n4. 만 14세 미만의 가입자인 경우\n5. 이용자가 서비스의 정상적인 제공을 저해하거나 다른 이용자의 서비스 이용에 지장을 줄 것으로 예상되는 경우\n6. 이용자의 귀책사유로 인하여 승인이 불가능하거나 기타 규정한 제반 사항을 위반하며 신청하는 경우\n7. 제19조 제3항에 의하여 회사로부터 계약해지를 당한 이후 1년이 경과하지 않은 경우\n8. 기타 회사가 관련법령 등을 기준으로 하여 명백하게 사회질서 및 미풍양속에 반할 우려가 있음을 인정하는 경우\n④ 본 조 제1항에 따른 신청에 있어 회사는 이용자의 종류에 따라 전문기관을 통한 실명확인 및 본인인증을 요청하거나 증빙자료를 요청할 수 있습니다.\n⑤ 회사는 본 조 제3항 각호에 따라 이용신청이 이루어지지 않는지 관리·감독할 수 있습니다.\n⑥ 회사는 다음 각호에 해당하는 신청에 대해서는 승낙을 지연할 수 있습니다.\n1. 회사의 설비에 여유가 없거나 기술적 장애가 있는 경우\n2. 서비스 상의 장애 또는 서비스 이용요금 결제수단의 장애가 발생한 경우\n3. 기타 회사가 재정적, 기술적으로 필요하다고 인정하는 경우\n⑦ 회사와 이용자가 서비스 이용에 관하여 별도의 계약을 체결한 경우, 당해 별도의 계약이 본 약관에 우선하여 적용됩니다.";
  final String sixth =
      "1. 본 약관은 2021년 1월 27일부터 적용됩니다.\n서비스 이용약관 시행일자 : 2021년 1월 27일\n서비스 이용약관 공고일자 : 2021년 1월 27일";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이용약관'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text('EGLV 서비스 이용약관', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),


              get_in(first, '제1조 (목적)'),

              get_in(second, '제2조 (용어의 정의)'),

              get_in(third, '제3조 (약관의 게시와 개정)'),
              get_in(fourth, '제4조 (약관 외 준칙)'),

              get_in(fifth, '제5조 (이용계약의 체결)'),
              get_in(sixth,"*부칙*"),



              SizedBox(
                height: 20,
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
