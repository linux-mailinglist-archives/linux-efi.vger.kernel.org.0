Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF0454D7D
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 19:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhKQS7S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 13:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhKQS7S (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Nov 2021 13:59:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E13AC061570;
        Wed, 17 Nov 2021 10:56:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9B4F01F4504E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637175377; bh=pfW3r//hiTUpNl3AaVc51NsLpL5CHDHjWkEcoprBN2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbnJLmmNnqvWvLr9wHaL1mfpbN4RShrjRtTXKJVBBAo5YO6XNFtiN5ZbGsQ6/aW/G
         fiAL9oiaawS8DOwJW0P6GJAdXDbU43Yl5zumMeMZAqauBrDkqo+VAqoB2mg2DuMbOm
         q9fsb9WuE9mkjLxTOmNM3Wkv1uG72cekwaHb1yVfB4YQrW0FKo+4bLoxUQi2NPTo8g
         KLcpLCo0ISj5xa3IaUuIPyBxhReiowDNustCg1ob3qr8UYUK/oCRJc8coRs6OtlH5v
         VQXMwVzSAYwln00ZTW4i33Ea+MW3ExfWUp4qw/YcKKMJXM8uNL8ERIiltYwgzU5lZ4
         oUbBMnM6c7frw==
Received: by earth.universe (Postfix, from userid 1000)
        id F17313C0F9E; Wed, 17 Nov 2021 19:56:15 +0100 (CET)
Date:   Wed, 17 Nov 2021 19:56:15 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 00/20] power-suppy/i2c/extcon: Fix charger setup on
 Xiaomi Mi Pad 2 and Lenovo Yogabook
Message-ID: <20211117185615.iqln2hhvkq5utefb@earth.universe>
References: <20211114170335.66994-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jv4e474pzdvgweet"
Content-Disposition: inline
In-Reply-To: <20211114170335.66994-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--jv4e474pzdvgweet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Nov 14, 2021 at 06:03:15PM +0100, Hans de Goede wrote:
> This is version 2 of my series previously titled:
> "[PATCH 00/13] power-suppy/i2c/extcon: Add support for cht-wc PMIC
> without USB-PD support". [...]

Apart from the already pointed out things the power-supply changes LGTM.

-- Sebastian

--jv4e474pzdvgweet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGVUEMACgkQ2O7X88g7
+prLXQ/+M0HVd3+zx/Indeo+CsPNaNrCsjPQPMmXpWCFv+D+60jX1xElNK2MOdRY
4nb82ca24uvIsawx85gUXPQJv0DAB0KQiqa3I7d7L/AswNarxha6bDcC8d6TlD85
Kg/55YNaKB2mjqxGK7nZ7lAOYQMHQGgiJ19br2kVwlJiBywMHvso8lPSBHA0cR3f
eJc57hpLvliqpW/1l7XzDMgdR1U+TUG7vICuC6uyV3DwWb0XdakFFJvQQvE14U1v
to9otcNL1E2Wt2I0sQV52Je+/a3tP6qlWMR1AigfeNbLXTl/POcWIhbjSbxChgT2
N3HVqKcN/JnBXAwRmSr+K5LVPJWEKiM6wLhD+Ua2ncXX51mcxABnA1pXiXuXBqZ6
eIni/tmerqPcbLLmqGtvx/rD7m4Gcudu+66BrhplkgMEpDs+oZ2qIZMdPO/e+JTS
rhwowA9g2ujDON5JeM/IBImnzJ/ggKUkba80GKbqGVQq5vpzjNuq4wIy1uMiNS3Q
/LbrJnk+zun2i4ZNWsGBDymPMXeXkJ12JF3NFv2HsuAzHKjLMNpwvGpFn3UnntK0
98yUoQkD8UqlXf/0BJ5hi4ACVdBTZQ88Z4ry/G0/ii2HNvgHfO7z2p7DmXa1QClu
ZCzHvKRatNnEgs/bm8KHyoda4DNua9TFOlsiDwa3g/cIT/sPV28=
=SyNY
-----END PGP SIGNATURE-----

--jv4e474pzdvgweet--
