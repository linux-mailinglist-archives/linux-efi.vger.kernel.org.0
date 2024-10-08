Return-Path: <linux-efi+bounces-1920-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE59E993F5B
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2024 09:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17D61C249C7
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2024 07:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2849D18CBF1;
	Tue,  8 Oct 2024 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvvR5449"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA592381B1;
	Tue,  8 Oct 2024 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728369931; cv=none; b=EPbGk9VX1UPEeadGA9RbL24lJS/L7+3Un7PclV08RXwwTIT4LPw0/Oo8FGov0UHkK9d9YeeQ7/P30s7DM1bcGl9gxJjHL7UJPwIHR97JNCb/h65BV4eP/vf1p1+l2NPgTtkmi4i3scE6aoM5n/jT71d54IOcihCb9Ladxl9MHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728369931; c=relaxed/simple;
	bh=cIrzPxQeyCDdavc8DlxXD3nlhNwGLYImI5FKpYJP0Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYF7m7VA3lexh2mVcCg76zOk0iEYtfKLYSTX5XMA0nB+Q2dJvxx4qJOgn8zx3W9HtZiOVDuo1Lc1plBBwy7x3rq9Ks0H82G0FAL4lKWx+Q2hXrTUqo9zstQBK74evFQanWzkoQJ5fPVtR15KtONc1en3eXGzIpDQYBOxb3rufvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvvR5449; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F436C4CED1;
	Tue,  8 Oct 2024 06:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728369930;
	bh=cIrzPxQeyCDdavc8DlxXD3nlhNwGLYImI5FKpYJP0Sg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fvvR5449c6iPXu2st1ZGLSrOVvguj0dAcYEeSMI+6fPkIoeRnjf9Vu6EhburhzzB3
	 kV5mSLFufsRvF30srsxrnxtrB5+ywnEdjb6Z8SeL/p1znl74inhLpXlGE03MxGDAlc
	 G5os05yPmllLaImj5FK1Tk6hMDF0tBdtahAv8lPuw4Eh7y6sx0eLcvs3YnAsOGbqYT
	 FEw2IqVeXpvi4aMKcas0QgCJXD0gXYErtdWemVcMfRWeQADGn6CAhjufVQxOyO61/m
	 7DDPUMXxXWFrk33HzX83wSxClblvFypvSQSLG1GNNYK9jzQPcVdFSRRGgUucdet153
	 JrkgnTTd7Dpsg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5399041167cso8162122e87.0;
        Mon, 07 Oct 2024 23:45:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjXSGaim4oGeSskz3WM3+Ndvblg7RIqb79p2rr60tFcz9wPQEiniKirCIA+/N+vipyZI3zWDgXwJVLe9MT@vger.kernel.org, AJvYcCWljEhAZ9lKoogYhyXSQ1de4MSWvknt/nj/69jwZGxeVUUml+74Gth/x8hMMTGarqWVdFMJUooaqw6S@vger.kernel.org, AJvYcCX67szMPXtGmDHGeBPLl7D1BUIRh3hy/Li2IeU2kaclpz+YCUCVFlMSvEdJ5SHEGWNFd4raMUBq6w59@vger.kernel.org
X-Gm-Message-State: AOJu0YzOqbU93LIYh5VBP2tEK1qJbsBVukDEmwin8VhRHe0J6be68vLT
	IUdd849NTg4DeqtjUCPOfO5BDpeDkC6NPmJglHz3fqREGFXBStQDZXFYrFp3TWumxluwP94kkM1
	wRiee/yXwDbM7Pwc/d3aPhZe9gHc=
X-Google-Smtp-Source: AGHT+IH9nOMIZJOGcbEoCN3DtRbRftdvs9l+cZ858rssHYvQK4KnM+9x1fmsQNv2btEyHreGeJaqSsz1oxRF5agCZWo=
X-Received: by 2002:a05:6512:33ca:b0:536:a4f1:d214 with SMTP id
 2adb3069b0e04-539ab86693emr11035544e87.19.1728369928526; Mon, 07 Oct 2024
 23:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006153611.1165482-1-kobak@nvidia.com>
In-Reply-To: <20241006153611.1165482-1-kobak@nvidia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 8 Oct 2024 08:45:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHmOzcOPKgBzWn0DSQ0Ez4Yji1X9axnYmoprs1rDVL7-Q@mail.gmail.com>
Message-ID: <CAMj1kXHmOzcOPKgBzWn0DSQ0Ez4Yji1X9axnYmoprs1rDVL7-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2 V6] acpi/prmt: find block with specific type
To: KobaK <kobak@nvidia.com>
Cc: Matt Ochs <mochs@nvidia.com>, James Morse <james.morse@arm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Oct 2024 at 17:36, KobaK <kobak@nvidia.com> wrote:
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

You can drop the call trace from the commit log.

>       __efi_queue_work+0x11c/0x170
>       efi_call_acpi_prm_handler+0x68/0xd0
>       acpi_platformrt_space_handler+0x198/0x258
>       acpi_ev_address_space_dispatch+0x144/0x388
>       acpi_ex_access_region+0x9c/0x118
>       acpi_ex_write_serial_bus+0xc4/0x218
>       acpi_ex_write_data_to_field+0x168/0x218
>       acpi_ex_store_object_to_node+0x1a8/0x258
>       acpi_ex_store+0xec/0x330
>       acpi_ex_opcode_1A_1T_1R+0x15c/0x618
>       acpi_ds_exec_end_op+0x274/0x548
>       acpi_ps_parse_loop+0x10c/0x6b8
>       acpi_ps_parse_aml+0x140/0x3b0
>       acpi_ps_execute_method+0x12c/0x2a0
>       acpi_ns_evaluate+0x210/0x310
>       acpi_evaluate_object+0x178/0x358
>       acpi_proc_write+0x1a8/0x8a0 [acpi_call]
>       proc_reg_write+0xcc/0x150
>       vfs_write+0xd8/0x380
>       ksys_write+0x70/0x120
>       __arm64_sys_write+0x24/0x48
>       invoke_syscall.constprop.0+0x80/0xf8
>       do_el0_svc+0x50/0x110
>       el0_svc+0x48/0x1d0
>       el0t_64_sync_handler+0x15c/0x178
>       el0t_64_sync+0x1a8/0x1b0
>
> Find a block with specific type to fix this.
> prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler and
> find a block with EFI_RUNTIME_SERVICES_CODE for prm context.

This is outdated now

> If no suitable block is found, a warning message will be prompted
> but the procedue continues to manage the next prm handler.

procedure

> However, if the prm handler is actullay called without proper allocation,

actually

> it would result in a failure during error handling.
>
> By using the correct memory types for runtime services,
> Ensure that the PRM handler and the context are

ensure

please capitalize PRM and PRMT consistently

> properly mapped in the virtual address space during runtime,
> preventing the paging request error.
>

The issue is really that only memory that has been remapped for
runtime by the firmware can be used by the PRM handler, and so the
region needs to have the EFI_MEMORY_RUNTIME attribute.

> [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
> Signed-off-by: Koba Ko <kobak@nvidia.com>
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> ---
> V2:
> 1. format the changelog and add more about error handling.
> 2. replace goto
> V3: Warn if parts of handler are missed during va-pa translating.
> V4: Fix the 0day
> V5: Fix typo and pr_warn warning
> V6: use EFI_MOMOERY_RUNTIME to find block and split goto refactor as a single
> patch
> ---
>  drivers/acpi/prmt.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 1cfaa5957ac4..970207bc8f4a 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -79,8 +79,10 @@ static u64 efi_pa_va_lookup(u64 pa)
>         u64 page = pa & PAGE_MASK;
>
>         for_each_efi_memory_desc(md) {
> -               if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
> +               if ((md->attribute & EFI_MEMORY_RUNTIME) &&
> +                       (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {

Please indent with 4 spaces so the ( line up vertically

>                         return pa_offset + md->virt_addr + page - md->phys_addr;
> +               }
>         }
>
>         return 0;
> @@ -149,8 +151,20 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
>
>                 guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
>                 th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
> +               if (!th->handler_addr)
> +                       pr_warn("Idx: %llu, failed to find VA for handler_addr(GUID: %pUL, PA: %p)",
> +                               cur_handler, &th->guid, th->handler_addr);
> +
>                 th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
> +               if (!th->static_data_buffer_addr)
> +                       pr_warn("Idx: %llu, failed to find VA for data_addr(GUID: %pUL, PA: %p)",
> +                               cur_handler, &th->guid, (void *)th->static_data_buffer_addr);
> +
>                 th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
> +               if (!th->acpi_param_buffer_addr)
> +                       pr_warn("Idx: %llu, failed to find VA for param_addr(GUID: %pUL, PA: %p)",
> +                               cur_handler, &th->guid, (void *)th->acpi_param_buffer_addr);
> +

Can we move this warning into efi_pa_va_lookup() so we don't need to
duplicate it three times?

>         } while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
>
>         return 0;
> @@ -277,6 +291,12 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>                 if (!handler || !module)
>                         goto invalid_guid;
>
> +               if (!handler->handler_addr || !handler->static_data_buffer_addr ||
> +                       !handler->acpi_param_buffer_addr) {

Please split the condition into three lines, and use 4 spaces of
indentation on the continuation lines.

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
>

