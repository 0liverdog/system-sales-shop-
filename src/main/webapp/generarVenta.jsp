<%@ page import="java.util.List, Entidades.Cliente, Entidades.Producto, Dao.Dao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Generar Venta</title>
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

.form-container {
  max-width: 1000px;
  margin: 0 auto;
}

.page-title {
  font-family: 'Syne', sans-serif;
  font-weight: 800;
  font-size: 32px;
  color: var(--text-1);
  margin-bottom: 32px;
  text-align: center;
  background: linear-gradient(135deg, var(--emerald), var(--cyan));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.form-card {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: var(--r);
  overflow: hidden;
  animation: slideUp .6s cubic-bezier(.22,.68,0,1.2);
  margin-bottom: 24px;
}

@keyframes slideUp {
  from { opacity:0; transform:translateY(30px); }
  to   { opacity:1; transform:translateY(0); }
}

.section-header {
  background: linear-gradient(135deg, var(--emerald), var(--cyan));
  padding: 16px 24px;
  font-family: 'Syne', sans-serif;
  font-weight: 700;
  font-size: 16px;
  color: var(--bg-deep);
  display: flex;
  align-items: center;
  gap: 10px;
}

.section-header svg {
  width: 20px;
  height: 20px;
  stroke: var(--bg-deep);
}

.form-body {
  padding: 24px;
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

.form-select,
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

.form-select:focus,
.form-control:focus {
  outline: none;
  border-color: var(--emerald);
  background: var(--bg-hover);
  box-shadow: 0 0 0 3px var(--emerald-dim);
}

.form-select option {
  background: var(--bg-card);
  color: var(--text-1);
}

.products-table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  margin-top: 16px;
}

.products-table thead {
  background: var(--bg-accent);
}

.products-table thead th {
  padding: 14px 16px;
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  color: var(--text-2);
  text-align: center;
  border-bottom: 2px solid var(--border);
}

.products-table thead th:first-child {
  border-radius: var(--r-sm) 0 0 0;
}

.products-table thead th:last-child {
  border-radius: 0 var(--r-sm) 0 0;
}

.products-table tbody tr {
  transition: background 0.2s ease;
}

.products-table tbody tr:hover {
  background: var(--bg-hover);
}

.products-table tbody td {
  padding: 14px 16px;
  border-bottom: 1px solid var(--border);
  text-align: center;
  color: var(--text-1);
  font-size: 14px;
}

.products-table tbody tr:last-child td:first-child {
  border-radius: 0 0 0 var(--r-sm);
}

.products-table tbody tr:last-child td:last-child {
  border-radius: 0 0 var(--r-sm) 0;
}

.stock-badge {
  display: inline-block;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: 600;
}

.stock-high {
  background: var(--emerald-dim);
  color: var(--emerald);
}

.stock-medium {
  background: var(--amber-dim);
  color: var(--amber);
}

.stock-low {
  background: var(--rose-dim);
  color: var(--rose);
}

.products-table input[type="number"] {
  max-width: 100px;
  margin: 0 auto;
  text-align: center;
  padding: 8px;
}

.form-actions {
  display: flex;
  gap: 12px;
  justify-content: center;
  margin-top: 32px;
}

.btn {
  padding: 12px 32px;
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
  background: linear-gradient(135deg, var(--emerald), var(--cyan));
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
  border-color: var(--emerald);
}

::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: var(--border); border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: var(--text-3); }

@media (max-width: 768px) {
  .main {
    padding: 20px;
  }
  
  .products-table {
    font-size: 12px;
  }
  
  .products-table thead th,
  .products-table tbody td {
    padding: 10px 8px;
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

<%
Dao dao = new Dao();
List<Cliente> clientes = dao.listarClientePorEstado(1);
List<Producto> productos = dao.listarProductoPorEstado(1);
%>

<!-- ═══ SIDEBAR ═══ -->
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
    <div class="avatar">R</div>
  </div>
</aside>

<main class="main">
  
  <div class="form-container">
    
    <h1 class="page-title">Generar Nueva Venta</h1>

    <form action="GenerarVentas" method="post">

        <div class="form-card">
          <div class="section-header">
            <svg viewBox="0 0 24 24" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
              <circle cx="9" cy="7" r="4"/>
            </svg>
            Seleccionar Cliente
          </div>
          
          <div class="form-body">
            <div class="form-group">
              <label for="idCliente">Cliente</label>
              <select name="idCliente" id="idCliente" class="form-select" required>
                <option value="">Seleccione un cliente</option>
                <% for (Cliente c : clientes) { %>
                    <option value="<%=c.getId_cliente()%>">
                        <%=c.getNombre()%> - DNI: <%=c.getDni()%>
                    </option>
                <% } %>
              </select>
            </div>
          </div>
        </div>

        <div class="form-card">
          <div class="section-header">
            <svg viewBox="0 0 24 24" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/>
              <line x1="3" y1="6" x2="21" y2="6"/>
              <path d="M16 10a4 4 0 0 1-8 0"/>
            </svg>
            Productos a Vender
          </div>
          
          <div class="form-body">
            <table class="products-table">
              <thead>
                <tr>
                  <th>Producto</th>
                  <th>Precio</th>
                  <th>Stock Disponible</th>
                  <th>Cantidad</th>
                </tr>
              </thead>
              <tbody>
                <% for (Producto p : productos) { 
                   String stockClass = p.getStock() > 20 ? "stock-high" : 
                                       p.getStock() > 10 ? "stock-medium" : "stock-low";
                %>
                <tr>
                  <td style="text-align: left;">
                    <%= p.getNombre() %>
                    <input type="hidden" name="idProducto" value="<%=p.getId_producto()%>">
                  </td>
                  <td style="font-weight: 600; color: var(--emerald);">
                    S/ <%= String.format("%.2f", p.getPrecio()) %>
                  </td>
                  <td>
                    <span class="stock-badge <%=stockClass%>">
                      <%= p.getStock() %> und.
                    </span>
                  </td>
                  <td>
                    <input type="number"
                           name="cantidad"
                           class="form-control"
                           min="0"
                           max="<%=p.getStock()%>"
                           value="0"
                           placeholder="0">
                  </td>
                </tr>
                <% } %>
              </tbody>
            </table>
          </div>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-primary">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" style="width:18px;height:18px">
              <polyline points="20 6 9 17 4 12"/>
            </svg>
            Generar Venta
          </button>
          <a href="listadoVentas.jsp" class="btn btn-secondary">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" style="width:18px;height:18px">
              <line x1="18" y1="6" x2="6" y2="18"/>
              <line x1="6" y1="6" x2="18" y2="18"/>
            </svg>
            Cancelar
          </a>
        </div>

    </form>

  </div>

</main>

</body>
</html>