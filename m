Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AADA4A7441
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 16:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbiBBPJa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 10:09:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231908AbiBBPJa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 10:09:30 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212DK5dS012616;
        Wed, 2 Feb 2022 15:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/L7LgOqBnUWKyovGdW9Yyvs7GhfLMvadBzkskdLQKG0=;
 b=kInV1hwU5kAwk6ywy95F+7svUiu2lATh8cw8EPJAX60kwK+1SOVxNCC6HTgjzYq4pgX7
 ILngONIfUeWt7FajEf5kpeOaSwv23onvwAQ1YCyRYqTg1X4YmUXFhjWanCTSQmB2RFL2
 hJo3GQCzDfX5s/3tw/+ZoMCel+cZ3aIsONil9EasG8P4C4LkOiA19V0ceCfv4TWYrhnT
 O/AwcMeWgmDQZsPhKRKA5zEXS1LvpZ3CsS4DCAbNaqUsnRMW13gkE1UpJoYAxhdJpi6r
 3hZhdjnnW8v0xvXM1TK9oiWh3MV4uD2zjbdw5OQwvASHa2lekVgO04TAXy587BNQphUX kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyr2ce17h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 15:09:15 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212DWSHw009862;
        Wed, 2 Feb 2022 15:09:14 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyr2ce16y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 15:09:14 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212F2nja021440;
        Wed, 2 Feb 2022 15:09:13 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3dvw7brrfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 15:09:13 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212F9Awu35848628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 15:09:11 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD67428065;
        Wed,  2 Feb 2022 15:09:10 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD93228059;
        Wed,  2 Feb 2022 15:09:04 +0000 (GMT)
Received: from [9.65.240.79] (unknown [9.65.240.79])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Feb 2022 15:09:04 +0000 (GMT)
Message-ID: <cb548aa2-1ac3-46e7-91e4-f57a4fd63754@linux.ibm.com>
Date:   Wed, 2 Feb 2022 17:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v7 4/5] efi: Load efi_secret module if EFI secret area is
 populated
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-5-dovmurik@linux.ibm.com>
 <20220202084723.ushasiekb3cxami4@sirius.home.kraxel.org>
 <c7604c39-d6ca-f3b9-b1d8-fd0362216717@linux.ibm.com>
 <20220202143128.jgadmr7tzetlobt7@sirius.home.kraxel.org>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20220202143128.jgadmr7tzetlobt7@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dzdajyehst2K1ofnbMtB5uQv7AKyejMc
X-Proofpoint-ORIG-GUID: -oktOVuqy-KseV4GOevec6u13hg_4yEt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_07,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020084
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 02/02/2022 16:31, Gerd Hoffmann wrote:
> On Wed, Feb 02, 2022 at 01:08:43PM +0200, Dov Murik wrote:
>>
>>
>> On 02/02/2022 10:47, Gerd Hoffmann wrote:
>>> On Tue, Feb 01, 2022 at 12:44:12PM +0000, Dov Murik wrote:
>>>> If the efi_secret module is built, register a late_initcall in the EFI
>>>> driver which checks whether the EFI secret area is available and
>>>> populated, and then requests to load the efi_secret module.
>>>
>>>> +	area = memremap(efi.coco_secret, sizeof(*area), MEMREMAP_WB);
>>>> +	if (!area) {
>>>> +		pr_err("Failed to map confidential computing secret area descriptor\n");
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +	if (!area->base_pa || area->size < sizeof(*header_guid))
>>>> +		goto unmap_desc;
>>>> +
>>>> +	header_guid = (void __force *)ioremap_encrypted(area->base_pa, sizeof(*header_guid));
>>>> +	if (!header_guid) {
>>>> +		pr_err("Failed to map secret area\n");
>>>> +		ret = -ENOMEM;
>>>> +		goto unmap_desc;
>>>> +	}
>>>> +	if (efi_guidcmp(*header_guid, EFI_SECRET_TABLE_HEADER_GUID))
>>>> +		goto unmap_encrypted;
>>>
>>> Why these sanity checks are here and not in the efi_secret module?
>>
>> The same checks indeed appear in the efi_secret module (see in patch 3:
>> efi_secret_map_area() and the beginning of efi_secret_securityfs_setup()).
>>
>> However, in the efi_secret module, the checks are noisy, because they
>> expect the secret area to be populated.  For example:
>>
>> +	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR) {
>> +		pr_err("Secret area address is not available\n");
>> +		return -EINVAL;
>> +	}
> 
> Note I explicitly excluded that check ;)
> 
> Checking whenever efi.coco_secret looks valid and only try load
> efi_secret if that is the case (and otherwise stay silent) makes
> perfect sense.  The other checks should be dropped IMHO.
> 
>> Another approach could be to just try to load the module anyway, and
>> the module will fail (silently? noisily?) if there's no designated
>> secret area or it's not populated.  I feel that will be harder to
>> understand what's going on.
> 
> I think the module should fail noisily.  See above for autoload.  In
> case the module is loaded (either manually by the admin, or because
> efi.coco_secret != EFI_INVALID_TABLE_ADDR) and it can't actually load
> the secrets we want know why ...
> 

Note that the AmdSev build of OVMF always publishes
LINUX_EFI_COCO_SECRET_TABLE_GUID in the EFI table.  Even when
LAUNCH_SECRET was not executed.  In such cases the secret area will be
empty.

If we keep only the 'efi.coco_secret != EFI_INVALID_TABLE_ADDR' check,
we'll get errors from efi_secret for every VM launch that doesn't
undergo LAUNCH_SECRET.  I don't think that's good.

If we *do* want to check that the area starts with
EFI_SECRET_TABLE_HEADER_GUID (like I think we should), we need all the
checks before that, like checking that the area is big enough, and that
all the memremap()s succeed -- before actually comparing the
header_guid.  The checks are basically prerequisites for calling
efi_guidcmp() safely.

-Dov

