Return-Path: <linux-efi+bounces-1117-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05818D6052
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 13:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AE92835BE
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14D3156F4D;
	Fri, 31 May 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTtk227m"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF8153BC1;
	Fri, 31 May 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153784; cv=none; b=dSoOcAepB5tCf2DzIPdpZMk7i7NKxL6qVm7WincRtOA6CaObNv3i1+R6X2X61LEQdWrWWi9nkb37DAoIts2B1ex9oIBOdJWz/hS+2/bo5wvi07qneyLDLDasixeQJqrr/TgmIRbyXN7aDkyUyTFjFmco1125D3erlhCux6XnFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153784; c=relaxed/simple;
	bh=HgtvQmhgEpL9Xbp5+KHJ6NjcuOEi7zDCX0BlPKTFvGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCUt4TDR8W7bg0i2j17/S2EvttU5OkJCOkg6qkpWlfCeVfPCbbn64h4qx/rqTNS7ZVt5NWB3admGnWJGCgrZBwMAhSGtyz5jse/n0OWC0w8JWhBl1hxDDMlzBohCPEx0KvJWo099NfHCa803DQzTHS1u8B4G0h93OHx65canIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTtk227m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4C7C4AF16;
	Fri, 31 May 2024 11:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717153784;
	bh=HgtvQmhgEpL9Xbp5+KHJ6NjcuOEi7zDCX0BlPKTFvGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XTtk227mDgN9yrTK1sYIJdBwb13rZdzdiDLQf1D1lV6VYjqnNY8eoiBsb5xvjoB/k
	 /hIe2wFsOGiTyBQSpe7LkY9o/uOJDA1Fe8LpPya6oap4IbUOcELLVBwc42sWifhHOT
	 Yl1E907W46n5nq72q+ICSOIdWoDXNJQGOK/ynRwyU2GJfl/PLHN0aOKMK+uNNpyHa9
	 NOFdoSVDpfpeLc5z4bV7IPCP0bm3MA2GtZqgDg3SIyjCl8yt98/ElPRJZmMU+Dxdlm
	 S/4XoJab0vBmKRwrh2D/jXcFNGLbfx8t9ZV8b/3e1UfCkCNFd12w3AIJerl79WF6Ii
	 ycAJwno/aDHiQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e95abc7259so20693411fa.3;
        Fri, 31 May 2024 04:09:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUW1mCT6B0uubbrlfvHMb9kGzpWb0FjUmjnukmX/6ZlAGJGU2vpffoZL/01d0p9Pf0p2RJUxbK/z/ZBnB2L3otedeTdN6kCIcXU3bPV+6nMPOtCnBmVYjVPwbU9Gvbk0iRgRwgdg9iz9IOstsOKPA0nKtXBNw/s6qj3feZ4wMKcxTmlwg5uyinAkX9/+G0evyo3xEU3D0sGSh40SjI0OcsEBw1f
X-Gm-Message-State: AOJu0Yzt+Z2esu9R5C1uI35QWMnEKIid9UnCJzZjBSqBQUy0h6hvXRdT
	GDCQmkeitmSg//GHcprRJRUy8BVyrBi0kpvo5u37ENV+qd39ygc3VAfest6+6BBGt10cUxNXTQm
	SJ6M15f6gcAn1yTRc6ITyxUL7rbs=
X-Google-Smtp-Source: AGHT+IGTzAQXJboCZrE7ub+CPIwBrd4fT/qOP7BamuTNTLnHwWnsj6M7s6s5d6esPM1ooNMpIhnA2f1RjvhbZEhwwrw=
X-Received: by 2002:a2e:8695:0:b0:2e9:6265:9926 with SMTP id
 38308e7fff4ca-2ea951ddd1emr10496851fa.49.1717153782170; Fri, 31 May 2024
 04:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com> <20240531010331.134441-20-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-20-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 May 2024 13:09:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGC7a5+5at7T7M_mxBNWjqnuM4QGydG4ZEbu63y6fri3g@mail.gmail.com>
Message-ID: <CAMj1kXGC7a5+5at7T7M_mxBNWjqnuM4QGydG4ZEbu63y6fri3g@mail.gmail.com>
Subject: Re: [PATCH v9 19/19] x86: EFI stub DRTM launch support for Secure Launch
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 May 2024 at 03:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> This support allows the DRTM launch to be initiated after an EFI stub
> launch of the Linux kernel is done. This is accomplished by providing
> a handler to jump to when a Secure Launch is in progress. This has to be
> called after the EFI stub does Exit Boot Services.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Just some minor remarks below. The overall approach in this patch
looks fine now.


> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 98 +++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index d5a8182cf2e1..a1143d006202 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -9,6 +9,8 @@
>  #include <linux/efi.h>
>  #include <linux/pci.h>
>  #include <linux/stddef.h>
> +#include <linux/slr_table.h>
> +#include <linux/slaunch.h>
>
>  #include <asm/efi.h>
>  #include <asm/e820/types.h>
> @@ -830,6 +832,97 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>         return efi_adjust_memory_range_protection(addr, kernel_text_size);
>  }
>
> +#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))

IS_ENABLED() is mostly used for C conditionals not CPP ones.

It would be nice if this #if could be dropped, and replaced with ... (see below)


> +static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
> +                                                struct boot_params *boot_params)
> +{
> +       struct slr_entry_intel_info *txt_info;
> +       struct slr_entry_policy *policy;
> +       struct txt_os_mle_data *os_mle;
> +       bool updated = false;
> +       int i;
> +
> +       txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
> +       if (!txt_info)
> +               return false;
> +
> +       os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
> +       if (!os_mle)
> +               return false;
> +
> +       os_mle->boot_params_addr = (u32)(u64)boot_params;
> +

Why is this safe?

> +       policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
> +       if (!policy)
> +               return false;
> +
> +       for (i = 0; i < policy->nr_entries; i++) {
> +               if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
> +                       policy->policy_entries[i].entity = (u64)boot_params;
> +                       updated = true;
> +                       break;
> +               }
> +       }
> +
> +       /*
> +        * If this is a PE entry into EFI stub the mocked up boot params will
> +        * be missing some of the setup header data needed for the second stage
> +        * of the Secure Launch boot.
> +        */
> +       if (image) {
> +               struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base + 0x1f1);

Could we use something other than a bare 0x1f1 constant here? struct
boot_params has a struct setup_header at the correct offset, so with
some casting of offsetof() use, we can make this look a lot more self
explanatory.


> +               u64 cmdline_ptr, hi_val;
> +
> +               boot_params->hdr.setup_sects = hdr->setup_sects;
> +               boot_params->hdr.syssize = hdr->syssize;
> +               boot_params->hdr.version = hdr->version;
> +               boot_params->hdr.loadflags = hdr->loadflags;
> +               boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
> +               boot_params->hdr.min_alignment = hdr->min_alignment;
> +               boot_params->hdr.xloadflags = hdr->xloadflags;
> +               boot_params->hdr.init_size = hdr->init_size;
> +               boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
> +               hi_val = boot_params->ext_cmd_line_ptr;

We have efi_set_u64_split() for this.

> +               cmdline_ptr = boot_params->hdr.cmd_line_ptr | hi_val << 32;
> +               boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);;
> +       }
> +
> +       return updated;
> +}
> +
> +static void efi_secure_launch(struct boot_params *boot_params)
> +{
> +       struct slr_entry_dl_info *dlinfo;
> +       efi_guid_t guid = SLR_TABLE_GUID;
> +       dl_handler_func handler_callback;
> +       struct slr_table *slrt;
> +

... a C conditional here, e.g.,

if (!IS_ENABLED(CONFIG_SECURE_LAUNCH))
    return;

The difference is that all the code will get compile test coverage
every time, instead of only in configs that enable
CONFIG_SECURE_LAUNCH.

This significantly reduces the risk that your stuff will get broken
inadvertently.

> +       /*
> +        * The presence of this table indicated a Secure Launch
> +        * is being requested.
> +        */
> +       slrt = (struct slr_table *)get_efi_config_table(guid);
> +       if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
> +               return;
> +
> +       /*
> +        * Since the EFI stub library creates its own boot_params on entry, the
> +        * SLRT and TXT heap have to be updated with this version.
> +        */
> +       if (!efi_secure_launch_update_boot_params(slrt, boot_params))
> +               return;
> +
> +       /* Jump through DL stub to initiate Secure Launch */
> +       dlinfo = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
> +
> +       handler_callback = (dl_handler_func)dlinfo->dl_handler;
> +
> +       handler_callback(&dlinfo->bl_context);
> +
> +       unreachable();
> +}
> +#endif
> +
>  static void __noreturn enter_kernel(unsigned long kernel_addr,
>                                     struct boot_params *boot_params)
>  {
> @@ -957,6 +1050,11 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>                 goto fail;
>         }
>
> +#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))

... and drop this #if as well.

> +       /* If a Secure Launch is in progress, this never returns */
> +       efi_secure_launch(boot_params);
> +#endif
> +
>         /*
>          * Call the SEV init code while still running with the firmware's
>          * GDT/IDT, so #VC exceptions will be handled by EFI.
> --
> 2.39.3
>

