<%@ page import="java.io.*,java.util.*" %>
<html>
<head>
<link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"   rel = "stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>
</head>
<body>

  <div class="container">
      <div class="header clearfix" style="width:100%">
        <nav>
          <ul class="nav nav-pills float-right">
            <li class="nav-item">
              <a class="nav-link active" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">About</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Contact</a>
            </li>
          </ul>
        </nav>
        <h3 class="text-muted">Cognizant Survey App - Demo V0.1</h3>
      </div>
 

<hr>     
<table id="example" class = "display"  width="100%">
  <thead>
  <tr>
     <th><button type="button" class="btn btn-primary">List of ProjectLead And Team Member Email-ids</button></th>
     <th> <button type="button" class="btn btn-primary">Select All</button> <input type = "checkbox" id = "selectall" checked /> </th>
     </tr>
  </thead>
   <tbody id = "tb1_body">
       
         <% 
        Map<String,List<String>> myMap = (Map) request.getAttribute("emailList");
        System.out.println("myMap" +myMap);		
        Set<String> keys = myMap.keySet();
        int i =0;
        for(String key: keys){  
         System.out.println("Value of "+key+" is: "+myMap.get(key));
        %>
        <tr>
            <td><button   class="btn btn-primary" id = "<%=i%>"   onclick = "showTm(this.id);" > +
             
            </button> <a id = "pl_<%=i%>" >   <%=key%>  </a></td>
             <td><input type = "checkbox" id = "select_<%=i%>" checked /></td>
        </tr>
             
           <%
            List<String> tmEmailIds = myMap.get(key);
           System.out.println("List of EmailIds==> "+tmEmailIds);
           for(int j =0;j< tmEmailIds.size(); j++){ 
        	   i++;
        	   
        	   %>
              
             <tr  id = "tr_<%=i%>"  class="collapse" >
             <td><%=tmEmailIds.get(j) %></td>  
               <td><input type = "checkbox" id = "check_<%=i%>" checked /></td> 
             </tr>
            	 <% 
            	 } %> 
             <%   i++;
                 }
                 %>
    </tbody>
</table>
<center><button type="button" class="btn btn-success" id = "sendmail">Send Mails</button> </center>

<footer class="footer">
        <p>&copy; Cognizant 2019</p>  
      </footer>

    </div> <!-- /container -->
</body>

<script>
    $(document).ready(function(){
      var table = $('#example').DataTable({
          "ordering":false,
          "responsive":true
   });
});
    
    
     function showTm(id){
    	 
    	  
    		 document.getElementById(id).innerHTML = "-";
    	  
    		 
    	 
    	 
    	 $("#tr_"+id).toggle();
    	  
    	
    	 
     }
    
     
    $("#selectall").click(function () {
    	 var x = document.getElementById("example").rows.length;
    	 for(var i = 0; i<x-1;i++){
    		 if(document.getElementById("selectall").checked){
    		 document.getElementById("select_"+i).checked = true;
    		 }else{
    			 document.getElementById("select_"+i).checked = false;
    		 }
    	 }
    });
    
    
     $("#sendmail").click(function () {
		 var x = document.getElementById("example").rows.length;
		 
		 alert(x);
		 var tmemail = "";
		 for(var i = 0; i<x-1;i++){
			 alert(document.getElementById("select_"+i));
			 alert(document.getElementById("check_"+i));
			 
			 if(document.getElementById("select_"+i) != null){
			  tmemail += document.getElementById("pl_"+i).innerHTML+";";
			 }else if(document.getElementById("check_"+i) != null ){
				 tmemail += document.getElementById("tr_"+i).innerHTML+";";
			 }
		 }
		  alert(tmemail);
		 
		  if(tmemail == ""){
			  alert("Please Select Atleast One TeamMember To Send Mail");
			  return;
		  }
		  $.ajax({
				type : "POST",
				url : "/admin/sendmailToMember",	
				data: {
					emailid: tmemail
		 		},
				success : function(response) {
					alert("E-mail Sent Successfully.");
					if (response != "")
		 			{
					 ///
		 			}
					
				}
		  });
	  });
</script>
</html>
            