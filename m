Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C4EF4B8
	for <lists+linux-efi@lfdr.de>; Tue,  5 Nov 2019 06:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbfKEFOi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Nov 2019 00:14:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728110AbfKEFOi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Nov 2019 00:14:38 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA557IWN064143
        for <linux-efi@vger.kernel.org>; Tue, 5 Nov 2019 00:14:34 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w327g1bkv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 05 Nov 2019 00:14:34 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <erichte@linux.ibm.com>;
        Tue, 5 Nov 2019 05:14:32 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Nov 2019 05:14:29 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA55ERdR50397194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Nov 2019 05:14:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B24004C046;
        Tue,  5 Nov 2019 05:14:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBC1D4C040;
        Tue,  5 Nov 2019 05:14:25 +0000 (GMT)
Received: from [9.80.237.45] (unknown [9.80.237.45])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Nov 2019 05:14:25 +0000 (GMT)
Subject: Re: [PATCH v10 1/9] powerpc: detect the secure boot mode of the
 system
To:     Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
 <1572492694-6520-2-git-send-email-zohar@linux.ibm.com>
From:   Eric Richter <erichte@linux.ibm.com>
Date:   Mon, 4 Nov 2019 23:14:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1572492694-6520-2-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19110505-4275-0000-0000-0000037AD8D9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110505-4276-0000-0000-0000388E21BD
Message-Id: <09a57ae4-c7b1-aaf4-0f89-a0d7ed16f6cf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050040
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/30/19 10:31 PM, Mimi Zohar wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> This patch defines a function to detect the secure boot state of a
> PowerNV system.
> 
> The PPC_SECURE_BOOT config represents the base enablement of secure boot
> for powerpc.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig                   | 10 ++++++++++
>  arch/powerpc/include/asm/secure_boot.h | 23 +++++++++++++++++++++++
>  arch/powerpc/kernel/Makefile           |  2 ++
>  arch/powerpc/kernel/secure_boot.c      | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/secure_boot.h
>  create mode 100644 arch/powerpc/kernel/secure_boot.c
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3e56c9c2f16e..56ea0019b616 100644
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
> +	  Systems with firmware secure boot enabled need to define security
> +	  policies to extend secure boot to the OS. This config allows a user
> +	  to enable OS secure boot on systems that have firmware support for
> +	  it. If in doubt say N.
> +
>  endmenu
>  
>  config ISA_DMA_API
> diff --git a/arch/powerpc/include/asm/secure_boot.h b/arch/powerpc/include/asm/secure_boot.h
> new file mode 100644
> index 000000000000..07d0fe0ca81f
> --- /dev/null
> +++ b/arch/powerpc/include/asm/secure_boot.h
> @@ -0,0 +1,23 @@
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
> +bool is_ppc_secureboot_enabled(void);
> +
> +#else
> +
> +static inline bool is_ppc_secureboot_enabled(void)
> +{
> +	return false;
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
> index 000000000000..63dc82c50862
> --- /dev/null
> +++ b/arch/powerpc/kernel/secure_boot.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain
> + */
> +#include <linux/types.h>
> +#include <linux/of.h>
> +#include <asm/secure_boot.h>
> +
> +bool is_ppc_secureboot_enabled(void)
> +{
> +	struct device_node *node;
> +	bool enabled = false;
> +
> +	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-v1");

Per skiboot changes, should instead look for "ibm,secureboot".

Updated set can be found here:
https://patchwork.ozlabs.org/project/skiboot/list/?series=140626

> +	if (!of_device_is_available(node)) {
> +		pr_err("Cannot find secure variable node in device tree; failing to secure state\n");

The default value for "enabled" is false, so it's actually failing insecure. Although, the print is
probably unnecessary.

> +		goto out;
> +	}
> +
> +	/*
> +	 * secureboot is enabled if os-secure-enforcing property exists,
> +	 * else disabled.
> +	 */
> +	enabled = of_property_read_bool(node, "os-secure-enforcing");

Property has been renamed to "os-secureboot-enforcing".

> +> +out:
> +	of_node_put(node);
> +
> +	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
> +	return enabled;
> +}
> 

