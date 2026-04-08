import axios from 'axios';

// Choose a reasonable default base URL when REACT_APP_API_URL is not set:
// - when running in a desktop browser during development, use localhost:80
// - when running inside Android emulator, fall back to 10.0.2.2:80
const inferredDefault = (typeof window !== 'undefined' && window.location && window.location.hostname === 'localhost')
  ? 'http://localhost:80'
  : 'http://10.0.2.2:80';

var apiUrl = 'https://opinix.ru/api';

if (process.env.NODE_ENV === 'development') {
  // Helpful debug output when running locally
  // eslint-disable-next-line no-console
  console.debug('[http] API base URL:', apiUrl);
}

const http = axios.create({
  baseURL: apiUrl,
  withCredentials: true, // для куки
});

// Response interceptor to handle 401 errors
http.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Token expired or invalid, clear local storage
      localStorage.removeItem('token');
      setAccessToken('');
      // Optionally redirect to login, but since we have context, maybe not here
    }
    return Promise.reject(error);
  }
);

export function setAccessToken(token) {
  if (token) {
    http.defaults.headers.common.Authorization = `Bearer ${token}`;
  } else {
    delete http.defaults.headers.common.Authorization;
  }
}

export default http;
