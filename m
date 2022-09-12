Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B355B625E
	for <lists+linux-efi@lfdr.de>; Mon, 12 Sep 2022 22:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiILUt7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Sep 2022 16:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiILUtz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Sep 2022 16:49:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511F9E0E7;
        Mon, 12 Sep 2022 13:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A6B1B80CBF;
        Mon, 12 Sep 2022 20:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA50C43470;
        Mon, 12 Sep 2022 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663015790;
        bh=UgN3+C6I2jy2LKJA5gbgkhfH1TYB7W6z2KdhdYv0SFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQ1/QN61hES59nfphrDpfQHbiETTHjQ1u/9WWfBXhtONVcoDgM0fZMqzL12MN4s9c
         jpbXLtrceBTPSnE/8wP1tA5NgdoxCMxyMpSskjZiMA94WALAITC1A6U0S0E+4nRJ9r
         VtQnoHOQKfX9QRR1QrNRftv3O5D/F226oQCLRzxcktNGi/buiuO/rJTajaor/JgKKd
         NcA/wXhHP2miGvZO9vFw0RxJYrNSS9d+9StY4rmW0h02KUPmw8aE1bD7ze0WETbt1g
         coDE+j2kl/XWVQL9u03AKm5N5Eaj03FvG79EBXJC/cQChmjxq8X2Cb1Y7vbzy0rF+S
         +vnvTxa0BjUog==
Date:   Mon, 12 Sep 2022 21:49:47 +0100
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
Subject: Re: [PATCH v2 5/8] i2c: mlxbf: Refactor _UID handling to use
 acpi_dev_uid_to_integer()
Message-ID: <Yx+ba9u7pUASjsOh@shikoro>
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
 <20220908132910.62122-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a0qCJfjONDTI+fsG"
Content-Disposition: inline
In-Reply-To: <20220908132910.62122-6-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--a0qCJfjONDTI+fsG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2022 at 04:29:07PM +0300, Andy Shevchenko wrote:
> ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
> an integer. Use it instead of custom approach.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Wolfram Sang <wsa@kernel.org>


--a0qCJfjONDTI+fsG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMfm2sACgkQFA3kzBSg
KbbJahAAlddNw8oAIOtzHCY+oWXUoegf6GauKe69t1C+izLWXeOmRubobDgpPdVX
W2Ys5JH2bOhl509CZYHG+4D+QOeO7AKcMhF+ZRoip6bBtTnq0bN07PDwjEztkaU2
9BGDci1XgEr0Y4S2GY3/BJTFXVBuLx+iAMngQrXzv9CGLliggW/GUrHoKCdZkIH9
9CuIIu4sd4FTfCWXvp3ehN7KMRNtUueW6nRvrFycxUmQSNMdMzAX9FY/1mQSFwEP
arR6FPpwqafToNlyQoYx538SC/iL3LDGRhZHlpRsAus3gOVeCNmb4Wg+3OcKK8JE
xJETvOwONGo5JCjylOUEmR0A/c3CxinldJ8WQ/3Z7/t3cVW1PzMX7aeFrB3oZB08
p3ZbqspitutuBoVWY8PhOPtPsytCq7LRoMm3M5WtxDYp5JvYGMg3hS7Z0s7Cn4C5
Bu8KHnYlZc6vzAFO5+6TitF6CR3tt+Q2itM92vbbCWdesVdQg4c2hbsbeYx0Zkew
ulEg/xGbDmyvYWlcojjMhFwRJ3DfJ/kL+0KeCZOenXeyVpk7cDZR45One4S1BX3e
f+f3Unf4Os7ScPyOA8S23aPwJZHH9+A3exYzO4g5l2lvgmZS/f34I+p9m4xnKIva
tvD2jxk7pJz3eePXV9z1NSNv+oikQeou/3RvWyJ899OnDGsknas=
=npcM
-----END PGP SIGNATURE-----

--a0qCJfjONDTI+fsG--
