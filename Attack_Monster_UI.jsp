<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="mall.*" %>
<%@ page import="java.util.List" %>

<%
    request.setCharacterEncoding("UTF-8");

    캐릭터 character = (캐릭터)session.getAttribute("character");

    if(character == null) {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>몬스터 공격 결과</title>
</head>
<body>
    <h2>캐릭터 정보 없음</h2>
    <p>먼저 캐릭터를 생성해주세요.</p>
</body>
</html>
<%
        return;
    }

    전투 battle = new 전투();

    boolean 검증결과 = battle.플레이어검증(character.get플레이어ID());

    if(!검증결과) {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>몬스터 공격 결과</title>
</head>
<body>
    <h2>플레이어 인증 실패</h2>
    <p>유효하지 않은 플레이어 정보입니다.</p>
</body>
</html>
<%
        return;
    }

    int 데미지 = battle.데미지계산(character);
    String 스킬명 = battle.스킬발동(character);
    String 등급 = battle.등급부여(데미지);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>몬스터 공격 결과</title>
</head>
<body>

<h2>몬스터 공격 결과</h2>

<p>플레이어ID : <%= character.get플레이어ID() %></p>
<p>캐릭터명 : <%= character.get캐릭터명() %></p>
<p>레벨 : <%= character.get레벨() %></p>
<p>공격력 : <%= character.get공격력() %></p>
<p>소속 길드 : <%= character.get길드명() != null ? character.get길드명() : "무소속" %></p>

<hr>

<p>스킬 : <%= 스킬명 %></p>
<p>최종 데미지 : <%= 데미지 %></p>
<p>등급 : <%= 등급 %></p>

<hr>

<h3>인벤토리 정보 (<%= character.get인벤토리().size() %> / 30)</h3>
<ul>
    <% 
        List<아이템> 아이템목록 = character.get인벤토리();
        if(아이템목록 != null) {
            for(아이템 item : 아이템목록) { 
    %>
        <li><%= item.get아이템명() %> (<%= item.get아이템종류() %>) - 가치: <%= item.get아이템가치() %> [<%= item.get등급() %>]</li>
    <% 
            }
        } 
    %>
</ul>

</body>
</html>
