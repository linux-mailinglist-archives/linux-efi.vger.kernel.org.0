Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE4F6A1CAB
	for <lists+linux-efi@lfdr.de>; Fri, 24 Feb 2023 14:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjBXNGZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Feb 2023 08:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBXNGZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Feb 2023 08:06:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB21F959
        for <linux-efi@vger.kernel.org>; Fri, 24 Feb 2023 05:06:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 570DAB81C76
        for <linux-efi@vger.kernel.org>; Fri, 24 Feb 2023 13:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55114C433D2;
        Fri, 24 Feb 2023 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677243981;
        bh=1mGz+w0RjzaG/ZEeVR8AXX1W9VVWkhRGaVyM0jSyMNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWZP9WcxaG4nTafTfsWQTl7wNK88LprQhbeokcox21v+J8XEpXXZ7zRhAAAVEUZsi
         KPcONO0PJrWsELCj4fFC+JGixnka+df1bNaBQaCJ0xo7QwJCcMKKiRdeZzhulWPWbX
         DAIpRWjP031t3k/LqEwl2rCfDP/x3pKDlu3x0fJnIkCSFFyBK2CpijG3ykrc4RSrND
         wJurxbApF9ODqqtpFfaEL2kyWqxfUtkv4Tf2Sue6lAplUAD0DBN1wlDfQmu9vzScqm
         MBdi12E/soWquoA0ARgnwcebUaodg+Qshq5l0abSWpxVNHELWGTwHPDcVkCJ4xz2gT
         i+0x0BoxPi+8w==
Date:   Fri, 24 Feb 2023 13:06:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        maz@kernel.org
Subject: Re: [PATCH] arm64: kaslr: don't pretend KASLR is enabled if offset <
 MIN_KIMG_ALIGN
Message-ID: <Y/i2SH+a7aXZM1pa@sirena.org.uk>
References: <20230223204101.1500373-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="186QMZB+iBK+ct7K"
Content-Disposition: inline
In-Reply-To: <20230223204101.1500373-1-ardb@kernel.org>
X-Cookie: The early worm gets the bird.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--186QMZB+iBK+ct7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2023 at 09:41:01PM +0100, Ard Biesheuvel wrote:

> This means that a KASLR offset of less than 2 MiB is simply the product
> of this physical displacement, and no randomization has actually taken
> place. Currently, we use 'kaslr_offset() > 0' to decide whether or not
> randomization has occurred, and so we misidentify this case.

Making an explicit function to check if we've enabled KASLR is also a
nice cleanup in itself.

Reviewed-by: Mark Brown <broonie@kernel.org>

--186QMZB+iBK+ct7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP4tkgACgkQJNaLcl1U
h9BQbwf8DZ42+KG92TbIQZLbQHG59r9vI2kydLs0U+py+/fsaC9uEZamb5jp7uqv
sQHCUWmd6MFn2Jz5PlwJaszYIkhc7e2aR91IIHH4z7cZzU0L5zpEYH/4I9bcBwpa
+2LdnWVBwPc1USd3l1oOJeTm5dwZEkKFGMDqMqJ4MPcuV9M3ftq/4UJNh5/XHXeY
Q006j1Smhf0bVEg7iNxqtsjEW+b6fOPqCQZEfh5RXmxOLxJZ0f+u4f/FKouEWfeu
PuSs+CNbF6TOLmxpQ034YnQttKvhRc87kJIWXIXS+dxi8HF4s/pBU5UzdrozSHk4
UFT7sqiPlWF+bls2j79t5lNHlK4E9w==
=gF8I
-----END PGP SIGNATURE-----

--186QMZB+iBK+ct7K--
