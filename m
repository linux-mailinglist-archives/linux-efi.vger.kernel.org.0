Return-Path: <linux-efi+bounces-2011-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5519A6705
	for <lists+linux-efi@lfdr.de>; Mon, 21 Oct 2024 13:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C8A1C2155C
	for <lists+linux-efi@lfdr.de>; Mon, 21 Oct 2024 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758BE1E5722;
	Mon, 21 Oct 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSYLtcBh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6611E1A3B;
	Mon, 21 Oct 2024 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511542; cv=none; b=iICNZSWWxevJO1YBQx8SmkqNLMMVvnF9oIhOdVIiL+iAMZLfIHl/vfCkObDn9floTzA1RNiP13dymYoq1x1DWm4PbOMqDtlXVzXBIss8vg48jpENUX7a347RY6HyxwEZHZLRfdV50B5jgS72HcjW8/9A4UiLc2y2KKFYKEKXrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511542; c=relaxed/simple;
	bh=svJmMssGYz1wkQkC8PXANMosMeedZ6FHgwDuinCPMi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BiWoX8sM6DQTupRQet/w9650ZTFi0JEvboLhFAAQl8/XT3qBmyGufkGNWHKjVJZ6y5bjmdlo0QlpQ54PjW8fyvgwjP7nwcb3hqjUAsSDuPS6vKH8OoB6Ex8R9Ca5swjA9JVgwsDjN0UCLpq1FYVRornEdqNJa3uC3Ej4urZfFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSYLtcBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79DBC4CEC3;
	Mon, 21 Oct 2024 11:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729511541;
	bh=svJmMssGYz1wkQkC8PXANMosMeedZ6FHgwDuinCPMi8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cSYLtcBhJ9FgQFeJUyhLyaYS1qp40ivSLckG0nNrVmWrCojk7ONK9kDUF6cJC5zvq
	 wdTvV/xxeAngzhtSBSYid7sqD6LFbVzl75jrRN7PS52I463cs4nPiN19DW9t25XVcI
	 zQOjEMajyINpE2WaGDnuZ9V1NDzE5L8E7DC9VpYNgIWaYCAPssSXSSqO9lktAJ61JL
	 POYXajnUPY/wI4NaO53h7G2tl6pT625ca96gEJZiwCxfor4DsOi8Pk1ptNanDhmwC7
	 QTmhC8+nD83XHqAUSg7IPVjaHhpgvO/YLGVRbOvs0yjgeRgdvWZlhYMuVtmJfZgvAL
	 bhiziCjgZJsyw==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71808e95ae2so2003753a34.0;
        Mon, 21 Oct 2024 04:52:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+U07hpT/FaP07RXE0PwOFW9wkmtBL1uygohjQzqMXyIqQgEfcbZnBdeeuN4HnTv4bpeH1SA6/Bn00@vger.kernel.org, AJvYcCWqXtw+n9DQrQxPzmwsORsN9VcMOaP88AAV00CkwkRiVAdbpGWSm0kONV+o2DI5kk/PhNnTw0DmMfN/@vger.kernel.org, AJvYcCWrRO3yrXdeIRrFeh9Wb9UE5K+OVVJFDbvpL9vW0LE7VORltibR+ijj1TfkKdmsX07max8ly+rsdTbuvfIi@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1R70JY6697K/KVg++uBVpGbi+sWZvVIj6ztRBdWNxeZc7qV+
	UB8C+r3r/bewZsYvkoY9ktqtcpfNKUPkxEP+ul+KjI6cb6TV3234/x/6o47+1xA25VhNsJxf+ld
	oZQ4YmesuyiS00uUDDwEjkp554vY=
X-Google-Smtp-Source: AGHT+IH5kuIPUKXkWOnc6Yk9qOzjcc8+DbNnyTdcZdozKceiiwGRfpoTnoOGjCPmRbOA/2WoMYPreGPfXVrYBcTSGWA=
X-Received: by 2002:a05:6870:2054:b0:277:73ce:da7c with SMTP id
 586e51a60fabf-2892d6e02d9mr6406849fac.23.1729511541062; Mon, 21 Oct 2024
 04:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012205010.4165798-1-kobak@nvidia.com>
In-Reply-To: <20241012205010.4165798-1-kobak@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 13:52:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iA_8S13ZJLbhbj63+PQXXWd9m2jGbZOmvV_+G84cBZ-w@mail.gmail.com>
Message-ID: <CAJZ5v0iA_8S13ZJLbhbj63+PQXXWd9m2jGbZOmvV_+G84cBZ-w@mail.gmail.com>
Subject: Re: [PATCH V10] acpi/prmt: find block with specific type
To: KobaK <kobak@nvidia.com>
Cc: Matt Ochs <mochs@nvidia.com>, James Morse <james.morse@arm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 10:50=E2=80=AFPM KobaK <kobak@nvidia.com> wrote:
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
>     [Firmware Bug]: Unable to handle paging request in EFI runtime servic=
e
>     WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c=
:341
>         __efi_queue_work+0x11c/0x170
>     Call trace:
>
> Find a block with specific type to fix this.
> PRMT find a block with EFI_MEMORY_RUNTIME for PRM handler and PRM context=
.
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
> [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.p=
df
> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for th=
e PlatformRtMechanism subtype")
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
> V6: use EFI_MOMOERY_RUNTIME to find block and split goto refactor as a si=
ngle
> patch
> V7:
> 1. refine the codes and commit description as per comments
> 2. drop goto refacotr
> V8: Fix 0day and cc to stable
> V9: Describe 0day fix
> cast PA as (void *) in pr_warn
> V10: use 0x%llx instead for PA in pr_warn

Applied (under a new subject and with edits in the changelog) as
6.12-rc material.

Thanks!

> ---
>  drivers/acpi/prmt.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 1cfaa5957ac4..d59307a76ca3 100644
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
>         u64 pa_offset =3D pa & ~PAGE_MASK;
>         u64 page =3D pa & PAGE_MASK;
>
>         for_each_efi_memory_desc(md) {
> -               if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE =
* md->num_pages)
> +               if ((md->attribute & EFI_MEMORY_RUNTIME) &&
> +                   (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE=
 * md->num_pages)) {
>                         return pa_offset + md->virt_addr + page - md->phy=
s_addr;
> +               }
>         }
>
> +       pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa)=
;
> +
>         return 0;
>  }
>
> @@ -148,9 +152,15 @@ acpi_parse_prmt(union acpi_subtable_headers *header,=
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
> +                       (void *)efi_pa_va_lookup(&th->guid, handler_info-=
>handler_address);
> +
> +               th->static_data_buffer_addr =3D
> +                       efi_pa_va_lookup(&th->guid, handler_info->static_=
data_buffer_address);
> +
> +               th->acpi_param_buffer_addr =3D
> +                       efi_pa_va_lookup(&th->guid, handler_info->acpi_pa=
ram_buffer_address);
> +
>         } while (++cur_handler < tm->handler_count && (handler_info =3D g=
et_next_handler(handler_info)));
>
>         return 0;
> @@ -277,6 +287,13 @@ static acpi_status acpi_platformrt_space_handler(u32=
 function,
>                 if (!handler || !module)
>                         goto invalid_guid;
>
> +               if (!handler->handler_addr ||
> +                   !handler->static_data_buffer_addr ||
> +                   !handler->acpi_param_buffer_addr) {
> +                       buffer->prm_status =3D PRM_HANDLER_ERROR;
> +                       return AE_OK;
> +               }
> +
>                 ACPI_COPY_NAMESEG(context.signature, "PRMC");
>                 context.revision =3D 0x0;
>                 context.reserved =3D 0x0;
> --
> 2.43.0
>
>

