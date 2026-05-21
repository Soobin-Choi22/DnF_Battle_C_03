<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="mall.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("playerId");
    String 이름 = request.getParameter("charName");
    String 직업 = request.getParameter("job");

    String levelParam = request.getParameter("level");
    int 레벨 = 1;

    if(levelParam != null) {
        try {
            레벨 = Integer.parseInt(levelParam);
        } catch(Exception e) {
            레벨 = 1;
        }
    }

    전투 battle = new 전투();

    캐릭터 character = null;

    if ("전사".equals(직업)) {
        character = new 전사(id, 이름, 레벨, 직업);
    } else {
        character = new 마법사(id, 이름, 레벨, 직업);
    }

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
    <p>직업 : <%= character.get직업() %></p>
    <p>레벨 : <%= character.get레벨() %></p>
    <p>HP : <%= character.getHP() %></p>
    <p>공격력 : <%= character.get공격력() %></p>

<% } else { %>

    <h2>플레이어 인증 실패</h2>

<% } %>

</body>
</html>