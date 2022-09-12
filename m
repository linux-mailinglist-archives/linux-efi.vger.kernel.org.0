Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4294E5B6254
	for <lists+linux-efi@lfdr.de>; Mon, 12 Sep 2022 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiILUtr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Sep 2022 16:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiILUtq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Sep 2022 16:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C3BAE72;
        Mon, 12 Sep 2022 13:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E6C961251;
        Mon, 12 Sep 2022 20:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B1CC433C1;
        Mon, 12 Sep 2022 20:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663015780;
        bh=6Fjw6Ql7mmqXkbJehMTFK14pZmNsuXqsCwyUTi8gFfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcmzkH3VZeu+vcCV3jE2FAUs7FFXjtw26g1osYrRXVetuIOuCk3Q/Ktyp9F9BPRKE
         LmS/P+XAriOWGiu1V/lS6ylkx9hfjkSetlQVf2nstvXNpoyF3OuZdRJoD1JEFWmekR
         I75WTAygor23nOe40a7/ymJ1KMqyairdrYTXgkY6yJJqj1JhihU61PtFFS5p95RqKC
         oiPcF9TzRi5PayPLvM97oHIO4wMatDgGXrpGLXSz614qMHdKG9fLKqQ8hRVEcaP6XQ
         YuXPbsJH5dEqD9oNsPMbi6+5QN0cliQsLHN0OZEpj1SBciqI9f1VEfejokNNp/WnVA
         N/LsG9emnnNpg==
Date:   Mon, 12 Sep 2022 21:49:34 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v2 4/8] i2c: amd-mp2-plat: Refactor _UID handling to use
 acpi_dev_uid_to_integer()
Message-ID: <Yx+bXht7BPDJ0e7x@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, devel@acpica.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Robert Moore <robert.moore@intel.com>
References: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
 <20220908132910.62122-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sUAXZs/SIFegtpQk"
Content-Disposition: inline
In-Reply-To: <20220908132910.62122-5-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--sUAXZs/SIFegtpQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2022 at 04:29:06PM +0300, Andy Shevchenko wrote:
> ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
> an integer. Use it instead of custom approach.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Wolfram Sang <wsa@kernel.org>


--sUAXZs/SIFegtpQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMfm1oACgkQFA3kzBSg
KbZOvxAAlXmFeqXkCJJ0tSAv+ILY540Lq7bsjWcq5ojbGK5UK53ituzoHRL/6H0s
PhB+A5LEUea5sUZwQfQdhLPWPIy8Mu5hwAiIZinq7ebTtMcw8tte44ki2a3HG5OV
H3Kbt9oX3c3ToVuB2dDsY+Wn0MOcgVw1i7wYNx85JpKpmXatOUcs7A55yz6gF+bF
1Eg7kwUiMroaBDyL1HhiVMIW8c96lyyYEGJLbY0kT/jAUVWzlI4YjeGow7cNCjwI
gJkfKGxiFz1fZdfJ7+LJTchunMJrH4sWRgEIoLFAKhaav7MspxNTTnc7W/HqKHYV
LgzUhyxBZA8OxTt36bYTY9DJjKlr1kmN2YF3i5gn68j7gkuzBPIwGatcddHC8v2C
zG6UB30INc7wtOtU2lxAQhJhcJOSZvHbLlsjPisuYwBg8x6hXuB/DREv8GzN1c5E
MG1kpb/d0+237zy9b6/ZNxANz56fLN56Sg7gMl3NHLQIXfb9fwpYec1z6i8vuOVS
OUdzUKAfuCBxIUZwPFoX5oesGRX2YlmQiPxvVZSlFBNkDz979ciTriA2xfN+OJ6e
8KjDhD4HB0pIPhRVK2WID7RgT5rra57FA0bqiIzro24WSZo/kmzKBHnkc/P3Vq3o
7bTW3f07rs+u55/hwAiOJicYm/DLw7uECO+q1FxIW1Rgl6VIZiQ=
=ivoN
-----END PGP SIGNATURE-----

--sUAXZs/SIFegtpQk--
