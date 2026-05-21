<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="mall.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    캐릭터 character = (캐릭터)session.getAttribute("character");

    if(character == null) {
%>
    <h2>캐릭터 정보 없음</h2>
<%
        return;
    }

    전투 battle = new 전투();

    int 데미지 = battle.데미지계산(character);
    String 스킬명 = battle.스킬발동(character);
    String 등급 = battle.등급부여(데미지);
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
<p>레벨 : <%= character.get레벨() %></p>
<p>공격력 : <%= character.get공격력() %></p>

<hr>

<p>스킬 : <%= 스킬명 %></p>
<p>최종 데미지 : <%= 데미지 %></p>
<p>등급 : <%= 등급 %></p>

</body>
</html>