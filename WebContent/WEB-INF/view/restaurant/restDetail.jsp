<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div>
	<div id="sectionContainerCenter">
		<div>
			<c:if test="${loginUser.i_user == data.i_user}">
				<div class="recMenuItem">
					<button onclick="isDel()">삭제</button>
					<form id="recFrm" action="/restaurant/addRecMenusProc" enctype="multipart/form-data" method="post">
					<!-- 파일넣을때 enctype가 필요 -->
						<div><button type="button" onclick="addRecMenu()">메뉴 추가</button></div>
						<input type="hidden" name="i_rest" value="${data.i_rest}">
						<div id="recItem">
						</div>
						<div><input type="submit" value="등록"></div>
					</form>
				</div>
			</c:if>
			<div class="recMenuContainer">
				<c:forEach items="${recommendMenuList}" var="item">
					<div class="recMenuItem" id="recMenuItem_${item.seq}">
						<div class="pic">
							<c:if test="${item.menu_pic != null && item.menu_pic != ''}">
								<img alt="" src="/res/img/restaurant/${data.i_rest}/${item.menu_pic}">
							</c:if>
						</div>
						<div class="info">
							<div class="nm">${item.menu_nm}</div>
							<div class="price"><fmt:formatNumber type="number" value="${item.menu_price}"/></div>
						</div>
						<c:if test="${loginUser.i_user == data.i_user}">
						<div class="delIconContainer" onclick="delRecMenu(${data.i_rest}, ${item.seq})">
							<span class="material-icons">clear</span>
						</div>
						</c:if>
					</div>
				</c:forEach>
			</div>
			<div class="restaurant-detail">
				<div id="detail-header">
					<div class="restaurant_title_wrap">
						<span class="title">
							<h1 class="restaurant_name">${data.nm}</h1>
						</span>
					</div>
					<div class="status branch_none">
						<span class="cnt hit">${data.cntHits}</span>
						<span class="cnt favorite">${data.cntFavorite}</span>
					</div>
				</div>
				<div>
					<table>
						<caption>레스토랑 상세 정보</caption>
						<tbody>
							<tr>
								<th>주소</th>
								<td>${data.addr}</td>
							</tr>
							<tr>
								<th>카테고리</th>
								<td>${data.cd_category_nm}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="http://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
	function delRecMenu(i_rest, seq) {
		console.log('i_rest : ' + i_rest)
		console.log('seq : ' + seq)
		
		axios.get('/restaurant/ajaxDelRecMenu', {
			params: {
				i_rest, seq
			}
		}).then(function(res) {
			if(res.data == 1) {
				//엘리먼트 삭제
				var ele = document.querySelector('#recMenuItem_' + seq)
				ele.remove()
			}
		})
	}
	var idx = 0;
	function addRecMenu() {
		var div = document.createElement('div')
			
		var inputNm = document.createElement('input')
		inputNm.setAttribute("type", "text")
		inputNm.setAttribute('name', 'menu_nm')			
		var inputPrice = document.createElement('input')
		inputPrice.setAttribute("type", "number")
		inputPrice.setAttribute('name', 'menu_price')
		var inputPic = document.createElement('input')
		inputPic.setAttribute("type", "file")
		inputPic.setAttribute('name', 'menu_pic_'+idx++)
			
		div.append(' menu : ')
		div.append(inputNm)
		div.append(' price : ')
		div.append(inputPrice)
		div.append(' photo : ')
		div.append(inputPic)
			
		recItem.append(div)
	}
	addRecMenu()
		
	function isDel() {
		if(confirm('삭제 하시겠습니까?')) {
			location.href= '/restaurant/restDel?i_rest=${data.i_rest}'
		}
	}
</script>

