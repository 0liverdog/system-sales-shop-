<%@ page import="java.util.List, Entidades.*, Dao.Dao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Notificaciones y Actividad</title>
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
  background: var(--cyan);
  border-radius: 0 4px 4px 0;
  transition: height .3s ease;
}

.nav-item:hover {
  background: var(--bg-hover);
  transform: translateX(4px) scale(1.08);
}

.nav-item.active {
  background: var(--cyan-dim);
  transform: translateX(4px);
}

.nav-item.active::before {
  height: 100%;
}

.nav-item.active svg {
  stroke: var(--cyan);
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

.nav-item .badge {
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

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 18px;
  margin-bottom: 32px;
}

.stat-card {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: var(--r);
  padding: 20px;
  position: relative;
  overflow: hidden;
  transition: transform .3s ease, border-color .3s ease;
  animation: slideUp .5s cubic-bezier(.22,.68,0,1.2) both;
}

.stat-card:nth-child(1) { animation-delay: .05s; }
.stat-card:nth-child(2) { animation-delay: .10s; }
.stat-card:nth-child(3) { animation-delay: .15s; }
.stat-card:nth-child(4) { animation-delay: .20s; }

@keyframes slideUp {
  from { opacity:0; transform:translateY(18px); }
  to   { opacity:1; transform:translateY(0); }
}

.stat-card:hover {
  transform: translateY(-4px);
  border-color: var(--cyan);
}

.stat-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
}

.stat-card.cyan::before { background: var(--cyan); }
.stat-card.emerald::before { background: var(--emerald); }
.stat-card.rose::before { background: var(--rose); }
.stat-card.amber::before { background: var(--amber); }

.stat-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
}

.stat-icon {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.stat-icon.cyan { background: var(--cyan-dim); }
.stat-icon.emerald { background: var(--emerald-dim); }
.stat-icon.rose { background: var(--rose-dim); }
.stat-icon.amber { background: var(--amber-dim); }

.stat-icon svg {
  width: 20px;
  height: 20px;
  fill: none;
  stroke-width: 2;
}

.stat-icon.cyan svg { stroke: var(--cyan); }
.stat-icon.emerald svg { stroke: var(--emerald); }
.stat-icon.rose svg { stroke: var(--rose); }
.stat-icon.amber svg { stroke: var(--amber); }

.stat-trend {
  font-size: 11px;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 4px;
  color: var(--emerald);
}

.stat-trend svg {
  width: 12px;
  height: 12px;
}

.stat-value {
  font-family: 'Syne', sans-serif;
  font-weight: 800;
  font-size: 28px;
  letter-spacing: -1px;
  margin-bottom: 4px;
}

.stat-label {
  color: var(--text-3);
  font-size: 12px;
  font-weight: 300;
}

.activity-section {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
  margin-bottom: 32px;
}

.panel {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: var(--r);
  padding: 24px;
  animation: slideUp .6s cubic-bezier(.22,.68,0,1.2);
}

.panel-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--border);
}

.panel-header h3 {
  font-family: 'Syne', sans-serif;
  font-weight: 700;
  font-size: 16px;
  letter-spacing: -0.3px;
}

.panel-badge {
  font-size: 11px;
  background: var(--cyan-dim);
  color: var(--cyan);
  padding: 4px 10px;
  border-radius: 20px;
  font-weight: 500;
}

.activity-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.activity-item {
  display: flex;
  align-items: flex-start;
  gap: 14px;
  padding: 12px;
  border-radius: var(--r-sm);
  transition: all .3s ease;
}

.activity-item:hover {
  background: var(--bg-hover);
  transform: translateX(4px);
}

.activity-avatar {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.activity-avatar.cyan { background: var(--cyan-dim); }
.activity-avatar.emerald { background: var(--emerald-dim); }
.activity-avatar.rose { background: var(--rose-dim); }
.activity-avatar.amber { background: var(--amber-dim); }

.activity-avatar svg {
  width: 20px;
  height: 20px;
  fill: none;
  stroke-width: 2;
}

.activity-avatar.cyan svg { stroke: var(--cyan); }
.activity-avatar.emerald svg { stroke: var(--emerald); }
.activity-avatar.rose svg { stroke: var(--rose); }
.activity-avatar.amber svg { stroke: var(--amber); }

.activity-content {
  flex: 1;
}

.activity-title {
  font-size: 13px;
  font-weight: 500;
  margin-bottom: 4px;
}

.activity-desc {
  font-size: 12px;
  color: var(--text-3);
  margin-bottom: 6px;
}

.activity-time {
  font-size: 11px;
  color: var(--text-3);
  font-weight: 300;
}

.chart-container {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: var(--r);
  padding: 24px;
  animation: slideUp .7s cubic-bezier(.22,.68,0,1.2);
  margin-bottom: 32px;
}

.chart-header {
  margin-bottom: 24px;
}

.chart-header h3 {
  font-family: 'Syne', sans-serif;
  font-weight: 700;
  font-size: 16px;
  margin-bottom: 4px;
}

.chart-header p {
  font-size: 12px;
  color: var(--text-3);
}

.chart-bars {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.chart-bar-item {
  display: flex;
  align-items: center;
  gap: 16px;
}

.chart-label {
  width: 120px;
  font-size: 13px;
  color: var(--text-2);
  font-weight: 500;
}

.chart-bar-wrapper {
  flex: 1;
  position: relative;
  height: 32px;
  background: var(--bg-accent);
  border-radius: 6px;
  overflow: hidden;
}

.chart-bar {
  height: 100%;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding-right: 12px;
  font-size: 12px;
  font-weight: 600;
  color: var(--bg-deep);
  transition: width 1s cubic-bezier(.22,.68,0,1.2);
}

.chart-bar.cyan { background: var(--cyan); }
.chart-bar.emerald { background: var(--emerald); }
.chart-bar.rose { background: var(--rose); }
.chart-bar.amber { background: var(--amber); }

::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: var(--border); border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: var(--text-3); }

@media (max-width: 1024px) {
  .activity-section {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .main {
    padding: 20px;
  }
  
  .stats-grid {
    grid-template-columns: 1fr;
  }
  
  .chart-label {
    width: 80px;
    font-size: 11px;
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
Dao dao = new Dao();

List<Producto> productosRecientes = dao.obtenerUltimosProductos(10);
List<Cliente> clientesRecientes = dao.obtenerUltimosClientes(10);
List<Proveedor> proveedoresRecientes = dao.obtenerUltimosProveedores(10);
List<Venta> ventasRecientes = dao.obtenerUltimasVentas(10);

int nuevosProductos = dao.contarProductos();
int nuevosClientes = dao.contarClientes();
int nuevosProveedores = dao.contarProveedores();
int nuevasVentas = dao.contarVentas();

int maxValor = Math.max(Math.max(nuevosProductos, nuevosClientes), 
                        Math.max(nuevosProveedores, nuevasVentas));
if (maxValor == 0) maxValor = 1; 

int porcentajeProductos = nuevosProductos > 0 ? Math.max(10, (nuevosProductos * 100) / maxValor) : 0;
int porcentajeClientes = nuevosClientes > 0 ? Math.max(10, (nuevosClientes * 100) / maxValor) : 0;
int porcentajeProveedores = nuevosProveedores > 0 ? Math.max(10, (nuevosProveedores * 100) / maxValor) : 0;
int porcentajeVentas = nuevasVentas > 0 ? Math.max(10, (nuevasVentas * 100) / maxValor) : 0;
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

  <a href="listadoVentas.jsp" class="nav-item">
    <svg viewBox="0 0 24 24"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
  </a>
  
  <a href="notificaciones.jsp" class="nav-item active">
    <svg viewBox="0 0 24 24"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
    <span class="badge"></span>
  </a>

 <div class="sidebar-bottom">
    <a href="#logoutPopup" class="avatar">R</a>
  </div>
</aside>

<main class="main">

  <div class="page-header">
    <h1>Centro de Notificaciones</h1>
    <p>Monitorea la actividad reciente y nuevos registros del sistema</p>
  </div>

  <div class="stats-grid">
    <div class="stat-card cyan">
      <div class="stat-header">
        <div class="stat-icon cyan">
          <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
            <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/>
            <line x1="3" y1="6" x2="21" y2="6"/>
            <path d="M16 10a4 4 0 0 1-8 0"/>
          </svg>
        </div>
        <div class="stat-trend">
          <svg viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 4l-8 8h16z"/>
          </svg>
          Últimos 
        </div>
      </div>
      <div class="stat-value"><%= nuevosProductos %></div>
      <div class="stat-label">Productos Recientes</div>
    </div>
    
     <div class="stat-card emerald">
      <div class="stat-header">
        <div class="stat-icon emerald">
          <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
            <path d="M12 2L2 7l10 5 10-5-10-5z"/>
            <path d="M2 17l10 5 10-5"/>
            <path d="M2 12l10 5 10-5"/>
          </svg>
        </div>
        <div class="stat-trend">
          <svg viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 4l-8 8h16z"/>
          </svg>
          Últimos 
        </div>
      </div>
      <div class="stat-value"><%= nuevosProveedores %></div>
      <div class="stat-label">Proveedores Recientes</div>
    </div>

    <div class="stat-card rose">
      <div class="stat-header">
        <div class="stat-icon rose">
          <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
            <circle cx="9" cy="7" r="4"/>
            <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
            <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
          </svg>
        </div>
        <div class="stat-trend">
          <svg viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 4l-8 8h16z"/>
          </svg>
          Últimos 
        </div>
      </div>
      <div class="stat-value"><%= nuevosClientes %></div>
      <div class="stat-label">Clientes Recientes</div>
    </div>

   

    <div class="stat-card amber">
      <div class="stat-header">
        <div class="stat-icon amber">
          <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/>
          </svg>
        </div>
        <div class="stat-trend">
          <svg viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 4l-8 8h16z"/>
          </svg>
          Últimos 
        </div>
      </div>
      <div class="stat-value"><%= nuevasVentas %></div>
      <div class="stat-label">Ventas Recientes</div>
    </div>
  </div>

  <div class="activity-section">
    
    <div class="panel">
      <div class="panel-header">
        <h3>Productos Agregados</h3>
        <span class="panel-badge">Últimos 5</span>
      </div>
      <div class="activity-list">
        <%
        int countP = 0;
        for (Producto p : productosRecientes) {
          if (countP >= 5) break;
          countP++;
        %>
        <div class="activity-item">
          <div class="activity-avatar cyan">
            <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
              <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/>
              <line x1="3" y1="6" x2="21" y2="6"/>
              <path d="M16 10a4 4 0 0 1-8 0"/>
            </svg>
          </div>
          <div class="activity-content">
            <div class="activity-title"><%= p.getNombre() %></div>
            <div class="activity-desc">Precio: S/ <%= String.format("%.2f", p.getPrecio()) %> • Stock: <%= p.getStock() %></div>
            <div class="activity-time">Categoría: <%= p.getCategoria() != null ? p.getCategoria() : "Sin categoría" %></div>
          </div>
        </div>
        <% } %>
      </div>
    </div>

    <div class="panel">
      <div class="panel-header">
        <h3>Clientes Registrados</h3>
        <span class="panel-badge">Últimos 5</span>
      </div>
      <div class="activity-list">
        <%
        int countC = 0;
        for (Cliente c : clientesRecientes) {
          if (countC >= 5) break;
          countC++;
        %>
        <div class="activity-item">
          <div class="activity-avatar emerald">
            <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
              <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
              <circle cx="9" cy="7" r="4"/>
            </svg>
          </div>
          <div class="activity-content">
            <div class="activity-title"><%= c.getNombre() %></div>
            <div class="activity-desc">DNI: <%= c.getDni() %></div>
            <div class="activity-time">Teléfono: <%= c.getTelefono() != null ? c.getTelefono() : "No registrado" %></div>
          </div>
        </div>
        <% } %>
      </div>
    </div>

  </div>

  <div class="chart-container">
    <div class="chart-header">
      <h3>Comparativa de Nuevos Registros</h3>
      <p>Visualización de la actividad reciente en el sistema (últimos 10 registros)</p>
    </div>
    <div class="chart-bars">
      
      <div class="chart-bar-item">
        <div class="chart-label">Productos</div>
        <div class="chart-bar-wrapper">
          <div class="chart-bar cyan" style="width: <%= porcentajeProductos %>%">
            <%= nuevosProductos %>
          </div>
        </div>
      </div>

 	<div class="chart-bar-item">
        <div class="chart-label">Proveedores</div>
        <div class="chart-bar-wrapper">
          <div class="chart-bar emerald" style="width: <%= porcentajeProveedores %>%">
            <%= nuevosProveedores %>
          </div>
        </div>
      </div>
      
      <div class="chart-bar-item">
        <div class="chart-label">Clientes</div>
        <div class="chart-bar-wrapper">
          <div class="chart-bar rose" style="width: <%= porcentajeClientes %>%">
            <%= nuevosClientes %>
          </div>
        </div>
      </div>

     
      <div class="chart-bar-item">
        <div class="chart-label">Ventas</div>
        <div class="chart-bar-wrapper">
          <div class="chart-bar amber" style="width: <%= porcentajeVentas %>%">
            <%= nuevasVentas %>
          </div>
        </div>
      </div>

    </div>
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