<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="mall.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 캐릭터 불러오기
    캐릭터 character = (캐릭터) session.getAttribute("character");

    String 가입결과 = "";

    // application 영역에 공용 길드 저장
    길드 레전드길드 = (길드) application.getAttribute("globalGuild");

    if (레전드길드 == null) {
        레전드길드 = new 길드("아라드 수호자");
        application.setAttribute("globalGuild", 레전드길드);
    }

    String action = request.getParameter("action");

    if ("가입".equals(action)) {
        if (character == null) {
            가입결과 = "캐릭터 정보가 없습니다. 먼저 캐릭터를 생성하세요.";
        } else {
            String 플레이어ID = request.getParameter("playerId");

            전투 battle = new 전투();
            가입결과 = battle.길드가입(플레이어ID, character, 레전드길드);

            // 길드 정보가 캐릭터에 반영되는 구조라면 세션에 다시 저장
            session.setAttribute("character", character);

            // 길드도 application에 다시 저장
            application.setAttribute("globalGuild", 레전드길드);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join Guild UI</title>
</head>

<body>

<h2>길드 가입 시스템</h2>

<% if (character == null) { %>

    <p>캐릭터 정보가 없습니다. 먼저 캐릭터를 생성하세요.</p>
    <a href="Create_Chatacter_UI.jsp">캐릭터 생성하러 가기</a>

<% } else { %>

    <p>현재 캐릭터 : <%= character.get캐릭터명() %></p>
    <p>플레이어ID : <%= character.get플레이어ID() %></p>
    <p>직업 : <%= character.get직업() %></p>

    <hr>

    <p>가입 가능 길드명 : <strong><%= 레전드길드.get길드명() %></strong></p>

    <% if (!가입결과.isEmpty()) { %>
        <p><strong>가입 결과 :</strong> <%= 가입결과 %></p>
        <hr>
    <% } %>

    <form method="post" action="Join_Guild_UI.jsp">
        <input type="hidden" name="action" value="가입">

        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <td>요청 플레이어 ID</td>
                <td>
                    <input type="text" name="playerId"
                        value="<%= character.get플레이어ID() %>" required>
                </td>
            </tr>

            <tr>
                <td>현재 대상 캐릭터명</td>
                <td>
                    <input type="text"
                        value="<%= character.get캐릭터명() %>" disabled>
                </td>
            </tr>

            <tr>
                <td>가입 대상 길드</td>
                <td>
                    <input type="text"
                        value="<%= 레전드길드.get길드명() %>" disabled>
                </td>
            </tr>
        </table>

        <br>

        <button type="submit">길드 가입 신청</button>
    </form>

    <hr>

    <a href="Attack_Monster_UI.jsp">몬스터 공격하기</a><br>
    <a href="Add_Item_UI.jsp">아이템 획득하기</a><br>
    <a href="Create_Chatacter_UI.jsp">캐릭터 생성 페이지</a>

<% } %>

</body>
</html>