import React from "react";
import "../styles/pages/Legal.css";

export default function PrivacyPage() {
  return (
    <div className="page-wrapper">
      <header className="legal-header">
        <h1 className="coming-soon-title">Политика конфиденциальности от 05.11.2025</h1>
      </header>
      <main className="fullpage-legal">
        <iframe
          src="/docs/privacy.pdf"
          title="Политика конфиденциальности"
          className="fullpage-iframe"
        ></iframe>
      </main>
    </div>
  );
}
