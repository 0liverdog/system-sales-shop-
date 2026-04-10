<%@ page import="java.util.List, Entidades.DetalleVenta, Dao.Dao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detalle de Venta</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet" />
<style>
:root {
  --bg-deep:    #0a0c0f;
  --bg-card:    #121519;
  --bg-hover:   #1a1e24;
  --bg-accent:  #1e2328;
  --text-1:     #f0f1f3;
  --text-2:     #7a8290;
  --text-3:     #4e545e;
  --border:     #1f252e;
  --cyan:       #00e5ff;
  --cyan-dim:   rgba(0,229,255,.12);
  --emerald:    #2ecc71;
  --emerald-dim:rgba(46,204,113,.12);
  --rose:       #ff5c6b;
  --rose-dim:   rgba(255,92,107,.12);
  --amber:      #f5a623;
  --amber-dim:  rgba(245,166,35,.12);
  --violet:     #a78bfa;
  --violet-dim: rgba(167,139,250,.12);
  --r:          14px;
  --r-sm:       8px;
}

* { margin:0; padding:0; box-sizing:border-box; }

html, body {
  height: 100%;
  margin: 0;
  overflow: hidden;
}

body {
  font-family: 'DM Sans', sans-serif;
  background: var(--bg-deep);
  color: var(--text-1);
  display: flex;
}

.nav-item .badge1 {
  position:absolute; top:4px; right:4px;
  width:7px; height:7px;
  background: var(--rose);
  border-radius:50%;
  border:1.5px solid var(--bg-card);
  animation: badgePulse 2s ease-in-out infinite;
}

@keyframes badgePulse {
  0%, 100% { 
    transform: scale(1);
    box-shadow: 0 0 0 0 rgba(255, 92, 107, 0.7);
  }
  50% { 
    transform: scale(1.1);
    box-shadow: 0 0 0 4px rgba(255, 92, 107, 0);
  }
}

.sidebar {
  width: 80px;
  height: 100vh;
  background: var(--bg-card);
  border-right: 1px solid var(--border);
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 28px 0;
  gap: 6px;
  flex-shrink: 0;
  position: fixed;
  left: 0;
  top: 0;
  z-index: 100;
}

.sidebar-logo {
  width: 42px; height: 42px;
  background: linear-gradient(135deg, var(--cyan), var(--violet));
  border-radius: 12px;
  margin-bottom: 32px;
  display: flex; align-items: center; justify-content: center;
  cursor: pointer;
  transition: transform .3s ease, box-shadow .3s ease;
  text-decoration: none;
}
.sidebar-logo:hover {
  transform: rotate(90deg) scale(1.1);
  box-shadow: 0 0 20px rgba(0, 229, 255, 0.4);
}
.sidebar-logo svg { width:22px; height:22px; }

.nav-item {
  width:46px; height:46px;
  border-radius:12px;
  display:flex; align-items:center; justify-content:center;
  cursor:pointer;
  position:relative;
  transition: all .3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
  text-decoration: none;
}

.nav-item::before {
  content: '';
  position: absolute;
  left: -8px;
  width: 4px;
  height: 0;
  background: var(--emerald);
  border-radius: 0 4px 4px 0;
  transition: height .3s ease;
}

.nav-item:hover {
  background: var(--bg-hover);
  transform: translateX(4px) scale(1.08);
}

.nav-item.active {
  background: var(--emerald-dim);
  transform: translateX(4px);
}

.nav-item.active::before {
  height: 100%;
}

.nav-item.active svg {
  stroke: var(--emerald);
  filter: drop-shadow(0 0 8px rgba(0, 229, 255, 0.5));
}

.nav-item svg {
  width:20px; height:20px;
  stroke: var(--text-3); fill:none;
  stroke-width:1.8; stroke-linecap:round; stroke-linejoin:round;
  transition: all .3s ease;
}

.nav-item:hover svg {
  stroke: var(--text-2);
  transform: scale(1.1);
}

.sidebar-bottom { margin-top:auto; }

.avatar {
  width:38px; height:38px; border-radius:50%;
  background: linear-gradient(135deg, var(--cyan), var(--violet));
  display:flex; align-items:center; justify-content:center;
  font-family:'Syne',sans-serif; font-weight:700; font-size:14px;
  color:#0a0c0f; cursor:pointer;
  transition: transform .3s ease, box-shadow .3s ease;
}

.avatar:hover {
  transform: scale(1.1) rotate(5deg);
  box-shadow: 0 0 20px rgba(0, 229, 255, 0.4);
}

.main {
  margin-left: 80px;
  flex: 1;
  height: 100vh;
  overflow-y: auto;
  padding: 40px;
  animation: fadeIn .5s ease;
}

@keyframes fadeIn {
  from { opacity:0; transform:translateY(6px); }
  to   { opacity:1; transform:translateY(0); }
}

.page-header {
  max-width: 1400px;
  margin: 0 auto 32px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 20px;
}

.page-title {
  font-family: 'Syne', sans-serif;
  font-weight: 800;
  font-size: 32px;
  color: var(--text-1);
  display: flex;
  align-items: center;
  gap: 12px;
}

.page-title svg {
  width: 32px;
  height: 32px;
  stroke: var(--rose);
}

.page-title-text {
  background: linear-gradient(135deg, var(--rose), var(--amber));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.table-container {
  max-width: 1400px;
  margin: 0 auto;
}

.table-card {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: var(--r);
  overflow: hidden;
  animation: slideUp .6s cubic-bezier(.22,.68,0,1.2);
}

@keyframes slideUp {
  from { opacity:0; transform:translateY(30px); }
  to   { opacity:1; transform:translateY(0); }
}

.data-table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
}

.data-table thead {
  background: var(--bg-accent);
}

.data-table thead th {
  padding: 16px;
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  color: var(--text-2);
  text-align: center;
  border-bottom: 2px solid var(--border);
  white-space: nowrap;
}

.data-table tbody tr {
  transition: all 0.2s ease;
  border-bottom: 1px solid var(--border);
}

.data-table tbody tr:hover {
  background: var(--bg-hover);
  transform: scale(1.01);
}

.data-table tbody td {
  padding: 16px;
  text-align: center;
  color: var(--text-1);
  font-size: 14px;
}

/* Empty state */
.empty-state {
  padding: 60px 20px;
  text-align: center;
}

.empty-state svg {
  width: 80px;
  height: 80px;
  stroke: var(--text-3);
  margin-bottom: 20px;
  opacity: 0.5;
}

.empty-state-text {
  font-size: 16px;
  color: var(--text-3);
  font-weight: 500;
}

.badge {
  display: inline-block;
  padding: 6px 14px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.badge-inactive {
  background: var(--rose-dim);
  color: var(--rose);
}

.btn {
  padding: 8px 16px;
  border-radius: var(--r-sm);
  font-size: 13px;
  font-weight: 600;
  font-family: 'Syne', sans-serif;
  cursor: pointer;
  border: none;
  transition: all .3s ease;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  text-decoration: none;
  white-space: nowrap;
}

.btn svg {
  width: 16px;
  height: 16px;
}

.btn-success {
  background: linear-gradient(135deg, var(--emerald), var(--cyan));
  color: var(--bg-deep);
}

.btn-success:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(46, 204, 113, 0.3);
}

.btn-danger {
  background: linear-gradient(135deg, var(--rose), var(--amber));
  color: var(--bg-deep);
}

.btn-danger:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(255, 92, 107, 0.3);
}

.btn-secondary {
  background: var(--bg-accent);
  color: var(--text-2);
  border: 1px solid var(--border);
}

.btn-secondary:hover {
  background: var(--bg-hover);
  color: var(--text-1);
  border-color: var(--emerald);
}

.btn-sm {
  padding: 6px 12px;
  font-size: 12px;
}

.actions-bar {
  max-width: 1400px;
  margin: 24px auto 0;
  display: flex;
  gap: 12px;
  justify-content: center;
  flex-wrap: wrap;
}

::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: var(--border); border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: var(--text-3); }

@media (max-width: 768px) {
  .main {
    padding: 20px;
  }
  
  .page-title {
    font-size: 24px;
  }
  
  .data-table {
    font-size: 12px;
  }
  
  .data-table thead th,
  .data-table tbody td {
    padding: 10px 8px;
  }
  
  .btn {
    font-size: 11px;
    padding: 6px 10px;
  }
}
</style>
</head>
<body>
<%
int idVenta = Integer.parseInt(request.getParameter("idVenta"));

Dao dao = new Dao();
List<DetalleVenta> lista = dao.listarDetalleVenta(idVenta);
%>
<aside class="sidebar">
  <a href="index.jsp" class="sidebar-logo">
    <svg viewBox="0 0 24 24" fill="none" stroke="#0a0c0f" stroke-width="2.5" stroke-linecap="round">
      <rect x="3" y="3" width="7" height="7" rx="1.5"/>
      <rect x="14" y="3" width="7" height="7" rx="1.5"/>
      <rect x="3" y="14" width="7" height="7" rx="1.5"/>
      <rect x="14" y="14" width="7" height="7" rx="1.5"/>
    </svg>
  </a>

   <a href="listadoProducto.jsp" class="nav-item">
    <svg viewBox="0 0 24 24"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
  </a>

   <a href="listadoProveedor.jsp" class="nav-item">
   <svg viewBox="0 0 24 24"><path d="M12 2L2 7l10 5 10-5-10-5z"/><path d="M2 17l10 5 10-5"/><path d="M2 12l10 5 10-5"/></svg>
  </a>
  
  <a href="listadoCliente.jsp" class="nav-item">
    <svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
  </a>

  <a href="listadoVentas.jsp" class="nav-item active">
    <svg viewBox="0 0 24 24"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
  </a>
  
  <a href="notificaciones.jsp" class="nav-item">
    <svg viewBox="0 0 24 24"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
    <span class="badge1"></span>
  </a>

  <div class="sidebar-bottom">
    <div class="avatar">R</div>
  </div>
</aside>

<main class="main">
	<div class="page-header">
	<h1 class="page-title">
      <span class="page-title-text">Detalle de Venta N° <%=idVenta %></span>
	</h1>
	</div>
	
	<div class="table-container">
	<div class="table-card">
		<table class="data-table">
		<thead>
                <tr>
                    <th>ID Detalle</th>
                    <th>Producto</th>
                    <th>Precio</th>
                    <th>Cantidad</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            
      <tbody>
      <%
      		if(lista == null || lista.isEmpty()){
      %>
      
      <tr>
      <td colpsan="5">
      <div class="empty-state">
      <svg viewBox="0 0 24 24" fill="none" stroke-linecap="round" stroke-linejoin="round">
                  <circle cx="12" cy="12" r="10"/>
                  <path d="M16 16s-1.5-2-4-2-4 2-4 2"/>
                  <line x1="9" y1="9" x2="9.01" y2="9"/>
                  <line x1="15" y1="9" x2="15.01" y2="9"/>
		</svg>
		<div class="empty-state-text">No hay detalle de la boleta</div>
      </div>
      </td>
      </tr>
      
      <%
      		} else {
                for (DetalleVenta dt : lista) {
      %>
      
      <tr>
      <td style="font-weight: 600; color: var(--text-3);"><%= dt.getId_detalle() %></td>
      <td style="text-align: center; font-weight: 500;"><%= dt.getNombreProducto() %></td>
      <td style="color: var(--amber); font-weight: 600;">S/ <%= String.format("%.2f", dt.getPrecio()) %></td>
      <td style="color: var(--text-2);"><%= dt.getCantidad() %></td>
      <td style="font-weight: 600;"><%= dt.getSubtotal()%></td>
      </tr>
      <%
                }
            }
        %>
      </tbody>
		</table>
	</div>
	</div>
	
	 <div class="actions-bar">
    <a href="listadoVentas.jsp" class="btn btn-success">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <polyline points="20 6 9 17 4 12"/>
      </svg>
      Ver Ventas Activos
    </a>
    <a href="index.jsp" class="btn btn-secondary">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <line x1="19" y1="12" x2="5" y2="12"/>
        <polyline points="12 19 5 12 12 5"/>
      </svg>
      Volver al Inicio
    </a>
  </div>
	
	
</main>

</body>
</html>
