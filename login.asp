﻿<%@ CODEPAGE=65001 %>
<%
'///////////////////////////////////////////////////////////////////////////////
'//              Z-Blog
'// 作    者:    朱煊(zx.asd)
'// 版权所有:    RainbowSoft Studio
'// 技术支持:    rainbowsoft@163.com
'// 程序名称:    
'// 程序版本:    
'// 单元名称:    login.asp
'// 开始时间:    2004.07.27
'// 最后修改:    
'// 备    注:    登陆页
'///////////////////////////////////////////////////////////////////////////////
%>
<% Option Explicit %>
<% On Error Resume Next %>
<% Response.Charset="UTF-8" %>
<% Response.Buffer=True %>
<!-- #include file="c_option.asp" -->
<!-- #include file="function/c_function.asp" -->
<%
Call CheckReference("")
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<%=ZC_BLOG_LANGUAGE%>" lang="<%=ZC_BLOG_LANGUAGE%>">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Language" content="<%=ZC_BLOG_LANGUAGE%>" />
	<link rel="stylesheet" rev="stylesheet" href="CSS/admin.css" type="text/css" media="screen" />
	<script language="JavaScript" src="SCRIPT/common.js" type="text/javascript"></script>
	<script language="JavaScript" src="SCRIPT/md5.js" type="text/javascript"></script>
	<title><%=ZC_BLOG_TITLE & ZC_MSG044 & ZC_MSG009%></title>
</head>
<body class="login">
<form id="frmLogin" method="post">
<h3><%=ZC_MSG009%></h3>
<table border="0" width="100%" cellspacing="5" cellpadding="5">
	<tr>
		<td align="right" width="25%"><%=ZC_MSG001%>: </td>
		<td><input type="text" id="edtUserName" name="edtUserName" size="20" /></td>
	</tr>
	<tr>
		<td align="right"><%=ZC_MSG002%>: </td>
		<td><input type="password" id="edtPassWord" name="edtPassWord" size="20" /></td>
	</tr>
	<tr>
		<td align="right"><%=ZC_MSG004%>: </td>
		<td><select size="1" value="0" id="cmbSave" onchange="edtSaveDate.value=this.options[this.selectedIndex].value"><option selected="selected" value=""><%=ZC_MSG005%></option><option value="1"><%=ZC_MSG006%></option><option value="30"><%=ZC_MSG007%></option></select><input type="hidden" id="edtSaveDate" name="edtSaveDate" value="" /></td>
	</tr>
	<tr>
		<td align="right"><%=ZC_MSG089%>: </td>
		<td><input type="text" id="edtCheckOut" name="edtCheckOut" size="10" /> <img style="border:1px solid black" src="function/c_validcode.asp?name=loginvalid" height="<%=ZC_VERIFYCODE_HEIGHT%>" width="<%=ZC_VERIFYCODE_WIDTH%>" alt="" title=""/></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input class="button" type="submit" value="<%=ZC_MSG260%>" id="btnPost"></td>
	</tr>
</table>

</form>

<script language="JavaScript" type="text/javascript">

function SetCookie(sName, sValue,iExpireDays) {
	if (iExpireDays){
		var dExpire = new Date();
		dExpire.setTime(dExpire.getTime()+parseInt(iExpireDays*24*60*60*1000));
		document.cookie = sName + "=" + escape(sValue) + "; expires=" + dExpire.toGMTString();
	}
	else{
		document.cookie = sName + "=" + escape(sValue)+ "; path=/";
	}
}


if(GetCookie("username")){document.getElementById("edtUserName").value=unescape(GetCookie("username"))};
//alert('password_plain:'+GetCookie("password_plain"));
if(GetCookie("password_plain")){document.getElementById("edtPassWord").value=unescape(GetCookie("password_plain"))};
document.getElementById("btnPost").onclick = function () {

    var strUserName = document.getElementById("edtUserName").value;
    var strPassWord = document.getElementById("edtPassWord").value;
    var strSaveDate = document.getElementById("edtSaveDate").value



    if ((strUserName == "") || (strPassWord == "")) {
        alert("<%=ZC_MSG010%>");
        return false;
    }
	
	SetCookie("password_plain", strPassWord, strSaveDate);
    strUserName = escape(strUserName);

    strPassWord = MD5(strPassWord);
    

    SetCookie("username", strUserName, strSaveDate);
    SetCookie("password", strPassWord, strSaveDate);	
    document.getElementById("frmLogin").action = "cmd.asp?act=verify"

}


$(document).ready(function(){ 
	if(document.getElementById("edtCheckOut")){
		var objImageValid=$("img[@src='function/c_validcode.asp?name=loginvalid']");
		objImageValid.css("cursor","pointer");
		objImageValid.click( function() {
				objImageValid.attr("src","function/c_validcode.asp?name=loginvalid"+"&random="+Math.random());
		} );
	}
});

</script>
</body>
</html>
<%
If Err.Number<>0 then
	Call ShowError(0)
End If
%>