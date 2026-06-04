<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="Mall.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 캐릭터 불러오기
    캐릭터 character = (캐릭터) session.getAttribute("character");

    String 결과메시지 = "";

    String action = request.getParameter("action");

    if ("획득".equals(action)) {
        if (character == null) {
            결과메시지 = "캐릭터 정보가 존재하지 않습니다. 먼저 캐릭터를 생성하세요.";
        } else {
            String 플레이어ID = request.getParameter("playerId");
            String 아이템명 = request.getParameter("itemName");
            String 타입 = request.getParameter("itemType");

            int 가치 = 0;

            try {
                가치 = Integer.parseInt(request.getParameter("itemValue"));
            } catch (Exception e) {
                가치 = 0;
            }

            전투 battle = new 전투();
            결과메시지 = battle.아이템획득(플레이어ID, character, 아이템명, 타입, 가치);

            // character 객체 안의 인벤토리가 바뀐 상태를 세션에 다시 저장
            session.setAttribute("character", character);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Item UI</title>
</head>

<body>

<h2>아이템 획득 시스템</h2>

<% if (character == null) { %>

    <p>캐릭터 정보가 없습니다. 먼저 캐릭터를 생성하세요.</p>
    <a href="Create_Chatacter_UI.jsp">캐릭터 생성하러 가기</a>

<% } else { %>

    <p>현재 캐릭터 : <%= character.get캐릭터명() %></p>
    <p>플레이어ID : <%= character.get플레이어ID() %></p>
    <p>직업 : <%= character.get직업() %></p>

    <hr>

    <% if (!결과메시지.isEmpty()) { %>
        <p><strong>결과 :</strong> <%= 결과메시지 %></p>
        <hr>
    <% } %>

    <form method="post" action="Add_Item_UI.jsp">
        <input type="hidden" name="action" value="획득">

        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <td>플레이어 ID 확인</td>
                <td>
                    <input type="text" name="playerId"
                        value="<%= character.get플레이어ID() %>" required>
                </td>
            </tr>

            <tr>
                <td>아이템 이름</td>
                <td>
                    <input type="text" name="itemName"
                        placeholder="예: 낡은 대검, 마법 스태프" required>
                </td>
            </tr>

            <tr>
                <td>아이템 종류</td>
                <td>
                    <select name="itemType">
                        <option value="무기">무기</option>
                        <option value="방어구">방어구</option>
                        <option value="물약">물약</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td>아이템 가치</td>
                <td>
                    <input type="number" name="itemValue"
                        placeholder="예: 1200" required>
                </td>
            </tr>
        </table>

        <br>

        <button type="submit">아이템 획득</button>
    </form>

    <hr>

    <a href="Attack_Monster_UI.jsp">몬스터 공격하기</a><br>
    <a href="Join_Guild_UI.jsp">길드 가입하기</a><br>
    <a href="Create_Chatacter_UI.jsp">캐릭터 생성 페이지</a>

<% } %>

</body>
</html>