const express = require("express");
const axios = require("axios");
const cors = require("cors");
require("dotenv").config();

const app = express();

app.use(cors());
app.use(express.json());

const PORT = 3000;

// Pesapal Production API
const BASE_URL = "https://pay.pesapal.com/v3/api";

// Credentials
const CONSUMER_KEY = process.env.PESAPAL_CONSUMER_KEY;
const CONSUMER_SECRET = process.env.PESAPAL_CONSUMER_SECRET;

// Home
app.get("/", (req, res) => {
  res.send("Football Prediction Payment Server is running...");
});
// Get Access Token
app.get("/token", async (req, res) => {
  try {
    const response = await axios.post(
      `${BASE_URL}/Auth/RequestToken`,
      {
        consumer_key: CONSUMER_KEY,
        consumer_secret: CONSUMER_SECRET,
      },
      {
        headers: {
          "Content-Type": "application/json",
        },
      }
    );

    res.json(response.data);

  } catch (error) {
    console.log(error.response?.data || error.message);

    res.status(500).json(
      error.response?.data || error.message
    );
  }
});
// Register IPN
app.get("/register-ipn", async (req, res) => {
  try {
    // Get access token
    const tokenResponse = await axios.post(
      `${BASE_URL}/Auth/RequestToken`,
      {
        consumer_key: CONSUMER_KEY,
        consumer_secret: CONSUMER_SECRET,
      },
      {
        headers: {
          "Content-Type": "application/json",
        },
      }
    );

    const token = tokenResponse.data.token;

    // Register IPN
    const response = await axios.post(
      `${BASE_URL}/URLSetup/RegisterIPN`,
      {
        url: "https://wow-pretender-entertain.ngrok-free.dev/ipn",
        ipn_notification_type: "GET",
      },
      {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      }
    );

    res.json(response.data);

  } catch (error) {
    console.log(error.response?.data || error.message);

    res.status(500).json(
      error.response?.data || error.message
    );
  }
});
// Create Payment
app.post("/create-payment", async (req, res) => {
  try {
    const { email, first_name, last_name, amount } = req.body;

    // Get Access Token
    const tokenResponse = await axios.post(
      `${BASE_URL}/Auth/RequestToken`,
      {
        consumer_key: CONSUMER_KEY,
        consumer_secret: CONSUMER_SECRET,
      },
      {
        headers: {
          "Content-Type": "application/json",
        },
      }
    );

    const token = tokenResponse.data.token;

    // Submit Payment Request
    const response = await axios.post(
      `${BASE_URL}/Transactions/SubmitOrderRequest`,
      {
        id: Date.now().toString(),
        currency: "USD",
        amount: amount,
        description: "Football Prediction VIP Subscription",
        callback_url: "https://wow-pretender-entertain.ngrok-free.dev/ipn",
        notification_id: "51574b59-49b8-441d-963b-da2a138c2f6e",
        billing_address: {
          email_address: email,
          phone_number: "",
          country_code: "UG",
          first_name: first_name,
          last_name: last_name,
        },
      },
      {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      }
    );

    res.json(response.data);

  } catch (error) {
    console.log(error.response?.data || error.message);

    res.status(500).json(
      error.response?.data || error.message
    );
  }
});

// Receive IPN notifications
app.get("/ipn", (req, res) => {
  console.log("Pesapal IPN:", req.query);
  res.status(200).send("IPN received");
});

// Start Server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});