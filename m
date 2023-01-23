Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85042678A99
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 23:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjAWWQI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 17:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjAWWQH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 17:16:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2861259A;
        Mon, 23 Jan 2023 14:15:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99F4761029;
        Mon, 23 Jan 2023 22:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2B3C433EF;
        Mon, 23 Jan 2023 22:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674512149;
        bh=dzR9jadCHVHiRlmTtLWKgwiAFnV8i9CLV57+Ug54JSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WODNM7ZmTXCIqpt5GqHEgS+2D9pSHAt0/Pu95CkURnZS11o92eGr5FWTQfVWwamoT
         2BRj82k959actPJpsKZlGtqv27vuQaMny2oOf27xoZ4D65JVauwyiGPzSfgoYW2GpL
         OG9YpPtGMxDMjbquvuFZIAHYd6oJswVsCmYXlUxLn47wXwMyTxWCZqETvNxmgCAa02
         DRXAaMn9g8+NrQ0EKBRhprRM72AFLKohA022Eurn/vhe2Ls6y9csbBCjCk3aZyUEQc
         rBEZAzTAglnlBFyrOQR+aIp6+810PKwvXal/3BfmcOAFFGO2kSwkL/6BuxoF5pkI9s
         yzkDityFrYuTQ==
Date:   Mon, 23 Jan 2023 22:15:43 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 1/6] riscv: Split early and final KASAN population
 functions
Message-ID: <Y88HD2ocLQilIuDr@spud>
References: <20230123100951.810807-1-alexghiti@rivosinc.com>
 <20230123100951.810807-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/CdvQ7qYoN72WHHO"
Content-Disposition: inline
In-Reply-To: <20230123100951.810807-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--/CdvQ7qYoN72WHHO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

FYI this patch has a couple places with spaces used rather than tabs for
indent.

>  static void __init kasan_populate_p4d(pgd_t *pgd,
> -				      unsigned long vaddr, unsigned long end,
> -				      bool early)
> +				      unsigned long vaddr, unsigned long end)
>  {
>  	phys_addr_t phys_addr;
>  	p4d_t *p4dp, *base_p4d;
>  	unsigned long next;
> =20
> -	if (early) {
> -		/*
> -		 * We can't use pgd_page_vaddr here as it would return a linear
> -		 * mapping address but it is not mapped yet, but when populating
> -		 * early_pg_dir, we need the physical address and when populating
> -		 * swapper_pg_dir, we need the kernel virtual address so use
> -		 * pt_ops facility.
> -		 */
> -		base_p4d =3D pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pgd)));
> -	} else {
> -		base_p4d =3D (p4d_t *)pgd_page_vaddr(*pgd);
> -		if (base_p4d =3D=3D lm_alias(kasan_early_shadow_p4d)) {
> -			base_p4d =3D memblock_alloc(PTRS_PER_PUD * sizeof(p4d_t), PAGE_SIZE);
> -			memcpy(base_p4d, (void *)kasan_early_shadow_p4d,
> -				sizeof(p4d_t) * PTRS_PER_P4D);
> -		}
> -	}
> +	base_p4d =3D (p4d_t *)pgd_page_vaddr(*pgd);
> +	if (base_p4d =3D=3D lm_alias(kasan_early_shadow_p4d)) {
> +		base_p4d =3D memblock_alloc(PTRS_PER_PUD * sizeof(p4d_t), PAGE_SIZE);
> +        memcpy(base_p4d, (void *)kasan_early_shadow_p4d,
> +                sizeof(p4d_t) * PTRS_PER_P4D);
> +    }

^^  here.

Thanks,
Conor.


--/CdvQ7qYoN72WHHO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY88HDwAKCRB4tDGHoIJi
0g3jAP9qpKIGB01xKifUub9QHdmf+VkgP+aCUvX0haiSSlOv5gEA5jDr/uhR9d5+
klCEHGmOIU7GXyYShrKt3au2MQpcXQY=
=NeIJ
-----END PGP SIGNATURE-----

--/CdvQ7qYoN72WHHO--
