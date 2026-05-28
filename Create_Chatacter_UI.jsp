<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="mall.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 예시 데이터
    String 플레이어ID = request.getParameter("playerID");
    String 캐릭터명 = request.getParameter("characterName");
    String 직업 = request.getParameter("job");

    캐릭터 character = null;

    // 직업에 따라 객체 생성
    if("전사".equals(직업)) {
        character = new 전사(플레이어ID, 캐릭터명);
    }
    else if("마법사".equals(직업)) {
        character = new 마법사(플레이어ID, 캐릭터명);
    }

    // 세션 저장
    session.setAttribute("character", character);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Character UI</title>
</head>

<body>

<% if(character != null) { %>

    <h2>캐릭터 생성 완료</h2>

    <p>플레이어ID : <%= character.get플레이어ID() %></p>
    <p>캐릭터명 : <%= character.get캐릭터명() %></p>
    <p>직업 : <%= 직업 %></p>
    <p>레벨 : <%= character.get레벨() %></p>
    <p>HP : <%= character.getHP() %></p>
    <p>공격력 : <%= character.get공격력() %></p>

    <hr>

    <a href="attackMonster.jsp">몬스터 공격하기</a>

<% } else { %>

    <h2>플레이어 인증 실패</h2>

<% } %>

</body>
</html>