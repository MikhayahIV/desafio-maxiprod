import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:5281',
  headers: {
    'Content-Type': 'application/json',
  },
});

export default api;