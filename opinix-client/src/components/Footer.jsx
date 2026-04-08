import React from "react";
import { Link } from "react-router-dom";
import "../styles/components/Footer.css";

export default function Footer() {
  return (
    <footer className="site-footer">
      <div className="footer-inner">
        <p className="footer-links">
          <Link to="/privacy" className="footer-link">
            Политика конфиденциальности
          </Link>
          {" | "}
          <Link to="/terms" className="footer-link">
            Пользовательское соглашение
          </Link>
        </p>
        <p className="footer-copy">© {new Date().getFullYear()} Opinix</p>
      </div>
    </footer>
  );
}
