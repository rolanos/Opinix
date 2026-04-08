import React, { useState } from 'react';
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import PrivacyPage from "./pages/Privacy";
import TermsPage from "./pages/Terms";
import SurveyPage from "./pages/SurveyPage";
import LoginPage from "./pages/LoginPage";
import RegisterPage from "./pages/RegisterPage";
import EmailVerificationPage from "./pages/EmailVerificationPage";
import ComingSoonPage from "./pages/ComingSoonPage";
import Header from "./components/Header";
import Footer from "./components/Footer";
import Sidebar from "./components/Sidebar";
import { AuthProvider } from "./contexts/AuthContext";
import "./styles/App.css"; // подключим стили для flex-layout

export default function App() {
  const [sidebarOpen, setSidebarOpen] = useState(true);

  return (
    <AuthProvider>
      <BrowserRouter>
        <div className="app-layout">
          <Header onToggleSidebar={() => setSidebarOpen(v => !v)} />
          <div className="main-layout">
            <Sidebar isOpen={sidebarOpen} />
            <main className={`main-content ${sidebarOpen ? 'shifted' : 'collapsed'}`}>
              <div className="content-area">
                <Routes>
                <Route path="/" element={<SurveyPage />} />
                <Route path="/login" element={<LoginPage />} />
                <Route path="/register" element={<RegisterPage />} />
                <Route path="/confirm" element={<EmailVerificationPage />} />
                <Route path="/coming-soon" element={<ComingSoonPage />} />
                <Route path="/privacy" element={<PrivacyPage />} />
                <Route path="/terms" element={<TermsPage />} />
                {/* если страница не найдена — редирект на главную */}
                <Route path="*" element={<Navigate to="/" replace />} />
                </Routes>
              </div>
            </main>
          </div>
          <Footer />
        </div>
      </BrowserRouter>
    </AuthProvider>
  );
}
