Return-Path: <linux-efi+bounces-1887-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FFC98E4A3
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 23:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6011C284766
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30E217337;
	Wed,  2 Oct 2024 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaacTp+/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4431D1E60;
	Wed,  2 Oct 2024 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903510; cv=none; b=atvtM3FyDqBRa3yinT+Czve5q/609Rvd2W1SxP0fQgACUuPuaRTUVtqDiHzRfOnXOR5I3mjAwXA8TxMby4jRHfGwdERU9Xz9d7rPdad11QOlekn0XbMTcxKuTlA0VZVTc75JTe7dnSdeoVgovGbWrvxH0ZLIqcJKOkYOxbUc2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903510; c=relaxed/simple;
	bh=h2hkGlrWp+ilrEQxBBn348t9IrI0rV3FgPcHG9zYLCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvb6eyzJYAVJzsPY7qZyi3qshFPuyt7JrVryJTzVOSeU+KanKTyzKkTqp2bTGROp9TvK+hGrwtGmag2rirP2DETKp7KzYR/905MupLWMtMpulsOfTErQiznkdXLdbYl8ujpOKnu9JEy4+k5y3zVCX/FWz8cwaHnju9QP3bs6o5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaacTp+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FEDC4CECF;
	Wed,  2 Oct 2024 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727903509;
	bh=h2hkGlrWp+ilrEQxBBn348t9IrI0rV3FgPcHG9zYLCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GaacTp+/lYKvPZc+QQOBDr6qF9Z0L+71MJr0a9x7rzxmWL2ZWYig/1foGU1yAoW+P
	 pnC27yiW0bjhdH1VLP0WxzL4W1/0MKmfHTAhRUEcJR619/JEXUs/J+3ekS5uyadn/n
	 fsQwBRHxhJOxtMA3CesxgsmOFXid3xmlZA7shR3YeyEkqEc0/Mr6CsxXknvJ165/VL
	 w2rYcnJkJXmMbthc1nKS9yKD2ZTNC6Y/hDhCQ8Wrua3/Y6RO5A3ijmim58UFciWKWX
	 4b1VYbDzYcZhZnHyR0azkpSqUN/bXlMmXmccgYWu/ZfdSQERhLjh1P2QvhnEuMqhQM
	 UBisNjBKn9xHQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398996acbeso219407e87.1;
        Wed, 02 Oct 2024 14:11:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVM6RTXMKaLvNR117ZFw4+3hfK2fVEOCzHL9+1fpzyWfp86UirdtKTziZWvaR8MXjMsMdn+cjQSlAdd@vger.kernel.org, AJvYcCVl59wSgB6g0VmX9p//EBydX0D52x8vtiblnko72G2/OiznfD6uYzpc5fF1zxZhhXaE1f5+H0IN+s6d@vger.kernel.org, AJvYcCWWpllot7XiTuZ1RHlrip86SS+U6APA3rhfNIreb13e4RwuHaZylDRCepmrJAVORQLysIV+X28oBKmGn0cP@vger.kernel.org
X-Gm-Message-State: AOJu0YwYBYMT6BraNgkpOfzdccBYMVZgQN5umkJqy5HuGVRUiS5QPRkF
	bcGrR6DXWe91pUQoZI7MmRlDT/mKA76tTSUUpyZYYGgtiyQi0RNvn8PN8WqKemDf2DjCj/+H3+O
	i1bKqyO7iGtIyEPWPofHNskSCAsY=
X-Google-Smtp-Source: AGHT+IES9jvCPq3yE6PJbBdhAXs1kKVc6zV/xm0+yUBEGXFjN18dIfZ9NuoUPGUzoC+CA1o24HpqcmQDU+MZIJmqL+I=
X-Received: by 2002:a05:6512:10cd:b0:536:568f:c5ed with SMTP id
 2adb3069b0e04-539a06586f7mr2651783e87.1.1727903507817; Wed, 02 Oct 2024
 14:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911155536.3900579-1-kobak@nvidia.com> <CAJZ5v0gQVPcmMNL4J7UskHsTx8vugJ6pZ_T=Ob3qjsrGmhnFAw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gQVPcmMNL4J7UskHsTx8vugJ6pZ_T=Ob3qjsrGmhnFAw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 2 Oct 2024 23:11:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH+xsEj6vC-+z=NcNyGNA6EVePd35iToLB-J-8LhKdD-w@mail.gmail.com>
Message-ID: <CAMj1kXH+xsEj6vC-+z=NcNyGNA6EVePd35iToLB-J-8LhKdD-w@mail.gmail.com>
Subject: Re: [PATCH V5] acpi/prmt: find block with specific type
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: KobaK <kobak@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Oct 2024 at 20:06, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Sep 11, 2024 at 5:55=E2=80=AFPM KobaK <kobak@nvidia.com> wrote:
> >
> > PRMT needs to find the correct type of block to
> > translate the PA-VA mapping for EFI runtime services.
> >
> > The issue arises because the PRMT is finding a block of
> > type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
> > runtime services as described in Section 2.2.2 (Runtime
> > Services) of the UEFI Specification [1]. Since the PRM handler is
> > a type of runtime service, this causes an exception
> > when the PRM handler is called.
> >
> >     [Firmware Bug]: Unable to handle paging request in EFI runtime serv=
ice
> >     WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers=
.c:341
> >         __efi_queue_work+0x11c/0x170
> >     Call trace:
> >       __efi_queue_work+0x11c/0x170
> >       efi_call_acpi_prm_handler+0x68/0xd0
> >       acpi_platformrt_space_handler+0x198/0x258
> >       acpi_ev_address_space_dispatch+0x144/0x388
> >       acpi_ex_access_region+0x9c/0x118
> >       acpi_ex_write_serial_bus+0xc4/0x218
> >       acpi_ex_write_data_to_field+0x168/0x218
> >       acpi_ex_store_object_to_node+0x1a8/0x258
> >       acpi_ex_store+0xec/0x330
> >       acpi_ex_opcode_1A_1T_1R+0x15c/0x618
> >       acpi_ds_exec_end_op+0x274/0x548
> >       acpi_ps_parse_loop+0x10c/0x6b8
> >       acpi_ps_parse_aml+0x140/0x3b0
> >       acpi_ps_execute_method+0x12c/0x2a0
> >       acpi_ns_evaluate+0x210/0x310
> >       acpi_evaluate_object+0x178/0x358
> >       acpi_proc_write+0x1a8/0x8a0 [acpi_call]
> >       proc_reg_write+0xcc/0x150
> >       vfs_write+0xd8/0x380
> >       ksys_write+0x70/0x120
> >       __arm64_sys_write+0x24/0x48
> >       invoke_syscall.constprop.0+0x80/0xf8
> >       do_el0_svc+0x50/0x110
> >       el0_svc+0x48/0x1d0
> >       el0t_64_sync_handler+0x15c/0x178
> >       el0t_64_sync+0x1a8/0x1b0
> >
> > Find a block with specific type to fix this.
> > prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler and
> > find a block with EFI_RUNTIME_SERVICES_CODE for prm context.
> > If no suitable block is found, a warning message will be prompted
> > but the procedue continues to manage the next prm handler.
> > However, if the prm handler is actullay called without proper allocatio=
n,
> > it would result in a failure during error handling.
> >
> > By using the correct memory types for runtime services,
> > Ensure that the PRM handler and the context are
> > properly mapped in the virtual address space during runtime,
> > preventing the paging request error.
> >
> > [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29=
.pdf
>
> I need input from EFI people on this, so can you please resend the
> patch with a CC to linux-efi@vger.kernel.org?
>
> > Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for =
the PlatformRtMechanism subtype")
> > Signed-off-by: KobaK <kobak@nvidia.com>

Please use your full name.

> > Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> > ---
> > V2:
> > 1. format the changelog and add more about error handling.
> > 2. replace goto
> > V3: Warn if parts of handler are missed during va-pa translating.
> > V4: Fix the 0day
> > V5: Fix typo and pr_warn warning
> > ---
> >  drivers/acpi/prmt.c | 49 +++++++++++++++++++++++++++++++--------------
> >  1 file changed, 34 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> > index c78453c74ef5..cd4a7f5491d6 100644
> > --- a/drivers/acpi/prmt.c
> > +++ b/drivers/acpi/prmt.c
> > @@ -72,15 +72,17 @@ struct prm_module_info {
> >         struct prm_handler_info handlers[] __counted_by(handler_count);
> >  };
> >
> > -static u64 efi_pa_va_lookup(u64 pa)
> > +static u64 efi_pa_va_lookup(u64 pa, u32 type)
> >  {
> >         efi_memory_desc_t *md;
> >         u64 pa_offset =3D pa & ~PAGE_MASK;
> >         u64 page =3D pa & PAGE_MASK;
> >
> >         for_each_efi_memory_desc(md) {
> > -               if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZ=
E * md->num_pages)
> > +               if ((md->type =3D=3D type) &&
> > +                       (md->phys_addr < pa && pa < md->phys_addr + PAG=
E_SIZE * md->num_pages)) {
> >                         return pa_offset + md->virt_addr + page - md->p=
hys_addr;
> > +               }
> >         }
> >
> >         return 0;
> > @@ -148,9 +150,18 @@ acpi_parse_prmt(union acpi_subtable_headers *heade=
r, const unsigned long end)
> >                 th =3D &tm->handlers[cur_handler];
> >
> >                 guid_copy(&th->guid, (guid_t *)handler_info->handler_gu=
id);
> > -               th->handler_addr =3D (void *)efi_pa_va_lookup(handler_i=
nfo->handler_address);
> > -               th->static_data_buffer_addr =3D efi_pa_va_lookup(handle=
r_info->static_data_buffer_address);
> > -               th->acpi_param_buffer_addr =3D efi_pa_va_lookup(handler=
_info->acpi_param_buffer_address);
> > +               th->handler_addr =3D
> > +                       (void *)efi_pa_va_lookup(handler_info->handler_=
address, EFI_RUNTIME_SERVICES_CODE);

Wouldn't it make more sense to test the EFI_MEMORY_RUNTIME attribute
rather than expecting/assuming a certain memory type in each case?
That attribute is precisely what controls whether or not a region has
been remapped into the firmware's page tables.

> > +               th->static_data_buffer_addr =3D
> > +                       efi_pa_va_lookup(handler_info->static_data_buff=
er_address, EFI_RUNTIME_SERVICES_DATA);
> > +               th->acpi_param_buffer_addr =3D
> > +                       efi_pa_va_lookup(handler_info->acpi_param_buffe=
r_address, EFI_RUNTIME_SERVICES_DATA);
> > +
> > +               if (!th->handler_addr || !th->static_data_buffer_addr |=
| !th->acpi_param_buffer_addr)
> > +                       pr_warn(
> > +                               "Idx: %llu, Parts of handler(GUID: %pUL=
) are missed, handler_addr %p, data_addr %p, param_addr %p",

Please improve this diagnostic: 'are missed' is not very helpful.


> > +                               cur_handler, &th->guid, th->handler_add=
r,
> > +                               (void *)th->static_data_buffer_addr, (v=
oid *)th->acpi_param_buffer_addr);
> >         } while (++cur_handler < tm->handler_count && (handler_info =3D=
 get_next_handler(handler_info)));
> >
> >         return 0;
> > @@ -250,8 +261,16 @@ static acpi_status acpi_platformrt_space_handler(u=
32 function,
> >
> >                 handler =3D find_prm_handler(&buffer->handler_guid);
> >                 module =3D find_prm_module(&buffer->handler_guid);
> > -               if (!handler || !module)
> > -                       goto invalid_guid;
> > +               if (!handler || !module) {
> > +                       buffer->prm_status =3D PRM_HANDLER_GUID_NOT_FOU=
ND;
> > +                       return AE_OK;
> > +               }
> > +
> > +               if (!handler->handler_addr || !handler->static_data_buf=
fer_addr ||
> > +                       !handler->acpi_param_buffer_addr) {
> > +                       buffer->prm_status =3D PRM_HANDLER_ERROR;
> > +                       return AE_OK;
> > +               }
> >
> >                 ACPI_COPY_NAMESEG(context.signature, "PRMC");
> >                 context.revision =3D 0x0;
> > @@ -274,8 +293,10 @@ static acpi_status acpi_platformrt_space_handler(u=
32 function,
> >         case PRM_CMD_START_TRANSACTION:
> >
> >                 module =3D find_prm_module(&buffer->handler_guid);
> > -               if (!module)
> > -                       goto invalid_guid;
> > +               if (!module) {
> > +                       buffer->prm_status =3D PRM_HANDLER_GUID_NOT_FOU=
ND;
> > +                       return AE_OK;
> > +               }

What is the reason for this change, and the ones down below?

> >
> >                 if (module->updatable)
> >                         module->updatable =3D false;
> > @@ -286,8 +307,10 @@ static acpi_status acpi_platformrt_space_handler(u=
32 function,
> >         case PRM_CMD_END_TRANSACTION:
> >
> >                 module =3D find_prm_module(&buffer->handler_guid);
> > -               if (!module)
> > -                       goto invalid_guid;
> > +               if (!module) {
> > +                       buffer->prm_status =3D PRM_HANDLER_GUID_NOT_FOU=
ND;
> > +                       return AE_OK;
> > +               }
> >
> >                 if (module->updatable)
> >                         buffer->prm_status =3D UPDATE_UNLOCK_WITHOUT_LO=
CK;
> > @@ -302,10 +325,6 @@ static acpi_status acpi_platformrt_space_handler(u=
32 function,
> >         }
> >
> >         return AE_OK;
> > -
> > -invalid_guid:
> > -       buffer->prm_status =3D PRM_HANDLER_GUID_NOT_FOUND;
> > -       return AE_OK;
> >  }
> >
> >  void __init init_prmt(void)
> > --
> > 2.43.0
> >
> >
>

