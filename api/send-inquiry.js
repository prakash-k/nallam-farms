const nodemailer = require('nodemailer');

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

  // Get SMTP credentials from Vercel Environment Variables
  const smtpHost = process.env.SMTP_HOST || 'smtp.gmail.com';
  const smtpPort = process.env.SMTP_PORT || '587';
  const smtpUser = process.env.SMTP_USER; // e.g. infonallam@gmail.com
  const smtpPass = process.env.SMTP_PASS; // e.g. Gmail App Password
  const targetEmail = 'infonallam@gmail.com';

  if (!smtpUser || !smtpPass) {
    return res.status(500).json({ 
      error: 'SMTP user and password credentials are not configured on Vercel environment variables.' 
    });
  }

  // Configure transporter using SMTP details
  const transporter = nodemailer.createTransport({
    host: smtpHost,
    port: parseInt(smtpPort),
    secure: parseInt(smtpPort) === 465, // true for 465, false for 587
    auth: {
      user: smtpUser,
      pass: smtpPass
    },
    tls: {
      rejectUnauthorized: false // Avoid connection issues on some hosts
    }
  });

  const mailOptions = {
    from: `"Nallam Farms Website" <${smtpUser}>`,
    to: targetEmail,
    replyTo: email,
    subject: `New Inquiry from ${name}`,
    html: `
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
  };

  try {
    await transporter.sendMail(mailOptions);
    return res.status(200).json({ success: true, message: 'Inquiry sent successfully via SMTP!' });
  } catch (error) {
    console.error('SMTP Send Error:', error);
    return res.status(500).json({ error: 'Failed to send email via SMTP', details: error.message });
  }
};
