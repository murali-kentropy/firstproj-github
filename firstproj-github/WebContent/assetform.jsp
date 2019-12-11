<%@page import="database.CrudOperations"%>
<%@page import="database.GenerateDashboardData"%>
<%@page import="database.Supporting"%>
<%@page import="org.json.JSONObject,java.io.*"%>
<%@page import="org.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://unpkg.com/jquery"></script>
<script src="https://surveyjs.azureedge.net/1.1.23/survey.jquery.min.js"></script>
 <link href="https://surveyjs.azureedge.net/1.0.28/survey.css" type="text/css" rel="stylesheet" />

<script>

<% 	GenerateDashboardData.confirgPath=request.getRealPath("/")+"/dashboards";
%>
var typeList=<%=GenerateDashboardData.getAssetType()%>;
var assignedtoList=<%=GenerateDashboardData.getStaff()%>;
var locationList=<%=GenerateDashboardData.getLocations()%>;

</script>
<script src="js/assetform.js"></script>
    </head>
    <body>
<div id="surveyContainer"></div>
  <%
  int asset_no=0;
  String type="";String name="";String serial_no="";String ano="";String verified="";
  String status="";String location="";String assignedto=""; String history="";String model="";
  CrudOperations crop=new CrudOperations();
  JSONObject obj=new JSONObject();	
  if(request.getParameter("asset_no")!=null){
		asset_no=Integer.parseInt(request.getParameter("asset_no"));
		
		obj=crop.getByAssset_no(asset_no);
		if(obj.has("type"))type=obj.getString("type");if(obj.has("name"))name=obj.getString("name");if(obj.has("asset_no"))ano=obj.getString("asset_no");if(obj.has("verified"))verified=obj.getString("verified");
		if(obj.has("location"))location=obj.getString("location");if(obj.has("serial_no"))serial_no=obj.getString("serial_no");if(obj.has("status"))status=obj.getString("status");if(obj.has("assignedto"))assignedto=obj.getString("assignedto");
		if(obj.has("history"))history=obj.getString("history");if(obj.has("model"))model=obj.getString("model");

  }
  %>
            
<script>
//Survey.StylesManager.applyTheme("bootstrap");



function sendDataToServer(survey) {
    //send Ajax request to your web server.
    var data=survey.data;
    //alert("The results are:" + JSON.stringify(survey.data));
	var request={};
	request.data=JSON.stringify(data);
	request.history=JSON.stringify(history);
	request.asset_no=JSON.stringify(asset_no);
	
	postForm(request,"assetcrud.jsp");

}

function postForm(request,url){
    
    $.post(url,
   request,
    function(data,status){
        alert("Data saved successfully: \nStatus: " + status);
        window.location.href="survey_monitoring_dashboard.jsp?tabs=assetmanagement&dashboard=assetmanagement";
        });
};

var survey = new Survey.Model(assetjson);
var history="";
var asset_no=<%=asset_no%>;

if(asset_no!=0){
	var assignedto="<%=assignedto%>";
	var type="<%=type%>";
	var name="<%=name%>";
 	var serial_no="<%=serial_no%>";
 	var model="<%=model%>";
 	var verified="<%=verified%>";
 	var status="<%=status%>";
	 var location1="<%=location%>"; 
 
	survey.getQuestionByName("assignedto").value=assignedto;
	survey.getQuestionByName("type").value=type;
	survey.getQuestionByName("name").value=name;
	survey.getQuestionByName("serial_no").value=serial_no;
	survey.getQuestionByName("model").value=model;
	survey.getQuestionByName("verified").value=verified;
	survey.getQuestionByName("status").value=status;
	survey.getQuestionByName("location").value=location1;

	

 }
$("#surveyContainer").Survey({
    model: survey,
    onComplete: sendDataToServer
});


</script>
</body>
</html>