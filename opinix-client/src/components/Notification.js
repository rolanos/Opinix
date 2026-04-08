import React from 'react';

export default function Snackbar({ message }) {
  if (!message) return null;
  return (
    <div className="fixed bottom-4 left-1/2 -translate-x-1/2 bg-black text-white px-4 py-2 rounded">
      {message}
    </div>
  );
}
