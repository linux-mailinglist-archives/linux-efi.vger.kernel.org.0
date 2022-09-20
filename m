Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A15BEA54
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiITPgt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiITPgs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 11:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765A7659E0;
        Tue, 20 Sep 2022 08:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03A31623C6;
        Tue, 20 Sep 2022 15:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5C6C433C1;
        Tue, 20 Sep 2022 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663688206;
        bh=D4fI20wsDZU6cBnEMfE+TOOp7Qrzm1qKp2H/6FoR1lw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RFTGMek09d+aDdEKwQI5h9B9rUkfk1jaIjyoKzeykvjmwn5OmC3Ab3M4BIHr+Zftn
         hwQQXrOg06GmITriVcjkYKVYtZ/wedGGgOzbCwzUDOpF8QCEs8oupwqCKtMnOvy10W
         GqCyYJ0iRjyJSk8IGuD5QNUBcXSYPHcjPuAtSVFCwmcX5XKtUjNe7lhNOx2HCyne2B
         q9P2brJEWnSui/jrnLDBiiOY0QcQAB+emVwJWzLOHjgN0rNE9ubiA3vT1tBSWjv3Db
         ktoHwtI+ZlmizOqxe4jujhPf9vXL8So3/bdagy34nv4Yb7UL+yrJXLZR+z3Tq8z3gN
         9O0U98xNH7QPA==
Received: by mail-lj1-f174.google.com with SMTP id q17so3445626lji.11;
        Tue, 20 Sep 2022 08:36:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf0/DtBCWgVeTpRixEGW6D8Oy8uCEewQFyU0DP2idB7+H45YkLiK
        l0hUs7Ga8gE8bUqBv1tAyBCBma4GBJ/Q1Ajdw4k=
X-Google-Smtp-Source: AMsMyM48yyP2Hqwk6bUrxTHAQc4fBFlYjN+MCHW44sVapUcWvHsLb4wIHHgjlbB4nlnT1A6045csLq04qR0dn0WWsCw=
X-Received: by 2002:a2e:2d0a:0:b0:26c:a1c:cdf with SMTP id t10-20020a2e2d0a000000b0026c0a1c0cdfmr7905440ljt.352.1663688204337;
 Tue, 20 Sep 2022 08:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220919193257.2031-1-demi@invisiblethingslab.com>
In-Reply-To: <20220919193257.2031-1-demi@invisiblethingslab.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Sep 2022 17:36:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEBfJUfTQ3THqqKxsU09_S98B_TjTECKwGM0WAv_5tZaA@mail.gmail.com>
Message-ID: <CAMj1kXEBfJUfTQ3THqqKxsU09_S98B_TjTECKwGM0WAv_5tZaA@mail.gmail.com>
Subject: Re: [PATCH v3] Support ESRT in Xen dom0
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Demi,

On Mon, 19 Sept 2022 at 21:33, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> fwupd requires access to the EFI System Resource Table (ESRT) to
> discover which firmware can be updated by the OS.  Currently, Linux does
> not expose the ESRT when running as a Xen dom0.  Therefore, it is not
> possible to use fwupd in a Xen dom0, which is a serious problem for e.g.
> Qubes OS.
>
> Before Xen 4.16, this was not fixable due to hypervisor limitations.
> The UEFI specification requires the ESRT to be in EfiBootServicesData
> memory, which Xen will use for whatever purposes it likes.  Therefore,
> Linux cannot safely access the ESRT, as Xen may have overwritten it.
>
> Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootServicesData
> or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootServicesData
> memory, Xen allocates some memory of type EfiRuntimeServicesData, copies
> the ESRT to it, and finally replaces the ESRT pointer with a pointer to
> the copy.  Since Xen will not clobber EfiRuntimeServicesData memory,
> this ensures that the ESRT can safely be accessed by the OS.  It is safe
> to access the ESRT under Xen if, and only if, it is in memory of type
> EfiRuntimeServicesData.
>

Thanks for the elaborate explanation. This is really helpful.

So here, you are explaining that the only way for Xen to prevent
itself from potentially clobbering the ESRT is by creating a
completely new allocation? What about other assets that may be passed
via EFI boot services data regions?

So first of all, EfiRuntimeServicesData has a special purpose: it is
used to carry data that is part of the EFI runtime service
implementations themselves. Therefore, it has to be mapped into the
EFI page tables by the OS kernel, and carved out of the linear map (to
prevent inadvertent access with mismatched attributes). So unless you
are writing the code that backs GetVariable() or SetVariable(), there
are never good reasons to use EfiRuntimeServicesData.

If you want to use a memory type that is suitable for firmware tables
that are intended for consumption by the OS only (and not by the
runtime services themselves), you might consider EfiAcpiReclaimMemory.

TBH I still don't think this is a scalable approach. There are other
configuration tables that may be passed in EFI boot services memory,
and MS especially were pushing back in the UEFI forum on adding table
types that were passed in anything other the EfiBootServicesData.

> When running as a Xen dom0, check if the ESRT is in memory of type
> EfiRuntimeServicesData, and if it is, parse it as if not running under
> Xen.  This allows programs such as fwupd which require the ESRT to run
> under Xen, and so makes fwupd support in Qubes OS possible.
>
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> ---
> Changes since v2:
>
> - Massively updated commit message.
> - Fetch the ESRT inline in drivers/firmware/efi/esrt.c, instead of using
>   a single-use helper in drivers/xen/efi.c.
>
> Changes since v1:
>
> - Use a different type (struct xen_efi_mem_info) for memory information
>   provided by Xen, as Xen reports it in a different way than the
>   standard Linux functions do.
>
>  drivers/firmware/efi/esrt.c | 71 ++++++++++++++++++++++++++++++-------
>  1 file changed, 58 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index 2a2f52b017e736dd995c69e8aeb5fbd7761732e5..378bf2ea770ad3bd747345a89258216919eb21bb 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -28,6 +28,11 @@
>  #include <asm/io.h>
>  #include <asm/early_ioremap.h>
>
> +#ifdef CONFIG_XEN_EFI
> +#include <asm/xen/hypercall.h>
> +#include <xen/page.h>
> +#endif
> +
>  struct efi_system_resource_entry_v1 {
>         efi_guid_t      fw_class;
>         u32             fw_type;
> @@ -243,27 +248,67 @@ void __init efi_esrt_init(void)
>         void *va;
>         struct efi_system_resource_table tmpesrt;
>         size_t size, max, entry_size, entries_size;
> -       efi_memory_desc_t md;
> -       int rc;
>         phys_addr_t end;
> -
> -       if (!efi_enabled(EFI_MEMMAP))
> -               return;
> +       uint32_t type;
>
>         pr_debug("esrt-init: loading.\n");
>         if (!esrt_table_exists())
>                 return;
>
> -       rc = efi_mem_desc_lookup(efi.esrt, &md);
> -       if (rc < 0 ||
> -           (!(md.attribute & EFI_MEMORY_RUNTIME) &&
> -            md.type != EFI_BOOT_SERVICES_DATA &&
> -            md.type != EFI_RUNTIME_SERVICES_DATA)) {
> -               pr_warn("ESRT header is not in the memory map.\n");
> +       if (efi_enabled(EFI_MEMMAP)) {
> +               efi_memory_desc_t md;
> +
> +               if (efi_mem_desc_lookup(efi.esrt, &md) < 0 ||
> +                   (!(md.attribute & EFI_MEMORY_RUNTIME) &&
> +                    md.type != EFI_BOOT_SERVICES_DATA &&
> +                    md.type != EFI_RUNTIME_SERVICES_DATA)) {
> +                       pr_warn("ESRT header is not in the memory map.\n");
> +                       return;
> +               }
> +
> +               type = md.type;
> +               max = efi_mem_desc_end(&md);
> +#ifdef CONFIG_XEN_EFI
> +       } else if (efi_enabled(EFI_PARAVIRT)) {
> +               static_assert(XEN_PAGE_SHIFT == EFI_PAGE_SHIFT,
> +                             "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
> +
> +               struct xen_platform_op op = {
> +                       .cmd = XENPF_firmware_info,
> +                       .u.firmware_info = {
> +                               .type = XEN_FW_EFI_INFO,
> +                               .index = XEN_FW_EFI_MEM_INFO,
> +                               .u.efi_info.mem.addr = efi.esrt,
> +                               .u.efi_info.mem.size = ((u64)-1ULL) - efi.esrt,
> +                       }
> +               };
> +               union xenpf_efi_info *info = &op.u.firmware_info.u.efi_info;
> +               int rc = HYPERVISOR_platform_op(&op);
> +
> +               if (rc) {
> +                       pr_warn("Failed to lookup ESRT header %lu in Xen memory map: error %d\n",
> +                               efi.esrt, rc);
> +                       return;
> +               }
> +               type = info->mem.type;
> +               max = info->mem.addr + info->mem.size;
> +
> +               /*
> +                * Recent Xen versions relocate the ESRT to memory of type
> +                * EfiRuntimeServicesData, which Xen will not reuse.  If the ESRT
> +                * is not in EfiRuntimeServicesData memory, it has not been reserved
> +                * by Xen and might be allocated to other guests, so it cannot
> +                * safely be used.
> +                */
> +               if (type != EFI_RUNTIME_SERVICES_DATA) {
> +                       pr_warn("Xen did not reserve ESRT, ignoring it\n");
> +                       return;
> +               }
> +#endif

I am really not happy with this. You are adding a special case
specific to Xen to double check that it has violated the EFI spec as
required. Even if some firmwares exist that do the same, codifying it
like this on mainline Linux code is not something I am comfortable
accepting.

I take it that this also means that ESRT on dom0 is currently just
broken, right?


> +       } else {
>                 return;
>         }
>
> -       max = efi_mem_desc_end(&md);
>         if (max < efi.esrt) {
>                 pr_err("EFI memory descriptor is invalid. (esrt: %p max: %p)\n",
>                        (void *)efi.esrt, (void *)max);
> @@ -333,7 +378,7 @@ void __init efi_esrt_init(void)
>
>         end = esrt_data + size;
>         pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
> -       if (md.type == EFI_BOOT_SERVICES_DATA)
> +       if (type == EFI_BOOT_SERVICES_DATA)
>                 efi_mem_reserve(esrt_data, esrt_data_size);
>
>         pr_debug("esrt-init: loaded.\n");
> --
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab
