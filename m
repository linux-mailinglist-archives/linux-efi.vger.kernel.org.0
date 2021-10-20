Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EED43455C
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 08:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhJTGqY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 02:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhJTGqY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Oct 2021 02:46:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A85CE610EA;
        Wed, 20 Oct 2021 06:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634712250;
        bh=pJ6WR/t3kSUGVEbEEgaAeXBrFHQpAxoHqhWBx9sS1rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7kPJcuXrIpclvVWP3ARxvSGjHQGl4awiLNDu5UpKZjn+uh3UaXm88SzYgI27+gWU
         MRKN2rgmQVZ+Kqh+9UbgUYHMgDios3U7xLU6uswezW7ai4dipDZvK4GXQbqa2MPToB
         eiGs6360/lQ5OFNjAHrgZ2X5nMPFCQi5MtMdAVNk=
Date:   Wed, 20 Oct 2021 08:40:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] efi: Reserve confidential computing secret area
Message-ID: <YW+55YcXqUtrw4/T@kroah.com>
References: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
 <20211020061408.3447533-3-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020061408.3447533-3-dovmurik@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 20, 2021 at 06:14:07AM +0000, Dov Murik wrote:
> When efi-stub copies an EFI-provided confidential computing (coco)
> secret area, reserve that memory block for future use within the kernel.
> 
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> ---
>  arch/x86/platform/efi/efi.c   |  3 +++
>  drivers/firmware/efi/Makefile |  1 +
>  drivers/firmware/efi/coco.c   | 41 +++++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/efi.c    |  8 +++++++
>  include/linux/efi.h           | 10 +++++++++
>  5 files changed, 63 insertions(+)
>  create mode 100644 drivers/firmware/efi/coco.c
> 
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 147c30a81f15..1591d67e0bcd 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -93,6 +93,9 @@ static const unsigned long * const efi_tables[] = {
>  #ifdef CONFIG_LOAD_UEFI_KEYS
>  	&efi.mokvar_table,
>  #endif
> +#ifdef CONFIG_EFI_COCO_SECRET
> +	&efi.coco_secret,
> +#endif
>  };
>  
>  u64 efi_setup;		/* efi setup_data physical address */
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index c02ff25dd477..49c4a8c0bfc4 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
>  obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
>  obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
>  obj-$(CONFIG_LOAD_UEFI_KEYS)		+= mokvar-table.o
> +obj-$(CONFIG_EFI_COCO_SECRET)		+= coco.o
>  
>  fake_map-y				+= fake_mem.o
>  fake_map-$(CONFIG_X86)			+= x86_fake_mem.o
> diff --git a/drivers/firmware/efi/coco.c b/drivers/firmware/efi/coco.c
> new file mode 100644
> index 000000000000..42f477d6188c
> --- /dev/null
> +++ b/drivers/firmware/efi/coco.c
> @@ -0,0 +1,41 @@
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
> +#include <linux/memblock.h>
> +#include <asm/early_ioremap.h>
> +
> +/*
> + * Reserve the confidential computing secret area memory
> + */
> +int __init efi_coco_secret_area_reserve(void)
> +{
> +	struct linux_efi_coco_secret_area *secret_area;
> +	unsigned long secret_area_size;
> +
> +	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR)
> +		return 0;
> +
> +	secret_area = early_memremap(efi.coco_secret, sizeof(*secret_area));
> +	if (!secret_area) {
> +		pr_err("Failed to map confidential computing secret area\n");
> +		efi.coco_secret = EFI_INVALID_TABLE_ADDR;
> +		return -ENOMEM;
> +	}
> +
> +	secret_area_size = sizeof(*secret_area) + secret_area->size;
> +	memblock_reserve(efi.coco_secret, secret_area_size);
> +
> +	pr_info("Reserved memory of EFI-provided confidential computing secret area");

When kernel code works properly, it is quiet.  Why do you need to print
this out at every boot?

> +
> +	early_memunmap(secret_area, sizeof(*secret_area));
> +	return 0;
> +}

And again, when is this memory freed when shutting down?

thanks,

greg k-h
