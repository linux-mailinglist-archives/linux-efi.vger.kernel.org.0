Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7300798AA6
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2019 07:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfHVFCm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Aug 2019 01:02:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33496 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfHVFCm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Aug 2019 01:02:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so2787673pgn.0;
        Wed, 21 Aug 2019 22:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=G2YwCsG49ayjEsfaaTfZWksO9ojMqS2MFaqkKcrZSO4=;
        b=SRFi5P2NOcEPpmh3gv0H7a6qYusKyqO+o+e/y8U0ZVKyy/ymbT2J1QXRscnuYNeVSP
         wfSiHaJsIgnPx04q9XcHHDuQlJZsDuwiyiQVFKMtjQmWz+2qo5IIMQ6fqcWADVSTR+mH
         Q2e8qoGQAhDcOpco7fTUvoEteO1jhipWYq4ar3Vye+Ld+GOdgedkDEAMEGNL7wN81t4Q
         Y4AbBg7vCHRZtvOhuEe2nCzvOlYbihj9pWQ7aYffxT2r3mQx/4mYDsXFkbDXaKWF9Q+u
         mPBo6zBV/UJngPPBUA3ZuSOJj3DlokDR/b3bf/oxvQNoJPe9onKjZC7uqNkuztKO65Ga
         RnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=G2YwCsG49ayjEsfaaTfZWksO9ojMqS2MFaqkKcrZSO4=;
        b=JpiTvH8E8RK2mX+h1aEqKFxcmX7Hb52C2ErU5adSUVT1AtQ0MXffOpg1Py+9ZKgeOq
         1Px0LVbuN58OpZE7rzbUWUPApVVNfxaMjxq/5wssoob/lRHshh7TDtvaRFAmuNaAraGL
         eYBUvNAAu5Z3US2XM/AUixFUpJAOuKKUyKyVxScoHQ3jl4Nod/TmNhx028CouKl8HNWx
         usjMo55NV1nn70zkz2Q2yglgAsU9JkNSQwFlc1y1m6wR9mLWrSMr9YyTB+OVEHsthPeW
         NJljcu4+iJhw23tD0W3B6/KbixmafA+g3zJLAmCiLVHMK3vn0rWCpCV3xqDAtjuu9nmX
         YHsg==
X-Gm-Message-State: APjAAAWt25XyRGPWRHS5IjZQbZcQRPh2uQkY1N5zwxLmb/Xcv9tggWMT
        RXAN12FbVH5Lu9/ibCf4TOo=
X-Google-Smtp-Source: APXvYqylwS76fFFNKVMNqsFFQIUDfM9JN8RuhINp6htDvT03HL1BOrss1q7POwvQWI3qLcmpnXF93A==
X-Received: by 2002:a63:6106:: with SMTP id v6mr31564529pgb.36.1566450160714;
        Wed, 21 Aug 2019 22:02:40 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
        by smtp.googlemail.com with ESMTPSA id j11sm1921312pjb.11.2019.08.21.22.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 22:02:39 -0700 (PDT)
Message-ID: <eda9210b56ab220519642d272079eeca60a18265.camel@gmail.com>
Subject: Re: [PATCH v2 1/4] powerpc/powernv: Add OPAL API interface to
 access secure variable
From:   Oliver O'Halloran <oohall@gmail.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
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
        Eric Ricther <erichte@linux.ibm.com>
Date:   Thu, 22 Aug 2019 15:02:32 +1000
In-Reply-To: <1566400103-18201-2-git-send-email-nayna@linux.ibm.com>
References: <1566400103-18201-1-git-send-email-nayna@linux.ibm.com>
         <1566400103-18201-2-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2019-08-21 at 11:08 -0400, Nayna Jain wrote:
> The X.509 certificates trusted by the platform and required to secure boot
> the OS kernel are wrapped in secure variables, which are controlled by
> OPAL.
> 
> This patch adds firmware/kernel interface to read and write OPAL secure
> variables based on the unique key.
> 
> This support can be enabled using CONFIG_OPAL_SECVAR.
> 
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/opal-api.h          |   5 +-
>  arch/powerpc/include/asm/opal.h              |   6 ++
>  arch/powerpc/include/asm/secvar.h            |  55 ++++++++++
>  arch/powerpc/kernel/Makefile                 |   2 +-
>  arch/powerpc/kernel/secvar-ops.c             |  25 +++++
>  arch/powerpc/platforms/powernv/Kconfig       |   6 ++
>  arch/powerpc/platforms/powernv/Makefile      |   1 +
>  arch/powerpc/platforms/powernv/opal-call.c   |   3 +
>  arch/powerpc/platforms/powernv/opal-secvar.c | 102 +++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal.c        |   5 +
>  10 files changed, 208 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/secvar.h
>  create mode 100644 arch/powerpc/kernel/secvar-ops.c
>  create mode 100644 arch/powerpc/platforms/powernv/opal-secvar.c
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 383242eb0dea..b238b4f26c5b 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -208,7 +208,10 @@
>  #define OPAL_HANDLE_HMI2			166
>  #define	OPAL_NX_COPROC_INIT			167
>  #define OPAL_XIVE_GET_VP_STATE			170
> -#define OPAL_LAST				170
> +#define OPAL_SECVAR_GET                         173
> +#define OPAL_SECVAR_GET_NEXT                    174
> +#define OPAL_SECVAR_ENQUEUE_UPDATE              175
> +#define OPAL_LAST                               175
>  
>  #define QUIESCE_HOLD			1 /* Spin all calls at entry */
>  #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 57bd029c715e..247adec2375f 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -388,6 +388,12 @@ void opal_powercap_init(void);
>  void opal_psr_init(void);
>  void opal_sensor_groups_init(void);

Put these with the rest of the OPAL API wrapper prototypes
(i.e. just after opal_nx_coproc_init()) rather than with the
internal functions.
 
> > +extern int opal_secvar_get(uint64_t k_key, uint64_t k_key_len,
> +			   uint64_t k_data, uint64_t k_data_size);
> +extern int opal_secvar_get_next(uint64_t k_key, uint64_t k_key_len,
> +				uint64_t k_key_size);
> +extern int opal_secvar_enqueue_update(uint64_t k_key, uint64_t k_key_len,
> +				      uint64_t k_data, uint64_t k_data_size);

Everything in asm/opal.h is intended for consumption by the kernel, so
use a useful kernel type (or annotation) rather than blank uint64_t for
the parameters that are actually pointers. You should also ditch the k_
prefix since it doesn't make much sense having it inside the kernel.

As a general comment, don't use extern on function prototypes. They're
extern by default and, more importantly, it's contrary to the normal
kernel style.

>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_POWERPC_OPAL_H */
> diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
> new file mode 100644
> index 000000000000..645654456265
> --- /dev/null
> +++ b/arch/powerpc/include/asm/secvar.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PowerPC secure variable operations.
> + *
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain <nayna@linux.ibm.com>
> + *
> + */
> +#ifndef SECVAR_OPS_H
> +#define SECVAR_OPS_H
> +
> +#include<linux/types.h>
> +#include<linux/errno.h>
missing space

> +
> +struct secvar_operations {
> +	int (*get_variable)(const char *key, unsigned long key_len, u8 *data,
> +			    unsigned long *data_size);
> +	int (*get_next_variable)(const char *key, unsigned long *key_len,
> +				 unsigned long keysize);
> +	int (*set_variable)(const char *key, unsigned long key_len, u8 *data,
> +			    unsigned long data_size);
> +};


Calling them requires writing code like:

	secvar_ops->get_variable(blah);

Why not shorten it to:
	secvar_ops->get(blah);


> +#ifdef CONFIG_PPC_SECURE_BOOT
> +
> +extern void set_secvar_ops(struct secvar_operations *ops);
> +extern struct secvar_operations *get_secvar_ops(void);
> +
> +#else
> +
> +static inline void set_secvar_ops(struct secvar_operations *ops)
> +{
> +}
> +
> +static inline struct secvar_operations *get_secvar_ops(void)
> +{
> +	return NULL;
> +}
> +
> +#endif
> +#ifdef CONFIG_OPAL_SECVAR
> +
> +extern int secvar_init(void);
> +
> +#else
> +
> +static inline int secvar_init(void)
> +{
> +	return -EINVAL;
> +}
> +
> +#endif

The init function is always going to be platform specific so having an
opal-specific secvar_init() in a generic header doesn't make much sense
to me.

> +
> +#endif
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 520b1c814197..9041563f1c74 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -157,7 +157,7 @@ endif
>  obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
>  obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
>  
> -obj-$(CONFIG_PPC_SECURE_BOOT)	+= secboot.o ima_arch.o
> +obj-$(CONFIG_PPC_SECURE_BOOT)	+= secboot.o ima_arch.o secvar-ops.o
>  
>  # Disable GCOV, KCOV & sanitizers in odd or sensitive code
>  GCOV_PROFILE_prom_init.o := n
> diff --git a/arch/powerpc/kernel/secvar-ops.c b/arch/powerpc/kernel/secvar-ops.c
> new file mode 100644
> index 000000000000..198222499848
> --- /dev/null
> +++ b/arch/powerpc/kernel/secvar-ops.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain <nayna@linux.ibm.com>
> + *
> + * secvar-ops.c
> + *      - initialize secvar operations for PowerPC Secureboot
> + */
> +

> +#include<stddef.h>
> +#include<asm/secvar.h>
missing space

> +
> +static struct secvar_operations *secvars_ops;
should be const

> +
> +void set_secvar_ops(struct secvar_operations *ops)
> +{
> +	if (!ops)
> +		secvars_ops = NULL;
> +	secvars_ops = ops;
> +}
> +
> +struct secvar_operations *get_secvar_ops(void)
> +{
> +	return secvars_ops;
> +}

Is this really any better than just making the ops pointer global?

> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
> index 850eee860cf2..65b060539b5c 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -47,3 +47,9 @@ config PPC_VAS
>  	  VAS adapters are found in POWER9 based systems.
>  
>  	  If unsure, say N.
> +
> +config OPAL_SECVAR
> +	bool "OPAL Secure Variables"
> +	depends on PPC_POWERNV
> +	help
> +	  This enables the kernel to access OPAL secure variables.
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index da2e99efbd04..6651c742e530 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
>  obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
>  obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o
>  obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
> +obj-$(CONFIG_OPAL_SECVAR) += opal-secvar.o
> diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
> index 29ca523c1c79..93106e867924 100644
> --- a/arch/powerpc/platforms/powernv/opal-call.c
> +++ b/arch/powerpc/platforms/powernv/opal-call.c
> @@ -287,3 +287,6 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
>  OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
>  OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
>  OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
> +OPAL_CALL(opal_secvar_get,                     OPAL_SECVAR_GET);
> +OPAL_CALL(opal_secvar_get_next,                 OPAL_SECVAR_GET_NEXT);
> +OPAL_CALL(opal_secvar_enqueue_update,           OPAL_SECVAR_ENQUEUE_UPDATE);
> diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
> new file mode 100644
> index 000000000000..b0f97cea7675
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-secvar.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PowerNV code for secure variables
> + *
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Claudio Carvalho <cclaudio@linux.ibm.com>
> + *
> + * APIs to access secure variables managed by OPAL.
> + *
> + */
> +
> +#define pr_fmt(fmt) "secvar: "fmt
> +
> +#include <linux/types.h>
> +#include <asm/opal.h>
> +#include <asm/secvar.h>
> +
> +static bool is_opal_secvar_supported(void)
> +{
> +	static bool opal_secvar_supported;
> +	static bool initialized;
> +
> +	if (initialized)
> +		return opal_secvar_supported;
> +
> +	if (!opal_check_token(OPAL_SECVAR_GET)
> +			|| !opal_check_token(OPAL_SECVAR_GET_NEXT)
> +			|| !opal_check_token(OPAL_SECVAR_ENQUEUE_UPDATE)) {

> +		pr_err("OPAL doesn't support secure variables\n");

This should only print an error if OPAL has advertised support for
secure variables through the DT, but doesn't support the OPAL
calls. Otherwise we'll get a spurious error message on any system
running currently released firmware.

> +		opal_secvar_supported = false;
> +	} else {
> +		opal_secvar_supported = true;
> +	}
> +
> +	initialized = true;
> +
> +	return opal_secvar_supported;
> +}
> +
> +static int opal_get_variable(const char *key, unsigned long ksize,
> +			     u8 *data, unsigned long *dsize)
> +{
> +	int rc;
> +
> +	if (!is_opal_secvar_supported())
> +		return OPAL_UNSUPPORTED;

This should be -ENXIO or -ENOSUPP. OPAL_UNSUPPORTED is an OPAL return
code, not a kernel one. That said, if the firmware doesn't support
secure variables we should never be calling this function anyway since
the ops pointer is never set.

> +
> +	if (dsize)
> +		*dsize = cpu_to_be64(*dsize);
> +
> +	rc = opal_secvar_get(__pa(key), ksize,
> +			__pa(data), __pa(dsize));
> +
> +	if (dsize)
> +		*dsize = be64_to_cpu(*dsize);
> +
> +	return rc;
> +}
> +
> +static int opal_get_next_variable(const char *key, unsigned long *keylen,
> +				  unsigned long keysize)
> +{
> +	int rc;
> +
> +	if (!is_opal_secvar_supported())
> +		return OPAL_UNSUPPORTED;
> +
> +	if (keylen)
> +		*keylen = cpu_to_be64(*keylen);
> +
> +	rc = opal_secvar_get_next(__pa(key), __pa(keylen), keysize);
> +
> +	if (keylen)
> +		*keylen = be64_to_cpu(*keylen);
> +
> +	return rc;
> +}
> +
> +static int opal_set_variable(const char *key, unsigned long ksize, u8 *data,
> +			     unsigned long dsize)
> +{
> +	int rc;
> +
> +	if (!is_opal_secvar_supported())
> +		return OPAL_UNSUPPORTED;
> +
> +	rc = opal_secvar_enqueue_update(__pa(key), ksize, __pa(data), dsize);
> +
> +	return rc;
> +}
> +

> +static struct secvar_operations secvar_ops = {
> +	.get_variable = opal_get_variable,
> +	.get_next_variable = opal_get_next_variable,
> +	.set_variable = opal_set_variable,
> +};

should be const

> +int secvar_init(void)
> +{
> +	set_secvar_ops(&secvar_ops);
> +	return 0;
> +}

Rename this to opal_secvar_init() and put the prototype in
arch/powerpc/platforms/powernv/powernv.h

> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index aba443be7daa..ffe6f1cf0830 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -32,6 +32,8 @@
>  #include <asm/mce.h>
>  #include <asm/imc-pmu.h>
>  #include <asm/bug.h>
> +#include <asm/secvar.h>
> +#include <asm/secboot.h>
>  
>  #include "powernv.h"
>  
> @@ -988,6 +990,9 @@ static int __init opal_init(void)
>  	/* Initialise OPAL Power control interface */
>  	opal_power_control_init();
>  
> +	if (is_powerpc_secvar_supported())
> +		secvar_init();
> +

The usual pattern here is to have the init function check for support
internally.

Also, is_powerpc_secvar_supported() doesn't appear to be defined
anywhere. Is that supposed to be is_opal_secvar_supported()? Or is this
series supposed to be applied on top of another series?

>  	return 0;
>  }
>  machine_subsys_initcall(powernv, opal_init);

