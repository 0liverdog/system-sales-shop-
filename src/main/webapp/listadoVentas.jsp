<%@ page import="java.util.List, Entidades.Venta, Dao.Dao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ventas Activas</title>
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

.nav-item:active {
  transform: translateX(4px) scale(0.95);
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
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
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
  margin-bottom: 32px;
}

.page-header h1 {
  font-family: 'Syne', sans-serif;
  font-weight: 800;
  font-size: 32px;
  letter-spacing: -0.5px;
  margin-bottom: 8px;
}

.page-header p {
  color: var(--text-3);
  font-size: 14px;
  font-weight: 300;
}

.toolbar {
  display: flex;
  gap: 12px;
  margin-bottom: 24px;
  flex-wrap: wrap;
}

.btn {
  padding: 10px 18px;
  border-radius: var(--r-sm);
  font-size: 13px;
  font-weight: 500;
  cursor: pointer;
  border: none;
  transition: all .3s ease;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  text-decoration: none;
}

.btn-primary {
  background: linear-gradient(135deg, var(--emerald), var(--cyan));
  color: var(--bg-deep);
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(46, 204, 113, 0.3);
}

.btn-secondary {
  background: var(--bg-card);
  color: var(--text-2);
  border: 1px solid var(--border);
}

.btn-secondary:hover {
  background: var(--bg-hover);
  color: var(--text-1);
  border-color: var(--cyan);
}

.btn-danger {
  background: var(--rose-dim);
  color: var(--rose);
  border: 1px solid var(--rose);
}

.btn-danger:hover {
  background: var(--rose);
  color: var(--bg-deep);
}

/* Formulario de búsqueda */
.search-form {
  display: flex;
  gap: 8px;
  flex: 1;
  max-width: 500px;
}

.search-box {
  display: flex;
  align-items: center;
  gap: 8px;
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: var(--r-sm);
  padding: 10px 14px;
  transition: border-color .2s;
  flex: 1;
}

.search-box:focus-within {
  border-color: var(--emerald);
}

.search-box svg {
  width: 16px;
  height: 16px;
  stroke: var(--text-3);
  fill: none;
  stroke-width: 2;
  flex-shrink: 0;
}

.search-box input {
  background: none;
  border: none;
  outline: none;
  color: var(--text-1);
  font-size: 13px;
  font-family: inherit;
  width: 100%;
}

.search-box input::placeholder {
  color: var(--text-3);
}

.btn-search {
  background: linear-gradient(135deg, var(--emerald), var(--cyan));
  color: var(--bg-deep);
  padding: 10px 20px;
}

.btn-search:hover {
  transform: translateY(-2px);
   box-shadow: 0 8px 20px rgba(46, 204, 113, 0.3);
}

.stats-card {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: var(--r);
  padding: 24px;
  margin-bottom: 24px;
  position: relative;
  overflow: hidden;
  animation: slideUp .5s cubic-bezier(.22,.68,0,1.2);
}

.stats-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, var(--cyan), var(--emerald));
}

.stats-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.stats-icon {
  width: 56px;
  height: 56px;
  background: var(--emerald-dim);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.stats-icon svg {
  width: 28px;
  height: 28px;
  stroke: var(--emerald);
  fill: none;
  stroke-width: 2;
}

.stats-info {
  flex: 1;
  margin-left: 20px;
}

.stats-label {
  font-size: 12px;
  color: var(--text-3);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 4px;
}

.stats-value {
  font-family: 'Syne', sans-serif;
  font-weight: 800;
  font-size: 32px;
  letter-spacing: -1px;
  color: var(--emerald);
}

.panel {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: var(--r);
  padding: 0;
  overflow: hidden;
  animation: slideUp .5s cubic-bezier(.22,.68,0,1.2);
  animation-delay: .1s;
  animation-fill-mode: both;
}

@keyframes slideUp {
  from { opacity:0; transform:translateY(18px); }
  to   { opacity:1; transform:translateY(0); }
}

.table-wrap {
  overflow-x: auto;
}

table {
  width: 100%;
  border-collapse: collapse;
}

thead th {
  text-align: left;
  font-size: 11px;
  color: var(--text-3);
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.8px;
  padding: 16px 20px;
  border-bottom: 1px solid var(--border);
  background: var(--bg-accent);
}

tbody td {
  padding: 16px 20px;
  font-size: 13px;
  border-bottom: 1px solid var(--border);
}

tbody tr:last-child td {
  border-bottom: none;
}

tbody tr {
  transition: all .3s ease;
}

tbody tr:hover {
  background: var(--bg-hover);
  transform: translateX(4px);
}

.badge {
  display: inline-block;
  font-size: 11px;
  font-weight: 500;
  border-radius: 20px;
}

.badge-success {
  background: var(--emerald-dim);
  color: var(--emerald);
}

.nav-item .badge {
  position: absolute;
  top: 4px;
  right: 4px;

  width: 7px;
  height: 7px;

  background: var(--rose);
  border-radius: 50%;
  border: 1px solid var(--bg-card);

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
.kpi-change {
  font-size:11.5px; font-weight:500;
  display:flex; align-items:center; gap:3px;
}
.kpi-change.up   { color:var(--emerald); }
.kpi-change.down { color:var(--rose); }
.kpi-change svg  { width:10px; height:10px; }

.kpi-value {
  font-family:'Syne',sans-serif;
  font-weight:800; font-size:28px; letter-spacing:-1px;
}
.kpi-label { color:var(--text-3); font-size:12.5px; margin-top:4px; font-weight:300; }

.btn-sm {
  padding: 6px 12px;
  font-size: 12px;
  border-radius: 6px;
}

.btn-info {
  background: var(--cyan-dim);
  color: var(--cyan);
  border: 1px solid var(--cyan);
}

.btn-info:hover {
  background: var(--cyan);
  color: var(--bg-deep);
}

.empty-state {
  text-align: center;
  padding: 60px 20px;
  color: var(--text-3);
}

.empty-state svg {
  width: 64px;
  height: 64px;
  stroke: var(--text-3);
  margin-bottom: 16px;
  opacity: 0.5;
}

.empty-state p {
  font-size: 14px;
  margin-bottom: 8px;
}

.footer-actions {
  display: flex;
  justify-content: center;
  gap: 12px;
  margin-top: 24px;
  flex-wrap: wrap;
  padding-bottom: 40px;
}

::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: var(--border); border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: var(--text-3); }

@media (max-width: 768px) {
  .toolbar {
    flex-direction: column;
  }
  
  .search-form {
    max-width: 100%;
  }
  
  .main {
    padding: 20px;
  }
  
  .stats-content {
    flex-direction: column;
    text-align: center;
  }
  
  .stats-info {
    margin-left: 0;
    margin-top: 16px;
  }
}

.logout-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(10, 12, 15, 0.85);
  backdrop-filter: blur(8px);
  display: none;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  animation: fadeInOverlay 0.3s ease;
}

.logout-overlay.active {
  display: flex;
}

@keyframes fadeInOverlay {
  from { opacity: 0; }
  to { opacity: 1; }
}

.logout-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(10, 12, 15, 0.85);
  backdrop-filter: blur(8px);
  display: none;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.logout-overlay:target {
  display: flex;
  opacity: 1;
}

.logout-popup {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: var(--r);
  padding: 32px;
  max-width: 400px;
  width: 90%;
  position: relative;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
  animation: slideUpPopup 0.4s cubic-bezier(0.22, 0.68, 0, 1.2);
}

@keyframes slideUpPopup {
  from { 
    opacity: 0;
    transform: translateY(30px) scale(0.9);
  }
  to { 
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

.logout-popup-header {
  text-align: center;
  margin-bottom: 24px;
}

.logout-icon {
  width: 56px;
  height: 56px;
  margin: 0 auto 16px;
  background: linear-gradient(135deg, var(--rose), var(--amber));
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  animation: pulseIcon 2s ease-in-out infinite;
}

@keyframes pulseIcon {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.logout-icon svg {
  width: 28px;
  height: 28px;
  stroke: #0a0c0f;
  fill: none;
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
}

.logout-popup h3 {
  font-family: 'Syne', sans-serif;
  font-weight: 700;
  font-size: 20px;
  margin-bottom: 8px;
  letter-spacing: -0.3px;
}

.logout-popup p {
  color: var(--text-3);
  font-size: 13px;
  font-weight: 300;
  line-height: 1.5;
}

.logout-actions {
  display: flex;
  gap: 12px;
  margin-top: 24px;
}

.btn-logout {
  flex: 1;
  padding: 12px 24px;
  border: none;
  border-radius: var(--r-sm);
  font-family: 'DM Sans', sans-serif;
  font-size: 13px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  outline: none;
  text-decoration: none;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.btn-cancel {
  background: var(--bg-hover);
  color: var(--text-1);
  border: 1px solid var(--border);
}

.btn-cancel:hover {
  background: var(--bg-accent);
  transform: translateY(-2px);
}

.btn-confirm {
  background: linear-gradient(135deg, var(--rose), #ff3d4d);
  color: white;
  position: relative;
  overflow: hidden;
}

.btn-confirm::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.5s;
}

.btn-confirm:hover::before {
  left: 100%;
}

.btn-confirm:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(255, 92, 107, 0.4);
}

.btn-confirm:active {
  transform: translateY(0);
}
</style>

</head>
<body>

<%
List<Venta> lista = (List<Venta>) request.getAttribute("lista");
if (lista == null) {
    Dao dao = new Dao();
    lista = dao.listarVentaPorEstado(1);
}
double totalGeneral = 0;
for (Venta v : lista) {
    if (v.getEstado() == 1) {
        totalGeneral += v.getTotal();
    }
}
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
    <span class="badge"></span>
  </a>

  <div class="sidebar-bottom">
    <a href="#logoutPopup" class="avatar">R</a>
  </div>
</aside>

<main class="main">

  <div class="page-header">
    <h1>Ventas Activas</h1>
    <p>Gestiona y consulta todas las ventas realizadas</p>
  </div>

  <div class="stats-card">
    <div class="stats-content">
      <div class="stats-icon">
        <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
          <line x1="12" y1="1" x2="12" y2="23"/>
          <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
        </svg>
      </div>
      <div class="stats-info">
        <div class="stats-label">Total General de Ventas</div>
        <div class="stats-value">S/. <%= String.format("%.2f", totalGeneral) %></div>
      </div>
    </div>
  </div>

  <div class="toolbar">
    <a href="generarVenta.jsp" class="btn btn-primary">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" style="width:16px;height:16px">
        <line x1="12" y1="5" x2="12" y2="19"/>
        <line x1="5" y1="12" x2="19" y2="12"/>
      </svg>
      Generar Venta
    </a>

    <form action="Gestionar" method="get" class="search-form">
      <input type="hidden" name="accion" value="BuscarVenta">
      <div class="search-box">
        <svg viewBox="0 0 24 24" stroke-linecap="round">
          <circle cx="11" cy="11" r="8"/>
          <line x1="21" y1="21" x2="16.65" y2="16.65"/>
        </svg>
        <input type="number" name="idVenta" placeholder="Buscar por ID de venta...">
      </div>
      <button type="submit" class="btn btn-search">Buscar</button>
    </form>
  </div>

  <div class="panel">
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>ID Venta</th>
            <th>Fecha</th>
            <th>Total</th>
            <th>ID Cliente</th>
            <th>Estado</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
        <%
          if (lista == null || lista.isEmpty()) {
        %>
          <tr>
            <td colspan="6">
              <div class="empty-state">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round">
                  <circle cx="12" cy="12" r="10"/>
                  <line x1="12" y1="8" x2="12" y2="12"/>
                  <line x1="12" y1="16" x2="12.01" y2="16"/>
                </svg>
                <p>No hay ventas activas</p>
              </div>
            </td>
          </tr>
        <%
          } else {
            for (Venta v : lista) {
        %>
          <tr>
            <td style="color:var(--text-3)"><%= v.getId_venta() %></td>
            <td style="color:var(--text-2)"><%= v.getFecha() %></td>
            <td style="color:var(--emerald); font-weight:600">S/ <%= String.format("%.2f", v.getTotal()) %></td>
            <td style="color:var(--text-2)"><%= v.getId_cliente() %></td>
            <td><span class="badge badge-success">Activa</span></td>
            <td>
              <a href="listadoDetalleVenta.jsp?idVenta=<%= v.getId_venta() %>" class="btn btn-info btn-sm">
                 Ver Detalle
              </a>
              <a href="CambiarEstado?tabla=venta&campo=id_venta&id=<%=v.getId_venta()%>&estado=0" 
                 class="btn btn-danger btn-sm">
                Anular
              </a>
            </td>
          </tr>
        <%
            }
          }
        %>
        </tbody>
      </table>
    </div>
  </div>

  <div class="footer-actions">
    <a href="index.jsp" class="btn btn-secondary">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" style="width:16px;height:16px">
        <line x1="19" y1="12" x2="5" y2="12"/>
        <polyline points="12 19 5 12 12 5"/>
      </svg>
      Volver al inicio
    </a>
    <a href="listadoVentaInactivo.jsp" class="btn btn-danger">
      Ver Inactivos
    </a>
  </div>

</main>
<div class="logout-overlay" id="logoutPopup">
  <div class="logout-popup">
    <div class="logout-popup-header">
      <div class="logout-icon">
        <svg viewBox="0 0 24 24">
          <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
          <polyline points="16 17 21 12 16 7"/>
          <line x1="21" y1="12" x2="9" y2="12"/>
        </svg>
      </div>
      <h3>Cerrar Sesion</h3>
      <p>¿Estas seguro que deseas cerrar sesion?</p>
    </div>
    <div class="logout-actions">
      <a href="#" class="btn-logout btn-cancel">Cancelar</a>
      <a href="Logout" class="btn-logout btn-confirm">Cerrar Sesion</a>
    </div>
  </div>
</div>
</body>
</html>