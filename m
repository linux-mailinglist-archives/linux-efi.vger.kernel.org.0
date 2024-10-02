Return-Path: <linux-efi+bounces-1884-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703A498E20C
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 20:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32222284BF1
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406D91D1E8F;
	Wed,  2 Oct 2024 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ3GPpGF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035B8F58;
	Wed,  2 Oct 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892359; cv=none; b=THhmZCJe8SuAGufJL/8S0cqavhctUM6ROMeIRPOmEfPLMt8kMbl0GUDgn9fGcfAs5azH+M6nYtpeFEbu/SU8iWZVrJlFVnxRGqhSHQgXUzownLrSj8AGN2ak8VOpjcxo34PFU9YFArPmgzWnjgEfw/QIoniJso1lHP69HfpNBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892359; c=relaxed/simple;
	bh=Ln99NhDjCirxEjvqCHh0VcaSc9mCmGJoYsavNLwPD4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vl7zFTQE1i9hL6l51zyVyIaBkht85C7e0u9lSh+nz3zXEX4JLx2v9Cm4fuNVYg7EfuLNhgp9CL/1deskOqqH0vxl5bjVBrhQSYgBL8MoT9JUjs0g/LM4lJqkwv+qeOvA1jCTj76z50IIU4esd1VzKESXxc12FKRT/aknoMWI9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ3GPpGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E364C4CED1;
	Wed,  2 Oct 2024 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727892358;
	bh=Ln99NhDjCirxEjvqCHh0VcaSc9mCmGJoYsavNLwPD4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nQ3GPpGF0I30lMz8RjZnQ5wdYocC7z2FRlLQXesBlGo3Zi5dd3m0taDYo06teTj9Q
	 +CGWUiWiXaRA5jiW0iYEA4WPYB0+v1KlVavp+yf2qRkNX9O9jbVNFPpvqCAKrrNbNw
	 l8fnHK+jWJMnzaFk7s3ESgZM/CtFglWMOUMIT+4j/P4vknKYEGJT/TnlX4lVe5fhon
	 D+KE4d81a5ydof6lz3VhaWcQmJ8J7QktxYIua2g5tclYrTn8gjGr7SF1FMuykOy30w
	 WB11O0iPWGTjAr+2x7wql+DSdvVqF1K1u5lLPqdVRsVd2SOeGN3AVh7qF8PMDuJePk
	 nrGeCBO2p9APg==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e1b50fea4bso56385eaf.2;
        Wed, 02 Oct 2024 11:05:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU89RnFLov/Djw4WAORMIDUqTUDFxH/uPfIuqjtitC0nmaFDDTYPkZyenHhKsKSLKEkzWfWLjMwEYNBzt+p@vger.kernel.org, AJvYcCVssxMvQcEQY1u5BPsFBDta4LwioVQQdsxY90LL3ykga2bsilv7QPR1j+edkhRVKeVonapGNBjUW/hX@vger.kernel.org, AJvYcCXlY0206DBD4CP2OCqqiJidque21Wvh1t+jxWHXDfVWpc+w4XvGBFoF6BieK2BXCxGbYbzpRfb9dHDe@vger.kernel.org
X-Gm-Message-State: AOJu0YznnQVRfkB+JGxOBelcLZzPOzjzKjtg0D0HIsaQO/+JiwAOWReU
	WSc2bkrIVqYUgHK6dwbMhTFzggavYXFiUVweqznhfrcI2xz2XUWCqJFuQj4qe2GFUqLQ3zOeCVh
	584FeZgF3+D0gB1LwY2mPTfXof1w=
X-Google-Smtp-Source: AGHT+IG9sQAST+6AxF9rzwFDOndtv0UjcO0N3mT2mMdvMo5FyWFnC0QiDLheiTJsjndv8R4ephGS1FN3dJ19nDhv6os=
X-Received: by 2002:a05:6871:5c8:b0:277:d7f1:db53 with SMTP id
 586e51a60fabf-28788a7309bmr2801459fac.17.1727892357858; Wed, 02 Oct 2024
 11:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911155536.3900579-1-kobak@nvidia.com>
In-Reply-To: <20240911155536.3900579-1-kobak@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Oct 2024 20:05:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gQVPcmMNL4J7UskHsTx8vugJ6pZ_T=Ob3qjsrGmhnFAw@mail.gmail.com>
Message-ID: <CAJZ5v0gQVPcmMNL4J7UskHsTx8vugJ6pZ_T=Ob3qjsrGmhnFAw@mail.gmail.com>
Subject: Re: [PATCH V5] acpi/prmt: find block with specific type
To: KobaK <kobak@nvidia.com>
Cc: Matt Ochs <mochs@nvidia.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
	linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 5:55=E2=80=AFPM KobaK <kobak@nvidia.com> wrote:
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
>     [Firmware Bug]: Unable to handle paging request in EFI runtime servic=
e
>     WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c=
:341
>         __efi_queue_work+0x11c/0x170
>     Call trace:
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
> If no suitable block is found, a warning message will be prompted
> but the procedue continues to manage the next prm handler.
> However, if the prm handler is actullay called without proper allocation,
> it would result in a failure during error handling.
>
> By using the correct memory types for runtime services,
> Ensure that the PRM handler and the context are
> properly mapped in the virtual address space during runtime,
> preventing the paging request error.
>
> [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.p=
df

I need input from EFI people on this, so can you please resend the
patch with a CC to linux-efi@vger.kernel.org?

> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for th=
e PlatformRtMechanism subtype")
> Signed-off-by: KobaK <kobak@nvidia.com>
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> ---
> V2:
> 1. format the changelog and add more about error handling.
> 2. replace goto
> V3: Warn if parts of handler are missed during va-pa translating.
> V4: Fix the 0day
> V5: Fix typo and pr_warn warning
> ---
>  drivers/acpi/prmt.c | 49 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index c78453c74ef5..cd4a7f5491d6 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -72,15 +72,17 @@ struct prm_module_info {
>         struct prm_handler_info handlers[] __counted_by(handler_count);
>  };
>
> -static u64 efi_pa_va_lookup(u64 pa)
> +static u64 efi_pa_va_lookup(u64 pa, u32 type)
>  {
>         efi_memory_desc_t *md;
>         u64 pa_offset =3D pa & ~PAGE_MASK;
>         u64 page =3D pa & PAGE_MASK;
>
>         for_each_efi_memory_desc(md) {
> -               if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE =
* md->num_pages)
> +               if ((md->type =3D=3D type) &&
> +                       (md->phys_addr < pa && pa < md->phys_addr + PAGE_=
SIZE * md->num_pages)) {
>                         return pa_offset + md->virt_addr + page - md->phy=
s_addr;
> +               }
>         }
>
>         return 0;
> @@ -148,9 +150,18 @@ acpi_parse_prmt(union acpi_subtable_headers *header,=
 const unsigned long end)
>                 th =3D &tm->handlers[cur_handler];
>
>                 guid_copy(&th->guid, (guid_t *)handler_info->handler_guid=
);
> -               th->handler_addr =3D (void *)efi_pa_va_lookup(handler_inf=
o->handler_address);
> -               th->static_data_buffer_addr =3D efi_pa_va_lookup(handler_=
info->static_data_buffer_address);
> -               th->acpi_param_buffer_addr =3D efi_pa_va_lookup(handler_i=
nfo->acpi_param_buffer_address);
> +               th->handler_addr =3D
> +                       (void *)efi_pa_va_lookup(handler_info->handler_ad=
dress, EFI_RUNTIME_SERVICES_CODE);
> +               th->static_data_buffer_addr =3D
> +                       efi_pa_va_lookup(handler_info->static_data_buffer=
_address, EFI_RUNTIME_SERVICES_DATA);
> +               th->acpi_param_buffer_addr =3D
> +                       efi_pa_va_lookup(handler_info->acpi_param_buffer_=
address, EFI_RUNTIME_SERVICES_DATA);
> +
> +               if (!th->handler_addr || !th->static_data_buffer_addr || =
!th->acpi_param_buffer_addr)
> +                       pr_warn(
> +                               "Idx: %llu, Parts of handler(GUID: %pUL) =
are missed, handler_addr %p, data_addr %p, param_addr %p",
> +                               cur_handler, &th->guid, th->handler_addr,
> +                               (void *)th->static_data_buffer_addr, (voi=
d *)th->acpi_param_buffer_addr);
>         } while (++cur_handler < tm->handler_count && (handler_info =3D g=
et_next_handler(handler_info)));
>
>         return 0;
> @@ -250,8 +261,16 @@ static acpi_status acpi_platformrt_space_handler(u32=
 function,
>
>                 handler =3D find_prm_handler(&buffer->handler_guid);
>                 module =3D find_prm_module(&buffer->handler_guid);
> -               if (!handler || !module)
> -                       goto invalid_guid;
> +               if (!handler || !module) {
> +                       buffer->prm_status =3D PRM_HANDLER_GUID_NOT_FOUND=
;
> +                       return AE_OK;
> +               }
> +
> +               if (!handler->handler_addr || !handler->static_data_buffe=
r_addr ||
> +                       !handler->acpi_param_buffer_addr) {
> +                       buffer->prm_status =3D PRM_HANDLER_ERROR;
> +                       return AE_OK;
> +               }
>
>                 ACPI_COPY_NAMESEG(context.signature, "PRMC");
>                 context.revision =3D 0x0;
> @@ -274,8 +293,10 @@ static acpi_status acpi_platformrt_space_handler(u32=
 function,
>         case PRM_CMD_START_TRANSACTION:
>
>                 module =3D find_prm_module(&buffer->handler_guid);
> -               if (!module)
> -                       goto invalid_guid;
> +               if (!module) {
> +                       buffer->prm_status =3D PRM_HANDLER_GUID_NOT_FOUND=
;
> +                       return AE_OK;
> +               }
>
>                 if (module->updatable)
>                         module->updatable =3D false;
> @@ -286,8 +307,10 @@ static acpi_status acpi_platformrt_space_handler(u32=
 function,
>         case PRM_CMD_END_TRANSACTION:
>
>                 module =3D find_prm_module(&buffer->handler_guid);
> -               if (!module)
> -                       goto invalid_guid;
> +               if (!module) {
> +                       buffer->prm_status =3D PRM_HANDLER_GUID_NOT_FOUND=
;
> +                       return AE_OK;
> +               }
>
>                 if (module->updatable)
>                         buffer->prm_status =3D UPDATE_UNLOCK_WITHOUT_LOCK=
;
> @@ -302,10 +325,6 @@ static acpi_status acpi_platformrt_space_handler(u32=
 function,
>         }
>
>         return AE_OK;
> -
> -invalid_guid:
> -       buffer->prm_status =3D PRM_HANDLER_GUID_NOT_FOUND;
> -       return AE_OK;
>  }
>
>  void __init init_prmt(void)
> --
> 2.43.0
>
>

