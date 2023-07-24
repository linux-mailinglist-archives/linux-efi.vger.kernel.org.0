Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B697D75F9A5
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jul 2023 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjGXOUb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Jul 2023 10:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjGXOUa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Jul 2023 10:20:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B54E64;
        Mon, 24 Jul 2023 07:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690208429; x=1721744429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jpqAetm4pZsB5/kXbjlZnlIftjDXYhKEa2j6e0p9oaw=;
  b=Eiy1HBKTYWI4BrqhjiO+kTBNEVt8pOSY5sw1IzEDFw/MJQNAFhpKGmvT
   vM5WnkfEHmarq85GaG/BHUs0VV1wn2VH/2t+VtkcMP/23q6SfxOEvYkdj
   YuU2fjgDbYa7PyNvOyHXX7HGLgT3DbJB5LIc8mEUSmqmG8MNJJokiM5Tu
   af9IPKexfl5fqsXHNAdwAF+VcrcfCVJdZ9RMpmHj7ipUKF4iSz8X/RHr0
   ivAGb5GusydIdmXThbGpzqooRDheIFvZQM/QLjty0Ooaf2iRUkrbF3PrT
   hy0PkkqfHTeTQw5EKx+TEWPrLkq4CyOQS160EA4TRmIE48I2/xPF5tvbE
   g==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="asc'?scan'208";a="221901442"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 07:20:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 07:20:24 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 24 Jul 2023 07:20:22 -0700
Date:   Mon, 24 Jul 2023 15:19:49 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-efi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v6 2/5] riscv: Dump out kernel offset information on panic
Message-ID: <20230724-fineness-sectional-8cdd1e4bbff2@wendy>
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
 <20230722123850.634544-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aMNb8/bsNIfqV7pO"
Content-Disposition: inline
In-Reply-To: <20230722123850.634544-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--aMNb8/bsNIfqV7pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

On Sat, Jul 22, 2023 at 02:38:47PM +0200, Alexandre Ghiti wrote:
> Dump out the KASLR virtual kernel offset when panic to help debug kernel.
>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>

Either you're missing a Co-developed-by: or the author of this patch is
incorrect.

> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

--aMNb8/bsNIfqV7pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL6IhAAKCRB4tDGHoIJi
0uMUAP9RhMxzS+06VHvIGGfhOAXni5ygCNraqDKLEstEuQWfDQEAlV63sF94gRq7
ibFLhTzDBOjVznhq0Br9EjnHLbwKzAE=
=G/wQ
-----END PGP SIGNATURE-----

--aMNb8/bsNIfqV7pO--
