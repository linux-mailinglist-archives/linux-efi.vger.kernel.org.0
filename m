Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3277B4432F3
	for <lists+linux-efi@lfdr.de>; Tue,  2 Nov 2021 17:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhKBQjT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Nov 2021 12:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbhKBQis (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Nov 2021 12:38:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A1FC0432E2;
        Tue,  2 Nov 2021 09:35:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B6F9A1F44B05
Received: by earth.universe (Postfix, from userid 1000)
        id 9934C3C0F95; Tue,  2 Nov 2021 17:28:24 +0100 (CET)
Date:   Tue, 2 Nov 2021 17:28:24 +0100
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
Subject: Re: [PATCH 03/13] power: supply: bq25890: Fix race causing oops at
 boot
Message-ID: <20211102162824.f77b2udrzdae6ese@earth.universe>
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m3bztypuuj3ujxau"
Content-Disposition: inline
In-Reply-To: <20211030182813.116672-4-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--m3bztypuuj3ujxau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 30, 2021 at 08:28:03PM +0200, Hans de Goede wrote:
> Before this commit the driver was registering its interrupt handler before
> it registered the power_supply, causing bq->charger to potentially be NULL
> when the interrupt handler runs, triggering a NULL pointer exception in
> the interrupt handler:
>=20
> [   21.213531] BUG: kernel NULL pointer dereference, address: 00000000000=
00680
> ...
> [   21.213573] Hardware name: Xiaomi Inc Mipad2/Mipad, BIOS MIPad-P4.X64.=
0043.R03.1603071414 03/07/2016
> [   21.213576] RIP: 0010:__lock_acquire+0x5c5/0x1de0
> ...
> [   21.213629] Call Trace:
> [   21.213636]  ? disable_irq_nosync+0x10/0x10
> [   21.213644]  ? __mutex_unlock_slowpath+0x35/0x260
> [   21.213655]  lock_acquire+0xb5/0x2b0
> [   21.213661]  ? power_supply_changed+0x23/0x90
> [   21.213670]  ? disable_irq_nosync+0x10/0x10
> [   21.213676]  _raw_spin_lock_irqsave+0x48/0x60
> [   21.213682]  ? power_supply_changed+0x23/0x90
> [   21.213687]  power_supply_changed+0x23/0x90
> [   21.213697]  __bq25890_handle_irq+0x5e/0xe0 [bq25890_charger]
> [   21.213709]  bq25890_irq_handler_thread+0x26/0x40 [bq25890_charger]
> [   21.213718]  irq_thread_fn+0x20/0x60
> ...
>=20
> Fix this by moving the power_supply_register() call to above the
> request_threaded_irq() call.
>=20
> Note this fix includes making the following 2 (necessary) changes:
>=20
> 1. Switch to the devm version of power_supply_register() to avoid the
> need to make the error-handling in probe() more complicated.
>=20
> 2. Rename the "irq_fail" label to "err_unregister_usb_notifier" since
> the old name no longer makes sense after this fix.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 945c3257ca93..491d36a3811a 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -734,8 +734,9 @@ static int bq25890_power_supply_init(struct bq25890_d=
evice *bq)
>  	psy_cfg.supplied_to =3D bq25890_charger_supplied_to;
>  	psy_cfg.num_supplicants =3D ARRAY_SIZE(bq25890_charger_supplied_to);
> =20
> -	bq->charger =3D power_supply_register(bq->dev, &bq25890_power_supply_de=
sc,
> -					    &psy_cfg);
> +	bq->charger =3D devm_power_supply_register(bq->dev,
> +						 &bq25890_power_supply_desc,
> +						 &psy_cfg);
> =20
>  	return PTR_ERR_OR_ZERO(bq->charger);
>  }
> @@ -985,22 +986,22 @@ static int bq25890_probe(struct i2c_client *client,
>  		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
>  	}
> =20
> +	ret =3D bq25890_power_supply_init(bq);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register power supply\n");
> +		goto err_unregister_usb_notifier;
> +	}
> +
>  	ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
>  					bq25890_irq_handler_thread,
>  					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  					BQ25890_IRQ_PIN, bq);
>  	if (ret)
> -		goto irq_fail;
> -
> -	ret =3D bq25890_power_supply_init(bq);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to register power supply\n");
> -		goto irq_fail;
> -	}
> +		goto err_unregister_usb_notifier;
> =20
>  	return 0;
> =20
> -irq_fail:
> +err_unregister_usb_notifier:
>  	if (!IS_ERR_OR_NULL(bq->usb_phy))
>  		usb_unregister_notifier(bq->usb_phy, &bq->usb_nb);
> =20
> @@ -1011,8 +1012,6 @@ static int bq25890_remove(struct i2c_client *client)
>  {
>  	struct bq25890_device *bq =3D i2c_get_clientdata(client);
> =20
> -	power_supply_unregister(bq->charger);
> -
>  	if (!IS_ERR_OR_NULL(bq->usb_phy))
>  		usb_unregister_notifier(bq->usb_phy, &bq->usb_nb);
> =20
> --=20
> 2.31.1
>=20

--m3bztypuuj3ujxau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGBZyAACgkQ2O7X88g7
+pqXiw//YG80CwkdFndnEyxqicPSzqUUgzessKeb6Whnt1gt2k8F9m57m6BGOqrX
6uInmweM9Uv7HtJhwQbpTK/X6tU2ZMsg5y39VFk44FTw3xOlHkokZtgmP5Svjo9R
E4gTmqK5peTQ7YUQ3mN9oAYArQpE44UKIPxnzV9aoNBKvauR9ojJsPHKyPQ5FQxn
WhvOjrd8PEmJGmb1k4GI58LH6W3Fwl/iTLo6tgg74JLXUznhbzwQc/Nfb4nBGOeE
4RsN2MlIreynH7C95k8VMtrJXN0xfpc77DkT9jPyAteZpgFztCTbRqi+B0sGF1b2
ExPv2k2idl/N5A/fUstDWsJODIvOVynjqn/I95v9lxLhwlXRPDEqa4FSuCw/HQxI
apkbNhN4TB5ZQwTaPFukEosI2/0QqRGEgXB3mAlpQQKhB8g7Y7aA6T0GWXlXgdLo
+QBNQbd5+7S8A4wmHeUce7XnzU62phbjV3aV2sOZP+oMqG9o9PPb81rjAQyP+o2+
+4QDRWJBXHplepFt2sPTBtS7sldSBKPIrTTsLSMmviaHcv69SRCc+2K1rv0FNER6
jiLkNvaOPBJalQuZqSrpzSwSj0nyiMh96cnUdflP7Zst2N3BQAPKPzC9si0zBLBm
iZgLKikK5RAG6RxAOLqwd6kNKTgF93udMIO8YpW+gc9ADO0riNQ=
=FDjP
-----END PGP SIGNATURE-----

--m3bztypuuj3ujxau--
