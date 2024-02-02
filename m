Return-Path: <linux-efi+bounces-456-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E02847537
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 17:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DCA1C21DFD
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF60148314;
	Fri,  2 Feb 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHuUiP/i"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB814534E;
	Fri,  2 Feb 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892334; cv=none; b=bK5meP3lUNwiWZQWdvK5fRdJdd67AE0zTfj699n48TSGSQrGvC0oKPQuamU5/RE6B5C0tlsjk5svYU2Drbf9g4hpc7sxwjPCEsvejVjirSTC9E9dOaFxuBEjIaB7+OnHXzW+nKGRlmuqxO29YlrElGS49ThRY/spTNmdhHW05wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892334; c=relaxed/simple;
	bh=1NpeW/jx9i/TLtkjQru7LCt3fwDMOgyS6dS+4BVnKEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uywMeru0Z9wf8mYsWhYpRY8ddJCN+qFzdlQByuFWkhEz8ZWjv1ursUtTWshkt+4YgE2chvAmcOiF3To+75jwqPTUgTlkWz3FZTBlfKX7fCanF7gpLA0wXj12jI2980Sge2CkW1TT/VJm4JqoJ1K2ItkedEMwgF5snj9fwCy1yAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHuUiP/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BB6C433C7;
	Fri,  2 Feb 2024 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892334;
	bh=1NpeW/jx9i/TLtkjQru7LCt3fwDMOgyS6dS+4BVnKEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UHuUiP/iWk5Fb53S92nVygIFatSs9skq2hMoXmumjli8E4rpyHXmCRTuhNPx/CUyS
	 WInbGMMiFUC5zSs9pHr8PxwCyqpB5wuc7JKCuxeUpN0kRgXoZGxqvfQa7V4g1vy5rx
	 ZH65cC0egk0Ci+3m6DC56kCOdrLuHafHqcTZryqxissLpfpqvBfJV2ic3TC07vc162
	 RfROEBIkvPkuXXvgAKSwnD/mFfgGAvEt56tgRD5v+f4HO83hOB4WBd+PYhwq8qpcDy
	 i72DKP36jvL0uRRmzITZ3Mi5v9M9T+T4Ofb3IqJI/SG7uD3ukIYC5fBX5+UwK2D10t
	 CdTwZpt9Q6Sag==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d07b400bb8so21160871fa.2;
        Fri, 02 Feb 2024 08:45:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUj1kZAeWoXLMvCXfOu2t6fvVDEo//bRokvfTSLpvBsMzg7brLUde90oSd5P/jmOEZLPyM0T4KM102EZzbFpoCTC32BaPWuZKYMHxDWjziqLBaHPgKgwuMaJYEU4cuM8u4LY1HA4zvF
X-Gm-Message-State: AOJu0Yymm66AvbUJXJqnu2P/PkzTBVbrnE/r3C9tF0xKIq0pOf0Qmtm9
	VCbAeu6XGlyx8nKn5BJUq8pD/EV1V7NQiAtRS1OIA6uxlfTgo594b3Epm5ZCUSdFwwDevhBR47y
	geAixtBVt+aduxIcR1MDanJ6huWE=
X-Google-Smtp-Source: AGHT+IEVsLTITAJ2OrzaTZdhtTYlPVrCreRMlehrq0ps5B01+fszECj/LB2WI4jZuRlSw3VuVUVh8K42fS/pgildxQw=
X-Received: by 2002:a05:651c:1249:b0:2d0:87ea:a132 with SMTP id
 h9-20020a05651c124900b002d087eaa132mr1347084ljh.27.1706892332395; Fri, 02 Feb
 2024 08:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202163433.786581-1-abrestic@rivosinc.com> <20240202163433.786581-3-abrestic@rivosinc.com>
In-Reply-To: <20240202163433.786581-3-abrestic@rivosinc.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 2 Feb 2024 17:45:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH7=9-Ww_z6a4Z5K8MrbH8x17Y3EzYk9Qf-3PL-JgMcww@mail.gmail.com>
Message-ID: <CAMj1kXH7=9-Ww_z6a4Z5K8MrbH8x17Y3EzYk9Qf-3PL-JgMcww@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: Don't add memblocks for unusable memory
To: Andrew Bresticker <abrestic@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 17:34, Andrew Bresticker <abrestic@rivosinc.com> wrote:
>
> Adding memblocks (even if nomap) for such regions unnecessarily consumes
> resources by creating struct pages for memory that may never be used or,
> in the case of soft-reserved regions, prevents the memory from later
> being hotplugged in by dax_kmem. This is also consistent with how x86
> handles unusable memory found in the EFI memory map.
>

x86 doesn't care as much about memory vs device semantics as ARM does.

This affects the output of memblock_is_[region_]memory(), so we'd have
to double check that none of those uses get broken by this.

If the soft reserved regions need to be omitted from memblock, we can
deal with that separately perhaps, but changing it at this level seems
inappropriate to me.


> Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> ---
>  drivers/firmware/efi/efi-init.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index d4987d013080..f05bacac89b7 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -24,13 +24,6 @@
>
>  unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
>
> -static int __init is_memory(efi_memory_desc_t *md)
> -{
> -       if (md->attribute & (EFI_MEMORY_WB|EFI_MEMORY_WT|EFI_MEMORY_WC))
> -               return 1;
> -       return 0;
> -}
> -
>  /*
>   * Translate a EFI virtual address into a physical address: this is necessary,
>   * as some data members of the EFI system table are virtually remapped after
> @@ -195,12 +188,9 @@ static __init void reserve_regions(void)
>                 memrange_efi_to_native(&paddr, &npages);
>                 size = npages << PAGE_SHIFT;
>
> -               if (is_memory(md)) {
> +               if (is_usable_memory(md)) {
>                         early_init_dt_add_memory_arch(paddr, size);
>
> -                       if (!is_usable_memory(md))
> -                               memblock_mark_nomap(paddr, size);
> -
>                         /* keep ACPI reclaim memory intact for kexec etc. */
>                         if (md->type == EFI_ACPI_RECLAIM_MEMORY)
>                                 memblock_reserve(paddr, size);
> --
> 2.34.1
>

