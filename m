Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4D7C2B7D
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2019 03:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfJABFk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Sep 2019 21:05:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727320AbfJABFk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Sep 2019 21:05:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9112B0t102786;
        Mon, 30 Sep 2019 21:05:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vbsx9cd52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 21:05:02 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9113SJm105324;
        Mon, 30 Sep 2019 21:05:01 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vbsx9cd4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 21:05:01 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9113370014972;
        Tue, 1 Oct 2019 01:05:00 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 2v9y57d0gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 01:05:00 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9114wdU55968128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Oct 2019 01:04:58 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31406C6057;
        Tue,  1 Oct 2019 01:04:58 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F9F3C605A;
        Tue,  1 Oct 2019 01:04:53 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.220.184])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Oct 2019 01:04:52 +0000 (GMT)
References: <1569594360-7141-1-git-send-email-nayna@linux.ibm.com> <1569594360-7141-4-git-send-email-nayna@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 3/9] powerpc: add support to initialize ima policy rules
In-reply-to: <1569594360-7141-4-git-send-email-nayna@linux.ibm.com>
Date:   Mon, 30 Sep 2019 22:04:48 -0300
Message-ID: <877e5pwa1b.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-30_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010009
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Hello,

Nayna Jain <nayna@linux.ibm.com> writes:

> PowerNV systems uses kernel based bootloader, thus its secure boot
> implementation uses kernel IMA security subsystem to verify the kernel
> before kexec. Since the verification policy might differ based on the
> secure boot mode of the system, the policies are defined at runtime.
>
> This patch implements the arch-specific support to define the IMA policy
> rules based on the runtime secure boot mode of the system.
>
> This patch provides arch-specific IMA policies if PPC_SECURE_BOOT
> config is enabled.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig           |  2 ++
>  arch/powerpc/kernel/Makefile   |  2 +-
>  arch/powerpc/kernel/ima_arch.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/ima.h            |  3 ++-
>  4 files changed, 38 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/kernel/ima_arch.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2c54beb29f1a..54eda07c74e5 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -916,6 +916,8 @@ config PPC_SECURE_BOOT
>  	prompt "Enable secure boot support"
>  	bool
>  	depends on PPC_POWERNV
> +	depends on IMA
> +	depends on IMA_ARCH_POLICY
>  	help
>  	  Systems with firmware secure boot enabled needs to define security
>  	  policies to extend secure boot to the OS. This config allows user
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 875b0785a20e..7156ac1fc956 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -157,7 +157,7 @@ endif
>  obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
>  obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
>
> -obj-$(CONFIG_PPC_SECURE_BOOT)	+= secure_boot.o
> +obj-$(CONFIG_PPC_SECURE_BOOT)	+= secure_boot.o ima_arch.o
>
>  # Disable GCOV, KCOV & sanitizers in odd or sensitive code
>  GCOV_PROFILE_prom_init.o := n
> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
> new file mode 100644
> index 000000000000..39401b67f19e
> --- /dev/null
> +++ b/arch/powerpc/kernel/ima_arch.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain
> + */
> +
> +#include <linux/ima.h>
> +#include <asm/secure_boot.h>
> +
> +bool arch_ima_get_secureboot(void)
> +{
> +	return is_powerpc_os_secureboot_enabled();
> +}
> +
> +/* Defines IMA appraise rules for secureboot */
> +static const char *const arch_rules[] = {
> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
> +#if !IS_ENABLED(CONFIG_MODULE_SIG)
> +	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
> +#endif
> +	NULL
> +};
> +
> +/*
> + * Returns the relevant IMA arch policies based on the system secureboot state.
> + */
> +const char *const *arch_get_ima_policy(void)
> +{
> +	if (is_powerpc_os_secureboot_enabled())
> +		return arch_rules;
> +
> +	return NULL;
> +}

If CONFIG_MODULE_SIG is enabled but module signatures aren't enforced,
then IMA won't enforce module signature either. x86's
arch_get_ima_policy() calls set_module_sig_enforced(). Doesn't the
powerpc version need to do that as well?

On the flip side, if module signatures are enforced by the module
subsystem then IMA will verify the signature a second time since there's
no sharing of signature verification results between the module
subsystem and IMA (this was observed by Mimi).

IMHO this is a minor issue, since module loading isn't a hot path and
the duplicate work shouldn't impact anything. But it could be avoided by
having a NULL entry in arch_rules, which arch_get_ima_policy() would
dynamically update with the "appraise func=MODULE_CHECK" rule if
is_module_sig_enforced() is true.

--
Thiago Jung Bauermann
IBM Linux Technology Center
