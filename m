Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00FD3F33EA
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 20:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhHTShw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 14:37:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhHTShv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Aug 2021 14:37:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KIWaAw123077;
        Fri, 20 Aug 2021 14:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wuzUIU8KjfQ54EF54lX/CiPbBu8YyPftPw/seHB3IRI=;
 b=LEQbwOtASKCUrd2nNr8HLXglnqVmAtvI2pNybnG0lcKwF64aFnvU+roMgZ9LB/HGKEFX
 8O99oGEE51Hepuy+fM1wdnXxPJbVc45p2O95FUeir0BCgHNxagQo8kecFqSSINsEok6s
 qPVJoJ5S+Pji9UHxgu+/1mTvcXgk1s0H9HIox8F7ST1yL4vn4TysEZKulCF4W5bEV0UM
 x4iX/5Q4bSrNC4htwwgjrKuTa3Dy7r6vK+GMjgQOxhH9W0nFm0q1VQiecXkYFRTRdS+F
 U/Cmq6lAIaCXXRsoQFpl38yUywm4G57HPTPqHFxMHH2rdBpTsLP/dtUzj7uBkoJ+tekk rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahkacjv6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 14:36:57 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17KIXH52124317;
        Fri, 20 Aug 2021 14:36:57 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahkacjv5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 14:36:57 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17KIXUXt009972;
        Fri, 20 Aug 2021 18:36:55 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3ae5fg3hw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 18:36:54 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17KIarMd37290302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 18:36:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C94D0B2066;
        Fri, 20 Aug 2021 18:36:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EADA0B2065;
        Fri, 20 Aug 2021 18:36:48 +0000 (GMT)
Received: from [9.160.110.229] (unknown [9.160.110.229])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 20 Aug 2021 18:36:48 +0000 (GMT)
Subject: Re: [PATCH 3/3] virt: Add sev_secret module to expose confidential
 computing secrets
To:     Andrew Scull <ascull@google.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
 <20210809190157.279332-4-dovmurik@linux.ibm.com>
 <YRZuIIVIzMfgjtEl@google.com>
 <CAMj1kXFC-cizTw2Tv40uZHdLArKtdMNxdQXWoPWSL-8qexdkLQ@mail.gmail.com>
 <CADcWuH0mP+e6GxkUGN3ni_Yu0z8YTn-mo677obH+p-OFCL+wOQ@mail.gmail.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <b3c65f9d-5fd3-22c5-cd23-481774d92222@linux.ibm.com>
Date:   Fri, 20 Aug 2021 21:36:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADcWuH0mP+e6GxkUGN3ni_Yu0z8YTn-mo677obH+p-OFCL+wOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9kbPMz4xAuUJD4vBYofJZIqKJOViYTrP
X-Proofpoint-ORIG-GUID: b3ZcUyslaSKfRcKCznK32dCVOs4aM1z5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-20_06:2021-08-20,2021-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200103
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 19/08/2021 16:02, Andrew Scull wrote:
> On Mon, 16 Aug 2021 at 10:57, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Fri, 13 Aug 2021 at 15:05, Andrew Scull <ascull@google.com> wrote:
>>>
>>> On Mon, Aug 09, 2021 at 07:01:57PM +0000, Dov Murik wrote:

[...]

>>>
>>>> +static int sev_secret_unlink(struct inode *dir, struct dentry *dentry)
>>>> +{
>>>> +     struct sev_secret *s = sev_secret_get();
>>>> +     struct inode *inode = d_inode(dentry);
>>>> +     struct secret_entry *e = (struct secret_entry *)inode->i_private;
>>>> +     int i;
>>>> +
>>>> +     if (e) {
>>>> +             /* Zero out the secret data */
>>>> +             memzero_explicit(e->data, secret_entry_data_len(e));
>>>
>>> Would there be a benefit in flushing these zeros?
>>>
>>
>> Do you mean cache clean+invalidate? Better to be precise here.
> 
> At least a clean, to have the zeros written back to memory from the
> cache, in order to overwrite the secret.
> 

I agree, but not sure how to implement this:

I see there's an arch_wb_cache_pmem exported function which internally
(in arch/x86/lib/usercopy_64.c) calls clean_cache_range which seems to
do what we want (assume the secret can be longer than the cache line).

But arch_wb_cache_pmem is declared in include/linux/libnvdimm.h and
guarded with #ifdef CONFIG_ARCH_HAS_PMEM_API -- both seem not related to
what I'm trying to do.

I see there's an exported clflush_cache_range for x86 -- but that's a
clean+flush if I understand correctly.

Suggestions on how to approach? I can copy the clean_cache_range
implementation into the sev_secret module but hopefully there's a better
way to reuse.  Maybe export clean_cache_range in x86?

Since this is for SEV the solution can be x86-specific, but if there's a
generic way I guess it's better (I think all of sev_secret module
doesn't have x86-specific stuff).

-Dov


>>
>>>> +             e->guid = NULL_GUID;
>>>> +     }
>>>> +
>>>> +     inode->i_private = NULL;
>>>> +
>>>> +     for (i = 0; i < SEV_SECRET_NUM_FILES; i++)
>>>> +             if (s->fs_files[i] == dentry)
>>>> +                     s->fs_files[i] = NULL;
>>>> +
>>>> +     /*
>>>> +      * securityfs_remove tries to lock the directory's inode, but we reach
>>>> +      * the unlink callback when it's already locked
>>>> +      */
>>>> +     inode_unlock(dir);
>>>> +     securityfs_remove(dentry);
>>>> +     inode_lock(dir);
>>>> +
>>>> +     return 0;
>>>> +}
