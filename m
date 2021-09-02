Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90353FF311
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 20:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346939AbhIBSPx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 14:15:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346936AbhIBSPw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Sep 2021 14:15:52 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182I4CL5003960;
        Thu, 2 Sep 2021 14:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WDQr9prZoZvK59wo4XINd3RoiSuTOWHFB4TBVQYAJOY=;
 b=aVWrF5kZt3r/P+S+uC7LXvVAF38bHgornZGrnaqCZI5U5vRIw5Fz0yDAN6NnkXfAbQNv
 FS5R2JBvvafjjW0pz6ifNaNaxLWlc+FFhQzF5/CjQ0rJRGpmP+P6B0NpUqLqQmqKuiBk
 ZmxrkPz1Tn228THoY7yP4Nf9fQ/6UFwoW4UQs0msAQPe/nMbkKcv3P37HW9M6b/cMnXS
 hlZKo64GnXiFOCwJT1FNsLgSENFzApYr0gNiHZGFIkP0A1aHgvzXS6RJzzOg7Pt3TOjk
 IcC4tT6j1ZYiw/z/yrad2FY0mebxOgb75vOq/58zEkGCb0ThawEPCdlpa8al8jNb69Ib Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3au2mdcakp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 14:14:40 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 182I4wcj007749;
        Thu, 2 Sep 2021 14:14:40 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3au2mdcak8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 14:14:40 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 182ICxUS029580;
        Thu, 2 Sep 2021 18:14:39 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 3atdxehyxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 18:14:39 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 182IEaKR34799968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 18:14:37 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7C8BC607F;
        Thu,  2 Sep 2021 18:14:36 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 100F4C605A;
        Thu,  2 Sep 2021 18:14:31 +0000 (GMT)
Received: from [9.65.84.185] (unknown [9.65.84.185])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Sep 2021 18:14:31 +0000 (GMT)
Subject: Re: [PATCH 3/3] virt: Add sev_secret module to expose confidential
 computing secrets
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
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
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
 <20210809190157.279332-4-dovmurik@linux.ibm.com> <YTDKtr+W7wBTn/96@kroah.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <35be128e-52a4-b463-8ad7-8047810002f9@linux.ibm.com>
Date:   Thu, 2 Sep 2021 21:14:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTDKtr+W7wBTn/96@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EWRQJtOpxFqvh5K6RGLEe9ngnfz2w3Fq
X-Proofpoint-GUID: kvvKWqCSqtdLcqoV8X3iZ3jgXpZ0VGey
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020102
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 02/09/2021 15:59, Greg KH wrote:
> On Mon, Aug 09, 2021 at 07:01:57PM +0000, Dov Murik wrote:
>> The new sev_secret module exposes the confidential computing (coco)
>> secret area via securityfs interface.
>>
>> When the module is loaded (and securityfs is mounted, typically under
>> /sys/kernel/security), a "coco/sev_secret" directory is created in
>> securityfs.  In it, a file is created for each secret entry.  The name
>> of each such file is the GUID of the secret entry, and its content is
>> the secret data.
>>
>> This allows applications running in a confidential computing setting to
>> read secrets provided by the guest owner via a secure secret injection
>> mechanism (such as AMD SEV's LAUNCH_SECRET command).
>>
>> Removing (unlinking) files in the "coco/sev_secret" directory will zero
>> out the secret in memory, and remove the filesystem entry.  If the
>> module is removed and loaded again, that secret will not appear in the
>> filesystem.
>>
>> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
>> ---
>>  drivers/virt/Kconfig                      |   3 +
>>  drivers/virt/Makefile                     |   1 +
>>  drivers/virt/coco/sev_secret/Kconfig      |  11 +
>>  drivers/virt/coco/sev_secret/Makefile     |   2 +
>>  drivers/virt/coco/sev_secret/sev_secret.c | 313 ++++++++++++++++++++++
>>  5 files changed, 330 insertions(+)
>>  create mode 100644 drivers/virt/coco/sev_secret/Kconfig
>>  create mode 100644 drivers/virt/coco/sev_secret/Makefile
>>  create mode 100644 drivers/virt/coco/sev_secret/sev_secret.c
>>
>> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
>> index 8061e8ef449f..6f73672f593f 100644
>> --- a/drivers/virt/Kconfig
>> +++ b/drivers/virt/Kconfig
>> @@ -36,4 +36,7 @@ source "drivers/virt/vboxguest/Kconfig"
>>  source "drivers/virt/nitro_enclaves/Kconfig"
>>  
>>  source "drivers/virt/acrn/Kconfig"
>> +
>> +source "drivers/virt/coco/sev_secret/Kconfig"
>> +
>>  endif
>> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
>> index 3e272ea60cd9..2a7d472478bd 100644
>> --- a/drivers/virt/Makefile
>> +++ b/drivers/virt/Makefile
>> @@ -8,3 +8,4 @@ obj-y				+= vboxguest/
>>  
>>  obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>>  obj-$(CONFIG_ACRN_HSM)		+= acrn/
>> +obj-$(CONFIG_AMD_SEV_SECRET)	+= coco/sev_secret/
>> diff --git a/drivers/virt/coco/sev_secret/Kconfig b/drivers/virt/coco/sev_secret/Kconfig
>> new file mode 100644
>> index 000000000000..76cfb4f405e0
>> --- /dev/null
>> +++ b/drivers/virt/coco/sev_secret/Kconfig
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config AMD_SEV_SECRET
>> +	tristate "AMD SEV secret area securityfs support"
>> +	depends on AMD_MEM_ENCRYPT && EFI
>> +	select SECURITYFS
>> +	help
>> +	  This is a driver for accessing the AMD SEV secret area via
>> +	  securityfs.
>> +
>> +	  To compile this driver as a module, choose M here.
>> +	  The module will be called sev_secret.
>> diff --git a/drivers/virt/coco/sev_secret/Makefile b/drivers/virt/coco/sev_secret/Makefile
>> new file mode 100644
>> index 000000000000..dca0ed3f8f94
>> --- /dev/null
>> +++ b/drivers/virt/coco/sev_secret/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_AMD_SEV_SECRET) += sev_secret.o
>> diff --git a/drivers/virt/coco/sev_secret/sev_secret.c b/drivers/virt/coco/sev_secret/sev_secret.c
>> new file mode 100644
>> index 000000000000..d9a60166b142
>> --- /dev/null
>> +++ b/drivers/virt/coco/sev_secret/sev_secret.c
>> @@ -0,0 +1,313 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * sev_secret module
>> + *
>> + * Copyright (C) 2021 IBM Corporation
>> + * Author: Dov Murik <dovmurik@linux.ibm.com>
>> + */
>> +
>> +/**
>> + * DOC: sev_secret: Allow reading confidential computing (coco) secret area via
>> + * securityfs interface.
>> + *
>> + * When the module is loaded (and securityfs is mounted, typically under
>> + * /sys/kernel/security), a "coco/sev_secret" directory is created in
>> + * securityfs.  In it, a file is created for each secret entry.  The name of
>> + * each such file is the GUID of the secret entry, and its content is the
>> + * secret data.
>> + */
>> +
>> +#include <linux/seq_file.h>
>> +#include <linux/fs.h>
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/io.h>
>> +#include <linux/security.h>
>> +#include <linux/efi.h>
>> +
>> +#define SEV_SECRET_NUM_FILES 64
>> +
>> +#define EFI_SEVSECRET_TABLE_HEADER_GUID \
>> +	EFI_GUID(0x1e74f542, 0x71dd, 0x4d66, 0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
>> +
>> +struct sev_secret {
>> +	struct dentry *coco_dir;
>> +	struct dentry *fs_dir;
>> +	struct dentry *fs_files[SEV_SECRET_NUM_FILES];
>> +	struct linux_efi_coco_secret_area *secret_area;
>> +};
>> +
>> +/*
>> + * Structure of the SEV secret area
>> + *
>> + * Offset   Length
>> + * (bytes)  (bytes)  Usage
>> + * -------  -------  -----
>> + *       0       16  Secret table header GUID (must be 1e74f542-71dd-4d66-963e-ef4287ff173b)
>> + *      16        4  Length of bytes of the entire secret area
>> + *
>> + *      20       16  First secret entry's GUID
>> + *      36        4  First secret entry's length in bytes (= 16 + 4 + x)
>> + *      40        x  First secret entry's data
>> + *
>> + *    40+x       16  Second secret entry's GUID
>> + *    56+x        4  Second secret entry's length in bytes (= 16 + 4 + y)
>> + *    60+x        y  Second secret entry's data
>> + *
>> + * (... and so on for additional entries)
> 
> Why isn't all of this documented in Documentation/ABI/ which is needed
> for any new user/kernel api that you come up with like this.  We have to
> have it documented somewhere, otherwise how will you know how to use
> these files?

Yes, you're right, I'll add such documentation.

Note that the ABI (for userspace programs) is the filesystem paths and
usage (read + unlink), and not the GUIDed table explained above your
comment.  That GUIDed table is passed from the Guest Owner via SEV
secret injection into OVMF and from there to the kernel memory (patches
1+2 in this series).  So userspace doesn't see this GUIDed table
structure at all.

I should probably add this story to this file's header comment, or some
other place which will document this module (suggestions welcome).

-Dov
