Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C417E5B0B05
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 19:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIGRGU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 13:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIGRGS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 13:06:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA0C816A5;
        Wed,  7 Sep 2022 10:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFFD561983;
        Wed,  7 Sep 2022 17:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54917C433D7;
        Wed,  7 Sep 2022 17:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662570376;
        bh=F1wAayePl19lX2NW3Il3ocArXwd0RnPJMXZ8uZajO1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awLJ3NNm2Rrsu06vfyEeS6g54TPofZkCIv4iyLyM469FCHpdzipzIIsxvzR3bqTx2
         XeaAlsJO+Q7Gm7Aibxx4FnUJPTLjUvmbSnxUas0vLkPUqkVjsHmxRIEJ/0P9BK4ZsH
         SwfOXzI9V09ykXih0bYSLdc4O1PctaSvh0TT2kvVzR/FNhOuSI6HjIyI168wjDUCb5
         2Q4Jjv95V3IsM6zD4j1QgldP42dHu8Yg+EnRQe0B0evcrNtlfiMv4bLHKsb0s8oiBD
         Hg/Lj+19VBbKraYE7oLCZKp5Wq7+PG9sFZdAjwbSfTNnQCw0gEAOgYG/gbnp+D+XxN
         /ev2gwsF2+kKA==
Date:   Wed, 7 Sep 2022 18:06:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Elie Morisse <syniurge@gmail.com>,
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
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v1 7/8] spi: pxa2xx: Refactor _UID handling to use
 acpi_dev_uid_to_integer()
Message-ID: <YxjPfrUvWgcmcyYM@sirena.org.uk>
References: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
 <20220907164606.65742-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rIhaezhX0J6qlQbz"
Content-Disposition: inline
In-Reply-To: <20220907164606.65742-8-andriy.shevchenko@linux.intel.com>
X-Cookie: You have a truly strong individuality.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--rIhaezhX0J6qlQbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 07, 2022 at 07:46:05PM +0300, Andy Shevchenko wrote:
> ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
> an integer. Use it instead of custom approach.

Acked-by: Mark Brown <broonie@kernel.org>

--rIhaezhX0J6qlQbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMYz30ACgkQJNaLcl1U
h9C4hwf+I1R22kTr87UlgwkXp1bqqvfIyM2oREtcbqJndf12eBGzk88I/GnXWLSb
fg1DfB0VQ1bcw6N+8RCbNofKm/wt19D604DGOgLExTdvrgY9dYay6EZc4TzIoW81
LXJTrROsePKWY5T0nozzJwgOnMzWoSjUSAiVl+vdsI6nbonhzsGGfEpbwgQoypfH
Q36k3K9RT94nyRU9SuuWUNyBsGr2bfzgH+Y3JC1QgjvCHA75w8gUzJqsQMFxHGkn
A8dfZ6ztJxyvDlqpPUGXDhvcdGyVpcSzmLUEp5l8DVOSxvroS46Sn9mHTZlD0Qwq
VmF6MdSM9OUZPGVH2vhXMO2YBtw6dA==
=wys+
-----END PGP SIGNATURE-----

--rIhaezhX0J6qlQbz--
