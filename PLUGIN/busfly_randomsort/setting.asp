﻿<%@ CODEPAGE=65001 %>
<%
'///////////////////////////////////////////////////////////////////////////////
'// 插件应用:    Z-Blog 1.8
'// 插件制作:    
'// 备    注:    
'// 最后修改：   
'// 最后版本:    
'///////////////////////////////////////////////////////////////////////////////
%>
<% Option Explicit %>
<% 'On Error Resume Next %>
<% Response.Charset="UTF-8" %>
<% Response.Buffer=True %>
<!-- #include file="../../c_option.asp" -->
<!-- #include file="../../function/c_function.asp" -->
<!-- #include file="../../function/c_function_md5.asp" -->
<!-- #include file="../../function/c_system_lib.asp" -->
<!-- #include file="../../function/c_system_base.asp" -->
<!-- #include file="../../function/c_system_event.asp" -->
<!-- #include file="../../function/c_system_plugin.asp" -->
<%

Call System_Initialize()

'检查非法链接
Call CheckReference("")

'检查权限
If BlogUser.Level>1 Then Call ShowError(6) 

If CheckPluginState("busfly_randomsort")=False Then Call ShowError(48)

BlogTitle="文章排行插件 for z-blog 1.8 后台设置"
	Dim tmpSng
	tmpSng=LoadFromFile(BlogPath & "/PLUGIN/busfly_randomsort/include.asp","utf-8")
	
	Dim intCutLen '每条记录的标题字数
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_INTCUTLEN",intCutLen)
	
    Dim busfly_randomsort_NUM_CategoryComments		'分类最新回复 - 设置显示多少条记录	
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_CategoryComments",busfly_randomsort_NUM_CategoryComments)
    Dim busfly_randomsort_NUM_CategoryTophot		'分类热门文章 - 设置显示多少条记录
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_CategoryTophot",busfly_randomsort_NUM_CategoryTophot)



    Dim num_strnew 		'最新文章 -设置显示多少条记录
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_STRNEW",num_strnew)
	
    Dim num_strtemp 		'随机文章 -设置显示多少条记录
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_STRTEMP",num_strtemp)
	
    Dim num_busfly_strtemp 	'完全随机文章 -设置显示多少条记录
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_BUSFLY_STRTEMP",num_busfly_strtemp)
	
    Dim num_strcommonth 	'本月评论排行 -设置显示多少条记录
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_STRCOMMONTH",num_strcommonth)
	
    Dim num_strcomyear 	'本年评论排行 -设置显示多少条记录
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_STRCOMYEAR",num_strcomyear)
	
    Dim num_strtopmonth 	'本月排行 -设置显示多少条记录
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_STRTOPMONTH",num_strtopmonth)
	
    Dim num_strtopyear 	'本年排行 -设置显示多少条记录
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_STRTOPYEAR",num_strtopyear)
	
    Dim num_busfly_tophot '热文排行 -设置显示多少条记录
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_BUSFLY_TOPHOT",num_busfly_tophot)

    Dim busfly_randomsort_NUM_Category
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_Category",busfly_randomsort_NUM_Category)
	'分类文章 - 设置显示多少条记录
    Dim busfly_randomsort_NUM_Tags
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_Tags",busfly_randomsort_NUM_Tags)
	'Tag的记录条数
    Dim busfly_randomsort_NUM_Archives
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_Archives",busfly_randomsort_NUM_Archives)
	'归档条数
    Dim busfly_randomsort_NUM_Comments
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_Comments",busfly_randomsort_NUM_Comments)
	'评论及回复条数
    Dim busfly_randomsort_NUM_GuestComments
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_GuestComments",busfly_randomsort_NUM_GuestComments)
	'留言条数
    Dim busfly_randomsort_NUM_TrackBacks
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_TrackBacks",busfly_randomsort_NUM_TrackBacks)
	'引用条数
    Dim busfly_randomsort_NUM_Catalogs
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_Catalogs",busfly_randomsort_NUM_Catalogs)
	'分目录类条数
    Dim busfly_randomsort_NUM_Authors
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_NUM_Authors",busfly_randomsort_NUM_Authors)
	'用户条数


Dim busfly_randomsort_isBuildCategoryComments
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildCategoryComments",busfly_randomsort_isBuildCategoryComments)
         <!--分类最新回复--> 300	是否使用
Dim busfly_randomsort_isBuildCategoryTophot
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildCategoryTophot",busfly_randomsort_isBuildCategoryTophot)
         '<!--分类热门文章--> 320	是否使用


Dim busfly_randomsort_isBuildnew
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildnew",busfly_randomsort_isBuildnew)
	'<!--最新文章-->是否使用
Dim busfly_randomsort_isBuildrand
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildrand",busfly_randomsort_isBuildrand)
	'<!--随机文章-->是否使用
Dim busfly_randomsort_isBuildallrand
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildallrand",busfly_randomsort_isBuildallrand)
	'<!--完全随机文章-->是否使用
Dim busfly_randomsort_isBuildcommonth
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildcommonth",busfly_randomsort_isBuildcommonth)
	'<!--本月评论排行-->	是否使用
Dim busfly_randomsort_isBuildcomyear
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildcomyear",busfly_randomsort_isBuildcomyear)
	'<!--本年评论排行-->是否使用
Dim busfly_randomsort_isBuildtopmonth
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildtopmonth",busfly_randomsort_isBuildtopmonth)
	'<!--本月排行-->是否使用
Dim busfly_randomsort_isBuildtopyear
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildtopyear",busfly_randomsort_isBuildtopyear)
	'<!--本年排行-->是否使用
Dim busfly_randomsort_isBuildtophot
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildtophot",busfly_randomsort_isBuildtophot)
	'<!--热文排行-->	是否使用
Dim busfly_randomsort_isBuildCategory
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildCategory",busfly_randomsort_isBuildCategory)
	'<!--分类文章-->	是否使用
Dim busfly_randomsort_isBuildTags
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isBuildTags",busfly_randomsort_isBuildTags)
	'是否启用生成TAGS
Dim busfly_randomsort_isStatistics
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isStatistics",busfly_randomsort_isStatistics)
	'是否启用网站统计
Dim busfly_randomsort_isArchives
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isArchives",busfly_randomsort_isArchives)
	'是否启用归档
Dim busfly_randomsort_isComments
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isComments",busfly_randomsort_isComments)
	'是否启用评论回复
Dim busfly_randomsort_isGuestComments
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isGuestComments",busfly_randomsort_isGuestComments)
	'是否启用留言
Dim busfly_randomsort_isTrackBacks
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isTrackBacks",busfly_randomsort_isTrackBacks)
	'是否启用引用列表
Dim busfly_randomsort_isCatalogs
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isCatalogs",busfly_randomsort_isCatalogs)
	'是否启用分类目录
Dim busfly_randomsort_isAuthors
	Call LoadValueForSetting(tmpSng,True,"Numeric","busfly_randomsort_isAuthors",busfly_randomsort_isAuthors)
	'是否启用用户列表
Dim busfly_randomsort_chReplace
	Call LoadValueForSetting(tmpSng,True,"String","busfly_randomsort_chReplace",busfly_randomsort_chReplace)
	'设置单引号和双引号的替换字符

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<%=ZC_BLOG_LANGUAGE%>" lang="<%=ZC_BLOG_LANGUAGE%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="<%=ZC_BLOG_LANGUAGE%>" />
<link rel="stylesheet" rev="stylesheet" href="../../CSS/admin.css" type="text/css" media="screen" />
<script language="JavaScript" src="../../script/common.js" type="text/javascript"></script>
<title><%=BlogTitle%></title>
<script language="javascript">
function showhidediv(id){
  try{
    var sbtitle=document.getElementById(id);
    if(sbtitle){
      if(sbtitle.style.display=='none'){
        sbtitle.style.display='block';
      }else{
        sbtitle.style.display='none';
      }
    }
	resizes();
  }catch(e){}
}
</script>
<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000;
	font-weight: bold;
}
.STYLE2 {color: #009900}
.STYLE3 {
	color: #000000;
	font-weight: bold;
}
.STYLE4 {color: #FF0000}
-->
</style>
</head>
<body>
<div id="divMain">
  <div class="Header"><%=BlogTitle%></div>
  <div >
    <%Call GetBlogHint()%>
  </div>
</div>
<div id="divMain2">
  <form id="edit" name="edit" method="post">
    <p><b>关于[列表插件 for Z-BLOG 1.8] </b></p>
    <p>列表插件 for Z-BLOG 1.8是一个对ZBLOG现有的文章列表的扩充插件,提供了包括(文章排行,随机文章)等多种文章列表,,此插件提供了17种列表,极大的扩充了文章列表以及侧边栏的种类,让你的博客更好的展示文章.甚至可以借助此插件将你的博客改装成小型CMS</p>
    <p><b>规则设置：</b>&nbsp;及17种列表的代码</p>
    <table width="90%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="144">名称</td>
        <td width="80">启用/数量</td>
        <td>获取调用代码</td>
      </tr>
      <tr>
        <td>1.最新文章:</td>
        <td><input name="busfly_randomsort_isBuildnew" type="checkbox" value="1" <%if busfly_randomsort_isBuildnew=1 then%>checked="checked"<%end if%>/>
          <input name="num_strnew" style="width:20px" type="text" value="<%=num_strnew%>"/>条</td>
        <td>
        
          1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
          <a href="#" onClick="showhidediv('new_jsd1');return false">新版JS代码</a>&nbsp;&nbsp;
          <div id="new_jsd1" style="display:none; background-color:#999999">   
               &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>最新文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTNEW_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           
           <a href="#" onClick="showhidediv('new_libd1');return false">新版include代码</a>&nbsp;
           <div id="new_libd1" style="display:none; background-color:#999999">  
               &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>最新文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTNEW_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           
          <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
          
          <a href="#" onClick="showhidediv('jsd1');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd1" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>最新文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=randomsortnew&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd1');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd1" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>最新文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulRandomsortnew&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulRandomsortnew=randomsortnew,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd1');return false">include代码</a>&nbsp;
           <div id="libd1" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>最新文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTNEW#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
      <tr>
        <td>2.随机文章:</td>
        <td><input name="busfly_randomsort_isBuildrand" type="checkbox" value="1" <%if busfly_randomsort_isbuildrand=1 then%>checked="checked"<%end if%>/>
          <input name="num_strtemp" style="width:20px" type="text" value="<%=num_strtemp%>"/>条</td>
        <td> 
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd2');return false">新JS代码</a>&nbsp;
           <div id="new_jsd2" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>随机文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTRAND_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd2');return false">新include代码</a>&nbsp;
           <div id="new_libd2" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>随机文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTRAND_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        
        <a href="#" onClick="showhidediv('jsd2');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd2" style="display:none; background-color:#999999"> 
               &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>随机文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=randomsortrand&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd2');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd2" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>随机文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulRandomsortrand&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulRandomsortrand=randomsortrand,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd2');return false">include代码</a>&nbsp;
           <div id="libd2" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>随机文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTRAND#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
      <tr>
        <td>3.完全随机文章:</td>
        <td><input name="busfly_randomsort_isBuildallrand" type="checkbox" value="1" <%if busfly_randomsort_isbuildallrand=1 then%>checked="checked"<%end if%> />
          <input name="num_busfly_strtemp" style="width:20px" type="text" value="<%=num_busfly_strtemp%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd3');return false">新JS代码</a>&nbsp;
           <div id="new_jsd3" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>完全随机文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTALLRAND_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd3');return false">新include代码</a>&nbsp;
           <div id="new_libd3" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>完全随机文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTALLRAND_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd3');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd3" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>完全随机文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=randomsortallrand&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd3');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd3" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>完全随机文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulRandomsortallrand&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulRandomsortallrand=randomsortallrand,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd3');return false">include代码</a>&nbsp;
           <div id="libd3" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>完全随机文章</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTALLRAND#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
      <tr>
        <td>4.本月评论排行:</td>
        <td><input name="busfly_randomsort_isBuildcommonth" type="checkbox" value="1"  <%if busfly_randomsort_isbuildcommonth=1 then%>checked="checked"<%end if%> />
          <input name="num_strcommonth" style="width:20px" type="text" value="<%=num_strcommonth%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd4');return false">新JS代码</a>&nbsp;
           <div id="new_jsd4" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本月评论排行</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTCOMMONTH_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd4');return false">新include代码</a>&nbsp;
           <div id="new_libd4" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本月评论排行</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTCOMMONTH_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd4');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd4" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本月评论排行</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=randomsortcommonth&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd4');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd4" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本月评论排行</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulRandomsortcommonth&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulRandomsortcommonth=randomsortcommonth,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd4');return false">include代码</a>&nbsp;
           <div id="libd4" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本月评论排行</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTCOMMONTH#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
      <tr>
        <td>5.本年评论排行:</td>
        <td><input name="busfly_randomsort_isBuildcomyear" type="checkbox" value="1" <%if busfly_randomsort_isbuildcomyear=1 then%>checked="checked"<%end if%> />
          <input name="num_strcomyear" style="width:20px" type="text" value="<%=num_strcomyear%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd5');return false">新JS代码</a>&nbsp;
           <div id="new_jsd5" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本年评论排行</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTCOMYEAR_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd5');return false">新include代码</a>&nbsp;
           <div id="new_libd5" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本年评论排行</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTCOMYEAR_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd5');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd5" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本年评论排行</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=randomsortcomyear&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd5');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd5" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本年评论排行</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulRandomsortcomyear&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulRandomsortcomyear=randomsortcomyear,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd5');return false">include代码</a>&nbsp;
           <div id="libd5" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本年评论排行</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTCOMYEAR#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
      <tr>
        <td>6.本月排行使用:</td>
        <td><input name="busfly_randomsort_isBuildtopmonth" type="checkbox" value="1" <%if busfly_randomsort_isbuildtopmonth=1 then%>checked="checked"<%end if%> />
          <input name="num_strtopmonth" style="width:20px" type="text" value="<%=num_strtopmonth%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd6');return false">新JS代码</a>&nbsp;
           <div id="new_jsd6" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本月排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTTOPMONTH_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd6');return false">新include代码</a>&nbsp;
           <div id="new_libd6" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本月排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTTOPMONTH_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd6');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd6" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本月排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=randomsorttopmonth&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd6');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd6" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本月排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulRandomsorttopmonth&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulRandomsorttopmonth=randomsorttopmonth,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd6');return false">include代码</a>&nbsp;
           <div id="libd6" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本月排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTTOPMONTH#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
      <tr>
        <td>7.本年排行使用:</td>
        <td><input name="busfly_randomsort_isBuildtopyear" type="checkbox" value="1" <%if busfly_randomsort_isbuildtopyear=1 then%>checked="checked"<%end if%> />
          <input name="num_strtopyear" style="width:20px" type="text" value="<%=num_strtopyear%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd7');return false">新JS代码</a>&nbsp;
           <div id="new_jsd7" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本年排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTTOPYEAR_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd7');return false">新include代码</a>&nbsp;
           <div id="new_libd7" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本年排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTTOPYEAR_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd7');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd7" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本年排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=randomsorttopyear&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd7');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd7" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本年排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulRandomsorttopyear&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulRandomsorttopyear=randomsorttopyear,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd7');return false">include代码</a>&nbsp;
           <div id="libd7" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>本年排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTTOPYEAR#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
      <tr>
        <td>8.热文排行使用:</td>
        <td><input name="busfly_randomsort_isBuildtophot" type="checkbox" value="1" <%if busfly_randomsort_isbuildtophot=1 then%>checked="checked"<%end if%> />
          <input name="num_busfly_tophot" style="width:20px" type="text" value="<%=num_busfly_tophot%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd8');return false">新JS代码</a>&nbsp;
           <div id="new_jsd8" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>热文排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTTOPHOT_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd8');return false">新include代码</a>&nbsp;
           <div id="new_libd8" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>热文排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTTOPHOT_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd8');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd8" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>热文排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=randomsorttophot&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd8');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd8" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>热文排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulRandomsorttophot&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulRandomsorttophot=randomsorttophot,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd8');return false">include代码</a>&nbsp;
           <div id="libd8" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>热文排行使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_RANDOMSORTTOPHOT#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
      <tr>
        <td>9.分类列表使用:</td>
        <td><input name="busfly_randomsort_isBuildCategory" type="checkbox" value="1" <%if busfly_randomsort_isbuildcategory=1 then%>checked="checked"<%end if%> />
            <input name="busfly_randomsort_NUM_Category" style="width:20px" type="text" value="<%=busfly_randomsort_NUM_Category%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd9');return false">新JS代码</a>&nbsp;
           <div id="new_jsd9" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_CATEGORY_{id}_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd9');return false">新include代码</a>&nbsp;
           <div id="new_libd9" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_CATEGORY_{id}_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd9');return false">JS代码</a>&nbsp;&nbsp;
            <div id="jsd9" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
              &lt;h3&gt;<u><strong>分类列表使用</strong></u>&lt;/h3&gt;<br />
              &lt;ul&gt;<br />
              <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=category_{id}&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
              &lt;/ul&gt;<br />
              &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd9');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd9" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=<strong>&quot;ulCategory_{id}&quot;</strong>&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulCategory_{id}=category_{id},&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
          <a href="#" onClick="showhidediv('libd9');return false">include代码</a>&nbsp;
            <div id="libd9" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
              &lt;h3&gt;<u><strong>分类列表使用</strong></u>&lt;/h3&gt;<br />
              &lt;ul&gt;<br />
              <u><strong>&lt;#CACHE_INCLUDE_CATEGORY_{id}#&gt;</strong></u><br />
              &lt;/ul&gt;<br />
              &lt;/div&gt;</div></td>
      </tr>
      <tr>
        <td>10.TAGS列表使用:</td>
        <td><input name="busfly_randomsort_isBuildTags" type="checkbox" value="1" <%if busfly_randomsort_isBuildTags=1 then%>checked="checked"<%end if%> />
          <input name="busfly_randomsort_NUM_Tags" style="width:20px" type="text" value="<%=busfly_randomsort_NUM_Tags%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd10');return false">新JS代码</a>&nbsp;
           <div id="new_jsd10" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>TAGS列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFTAGS_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd10');return false">新include代码</a>&nbsp;
           <div id="new_libd10" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>TAGS列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFTAGS_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd10');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd10" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>TAGS列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=bftags&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd10');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd10" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>TAGS列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulBFTags&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulBFTags=bftags,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd10');return false">include代码</a>&nbsp;
           <div id="libd10" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>TAGS列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFTAGS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
	  <tr>
        <td>11.网站统计使用:</td>
        <td><input name="busfly_randomsort_isStatistics" type="checkbox" value="1" <%if busfly_randomsort_isStatistics=1 then%>checked="checked"<%end if%> /></td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd11');return false">新JS代码</a>&nbsp;
           <div id="new_jsd11" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>网站统计使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFSTATISTICS_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd11');return false">新include代码</a>&nbsp;
           <div id="new_libd11" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>网站统计使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFSTATISTICS_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd11');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd11" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>网站统计使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=bfstatistics&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd11');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd11" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>网站统计使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulBFStatistics&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulBFStatistics=bfstatistics,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd11');return false">include代码</a>&nbsp;
           <div id="libd11" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>网站统计使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFSTATISTICS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
	  <tr>
        <td>12.归档列表使用:</td>
        <td><input name="busfly_randomsort_isArchives" type="checkbox" value="1" <%if busfly_randomsort_isArchives=1 then%>checked="checked"<%end if%> />
          <input name="busfly_randomsort_NUM_Archives" style="width:20px" type="text" value="<%=busfly_randomsort_NUM_Archives%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd12');return false">新JS代码</a>&nbsp;
           <div id="new_jsd12" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>归档列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFARCHIVES_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd12');return false">新include代码</a>&nbsp;
           <div id="new_libd12" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>归档列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFARCHIVES_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd12');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd12" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>归档列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=bfarchives&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd12');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd12" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>归档列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulBFArchives&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulBFArchives=bfarchives,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd12');return false">include代码</a>&nbsp;
           <div id="libd12" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>归档列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFARCHIVES#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
	  <tr>
        <td>13.评论回复使用:</td>
        <td><input name="busfly_randomsort_isComments" type="checkbox" value="1" <%if busfly_randomsort_isComments=1 then%>checked="checked"<%end if%> />
          <input name="busfly_randomsort_NUM_Comments" style="width:20px" type="text" value="<%=busfly_randomsort_NUM_Comments%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd13');return false">新JS代码</a>&nbsp;
           <div id="new_jsd13" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>评论回复使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFCOMMENTS_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd13');return false">新include代码</a>&nbsp;
           <div id="new_libd13" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>评论回复使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFCOMMENTS_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd13');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd13" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>评论回复使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=bfComments&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd13');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd13" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>评论回复使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulBFComments&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulBFComments=bfcomments,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd13');return false">include代码</a>&nbsp;
           <div id="libd13" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>评论回复使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFCOMMENTS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
	  <tr>
        <td>14.留言列表使用:</td>
        <td><input name="busfly_randomsort_isGuestComments" type="checkbox" value="1" <%if busfly_randomsort_isGuestComments=1 then%>checked="checked"<%end if%> />
          <input name="busfly_randomsort_NUM_GuestComments" style="width:20px" type="text" value="<%=busfly_randomsort_NUM_GuestComments%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd14');return false">新JS代码</a>&nbsp;
           <div id="new_jsd14" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>留言列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFGUESTCOMMENTS_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd14');return false">新include代码</a>&nbsp;
           <div id="new_libd14" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>留言列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFGUESTCOMMENTS_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd14');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd14" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>留言列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=bfguestcomments&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd14');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd14" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>留言列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulBFGuestcomments&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulBFGuestcomments=bfguestcomments,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd14');return false">include代码</a>&nbsp;
           <div id="libd14" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>留言列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFGUESTCOMMENTS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
	  <tr>
        <td>15.引用列表使用:</td>
        <td><input name="busfly_randomsort_isTrackBacks" type="checkbox" value="1" <%if busfly_randomsort_isTrackBacks=1 then%>checked="checked"<%end if%> />
          <input name="busfly_randomsort_NUM_TrackBacks" style="width:20px" type="text" value="<%=busfly_randomsort_NUM_TrackBacks%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd15');return false">新JS代码</a>&nbsp;
           <div id="new_jsd15" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>引用列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFTRACKBACKS_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd15');return false">新include代码</a>&nbsp;
           <div id="new_libd15" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>引用列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFTRACKBACKS_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd15');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd15" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>引用列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=bftrackbacks&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd15');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd15" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>引用列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulBFTrackbacks&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulBFTrackbacks=bftrackbacks,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd15');return false">include代码</a>&nbsp;
           <div id="libd15" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>引用列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFTRACKBACKS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
	  <tr>
        <td>16.用户列表使用:</td>
        <td><input name="busfly_randomsort_isAuthors" type="checkbox" value="1" <%if busfly_randomsort_isAuthors=1 then%>checked="checked"<%end if%> />
          <input name="busfly_randomsort_NUM_Authors" style="width:20px" type="text" value="<%=busfly_randomsort_NUM_Authors%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd16');return false">新JS代码</a>&nbsp;
           <div id="new_jsd16" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>用户列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFAUTHORS_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd16');return false">新include代码</a>&nbsp;
           <div id="new_libd16" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>用户列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFAUTHORS_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd16');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd16" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>用户列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=bfauthors&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd16');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd16" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>用户列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulBFAuthors&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulBFAuthors=bfauthors,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd16');return false">include代码</a>&nbsp;
           <div id="libd16" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>用户列表使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFAUTHORS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
	  <tr>
        <td>17.分类目录使用:</td>
        <td><input name="busfly_randomsort_isCatalogs" type="checkbox" value="1" <%if busfly_randomsort_isCatalogs=1 then%>checked="checked"<%end if%> />
          <input name="busfly_randomsort_NUM_Catalogs" style="width:20px" type="text" value="<%=busfly_randomsort_NUM_Catalogs%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd17');return false">新JS代码</a>&nbsp;
           <div id="new_jsd17" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类目录使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFCATALOG_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd17');return false">新include代码</a>&nbsp;
           <div id="new_libd17" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类目录使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFCATALOG_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd17');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd17" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类目录使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=bfcatalog&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd17');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd17" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类目录使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulBFCatalogs&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulBFCatalogs=bfcatalog,&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd17');return false">include代码</a>&nbsp;
           <div id="libd17" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类目录使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BFCATALOG#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>

      <tr>
        <td>18.分类最新回复使用:</td>
        <td><input name="busfly_randomsort_isBuildCategoryComments" type="checkbox" value="1" <%if busfly_randomsort_isBuildCategoryComments=1 then%>checked="checked"<%end if%> />
          <input name="busfly_randomsort_NUM_CategoryComments" style="width:20px" type="text" value="<%=busfly_randomsort_NUM_CategoryComments%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd18');return false">新JS代码</a>&nbsp;
           <div id="new_jsd18" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类最新回复使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BF_COMMENTS_CATEGORY_{id}_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd18');return false">新include代码</a>&nbsp;
           <div id="new_libd18" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类最新回复使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BF_COMMENTS_CATEGORY_{id}_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd18');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd18" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类最新回复使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=bf_comments_category_{id}&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd18');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd18" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类最新回复使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulBFCatalogsComment&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulBFCatalogsComment=bf_comments_category_{id},&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd18');return false">include代码</a>&nbsp;
           <div id="libd18" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类最新回复使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BF_COMMENTS_CATEGORY_{id}#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>
      <tr>
        <td>19.分类热门文章使用:</td>
        <td><input name="busfly_randomsort_isBuildCategoryTophot" type="checkbox" value="1" <%if busfly_randomsort_isBuildCategoryTophot=1 then%>checked="checked"<%end if%> />
          <input name="busfly_randomsort_NUM_CategoryTophot" style="width:20px" type="text" value="<%=busfly_randomsort_NUM_CategoryTophot%>"/>条</td>
        <td>
              1.8 Walle Build 91204 及之后版本的用法---------------------------<BR>
              
           <a href="#" onClick="showhidediv('new_jsd19');return false">新JS代码</a>&nbsp;
           <div id="new_jsd19" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类热门文章使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BF_TOPHOT_CATEGORY_{id}_JS#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
           <a href="#" onClick="showhidediv('new_libd19');return false">新include代码</a>&nbsp;
           <div id="new_libd19" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类热门文章使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BF_TOPHOT_CATEGORY_{id}_HTML#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
              
              <BR><BR>下面是旧版(1.8 Walle Build 91204 之前版本)的用法---------------------------<BR>
              
              
        <a href="#" onClick="showhidediv('jsd19');return false">JS代码</a>&nbsp;&nbsp;
          <div id="jsd19" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类热门文章使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;  src=&quot;&lt;#ZC_BLOG_HOST#&gt;function/c_html_js.asp?include=bf_tophot_category_{id}&quot;  type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
		<a href="#" onClick="showhidediv('pjsd19');return false">批量JS代码</a>&nbsp;&nbsp;
          <div id="pjsd19" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类热门文章使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul id=&quot;ulBFCatalogsTopHot&quot;&gt;<br />
               <u><strong>&lt;script language=&quot;JavaScript&quot;   type=&quot;text/javascript&quot;&gt;strBatchInculde+=&quot;ulBFCatalogsTopHot=bf_tophot_category_{id},&quot;&lt;/script&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div>
		
           <a href="#" onClick="showhidediv('libd19');return false">include代码</a>&nbsp;
           <div id="libd19" style="display:none; background-color:#999999">   &lt;div class=&quot;function&quot;&gt;<br />
               &lt;h3&gt;<u><strong>分类热门文章使用</strong></u>&lt;/h3&gt;<br />
               &lt;ul&gt;<br />
               <u><strong>&lt;#CACHE_INCLUDE_BF_TOPHOT_CATEGORY_{id}#&gt;</strong></u><br />
               &lt;/ul&gt;<br />
           &lt;/div&gt;</div></td>
      </tr>

      <tr>
        <td>20.标题字数</td>
        <td><input name="intCutLen" style="width:20px" type="text" value="<%=intCutLen%>"/>
          个</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>21:标题中引号(<span class="STYLE1">&quot;'</span>)替换:</td>
        <td><input name="busfly_randomsort_chReplace" style="width:20px" type="text" value="<%=busfly_randomsort_chReplace%>"/></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="3" align="center"><p class="STYLE2">注意:这里只提供通用代码,获取的代码里<span class="STYLE3">黑色粗体</span>部分是关键代码,你可单独取出,拿出来自己DIY;<span class="STYLE1">红色粗体</span>部分是DIV的ID,是默认主题的留言本的样式ID,自己设吧</p>
        <p class="STYLE2"><span class="STYLE4">特别提醒:</span>1:分类列表里提供的调用代码不能直接用,要把那个&quot;<span class="STYLE1">{id}</span>&quot;要替换成分类的ID,这个ID可以到你的分类管理里去查到.</p>
        <p class="STYLE2"><span class="STYLE4">特别提醒:</span>2:如果采用的是&quot;批量JS代码&quot;,如果没有显示列表,请参考<a href="http://bbs.rainbowsoft.org/thread-3530-1-2.html" target="_blank">文章列表调用方法</a>中JS调用B方法</p></td>
      </tr>
    </table>
    <p>
      <input type="submit" class="button" value=" 保存 " id="btnPost" onclick='document.getElementById("edit").action="savesetting.asp";' />
    </p>
    <br/>
    <p>讨论区:======<a target='_blank' href='http://bbs.rainbowsoft.org/thread-18854-1-1.html'>ZBLOG论坛帖</a>======<a target='_blank' href='http://www.busfly.net/post/z-blog-1-8-randomsort-plugin.html'>作者博客专区</a>======<a href="http://bbs.rainbowsoft.org/thread-3530-1-2.html" target="_blank">文章列表调用方法</a></p>
    <br/>
  </form>
</div>
<script language="javascript">
function ChangeValue(obj){

	if (obj.value=="True")
	{
	obj.value="False";
	return true;
	}

	if (obj.value=="False")
	{
	obj.value="True";
	return true;
	}
}
</script>
</body>
</html>
<%
Call System_Terminate()

If Err.Number<>0 then
  Call ShowError(0)
End If
%>
