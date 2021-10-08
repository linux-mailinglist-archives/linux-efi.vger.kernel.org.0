Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDDA426425
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 07:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhJHFme (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 01:42:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229511AbhJHFme (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Oct 2021 01:42:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1985695B023033;
        Fri, 8 Oct 2021 01:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vjRMRlRq+QbD9v0aID6Njw31X51jShwlBAEpOOPtaYw=;
 b=iwpQyoF8wA3RC9BTv6TAda6S5HvIexbC5ijP8NfGDN2IBqJoObxQpR5ygaAMUReV/dwy
 Zy54DlN1VuV5f/XuWj75TGykrEx7oL66xvQCVgewk5xSjS1fRHj/IoDN24E0q6h/fezT
 CuATNHpXUchc/nwnes55Fm3PijvqEvj05eY9VVJauIb6jDBwTXaA/pg29KUXx7vwfQtF
 Ud893WmgsywQu5Rse6nStugeLShDDC1OnvoUNL/KIvXypVayDDHrMBcIUL1pReqUBPlH
 uIS88U2PTkoro3Dmcv0XwDayu75Wxkr+/KqdaXuy6jXgGFoHgO99P6OFAhHiVpT7GoJ9 Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bjdqktqds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 01:40:26 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1985X6Qq007521;
        Fri, 8 Oct 2021 01:40:25 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bjdqktqdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 01:40:25 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1985ak9p030097;
        Fri, 8 Oct 2021 05:40:24 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 3bef2ebs27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 05:40:24 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1985eK4k29426072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Oct 2021 05:40:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5664C6065;
        Fri,  8 Oct 2021 05:40:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DF93C605D;
        Fri,  8 Oct 2021 05:40:16 +0000 (GMT)
Received: from [9.65.95.104] (unknown [9.65.95.104])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  8 Oct 2021 05:40:15 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] virt: Add sev_secret module to expose confidential
 computing secrets
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
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
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20211007061838.1381129-1-dovmurik@linux.ibm.com>
 <20211007061838.1381129-5-dovmurik@linux.ibm.com>
 <7e2a4595-3f9c-6d65-34e3-af7c1d6da196@intel.com> <YV8dsl+qgbIH6z8F@work-vm>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <fc31d2a9-ee56-f114-857e-310c4f4d7d4f@linux.ibm.com>
Date:   Fri, 8 Oct 2021 08:40:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YV8dsl+qgbIH6z8F@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6tHLsQAncmQL0tmlDgxxxj9r6LHQlPwb
X-Proofpoint-ORIG-GUID: CJ3FntA6G0k0HhAnOrDK5ko-QqVBgMYN
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_05,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 mlxscore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080031
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Thanks Dave and Dave for reviewing this.

On 07/10/2021 19:17, Dr. David Alan Gilbert wrote:
> * Dave Hansen (dave.hansen@intel.com) wrote:
>> On 10/6/21 11:18 PM, Dov Murik wrote:
>>> +static int sev_secret_map_area(void)
>>> +{
>>> +	struct sev_secret *s = sev_secret_get();
>>> +	struct linux_efi_coco_secret_area *secret_area;
>>> +	u32 secret_area_size;
>>> +
>>> +	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR) {
>>> +		pr_err("Secret area address is not available\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	secret_area = memremap(efi.coco_secret, sizeof(*secret_area), MEMREMAP_WB);
>>> +	if (secret_area == NULL) {
>>> +		pr_err("Could not map secret area header\n");
>>> +		return -ENOMEM;
>>> +	}
>>
>> There doesn't seem to be anything truly SEV-specific in here at all.
>> Isn't this more accurately called "efi_secret" or something?  What's to
>> prevent Intel or an ARM vendor from implementing this?
> 
> I don't think anything; although the last discussion I remember on list
> with Intel was that Intel preferred some interface with an ioctl to read
> the secrets and stuff.  I'm not quite sure if the attestation/secret
> delivery order makes sense with TDX, but if it does, then if you could
> persuade someone to standardise on this it would be great.
> 

I agree that this series doesn't have any SEV-specific stuff in it; in
fact, I wrote in the cover letter:

+++
This has been tested with AMD SEV and SEV-ES guests, but the kernel side
of handling the secret area has no SEV-specific dependencies, and
therefore might be usable (perhaps with minor changes) for any
confidential computing hardware that can publish the secret area via the
standard EFI config table entry.
+++

However, in previous rounds Boris said [1] that if it's only
hypothetical support for other platforms, I should add a
"depends on AMD_MEM_ENCRYPT" clause.  Boris, can you please share your view?

I'm indeed in favor of making this more generic (efi_secret sounds
good), allowing for future support for other early-boot secret injection
mechanisms.


[1] https://lore.kernel.org/linux-coco/YNojYBIwk0xCHQ0v@zn.tnic/


-Dov
