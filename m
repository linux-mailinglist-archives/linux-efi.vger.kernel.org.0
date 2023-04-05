Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ED56D83C3
	for <lists+linux-efi@lfdr.de>; Wed,  5 Apr 2023 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDEQdI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Apr 2023 12:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjDEQdI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Apr 2023 12:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDCC40C4
        for <linux-efi@vger.kernel.org>; Wed,  5 Apr 2023 09:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B6A629CC
        for <linux-efi@vger.kernel.org>; Wed,  5 Apr 2023 16:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E066FC433D2;
        Wed,  5 Apr 2023 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680712386;
        bh=u4ib30Z0EhH1c74Q8RUCT9xZafldihLT8xoVTLu78mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4cWke0G6LVwI6RNzhwZJ8btwn4QUcwzjv0mdfdnLbyabBEoox1UgA9auI8yosNxt
         c0bv64I9rFTv1hJLMXV7lpLTN6omTWBWxpBnJckOTGqfxO05vVv0PP5PHuUJ0yUweP
         X+Jav37jELmAKP5XTKV2xZOUFvRNagTgehrQgTqXBiDl0vDZsRPJVm7vwN6BczNiJQ
         Ox8rTIu3Ql1xlyOW86nM0X7a+5xEEFyfKmG5xDcGNOUwTeeFcimXVoGTkuVrj3hpi9
         /ERSCWts+JgZkzrUklTBzMvw5jdAjvqqZVfK2QxrifwDmUzA8HNGDsVFz8737RCBqN
         hfcZz7jlQNBaQ==
Date:   Wed, 5 Apr 2023 17:33:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Subject: Re: [PATCH 2/6] arm64: efi: Enable BTI codegen and add PE/COFF
 annotation
Message-ID: <9b0f0dfd-0fa0-4791-ae03-bf43157542f2@sirena.org.uk>
References: <20230404151959.2774612-1-ardb@kernel.org>
 <20230404151959.2774612-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xSLbVpdFyz9QoyD0"
Content-Disposition: inline
In-Reply-To: <20230404151959.2774612-3-ardb@kernel.org>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--xSLbVpdFyz9QoyD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2023 at 05:19:55PM +0200, Ard Biesheuvel wrote:

> So let's no longer disable BTI codegen for the EFI stub, and set the
> newly introduced PE/COFF header flag when the kernel is built with BTI
> landing pads.

Reviewed-by: Mark Brown <broonie@kernel.org>

--xSLbVpdFyz9QoyD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtorwACgkQJNaLcl1U
h9D/hwf+NnUc/YpqtCDSnIKUJ3ikHdk5CgoQEXxN+BrroG2oLKq+YiwsZMEjiaOF
KIkS+X6HKGtJyI89vchPXgKzi24QyA0QiAxyaZbROljYMgeH77MguatjLCE/yboQ
8w0i7yRL0cpS6XVWpKYmQeAgrR3n8U1BAtXrjnk2P+D6VAfZPZrmA2TiOUI5kFP9
dZ9S0nCug4urWZwdt/lJmvafY/jcs3BFPhK5kHxJwI06rKpdvMacOjaKJsC4loJX
EWbszhVN9uO+Ho7W25F/+YNRLEDh9WIMHKXJ3au5GADZyOwYPvv0STuNuU/1pkjZ
s4yNzw+cV6FvBT9zyyZZSavUJnD55w==
=OA9u
-----END PGP SIGNATURE-----

--xSLbVpdFyz9QoyD0--
