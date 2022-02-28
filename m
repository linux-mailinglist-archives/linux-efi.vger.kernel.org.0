Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154234C6D66
	for <lists+linux-efi@lfdr.de>; Mon, 28 Feb 2022 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiB1NIC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Feb 2022 08:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiB1NHx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Feb 2022 08:07:53 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90065A090;
        Mon, 28 Feb 2022 05:07:14 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SBdOgJ003017;
        Mon, 28 Feb 2022 13:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pUPv7EHa00iSmyBhnBNdojt8nLdAFA7ObpMei0IW+6w=;
 b=kIP16Og8TjfthYJN9cdZOPe2+mQzxou3fppMuSJyRU6FOSda8isUInsMygfYAg+Npdf8
 SsMZa4GxCUB3D3aW4PWwf/tXQXHaI53SD03IoXskQz3joa6ClV/b40Q67XplqV3Lwbro
 uXtafjcz48OjcNem8MAvhWkvkbDWal+KhWPHnYGGf+PVH9wjN0tNju9MblTaqpZa8/jo
 zLvlyPl8s+qJcBUdTQvRVYRGusNBitlOLJ94MHaAYoKZ0VyaFxCSdwr7ENuRHBSBhgzq
 qFQIiF5vTae8m4e4IahNIy6XkSyr0E/8nj269GZkXKUfw61TBnf4/17Zt5vkd9sc3HEB Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3egwb72ee5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 13:06:56 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21SCqokx039349;
        Mon, 28 Feb 2022 13:06:56 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3egwb72ed9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 13:06:56 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21SCtTa8032044;
        Mon, 28 Feb 2022 13:06:54 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3egfsrqxa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 13:06:54 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21SD6pQj30999026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 13:06:51 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89E1078064;
        Mon, 28 Feb 2022 13:06:51 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E3787805F;
        Mon, 28 Feb 2022 13:06:47 +0000 (GMT)
Received: from [9.148.12.169] (unknown [9.148.12.169])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 28 Feb 2022 13:06:46 +0000 (GMT)
Message-ID: <f3de6cd9-9f58-7db3-e367-a6a5a5d826e2@linux.ibm.com>
Date:   Mon, 28 Feb 2022 15:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 3/4] efi: Load efi_secret module if EFI secret area is
 populated
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
 <20220228114254.1099945-4-dovmurik@linux.ibm.com>
 <CAMj1kXFybkGtxH2U6oAi_Qeqe-i_kH-hZjUZKY3-UzPHUg55vg@mail.gmail.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <CAMj1kXFybkGtxH2U6oAi_Qeqe-i_kH-hZjUZKY3-UzPHUg55vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AEiL-FJZDWwomwyYuqIQiSCaqx1MmsSn
X-Proofpoint-GUID: ZxEsY9ImkWyumnmICv8oVy7oOfJDb1LM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_05,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 28/02/2022 14:49, Ard Biesheuvel wrote:
> On Mon, 28 Feb 2022 at 12:43, Dov Murik <dovmurik@linux.ibm.com> wrote:
>>
>> If the efi_secret module is built, register a late_initcall in the EFI
>> driver which checks whether the EFI secret area is available and
>> populated, and then requests to load the efi_secret module.
>>
>> This will cause the <securityfs>/secrets/coco directory to appear in
>> guests into which secrets were injected; in other cases, the module is
>> not loaded.
>>
>> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> It would be better to simply expose a platform device and associated
> driver, instead of hooking into the module machinery directly.
> 
> We already do something similar for the EFI rtc and the efivars
> subsystem, using platform_device_register_simple()
> 

Thanks Ard, I'll look into this.

I hope the mechanism you suggest allows me to perform complex check to
see if the device is really there (in this case: check for an efi
variable, map memory as encrypted, verify it starts with a specific GUID
-- everything before request_module() in the code below).

-Dov


> 
>> ---
>>  drivers/firmware/efi/Makefile        |  1 +
>>  drivers/firmware/efi/coco.c          | 58 ++++++++++++++++++++
>>  drivers/virt/coco/efi_secret/Kconfig |  3 +
>>  3 files changed, 62 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
>> index c02ff25dd477..49c4a8c0bfc4 100644
>> --- a/drivers/firmware/efi/Makefile
>> +++ b/drivers/firmware/efi/Makefile
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_PROPERTIES)                += apple-properties.o
>>  obj-$(CONFIG_EFI_RCI2_TABLE)           += rci2-table.o
>>  obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)    += embedded-firmware.o
>>  obj-$(CONFIG_LOAD_UEFI_KEYS)           += mokvar-table.o
>> +obj-$(CONFIG_EFI_COCO_SECRET)          += coco.o
>>
>>  fake_map-y                             += fake_mem.o
>>  fake_map-$(CONFIG_X86)                 += x86_fake_mem.o
>> diff --git a/drivers/firmware/efi/coco.c b/drivers/firmware/efi/coco.c
>> new file mode 100644
>> index 000000000000..f8efd240ab05
>> --- /dev/null
>> +++ b/drivers/firmware/efi/coco.c
>> @@ -0,0 +1,58 @@
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
>> +#include <linux/io.h>
>> +#include <linux/kmod.h>
>> +
>> +#ifdef CONFIG_EFI_SECRET_MODULE
>> +
>> +/*
>> + * Load the efi_secret module if the EFI secret area is populated
>> + */
>> +static int __init load_efi_secret_module(void)
>> +{
>> +       struct linux_efi_coco_secret_area *area;
>> +       efi_guid_t *header_guid;
>> +       int ret = 0;
>> +
>> +       if (efi.coco_secret == EFI_INVALID_TABLE_ADDR)
>> +               return 0;
>> +
>> +       area = memremap(efi.coco_secret, sizeof(*area), MEMREMAP_WB);
>> +       if (!area) {
>> +               pr_err("Failed to map confidential computing secret area descriptor\n");
>> +               return -ENOMEM;
>> +       }
>> +       if (!area->base_pa || area->size < sizeof(*header_guid))
>> +               goto unmap_desc;
>> +
>> +       header_guid = (void __force *)ioremap_encrypted(area->base_pa, sizeof(*header_guid));
>> +       if (!header_guid) {
>> +               pr_err("Failed to map secret area\n");
>> +               ret = -ENOMEM;
>> +               goto unmap_desc;
>> +       }
>> +       if (efi_guidcmp(*header_guid, EFI_SECRET_TABLE_HEADER_GUID))
>> +               goto unmap_encrypted;
>> +
>> +       ret = request_module("efi_secret");
>> +
>> +unmap_encrypted:
>> +       iounmap((void __iomem *)header_guid);
>> +
>> +unmap_desc:
>> +       memunmap(area);
>> +       return ret;
>> +}
>> +late_initcall(load_efi_secret_module);
>> +
>> +#endif
>> diff --git a/drivers/virt/coco/efi_secret/Kconfig b/drivers/virt/coco/efi_secret/Kconfig
>> index 4404d198f3b2..dc8da2921e36 100644
>> --- a/drivers/virt/coco/efi_secret/Kconfig
>> +++ b/drivers/virt/coco/efi_secret/Kconfig
>> @@ -14,3 +14,6 @@ config EFI_SECRET
>>
>>           To compile this driver as a module, choose M here.
>>           The module will be called efi_secret.
>> +
>> +         The module is loaded automatically by the EFI driver if the EFI
>> +         secret area is populated.
>> --
>> 2.25.1
>>
