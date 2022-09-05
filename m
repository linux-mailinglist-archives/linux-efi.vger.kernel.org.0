Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70385AD1C8
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 13:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbiIELrg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 07:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbiIELrR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 07:47:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDBB5C976;
        Mon,  5 Sep 2022 04:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C09FB81116;
        Mon,  5 Sep 2022 11:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0745C433D6;
        Mon,  5 Sep 2022 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662378427;
        bh=NHuH20RrQjxRSqiH0mBVZk8zTQuLxuDS7k7p+r4UxA0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VmsO4/rrmylf8/u2/pk96SzSMvTQRigqOOVMVv/F+2rcKfVibHN50t5Ci/AkViS2D
         /1qKssYq733OPSahQv7niTSffy4hTNp4Hh68Y0MUtCwbHm9Bohc3JX/Ve4W3cOBUQq
         lcrrbCkRo74vijamxAJIG88UIKkbxNsLfXGztX/9fgOaHStHuOKCXU5uy502mSPhFX
         jsaY/YTxs+e35PkZX26ypa0aixYJ5pivEkDO5he42wLqBcPlp/85obB6sHiBo94qF7
         I1XEzbL4Z7EdhBhua8TCf+zRDc4LvGNK4Frar9/jdc1pNW0iOcAK/Z6uoIn3vzq23G
         Ki1PWLlwSdnIQ==
Received: by mail-lj1-f177.google.com with SMTP id x10so8983992ljq.4;
        Mon, 05 Sep 2022 04:47:07 -0700 (PDT)
X-Gm-Message-State: ACgBeo18nHLuScDqVbeWhhGU1ZmeJnskp5VjEOTsn42oaqoOAO1pFqrB
        aErQBSqXLmbcUnPjjCQ4sQTe5OcHm6HoQ9k+mcg=
X-Google-Smtp-Source: AA6agR7BAfNwXqTdiA+9ukiurbQmio6yAhB7Swj2kfchvdOlIHXq4ha1E1EZD4MjF6Zgfu08ZnI0Zywhrl+jacxNRI0=
X-Received: by 2002:a2e:710c:0:b0:264:ed38:e57f with SMTP id
 m12-20020a2e710c000000b00264ed38e57fmr9678972ljc.189.1662378425797; Mon, 05
 Sep 2022 04:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220828025158.1455-1-demi@invisiblethingslab.com>
In-Reply-To: <20220828025158.1455-1-demi@invisiblethingslab.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 5 Sep 2022 13:46:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF5eH-HE1dkAEGGZ1qfG1eRThsNK7ayWkRmaHSO36sjfA@mail.gmail.com>
Message-ID: <CAMj1kXF5eH-HE1dkAEGGZ1qfG1eRThsNK7ayWkRmaHSO36sjfA@mail.gmail.com>
Subject: Re: [PATCH v2] Add support for ESRT loading under Xen
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 28 Aug 2022 at 04:52, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> This is needed for fwupd to work in Qubes OS.
>

Please elaborate on:
- the current situation
- why this is a problem
- why your approach is a reasonable solution.

> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> ---
> Changes since v1:
>
> - Use a different type (struct xen_efi_mem_info) for memory information
>   provided by Xen, as Xen reports it in a different way than the
>   standard Linux functions do.
>
>  drivers/firmware/efi/esrt.c | 49 +++++++++++++++++++++++++++----------
>  drivers/xen/efi.c           | 32 ++++++++++++++++++++++++++
>  include/linux/efi.h         | 18 ++++++++++++++
>  3 files changed, 86 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index 2a2f52b017e736dd995c69e8aeb5fbd7761732e5..c0fc149a838044cc16bb08a374a0c8ea6b7dcbff 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -243,27 +243,50 @@ void __init efi_esrt_init(void)
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
> +       } else if (IS_ENABLED(CONFIG_XEN_EFI) && efi_enabled(EFI_PARAVIRT)) {
> +               struct xen_efi_mem_info info;
> +
> +               if (!xen_efi_mem_info_query(efi.esrt, &info)) {
> +                       pr_warn("Failed to lookup ESRT header in Xen memory map\n");
> +                       return;
> +               }
> +
> +               type = info.type;
> +               max = info.addr + info.size;
> +
> +               /* Recent Xen versions relocate the ESRT to memory of type
> +                * EfiRuntimeServicesData, which Xen will not reuse.  If the ESRT

This violates the EFI spec, which spells out very clearly that the
ESRT must be in EfiBootServicesData memory. Why are you deviating from
this?

> +                * is not in EfiRuntimeServicesData memory, it has not been reserved
> +                * by Xen and might be allocated to other guests, so it cannot
> +                * safely be used. */
> +               if (type != EFI_RUNTIME_SERVICES_DATA) {
> +                       pr_warn("Xen did not reserve ESRT, ignoring it\n");
> +                       return;
> +               }
> +       } else {
>                 return;
>         }
>
> -       max = efi_mem_desc_end(&md);
>         if (max < efi.esrt) {
>                 pr_err("EFI memory descriptor is invalid. (esrt: %p max: %p)\n",
>                        (void *)efi.esrt, (void *)max);
> @@ -333,7 +356,7 @@ void __init efi_esrt_init(void)
>
>         end = esrt_data + size;
>         pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
> -       if (md.type == EFI_BOOT_SERVICES_DATA)
> +       if (type == EFI_BOOT_SERVICES_DATA)
>                 efi_mem_reserve(esrt_data, esrt_data_size);
>
>         pr_debug("esrt-init: loaded.\n");
> diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> index d1ff2186ebb48a7c0981ecb6d4afcbbb25ffcea0..b313f213822f0fd5ba6448f6f6f453cfda4c7e23 100644
> --- a/drivers/xen/efi.c
> +++ b/drivers/xen/efi.c
> @@ -26,6 +26,7 @@
>
>  #include <xen/interface/xen.h>
>  #include <xen/interface/platform.h>
> +#include <xen/page.h>
>  #include <xen/xen.h>
>  #include <xen/xen-ops.h>
>
> @@ -40,6 +41,37 @@
>
>  #define efi_data(op)   (op.u.efi_runtime_call)
>
> +static_assert(XEN_PAGE_SHIFT == EFI_PAGE_SHIFT,
> +              "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
> +
> +bool xen_efi_mem_info_query(u64 phys_addr, struct xen_efi_mem_info *md)
> +{
> +       struct xen_platform_op op = {
> +               .cmd = XENPF_firmware_info,
> +               .u.firmware_info = {
> +                       .type = XEN_FW_EFI_INFO,
> +                       .index = XEN_FW_EFI_MEM_INFO,
> +                       .u.efi_info.mem.addr = phys_addr,
> +                       .u.efi_info.mem.size = ((u64)-1ULL) - phys_addr,
> +               }
> +       };
> +       union xenpf_efi_info *info = &op.u.firmware_info.u.efi_info;
> +       int rc;
> +
> +       memset(md, 0, sizeof(*md)); /* initialize md even on failure */
> +       rc = HYPERVISOR_platform_op(&op);
> +       if (rc) {
> +               pr_warn("Could not obtain information on address %llu from Xen: "
> +                       "error %d\n", phys_addr, rc);
> +               return false;
> +       }
> +       md->addr = info->mem.addr;
> +       md->size = info->mem.size;
> +       md->attr = info->mem.attr;
> +       md->type = info->mem.type;
> +       return true;
> +}
> +
>  static efi_status_t xen_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
>  {
>         struct xen_platform_op op = INIT_EFI_OP(get_time);
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index d2b84c2fec39f0268324d1a38a73ed67786973c9..0598869cdc924aef0e2b9cacc4450b728e1a98c7 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1327,1 +1327,19 @@ struct linux_efi_coco_secret_area {
> +/* Result of a XEN_FW_EFI_MEM_INFO query */
> +struct xen_efi_mem_info {
> +    uint64_t addr; /* address queried */
> +    uint64_t size; /* remaining bytes in memory region */
> +    uint64_t attr; /* attributes */
> +    uint32_t type; /* type */
> +};
> +
> +#if IS_ENABLED(CONFIG_XEN_EFI)
> +extern bool xen_efi_mem_info_query(u64 phys_addr, struct xen_efi_mem_info *out_md);
> +#else
> +static inline bool xen_efi_mem_info_query(u64 phys_addr, struct xen_efi_mem_info *out_md)
> +{
> +       BUILD_BUG();
> +       return false;
> +}
> +#endif
> +
>  #endif /* _LINUX_EFI_H */
> --
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab
