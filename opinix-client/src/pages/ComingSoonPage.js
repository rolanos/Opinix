import React from 'react';
import '../styles/pages/ComingSoonPage.css';
import comingSoonImage from '../assets/coming-soon.png'; // ваша картинка

export default function ComingSoon() {
  return (
    <div className="coming-soon-container">
      <img 
        src={comingSoonImage} 
        alt="Сайт в разработке" 
        className="coming-soon-image" 
      />
      <h1 className="coming-soon-title">Сайт в разработке</h1>
      <p className="coming-soon-text">
        Сайт находится в разработке, 
        вы можете использовать наше мобильное приложение <strong>Opinix</strong>.
      </p>
    </div>
  );
}
