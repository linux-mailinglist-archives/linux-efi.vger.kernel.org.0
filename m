Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A0F75F9EC
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jul 2023 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjGXOcQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Jul 2023 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjGXOcQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Jul 2023 10:32:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8232D10F0;
        Mon, 24 Jul 2023 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690209129; x=1721745129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8lSqctVplAIarKGMJtl03N2iVLoJAxL48zKohtkfpEY=;
  b=I7sLOnHoVcjr7fkPhbt4R3jva+sRv+KDKhbSdKC/+F2pAIao7UFmLPTt
   f15XhJGXpUw0WYm0qhc1tsBRXtcQ2LHDdgvqNGPLOcxEotDjyDc1SAUnr
   YzgVOLUFOj/1kQyLRXJDGn+gxgCM/zDlSGoE8PUA5GVBzeDN6IaiiXRqK
   q+v8Z9iyllFOogEsH+1wLIRKEuOlq+N9qzTRpJivp2kR/GZW4xSwrpBWP
   Uy8L1ivBhYCt0QyKnwkrQVDXGxbsMydVOMYoHF9Rb+dpEGCT29GIY38dE
   qBA8JBpIAs5AQBvSvhQYXonjQyuHBYawQH9fF4wXHSE/0YlGIvE1a439x
   g==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="asc'?scan'208";a="162903015"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 07:32:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 07:31:37 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 24 Jul 2023 07:31:35 -0700
Date:   Mon, 24 Jul 2023 15:31:01 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 0/5] riscv: Introduce KASLR
Message-ID: <20230724-sanded-dental-c9125c76ad74@wendy>
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xtSbObKEFv5fOwOJ"
Content-Disposition: inline
In-Reply-To: <20230722123850.634544-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--xtSbObKEFv5fOwOJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

On Sat, Jul 22, 2023 at 02:38:45PM +0200, Alexandre Ghiti wrote:
> The following KASLR implementation allows to randomize the kernel mapping:
>=20
> - virtually: we expect the bootloader to provide a seed in the device-tree
> - physically: only implemented in the EFI stub, it relies on the firmware=
 to
>   provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implementati=
on
>   hence the patch 3 factorizes KASLR related functions for riscv to take
>   advantage.
>=20
> The new virtual kernel location is limited by the early page table that o=
nly
> has one PUD and with the PMD alignment constraint, the kernel can only ta=
ke
> < 512 positions.

I gave this all a go today, it seems to do what it it says on the tin,
and crashing my kernel does dump out an offset etc.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

I'll hopefully get some time later in the week to go through the code.

Cheers,
Conor.


--xtSbObKEFv5fOwOJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL6LJQAKCRB4tDGHoIJi
0rUmAP434IQTNV26JB6nzkQMeniT7xYLVBw5Vtp0L980VphnTAD/UnQM8ZUEwq2o
p+omBnMci+/NF3PBemZTOQee5NYREwg=
=PcHz
-----END PGP SIGNATURE-----

--xtSbObKEFv5fOwOJ--
