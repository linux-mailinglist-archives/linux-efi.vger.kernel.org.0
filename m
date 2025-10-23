Return-Path: <linux-efi+bounces-5110-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E226FC01BCC
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 16:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4314C3B5319
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C372E2D5955;
	Thu, 23 Oct 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZexjWfku"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC21F8724
	for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228820; cv=none; b=Rq8mCeZRDxkVXsBovy+2CrFmnwpbNA1t/MQeVCH2JYgOQneN5BJnFOSC8QjZvnPR/ujO3We3H+TejaGC/T57Q/DdaXUFBqi7tzKlCKurH+Cuw3YGKxNo/U/Fj3PWTUsZKbGx41zWH2f0kH/p0HDBF4AnDaMxvzxEcEFP/kWMZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228820; c=relaxed/simple;
	bh=cZpeLUAcuryHPcdrxITI066SvmIhzzKTwSENhSqSg38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7DE4xQGPd59YYUSZHDzAgqwJeeeSn5wfTUXF3Q96TJbDVhBwXVqfymwV+qB/CwDuQUDXDkOOwbOVlYuBCPQEXcSrLLXAV5UTHm2OsIMZ6oXTu5a14AtewJ6jX5XVmt5lDgIuwPBfNvw2gnnT2HDTxc0yOTyhgXGS8y6A2x2IO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZexjWfku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB23C116C6
	for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761228820;
	bh=cZpeLUAcuryHPcdrxITI066SvmIhzzKTwSENhSqSg38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZexjWfkuM1Mnrohl/Rfjbhz03Qh2y244gv0V1ExhgW2AYGEX3k9CHHb6UVonzu4Uc
	 jQY9dsDPUSlqV+y3IJ2LLJc6yc9E0pD0EEO1fC7WE7TS69zMaE40YWnEkeVX1quzAX
	 qjJ+v09+zTlULgnrE/XIyMjlRL4timW5IcK2uBR+2UrKb9nAM0WsRBwHRUJpmlGexW
	 zqbULJN+LWfhm+g9gAIEsJWUwWwIxOkM6lDlxvkA8ZRTauRthqrliZlfgcHPn+5Brr
	 nFptX+i2+AcyKyvhcD/I1BHQli4STcY/oAkMIKu2jxyCgejYoInS6wvgN8K8uFOK/w
	 kSZCHruE8WoOQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57b35e176dbso1159845e87.1
        for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 07:13:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV891fPSyI3VMVw7ULg7vwSFlNdVk9Sl8ZoSnkTy1nPXwqkMeJ71to1DuyCrpFy3YWlYs4nb9i0T1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHBbnOpJThKck12yWYFklfqvmSef6vNGLQCPQZlqgReabDqkXq
	QvP/r4ccCiK1Rix/352bIH4kKRIqTGL6G0sP/oeU5x3MFISbEK1e8Yf6lhxZ0sPmCVEW/DzPxUx
	pxeHc8oic5ApN0rhbMYXUMh115bzZh6w=
X-Google-Smtp-Source: AGHT+IHO6/AXibCvANwIPz1i1SVGnWXIEXzs5+ih5K1pmNk7GVSQwJgh9sM1FbWbV7Sjq21NzIM2aNTWjm+g/kX+AtQ=
X-Received: by 2002:a05:6512:ad4:b0:592:f330:217 with SMTP id
 2adb3069b0e04-592f330065fmr2006781e87.31.1761228818734; Thu, 23 Oct 2025
 07:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022220755.1026144-1-usamaarif642@gmail.com> <20251022220755.1026144-3-usamaarif642@gmail.com>
In-Reply-To: <20251022220755.1026144-3-usamaarif642@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 23 Oct 2025 16:13:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEYYSc8=qMmDW6E2kRFawK34okGvq=rTuhvv5hVPsd-iw@mail.gmail.com>
X-Gm-Features: AS18NWARiLhzK3lWZNO_ocfdywm7tHpCV6F_eJg7_7UwW2CLn2dF03GBv3x4pbY
Message-ID: <CAMj1kXEYYSc8=qMmDW6E2kRFawK34okGvq=rTuhvv5hVPsd-iw@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi/libstub: Fix page table access in 5-level to
 4-level paging transition
To: Usama Arif <usamaarif642@gmail.com>
Cc: dwmw@amazon.co.uk, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org, 
	apopple@nvidia.com, thuth@redhat.com, nik.borisov@suse.com, kas@kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, kernel-team@meta.com, 
	Michael van der Westhuizen <rmikey@meta.com>, Tobias Fleig <tfleig@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 00:08, Usama Arif <usamaarif642@gmail.com> wrote:
>
> When transitioning from 5-level to 4-level paging, the existing code
> incorrectly accesses page table entries by directly dereferencing CR3
> and applying PAGE_MASK. This approach has several issues:
>
> - __native_read_cr3() returns the raw CR3 register value, which on
>   x86_64 includes not just the physical address but also flags Bits
>   above the physical address width of the system (i.e. above
>   __PHYSICAL_MASK_SHIFT) are also not masked.
> - The pgd value is masked by PAGE_SIZE which doesn't take into account
>   the higher bits such as _PAGE_BIT_NOPTISHADOW.
>
> Replace this with proper accessor functions:
> - read_cr3_pa(): Uses CR3_ADDR_MASK properly clearing SME encryption bit
>   and extracting only the physical address portion.
> - mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
>   flags above physical address (_PAGE_BIT_NOPTISHADOW in particular).
>
> Fixes: cb1c9e02b0c1 ("x86/efistub: Perform 4/5 level paging switch from the stub")
> Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Reported-by: Michael van der Westhuizen <rmikey@meta.com>
> Reported-by: Tobias Fleig <tfleig@meta.com>
> ---
>  drivers/firmware/efi/libstub/x86-5lvl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
> index f1c5fb45d5f7c..34b72da457487 100644
> --- a/drivers/firmware/efi/libstub/x86-5lvl.c
> +++ b/drivers/firmware/efi/libstub/x86-5lvl.c
> @@ -81,8 +81,11 @@ void efi_5level_switch(void)
>                 new_cr3 = memset(pgt, 0, PAGE_SIZE);
>                 new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
>         } else {
> +               pgd_t *pgdp;
> +
> +               pgdp = (pgd_t *)read_cr3_pa();

Shouldn't this be using native_read_cr3_pa()? And is there any reason
to re-read CR3 here, rather than update the code that populates the
cr3 variable? The preceding other branch of the if() should probably
use the same sanitised value of CR3, no?


>                 /* take the new root table pointer from the current entry #0 */
> -               new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
> +               new_cr3 = (u64 *)(pgd_val(pgdp[0]) & PTE_PFN_MASK);
>
>                 /* copy the new root table if it is not 32-bit addressable */
>                 if ((u64)new_cr3 > U32_MAX)
> --
> 2.47.3
>

