Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BBA69AE72
	for <lists+linux-efi@lfdr.de>; Fri, 17 Feb 2023 15:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBQOyN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Feb 2023 09:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBQOyM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Feb 2023 09:54:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14D228207;
        Fri, 17 Feb 2023 06:54:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B5BBB82A26;
        Fri, 17 Feb 2023 14:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B500EC433EF;
        Fri, 17 Feb 2023 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676645649;
        bh=mAyxo9jzvMpBaS+OGt1uE0IiaE4JH5UGYXDEN92Phwg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UY7NL9L8gdr3kr0FZ3JHMa3CVQX8uHHUWF/IDsYGG1eMhtZajd+SvfPmk8RK11ZHP
         iu2msEcey400TfIizRspgmRwexY75+NtyuQEG84fCoD/XmBqj5QDgDTVQlXkTuQLrY
         PH5O1xXc+i0QhFXPCftt8uKypCHEYwzsjX3f+dS36NCG5nUmmdgQSZlo5s7Dexy8th
         Og0RoXeH3rtE5OKqpCpEehLqtZB2llpGnLgDkCERZWGeALwgSCjU1cfBfni9uLnbEC
         4jcCc7HSudofdaY5YlwAWHB9oofnpZ4GLt4kxWNDnY8RM+j0G9fs0VY5g8cRZQFs7v
         uelimgXdvbLag==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 2/6] riscv: Rework kasan population functions
In-Reply-To: <20230203075232.274282-3-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
 <20230203075232.274282-3-alexghiti@rivosinc.com>
Date:   Fri, 17 Feb 2023 15:54:06 +0100
Message-ID: <87lekwmjg1.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> Our previous kasan population implementation used to have the final kasan
> shadow region mapped with kasan_early_shadow_page, because we did not cle=
an
> the early mapping and then we had to populate the kasan region "in-place"
> which made the code cumbersome.
>
> So now we clear the early mapping, establish a temporary mapping while we
> populate the kasan shadow region with just the kernel regions that will
> be used.
>
> This new version uses the "generic" way of going through a page table
> that may be folded at runtime (avoid the XXX_next macros).
>
> It was tested with outline instrumentation on an Ubuntu kernel
> configuration successfully.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

(One minor nit, that can be addressed later.)

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

>  arch/riscv/mm/kasan_init.c | 361 +++++++++++++++++++------------------
>  1 file changed, 183 insertions(+), 178 deletions(-)


> @@ -482,7 +437,37 @@ static void __init kasan_shallow_populate(void *star=
t, void *end)
>  	unsigned long vend =3D PAGE_ALIGN((unsigned long)end);
>=20=20
>  	kasan_shallow_populate_pgd(vaddr, vend);
> -	local_flush_tlb_all();
> +}
> +
> +static void create_tmp_mapping(void)
> +{
> +	void *ptr;
> +	p4d_t *base_p4d;
> +
> +	/*
> +	 * We need to clean the early mapping: this is hard to achieve "in-plac=
e",
> +	 * so install a temporary mapping like arm64 and x86 do.
> +	 */
> +	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(pgd_t) * PTRS_PER_PGD);
> +
> +	/* Copy the last p4d since it is shared with the kernel mapping. */
> +	if (pgtable_l5_enabled) {
> +		ptr =3D (p4d_t *)pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_END));
> +		memcpy(tmp_p4d, ptr, sizeof(p4d_t) * PTRS_PER_P4D);
> +		set_pgd(&tmp_pg_dir[pgd_index(KASAN_SHADOW_END)],
> +			pfn_pgd(PFN_DOWN(__pa(tmp_p4d)), PAGE_TABLE));
> +		base_p4d =3D tmp_p4d;
> +	} else {
> +		base_p4d =3D (p4d_t *)tmp_pg_dir;
> +	}
> +
> +	/* Copy the last pud since it is shared with the kernel mapping. */
> +	if (pgtable_l4_enabled) {
> +		ptr =3D (pud_t *)p4d_page_vaddr(*(base_p4d + p4d_index(KASAN_SHADOW_EN=
D)));
> +		memcpy(tmp_pud, ptr, sizeof(pud_t) * PTRS_PER_PUD);
> +		set_p4d(&base_p4d[p4d_index(KASAN_SHADOW_END)],
> +			pfn_p4d(PFN_DOWN(__pa(tmp_pud)), PAGE_TABLE));
> +	}
>  }
>=20=20
>  void __init kasan_init(void)
> @@ -490,10 +475,27 @@ void __init kasan_init(void)
>  	phys_addr_t p_start, p_end;
>  	u64 i;
>=20=20
> -	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
> +	create_tmp_mapping();
> +	csr_write(CSR_SATP, PFN_DOWN(__pa(tmp_pg_dir)) | satp_mode);

Nit: Maybe add a comment, why the sfence.vma is *not* required here. I
tripped over it.


Bj=C3=B6rn
