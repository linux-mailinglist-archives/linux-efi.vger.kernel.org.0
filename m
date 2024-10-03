Return-Path: <linux-efi+bounces-1895-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32C98EB06
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 10:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7229288C56
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF8812F588;
	Thu,  3 Oct 2024 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWmzMzZ5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20974811E2;
	Thu,  3 Oct 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942711; cv=none; b=ghw3vVEeASyyRyw5qs1/ITeAU93TvEuud+BG1wa9erSacf/nmAm3dIWwcmZxNiQOSZEo1Ly+hCzjlgyuHc+NsvlN2KNUwFH41bU4BrBTXfh5HHF/tPBIisglU5bDpf1m8T9+ekksdQjjc7ZTq3w56VaxpGaRY3Rt5kyInD9cPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942711; c=relaxed/simple;
	bh=TZQRn6HBj+Hmqap/Gn9V0Nlxw8zKuq4PMP6Bu8AaazA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c23s3ZlZiI2TsYE8Ao03p33CU09XoP1llnRzHxjSaq3oSfowW7E215g674fLCdr4Lgf51C5ZSR6bp9XtsnpEgI7L/OcTQujI/qFspW5iGWyMbbhWuuzXlmIOH89ljc8rX+8Tz1jaB7905/e19Mxzvedi1/LsmBgy0yWV2dufzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWmzMzZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E21C4CEC7;
	Thu,  3 Oct 2024 08:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727942710;
	bh=TZQRn6HBj+Hmqap/Gn9V0Nlxw8zKuq4PMP6Bu8AaazA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VWmzMzZ5bZo36Rd3NwsPpjsvH0NpoN8Sn0NDsYEo2PaIxM4T6TRDrG/+u27fcVYKW
	 AHDbgjLpv9CxbHaJs4lcmL8eSZ2AX9xiRyU7r7HM0o1aYz71GBVH05LDAYawef0oMu
	 yi44DbT7OOxrnGOoujMshL28Ertj2KseJM9Y4PxsmS6ZPdJ1HDzEsKUHNGGvkBTJ5P
	 Xn3v3xRhciTRd4cFE1IFwq+RK1TP4vhdljbuaTSYWZg5oqp8qRuR4dEkH55yQFdL38
	 eYccOmekWIlJSrFM/QYl7i+6WnEiA9GejEgtXNm3h/Q5SPLMoXfBe0E4MzZ07wm7bc
	 Odo6JAvDwRFmw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398e33155fso756950e87.3;
        Thu, 03 Oct 2024 01:05:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoDoRCsIbjeZNiWnfeRtu5MNFq2VX8t+Ah5D7xI+97iPnzcHiS5oKpU2WmZw6mOh4WArUkrsDzQmtWHDmv@vger.kernel.org, AJvYcCVzVXLGYfo3KdaVKjVwK7lwcd8h+HNBFA0Lh1o453FcMdTwuXmVkKTdbh3eAVzVnLcehbSoZBbvndrT@vger.kernel.org, AJvYcCXWO/OzDW3pIh+4/I9Cg0+/UU+TI+vFxl7EHHxEMRd0odg2Z901ff5v6u/P4VbKfJPQm8DPbyAxokzO@vger.kernel.org
X-Gm-Message-State: AOJu0YybxUWCeV+YM0eQGW3xeNYE2G4q96o+2tq+qqp/hawlkfSWbE+M
	pH8g/XbJFwQBxZNSg2OYHnkgrmbRXXQBCmk0QyfKbU3lw1kQm2GCYi0q8wpSvcS8VjWuGffW/oT
	2McyVDWzJeGqhfGqwEgGUWSeafDo=
X-Google-Smtp-Source: AGHT+IESruK5+9yBmcTRq3OjOtWAN42HOQbPadPnfEku5CBi9MCS0KGGpNPnN6NM0k9jkp3vIIh8SXIO41rcQFkjz00=
X-Received: by 2002:a05:6512:694:b0:539:8d46:4746 with SMTP id
 2adb3069b0e04-539a07aa3b0mr2941043e87.60.1727942708847; Thu, 03 Oct 2024
 01:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911155536.3900579-1-kobak@nvidia.com> <CAJZ5v0gQVPcmMNL4J7UskHsTx8vugJ6pZ_T=Ob3qjsrGmhnFAw@mail.gmail.com>
 <CAMj1kXH+xsEj6vC-+z=NcNyGNA6EVePd35iToLB-J-8LhKdD-w@mail.gmail.com> <1d88a9a8-c594-4474-ab85-1013e34deb73@nvidia.com>
In-Reply-To: <1d88a9a8-c594-4474-ab85-1013e34deb73@nvidia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 3 Oct 2024 10:04:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGSrEtoL2xztrr+LgNRxS6w6kY8i+GhjZsn+XNyPfKDXQ@mail.gmail.com>
Message-ID: <CAMj1kXGSrEtoL2xztrr+LgNRxS6w6kY8i+GhjZsn+XNyPfKDXQ@mail.gmail.com>
Subject: Re: [PATCH V5] acpi/prmt: find block with specific type
To: Koba Ko <kobak@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Matt Ochs <mochs@nvidia.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Oct 2024 at 05:45, Koba Ko <kobak@nvidia.com> wrote:
>
>
> On 10/3/24 05:11, Ard Biesheuvel wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Wed, 2 Oct 2024 at 20:06, Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
> >> On Wed, Sep 11, 2024 at 5:55=E2=80=AFPM KobaK <kobak@nvidia.com> wrote=
:
> >>> PRMT needs to find the correct type of block to
> >>> translate the PA-VA mapping for EFI runtime services.
> >>>
> >>> The issue arises because the PRMT is finding a block of
> >>> type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
> >>> runtime services as described in Section 2.2.2 (Runtime
> >>> Services) of the UEFI Specification [1]. Since the PRM handler is
> >>> a type of runtime service, this causes an exception
> >>> when the PRM handler is called.
> >>>
> >>>      [Firmware Bug]: Unable to handle paging request in EFI runtime s=
ervice
> >>>      WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrapp=
ers.c:341
> >>>          __efi_queue_work+0x11c/0x170
> >>>      Call trace:
> >>>        __efi_queue_work+0x11c/0x170
> >>>        efi_call_acpi_prm_handler+0x68/0xd0
> >>>        acpi_platformrt_space_handler+0x198/0x258
> >>>        acpi_ev_address_space_dispatch+0x144/0x388
> >>>        acpi_ex_access_region+0x9c/0x118
> >>>        acpi_ex_write_serial_bus+0xc4/0x218
> >>>        acpi_ex_write_data_to_field+0x168/0x218
> >>>        acpi_ex_store_object_to_node+0x1a8/0x258
> >>>        acpi_ex_store+0xec/0x330
> >>>        acpi_ex_opcode_1A_1T_1R+0x15c/0x618
> >>>        acpi_ds_exec_end_op+0x274/0x548
> >>>        acpi_ps_parse_loop+0x10c/0x6b8
> >>>        acpi_ps_parse_aml+0x140/0x3b0
> >>>        acpi_ps_execute_method+0x12c/0x2a0
> >>>        acpi_ns_evaluate+0x210/0x310
> >>>        acpi_evaluate_object+0x178/0x358
> >>>        acpi_proc_write+0x1a8/0x8a0 [acpi_call]
> >>>        proc_reg_write+0xcc/0x150
> >>>        vfs_write+0xd8/0x380
> >>>        ksys_write+0x70/0x120
> >>>        __arm64_sys_write+0x24/0x48
> >>>        invoke_syscall.constprop.0+0x80/0xf8
> >>>        do_el0_svc+0x50/0x110
> >>>        el0_svc+0x48/0x1d0
> >>>        el0t_64_sync_handler+0x15c/0x178
> >>>        el0t_64_sync+0x1a8/0x1b0
> >>>
> >>> Find a block with specific type to fix this.
> >>> prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler and
> >>> find a block with EFI_RUNTIME_SERVICES_CODE for prm context.
> >>> If no suitable block is found, a warning message will be prompted
> >>> but the procedue continues to manage the next prm handler.
> >>> However, if the prm handler is actullay called without proper allocat=
ion,
> >>> it would result in a failure during error handling.
> >>>
> >>> By using the correct memory types for runtime services,
> >>> Ensure that the PRM handler and the context are
> >>> properly mapped in the virtual address space during runtime,
> >>> preventing the paging request error.
> >>>
> >>> [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug=
29.pdf
> >> I need input from EFI people on this, so can you please resend the
> >> patch with a CC to linux-efi@vger.kernel.org?
> >>
> >>> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler fo=
r the PlatformRtMechanism subtype")
> >>> Signed-off-by: KobaK <kobak@nvidia.com>
> > Please use your full name.
> Hi Ardb,
> Sure, will update.
> >
> >>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> >>> ---
> >>> V2:
> >>> 1. format the changelog and add more about error handling.
> >>> 2. replace goto
> >>> V3: Warn if parts of handler are missed during va-pa translating.
> >>> V4: Fix the 0day
> >>> V5: Fix typo and pr_warn warning
> >>> ---
> >>>   drivers/acpi/prmt.c | 49 +++++++++++++++++++++++++++++++-----------=
---
> >>>   1 file changed, 34 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> >>> index c78453c74ef5..cd4a7f5491d6 100644
> >>> --- a/drivers/acpi/prmt.c
> >>> +++ b/drivers/acpi/prmt.c
> >>> @@ -72,15 +72,17 @@ struct prm_module_info {
> >>>          struct prm_handler_info handlers[] __counted_by(handler_coun=
t);
> >>>   };
> >>>
> >>> -static u64 efi_pa_va_lookup(u64 pa)
> >>> +static u64 efi_pa_va_lookup(u64 pa, u32 type)
> >>>   {
> >>>          efi_memory_desc_t *md;
> >>>          u64 pa_offset =3D pa & ~PAGE_MASK;
> >>>          u64 page =3D pa & PAGE_MASK;
> >>>
> >>>          for_each_efi_memory_desc(md) {
> >>> -               if (md->phys_addr < pa && pa < md->phys_addr + PAGE_S=
IZE * md->num_pages)
> >>> +               if ((md->type =3D=3D type) &&
> >>> +                       (md->phys_addr < pa && pa < md->phys_addr + P=
AGE_SIZE * md->num_pages)) {
> >>>                          return pa_offset + md->virt_addr + page - md=
->phys_addr;
> >>> +               }
> >>>          }
> >>>
> >>>          return 0;
> >>> @@ -148,9 +150,18 @@ acpi_parse_prmt(union acpi_subtable_headers *hea=
der, const unsigned long end)
> >>>                  th =3D &tm->handlers[cur_handler];
> >>>
> >>>                  guid_copy(&th->guid, (guid_t *)handler_info->handler=
_guid);
> >>> -               th->handler_addr =3D (void *)efi_pa_va_lookup(handler=
_info->handler_address);
> >>> -               th->static_data_buffer_addr =3D efi_pa_va_lookup(hand=
ler_info->static_data_buffer_address);
> >>> -               th->acpi_param_buffer_addr =3D efi_pa_va_lookup(handl=
er_info->acpi_param_buffer_address);
> >>> +               th->handler_addr =3D
> >>> +                       (void *)efi_pa_va_lookup(handler_info->handle=
r_address, EFI_RUNTIME_SERVICES_CODE);
> > Wouldn't it make more sense to test the EFI_MEMORY_RUNTIME attribute
> > rather than expecting/assuming a certain memory type in each case?
> > That attribute is precisely what controls whether or not a region has
> > been remapped into the firmware's page tables.
> Please see the below
> >
> >>> +               th->static_data_buffer_addr =3D
> >>> +                       efi_pa_va_lookup(handler_info->static_data_bu=
ffer_address, EFI_RUNTIME_SERVICES_DATA);
> >>> +               th->acpi_param_buffer_addr =3D
> >>> +                       efi_pa_va_lookup(handler_info->acpi_param_buf=
fer_address, EFI_RUNTIME_SERVICES_DATA);
> >>> +
> >>> +               if (!th->handler_addr || !th->static_data_buffer_addr=
 || !th->acpi_param_buffer_addr)
> >>> +                       pr_warn(
> >>> +                               "Idx: %llu, Parts of handler(GUID: %p=
UL) are missed, handler_addr %p, data_addr %p, param_addr %p",
> > Please improve this diagnostic: 'are missed' is not very helpful.
>
> Are these good for you
>

I /think/ it looks ok but please resend it as a proper patch - the
whitespace got mangled and it is difficult to read.

> ```
>
> -static u64 efi_pa_va_lookup(u64 pa, u32 type)
> +static u64 efi_pa_va_lookup(u64 pa)
>   {
>          efi_memory_desc_t *md;
>          u64 pa_offset =3D pa & ~PAGE_MASK;
>          u64 page =3D pa & PAGE_MASK;
>
>          for_each_efi_memory_desc(md) {
> -               if ((md->type =3D=3D type) &&
> +               if ((md->attribute & EFI_MEMORY_RUNTIME) &&
>                          (md->phys_addr < pa && pa < md->phys_addr +
> PAGE_SIZE * md->num_pages)) {
>                          return pa_offset + md->virt_addr + page -
> md->phys_addr;
>                  }
> @@ -150,18 +150,20 @@ acpi_parse_prmt(union acpi_subtable_headers
> *header, const unsigned long end)
>                  th =3D &tm->handlers[cur_handler];
>
>                  guid_copy(&th->guid, (guid_t *)handler_info->handler_gui=
d);
> -               th->handler_addr =3D
> -                       (void
> *)efi_pa_va_lookup(handler_info->handler_address,
> EFI_RUNTIME_SERVICES_CODE);
> -               th->static_data_buffer_addr =3D
> - efi_pa_va_lookup(handler_info->static_data_buffer_address,
> EFI_RUNTIME_SERVICES_DATA);
> -               th->acpi_param_buffer_addr =3D
> - efi_pa_va_lookup(handler_info->acpi_param_buffer_address,
> EFI_RUNTIME_SERVICES_DATA);
> -
> -               if (!th->handler_addr || !th->static_data_buffer_addr ||
> !th->acpi_param_buffer_addr)
> -                       pr_warn(
> -                               "Idx: %llu, Parts of handler(GUID: %pUL)
> are missed, handler_addr %p, data_addr %p, param_addr %p",
> -                               cur_handler, &th->guid, th->handler_addr,
> -                               (void *)th->static_data_buffer_addr,
> (void *)th->acpi_param_buffer_addr);
> +               th->handler_addr =3D (void
> *)efi_pa_va_lookup(handler_info->handler_address);
> +               if (!th->handler_addr)
> +                       pr_warn( "Idx: %llu, failed to find VA for
> handler_addr(GUID: %pUL, PA: %p)",
> +                               cur_handler, &th->guid, th->handler_addr)=
;
> +
> +               th->static_data_buffer_addr =3D
> efi_pa_va_lookup(handler_info->static_data_buffer_address);
> +               if (!th->static_data_buffer_addr)
> +                       pr_warn( "Idx: %llu, failed to find VA for
> data_addr(PA: %p)",
> +                               cur_handler, &th->guid, (void
> *)th->static_data_buffer_addr);
> +
> +               th->acpi_param_buffer_addr =3D
> efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
> +               if (!th->acpi_param_buffer_addr)
> +                       pr_warn( "Idx: %llu, failed to find VA for
> param_addr(PA: %p)",
> +                               cur_handler, &th->guid, (void
> *)th->acpi_param_buffer_addr);
>
> ```
>
...
> >>> @@ -274,8 +293,10 @@ static acpi_status acpi_platformrt_space_handler=
(u32 function,
> >>>          case PRM_CMD_START_TRANSACTION:
> >>>
> >>>                  module =3D find_prm_module(&buffer->handler_guid);
> >>> -               if (!module)
> >>> -                       goto invalid_guid;
> >>> +               if (!module) {
> >>> +                       buffer->prm_status =3D PRM_HANDLER_GUID_NOT_F=
OUND;
> >>> +                       return AE_OK;
> >>> +               }
> > What is the reason for this change, and the ones down below?
> As per Rui's comment, goto can be replaced with return.
> So I modified them with return and PRM_HANDLER_GUID_NOT_FOUND.

I don't think this change is necessary, but it should be a separate
patch at the very least.

