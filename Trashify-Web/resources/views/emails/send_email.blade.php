<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trashify - Kode OTP Anda</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap"
        rel="stylesheet">
</head>

<body style="margin: 0; padding: 0; font-family: 'Poppins', sans-serif; background-color: #f4f4f4;">
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%"
        style="max-width: 600px; background-color: #ffffff; margin: 20px auto; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
        <tr>
            <td align="center"
                style="font-family: 'Poppins', sans-serif; padding: 20px; background-color: #368666; border-radius: 10px 10px 0 0;">
                <h1 style="color: #ffffff; margin: 0;">Trashify</h1>
            </td>
        </tr>
        <tr>
            <td align="center" style="padding: 20px; color: #333333;">
                <h2 style="font-size: 24px; margin-top: 0;">{{ $kodeOTP['title'] }}</h2>
                <div style="margin: 20px 0; text-align: center;">
                    <span
                        style="display: inline-block; font-family: 'Poppins', sans-serif; font-size: 24px; font-weight: bold; color: #368666; background-color: #f4f4f4; padding: 10px 20px; border-radius: 5px; border: 1px solid #ddd;">
                        {{ $kodeOTP['code'] }}
                    </span>
                </div>
                <p
                    style="font-size: 14px; font-family: 'Poppins', sans-serif; color: #888888; line-height: 1.5; margin-top: 20px;">
                    Jika Anda tidak meminta kode ini, Anda dapat mengabaikan email ini dengan aman.
                </p>
            </td>
        </tr>
        <tr>
            <td align="center" align="center"
                style="padding: 10px; background-color: #f4f4f4; border-radius: 0 0 10px 10px;">
                <p style="font-size: 12px; font-family: 'Poppins', sans-serif; color: #888888; margin: 0;">&copy; 2024
                    Trashify. All rights reserved.</p>
            </td>
        </tr>
    </table>
</body>

</html>