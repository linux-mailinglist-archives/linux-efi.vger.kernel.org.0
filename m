Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672CA3B6EAB
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jun 2021 09:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhF2H0u (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Jun 2021 03:26:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232182AbhF2H0u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Jun 2021 03:26:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T73gfB055349;
        Tue, 29 Jun 2021 03:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1vA65LUOxdzS+qRVdjMOwhh+4VfRa8ghdpzPy5WUhBs=;
 b=YTQQlzQZMmzN5XdeYiMdu3IYJBRdgRYQU1awl0Y8sl2josWMlHV0jvltKa2l3pIAh5/1
 V1OttJS1d/d4pH3AWTDZY3cyXoL5nW4jMmwLfn3j6mhlHK6zJwArZAPu+3M8gYjddhf4
 VVAMDZIjrZUeC86CvrVa46jvG0wEEaiiUkt2oUVG0rw05GX3LVRi8aUxdcLMmU+oxnCH
 rNNOsa+A4FPuJoKWMPeQ4hY93PSbCslV6UB0t6mjhqIJTbwKWci5nXoP7mSyg0UCd0Xe
 4egSjSFamwuel87htDEvw0Q3tjT4+92fTuv58cUDjYrF2hs5qf5Hwo1kpVaGD3eIrnzl 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fwa5jkw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 03:24:02 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15T742Yn056895;
        Tue, 29 Jun 2021 03:24:01 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fwa5jkuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 03:24:01 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15T7NxXJ014280;
        Tue, 29 Jun 2021 07:23:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 39ft8er1jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 07:23:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15T7MKnE21692804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 07:22:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2B5DA4054;
        Tue, 29 Jun 2021 07:23:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF727A405B;
        Tue, 29 Jun 2021 07:23:50 +0000 (GMT)
Received: from [9.160.49.135] (unknown [9.160.49.135])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 07:23:50 +0000 (GMT)
Subject: Re: [RFC PATCH v2 3/3] virt: Add sev_secret module to expose
 confidential computing secrets
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-efi@vger.kernel.org, Laszlo Ersek <lersek@redhat.com>,
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
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20210628183431.953934-1-dovmurik@linux.ibm.com>
 <20210628183431.953934-4-dovmurik@linux.ibm.com> <YNojYBIwk0xCHQ0v@zn.tnic>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <6e35f6db-9c5b-3c75-a66b-de1392295f6a@linux.ibm.com>
Date:   Tue, 29 Jun 2021 10:23:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNojYBIwk0xCHQ0v@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JUDPkLjGeAeHzYs28BbUkloBVAObIJns
X-Proofpoint-ORIG-GUID: 5-vxk4qAy8PYa_wxU5hKn0WiPMHHmLSy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_02:2021-06-25,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290050
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 28/06/2021 22:30, Borislav Petkov wrote:
> On Mon, Jun 28, 2021 at 06:34:31PM +0000, Dov Murik wrote:
>> The new sev_secret module exposes the confidential computing secret area
>> via securityfs interface.
>>
>> When the module is loaded (and securityfs is mounted, typically under
>> /sys/kernel/security), an "sev_secret" directory is created in
>> securityfs.  In it, a file is created for each secret entry.  The name
>> of each such file is the GUID of the secret entry, and its content is
>> the secret data.
>>
>> This allows applications running in a confidential computing setting to
>> read secrets provided by the guest owner via a secure secret injection
>> mechanism (such as AMD SEV's LAUNCH_SECRET command).
>>
>> Removing (unlinking) files in the "sev_secret" directory will zero out
>> the secret in memory, and remove the filesystem entry.  If the module
>> is removed and loaded again, that secret will not appear in the
>> filesystem.
>>
>> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
>> ---
>>  drivers/virt/Kconfig                 |   2 +
>>  drivers/virt/Makefile                |   1 +
>>  drivers/virt/sev_secret/Kconfig      |  11 +
>>  drivers/virt/sev_secret/Makefile     |   2 +
>>  drivers/virt/sev_secret/sev_secret.c | 298 +++++++++++++++++++++++++++
>>  5 files changed, 314 insertions(+)
>>  create mode 100644 drivers/virt/sev_secret/Kconfig
>>  create mode 100644 drivers/virt/sev_secret/Makefile
>>  create mode 100644 drivers/virt/sev_secret/sev_secret.c
> 
> Same question here: maybe have 
> 
> drivers/virt/coco/
> 
> and put all coco guest stuff in there.
> 

I agree, according to what comes up of the conversation we have in
replies to the cover letter.


>> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
>> index 8061e8ef449f..c222cc625891 100644
>> --- a/drivers/virt/Kconfig
>> +++ b/drivers/virt/Kconfig
>> @@ -36,4 +36,6 @@ source "drivers/virt/vboxguest/Kconfig"
>>  source "drivers/virt/nitro_enclaves/Kconfig"
>>  
>>  source "drivers/virt/acrn/Kconfig"
>> +
>> +source "drivers/virt/sev_secret/Kconfig"
>>  endif
>> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
>> index 3e272ea60cd9..0765e5418d1d 100644
>> --- a/drivers/virt/Makefile
>> +++ b/drivers/virt/Makefile
>> @@ -8,3 +8,4 @@ obj-y				+= vboxguest/
>>  
>>  obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>>  obj-$(CONFIG_ACRN_HSM)		+= acrn/
>> +obj-y				+= sev_secret/
>> diff --git a/drivers/virt/sev_secret/Kconfig b/drivers/virt/sev_secret/Kconfig
>> new file mode 100644
>> index 000000000000..4505526b8ef1
>> --- /dev/null
>> +++ b/drivers/virt/sev_secret/Kconfig
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config AMD_SEV_SECRET_SECURITYFS
>> +	tristate "AMD SEV secret area securityfs support"
>> +	depends on EFI
> 
> That probably needs to depend on CONFIG_AMD_MEM_ENCRYPT - otherwise
> what's the point for it.
> 

But not if it's a generic driver that is useful for other confidential
computing implementations.  Consider some non-encrypting guest memory
isolation mechanism where the host can't read most guest pages; this
module might be useful there too.

Also, isn't it a bit weird to depend on CONFIG_AMD_MEM_ENCRYPT but not
use any of its APIs?


-Dov
