<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.GameCharacter" %>
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

   
    GameCharacter character = null;
    if (id != null && !id.trim().isEmpty()) {
        character = new GameCharacter(id, 이름, 직업, 레벨);
        
      
        character.addItem("I001", "초보자의 검", "무기", 100);
        
        session.setAttribute("character", character);
    } else {
        session.removeAttribute("character");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Character UI</title>
</head>
<body>

<% if(character != null) { %>

    <h2>캐릭터 생성 완료 [Phase 2]</h2>

    <p>플레이어ID : <%= character.getPlayerId() %></p>
    <p>캐릭터명 : <%= character.getCharName() %></p>
    <p>직업 : <%= character.getJob() %></p>
    <p>레벨 : <%= character.getLevel() %></p>
    <p>HP : <%= character.getHp() %></p>
    <p>공격력 : <%= character.getAttackPower() %></p>
    
    <hr>
    <h3>인벤토리 상태 (자동 생성됨)</h3>
    <p>현재 아이템 보유 수: <%= character.getInventory().size() %> / 30 칸</p>

<% } else { %>

    <h2>플레이어 인증 실패</h2>
    <p>존재하지 않는 플레이어 ID입니다.</p>

<% } %>

</body>
</html>
