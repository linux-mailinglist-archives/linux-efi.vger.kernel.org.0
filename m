Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A499D74F8
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2019 13:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfJOLa0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Oct 2019 07:30:26 -0400
Received: from ozlabs.org ([203.11.71.1]:48749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfJOLaZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Oct 2019 07:30:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46stWy4V4Vz9sPT;
        Tue, 15 Oct 2019 22:30:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1571139022;
        bh=1eSJsIMBoWHeDq5KLb0eoFiVgpIn29MQJlQXUW5sRtk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=J9Ac8/P25NMdHWeR5CUvbEmDgE8D1JV/Uc1TBzMwEDKYQ06wFxjnX31yZ+2aCm2KM
         hbGUfxPkAj5zRvjml6wUEU6BOvSKBzWD2zwIpC+j8Wttt20bnZ2ts6D36+ImCgFxVW
         nhfa8VrcQdboAUE+JHky85Oo5VmKOXcSTCg2Vx2UqYpy1RBtd/tJNywhckPewDWO6q
         ilB6LxjdOQRNhKmKJaYzb9JcJx4RrvoBC8Qy/qrFs71IjR4u07gspa1fswMp+clmOP
         L2jH/JHsWwJ/uQFKWpn7bsoOlPXc5Y0XcWTeylVLelj5ZM8bM5o2j77GkLJsq/6TUL
         6mz/O/JHVz2lg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v7 1/8] powerpc: detect the secure boot mode of the system
In-Reply-To: <1570497267-13672-2-git-send-email-nayna@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com> <1570497267-13672-2-git-send-email-nayna@linux.ibm.com>
Date:   Tue, 15 Oct 2019 22:30:21 +1100
Message-ID: <87zhi2tfea.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Nayna,

Just a few comments.

Nayna Jain <nayna@linux.ibm.com> writes:
> Secure boot on PowerNV defines different IMA policies based on the secure
> boot state of the system.

This description has got out of sync with what the patch does I think.
There's no IMA in here. I think you can just drop that sentence.

> This patch defines a function to detect the secure boot state of the
> system.

That's what the patch really does ^ - just make it clear that it's only
on powernv.

>
> The PPC_SECURE_BOOT config represents the base enablement of secureboot
> on POWER.

s/POWER/powerpc/.

>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig                   | 10 ++++++
>  arch/powerpc/include/asm/secure_boot.h | 29 ++++++++++++++++++
>  arch/powerpc/kernel/Makefile           |  2 ++
>  arch/powerpc/kernel/secure_boot.c      | 42 ++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/secure_boot.h
>  create mode 100644 arch/powerpc/kernel/secure_boot.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3e56c9c2f16e..b4a221886fcf 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -934,6 +934,16 @@ config PPC_MEM_KEYS
>  
>  	  If unsure, say y.
>  
> +config PPC_SECURE_BOOT
> +	prompt "Enable secure boot support"
> +	bool
> +	depends on PPC_POWERNV
> +	help
> +	  Systems with firmware secure boot enabled needs to define security
                                                        ^
                                                     need
> +	  policies to extend secure boot to the OS. This config allows user
                                                                      ^
                                                                      a
> +	  to enable OS secure boot on systems that have firmware support for
> +	  it. If in doubt say N.
> +
>  endmenu
>  
>  config ISA_DMA_API
> diff --git a/arch/powerpc/include/asm/secure_boot.h b/arch/powerpc/include/asm/secure_boot.h
> new file mode 100644
> index 000000000000..23d2ef2f1f7b
> --- /dev/null
> +++ b/arch/powerpc/include/asm/secure_boot.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Secure boot definitions
> + *
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain
> + */
> +#ifndef _ASM_POWER_SECURE_BOOT_H
> +#define _ASM_POWER_SECURE_BOOT_H
> +
> +#ifdef CONFIG_PPC_SECURE_BOOT
> +
> +bool is_powerpc_os_secureboot_enabled(void);
> +struct device_node *get_powerpc_os_sb_node(void);

This function is never used outside arch/powerpc/kernel/secure_boot.c
and so doesn't need to be public.

> +#else
> +
> +static inline bool is_powerpc_os_secureboot_enabled(void)
> +{

I know there's a distinction between firmware secureboot and OS
secureboot, but I don't think we need that baked into the name. So just
is_ppc_secureboot_enabled() would be fine.

> +	return false;
> +}
> +
> +static inline struct device_node *get_powerpc_os_sb_node(void)
> +{
> +	return NULL;
> +}
> +
> +#endif
> +#endif
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index a7ca8fe62368..e2a54fa240ac 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -161,6 +161,8 @@ ifneq ($(CONFIG_PPC_POWERNV)$(CONFIG_PPC_SVM),)
>  obj-y				+= ucall.o
>  endif
>  
> +obj-$(CONFIG_PPC_SECURE_BOOT)	+= secure_boot.o
> +
>  # Disable GCOV, KCOV & sanitizers in odd or sensitive code
>  GCOV_PROFILE_prom_init.o := n
>  KCOV_INSTRUMENT_prom_init.o := n
> diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
> new file mode 100644
> index 000000000000..0488dbcab6b9
> --- /dev/null
> +++ b/arch/powerpc/kernel/secure_boot.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain
> + */
> +#include <linux/types.h>
> +#include <linux/of.h>
> +#include <asm/secure_boot.h>
> +
> +struct device_node *get_powerpc_os_sb_node(void)
> +{
> +	return of_find_compatible_node(NULL, NULL, "ibm,secvar-v1");
> +}

Given that's only used in this file, once, it should just be inlined
into its caller.

> +
> +bool is_powerpc_os_secureboot_enabled(void)
> +{
> +	struct device_node *node;
> +
> +	node = get_powerpc_os_sb_node();
> +	if (!node)
> +		goto disabled;
> +
> +	if (!of_device_is_available(node)) {
> +		pr_err("Secure variables support is in error state, fail secure\n");
> +		goto enabled;
> +	}
> +
> +	/*
> +	 * secureboot is enabled if os-secure-enforcing property exists,
> +	 * else disabled.
> +	 */
> +	if (!of_find_property(node, "os-secure-enforcing", NULL))

Using of_property_read_bool() is preferable.

> +		goto disabled;
> +
> +enabled:
> +	pr_info("secureboot mode enabled\n");
> +	return true;
> +
> +disabled:
> +	pr_info("secureboot mode disabled\n");
> +	return false;
> +}

You could make that tail a bit more concise by doing something like
below, but up to you:

	bool enabled = false;
        ...

	enabled = of_property_read_bool(node, "os-secure-enforcing");
out:
	pr_info("secureboot mode %s\n", enabled ? "enabled" : "disabled");
	return enabled;
}


cheers
