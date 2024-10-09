Return-Path: <linux-efi+bounces-1926-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55373996022
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 08:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E9D1C232FB
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A716B391;
	Wed,  9 Oct 2024 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2ky4dlH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC81547F0;
	Wed,  9 Oct 2024 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456633; cv=none; b=CRKGQz4ARVJItLTLBu3klOt4f1oYcNE7PMqqweaAj7veYEc9KWU3+caKRPTrZQtaLpNcvipEMTGVrOhxHj0Q6xaF5tEUdhYlXi8b2LKEN8YXqiwJt41gwidVnJC9KhMVqtfnH2PeaeGrHhfgWHlHPjKETcJODtpzL1SxCo+F70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456633; c=relaxed/simple;
	bh=7dRLVqirDkMhI7Do48VuLPt5cdTI++FZolVltJyhwlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPYUo+h0bmyJFjlWnmjC2NgVYRP2sbI079kOWzLVJKhnXeW6IejOJD40BrJMdt4uryweAG9p8dBq7SZxMb+Gci4gabPJubhq4X6BQkoGaHiIS7p0jPdei5kkwYYhOnOm63yA7YnJObHLylpsGfPZq+kwpTn7F7Xhh+1mEaI8bXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2ky4dlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA23C4CEC5;
	Wed,  9 Oct 2024 06:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728456633;
	bh=7dRLVqirDkMhI7Do48VuLPt5cdTI++FZolVltJyhwlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p2ky4dlHlMIX1zVcZEdEZP5jjP/GioDOAL3idbq+p5lHiTqOGL1VuRAWlqGHYOhSu
	 m2je1o7yaVNshIXnuqPxIttVeyOaQ7so1dNT0DSMAjlOzwUVuwF0new2J5p8lIl8CI
	 n+VBCaG0dKi5xcXHlQr5aoDZKDig+PfraDLBpFpcIctQOW98x6IEhjyJ0Vq1zQDr2n
	 2hrsq+jPkXBeudD5hW6fy+5HcaTDKH4RRTdamIX9nnMAu8XmRpeGDMkRUSyt5+6RiN
	 +aw//i0K4ykst1PiaDJ6YJG9hqpLvEZn0I0gZXShSJ+ZQr6xiH+pcnL+mtTyMJ/0LH
	 +Zr1l3cPopAXA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53991d05416so7975008e87.2;
        Tue, 08 Oct 2024 23:50:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoC7Rc0aSz+vUnUCsEN4ZVOYYZuR5XlVLfXUjWApOfnW9LlZccGRVxWC+ist7nvHYnN2P8w6uCb1r/@vger.kernel.org, AJvYcCWmAy2PZrqUU9q63g1jWC1XEFyBjI6LcXAMvI/xTCjJhowi9kvIyzRJENW7JlU0kVCINUsXJCMG0Afz@vger.kernel.org, AJvYcCXixLN4G52AffidiCqOZU9Mso2gFlSQ4i3X6kTo8xMw1b1g/Rhd60ZpI9AcldFmPqFYYflfHrRHbPojvcOJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw1V/b6Jgz99yJKCSVh6rqGA4GLGUIqOdBJb1lOdH4rtAXNnMM
	1dYbtaTx/BAqOjQZ8XqMxJnqd0n7Tgt7XstFc2VsafRDc+lk2rEl5x2UpqMih+bnTY5UNZmcxCr
	q/FNkIt2DCUGp4ceMsUv+Xh3RoF8=
X-Google-Smtp-Source: AGHT+IHDxANZNMM/51ZrtmeyfRxGBOO8vMlyrE3rPE9oBN8O49jRbpNTFIcvObyMtvioEte3wceMAWwLkgx6U81mowk=
X-Received: by 2002:a05:6512:1091:b0:539:8d9b:b61c with SMTP id
 2adb3069b0e04-539c4968056mr963410e87.51.1728456631673; Tue, 08 Oct 2024
 23:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009064517.2678456-1-kobak@nvidia.com>
In-Reply-To: <20241009064517.2678456-1-kobak@nvidia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Oct 2024 08:50:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGrS+z=Kx2uPaZPKbLFeKGEfKDQ61HOvRF7U5=akktS9w@mail.gmail.com>
Message-ID: <CAMj1kXGrS+z=Kx2uPaZPKbLFeKGEfKDQ61HOvRF7U5=akktS9w@mail.gmail.com>
Subject: Re: [PATCH V7] acpi/prmt: find block with specific type
To: KobaK <kobak@nvidia.com>
Cc: Matt Ochs <mochs@nvidia.com>, James Morse <james.morse@arm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Oct 2024 at 08:45, KobaK <kobak@nvidia.com> wrote:
>
> From: kobak <kobak@nvidia.com>
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
> Signed-off-by: Koba Ko <kobak@nvidia.com>
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

This needs a cc:stable too

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
> ---
>
>  drivers/acpi/prmt.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 1cfaa5957ac4..51f5ae3d4350 100644
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
> +       pr_warn("Failed to find VA for GUID: %pUL, PA: %p", guid, pa);
> +
>         return 0;
>  }
>
> @@ -148,9 +152,15 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
>                 th = &tm->handlers[cur_handler];
>
>                 guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
> -               th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
> -               th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
> -               th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
> +               th->handler_addr =
> +                       (void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
> +
> +               th->static_data_buffer_addr =
> +                       efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
> +
> +               th->acpi_param_buffer_addr =
> +                       efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
> +
>         } while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
>
>         return 0;
> @@ -277,6 +287,13 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>                 if (!handler || !module)
>                         goto invalid_guid;
>
> +               if (!handler->handler_addr ||
> +                   !handler->static_data_buffer_addr ||
> +                   !handler->acpi_param_buffer_addr) {
> +                       buffer->prm_status = PRM_HANDLER_ERROR;
> +                       return AE_OK;
> +               }
> +
>                 ACPI_COPY_NAMESEG(context.signature, "PRMC");
>                 context.revision = 0x0;
>                 context.reserved = 0x0;
> --
> 2.43.0
>

