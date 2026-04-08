import "../styles/pages/Legal.css";

export default function TermsPage() {
  return (
    <div className="page-wrapper">
      <header className="legal-header">
        <h1 className="coming-soon-title">Пользовательское соглашение от 05.11.2025</h1>
      </header>
      <main className="fullpage-legal">
        <iframe
          src="/docs/terms.pdf"
          title="Пользовательское соглашение"
          className="fullpage-iframe"
        ></iframe>
      </main>
    </div>
  );
}
