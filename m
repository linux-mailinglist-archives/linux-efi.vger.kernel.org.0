Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564DB4A82D6
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 12:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiBCLEo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 06:04:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236576AbiBCLEn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Feb 2022 06:04:43 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213AiCOh013287;
        Thu, 3 Feb 2022 11:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BbPHxKoric5q4pnCkk+2NcaC2f0C46PrlPGRhayIQPg=;
 b=KoDbaFth/X6OZ5d1Od2Sn02UXI2/UzesyMFpSqv9p0lpmV+zpWmJgkgTeNhAlCkoG1fC
 4w513HClOPgv8JWawuq0Lo9LcS2eNaJ6B0KRII/o4zhMIG0jvV34w/q1u1o89HwtkCfY
 e4bSE1VIE7Asa+mD/82+1Gu13GtC/3J3nf8z+PVtGiwH1/Q61jH4QGwjTxGxlrHGVZvQ
 jB3VWBFGhoQBKUVcgMKkCAbAOYijN3W3LmO2+7H9l3ER9PuqHACy8PyU/KRJOrrmSkxs
 gw5qJ947D4SWl4sF80qhu8hD4ck8AT5zHPoFc1ZEMq8mg2khPSDSdftInS2uxI3w4yVC sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyvexmuvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 11:04:13 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2139qoGJ032495;
        Thu, 3 Feb 2022 11:04:13 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyvexmuvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 11:04:13 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 213B2i0L000440;
        Thu, 3 Feb 2022 11:04:12 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3dvw7c7nfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 11:04:12 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 213B456W32965110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 11:04:05 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 371EF28064;
        Thu,  3 Feb 2022 11:04:05 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05AB928060;
        Thu,  3 Feb 2022 11:03:59 +0000 (GMT)
Received: from [9.65.240.79] (unknown [9.65.240.79])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  3 Feb 2022 11:03:59 +0000 (GMT)
Message-ID: <815ba487-a6c1-0daa-aead-a7f3a52df2a1@linux.ibm.com>
Date:   Thu, 3 Feb 2022 13:03:58 +0200
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
 <cb548aa2-1ac3-46e7-91e4-f57a4fd63754@linux.ibm.com>
 <20220203061615.wwembqmmpmg77iyj@sirius.home.kraxel.org>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20220203061615.wwembqmmpmg77iyj@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: trqepfqvgRVlBjWR4INAX6e7ekuRrq62
X-Proofpoint-GUID: 4inEO94yDJbCDJmeSB782KtEUjr6ZfJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030070
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 03/02/2022 8:16, Gerd Hoffmann wrote:
>   Hi,
> 
>>> I think the module should fail noisily.  See above for autoload.  In
>>> case the module is loaded (either manually by the admin, or because
>>> efi.coco_secret != EFI_INVALID_TABLE_ADDR) and it can't actually load
>>> the secrets we want know why ...
>>
>> Note that the AmdSev build of OVMF always publishes
>> LINUX_EFI_COCO_SECRET_TABLE_GUID in the EFI table.  Even when
>> LAUNCH_SECRET was not executed.  In such cases the secret area will be
>> empty.
> 
> Hmm, ok.  Why?  I assume the secret area is filled by the host and ovmf
> doesn't even look at it?
> 

Exactly.  OVMF just reserves this area, and puts its address+size in the
EFI config table.  It doesn't care about its format and usage.

There are currently two "users" for the actual data in this memory area:

1. grub's efisecret module (which reads the disk passphrase from an
entry in the secret area)
2. linux's efi_secret module (which we're discussing here)



>> If we keep only the 'efi.coco_secret != EFI_INVALID_TABLE_ADDR' check,
>> we'll get errors from efi_secret for every VM launch that doesn't
>> undergo LAUNCH_SECRET.  I don't think that's good.
> 
> Well, if that is a common case the module could either print nothing or
> log KERN_INFO level instead of KERN_ERROR.
> 

What if the user doesn't inject a secret and doesn't include the
efi_secret module at all in the initrd?  request_module("efi_secret")
will fail.

I can ignore the error code of request_module("efi_secret") but that
feels bad.



>> If we *do* want to check that the area starts with
>> EFI_SECRET_TABLE_HEADER_GUID (like I think we should), we need all the
>> checks before that, like checking that the area is big enough, and that
>> all the memremap()s succeed -- before actually comparing the
>> header_guid.  The checks are basically prerequisites for calling
>> efi_guidcmp() safely.
> 
> It is still not fully clear to me why you want do that check twice.
> 

I want to load the module only if secrets were injected by the Guest
Owner.

Again, I'm open to ideas on how to de-duplicate these early checks, if
that's important.


-Dov
