Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB863FEE38
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 14:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhIBNAm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 09:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344892AbhIBNAf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Sep 2021 09:00:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CA2B610E6;
        Thu,  2 Sep 2021 12:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630587577;
        bh=kvnpsl+vAp5F0vMNJjaVKsRfY+l5b5vVyeef5rRTjk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6RHHHiwxiAeyErGszL2Ra4YcwPeYHqG+7fpO88sfz0eN6pIrD0bg+n2A0Wdq9T/S
         JIb24b1tkd4cplsfcwebbeGGjZk8DVs9NG9v5i+idgWd5RebFAIKKjY9jsz+b4n4Ed
         dRs7WdnYocqUoBi03ynSEdvIqAeDfv9sMqDo4Lms=
Date:   Thu, 2 Sep 2021 14:59:34 +0200
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
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] virt: Add sev_secret module to expose confidential
 computing secrets
Message-ID: <YTDKtr+W7wBTn/96@kroah.com>
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
 <20210809190157.279332-4-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809190157.279332-4-dovmurik@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 09, 2021 at 07:01:57PM +0000, Dov Murik wrote:
> The new sev_secret module exposes the confidential computing (coco)
> secret area via securityfs interface.
> 
> When the module is loaded (and securityfs is mounted, typically under
> /sys/kernel/security), a "coco/sev_secret" directory is created in
> securityfs.  In it, a file is created for each secret entry.  The name
> of each such file is the GUID of the secret entry, and its content is
> the secret data.
> 
> This allows applications running in a confidential computing setting to
> read secrets provided by the guest owner via a secure secret injection
> mechanism (such as AMD SEV's LAUNCH_SECRET command).
> 
> Removing (unlinking) files in the "coco/sev_secret" directory will zero
> out the secret in memory, and remove the filesystem entry.  If the
> module is removed and loaded again, that secret will not appear in the
> filesystem.
> 
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> ---
>  drivers/virt/Kconfig                      |   3 +
>  drivers/virt/Makefile                     |   1 +
>  drivers/virt/coco/sev_secret/Kconfig      |  11 +
>  drivers/virt/coco/sev_secret/Makefile     |   2 +
>  drivers/virt/coco/sev_secret/sev_secret.c | 313 ++++++++++++++++++++++
>  5 files changed, 330 insertions(+)
>  create mode 100644 drivers/virt/coco/sev_secret/Kconfig
>  create mode 100644 drivers/virt/coco/sev_secret/Makefile
>  create mode 100644 drivers/virt/coco/sev_secret/sev_secret.c
> 
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 8061e8ef449f..6f73672f593f 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -36,4 +36,7 @@ source "drivers/virt/vboxguest/Kconfig"
>  source "drivers/virt/nitro_enclaves/Kconfig"
>  
>  source "drivers/virt/acrn/Kconfig"
> +
> +source "drivers/virt/coco/sev_secret/Kconfig"
> +
>  endif
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index 3e272ea60cd9..2a7d472478bd 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -8,3 +8,4 @@ obj-y				+= vboxguest/
>  
>  obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>  obj-$(CONFIG_ACRN_HSM)		+= acrn/
> +obj-$(CONFIG_AMD_SEV_SECRET)	+= coco/sev_secret/
> diff --git a/drivers/virt/coco/sev_secret/Kconfig b/drivers/virt/coco/sev_secret/Kconfig
> new file mode 100644
> index 000000000000..76cfb4f405e0
> --- /dev/null
> +++ b/drivers/virt/coco/sev_secret/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config AMD_SEV_SECRET
> +	tristate "AMD SEV secret area securityfs support"
> +	depends on AMD_MEM_ENCRYPT && EFI
> +	select SECURITYFS
> +	help
> +	  This is a driver for accessing the AMD SEV secret area via
> +	  securityfs.
> +
> +	  To compile this driver as a module, choose M here.
> +	  The module will be called sev_secret.
> diff --git a/drivers/virt/coco/sev_secret/Makefile b/drivers/virt/coco/sev_secret/Makefile
> new file mode 100644
> index 000000000000..dca0ed3f8f94
> --- /dev/null
> +++ b/drivers/virt/coco/sev_secret/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_AMD_SEV_SECRET) += sev_secret.o
> diff --git a/drivers/virt/coco/sev_secret/sev_secret.c b/drivers/virt/coco/sev_secret/sev_secret.c
> new file mode 100644
> index 000000000000..d9a60166b142
> --- /dev/null
> +++ b/drivers/virt/coco/sev_secret/sev_secret.c
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * sev_secret module
> + *
> + * Copyright (C) 2021 IBM Corporation
> + * Author: Dov Murik <dovmurik@linux.ibm.com>
> + */
> +
> +/**
> + * DOC: sev_secret: Allow reading confidential computing (coco) secret area via
> + * securityfs interface.
> + *
> + * When the module is loaded (and securityfs is mounted, typically under
> + * /sys/kernel/security), a "coco/sev_secret" directory is created in
> + * securityfs.  In it, a file is created for each secret entry.  The name of
> + * each such file is the GUID of the secret entry, and its content is the
> + * secret data.
> + */
> +
> +#include <linux/seq_file.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/security.h>
> +#include <linux/efi.h>
> +
> +#define SEV_SECRET_NUM_FILES 64
> +
> +#define EFI_SEVSECRET_TABLE_HEADER_GUID \
> +	EFI_GUID(0x1e74f542, 0x71dd, 0x4d66, 0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
> +
> +struct sev_secret {
> +	struct dentry *coco_dir;
> +	struct dentry *fs_dir;
> +	struct dentry *fs_files[SEV_SECRET_NUM_FILES];
> +	struct linux_efi_coco_secret_area *secret_area;
> +};
> +
> +/*
> + * Structure of the SEV secret area
> + *
> + * Offset   Length
> + * (bytes)  (bytes)  Usage
> + * -------  -------  -----
> + *       0       16  Secret table header GUID (must be 1e74f542-71dd-4d66-963e-ef4287ff173b)
> + *      16        4  Length of bytes of the entire secret area
> + *
> + *      20       16  First secret entry's GUID
> + *      36        4  First secret entry's length in bytes (= 16 + 4 + x)
> + *      40        x  First secret entry's data
> + *
> + *    40+x       16  Second secret entry's GUID
> + *    56+x        4  Second secret entry's length in bytes (= 16 + 4 + y)
> + *    60+x        y  Second secret entry's data
> + *
> + * (... and so on for additional entries)

Why isn't all of this documented in Documentation/ABI/ which is needed
for any new user/kernel api that you come up with like this.  We have to
have it documented somewhere, otherwise how will you know how to use
these files?

thanks

greg k-h
