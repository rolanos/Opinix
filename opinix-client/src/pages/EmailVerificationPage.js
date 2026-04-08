import React, { useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import http, { setAccessToken } from '../api/http';
import Notification from '../components/Notification';

export default function ConfirmCode() {
  const [code, setCode] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();
  const { state } = useLocation();
  const email = state?.email;

  async function handleConfirm(e) {
    e.preventDefault();
    setError('');
    try {
      const res = await http.post('/auth/confirm_email', { email, code });
      const { accessToken, refreshToken } = res.data;
      localStorage.setItem('accessToken', accessToken);
      localStorage.setItem('refreshToken', refreshToken);
      setAccessToken(accessToken);
      navigate('/'); // после успешного подтверждения
    } catch {
      setError('Произошла ошибка');
    }
  }

  return (
    <div className="flex items-center justify-center min-h-screen bg-[var(--bg-light)]">
      <div className="absolute top-6 left-8 text-2xl font-bold tracking-wide">Opinix</div>

      <form
        onSubmit={handleConfirm}
        className="w-full max-w-sm bg-[var(--bg-white)] shadow-xl rounded-2xl p-8 flex flex-col items-center"
      >
        <h1 className="text-2xl font-medium mb-6">Введите код</h1>

        <input
          type="text"
          pattern="\d{6}"
          maxLength={6}
          value={code}
          onChange={e => setCode(e.target.value.replace(/\D/g, ''))}
          className="w-full border border-[var(--border-gray)] rounded-lg p-3 mb-6 text-center tracking-widest focus:outline-none focus:ring-2 focus:ring-black"
          required
        />

        <button
          type="submit"
          className="w-full bg-black text-white rounded-lg py-3 text-lg transition hover:bg-gray-800"
        >
          Подтвердить
        </button>
      </form>

      <Notification message={error} />
    </div>
  );
}
