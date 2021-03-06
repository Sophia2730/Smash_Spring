<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/table.css">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">

<script src="<c:url value="/resources/js/jquery-3.2.1.min.js" /> "></script>
<script src="<c:url value="/resources/js/bootstrap.js" /> "></script>
<script src="<c:url value="/resources/js/bootstrap.bundle.js" /> "></script>
<title>SMASH CARE MOVEMENT</title>
<script>
	function connection_start(deviceNumber) {
		var pno = prompt("환자 번호를 입력하세요.");
		if (pno != null) {
			$.ajax({
				type : 'post',
				url : './ConnectionStart',
				data : {
					'deviceNumber' : deviceNumber,
					'patientNumber' : pno
				},
				success : function(data) {
					alert("환자와의 기기 연결이 성공하였습니다.")
					location.reload();
				},
				error : function(xhr, status, error) {
					alert("환자번호를 다시 확인해주세요.");
				}
			});
		}
	}
</script>
<script>
	function closeForm() {
		alert("기기 연결이 정지되었습니다.");
	}
	jQuery(document).ready(
			function() {
				/* 개통/정지 설정 */
				$('.openForm').submit(function(e) {
					e.preventDefault();
					var index = $('.openForm').index(this);
					connection_start($($('.deviceNumber')[index]).val());
				});
				/* 검색창 포커스인 포커스 아웃 효과 */
				$('input').focusin(
						function() {
							$('.search').css('border-color', '#00afec');
							$('.search').css('box-shadow',
									'0 0 15px rgba(0, 175, 236, 0.5)');

							$('input').focusout(function() {
								$('.search').css('border-color', '#e0e0e0');
								$('.search').css('box-shadow', 'none');
							});
						});

				/* 검색 기능 */
				var search = function() {
					var id = $('input').val();
					$('tbody tr').hide();
					var item = $("tbody > tr > td:nth-child(4n+1):contains('"
							+ id + "')");

					$(item).parent().show();
				};
				/* 버튼 눌렀을때 검색 */
				$('#search_btn').click(function() {
					search();
				});
				/* 엔터 눌렀을때 검색 */
				$('input').keydown(function(key) {
					if (key.keyCode == 13) {
						search();
					}
				});
			});
</script>
</head>
<body>
	<div class="wrap" style="width: 100%;">

		<%@include file="medic_nav.jsp"%>

		<!-- Table -->
		<div class="content mx-auto">
			<div class="container my-auto">
				<!-- Table Head -->
				<div class="row content_head">
					<!-- 제목 -->
					<div class="col-lg-3 content_title">
						<p>기기 개통</p>
					</div>
					<!-- 검색 -->
					<div class="col-lg-7">
						<div class="search">
							<input type="text" placeholder="기기 아이디를 입력하세요."> <input
								type="submit" class="my-auto mx-auto search_btn" id="search_btn"
								value="">
						</div>
					</div>
				</div>
			</div>

			<!-- Table Body -->
			<table class="table device_manage">
				<thead>
					<tr>
						<th>식별 기기 아이디</th>
						<th>연결 환자</th>
						<th>기기 상태</th>
						<th>개통 / 정지</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="dto">
						<tr>
							<td style="color: rgb(127, 190, 38);"><img
										src="${pageContext.request.contextPath}/resources/img/man_icon.png"
										width="30px" height="30px">${dto.deviceNumber }</td>
							<td>${dto.patientNumber }</td>
							<c:choose>
								<c:when test="${dto.activated == 1}">
									<td><img
										src="${pageContext.request.contextPath}/resources/img/net_icon.png"
										width="30px"> 개통됨</td>
									<td>
										<form>
											<input type='button' class="btn_disable" value="개통하기" />
										</form>
										<form method="post" action="ConnectionStop">
											<input type="hidden" value="${dto.deviceNumber }"
												name="deviceNumber"> <input type="submit"
												class="btn_enable" value="정지하기"
												onClick="javascript:closeForm()">
										</form>
									</td>
								</c:when>
								<c:otherwise>
									<td>비활성화</td>
									<td>
										<form class="openForm">
											<input class="deviceNumber" type="hidden"
												value="${dto.deviceNumber }" name="deviceNumber"> <input
												type="submit" class="btn_enable" value="개통하기" />
										</form>
										<form>
											<input type="button" class="btn_disable" value="정지하기">
										</form>
									</td>
								</c:otherwise>
							</c:choose>
							<td></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

	</div>
</body>
</html>