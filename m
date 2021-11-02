Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5C44432F1
	for <lists+linux-efi@lfdr.de>; Tue,  2 Nov 2021 17:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhKBQjS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Nov 2021 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbhKBQis (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Nov 2021 12:38:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A62C0432E3;
        Tue,  2 Nov 2021 09:35:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2DD821F44BDC
Received: by earth.universe (Postfix, from userid 1000)
        id 93D413C0F95; Tue,  2 Nov 2021 17:29:21 +0100 (CET)
Date:   Tue, 2 Nov 2021 17:29:21 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH 04/13] power: supply: bq25890: Fix initial setting of the
 F_CONV_RATE field
Message-ID: <20211102162921.zbjmsxiwudbfi4wp@earth.universe>
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bawxk5exxgfk5hen"
Content-Disposition: inline
In-Reply-To: <20211030182813.116672-5-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--bawxk5exxgfk5hen
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 30, 2021 at 08:28:04PM +0200, Hans de Goede wrote:
> The code doing the initial setting of the F_CONV_RATE field based
> on the bq->state.online flag. In order for this to work properly,
> this must be done after the initial bq25890_get_chip_state() call.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 491d36a3811a..99497fdc73da 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -682,16 +682,16 @@ static int bq25890_hw_init(struct bq25890_device *b=
q)
>  		}
>  	}
> =20
> -	/* Configure ADC for continuous conversions when charging */
> -	ret =3D bq25890_field_write(bq, F_CONV_RATE, !!bq->state.online);
> +	ret =3D bq25890_get_chip_state(bq, &bq->state);
>  	if (ret < 0) {
> -		dev_dbg(bq->dev, "Config ADC failed %d\n", ret);
> +		dev_dbg(bq->dev, "Get state failed %d\n", ret);
>  		return ret;
>  	}
> =20
> -	ret =3D bq25890_get_chip_state(bq, &bq->state);
> +	/* Configure ADC for continuous conversions when charging */
> +	ret =3D bq25890_field_write(bq, F_CONV_RATE, !!bq->state.online);
>  	if (ret < 0) {
> -		dev_dbg(bq->dev, "Get state failed %d\n", ret);
> +		dev_dbg(bq->dev, "Config ADC failed %d\n", ret);
>  		return ret;
>  	}
> =20
> --=20
> 2.31.1
>=20

--bawxk5exxgfk5hen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGBZ2EACgkQ2O7X88g7
+pokgw/+NvQ9IHKN9jxUcazukK3dSubBs1v2lXGJmqCebI/s0K89oJMyEY68Qear
rzIlg9aLlTnOL+RD+/xJDaJ1ziXwDE9CYMkzXfGgsj8eBXtYe8W/OC5KAKvDNd88
ONvOqGIbUG2lychMyqnNH3mpd4HttHmdjCWd7mXiCKlHjMEzMClLRI/Pk0g6Bn1L
K5n1ve4BNyj0jqFN5EUyUzEeI7nAFmrSHUPks0pUHgpQ+ZbPc8AhzwfrOSYd3zoi
dk4RMgjo51K/nuFb1oavE3qRcuNHwxe+D5DBHaddCG/Yh04RmpVgFVFOt4NcGmOi
/fv+g9SPfbPI0kVoBPfvY4eHxOmxl0WJYCflna6gDRPM1B0o1O9viravg8fCQUn+
ok/HU3cRtn1JtAKQu2nclT9paiFXjUtUarmh399SrJhJJZSvQWN5fOsUcH7bFU0O
5/TYYtNcLc9HjjMa5rQGICH2Lq0w3nXdHcDVsfzdClgBhBo/T54nkX+8tqgoBn5I
ePc2neStXv5X4akpmD9KQQcCPuMpPIiWOfFy7OITjBwqMR2lzxSuUswNQUFCmNmo
EGqTcTmDLhw26JsdqDNc/d0w9jzvHyx7aZo4AQ0uXJaN42vmhsXbWFqlOH9ogIOw
/NPoCK2umJOUI2gANoyRB6kDQWxP8vuzXdo6XGKbzz5wCkEiZi0=
=VXeB
-----END PGP SIGNATURE-----

--bawxk5exxgfk5hen--
