<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mall.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 기존 생성된 캐릭터 객체를 획득 (Composition 구조)
    캐릭터 character = (캐릭터) session.getAttribute("character");
    String 결과메시지 = "";

    // Form POST 요청이 들어왔을 때 수행
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

            // 💡 다이어그램 스펙: 전투 클래스를 생성하여 아이템획득 비즈니스 로직 호출
            전투 battle = new 전투();
            결과메시지 = battle.아이템획득(플레이어ID, character, 아이템명, 타입, 가치);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Item UI - 아이템 획득</title>
</head>
<body>
    <h2>🎁 [신규 기능 1] 아이템 획득 시스템</h2>
    <hr>
    
    <% if (!결과메시지.isEmpty()) { %>
        <div style="padding: 10px; background-color: #e3f2fd; border: 1px solid #2196f3; margin-bottom: 20px;">
            <strong>시스템 브리핑:</strong> <%= 결과메시지 %>
        </div>
    <% } %>

    <form method="post" action="Add_Item_UI.jsp">
        <input type="hidden" name="action" value="획득">
        
        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <td>플레이어 ID 확인</td>
                <td><input type="text" name="playerId" value="<%= character != null ? character.get플레이어ID() : "" %>" required></td>
            </tr>
            <tr>
                <td>아이템 이름</td>
                <td><input type="text" name="itemName" placeholder="예: 낡은 대검, 마법 스태프" required></td>
            </tr>
            <tr>
                <td>아이템 종류 (타입)</td>
                <td>
                    <select name="itemType">
                        <option value="무기">무기</option>
                        <option value="방어구">방어구</option>
                        <option value="물약">물약</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>아이템 가치 (수치)</td>
                <td><input type="number" name="itemValue" placeholder="예: 1200 (1000이상 전설)" required></td>
            </tr>
        </table>
        <br>
        <button type="submit">아이템 인벤토리 주입 (Composition 1:N)</button>
    </form>

    <br>
    <hr>
    <a href="Attack_Monster_UI.jsp">⚔️ 현재 인벤토리 상태 및 전투 결과 보러가기</a>
</body>
</html>
