Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB91426442
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 07:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhJHFy0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 01:54:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229511AbhJHFyZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Oct 2021 01:54:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1985a7Z3019933;
        Fri, 8 Oct 2021 01:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=TAcsxJRPpiYrjozIXbDvk1b9KKzBsjHcjGhZFne9UdE=;
 b=nGalOqodAJMVgyl38W4iBYbbw996ckrXElRSvF5e8qDHwy9KxLB1OjWoSogF4W/simSp
 P0gX5c+GBipFPxheJYmOR1cl4ChroTj6plLvxohPYj9Y0BY9VCrMFLV0soWXS482kV6/
 hQmn22qTq0AqSK2YDtoPFPahNt0ZutRwiEEQxVi0hxvrcjpC2LzZ7ym1hd0pXRdiQdOY
 0pWKbVK3lw2QDmZQkLS9o00oo58oNn4WrdxZQ8MVnaJxP1FgRJ4Cn9J7jhsDv+TRNgQE
 ctwT0DfUVQMv2A4tKrYh3GTk8BnRbCXAMhsHFbaVu+0DMGLNJx8jDdJyGxqKDfajEDEf TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bjffwrs9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 01:52:04 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1985aGnQ020869;
        Fri, 8 Oct 2021 01:52:04 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bjffwrs9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 01:52:04 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1985mBD6027979;
        Fri, 8 Oct 2021 05:52:03 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 3bef2ec3mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 05:52:03 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1985q1HV26280594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Oct 2021 05:52:01 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A360C606E;
        Fri,  8 Oct 2021 05:52:01 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1EBAC6055;
        Fri,  8 Oct 2021 05:51:56 +0000 (GMT)
Received: from [9.65.95.104] (unknown [9.65.95.104])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  8 Oct 2021 05:51:56 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] virt: Add sev_secret module to expose confidential
 computing secrets
To:     Dave Hansen <dave.hansen@intel.com>, linux-efi@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20211007061838.1381129-1-dovmurik@linux.ibm.com>
 <20211007061838.1381129-5-dovmurik@linux.ibm.com>
 <290c21a8-a68f-0826-2754-1480f79a081d@intel.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <020a4e8b-20b6-15a0-13d3-66b232c221e3@linux.ibm.com>
Date:   Fri, 8 Oct 2021 08:51:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <290c21a8-a68f-0826-2754-1480f79a081d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QqC5e_7nOqg_HnKAu6a9Y45SPN8k26xu
X-Proofpoint-GUID: RDaktTOK2A6KCR2x7gYcvjMBhzPdNWWI
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_05,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110080031
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Thanks Dave for reviewing this.

On 07/10/2021 16:48, Dave Hansen wrote:
> On 10/6/21 11:18 PM, Dov Murik wrote:
>> +static void wipe_memory(void *addr, size_t size)
>> +{
>> +	memzero_explicit(addr, size);
>> +	clean_cache_range(addr, size);
>> +}
> 
> What's the purpose of the clean_cache_range()?  It's backed in a CLWB
> instruction on x86 which seems like an odd choice.  I guess the point is
> that the memzero_explicit() will overwrite the contents, but might have
> dirty lines in the cache.  The CLWB will ensure that the lines are
> actually written back to memory, clearing the secret out of memory.
> Without the CLWB, the secret might live in memory until the dirtied
> cachelines are written back.

Yes, that's the reason; as suggested by Andrew Scull in [1].

[1] https://lore.kernel.org/linux-coco/CADcWuH0mP+e6GxkUGN3ni_Yu0z8YTn-mo677obH+p-OFCL+wOQ@mail.gmail.com/

> 
> Could you document this, please?  It would also be nice to include some
> of this motivation in the patch that exports clean_cache_range() in the
> first place.
> 

Yes, I'll add that.


> I also think clean_cache_range() an odd choice.  If it were me, I
> probably would have just used the already-exported
> clflush_cache_range().  The practical difference between writing back
> and flushing the cachelines is basically zero.  The lines will never be
> reused.
> 

I agree that performance benefits of CLWB over CLFLUSH are negligible here
(but I have no way of measuring it).  Andrew suggested [2] that the extra
invalidation that CLFLUSH does it unnecessary.

But if we all agree that the clflush_cache_range() is OK here, I'm OK
with removing patch 1 and calling clflush_cache_range() in wipe_memory()
here.

Does anyone know of other locations in the kernel where memory is needed
to be scrubbed (zeroed and flushed) - like my wipe_memory()? Maybe there's
a standard way of doing this?


[2] https://lore.kernel.org/linux-coco/CADcWuH05vbFtJ1WYSs3d+_=TGzh-MitvAXp1__d1kGJJkvkWpQ@mail.gmail.com/


> *If* we export anything from x86 code, I think it should be something
> which is specific to the task at hand, like arch_invalidate_pmem() is.
> 
> Also, when you are modifying x86 code, including exports, it would be
> nice to include (all of) the x86 maintainers.  The relevant ones for
> this series would probably be:
> 
> X86 ARCHITECTURE (32-BIT AND 64-BIT)
> M:      Thomas Gleixner <tglx@linutronix.de>
> M:      Ingo Molnar <mingo@redhat.com>
> M:      Borislav Petkov <bp@alien8.de>
> M:      x86@kernel.org
> 
> X86 MM
> M:      Dave Hansen <dave.hansen@linux.intel.com>
> M:      Andy Lutomirski <luto@kernel.org>
> M:      Peter Zijlstra <peterz@infradead.org>
> 
> There's also the handy dandy scripts/get_maintainer.pl to help.
> 

You're right, sorry for missing it in this round.

But even if I remove the x86 change, I'll keep you copied anyway...


-Dov
