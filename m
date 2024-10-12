Return-Path: <linux-efi+bounces-1950-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6529B99B6C2
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 21:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15964282BF3
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 19:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B0C84FAD;
	Sat, 12 Oct 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOuDcf7V"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C2364A9;
	Sat, 12 Oct 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728761818; cv=none; b=diYTu3jde83IJgixbDLWhiqDTUKCv5ajhGKRtMCzoECOxonrwWmoLz2nXDt6A6pKXZHrBlKHY3Vl2yQdGh7qA9ExUCs0J0AsWeW9a6Fqs7ZT6iet13IWbDyV33QagcAhiIyilDCz/EMvuq+t3ZmWQ/brDcdwcA0QXW2NVm63fok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728761818; c=relaxed/simple;
	bh=tRzsr1U++A0KzqbkgnOR9fYTpBL7Jm0eT6coJMooBMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJJBZJSkA2H9xvyN960TaYP3aQmhpguYqTHHVXW/Bbk1FHFflAXrth/JQ9R5wLXM6joOwGt39eH/0rMzhv/DSjo9HoM13MuyaqcLDNCLHOOxz8s52P0G7BnAVKmbwQXOk1dcF+TCwRIZ0PheLwfmbWv4sttRK06GooM/shXYnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOuDcf7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A20C4CECE;
	Sat, 12 Oct 2024 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728761817;
	bh=tRzsr1U++A0KzqbkgnOR9fYTpBL7Jm0eT6coJMooBMw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VOuDcf7V8uJ/dk/vtLgSM5lyjbiIXrAG3NVHh8HxsQYn26y4onTmelkiTlzerHcER
	 dFR4cA1I+jLdcyBymTWPsr/zBMKvELqWCwKOW8gzt1hDHx+I8XYnT0/sAhrsYde3/2
	 +a9Xd9tVIDyWJT7OGP/076ynBwxPEU4TJxDYorrfDWlRHWD8pr1mA6GfgSy4gz3hjm
	 EQsDheGfy/5ePtxFv6nY8RFyzMqyKUnK6YZQTdl2pTYpvAgUwyERvZ86cqpsbl/huG
	 o5tQSk5s9pfuSR9rxBT9YcrDkxDE0SMdQnpRdr1uDPXk/6SbOIyVouFbys41H5hLCP
	 qoNQ+bCKrUr7Q==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e8607c2aso518910e87.3;
        Sat, 12 Oct 2024 12:36:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXyWbAdnLMsuHaPa1+OXbp3QfEPzwdC6lqVXj3tLz2pum+/GB7eXblSI3h45DdcXvtJ82GSsfjjWXg1R8S@vger.kernel.org, AJvYcCVxPAwtllZwVnYNvn4fDOyz/kg5RAEJeMu1PFnY6HULxsUdKIEQF2izfH2XBsr7qmpPJn3wKh6byiDl@vger.kernel.org, AJvYcCWlve1/RalQnjfr1sm5HM1WXsu2K8BFoBslo1x8XDA9kcy0GifBA5XBTY5qKgz+Btm3rJxKlyEORHTD@vger.kernel.org
X-Gm-Message-State: AOJu0YySP93/EnlGpFmXEFNOh9TbMhKC3T5yB9BBM9h7Nl9t29Crpbtu
	OEg/T2LKwpU9gPQ7dz7gkm9A7KJ5Df39eQGE3gG8hcBrWY3t86D2Vz8fTjRAY6qdci18DzODM0Y
	dLy4N0QQP6qs90w5wD59yO7sO2uc=
X-Google-Smtp-Source: AGHT+IGeFtAgvHQzRQNdUk4jiNN8jeQYCAHHUW6wENFttIVaaAbx8a4LaIvKYeaAa00kgJ7+WxWY2Mgh5lbtE5I/imM=
X-Received: by 2002:a05:6512:3503:b0:539:8b81:7f04 with SMTP id
 2adb3069b0e04-539da4d5787mr3035448e87.32.1728761816233; Sat, 12 Oct 2024
 12:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012191612.3586797-1-kobak@nvidia.com>
In-Reply-To: <20241012191612.3586797-1-kobak@nvidia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 12 Oct 2024 21:36:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE2D56oYP4mPzBxCzjiUH34HfhnWeBcbzL_gYWdvy0j7g@mail.gmail.com>
Message-ID: <CAMj1kXE2D56oYP4mPzBxCzjiUH34HfhnWeBcbzL_gYWdvy0j7g@mail.gmail.com>
Subject: Re: [PATCH V8] acpi/prmt: find block with specific type
To: KobaK <kobak@nvidia.com>
Cc: Matt Ochs <mochs@nvidia.com>, James Morse <james.morse@arm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Oct 2024 at 21:16, KobaK <kobak@nvidia.com> wrote:
>
> From: Koba Ko <kobak@nvidia.com>
>
> PRMT needs to find the correct type of block to
> translate the PA-VA mapping for EFI runtime services.
>
> The issue arises because the PRMT is finding a block of
> type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
> runtime services as described in Section 2.2.2 (Runtime
> Services) of the UEFI Specification [1]. Since the PRM handler is
> a type of runtime service, this causes an exception
> when the PRM handler is called.
>
>     [Firmware Bug]: Unable to handle paging request in EFI runtime service
>     WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c:341
>         __efi_queue_work+0x11c/0x170
>     Call trace:
>
> Find a block with specific type to fix this.
> PRMT find a block with EFI_MEMORY_RUNTIME for PRM handler and PRM context.
> If no suitable block is found, a warning message will be prompted
> but the procedure continues to manage the next PRM handler.
> However, if the PRM handler is actually called without proper allocation,
> it would result in a failure during error handling.
>
> By using the correct memory types for runtime services,
> ensure that the PRM handler and the context are
> properly mapped in the virtual address space during runtime,
> preventing the paging request error.
>
> The issue is really that only memory that has been remapped for
> runtime by the firmware can be used by the PRM handler, and so the
> region needs to have the EFI_MEMORY_RUNTIME attribute.
>
> [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
> cc: stable@vger.kernel.org
> Signed-off-by: Koba Ko <kobak@nvidia.com>
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> V2:
> 1. format the changelog and add more about error handling.
> 2. replace goto
> V3: Warn if parts of handler are missed during va-pa translating.
> V4: Fix the 0day
> V5: Fix typo and pr_warn warning
> V6: use EFI_MOMOERY_RUNTIME to find block and split goto refactor as a single
> patch
> V7:
> 1. refine the codes and commit description as per comments
> 2. drop goto refacotr
> V8: Fix 0day and cc to stable

'fix 0day' means nothing - please describe what the actual change is
compared to the previous version.

> ---
>  drivers/acpi/prmt.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 1cfaa5957ac4..552442bc10fd 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -72,17 +72,21 @@ struct prm_module_info {
>         struct prm_handler_info handlers[] __counted_by(handler_count);
>  };
>
> -static u64 efi_pa_va_lookup(u64 pa)
> +static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
>  {
>         efi_memory_desc_t *md;
>         u64 pa_offset = pa & ~PAGE_MASK;
>         u64 page = pa & PAGE_MASK;
>
>         for_each_efi_memory_desc(md) {
> -               if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
> +               if ((md->attribute & EFI_MEMORY_RUNTIME) &&
> +                   (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
>                         return pa_offset + md->virt_addr + page - md->phys_addr;
> +               }
>         }
>
> +       pr_warn("Failed to find VA for GUID: %pUL, PA: %p", guid, (void *)pa);
> +

'pa' is not a pointer so don't treat it as one - please drop the cast,
and use 0x%llx as the format specifier.

