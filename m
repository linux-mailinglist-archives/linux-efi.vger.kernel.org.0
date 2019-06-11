Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C4B3D382
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2019 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405867AbfFKRHw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jun 2019 13:07:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405345AbfFKRHv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jun 2019 13:07:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BH2jAv072072
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 13:07:51 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2em1x1q9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 13:07:50 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 11 Jun 2019 18:07:45 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 18:07:42 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BH7fKg12583310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 17:07:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E9902805A;
        Tue, 11 Jun 2019 17:07:41 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6639C28059;
        Tue, 11 Jun 2019 17:07:40 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.199.191])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 17:07:40 +0000 (GMT)
Subject: Re: [PATCH v3 3/3] powerpc: Add support to initialize ima policy
 rules
To:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garret <matthew.garret@nebula.com>,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>
References: <1560198837-18857-1-git-send-email-nayna@linux.ibm.com>
 <1560198837-18857-4-git-send-email-nayna@linux.ibm.com>
 <20190611051943.GA7516@sathnaga86.in.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Date:   Tue, 11 Jun 2019 13:07:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190611051943.GA7516@sathnaga86.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19061117-0052-0000-0000-000003CE8E55
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011247; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216515; UDB=6.00639636; IPR=6.00997614;
 MB=3.00027265; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 17:07:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061117-0053-0000-0000-00006148D898
Message-Id: <d596d03f-7aaf-d0af-ee45-92a990292ad0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=872 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110109
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 06/11/2019 01:19 AM, Satheesh Rajendran wrote:
> On Mon, Jun 10, 2019 at 04:33:57PM -0400, Nayna Jain wrote:
>> PowerNV secure boot relies on the kernel IMA security subsystem to
>> perform the OS kernel image signature verification. Since each secure
>> boot mode has different IMA policy requirements, dynamic definition of
>> the policy rules based on the runtime secure boot mode of the system is
>> required. On systems that support secure boot, but have it disabled,
>> only measurement policy rules of the kernel image and modules are
>> defined.
>>
>> This patch defines the arch-specific implementation to retrieve the
>> secure boot mode of the system and accordingly configures the IMA policy
>> rules.
>>
>> This patch provides arch-specific IMA policies if PPC_SECURE_BOOT
>> config is enabled.
>>
>> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
>> ---
>>   arch/powerpc/Kconfig           | 14 +++++++++
>>   arch/powerpc/kernel/Makefile   |  1 +
>>   arch/powerpc/kernel/ima_arch.c | 54 ++++++++++++++++++++++++++++++++++
>>   include/linux/ima.h            |  3 +-
>>   4 files changed, 71 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/powerpc/kernel/ima_arch.c
> Hi,
>
> This series failed to build against linuxppc/merge tree with `ppc64le_defconfig`,
>
> arch/powerpc/platforms/powernv/secboot.c:14:6: error: redefinition of 'get_powerpc_sb_mode'
>     14 | bool get_powerpc_sb_mode(void)
>        |      ^~~~~~~~~~~~~~~~~~~
> In file included from arch/powerpc/platforms/powernv/secboot.c:11:
> ./arch/powerpc/include/asm/secboot.h:15:20: note: previous definition of 'get_powerpc_sb_mode' was here
>     15 | static inline bool get_powerpc_sb_mode(void)
>        |                    ^~~~~~~~~~~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:278: arch/powerpc/platforms/powernv/secboot.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:489: arch/powerpc/platforms/powernv] Error 2
> make[1]: *** [scripts/Makefile.build:489: arch/powerpc/platforms] Error 2
> make: *** [Makefile:1071: arch/powerpc] Error 2
> make: *** Waiting for unfinished jobs....


Thanks for reporting. I have fixed it and reposted as v4.

Please retry.

Thanks & Regards,
      - Nayna


