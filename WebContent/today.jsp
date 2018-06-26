<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%--데이터 베이스에 필요한 부분 추가 import --%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 자바 소스를 사용 할 수 있어요.
	System.out.println("JSP(자바 소스부분)");

	// 한글을 위해 설정(set)
	request.setCharacterEncoding("utf-8");

	// main.jsp 에서 보내는 데이터를 받기 위해
	// 	String menu = request.getParameter("menu");
	String[] menu = request.getParameterValues("menu");
	// 확인용
	System.out.println("배열의 길이: " + menu.length);
	// 넘어오는 데이터들이 가변 적이기 때문에
	// for 문을 써야 되겠네...
	// 	for(int i=0; ...)
	for (String m : menu) {
		System.out.println(m);
	}

	// 넘어오는 데이터들을 배열(배열로 넘어오는데??)
	// 로 하든 ArrayList에 담든
	// 어떻게든 해서 랜덤으로 오늘의 메뉴를 출력 해보기

	// 배열에(이미 담겨 있음) ArrayList 값 옮겨 담기
	ArrayList<String> menuList = new ArrayList<>();
	for (String m : menu) {
		menuList.add(m);
	}

	// Rnadom 을 사용 할 수 있게 선언 하고 
	Random rnd = new Random();
	// 랜덤 갯수 설정해서 하나의 번호를 뽑기
	int rndNum = rnd.nextInt(menuList.size());
	// 그 번호를 index(rndNum)로 하여 안에 있는 문자열을 출력

	// 확인용(나중에 지워야 될)
	System.out.println("랜덤으로 나온 숫자: " + rndNum);
	// 리스트에 담겨 있는 데이터 중에 하나(rndNum값에 따라)를 출력
	// 	out.println(menuList.get(rndNum));
	// 리스트에 담겨 있는 데이터 중에 하나(rndNum값에 따라)를 변수에 담음
	String selMenu = menuList.get(rndNum);

	//데이터 베이스 연동부분
	Connection conn = null;
	try {//user pw url 전부 본인에 맞게 수정해야함
		String user = "java";
		String pw = "java";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";

		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pw);

		System.out.println("Database에 연결되었습니다.\n");

	} catch (ClassNotFoundException cnfe) {
		System.out.println("DB 드라이버 로딩 실패 :" + cnfe.toString());
	} catch (SQLException sqle) {
		System.out.println("DB 접속실패 : " + sqle.toString());
	} catch (Exception e) {
		System.out.println("Unkonwn error");
		e.printStackTrace();
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오늘의 메뉴</title>
</head>
<body>
	<h1>오늘의 메뉴</h1>
	<h3>
		오늘의 메뉴는
		<%=selMenu%></h3>
</body>
</html>