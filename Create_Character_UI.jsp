<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.GameCharacter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Character UI</title>
<style>
    body { background-color: #0b0c10; color: #ffffff; font-family: 'Malgun Gothic', sans-serif; padding: 20px; }
    .container { border: 2px solid #ff4a5a; border-radius: 10px; padding: 30px; width: 450px; background-color: #12141c; }
    .title { color: #f5b041; font-size: 20px; font-weight: bold; text-align: center; margin-bottom: 20px; }
    .success-msg { color: #2ecc71; font-weight: bold; margin-bottom: 15px; }
    .info-label { color: #a6acaf; margin-top: 15px; font-size: 14px; }
    .info-value { font-size: 16px; margin-bottom: 8px; padding-left: 10px; }
    .footer-msg { color: #2ecc71; text-align: center; font-weight: bold; margin-top: 25px; font-size: 15px; }
    hr { border: 0; height: 1px; background: #566573; margin: 15px 0; }
</style>
</head>
<body>

<%
    String playerId = request.getParameter("playerId") != null ? request.getParameter("playerId") : "hero";
    String charName = request.getParameter("charName") != null ? request.getParameter("charName") : "용사_홍길동";
    String job = request.getParameter("job") != null ? request.getParameter("job") : "전사";
    int level = request.getParameter("level") != null ? Integer.parseInt(request.getParameter("level")) : 10;

    GameCharacter character = new GameCharacter(playerId, charName, job, level);
    session.setAttribute("character", character);
%>

<div class="container">
    <div class="title">[ 캐릭터 생성 결과 ]</div>
    <hr>
    
    <% if("hero".equals(character.getPlayerId())) { %>
        <div class="success-msg">플레이어 인증 성공: <%= character.getPlayerId() %></div>
        <hr>
        
        <div class="info-label">캐릭터 정보</div>
        <div class="info-value">캐릭터명: <%= character.getCharName() %></div>
        <div class="info-value">직업: <%= character.getJob() %></div>
        <div class="info-value">레벨: Lv.<%= character.getLevel() %></div>
        <div class="info-value">HP: <%= character.getHp() %></div>
        <div class="info-value">공격력: <%= character.getAttackPower() %></div>
        <hr>
        
        <div class="footer-msg">캐릭터 생성이 완료되었습니다.</div>
    <% } else { %>
        <div style="color: #e74c3c; font-weight: bold;">플레이어 인증 실패</div>
    <% } %>
</div>

</body>
</html>
