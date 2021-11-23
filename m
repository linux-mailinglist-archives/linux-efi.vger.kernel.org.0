Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813ED459DDE
	for <lists+linux-efi@lfdr.de>; Tue, 23 Nov 2021 09:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhKWI1x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 03:27:53 -0500
Received: from sauhun.de ([88.99.104.3]:47114 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhKWI1x (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 23 Nov 2021 03:27:53 -0500
Received: from localhost (p5486ca86.dip0.t-ipconnect.de [84.134.202.134])
        by pokefinder.org (Postfix) with ESMTPSA id 06C2B2C009E;
        Tue, 23 Nov 2021 09:24:42 +0100 (CET)
Date:   Tue, 23 Nov 2021 09:24:38 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 15/20] i2c: cht-wc: Make charger i2c-client
 instantiation board/device-model specific
Message-ID: <YZylRkOQsj9LpG5U@kunai>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-16-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WTi5NgaCbc4tZLlR"
Content-Disposition: inline
In-Reply-To: <20211114170335.66994-16-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--WTi5NgaCbc4tZLlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 14, 2021 at 06:03:30PM +0100, Hans de Goede wrote:
> The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
> in that it is always connected to the I2C charger IC of the board on
> which the PMIC is used; and the charger IC is not described in ACPI,
> so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.
>=20
> So far this was hardcoded to instantiate an i2c-client for the
> bq24292i, with all properties, etc. set to match how this charger
> is used on the GPD win and GPD pcoket devices.
>=20
> There is a rudimentary check to make sure the ACPI tables are at least
> somewhat as expected, but this is far from accurate, leading to
> a wrong i2c-client being instantiated for the charger on some boards.
>=20
> Switch to the new DMI based intel_cht_wc_get_model() helper which is
> exported by the MFD driver for the CHT Whiskey Cove PMIC to help PMIC
> cell drivers like the i2c-cht-wc code reliably detect which board
> they are running on.
>=20
> And add board_info for the charger ICs as found on the other 2 known
> boards with a Whisky Cove PMIC.
>=20
> This has been tested on all 3 known boards.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Here is my Ack to take this via some other tree:

Acked-by: Wolfram Sang <wsa@kernel.org>

No need to send further versions of this series to the i2c-list, I'd
think.


--WTi5NgaCbc4tZLlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmGcpUEACgkQFA3kzBSg
KbZSBA/9GZx4RHh20+JYopnxXgk1t0Q/HPhRtQbbQI3VO4mo4gy8ayNRmaDWhi2+
SYeVFpAEaYJSlGATSM5JO6IaqcKM1TO1Jtuh0FH7vNPQMbqJmEA8nhKuM3Mf2pcP
qt9PhNkeZdg2qsDUVyHFo6fKsXahznvsZXtj/U5TPfTKtnXxJMDQY7mI6i4YCDZT
m4s8bjXxSaTd1uR/7URY+gtF9bKcyA9VZ6BKyV9sdutNSWkBkuP/RO0AEaPJMNzx
fjtaP7mabpQIFKvqx2dPIagON+sy7zd/H2ImKCDQjs/DwVgro9PdQ+6II8ObL1gE
74/dBRVIf0azQzYyxs1rtGftXf4vrsENGAKdzbOFzxwd4swg3BsLBrIcHZtc7bDb
n9C//6dIcS28/SJRCyOVNRLg5U529XqCVJ6njL8j5QGmfiCUUcyO097JrZAUpyGI
bsq01dw6I7ab9dgpLeLWVMKMRkrLgOeHgfzyONG17RKOofEC+8ZqNs8DW3WAwoad
XUWVEYT666VcxO2kFK/wpuS35Oef44Jm7sXlhkP4vjFKAAkYe8bO86Jkz1s+oqwL
h4g8dafZswiMZnrCq9wzc4lAVpgD3uRoKaFiTx9Qf2GNQ1mWWC9L1WnM90pODbWv
7M+q3EuWlrR3qjqb0Zlbf6jyxOobdVhq6mzkWTl7TjE385NA1kI=
=WAP4
-----END PGP SIGNATURE-----

--WTi5NgaCbc4tZLlR--
