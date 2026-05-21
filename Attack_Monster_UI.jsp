<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.GameCharacter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Attack Monster UI</title>
<style>
    body { background-color: #0b0c10; color: #ffffff; font-family: 'Malgun Gothic', sans-serif; padding: 20px; }
    .container { border: 2px solid #ff4a5a; border-radius: 10px; padding: 30px; width: 450px; background-color: #12141c; }
    .title { color: #f5b041; font-size: 20px; font-weight: bold; text-align: center; margin-bottom: 20px; }
    .success-msg { color: #2ecc71; font-weight: bold; margin-bottom: 15px; }
    .info-label { color: #a6acaf; margin-top: 15px; font-size: 14px; }
    .info-value { font-size: 16px; margin-bottom: 8px; padding-left: 10px; }
    .skill-zone { color: #f39c12; font-weight: bold; font-size: 18px; margin: 10px 0; padding-left: 10px;}
    .damage-zone { color: #e74c3c; font-weight: bold; font-size: 16px; padding-left: 10px; }
    .grade-box { font-size: 18px; font-weight: bold; color: #f1c40f; margin: 15px 0; }
    .crit-msg { color: #2ecc71; font-size: 13px; font-weight: bold; padding-left: 10px; }
    .footer-msg { color: #3498db; font-weight: bold; margin-top: 20px; font-size: 14px; }
    hr { border: 0; height: 1px; background: #566573; margin: 15px 0; }
</style>
</head>
<body>

<%
    GameCharacter character = (GameCharacter) session.getAttribute("character");

    if (character == null) {
        character = new GameCharacter("hero", "용사_홍길동", "전사", 10);
    }

    int damage = character.calculateDamage();
    String grade = character.getGrade(damage);
%>

<div class="container">
    <div class="title">[ 몬스터 공격 결과 ]</div>
    <hr>
    
    <div class="success-msg">플레이어 인증 성공: <%= character.getPlayerId() %></div>
    <hr>
    
    <div class="info-label">전투 정보</div>
    <div class="info-value">캐릭터: <%= character.getCharName() %> (<%= character.getJob() %> Lv.<%= character.getLevel() %>)</div>
    <div class="info-value">공격력: <%= character.getAttackPower() %></div>
    <hr>
    
    <div class="info-label">스킬 발동</div>
    <div class="skill-zone"><%= character.getSkillName() %></div>
    <div class="damage-zone">데미지: <%= damage %></div>
    <hr>
    
    <div class="grade-box">평가: <%= grade %></div>
    <% if(damage >= 200) { %>
        <div class="crit-msg">AMAZING!! 크리티컬 히트!!!</div>
    <% } %>
    <hr>
    
    <div class="footer-msg">몬스터에게 큰 타격을 입혔습니다.</div>
</div>

</body>
</html>
