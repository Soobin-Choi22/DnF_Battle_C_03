<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mall.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 가입을 진행할 캐릭터 스냅샷 확보
    캐릭터 character = (캐릭터) session.getAttribute("character");
    String 가입결과 = "";

    // 테스트 환경을 위해 서버 메모리(application)에 테라코타 전용 가입용 길드가 없으면 생성해둠 (Aggregation 타겟)
    길드 레전드길드 = (길드) application.getAttribute("globalGuild");
    if (레전드길드 == null) {
        레전드길드 = new 길드("아라드 수호자");
        application.setAttribute("globalGuild", 레전드길드);
    }

    String action = request.getParameter("action");
    if ("가입".equals(action)) {
        if (character == null) {
            가입결과 = "캐릭터 정보가 유실되었습니다. 생성을 먼저 진행하세요.";
        } else {
            String 플레이어ID = request.getParameter("playerId");
            
            // 💡 다이어그램 스펙: battle.길드가입(id, c, g)을 그대로 호출하여 검증 및 정원 제어
            전투 battle = new 전투();
            가입결과 = battle.길드가입(플레이어ID, character, 레전드길드);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Join Guild UI - 길드 가입</title>
</head>
<body>
    <h2>🏰 [신규 기능 2] 길드 가입 연계 시스템</h2>
    <hr>

    <% if (!가입결과.isEmpty()) { %>
        <div style="padding: 10px; background-color: #e8f5e9; border: 1px solid #4caf50; margin-bottom: 20px;">
            <strong>길드 사무소 알림:</strong> <%= 가입결과 %>
        </div>
    <% } %>

    <p>🛡️ 가입 가능 타겟 길드명: <strong>아라드 수호자</strong> (정원 최대 5명 제한)</p>

    <form method="post" action="Join_Guild_UI.jsp">
        <input type="hidden" name="action" value="가입">
        
        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <td>요청 플레이어 ID</td>
                <td><input type="text" name="playerId" value="<%= character != null ? character.get플레이어ID() : "" %>" required></td>
            </tr>
            <tr>
                <td>현재 대상 캐릭터명</td>
                <td><input type="text" value="<%= character != null ? character.get캐릭터명() : "캐릭터 없음" %>" disabled></td>
            </tr>
        </table>
        <br>
        <button type="submit">길드 가입 신청 (Aggregation 1:N)</button>
    </form>

    <br>
    <hr>
    <a href="Attack_Monster_UI.jsp">⚔️ 소속 길드명 반영 상태 확인하러 가기</a>
</body>
</html>
