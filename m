Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B246B67E96F
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jan 2023 16:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjA0P2Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Jan 2023 10:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjA0P2P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Jan 2023 10:28:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380CE21959;
        Fri, 27 Jan 2023 07:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674833293; x=1706369293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CtNAdAonBFHUKepZl7RaqISOJYoGgnfbvYJNH8B3Y0k=;
  b=odupeIn+e+jVCDRbjIG71Vsh4sZnD9NQT+yErQd0TVfdVxxdpJfM/HOO
   2YRvWr9arDPL83SMcdSrvyaQ3XGe+/X1e2YuCWIHSbUexWgV6HdaPSjuz
   qlBDmP3OvUU7yfjD3yXvP69ngfPeWq8QzbUYcwug/AfQKGo0eyN0P9KCQ
   YYLMdhP2gyxVKFfVxpCsZ07rh/66L6gvAAUGvkM1OdGswXsHNIe5MkM2F
   En4iPKaWKv2c3HmwiA69Z00FHtkXHx7/hRhOh0j3NiSlVaDSlD96bw7nI
   0clQev8JkhNTVoBN/d+qJe9My8450sHWgp1ZfwKFaf07mxTRWPY665gNv
   g==;
X-IronPort-AV: E=Sophos;i="5.97,251,1669100400"; 
   d="asc'?scan'208";a="197710525"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jan 2023 08:28:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 08:28:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 27 Jan 2023 08:28:04 -0700
Date:   Fri, 27 Jan 2023 15:27:40 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel
 address space
Message-ID: <Y9PtbMSe9DUk3bCn@wendy>
References: <20230125082333.1577572-1-alexghiti@rivosinc.com>
 <20230125082333.1577572-4-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z01ixQvrSdrQQAm3"
Content-Disposition: inline
In-Reply-To: <20230125082333.1577572-4-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--Z01ixQvrSdrQQAm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

On Wed, Jan 25, 2023 at 09:23:30AM +0100, Alexandre Ghiti wrote:
> The early virtual address should lie in the kernel address space for
> inline kasan instrumentation to succeed, otherwise kasan tries to
> dereference an address that does not exist in the address space (since
> kasan only maps *kernel* address space, not the userspace).
>=20
> Simply use the very first address of the kernel address space for the
> early fdt mapping.
>=20
> It allowed an Ubuntu kernel to boot successfully with inline
> instrumentation.
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Been poking around in this area the last few days trying to hunt down
some bugs... Things look functionally the same w/ this patch and we do
get rid of the odd looking pointer which is nice.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Probably would've made the cause of 50e63dd8ed92 ("riscv: fix reserved
memory setup") more difficult to find so glad I got that out of the way
well before this patch!

Thanks,
Conor.

> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 478d6763a01a..87f6a5d475a6 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -57,7 +57,7 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsign=
ed long)]
>  EXPORT_SYMBOL(empty_zero_page);
> =20
>  extern char _start[];
> -#define DTB_EARLY_BASE_VA      PGDIR_SIZE
> +#define DTB_EARLY_BASE_VA      (ADDRESS_SPACE_END - (PTRS_PER_PGD / 2 * =
PGDIR_SIZE) + 1)
>  void *_dtb_early_va __initdata;
>  uintptr_t _dtb_early_pa __initdata;
> =20
> --=20
> 2.37.2
>=20
>=20

--Z01ixQvrSdrQQAm3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9PtbAAKCRB4tDGHoIJi
0u7KAPY1hCi3Va5fAfv37uYg8QCBL7X4ZCQl3ls8gDg6rGp9AQDsdy5FKbSVrpX1
z1qeXbmq0/jC3ZakOc10BTCtvty7Dw==
=w080
-----END PGP SIGNATURE-----

--Z01ixQvrSdrQQAm3--
