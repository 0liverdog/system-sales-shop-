<%@ page import="java.util.List, Entidades.*, Dao.Dao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Admin Dashboard</title>
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

body {
  font-family: 'DM Sans', sans-serif;
  background: var(--bg-deep);
  color: var(--text-1);
  min-height: 100vh;
  display: flex;
  overflow: hidden;
}

.sidebar {
  width: 80px;
  min-height: 100vh;
  background: var(--bg-card);
  border-right: 1px solid var(--border);
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 28px 0;
  gap: 6px;
  flex-shrink: 0;
}

.sidebar-logo {
  width: 42px; height: 42px;
  background: linear-gradient(135deg, var(--cyan), var(--violet));
  border-radius: 12px;
  margin-bottom: 32px;
  display: flex; align-items: center; justify-content: center;
  cursor: pointer;
  transition: transform .3s ease, box-shadow .3s ease;
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

.nav-item:active {
  transform: translateX(4px) scale(0.95);
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

.avatar:active {
  transform: scale(0.95);
}

.main {
  flex:1;
  overflow-y:auto;
  padding:32px 36px;
  display:flex;
  flex-direction:column;
  gap:24px;
  animation: fadeIn .5s ease;
}
@keyframes fadeIn {
  from { opacity:0; transform:translateY(6px); }
  to   { opacity:1; transform:translateY(0); }
}

.header {
  display:flex; align-items:center; justify-content:space-between;
}
.header h1 {
  font-family:'Syne',sans-serif;
  font-weight:800; font-size:26px; letter-spacing:-.5px;
}
.header p { color:var(--text-3); font-size:13px; margin-top:3px; font-weight:300; }

.header-right { display:flex; align-items:center; gap:14px; }

.search-box {
  display:flex; align-items:center; gap:8px;
  background:var(--bg-card); border:1px solid var(--border);
  border-radius:var(--r-sm); padding:8px 14px; width:220px;
  transition: border-color .2s;
}
.search-box:focus-within { border-color: var(--cyan); }
.search-box svg { width:15px; height:15px; stroke:var(--text-3); fill:none; stroke-width:2; flex-shrink:0; }
.search-box input {
  background:none; border:none; outline:none;
  color:var(--text-1); font-size:13px; font-family:inherit; width:100%;
}
.search-box input::placeholder { color:var(--text-3); }

.notif-btn {
  width:38px; height:38px; border-radius:var(--r-sm);
  background:var(--bg-card); border:1px solid var(--border);
  display:flex; align-items:center; justify-content:center;
  cursor:pointer; position:relative; transition:background .2s;
}
.notif-btn:hover { background:var(--bg-hover); }
.notif-btn svg { width:18px; height:18px; stroke:var(--text-2); fill:none; stroke-width:1.8; }
.notif-btn .dot {
  position:absolute; top:7px; right:7px;
  width:7px; height:7px; background:var(--rose);
  border-radius:50%; border:1.5px solid var(--bg-deep);
}

.kpi-grid {
  display:grid;
  grid-template-columns: repeat(4,1fr);
  gap:18px;
}

.kpi-card {
  background:var(--bg-card);
  border:1px solid var(--border);
  border-radius:var(--r);
  padding:22px 22px 18px;
  position:relative; overflow:hidden;
  transition: border-color .25s, transform .2s;
  animation: slideUp .5s cubic-bezier(.22,.68,0,1.2) both;
}
.kpi-card:hover { border-color:var(--cyan); transform:translateY(-2px); }

.kpi-card:nth-child(1) { animation-delay:.05s; }
.kpi-card:nth-child(2) { animation-delay:.10s; }
.kpi-card:nth-child(3) { animation-delay:.15s; }
.kpi-card:nth-child(4) { animation-delay:.20s; }

@keyframes slideUp {
  from { opacity:0; transform:translateY(18px); }
  to   { opacity:1; transform:translateY(0); }
}

.kpi-card::before {
  content:''; position:absolute;
  top:0; left:0; right:0; height:3px;
}
.kpi-card.c-cyan::before      { background:var(--cyan); }
.kpi-card.c-emerald::before   { background:var(--emerald); }
.kpi-card.c-rose::before      { background:var(--rose); }
.kpi-card.c-amber::before     { background:var(--amber); }

.kpi-top {
  display:flex; align-items:center; justify-content:space-between;
  margin-bottom:14px;
}

.kpi-icon {
  width:40px; height:40px; border-radius:10px;
  display:flex; align-items:center; justify-content:center;
}
.kpi-icon svg { width:20px; height:20px; fill:none; stroke-width:1.8; stroke-linecap:round; stroke-linejoin:round; }

.kpi-icon.c-cyan      { background:var(--cyan-dim); }
.kpi-icon.c-cyan svg  { stroke:var(--cyan); }
.kpi-icon.c-emerald      { background:var(--emerald-dim); }
.kpi-icon.c-emerald svg  { stroke:var(--emerald); }
.kpi-icon.c-rose      { background:var(--rose-dim); }
.kpi-icon.c-rose svg  { stroke:var(--rose); }
.kpi-icon.c-amber      { background:var(--amber-dim); }
.kpi-icon.c-amber svg  { stroke:var(--amber); }

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

.panel {
  background:var(--bg-card);
  border:1px solid var(--border);
  border-radius:var(--r);
  padding:22px;
}
.panel-header {
  display:flex; align-items:center; justify-content:space-between;
  margin-bottom:20px;
}
.panel-header h2 {
  font-family:'Syne',sans-serif;
  font-weight:700; font-size:15px; letter-spacing:-.3px;
}
.panel-header .tag {
  font-size:11px; background:var(--cyan-dim); color:var(--cyan);
  padding:4px 10px; border-radius:20px; font-weight:500;
}

.charts-grid {
  display: grid;
  grid-template-columns: 1.4fr 1fr;
  gap: 18px;
  align-items: start;
}

.vertical-bar-chart {
  display: flex;
  align-items: flex-end;
  justify-content: space-around;
  height: 280px;
  gap: 12px;
  padding: 0 8px;
  position: relative;
}

.vertical-bar-chart::before {
  content: '';
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  height: 100%;
  background: 
    linear-gradient(to top, var(--border) 1px, transparent 1px),
    linear-gradient(to top, transparent calc(25% - 1px), var(--border) 25%, transparent calc(25% + 1px)),
    linear-gradient(to top, transparent calc(50% - 1px), var(--border) 50%, transparent calc(50% + 1px)),
    linear-gradient(to top, transparent calc(75% - 1px), var(--border) 75%, transparent calc(75% + 1px));
  pointer-events: none;
  opacity: 0.3;
}

.bar-column {
  flex: 1;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  position: relative;
  z-index: 1;
  justify-content: flex-end;
}


.bar-vertical {
  width: 100%;
  max-width: 60px;
  background: var(--bg-accent);
  border-radius: 8px 8px 0 0;
  position: relative;
  transition: all 0.3s ease;
  cursor: pointer;
}

.bar-vertical:hover {
  transform: translateY(-4px);
  filter: brightness(1.2);
}

.bar-vertical::after {
  content: attr(data-value);
  position: absolute;
  top: -28px;
  left: 50%;
  transform: translateX(-50%);
  font-size: 12px;
  font-weight: 600;
  color: var(--text-1);
  white-space: nowrap;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.bar-vertical:hover::after {
  opacity: 1;
}

.bar-label-vertical {
  font-size: 11px;
  color: var(--text-3);
  font-weight: 500;
  text-align: center;
}

.bar-v-1 { background: linear-gradient(to top, var(--cyan), #00b8d4); }
.bar-v-2 { background: linear-gradient(to top, var(--violet), #8b5cf6); }
.bar-v-3 { background: linear-gradient(to top, var(--emerald), #27ae60); }
.bar-v-4 { background: linear-gradient(to top, var(--amber), #f39c12); }
.bar-v-5 { background: linear-gradient(to top, var(--rose), #e74c3c); }
.bar-v-6 { background: linear-gradient(to top, #3498db, #2980b9); }
.bar-v-7 { background: linear-gradient(to top, var(--cyan), #00b8d4); }
.bar-v-8 { background: linear-gradient(to top, var(--violet), #8b5cf6); }
.bar-v-9 { background: linear-gradient(to top, var(--emerald), #27ae60); }
.bar-v-10 { background: linear-gradient(to top, var(--amber), #f39c12); }
.bar-v-11 { background: linear-gradient(to top, var(--rose), #e74c3c); }
.bar-v-12 { background: linear-gradient(to top, #3498db, #2980b9); }

@keyframes growUp {
  from {
    height: 0;
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.bar-column:nth-child(1) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 0.1s both; }
.bar-column:nth-child(2) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 0.2s both; }
.bar-column:nth-child(3) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 0.3s both; }
.bar-column:nth-child(4) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 0.4s both; }
.bar-column:nth-child(5) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 0.5s both; }
.bar-column:nth-child(6) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 0.6s both; }
.bar-column:nth-child(7) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 0.7s both; }
.bar-column:nth-child(8) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 0.8s both; }
.bar-column:nth-child(9) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 0.9s both; }
.bar-column:nth-child(10) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 1.0s both; }
.bar-column:nth-child(11) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 1.1s both; }
.bar-column:nth-child(12) .bar-vertical { animation: growUp 0.8s cubic-bezier(0.22, 0.68, 0, 1.2) 1.2s both; }

.pie-chart-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 24px;
}

.pie-chart {
  width: 220px;
  height: 220px;
  border-radius: 50%;
  position: relative;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
  animation: pieRotate 1s cubic-bezier(0.22, 0.68, 0, 1.2) forwards;
  transform: rotate(-90deg);
}

@keyframes pieRotate {
  from { transform: rotate(-90deg) scale(0.8); opacity: 0; }
  to { transform: rotate(-90deg) scale(1); opacity: 1; }
}

.pie-chart::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100px;
  height: 100px;
  background: var(--bg-card);
  border-radius: 50%;
  box-shadow: 0 0 0 8px var(--bg-accent);
}

.pie-legend {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
  width: 100%;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 8px;
}

.legend-color {
  width: 12px;
  height: 12px;
  border-radius: 3px;
  flex-shrink: 0;
}

.legend-text {
  font-size: 12px;
  color: var(--text-2);
  font-weight: 400;
}

.legend-value {
  font-size: 11px;
  color: var(--text-3);
  font-weight: 600;
  margin-left: auto;
}

.legend-color-bebidas { background: var(--cyan); }
.legend-color-comidas { background: var(--emerald); }
.legend-color-golosinas { background: var(--amber); }
.legend-color-panaderia { background: var(--violet); }
.legend-color-snacks { background: var(--rose); }
.legend-color-lacteos { background: #3498db; }
.legend-color-abarrotes { background: var(--text-3); }

::-webkit-scrollbar       { width:6px; }
::-webkit-scrollbar-track { background:transparent; }
::-webkit-scrollbar-thumb { background:var(--border); border-radius:3px; }
::-webkit-scrollbar-thumb:hover { background:var(--text-3); }

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

List<Dao.VentaMes> ventasMes = dao.obtenerVentasPorMes();
List<Dao.VentaCategoria> ventasPorCategoria = dao.obtenerVentasPorCategoria();

StringBuilder conicGradient = new StringBuilder();
if (ventasPorCategoria != null && !ventasPorCategoria.isEmpty()) {
    for (int i = 0; i < ventasPorCategoria.size(); i++) {
        Dao.VentaCategoria cat = ventasPorCategoria.get(i);
        String color = Dao.obtenerColorCategoria(cat.getNombre());
        
        conicGradient.append(color)
                     .append(" ")
                     .append(String.format("%.1f", cat.getAnguloInicio()))
                     .append("deg ")
                     .append(String.format("%.1f", cat.getAnguloFin()))
                     .append("deg");
        
        if (i < ventasPorCategoria.size() - 1) {
            conicGradient.append(", ");
        }
    }
} else {
    conicGradient.append("var(--cyan) 0deg 51.4deg, ")
                 .append("var(--emerald) 51.4deg 115.2deg, ")
                 .append("var(--amber) 115.2deg 194.4deg, ")
                 .append("var(--violet) 194.4deg 259.2deg, ")
                 .append("var(--rose) 259.2deg 309.6deg, ")
                 .append("#3498db 309.6deg 338.4deg, ")
                 .append("var(--text-3) 338.4deg 360deg");
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

  <a href="listadoVentas.jsp" class="nav-item">
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

  <div class="header">
    <div>
      <h1>Dashboard</h1>
      <p>Bienvenido de vuelta. Aqui tienes un resumen de hoy.</p>
    </div>
    <div class="header-right">
      <div class="search-box">
        <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" placeholder="Buscar..." />
      </div>
      <div class="notif-btn">
      	<a href="notificaciones.jsp">
        <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
        <span class="dot"></span></a>
      </div>
    </div>
  </div>

  <div class="kpi-grid">

<form action="Gestionar" method="post" style="display:inline;">
  <input type="hidden" name="accion" value="Producto">
    <div class="kpi-card c-cyan" style="cursor:pointer;" onclick="this.closest('form').submit();">
      <div class="kpi-top">
        <div class="kpi-icon c-cyan">
           <svg viewBox="0 0 24 24"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
        </div>
        <span class="kpi-change up">
          <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 4l-8 8h16z"/></svg> 12.5%
        </span>
      </div>
      <div class="kpi-value">Productos</div>
      <div class="kpi-label"></div>
    </div>
</form>


<form action="Gestionar" method="post" style="display:inline;">
  <input type="hidden" name="accion" value="Proveedor">
    <div class="kpi-card c-amber" style="cursor:pointer;" onclick="this.closest('form').submit();">
      <div class="kpi-top">
        <div class="kpi-icon c-amber">
          <svg viewBox="0 0 24 24"><path d="M12 2L2 7l10 5 10-5-10-5z"/><path d="M2 17l10 5 10-5"/><path d="M2 12l10 5 10-5"/></svg>
        </div>
        <span class="kpi-change up">
          <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 4l-8 8h16z"/></svg> 8.2%
        </span>
      </div>
      <div class="kpi-value">Proveedor</div>
      <div class="kpi-label"></div>
    </div>
</form>
    

<form action="Gestionar" method="post" style="display:inline;">
  <input type="hidden" name="accion" value="Cliente">
  <div class="kpi-card c-rose" style="cursor:pointer;" onclick="this.closest('form').submit();">
    <div class="kpi-top">
      <div class="kpi-icon c-rose">
        <svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
      </div>
      <span class="kpi-change up">
        <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 4l-8 8h16z"/></svg> 3.1%
      </span>
    </div>
    <div class="kpi-value">Cliente</div>
    <div class="kpi-label"></div>
  </div>
</form>


<form action="Gestionar" method="post" style="display:inline;">
  <input type="hidden" name="accion" value="Venta">
    <div class="kpi-card c-emerald" style="cursor:pointer;" onclick="this.closest('form').submit();">
      <div class="kpi-top">
        <div class="kpi-icon c-emerald">
		<svg viewBox="0 0 24 24"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
        </div>
        <span class="kpi-change up">
          <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 4l-8 8h16z"/></svg> 5.7%
        </span>
      </div>
      <div class="kpi-value">Venta</div>
      <div class="kpi-label"></div>
    </div>
</form>
  </div>

  <div class="charts-grid">
    
    <div class="panel">
      <div class="panel-header">
        <h2>Ventas por Mes</h2>
        <span class="tag">2026</span>
      </div>
      <div class="vertical-bar-chart">
        
        <%
        if (ventasMes != null && !ventasMes.isEmpty()) {
            int barIndex = 1;
            for (Dao.VentaMes venta : ventasMes) {
        %>
        <div class="bar-column">
        
        <div class="bar-vertical bar-v-<%= barIndex %>" 
     style="height: <%= String.format(java.util.Locale.US, "%.1f", venta.getPorcentaje()) %>%;" 
     data-value="S/ <%= String.format("%.1f", venta.getTotal()) %>">
</div>


<div class="bar-label-vertical"><%= venta.getMes().trim() %></div>
</div>
        <%
                barIndex++;
            }
        } else {
        %>
          <div class="bar-column">
            <div class="bar-vertical bar-v-1" style="height: 85%;" data-value="S/ 12,450"></div>
            <div class="bar-label-vertical">Ene</div>
          </div>
          <div class="bar-column">
            <div class="bar-vertical bar-v-2" style="height: 65%;" data-value="S/ 9,320"></div>
            <div class="bar-label-vertical">Feb</div>
          </div>
          <div class="bar-column">
            <div class="bar-vertical bar-v-3" style="height: 92%;" data-value="S/ 13,890"></div>
            <div class="bar-label-vertical">Mar</div>
          </div>
          <div class="bar-column">
            <div class="bar-vertical bar-v-4" style="height: 78%;" data-value="S/ 11,200"></div>
            <div class="bar-label-vertical">Abr</div>
          </div>
          <div class="bar-column">
            <div class="bar-vertical bar-v-5" style="height: 58%;" data-value="S/ 8,560"></div>
            <div class="bar-label-vertical">May</div>
          </div>
          <div class="bar-column">
            <div class="bar-vertical bar-v-6" style="height: 70%;" data-value="S/ 10,340"></div>
            <div class="bar-label-vertical">Jun</div>
          </div>
        <% } %>

      </div>
    </div>

    <div class="panel">
      <div class="panel-header">
        <h2>Ventas por Categoría</h2>
        <span class="tag">Total</span>
      </div>
      <div class="pie-chart-container">
        
        <div class="pie-chart" style="background: conic-gradient(<%= conicGradient.toString() %>);">
        </div>
        
        <div class="pie-legend">
          <%
          if (ventasPorCategoria != null && !ventasPorCategoria.isEmpty()) {
              for (Dao.VentaCategoria cat : ventasPorCategoria) {
          %>
            <div class="legend-item">
              <div class="legend-color legend-color-<%= cat.getNombreLower() %>"></div>
              <div class="legend-text"><%= cat.getNombre() %></div>
              <div class="legend-value"><%= String.format("%.1f", cat.getPorcentaje()) %>%</div>
            </div>
          <%
              }
          } else {
          %>
            <div class="legend-item">
              <div class="legend-color legend-color-bebidas"></div>
              <div class="legend-text">Bebidas</div>
              <div class="legend-value">14.3%</div>
            </div>
            <div class="legend-item">
              <div class="legend-color legend-color-comidas"></div>
              <div class="legend-text">Comidas</div>
              <div class="legend-value">17.7%</div>
            </div>
            <div class="legend-item">
              <div class="legend-color legend-color-golosinas"></div>
              <div class="legend-text">Golosinas</div>
              <div class="legend-value">22%</div>
            </div>
            <div class="legend-item">
              <div class="legend-color legend-color-panaderia"></div>
              <div class="legend-text">Panadería</div>
              <div class="legend-value">18%</div>
            </div>
            <div class="legend-item">
              <div class="legend-color legend-color-snacks"></div>
              <div class="legend-text">Snacks</div>
              <div class="legend-value">14%</div>
            </div>
            <div class="legend-item">
              <div class="legend-color legend-color-lacteos"></div>
              <div class="legend-text">Lácteos</div>
              <div class="legend-value">8%</div>
            </div>
            <div class="legend-item">
              <div class="legend-color legend-color-abarrotes"></div>
              <div class="legend-text">Abarrotes</div>
              <div class="legend-value">6%</div>
            </div>
          <% } %>
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
