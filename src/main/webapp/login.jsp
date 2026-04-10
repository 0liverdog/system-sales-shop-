<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login </title>
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

* { 
  margin: 0; 
  padding: 0; 
  box-sizing: border-box; 
}

body {
  font-family: 'DM Sans', sans-serif;
  background: var(--bg-deep);
  color: var(--text-1);
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
}

body::before {
  content: '';
  position: absolute;
  width: 600px;
  height: 600px;
  background: radial-gradient(circle, var(--cyan-dim), transparent);
  top: -300px;
  right: -200px;
  border-radius: 50%;
  animation: float1 8s ease-in-out infinite;
  z-index: 0;
}

body::after {
  content: '';
  position: absolute;
  width: 400px;
  height: 400px;
  background: radial-gradient(circle, var(--violet-dim), transparent);
  bottom: -200px;
  left: -100px;
  border-radius: 50%;
  animation: float2 10s ease-in-out infinite;
  z-index: 0;
}

@keyframes float1 {
  0%, 100% { transform: translate(0, 0) scale(1); }
  50% { transform: translate(-50px, 50px) scale(1.1); }
}

@keyframes float2 {
  0%, 100% { transform: translate(0, 0) scale(1); }
  50% { transform: translate(50px, -30px) scale(1.15); }
}

.login-container {
  position: relative;
  z-index: 10;
  animation: slideIn 0.6s cubic-bezier(.22,.68,0,1.2);
}

@keyframes slideIn {
  from { 
    opacity: 0; 
    transform: translateY(30px) scale(0.95); 
  }
  to { 
    opacity: 1; 
    transform: translateY(0) scale(1); 
  }
}

.login-box {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: var(--r);
  padding: 40px;
  width: 420px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
  position: relative;
  overflow: hidden;
}

.login-box::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, var(--cyan), var(--violet));
}

.logo {
  width: 56px;
  height: 56px;
  background: linear-gradient(135deg, var(--cyan), var(--violet));
  border-radius: 14px;
  margin: 0 auto 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  animation: logoRotate 1s ease-out;
}

@keyframes logoRotate {
  from { transform: rotate(-180deg) scale(0); }
  to { transform: rotate(0deg) scale(1); }
}

.logo svg {
  width: 28px;
  height: 28px;
}

.login-header {
  text-align: center;
  margin-bottom: 32px;
}

.login-header h2 {
  font-family: 'Syne', sans-serif;
  font-weight: 800;
  font-size: 26px;
  letter-spacing: -0.5px;
  margin-bottom: 8px;
  background: linear-gradient(135deg, var(--cyan), var(--violet));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.login-header p {
  color: var(--text-3);
  font-size: 13px;
  font-weight: 300;
}

.error {
  background: var(--rose-dim);
  border: 1px solid var(--rose);
  border-radius: var(--r-sm);
  padding: 12px 16px;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 10px;
  animation: shake 0.5s ease;
}

@keyframes shake {
  0%, 100% { transform: translateX(0); }
  25% { transform: translateX(-8px); }
  75% { transform: translateX(8px); }
}

.error svg {
  width: 18px;
  height: 18px;
  stroke: var(--rose);
  fill: none;
  stroke-width: 2;
  flex-shrink: 0;
}

.error span {
  color: var(--rose);
  font-size: 13px;
  font-weight: 500;
}

.form-group {
  margin-bottom: 20px;
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

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}

.input-wrapper svg {
  position: absolute;
  left: 14px;
  width: 18px;
  height: 18px;
  stroke: var(--text-3);
  fill: none;
  stroke-width: 2;
  transition: stroke 0.3s;
}

.input-wrapper input {
  width: 100%;
  padding: 12px 16px 12px 44px;
  background: var(--bg-accent);
  border: 1px solid var(--border);
  border-radius: var(--r-sm);
  color: var(--text-1);
  font-size: 14px;
  font-family: inherit;
  transition: all 0.3s ease;
}

.input-wrapper input:focus {
  outline: none;
  border-color: var(--cyan);
  background: var(--bg-hover);
  box-shadow: 0 0 0 3px var(--cyan-dim);
}

.input-wrapper input:focus + svg,
.input-wrapper:focus-within svg {
  stroke: var(--cyan);
}

.input-wrapper input::placeholder {
  color: var(--text-3);
}

.btn-login {
  width: 100%;
  padding: 14px;
  background: linear-gradient(135deg, var(--cyan), var(--violet));
  border: none;
  border-radius: var(--r-sm);
  color: var(--bg-deep);
  font-size: 15px;
  font-weight: 600;
  font-family: 'Syne', sans-serif;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.btn-login::before {
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

.btn-login:hover::before {
  width: 300px;
  height: 300px;
}

.btn-login:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(0, 229, 255, 0.3);
}

.btn-login:active {
  transform: translateY(0);
}

.login-footer {
  margin-top: 24px;
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid var(--border);
}

.login-footer p {
  color: var(--text-3);
  font-size: 12px;
  font-weight: 300;
}

.login-footer .brand {
  color: var(--cyan);
  font-weight: 600;
}

@media (max-width: 500px) {
  .login-box {
    width: 90%;
    padding: 30px 24px;
  }
  
  .login-header h2 {
    font-size: 22px;
  }
}
</style>

</head>
<body>

<div class="login-container">
  <div class="login-box">
    
    <div class="logo">
      <svg viewBox="0 0 24 24" fill="none" stroke="#0a0c0f" stroke-width="2.5" stroke-linecap="round">
        <rect x="3" y="3" width="7" height="7" rx="1.5"/>
        <rect x="14" y="3" width="7" height="7" rx="1.5"/>
        <rect x="3" y="14" width="7" height="7" rx="1.5"/>
        <rect x="14" y="14" width="7" height="7" rx="1.5"/>
      </svg>
    </div>

    <div class="login-header">
      <h2>Bienvenido</h2>
      <p>Ingresa tus credenciales para continuar</p>
    </div>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="error">
      <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="12" cy="12" r="10"/>
        <line x1="12" y1="8" x2="12" y2="12"/>
        <line x1="12" y1="16" x2="12.01" y2="16"/>
      </svg>
      <span><%= error %></span>
    </div>
    <%
        }
    %>

    <form action="Login" method="post">
      
      <div class="form-group">
        <label for="username">Usuario</label>
        <div class="input-wrapper">
          <input 
            type="text" 
            id="username" 
            name="username" 
            placeholder="Ingresa tu usuario" 
            required
            autofocus
          >
          <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
            <circle cx="12" cy="7" r="4"/>
          </svg>
        </div>
      </div>

      <div class="form-group">
        <label for="password">Contraseña</label>
        <div class="input-wrapper">
          <input 
            type="password" 
            id="password" 
            name="password" 
            placeholder="Ingresa tu contraseña" 
            required
          >
          <svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round">
            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
            <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
          </svg>
        </div>
      </div>

      <button type="submit" class="btn-login">
        Iniciar Sesión
      </button>

    </form>

    <div class="login-footer">
      <p>Sistema de Gestión de Ventas<span class="brand"></span></p>
    </div>

  </div>
</div>

</body>
</html>