Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BE24C6D29
	for <lists+linux-efi@lfdr.de>; Mon, 28 Feb 2022 13:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiB1MuN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Feb 2022 07:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiB1MuM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Feb 2022 07:50:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0863D54FAD;
        Mon, 28 Feb 2022 04:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39CA2B81120;
        Mon, 28 Feb 2022 12:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F7CC340EE;
        Mon, 28 Feb 2022 12:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646052570;
        bh=YNCjDWYFLy8kk5Lc6yfDNb4ICpsaXUgkOhGfWYb2mkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gc2oLdRhB79LqW2fWFa177bVCgVNvknFSspQ4Nx5BBRQEOH9JGJYOzWeIdtF4QlFa
         Vm6UwbbeLBmvY6Iq2ESWhfaFgokcE1digjq997sEXhVM8APqrUEJvlJLp74Pvk2mC9
         yRNCBOSSjomfbtGeQKNyOnmqvTLha8I0x+wfPOqaqZ59Vjpa9evMvPCHvgY/DxynWG
         py3f1VJxEJwBxXBGz72y7KAMH2QQlJ7pCSCLQBPOevRDSXsr0bSWZpICpprumq0DyN
         qc9B98cda5m7nLqFZBXESQTvAejiVjGQ+uQ2nokVTcxtk4fkfKfF16U43qXoqK6Aoo
         G+FEWlvZxX7Vw==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2d07c4a0d06so106264137b3.13;
        Mon, 28 Feb 2022 04:49:30 -0800 (PST)
X-Gm-Message-State: AOAM530pRLkjn3F9zF8Me5GJnEZPnwIjsZ6crvXmh3vjAHvygJcnU8iL
        l6ZX4Ahb4Tu+jgrAPxZUXCe13I7yS1aoIahGOEY=
X-Google-Smtp-Source: ABdhPJwXH3KFl4x5Rc0RFSsToohrsPYhCK8XUjA94rh6d7jiY3THMitYZZ/tsMG+hNHW5uuID/0rygMJxULOVjBiqpw=
X-Received: by 2002:a81:854:0:b0:2db:255b:dd6 with SMTP id 81-20020a810854000000b002db255b0dd6mr13412601ywi.140.1646052569778;
 Mon, 28 Feb 2022 04:49:29 -0800 (PST)
MIME-Version: 1.0
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com> <20220228114254.1099945-4-dovmurik@linux.ibm.com>
In-Reply-To: <20220228114254.1099945-4-dovmurik@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Feb 2022 13:49:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFybkGtxH2U6oAi_Qeqe-i_kH-hZjUZKY3-UzPHUg55vg@mail.gmail.com>
Message-ID: <CAMj1kXFybkGtxH2U6oAi_Qeqe-i_kH-hZjUZKY3-UzPHUg55vg@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] efi: Load efi_secret module if EFI secret area is populated
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 28 Feb 2022 at 12:43, Dov Murik <dovmurik@linux.ibm.com> wrote:
>
> If the efi_secret module is built, register a late_initcall in the EFI
> driver which checks whether the EFI secret area is available and
> populated, and then requests to load the efi_secret module.
>
> This will cause the <securityfs>/secrets/coco directory to appear in
> guests into which secrets were injected; in other cases, the module is
> not loaded.
>
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

It would be better to simply expose a platform device and associated
driver, instead of hooking into the module machinery directly.

We already do something similar for the EFI rtc and the efivars
subsystem, using platform_device_register_simple()


> ---
>  drivers/firmware/efi/Makefile        |  1 +
>  drivers/firmware/efi/coco.c          | 58 ++++++++++++++++++++
>  drivers/virt/coco/efi_secret/Kconfig |  3 +
>  3 files changed, 62 insertions(+)
>
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index c02ff25dd477..49c4a8c0bfc4 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_PROPERTIES)                += apple-properties.o
>  obj-$(CONFIG_EFI_RCI2_TABLE)           += rci2-table.o
>  obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)    += embedded-firmware.o
>  obj-$(CONFIG_LOAD_UEFI_KEYS)           += mokvar-table.o
> +obj-$(CONFIG_EFI_COCO_SECRET)          += coco.o
>
>  fake_map-y                             += fake_mem.o
>  fake_map-$(CONFIG_X86)                 += x86_fake_mem.o
> diff --git a/drivers/firmware/efi/coco.c b/drivers/firmware/efi/coco.c
> new file mode 100644
> index 000000000000..f8efd240ab05
> --- /dev/null
> +++ b/drivers/firmware/efi/coco.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Confidential computing (coco) secret area handling
> + *
> + * Copyright (C) 2021 IBM Corporation
> + * Author: Dov Murik <dovmurik@linux.ibm.com>
> + */
> +
> +#define pr_fmt(fmt) "efi: " fmt
> +
> +#include <linux/efi.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kmod.h>
> +
> +#ifdef CONFIG_EFI_SECRET_MODULE
> +
> +/*
> + * Load the efi_secret module if the EFI secret area is populated
> + */
> +static int __init load_efi_secret_module(void)
> +{
> +       struct linux_efi_coco_secret_area *area;
> +       efi_guid_t *header_guid;
> +       int ret = 0;
> +
> +       if (efi.coco_secret == EFI_INVALID_TABLE_ADDR)
> +               return 0;
> +
> +       area = memremap(efi.coco_secret, sizeof(*area), MEMREMAP_WB);
> +       if (!area) {
> +               pr_err("Failed to map confidential computing secret area descriptor\n");
> +               return -ENOMEM;
> +       }
> +       if (!area->base_pa || area->size < sizeof(*header_guid))
> +               goto unmap_desc;
> +
> +       header_guid = (void __force *)ioremap_encrypted(area->base_pa, sizeof(*header_guid));
> +       if (!header_guid) {
> +               pr_err("Failed to map secret area\n");
> +               ret = -ENOMEM;
> +               goto unmap_desc;
> +       }
> +       if (efi_guidcmp(*header_guid, EFI_SECRET_TABLE_HEADER_GUID))
> +               goto unmap_encrypted;
> +
> +       ret = request_module("efi_secret");
> +
> +unmap_encrypted:
> +       iounmap((void __iomem *)header_guid);
> +
> +unmap_desc:
> +       memunmap(area);
> +       return ret;
> +}
> +late_initcall(load_efi_secret_module);
> +
> +#endif
> diff --git a/drivers/virt/coco/efi_secret/Kconfig b/drivers/virt/coco/efi_secret/Kconfig
> index 4404d198f3b2..dc8da2921e36 100644
> --- a/drivers/virt/coco/efi_secret/Kconfig
> +++ b/drivers/virt/coco/efi_secret/Kconfig
> @@ -14,3 +14,6 @@ config EFI_SECRET
>
>           To compile this driver as a module, choose M here.
>           The module will be called efi_secret.
> +
> +         The module is loaded automatically by the EFI driver if the EFI
> +         secret area is populated.
> --
> 2.25.1
>
