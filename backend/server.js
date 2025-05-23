require('dotenv').config(); // .env 파일에서 API 토큰 불러오기
const express = require('express');
const axios = require('axios');
const cors = require('cors');

const app = express();
app.use(cors()); // CORS 허용
app.use(express.json()); // JSON 파싱

const HF_TOKEN = process.env.HF_API_TOKEN; // 환경변수에서 Hugging Face 토큰

// 요약 API 라우트
// 요약 API
app.post('/summarize', async (req, res) => {
  const inputText = req.body.text;
  try {
    const response = await axios.post(
      'https://api-inference.huggingface.co/models/google/pegasus-xsum',
      { inputs: inputText },
      {
        headers: {
          Authorization: `Bearer ${HF_TOKEN}`,
          'Content-Type': 'application/json',
        },
      }
    );
    res.json(response.data);
  } catch (error) {
    console.error('요약 에러:', error.response?.data || error.message);
    res.status(500).json({ error: '요약 실패', detail: error.response?.data });
  }
});
// 요약 API
app.post('/summarize', async (req, res) => {
  const inputText = req.body.text;
  try {
    const response = await axios.post(
      'https://api-inference.huggingface.co/models/google/pegasus-xsum',
      { inputs: inputText },
      {
        headers: {
          Authorization: `Bearer ${HF_TOKEN}`,
          'Content-Type': 'application/json',
        },
      }
    );
    res.json(response.data);
  } catch (error) {
    console.error('요약 에러:', error.response?.data || error.message);
    res.status(500).json({ error: '요약 실패', detail: error.response?.data });
  }
});


// 감정 분석 API 라우트
app.post('/emotion', async (req, res) => {
  const inputText = req.body.text;
  try {
    const response = await axios.post(
      'https://api-inference.huggingface.co/models/daniel604/koelectra-base-v3-finetuned-emotion',
      { inputs: inputText },
      {
        headers: {
          Authorization: `Bearer ${HF_TOKEN}`,
          'Content-Type': 'application/json',
        },
      }
    );
    res.json(response.data); // 감정 결과 반환
  } catch (error) {
    res.status(500).json({
      error: '감정 분석 실패',
      detail: error.response?.data ?? error.message,
    });
  }
});

// 서버 실행
const PORT = 3000;
app.listen(3000, '0.0.0.0', () => {
  console.log(`프록시 서버 실행 중 http://localhost:3000`);
});