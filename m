Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4156B4346B5
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 10:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhJTIWQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 04:22:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229544AbhJTIWQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 04:22:16 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K6lexe031316;
        Wed, 20 Oct 2021 04:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HVktBuFd6LmgPJY8KabqdBhgKyd1NA1KX8ewkk0v6yY=;
 b=m776LmI1MfhT1dzYlhcDcSEjIhiWDy8jgLvWs5TqO+zwuAswMz7uQiCbeOt5NwD8gbC+
 njVI2RlTlxQpgGqDmaB4ZJpCzryrKUswlC6EHttm4ayUeWtFwmS3KvYAirtP3wvqR66I
 bP09Nm4m8sR63v+3Djfex9Gjac/XwcwHElOOi58wks9zzP5r+uJXBL0oIQbCG1mJOxdu
 FgXp+mwLa6m87ZoTsJbLRIgccYu4YV/3EZ4+oVkkoTzodt5TJcQBZHfuKp0bXp2c/LjY
 R5OkD1lkf5Kfggn8ywgACK5QAsWf1XL+YTSzT5rxmoQupz7X4dGNQcPlFgKcsnFmFvU3 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bte5jhukg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 04:19:51 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19K707Mx012605;
        Wed, 20 Oct 2021 04:19:51 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bte5jhuk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 04:19:51 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19K8HSE0030041;
        Wed, 20 Oct 2021 08:19:50 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3bqpcbsnse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 08:19:50 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19K8JmZQ31392080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 08:19:48 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 360256A04F;
        Wed, 20 Oct 2021 08:19:48 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 604C26A05A;
        Wed, 20 Oct 2021 08:19:43 +0000 (GMT)
Received: from [9.160.85.241] (unknown [9.160.85.241])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 08:19:43 +0000 (GMT)
Message-ID: <1d79190a-f023-a83c-b197-62b0514dc769@linux.ibm.com>
Date:   Wed, 20 Oct 2021 11:19:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 2/3] efi: Reserve confidential computing secret area
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
 <20211020061408.3447533-3-dovmurik@linux.ibm.com>
 <YW+55YcXqUtrw4/T@kroah.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <YW+55YcXqUtrw4/T@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HwgP4MJydJ3Xt9bMi3XEOAMRK3R-OR0v
X-Proofpoint-GUID: 9Ocsk-Xs2XQvPnWn5epiZJjlFvWVL8d8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200045
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 20/10/2021 9:40, Greg KH wrote:
> On Wed, Oct 20, 2021 at 06:14:07AM +0000, Dov Murik wrote:
>> When efi-stub copies an EFI-provided confidential computing (coco)
>> secret area, reserve that memory block for future use within the kernel.
>>
>> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
>> ---
>>  arch/x86/platform/efi/efi.c   |  3 +++
>>  drivers/firmware/efi/Makefile |  1 +
>>  drivers/firmware/efi/coco.c   | 41 +++++++++++++++++++++++++++++++++++
>>  drivers/firmware/efi/efi.c    |  8 +++++++
>>  include/linux/efi.h           | 10 +++++++++
>>  5 files changed, 63 insertions(+)
>>  create mode 100644 drivers/firmware/efi/coco.c
>>
>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>> index 147c30a81f15..1591d67e0bcd 100644
>> --- a/arch/x86/platform/efi/efi.c
>> +++ b/arch/x86/platform/efi/efi.c
>> @@ -93,6 +93,9 @@ static const unsigned long * const efi_tables[] = {
>>  #ifdef CONFIG_LOAD_UEFI_KEYS
>>  	&efi.mokvar_table,
>>  #endif
>> +#ifdef CONFIG_EFI_COCO_SECRET
>> +	&efi.coco_secret,
>> +#endif
>>  };
>>  
>>  u64 efi_setup;		/* efi setup_data physical address */
>> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
>> index c02ff25dd477..49c4a8c0bfc4 100644
>> --- a/drivers/firmware/efi/Makefile
>> +++ b/drivers/firmware/efi/Makefile
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
>>  obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
>>  obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
>>  obj-$(CONFIG_LOAD_UEFI_KEYS)		+= mokvar-table.o
>> +obj-$(CONFIG_EFI_COCO_SECRET)		+= coco.o
>>  
>>  fake_map-y				+= fake_mem.o
>>  fake_map-$(CONFIG_X86)			+= x86_fake_mem.o
>> diff --git a/drivers/firmware/efi/coco.c b/drivers/firmware/efi/coco.c
>> new file mode 100644
>> index 000000000000..42f477d6188c
>> --- /dev/null
>> +++ b/drivers/firmware/efi/coco.c
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Confidential computing (coco) secret area handling
>> + *
>> + * Copyright (C) 2021 IBM Corporation
>> + * Author: Dov Murik <dovmurik@linux.ibm.com>
>> + */
>> +
>> +#define pr_fmt(fmt) "efi: " fmt
>> +
>> +#include <linux/efi.h>
>> +#include <linux/init.h>
>> +#include <linux/memblock.h>
>> +#include <asm/early_ioremap.h>
>> +
>> +/*
>> + * Reserve the confidential computing secret area memory
>> + */
>> +int __init efi_coco_secret_area_reserve(void)
>> +{
>> +	struct linux_efi_coco_secret_area *secret_area;
>> +	unsigned long secret_area_size;
>> +
>> +	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR)
>> +		return 0;
>> +
>> +	secret_area = early_memremap(efi.coco_secret, sizeof(*secret_area));
>> +	if (!secret_area) {
>> +		pr_err("Failed to map confidential computing secret area\n");
>> +		efi.coco_secret = EFI_INVALID_TABLE_ADDR;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	secret_area_size = sizeof(*secret_area) + secret_area->size;
>> +	memblock_reserve(efi.coco_secret, secret_area_size);
>> +
>> +	pr_info("Reserved memory of EFI-provided confidential computing secret area");
> 
> When kernel code works properly, it is quiet.  Why do you need to print
> this out at every boot?
> 

My kernel is not so quiet at the info loglevel; specifically from efi I 
see these prints (third log line added by this patch):

[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi: SMBIOS=0x7f541000 ACPI=0x7f77e000 ACPI 2.0=0x7f77e014 MEMATTR=0x7ea0c018 CocoSecret=0x7ea0b018
[    0.000000] efi: Reserved memory of EFI-provided confidential computing secret area

This print is useful to understand that both OVMF (EFI) and kernel support
the confidential computing secret area.



>> +
>> +	early_memunmap(secret_area, sizeof(*secret_area));
>> +	return 0;
>> +}
> 
> And again, when is this memory freed when shutting down?
> 

It is currently not freed.  I tried to look for such memory freeing of
other EFI-provided memory areas (such as efi.tpm_final_log) and couldn't
find them.  Can you please share pointers/examples of how to do that?

Thanks,
-Dov
