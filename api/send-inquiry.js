const https = require('https');

module.exports = async (req, res) => {
  // Add CORS headers
  res.setHeader('Access-Control-Allow-Credentials', true);
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
  );

  // Handle preflight OPTIONS request
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { name, email, company, reason } = req.body || {};

  if (!name || !email || !reason) {
    return res.status(400).json({ error: 'Missing required fields (name, email, reason)' });
  }

  const apiKey = process.env.BREVO_API_KEY;
  if (!apiKey) {
    return res.status(500).json({ error: 'Brevo API key is not configured on Vercel environment variables.' });
  }

  const data = JSON.stringify({
    sender: {
      name: "Nallam Farms Contact Form",
      email: "infonallam@gmail.com"
    },
    to: [
      {
        email: "infonallam@gmail.com",
        name: "Nallam Farms Support"
      }
    ],
    replyTo: {
      email: email,
      name: name
    },
    subject: `New Inquiry from ${name}`,
    htmlContent: `
      <html>
        <body style="font-family: sans-serif; line-height: 1.5; color: #333;">
          <div style="max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #eee; border-radius: 10px; background-color: #fcfcfc;">
            <h2 style="color: #1F3A2E; border-bottom: 2px solid #C7A86B; padding-bottom: 10px;">New Website Inquiry</h2>
            <p>You have received a new inquiry from the Nallam Farms contact form:</p>
            <table style="width: 100%; border-collapse: collapse; margin-top: 15px;">
              <tr>
                <td style="padding: 8px 0; font-weight: bold; width: 150px;">Full Name:</td>
                <td style="padding: 8px 0;">${name}</td>
              </tr>
              <tr>
                <td style="padding: 8px 0; font-weight: bold;">Email Address:</td>
                <td style="padding: 8px 0;"><a href="mailto:${email}">${email}</a></td>
              </tr>
              <tr>
                <td style="padding: 8px 0; font-weight: bold;">Company / Subject details:</td>
                <td style="padding: 8px 0;">${company || 'N/A'}</td>
              </tr>
            </table>
            <div style="margin-top: 20px; padding: 15px; background-color: #fff; border-left: 4px solid #C7A86B; border-radius: 4px;">
              <h4 style="margin-top: 0; color: #1F3A2E;">Inquiry Details:</h4>
              <p style="white-space: pre-wrap; margin-bottom: 0;">${reason}</p>
            </div>
            <p style="font-size: 12px; color: #888; margin-top: 30px; border-top: 1px solid #eee; padding-top: 10px;">
              This inquiry was sent automatically from the contact form on nallam-farms.com.
            </p>
          </div>
        </body>
      </html>
    `
  });

  const options = {
    hostname: 'api.brevo.com',
    port: 443,
    path: '/v3/smtp/email',
    method: 'POST',
    headers: {
      'accept': 'application/json',
      'api-key': apiKey,
      'content-type': 'application/json',
      'content-length': Buffer.byteLength(data)
    }
  };

  const request = https.request(options, (response) => {
    let responseData = '';

    response.on('data', (chunk) => {
      responseData += chunk;
    });

    response.on('end', () => {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return res.status(200).json({ success: true, message: 'Inquiry sent successfully!' });
      } else {
        console.error('Brevo API Error:', responseData);
        return res.status(500).json({ error: 'Failed to send email via Brevo API', details: responseData });
      }
    });
  });

  request.on('error', (error) => {
    console.error('Request Error:', error);
    return res.status(500).json({ error: 'Server connection error', details: error.message });
  });

  request.write(data);
  request.end();
};
