Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5403DADAB
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2019 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfJQM7Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Oct 2019 08:59:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbfJQM7X (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Oct 2019 08:59:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9HCqajx130707;
        Thu, 17 Oct 2019 08:58:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vprdx92pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 08:58:56 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9HCqeNS131031;
        Thu, 17 Oct 2019 08:58:56 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vprdx92nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 08:58:56 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9HCuGTX003724;
        Thu, 17 Oct 2019 12:58:55 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 2vk6f815ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 12:58:55 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9HCwroP31457722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 12:58:53 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 390AF13605E;
        Thu, 17 Oct 2019 12:58:53 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAA4013605D;
        Thu, 17 Oct 2019 12:58:50 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.165.227])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 17 Oct 2019 12:58:50 +0000 (GMT)
Subject: Re: [PATCH v7 2/8] powerpc: add support to initialize ima policy
 rules
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Matthew Garret <matthew.garret@nebula.com>,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        George Wilson <gcwilson@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
 <1570497267-13672-3-git-send-email-nayna@linux.ibm.com>
 <871rveuu0i.fsf@mpe.ellerman.id.au>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <fbd8ca54-19ff-b77b-9e15-d900168bbdb3@linux.vnet.ibm.com>
Date:   Thu, 17 Oct 2019 08:58:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <871rveuu0i.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170119
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 10/15/2019 07:29 AM, Michael Ellerman wrote:
> Nayna Jain <nayna@linux.ibm.com> writes:
>> PowerNV systems uses kernel based bootloader, thus its secure boot
>> implementation uses kernel IMA security subsystem to verify the kernel
>> before kexec. Since the verification policy might differ based on the
>> secure boot mode of the system, the policies are defined at runtime.
>>
>> This patch implements the arch-specific support to define the IMA policy
>> rules based on the runtime secure boot mode of the system.
>>
>> This patch provides arch-specific IMA policies if PPC_SECURE_BOOT
>> config is enabled.
> ...
>> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
>> new file mode 100644
>> index 000000000000..c22d82965eb4
>> --- /dev/null
>> +++ b/arch/powerpc/kernel/ima_arch.c
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 IBM Corporation
>> + * Author: Nayna Jain
>> + */
>> +
>> +#include <linux/ima.h>
>> +#include <asm/secure_boot.h>
>> +
>> +bool arch_ima_get_secureboot(void)
>> +{
>> +	return is_powerpc_os_secureboot_enabled();
>> +}
>> +
>> +/* Defines IMA appraise rules for secureboot */
>> +static const char *const arch_rules[] = {
>> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>> +#if !IS_ENABLED(CONFIG_MODULE_SIG_FORCE)
>> +	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
>> +#endif
> This confuses me.
>
> If I spell it out we get:
>
> #if IS_ENABLED(CONFIG_MODULE_SIG_FORCE)
> 	// nothing
> #else
> 	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
> #endif
>
> Which is just:
>
> #ifdef CONFIG_MODULE_SIG_FORCE
> 	// nothing
> #else
> 	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
> #endif
>
> But CONFIG_MODULE_SIG_FORCE enabled says that we *do* require modules to
> have a valid signature. Isn't that the inverse of what the rules say?
>
> Presumably I'm misunderstanding something :)

To avoid duplicate signature verification as much as possible, the IMA 
policy rule is added only if CONFIG_MODULE_SIG_FORCE is not enabled. 
CONFIG_MODULE_SIG_FORCE is part of modules support. IMA signature 
verification is based on policy.

Thanks & Regards,
      - Nayna

