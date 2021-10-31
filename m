Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D24441002
	for <lists+linux-efi@lfdr.de>; Sun, 31 Oct 2021 19:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJaSKs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Oct 2021 14:10:48 -0400
Received: from sauhun.de ([88.99.104.3]:34120 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230309AbhJaSKr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 31 Oct 2021 14:10:47 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Oct 2021 14:10:47 EDT
Received: from localhost (p5de04e1e.dip0.t-ipconnect.de [93.224.78.30])
        by pokefinder.org (Postfix) with ESMTPSA id B2A1D2C0093;
        Sun, 31 Oct 2021 18:58:40 +0100 (CET)
Date:   Sun, 31 Oct 2021 18:58:37 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH 11/13] i2c: cht-wc: Add support for devices using a
 bq25890 charger
Message-ID: <YX7ZTXbD0F+n3M36@kunai>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-12-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlSTOP0HHK83WUVH"
Content-Disposition: inline
In-Reply-To: <20211030182813.116672-12-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--HlSTOP0HHK83WUVH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 30, 2021 at 08:28:11PM +0200, Hans de Goede wrote:
> The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
> in that it is always connected to the I2C charger IC of the board on
> which the PMIC is used; and the charger IC is not described in ACPI,
> so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.
>=20
> So far there has been a rudimentary check to make sure the ACPI tables
> are at least somewhat as expected by checking for the presence of an
> INT33FE device and sofar the code has assumed that if this INT33FE
> device is present that the used charger then is a bq24290i.
>=20
> But some boards with an INT33FE device in their ACPI tables use a
> different charger IC and some boards don't have an INT33FE device at all.
>=20
> Since the information about the used charger + fuel-gauge + other chips is
> necessary in other places too, the kernel now adds a "intel,cht-wc-setup"
> string property to the Whiskey Cove PMIC i2c-client based on DMI matching,
> which reliably describes the board's setup of the PMIC.
>=20
> Switch to using the "intel,cht-wc-setup" property and add support for
> instantiating an i2c-client for either a bq24292i or a bq25890 charger.
>=20
> This has been tested on a GPD pocket (which uses the old bq24292i setup)
> and on a Xiaomi Mi Pad 2 with a bq25890 charger.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

In general, fine with me from the I2C side:

Acked-by: Wolfram Sang <wsa@kernel.org>


> +	else if (!strcmp(str, "bq24292i,max17047,fusb302,pi3usb30532"))
> +		board_info =3D &bq24190_board_info;
> +	else if (!strcmp(str, "bq25890,bq27520"))
> +		board_info =3D &bq25890_board_info;

Very minor nit: I prefer 'strcmp() =3D=3D 0' because the above could be read
as 'if not strcmp()' which is sadly misleading. But I am not strict with
it.


--HlSTOP0HHK83WUVH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmF+2UgACgkQFA3kzBSg
KbYmyg//ZFQBxYsRGPbdXLc7APBbxDE5qYmiiYJcZJnDc5S6/lKyh4ZoaOOeTGPv
LNw6jEPZQmjtHbZD72e4PfDY4FHmHCcj/6jZjmj3ftWzqS3wzQdzqXjC4qvkEHsd
ZHTa0BbSdb7sXWMo32Uf2ouTAeuMluVsbkEcwrFDvSKC39o/G1FsyTw4CHKphkOw
EmtFTRPnNhpvUKEA3PBVLojCtAIeg8d1j8t1KR7+1A/V7m82WNTRWh4MKZgCqTd9
0AqGamhOvc9DLok/cnzFxUICbaTpohBY5jDgP3WXlZBUGgpwOAVtvl4d7hMFhPhm
D9BJtASdC8H98ARoM8ELyrDjeVvZzxPxipyg+3oX77XAUePQUGV41ml2NKvQ5dCm
/iQWM/8Whrp+0lOMixkgZM3OtCjCWrH/p52WxAMk6Hyx4JqHTeTB7TNJjJTb8C25
2eYFXuC5P9gfW+FeMwt1LJ5QypNcG75JkYCO1AhoHz2eXdirSM5B2FFxUVZ4mMs9
rawpBnTG8EYUlP7HK6cNrkfCZC9azuYJ/ODNlYL/AE7Fb0TrPjYnXSMgYvD06pkC
Mh7NUZiz5KbXdRpgTm+IWDpevccXjslMtCmEatbmnr2tBObepvjy2qWIeZKY0jma
0RQbCFmpAWVziKgzozj1KJ78Psuv9vTdl0MpvTPN0uSWdc1SKjM=
=f7kV
-----END PGP SIGNATURE-----

--HlSTOP0HHK83WUVH--
