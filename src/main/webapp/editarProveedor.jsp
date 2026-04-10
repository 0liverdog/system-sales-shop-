<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dao.Dao, Entidades.Proveedor" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Dao dao = new Dao();
    Proveedor p = dao.buscarProveedorPorId(id);
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Editar Proveedor</title>

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
  background: var(--amber);
  border-radius: 0 4px 4px 0;
  transition: height .3s ease;
}

.nav-item:hover {
  background: var(--bg-hover);
  transform: translateX(4px) scale(1.08);
}

.nav-item.active {
  background: var(--amber-dim);
  transform: translateX(4px);
}

.nav-item.active::before {
  height: 100%;
}

.nav-item.active svg {
  stroke: var(--amber);
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
  display: flex;
  justify-content: center;
  align-items: flex-start;
  animation: fadeIn .5s ease;
}

@keyframes fadeIn {
  from { opacity:0; transform:translateY(6px); }
  to   { opacity:1; transform:translateY(0); }
}

.form-container {
  width: 100%;
  max-width: 600px;
  margin-top: 20px;
}

.form-card {
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

.form-header {
  background: linear-gradient(135deg, var(--amber), var(--rose));
  padding: 24px;
  text-align: center;
}

.form-header h2 {
  font-family: 'Syne', sans-serif;
  font-weight: 800;
  font-size: 24px;
  color: var(--bg-deep);
  margin: 0;
}

/* Cuerpo del formulario */
.form-body {
  padding: 32px;
}

.form-group {
  margin-bottom: 24px;
}

.form-group label {
  display: block;
  font-size: 12px;
  font-weight: 500;
  color: var(--text-2);
  margin-bottom: 8px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.form-control {
  width: 100%;
  padding: 12px 16px;
  background: var(--bg-accent);
  border: 1px solid var(--border);
  border-radius: var(--r-sm);
  color: var(--text-1);
  font-size: 14px;
  font-family: inherit;
  transition: all 0.3s ease;
}

.form-control:focus {
  outline: none;
  border-color: var(--amber);
  background: var(--bg-hover);
  box-shadow: 0 0 0 3px var(--amber-dim);
}

.form-control::placeholder {
  color: var(--text-3);
}

.input-with-icon {
  position: relative;
}

.input-with-icon svg {
  position: absolute;
  left: 14px;
  top: 50%;
  transform: translateY(-50%);
  width: 18px;
  height: 18px;
  stroke: var(--text-3);
  fill: none;
  stroke-width: 2;
  transition: stroke 0.3s;
  pointer-events: none;
}

.input-with-icon .form-control {
  padding-left: 44px;
}

.input-with-icon .form-control:focus + svg {
  stroke: var(--amber);
}

.form-actions {
  display: flex;
  gap: 12px;
  justify-content: center;
  margin-top: 32px;
}

.btn {
  padding: 12px 24px;
  border-radius: var(--r-sm);
  font-size: 14px;
  font-weight: 600;
  font-family: 'Syne', sans-serif;
  cursor: pointer;
  border: none;
  transition: all .3s ease;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  text-decoration: none;
}

.btn-primary {
  background: linear-gradient(135deg, var(--amber), var(--rose));
  color: var(--bg-deep);
  position: relative;
  overflow: hidden;
}

.btn-primary::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 0;
  height: 0;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.3);
  transform: translate(-50%, -50%);
  transition: width 0.6s, height 0.6s;
}

.btn-primary:hover::before {
  width: 300px;
  height: 300px;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(46, 204, 113, 0.3);
}

.btn-secondary {
  background: var(--bg-accent);
  color: var(--text-2);
  border: 1px solid var(--border);
}

.btn-secondary:hover {
  background: var(--bg-hover);
  color: var(--text-1);
  border-color: var(--amber);
}

.helper-text {
  font-size: 12px;
  color: var(--text-3);
  margin-top: 6px;
}

::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: var(--border); border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: var(--text-3); }

@media (max-width: 768px) {
  .main {
    padding: 20px;
  }
  
  .form-body {
    padding: 24px;
  }
  
  .form-actions {
    flex-direction: column;
  }
  
  .btn {
    width: 100%;
    justify-content: center;
  }
}
</style>
</head>

<body>

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

  <a href="listadoProveedor.jsp" class="nav-item active">
    <svg viewBox="0 0 24 24"><path d="M12 2L2 7l10 5 10-5-10-5z"/><path d="M2 17l10 5 10-5"/><path d="M2 12l10 5 10-5"/></svg>
  </a>
  
  <a href="listadoCliente.jsp" class="nav-item">
    <svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
  </a>

  <a href="listadoVentas.jsp" class="nav-item">
    <svg viewBox="0 0 24 24"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
  </a>
  
  <a href="notificaciones.jsp" class="nav-item">
    <svg viewBox="0 0 24 24"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
    <span class="badge"></span>
  </a>

  <div class="sidebar-bottom">
    <div class="avatar">R</div>
  </div>
</aside>
<main class="main">
<div>
	<div class="form-container">
	<div class="form-card">
		<div class="form-header">
			<h2>Editar Proveedor</h2>
		</div>
	
	<div class="form-body">
	<form action="Gestionar" method="post">
	 <input type="hidden" name="accion" value="ActualizarProveedor">
     <input type="hidden" name="id" value="<%= p.getId_proveedor()%>">
     
          <div class="form-group">
            <label for="nombre">Nombre del Proveedor</label>
            <div class="input-with-icon">
              <input 
                type="text" 
                id="nombre"
                name="nombre" 
                class="form-control" 
                value="<%= p.getNombre() %>"
                required
                autofocus
              >
              <svg fill="#000000" viewBox="0 0 32 32" id="icon" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
              <g id="SVGRepo_iconCarrier"><defs><style>.cls-1{fill:none;}</style></defs><title>enterprise</title><rect x="8" y="8" width="2" height="4"></rect><rect x="8" y="14" width="2" height="4"></rect>
              <rect x="14" y="8" width="2" height="4"></rect><rect x="14" y="14" width="2" height="4"></rect><rect x="8" y="20" width="2" height="4"></rect><rect x="14" y="20" width="2" height="4"></rect>
              <path d="M30,14a2,2,0,0,0-2-2H22V4a2,2,0,0,0-2-2H4A2,2,0,0,0,2,4V30H30ZM4,4H20V28H4ZM22,28V14h6V28Z"></path><rect id="_Transparent_Rectangle_" data-name="&lt;Transparent Rectangle&gt;" class="cls-1" width="32" height="32"></rect></g></svg>
            </div>
          </div>

          <div class="form-group">
            <label for="precio">RUC</label>
            <div class="input-with-icon">
              <input 
                type="text" 
                id="ruc"
                name="ruc" 
                class="form-control"
                value="<%= p.getRuc() %>"
                required
              >
                 <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
  <rect x="3" y="3" width="18" height="18" rx="2"/>
  <path d="M3 9h18"/>
  <path d="M9 3v18"/>
  <path d="M7 13h4"/>
  <path d="M7 16h2"/>
  <path d="M13 13h4"/>
  <path d="M13 16h4"/>
</svg>
            </div>
            <div class="helper-text">Edite el RUC</div>
          </div>

          <div class="form-group">
            <label for="stock">Teléfono del Proveedor</label>
            <div class="input-with-icon">
              <input 
                type="text" 
                id="telefono"
                name="telefono" 
                class="form-control"
                value="<%= p.getTelefono() %>"
                required
              >
              <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
                <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
              </svg>
            </div>
            <div class="helper-text">Editar telefono del Proveedor</div>
          </div>
     
       <div class="form-actions">
            <button type="submit" class="btn btn-primary">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" style="width:18px;height:18px">
                <polyline points="20 6 9 17 4 12"/>
              </svg>
              Guardar Proveedor
            </button>
            <a href="listadoProveedor.jsp" class="btn btn-secondary">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" style="width:18px;height:18px">
                <line x1="18" y1="6" x2="6" y2="18"/>
                <line x1="6" y1="6" x2="18" y2="18"/>
              </svg>
              Cancelar
            </a>
          </div>
     
	</form>
	</div>
	
	</div>
	</div>
</div>
</main>

</body>
</html>
