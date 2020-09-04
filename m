Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B88725D7C0
	for <lists+linux-efi@lfdr.de>; Fri,  4 Sep 2020 13:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgIDLrb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 07:47:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729297AbgIDLr3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 07:47:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084BX1Mu180994;
        Fri, 4 Sep 2020 07:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4Sbnt809dMBXF6cKluyEYXfuJYTsWdN/zlL8Yb9u6rY=;
 b=E8HMmcq7MTFKqRrv7/lvPB7s8oTwc6WBUQ6cz2ETXBs29yrBiUN5azhCdUKrfM5O0duc
 M5c7wjfZRPpw+lin9pmpfOED8q5Ti6TuomZtDJ2Evb+uJkLd28japrdPH95Uhe4hggxA
 YRWJpSciy3IfJT/5u+m7DN9F71oIPxo74nKHtUSt+irBwVG85OuGKASRjAJgTkMxj4ve
 jhty50GvknBZDPKd+GgRzwFugbaQtrX95KJDh11dDRk0avcPU+vmjfSxZG1hxkp6mqBx
 neuQK+dyYmugDeGglXZ+zpPW6WesdT+JzR7dVJFItyOqy8dn8RVZtfHZFDEPyTJLF835 Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bmh5rtvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 07:47:14 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 084BX1FF180986;
        Fri, 4 Sep 2020 07:47:14 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bmh5rtuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 07:47:13 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 084BfjPk029412;
        Fri, 4 Sep 2020 11:47:11 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 337e9h46es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 11:47:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 084Bl8lV32112904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Sep 2020 11:47:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B684FAE053;
        Fri,  4 Sep 2020 11:47:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76F45AE045;
        Fri,  4 Sep 2020 11:47:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.87.223])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Sep 2020 11:47:06 +0000 (GMT)
Message-ID: <f18986930ddc2823994b549f1ff1cd742706e188.camel@linux.ibm.com>
Subject: Re: [PATCH 5/6] arm64/ima: add ima arch support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Chester Lin <clin@suse.com>, ardb@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        dmitry.kasatkin@gmail.com, corbet@lwn.net, mark.rutland@arm.com,
        vincenzo.frascino@arm.com, samitolvanen@google.com,
        masahiroy@kernel.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        jlee@suse.com
Date:   Fri, 04 Sep 2020 07:47:05 -0400
In-Reply-To: <20200904072905.25332-6-clin@suse.com>
References: <20200904072905.25332-1-clin@suse.com>
         <20200904072905.25332-6-clin@suse.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_06:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 suspectscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040106
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2020-09-04 at 15:29 +0800, Chester Lin wrote:
> Add arm64 IMA arch support. The arch policy is inherited from x86.
> 
> Signed-off-by: Chester Lin <clin@suse.com>

The "secureboot arch rules" comment should be updated to reflect that
the policy is both "secure and trusted boot arch rules", both here and
in x86.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

thanks,

Mimi

> ---
>  arch/arm64/Kconfig           |  1 +
>  arch/arm64/kernel/Makefile   |  2 ++
>  arch/arm64/kernel/ima_arch.c | 37 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>  create mode 100644 arch/arm64/kernel/ima_arch.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..b5518e7b604d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -196,6 +196,7 @@ config ARM64
>  	select SWIOTLB
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>  	help
>  	  ARM 64-bit (AArch64) Linux support.
>  
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index a561cbb91d4d..0300ab60785d 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -71,3 +71,5 @@ extra-y					+= $(head-y) vmlinux.lds
>  ifeq ($(CONFIG_DEBUG_EFI),y)
>  AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
>  endif
> +
> +obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
> diff --git a/arch/arm64/kernel/ima_arch.c b/arch/arm64/kernel/ima_arch.c
> new file mode 100644
> index 000000000000..46f5641c3da5
> --- /dev/null
> +++ b/arch/arm64/kernel/ima_arch.c
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2018 IBM Corporation
> + */
> +#include <linux/efi.h>
> +#include <linux/module.h>
> +
> +bool arch_ima_get_secureboot(void)
> +{
> +	if (efi_enabled(EFI_SECURE_BOOT))
> +		return true;
> +
> +	return false;
> +}
> +
> +/* secureboot arch rules */
> +static const char * const sb_arch_rules[] = {
> +#if !IS_ENABLED(CONFIG_KEXEC_SIG)
> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> +#endif /* CONFIG_KEXEC_SIG */
> +	"measure func=KEXEC_KERNEL_CHECK",
> +#if !IS_ENABLED(CONFIG_MODULE_SIG)
> +	"appraise func=MODULE_CHECK appraise_type=imasig",
> +#endif
> +	"measure func=MODULE_CHECK",
> +	NULL
> +};
> +
> +const char * const *arch_get_ima_policy(void)
> +{
> +	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
> +		if (IS_ENABLED(CONFIG_MODULE_SIG))
> +			set_module_sig_enforced();
> +		return sb_arch_rules;
> +	}
> +	return NULL;
> +}


