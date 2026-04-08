import React, { useState } from 'react';
import http from '../api/http';
import { useNavigate } from 'react-router-dom';
import Notification from '../components/Notification';
import '../styles/pages/OldLogin.css';

export default function Login() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  async function handleSubmit(e) {
    e.preventDefault();
    setError('');
    try {
      await http.post('/auth/login', { email, password })
        .then(res => console.log('Ответ сервера:', res.data))
        .catch(err => console.error('Ошибка запроса:', err));
      navigate('/confirm', { state: { email } });
    } catch {
      setError('Произошла ошибка');
    }
  }

  return (
    <>
      {/* Белая шапка с логотипом */}
      <header className="login-header">Opinix</header>

      {/* Центрированная форма */}
      <div className="login-wrapper">
        <form className="login-card" onSubmit={handleSubmit}>
          <h1 className="login-title">Вход в аккаунт</h1>

          <input
            type="email"
            placeholder="Email"
            value={email}
            onChange={e => setEmail(e.target.value)}
            className="login-field"
            required
          />

          <input
            type="password"
            placeholder="Пароль"
            value={password}
            onChange={e => setPassword(e.target.value)}
            className="login-field"
            required
          />

          <button type="submit" className="login-button">
            Войти
          </button>
        </form>
      </div>

      <Notification message={error} />
    </>
  );
}
