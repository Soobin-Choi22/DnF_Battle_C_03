<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="mall.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 캐릭터 불러오기
    캐릭터 character = (캐릭터) session.getAttribute("character");

    if (character == null) {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류</title>
</head>
<body>

<h2>캐릭터 정보 없음</h2>
<p>먼저 캐릭터 생성 페이지를 실행하세요.</p>

<a href="Create_Chatacter_UI.jsp">캐릭터 생성하러 가기</a>

</body>
</html>

<%
        return;
    }

    // 전투 로직 실행
    전투 battle = new 전투();

    int 데미지 = battle.데미지계산(character);
    String 등급 = battle.등급부여(데미지);
    String 스킬명 = battle.스킬발동(character);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>몬스터 공격 결과</title>
</head>

<body>

<h2>몬스터 공격 결과</h2>

<p>플레이어ID : <%= character.get플레이어ID() %></p>
<p>캐릭터명 : <%= character.get캐릭터명() %></p>
<p>직업 : <%= character.get직업() %></p>
<p>레벨 : <%= character.get레벨() %></p>
<p>HP : <%= character.getHP() %></p>
<p>공격력 : <%= character.get공격력() %></p>

<hr>

<p>스킬 : <%= 스킬명 %></p>
<p>최종 데미지 : <%= 데미지 %></p>
<p>등급 : <%= 등급 %></p>

<hr>

<a href="Create_Chatacter_UI.jsp">캐릭터 생성 페이지</a><br>
<a href="Add_Item_UI.jsp">아이템 획득하기</a><br>
<a href="Join_Guild_UI.jsp">길드 가입하기</a>

</body>
</html>