<!--#include file="con_app.asp"-->
<html>

<head>
<%
vExp=request.QueryString("exp")
if vExp<>"xls" then%>
<link rel="icon" type="image/png" href="./images/icon.ico" />
<title>Mundo Maquinaria</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="assets2/css/core.css" type="text/css" />
<link rel="stylesheet" href="assets2/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="assets2/css/components.css" type="text/css" />
<link rel="stylesheet" href="assets2/css/icons.css" type="text/css" />
<link rel="stylesheet" href="assets2/css/pages.css" type="text/css" />

<!--<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />-->
<link rel="stylesheet" href="assets/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="assets/css/uniform.css" />
<link rel="stylesheet" href="assets/css/select2.css" />
<link rel="stylesheet" href="assets/css/matrix-media.css" />
<link rel="stylesheet" href="assets/css/matrix-style.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="assets/css/mantenedores.css" />
<%end if%>
</head>
<%
if vExp="xls" then
    Response.AddHeader "content-disposition", "attachment; filename=Reporte_Cotizaciones_" & year(now) &"-"& month(now) &"-"& day(now) & "_" & hour(now) & "_" & minute(now) & ".xls"
    Response.ContentType = "application/excel"
end if
%>
<body class="body-graficos">
<%
if vExp<>"xls" then
	vBusca=false
	if trim(request.QueryString("opc"))="sch" then
		'opcion buscar
		vBusca=true
	end if

else
	vBusca=true
	vTxt_Nombre = request.Form("nombre_cli")
	vTxt_Plan   = request.Form("vPlan")
	vTxt_Region = request.Form("vRegion")

end if
%>
<%if vExp<>"xls" then%>
<!--Header-part-->
<div id="header">
</div>
<!--#include file="./menu.asp"-->
<div id="content">
	<div id="content-header">
		<div id="breadcrumb">
			<a href="index.asp" title="Go to Home" class="tip-bottom" style="color:#666666">Inicio</a>
		</div>
		<h1>Informe Resumen</h1>
	</div>
<%end if%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12">
				<h4 class="page-title">Estadísticas</h4>
				<p class="text-muted page-title-alt">Bienvenido al panel de informes</p>
			</div>
		</div>
	<form name="form1_crit" action="#" method="post" class="form-horizontal">
		<table width="79%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr class="parrafoazulch">
				<td>Fecha Desde:</td>
				<td>
					<input class="span12 text-box-modal" type="text" name="fecha_ini" placeholder="dd-mm-aaaa" />
				</td>
				<td>Fecha Hasta:</td>
				<td><input class="span12 text-box-modal" type="text" name="fecha_fin" placeholder="dd-mm-aaaa" /></td>

			</tr>
		</table>
            <div class="form-actions">
              <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'graficos.asp?opc=sch');">Buscar</button>
			  <button type="submit" class="btn btn-success" onClick="irAFuera(document.forms.form1_crit,'graficos.asp?opc=sch&exp=xls','_blank')">Exportar</button>

            </div>
	</form>
<%if request.QueryString("opc") = "sch" then%>
		<div class="row">
			<div class="col-md-6 col-lg-3">
				<div class="widget-bg-color-icon card-box fadeInDown animated">
					<div class="bg-icon bg-icon-info pull-left">
						<i class="md md-attach-money text-info"></i>
					</div>
					<div class="text-right">
						<%
						sql = "exec NClientes"
						if request.form("fecha_ini") = "" then
							sql=sql & " '01-01-2017', "
						else
							sql=sql & " '" & request.form("fecha_ini") & "', "
						end if
						if request.form("fecha_fin") = "" then
							sql=sql & " '31-12-2030' "
						else
							sql=sql & " '" & request.form("fecha_fin") & "' "
						end if

						Set rs = nothing
						Set rs = cn.Execute(sql)
						if not rs.eof then
							vNClientes 	= rs("NClientes")
						end if
						%>
						<h3 class="text-dark"><b class="counter"><%=vNClientes%></b></h3>
						<p class="text-muted">Clientes</p>
						
					</div>
					<div class="clearfix"></div>
				</div>
					*N° total de clientes
			</div>
			
			<div class="col-md-6 col-lg-3">
				<div class="widget-bg-color-icon card-box">
					<div class="bg-icon bg-icon-pink pull-left">
						<i class="md md-add-shopping-cart text-pink"></i>
					</div>
					<div class="text-right">
						<%
						sql = "exec NCotizacion"
						if request.form("fecha_ini") = "" then
							sql=sql & " '01-01-2017', "
						else
							sql=sql & " '" & request.form("fecha_ini") & "', "
						end if
						if request.form("fecha_fin") = "" then
							sql=sql & " '31-12-2030' "
						else
							sql=sql & " '" & request.form("fecha_fin") & "' "
						end if	
				
						Set rs = nothing
						Set rs = cn.Execute(sql)
						if not rs.eof then
							vNCotizacion 	= rs("NCotizacion")
						end if
						%>
						<h3 class="text-dark"><b class="counter"><%=vNCotizacion%></b></h3>
						<p class="text-muted">Cotizaciones</p>
					</div>
					<div class="clearfix"></div>
				</div>
				*N° total de cotizaciones
			</div>

			<div class="col-md-6 col-lg-3">
				<div class="widget-bg-color-icon card-box">
					<div class="bg-icon bg-icon-purple pull-left">
						<i class="md md-equalizer text-purple"></i>
					</div>
					<div class="text-right">
						<%
						sql = "exec NEquipos"
						if request.form("fecha_ini") = "" then
							sql=sql & " '01-01-2017', "
						else
							sql=sql & " '" & request.form("fecha_ini") & "', "
						end if
						if request.form("fecha_fin") = "" then
							sql=sql & " '31-12-2030' "
						else
							sql=sql & " '" & request.form("fecha_fin") & "' "
						end if
	
						Set rs = nothing
						Set rs = cn.Execute(sql)
						if not rs.eof then
							vNEquipos 	= rs("NEquipos")
						end if
						%>
						<h3 class="text-dark"><b class="counter"><%=vNEquipos%></b></h3>
						<p class="text-muted">Equipos</p>
					</div>
					<div class="clearfix"></div>
				</div>
				*N° total de equipos
			</div>

			<div class="col-md-6 col-lg-3">
				<div class="widget-bg-color-icon card-box">
					<div class="bg-icon bg-icon-success pull-left">
						<i class="md md-remove-red-eye text-success"></i>
					</div>
					<div class="text-right">
						<%
						sql = "exec NVisitas"
						if request.form("fecha_ini") = "" then
							sql=sql & " '01-01-2017', "
						else
							sql=sql & " '" & request.form("fecha_ini") & "', "
						end if
						if request.form("fecha_fin") = "" then
							sql=sql & " '31-12-2030' "
						else
							sql=sql & " '" & request.form("fecha_fin") & "' "
						end if						
						Set rs = nothing
						Set rs = cn.Execute(sql)

						if not rs.eof then
							vNVisitas 	= rs("NVisitas")
						end if
						%>
						<h3 class="text-dark"><b class="counter"><%=vNVisitas%></b></h3>
						<p class="text-muted">Visitas</p>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			*N° total de visitas
		</div>
		<%end if%>
		
	</div>
</div> <!-- container -->
<script>
	var resizefunc = [];
</script>
<%if vExp<>"xls" then%>
<!-- jQuery  -->
<script src="assets2/js/jquery.min.js"></script>
<script src="assets2/js/bootstrap.min.js"></script>
<script src="assets2/js/detect.js"></script>
<script src="assets2/js/fastclick.js"></script>
<script src="assets2/js/jquery.slimscroll.js"></script>
<script src="assets2/js/jquery.blockUI.js"></script>
<script src="assets2/js/waves.js"></script>
<script src="assets2/js/wow.min.js"></script>
<script src="assets2/js/jquery.nicescroll.js"></script>
<script src="assets2/js/jquery.scrollTo.min.js"></script>
<script src="assets2/plugins/peity/jquery.peity.min.js"></script>
<!-- jQuery  -->
<script src="assets2/plugins/waypoints/lib/jquery.waypoints.js"></script>
<script src="assets2/plugins/counterup/jquery.counterup.min.js"></script>
<script src="assets2/plugins/morris/morris.min.js"></script>
<script src="assets2/plugins/raphael/raphael-min.js"></script>
<script src="assets2/plugins/jquery-knob/jquery.knob.js"></script>
<script src="assets2/pages/jquery.dashboard.js"></script>
<script src="assets2/js/jquery.core.js"></script>
<script src="assets2/js/jquery.app.js"></script>

<!--Footer-part-->
<div class="row-fluid footer-graficos">
  <div id="footer" class="span12"> 2017 &copy; Desarrollado por Go4 <a href="http://www.gofour.cl">Gofour.cl</a> </div>
</div>
<!--end-Footer-part-->
<script src="assets/js/jquery.ui.custom.js"></script>
<script src="assets/js/jquery.uniform.js"></script>
<script src="assets/js/select2.min.js"></script>
<script src="assets/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="assets/js/funciones.js"></script>
<script src="assets2/js/modernizr.min.js"></script>
<script src="assets/js/matrix.js"></script>
<script src="assets/js/matrix.tables.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$('.counter').counterUp({
			delay: 100,
			time: 1200
		});

		$(".knob").knob();

	});
</script>
<%end if%>
</body>
</html>
