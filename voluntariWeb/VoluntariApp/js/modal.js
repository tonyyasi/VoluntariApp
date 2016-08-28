$(document).ready(function () {

	var base = "https://nameless-forest-54224.herokuapp.com/api/v1/";
	var projects = base + "projects";
	var organizations = base + "organizations";


	//index
	$.getJSON(projects,function(data){
		var statusHTML = '<div class="container p-t-2"><div class="row">';
		$.each(data,function(index, project){
			statusHTML += '<a href="proyecto.html">';
			statusHTML += '<div class="abc col-lg-12 m-t-3 bg-info img-rounded"><h2 class="tit">';
			statusHTML += project.name + '</h2><h4 class="m-l-3 p-t-2 inf">';
			statusHTML += project.description + '</h4>';
			statusHTML += '</div></a>';
		});
		$('#cuatro').html(statusHTML);
	});
	//acaba index

	//proyecto


	//acaba proyecto

	// org
/*
	$("#org").on("click", function(){
		var id = $(this).text();
		console.log(id);
		$.getJSON(organizations, function(data){
			$.each(data, function (index, org) {

				if (org.name === id) {
				var statusHTML = '<div class="jumbotron jumbotron-fluid bg-info"><div class="container text-xs-center p-y-3">';
				statusHTML += '<h1 class="display-3 titulo orga">' + org.name + '</h1></div></div>';
				statusHTML += '<div class="container p-t-2"><div class="container"><div class="row">';
				statusHTML += '<div class="col-lg-12 m-t-3 img-rounded text-justify" style="font-size: 2rem;"><p class="texto">';
				statusHTML += org.description + '</p></div></div></div>';
			}

			});
			statusHTML += '</div>';
			$('#organizacion').html(statusHTML);
		});
	});
*/

	//acaba org

	//Categorias
/*
	$("button").on("click", function() {
  		var id = $(this).attr('id');
  		var modal = $(".bs-example-modal-lg");
		$.getJSON(projects, function (data) {

    		var statusHTML = '<h4 class="modal-title">Proyectos de ' + id;
    		statusHTML += '</h4></div>';
    		statusHTML += '<div class="modal-body"><ul class="list-group">';
    		$.each(data,function (index, project) {
      		if (project.categoria === id) {
        		statusHTML +='<a href="proyecto.html"><li class="list-group-item"><h4 class="list-group-item-heading">' + project.name;
        		statusHTML += '</h4>' + project.categories + '</li></a>';
      		} 
    		});
    		statusHTML += '</div>';
    		console.log(statusHTML);
    		$('#categorias').html(statusHTML);
    		modal.modal('show');
  		}); // end getJSON
  	});*/

  	//Acaba Categorias

//inscribete
  		$("#bot").on("click", function() {
  		var el = $(this);
  		if (el.text() == el.data("text-swap")) {
    		el.text(el.data("text-original"));
  		} else {
    		el.data("text-original", el.text());
    		el.text(el.data("text-swap"));
  		}
	});

}); // end ready