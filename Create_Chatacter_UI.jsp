<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="Mall.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 기존 세션 캐릭터 먼저 불러오기
    캐릭터 character = (캐릭터) session.getAttribute("character");

    String 플레이어ID = request.getParameter("playerID");
    String 캐릭터명 = request.getParameter("characterName");
    String 직업 = request.getParameter("job");

    // form으로 새 캐릭터 생성 요청이 들어온 경우에만 새 객체 생성
    if (플레이어ID != null && 캐릭터명 != null && 직업 != null) {

        if ("전사".equals(직업)) {
            character = new 전사(플레이어ID, 캐릭터명, 1, 직업);
        }
        else if ("마법사".equals(직업)) {
            character = new 마법사(플레이어ID, 캐릭터명, 1, 직업);
        }

        // 생성된 캐릭터를 세션에 저장
        if (character != null) {
            session.setAttribute("character", character);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Character UI</title>
</head>

<body>

<h2>캐릭터 생성</h2>

<form method="post" action="Create_Chatacter_UI.jsp">
    <p>
        플레이어ID :
        <input type="text" name="playerID" value="<%= character != null ? character.get플레이어ID() : "hero" %>">
    </p>

    <p>
        캐릭터명 :
        <input type="text" name="characterName" value="<%= character != null ? character.get캐릭터명() : "" %>">
    </p>

    <p>
        직업 :
        <select name="job">
            <option value="전사">전사</option>
            <option value="마법사">마법사</option>
        </select>
    </p>

    <button type="submit">캐릭터 생성</button>
</form>

<hr>

<% if (character != null) { %>

    <h2>현재 세션에 저장된 캐릭터</h2>

    <p>플레이어ID : <%= character.get플레이어ID() %></p>
    <p>캐릭터명 : <%= character.get캐릭터명() %></p>
    <p>직업 : <%= character.get직업() %></p>
    <p>레벨 : <%= character.get레벨() %></p>
    <p>HP : <%= character.getHP() %></p>
    <p>공격력 : <%= character.get공격력() %></p>

    <hr>

    <a href="Attack_Monster_UI.jsp">몬스터 공격하기</a><br>
    <a href="Add_Item_UI.jsp">아이템 획득하기</a><br>
    <a href="Join_Guild_UI.jsp">길드 가입하기</a>

<% } else if (플레이어ID != null) { %>

    <h2>플레이어 인증 실패 또는 직업 선택 오류</h2>

<% } else { %>

    <p>아직 세션에 캐릭터가 없습니다. 위에서 캐릭터를 생성하세요.</p>

<% } %>

</body>
</html>