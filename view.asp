﻿<%@ CODEPAGE=65001 %>
<%
'///////////////////////////////////////////////////////////////////////////////
'//              Z-Blog
'// 作    者:    朱煊(zx.asd)
'// 版权所有:    RainbowSoft Studio
'// 技术支持:    rainbowsoft@163.com
'// 程序名称:    
'// 程序版本:    
'// 单元名称:    view.asp
'// 开始时间:    2004.07.30
'// 最后修改:    
'// 备    注:    查看页
'///////////////////////////////////////////////////////////////////////////////
%>
<% Option Explicit %>
<% On Error Resume Next %>
<% Response.Charset="UTF-8" %>
<% Response.Buffer=True %>
<!-- #include file="c_option.asp" -->
<!-- #include file="function/c_function.asp" -->
<!-- #include file="function/c_function_md5.asp" -->
<!-- #include file="function/c_system_lib.asp" -->
<!-- #include file="function/c_system_base.asp" -->
<!-- #include file="function/c_system_plugin.asp" -->
<!-- #include file="plugin/p_config.asp" -->
<%

Call System_Initialize()

'plugin node
For Each sAction_Plugin_View_Begin in Action_Plugin_View_Begin
	If Not IsEmpty(sAction_Plugin_View_Begin) Then Call Execute(sAction_Plugin_View_Begin)
Next


Dim Article
Set Article=New TArticle

If Article.LoadInfoByID(Request.QueryString("id")) Then

	If Article.Level=1 Then Call ShowError(9)
	If Article.Level=2 Then
		If Not CheckRights("Root") Then
			If (Article.AuthorID<>BlogUser.ID) Then Call ShowError(6)
		End If
	End If

	Article.template="SINGLE"
	If Article.Export(ZC_DISPLAY_MODE_ALL)= True Then
		Article.Build
		Response.Write Article.html
	End If

End If

'plugin node
For Each sAction_Plugin_View_End in Action_Plugin_View_End
	If Not IsEmpty(sAction_Plugin_View_End) Then Call Execute(sAction_Plugin_View_End)
Next

Call System_Terminate()

%>
<!-- <%=RunTime()%>ms --><%
If Err.Number<>0 then
	Call ShowError(0)
End If
%>

<!--
<script language="JavaScript" type="text/javascript">
		
		

alert(GetCookie('avenetest'));
		
document.getElementById("inpHomePage").value = GetCookie('avenetest');

</script> 
-->
