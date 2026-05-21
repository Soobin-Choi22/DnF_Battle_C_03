<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.*" %>
<%
    // 1. 기본 인코딩 설정 (POST 대비)
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("playerId");
    String 이름 = request.getParameter("charName");
    String 직업 = request.getParameter("job");

    // ⭐ [한글 깨짐 철벽 방어] 
    // 브라우저가 ISO-8859-1(톰캣 기본)로 잘못 해석해 깨트린 한글을 다시 UTF-8 바이트로 추출해 복원합니다.
    if (이름 != null) {
        이름 = new String(이름.getBytes("ISO-8859-1"), "UTF-8");
    }
    if (직업 != null) {
        직업 = new String(직업.getBytes("ISO-8859-1"), "UTF-8");
    }

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
    캐릭터 character = battle.캐릭터생성(id, 이름, 직업, 레벨);

    // ⭐ session 저장
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

<% } else { %>

    <h2>플레이어 인증 실패</h2>

<% } %>

</body>
</html>
