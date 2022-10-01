<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
<!-- ============================================================================================== -->

<style type="text/css">

.img-gallery{
	width: 80%;
	margin: 100px auto 50px;
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	grid-gap: 30px;
}

.img-gallery img{
	width: 400px;
	cursor: pointer;
}

.img-gallery img:hover{
	transform: scale(0.8) rotate(-15deg);
	border-radius: 20px;
	box-shadow: 0 32px 75px rgba(68, 77, 136, 0.2);
}

.full-img{
	width: 100%;
	height: 100vh;
	background: rgba(0, 0, 0 ,0.9);
	position: fixed;
	top: 0;
	left: 0;
	display: none;
	align-items: center;
	justify-content: center;
	z-index: 100;
}

.full-img img{
	width: 90%;
	max-width: 500px;
}

.full-img span{
	position: absolute;
	top: 10%;
	right: 10%;
	font-size: 30px;
	color: #fff;
	cursor: pointer;
}

hr{
	height: 1px;
    background-color: black;
    border: none;
}
}

</style>

<!-- =================================================================================== -->

<style type="text/css">

* {
  font-family: Lato;
  --transition: 0.15s;
  --border-radius: 0.5rem;
  --background: #ffc107;
  --box-shadow: #ffc107;
  // --box-shadow: #0082ff;
}

.cont-bg {
  min-height: 100vh;
  background-image: radial-gradient(
    circle farthest-corner at 7.2% 13.6%,
    rgba(37, 249, 245, 1) 0%,
    rgba(8, 70, 218, 1) 90%
  );
  padding: 1rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.cont-main {
  display: flex;
  flex-wrap: wrap;
  align-content: center;
  justify-content: center;
}

.cont-checkbox {
  width: 150px;
  height: 100px;
  border-radius: var(--border-radius);
  box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
  transition: transform var(--transition);
  background: white;
  margin-bottom: 0.75rem;
  margin-right: 0.75rem;
  &:active {
    transform: scale(0.9);
  }
  input {
    display: none;
    &:checked + label {
      opacity: 1;
      box-shadow: 0 0 0 3px var(--background);
      .cover-checkbox {
        opacity: 1;
        transform: scale(1);
        svg {
          stroke-dashoffset: 0;
        }
      }
      img {
        -webkit-filter: none; /* Safari 6.0 - 9.0 */
        filter: none;
      }
    }
  }
  label {
    cursor: pointer;
    border-radius: var(--border-radius);
    overflow: hidden;
    width: 100%;
    height: 100%;
    position: relative;
    opacity: 0.6;
    img {
      width: 100%;
      height: 70%;
      object-fit: cover;
      clip-path: polygon(0% 0%, 100% 0, 100% 81%, 50% 100%, 0 81%);
      -webkit-filter: grayscale(100%); /* Safari 6.0 - 9.0 */
      filter: grayscale(100%);
    }
    .cover-checkbox {
      position: absolute;
      right: 5px;
      top: 3px;
      z-index: 1;
      width: 23px;
      height: 23px;
      border-radius: 50%;
      background: var(--box-shadow);
      border: 2px solid #fff;
      transition: transform var(--transition),
        opacity calc(var(--transition) * 1.2) linear;
      opacity: 0;
      transform: scale(0);
      svg {
        width: 13px;
        height: 11px;
        display: inline-block;
        vertical-align: top;
        fill: none;
        margin: 5px 0 0 3px;
        stroke: #fff;
        stroke-width: 2;
        stroke-linecap: round;
        stroke-linejoin: round;
        stroke-dasharray: 16px;
        transition: stroke-dashoffset 0.4s ease var(--transition);
        stroke-dashoffset: 16px;
      }
    }
    .info {
      text-align: center;
      margin-top: 0.2rem;
      font-weight: 600;
      font-size: 0.8rem;
    }
  }
}

</style>


<!-- ==================================================================================== -->

</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>	

	<center>
	<h3>Modify Page</h3>
	</center>
	
		<c:forEach items="${ requestScope.list }" var="g">
			<div class="img-gallery" >
			<c:if test="${ g.mb_imgname != null }">
			<input type="checkbox" id="myCheckbox1" value= "${g.mb_imgname}" class=img-gallery1/>
			<label for="myCheckbox1"><img src="resources/gallery/faceImages/${g.mb_imgname}" onclick="openFullImg(this.src)" ></label>
			
			</c:if>
			
			</div>
		</c:forEach>


<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>