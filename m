Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4BFC1300
	for <lists+linux-efi@lfdr.de>; Sun, 29 Sep 2019 06:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfI2EUv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Sep 2019 00:20:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfI2EUv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 29 Sep 2019 00:20:51 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8T47IJp106430
        for <linux-efi@vger.kernel.org>; Sun, 29 Sep 2019 00:20:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vammcry81-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sun, 29 Sep 2019 00:20:50 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 29 Sep 2019 05:20:47 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 29 Sep 2019 05:20:42 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8T4Kf8m42926160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Sep 2019 04:20:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14F41A4051;
        Sun, 29 Sep 2019 04:20:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D89D1A404D;
        Sun, 29 Sep 2019 04:20:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.142.195])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 29 Sep 2019 04:20:38 +0000 (GMT)
Subject: Re: [PATCH v6 5/9] powerpc/ima: add measurement rules to ima arch
 specific policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Sun, 29 Sep 2019 00:20:38 -0400
In-Reply-To: <1569594360-7141-6-git-send-email-nayna@linux.ibm.com>
References: <1569594360-7141-1-git-send-email-nayna@linux.ibm.com>
         <1569594360-7141-6-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092904-0028-0000-0000-000003A3A3C0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092904-0029-0000-0000-00002465C963
Message-Id: <1569730838.4999.31.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-29_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909290047
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2019-09-27 at 10:25 -0400, Nayna Jain wrote:
> This patch adds the measurement rules to the arch specific policies for the
> systems with trusted boot.
> 

on trusted boot enabled systems.


> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Minor comment correction below.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  arch/powerpc/kernel/ima_arch.c | 44 +++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
> index 39401b67f19e..77c61b142042 100644
> --- a/arch/powerpc/kernel/ima_arch.c
> +++ b/arch/powerpc/kernel/ima_arch.c
> @@ -12,8 +12,18 @@ bool arch_ima_get_secureboot(void)
>  	return is_powerpc_os_secureboot_enabled();
>  }
>  
> -/* Defines IMA appraise rules for secureboot */
> +/*
> + * The "arch_rules" contains both the securebot and trustedboot rules for adding
> + * the kexec kernel image and kernel modules file hashes to the IMA measurement
> + * list and verifying the file signatures against known good values.
> + *
> + * The "appraise_type=imasig|modsig" option allows the good signature to be
> + * stored as an xattr or as an appended signature. The "template=ima-modsig"
> + * option includes the appended signature in the IMA measurement list.

includes the appended signature, when available, in the IMA
measurement list. 

> + */
>  static const char *const arch_rules[] = {
> +	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
> +	"measure func=MODULE_CHECK template=ima-modsig",
>  	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>  #if !IS_ENABLED(CONFIG_MODULE_SIG)
>  	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
> @@ -22,12 +32,40 @@ static const char *const arch_rules[] = {
>  };
>  
>  /*
> - * Returns the relevant IMA arch policies based on the system secureboot state.
> + * The "measure_rules" are enabled only on "trustedboot" enabled systems.
> + * These rules add the kexec kernel image and kernel modules file hashes to
> + * the IMA measurement list.
> + */
> +static const char *const measure_rules[] = {
> +	"measure func=KEXEC_KERNEL_CHECK",
> +	"measure func=MODULE_CHECK",
> +	NULL
> +};
> +
> +/*
> + * Returns the relevant IMA arch policies based on the system secureboot
> + * and trustedboot state.
>   */
>  const char *const *arch_get_ima_policy(void)
>  {
> -	if (is_powerpc_os_secureboot_enabled())
> +	const char *const *rules;
> +	int offset = 0;
> +
> +	for (rules = arch_rules; *rules != NULL; rules++) {
> +		if (strncmp(*rules, "appraise", 8) == 0)
> +			break;
> +		offset++;
> +	}
> +
> +	if (is_powerpc_os_secureboot_enabled()
> +	    && is_powerpc_trustedboot_enabled())
>  		return arch_rules;
>  
> +	if (is_powerpc_os_secureboot_enabled())
> +		return arch_rules + offset;
> +
> +	if (is_powerpc_trustedboot_enabled())
> +		return measure_rules;
> +
>  	return NULL;
>  }

