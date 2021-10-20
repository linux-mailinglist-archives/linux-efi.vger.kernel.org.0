Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74157434663
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 10:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTIFK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 04:05:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229503AbhJTIFJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 04:05:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K6le2c031321;
        Wed, 20 Oct 2021 04:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=anGVICTQXw46Bmh+wUtOx9C9AOBjlyYSWCinbzMLne8=;
 b=ieeNIlzaL4/8wA2s5capFaTEpD3CxJMszCwTnvHi/eLj+GZFH+L6FyijizRENM7br+d0
 Co+AxEtiLOR/g02vvJyAXJ2Yi83kN+26sHF6uRXxfiPUo6F74qjSPG9wJyvIMxIX3p+G
 ejs6SROU9YDMCyiPzw5UqsFL9+CSE27bE632nuFiDWoeynMy8apK0qvLBuEZkIfkGKkT
 2Gd+X5eFqQcB/3GlJVN0dtexTFJMGO0NZwRscymuv8in2ceocYNWDl3tSO0ABQ5vEddQ
 VpbT8N20VB/7epaS0cqvZNcmM+w9eaG9Zj2mPXdH1uBFeGWVLjnzIyR+r+ZX3fYqzJ0l pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bte5jhfwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 04:02:42 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19K7gVRe003571;
        Wed, 20 Oct 2021 04:02:41 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bte5jhfw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 04:02:41 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19K7vGHR026100;
        Wed, 20 Oct 2021 08:02:40 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 3bqpcc1c70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 08:02:40 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19K82c9X43909480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 08:02:38 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51E336A04D;
        Wed, 20 Oct 2021 08:02:38 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E56696A04F;
        Wed, 20 Oct 2021 08:02:32 +0000 (GMT)
Received: from [9.160.85.241] (unknown [9.160.85.241])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 08:02:32 +0000 (GMT)
Message-ID: <1a5cd4ad-1476-24b1-4418-0f894982e142@linux.ibm.com>
Date:   Wed, 20 Oct 2021 11:02:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 1/3] efi/libstub: Copy confidential computing secret
 area
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
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
 <20211020061408.3447533-2-dovmurik@linux.ibm.com>
 <YW+5phDcxynJD2qy@kroah.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <YW+5phDcxynJD2qy@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Tczple_eWUhQCqhtgd1GEAlBbFEaYEsk
X-Proofpoint-GUID: -I_bmRiJRb_9arGo4YG6MPT5vwInVFwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200040
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 20/10/2021 9:39, Greg KH wrote:
> On Wed, Oct 20, 2021 at 06:14:06AM +0000, Dov Murik wrote:
>> Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
>> Virtualization) allows a guest owner to inject secrets into the VMs
>> memory without the host/hypervisor being able to read them.
>>
>> Firmware support for secret injection is available in OVMF, which
>> reserves a memory area for secret injection and includes a pointer to it
>> the in EFI config table entry LINUX_EFI_COCO_SECRET_TABLE_GUID.
>> However, OVMF doesn't force the guest OS to keep this memory area
>> reserved.
>>
>> If EFI exposes such a table entry, efi/libstub will copy this area to a
>> reserved memory for future use inside the kernel.
>>
>> A pointer to the new copy is kept in the EFI table under
>> LINUX_EFI_COCO_SECRET_AREA_GUID.
>>
>> The new functionality can be enabled with CONFIG_EFI_COCO_SECRET=y.
>>
>> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
>> ---
>>  drivers/firmware/efi/Kconfig            | 12 +++++
>>  drivers/firmware/efi/libstub/Makefile   |  1 +
>>  drivers/firmware/efi/libstub/coco.c     | 68 +++++++++++++++++++++++++
>>  drivers/firmware/efi/libstub/efi-stub.c |  2 +
>>  drivers/firmware/efi/libstub/efistub.h  |  6 +++
>>  drivers/firmware/efi/libstub/x86-stub.c |  2 +
>>  include/linux/efi.h                     |  6 +++
>>  7 files changed, 97 insertions(+)
>>  create mode 100644 drivers/firmware/efi/libstub/coco.c
>>
>> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
>> index 2c3dac5ecb36..68d1c5e6a7b5 100644
>> --- a/drivers/firmware/efi/Kconfig
>> +++ b/drivers/firmware/efi/Kconfig
>> @@ -284,3 +284,15 @@ config EFI_CUSTOM_SSDT_OVERLAYS
>>  
>>  	  See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
>>  	  information.
>> +
>> +config EFI_COCO_SECRET
>> +	bool "Copy and reserve EFI Confidential Computing secret area"
>> +	depends on EFI
>> +	default n
> 
> default is always "n", no need to list this.
> 

OK, I'll remove.


>> +	help
>> +	  Copy memory reserved by EFI for Confidential Computing (coco)
>> +	  injected secrets, if EFI exposes such a table entry.
> 
> Why would you want to "copy" secret memory?
> 
> This sounds really odd here, it sounds like you are opening up a
> security hole.  Are you sure this is the correct text that everyone on
> the "COCO" group agrees with?

I understand the security concern: we don't want several copies of the
secrets all around the guest's memory.

I'll try to see if I can just reserve the memory (instruct EFI to leave
it intact) at its current address instead of creating a copy.  I'm open
to suggestions/pointers.


linux-coco list is CC'd on this series; feedback is welcome.


> 
>> +
>> +	  If you say Y here, the EFI stub copy the EFI secret area (if
>> +	  available) and reserve it for use inside the kernel.  This will
>> +	  allow the virt/coo/efi_secret module to access the secrets.
> 
> What is "virt/coo/efi_secret"?
> 

Typo: that should be virt/coco/efi_secret (the module introduced in
patch 3).

-Dov

>> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>> index d0537573501e..fdada3fd5d9b 100644
>> --- a/drivers/firmware/efi/libstub/Makefile
>> +++ b/drivers/firmware/efi/libstub/Makefile
>> @@ -66,6 +66,7 @@ $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
>>  lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o \
>>  				   $(patsubst %.c,lib-%.o,$(efi-deps-y))
>>  
>> +lib-$(CONFIG_EFI_COCO_SECRET)	+= coco.o
>>  lib-$(CONFIG_ARM)		+= arm32-stub.o
>>  lib-$(CONFIG_ARM64)		+= arm64-stub.o
>>  lib-$(CONFIG_X86)		+= x86-stub.o
>> diff --git a/drivers/firmware/efi/libstub/coco.c b/drivers/firmware/efi/libstub/coco.c
>> new file mode 100644
>> index 000000000000..bf546b6a3f72
>> --- /dev/null
>> +++ b/drivers/firmware/efi/libstub/coco.c
>> @@ -0,0 +1,68 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Confidential computing (coco) secret area handling
>> + *
>> + * Copyright (C) 2021 IBM Corporation
>> + * Author: Dov Murik <dovmurik@linux.ibm.com>
>> + */
>> +
>> +#include <linux/efi.h>
>> +#include <linux/sizes.h>
>> +#include <asm/efi.h>
>> +
>> +#include "efistub.h"
>> +
>> +#define LINUX_EFI_COCO_SECRET_TABLE_GUID                                                           \
>> +	EFI_GUID(0xadf956ad, 0xe98c, 0x484c, 0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
>> +
>> +/**
>> + * struct efi_coco_secret_table - EFI config table that points to the
>> + * confidential computing secret area. The guid
>> + * LINUX_EFI_COCO_SECRET_TABLE_GUID holds this table.
>> + * @base:	Physical address of the EFI secret area
>> + * @size:	Size (in bytes) of the EFI secret area
>> + */
>> +struct efi_coco_secret_table {
>> +	u64 base;
>> +	u64 size;
> 
> __le64?  Or is this really in host endian format?
> 
>> +} __attribute((packed));
>> +
>> +/*
>> + * Create a copy of EFI's confidential computing secret area (if available) so
>> + * that the secrets are accessible in the kernel after ExitBootServices.
>> + */
>> +void efi_copy_coco_secret_area(void)
>> +{
>> +	efi_guid_t linux_secret_area_guid = LINUX_EFI_COCO_SECRET_AREA_GUID;
>> +	efi_status_t status;
>> +	struct efi_coco_secret_table *secret_table;
>> +	struct linux_efi_coco_secret_area *secret_area;
>> +
>> +	secret_table = get_efi_config_table(LINUX_EFI_COCO_SECRET_TABLE_GUID);
>> +	if (!secret_table)
>> +		return;
>> +
>> +	if (secret_table->size == 0 || secret_table->size >= SZ_4G)
>> +		return;
>> +
>> +	/* Allocate space for the secret area and copy it */
>> +	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
>> +			     sizeof(*secret_area) + secret_table->size, (void **)&secret_area);
>> +
>> +	if (status != EFI_SUCCESS) {
>> +		efi_err("Unable to allocate memory for confidential computing secret area copy\n");
>> +		return;
>> +	}
>> +
>> +	secret_area->size = secret_table->size;
>> +	memcpy(secret_area->area, (void *)(unsigned long)secret_table->base, secret_table->size);
> 
> Why the double cast?
> 
> And you can treat this value as a "raw" pointer directly?  No need to
> map it at all?  What could go wrong...
> 
>> +
>> +	status = efi_bs_call(install_configuration_table, &linux_secret_area_guid, secret_area);
>> +	if (status != EFI_SUCCESS)
>> +		goto err_free;
>> +
>> +	return;
>> +
>> +err_free:
>> +	efi_bs_call(free_pool, secret_area);
> 
> This memory is never freed when shutting down the system?
> 
> thanks,
> 
> greg k-h
> 
