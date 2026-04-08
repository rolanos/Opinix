import React from 'react';
import { useAuth } from '../contexts/AuthContext';
import { Link } from 'react-router-dom';
import '../styles/components/Header.css';

export default function Header({ onToggleSidebar }) {
  const { user, logout } = useAuth();

  return (
    <>
      <header className="app-header-bar">
        <div className="app-header-inner">
          <div style={{display: 'flex', alignItems: 'center', gap: 8}}>
            <button className="hamburger-btn" onClick={onToggleSidebar} aria-label="toggle sidebar">
              ☰
            </button>
            <Link to="/" className="app-title" aria-label="home">Opinix</Link>
          </div>
          <div className="auth-section">
            {user ? (
              <div className="user-info">
                <span>Привет, {user.name || user.email}</span>
                <button onClick={logout} className="logout-btn">Выйти</button>
              </div>
            ) : (
              <div className="auth-buttons">
                <Link to="/login" className="auth-link">Войти</Link>
                <Link to="/register" className="auth-link">Зарегистрироваться</Link>
              </div>
            )}
          </div>
        </div>
      </header>
      {/* overlay menu removed per request */}
    </>
  );
}
