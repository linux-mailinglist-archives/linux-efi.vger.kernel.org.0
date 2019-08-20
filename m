Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758FD958D8
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2019 09:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfHTHtm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Aug 2019 03:49:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728414AbfHTHtm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Aug 2019 03:49:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7K7mJa5059700
        for <linux-efi@vger.kernel.org>; Tue, 20 Aug 2019 03:49:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugb0svfav-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 20 Aug 2019 03:49:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 20 Aug 2019 08:49:38 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 08:49:34 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7K7nXsq39256114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 07:49:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4199442049;
        Tue, 20 Aug 2019 07:49:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 337E942041;
        Tue, 20 Aug 2019 07:49:32 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Aug 2019 07:49:32 +0000 (GMT)
Date:   Tue, 20 Aug 2019 10:49:30 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Chester Lin <clin@suse.com>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Gary Lin <GLin@suse.com>,
        Juergen Gross <JGross@suse.com>, Joey Lee <JLee@suse.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the
 kernel base
References: <20190802053744.5519-1-clin@suse.com>
 <CAKv+Gu-yaNYsLQOOcr8srW91-nt-w0e+RBqxXGOagiGGT69n1Q@mail.gmail.com>
 <CAKv+Gu8uwbY-JtjNbgoyY230X_M6xLchVM3OUg_oNWOJrF=iCg@mail.gmail.com>
 <20190815111543.GA4728@linux-8mug>
 <CAKv+Gu-5M-4=SbOzbqbLUYnfFw29vhfcrVD=N9j_APYpKjq2wQ@mail.gmail.com>
 <20190815133738.GA2483@rapoport-lnx>
 <20190819075621.GA20595@linux-8mug>
 <CAKv+Gu-sdhNbhfD24Fn93mj-h6=vGi82Ghjy7AzaRSqcpXCx-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-sdhNbhfD24Fn93mj-h6=vGi82Ghjy7AzaRSqcpXCx-g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19082007-0020-0000-0000-0000036199D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082007-0021-0000-0000-000021B6C918
Message-Id: <20190820074930.GC5989@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200083
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 19, 2019 at 05:56:51PM +0300, Ard Biesheuvel wrote:
> On Mon, 19 Aug 2019 at 11:01, Chester Lin <clin@suse.com> wrote:
> >
> > Hi Mike and Ard,
> >
> > On Thu, Aug 15, 2019 at 04:37:39PM +0300, Mike Rapoport wrote:
> > > On Thu, Aug 15, 2019 at 02:32:50PM +0300, Ard Biesheuvel wrote:
> > > > (adding Mike)
> > > >

...

> > > > > In this case the kernel failed to reserve cma, which should hit the issue of
> > > > > memblock_limit=0x1000 as I had mentioned in my patch description. The first
> > > > > block [0-0xfff] was scanned in adjust_lowmem_bounds(), but it did not align
> > > > > with PMD_SIZE so the cma reservation failed because the memblock.current_limit
> > > > > was extremely low. That's why I expand the first reservation from 1 PAGESIZE to
> > > > > 1 PMD_SIZE in my patch in order to avoid this issue. Please kindly let me know
> > > > > if any suggestion, thank you.
> > >
> > >
> > > > This looks like it is a separate issue. The memblock/cma code should
> > > > not choke on a reserved page of memory at 0x0.
> > > >
> > > > Perhaps Russell or Mike (cc'ed) have an idea how to address this?
> > >
> > > Presuming that the last memblock dump comes from the end of
> > > arm_memblock_init() with the this memory map
> > >
> > > memory[0x0] [0x0000000000000000-0x0000000000000fff], 0x0000000000001000 bytes flags: 0x4
> > > memory[0x1] [0x0000000000001000-0x0000000007ef5fff], 0x0000000007ef5000 bytes flags: 0x0
> > > memory[0x2] [0x0000000007ef6000-0x0000000007f09fff], 0x0000000000014000 bytes flags: 0x4
> > > memory[0x3] [0x0000000007f0a000-0x000000003cb3efff], 0x0000000034c35000 bytes flags: 0x0
> > >
> > > adjust_lowmem_bounds() will set the memblock_limit (and respectively global
> > > memblock.current_limit) to 0x1000 and any further memblock_alloc*() will
> > > happily fail.
> > >
> > > I believe that the assumption for memblock_limit calculations was that the
> > > first bank has several megs at least.
> > >
> > > I wonder if this hack would help:
> > >
> > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > index d9a0038..948e5b9 100644
> > > --- a/arch/arm/mm/mmu.c
> > > +++ b/arch/arm/mm/mmu.c
> > > @@ -1206,7 +1206,7 @@ void __init adjust_lowmem_bounds(void)
> > >                        * allocated when mapping the start of bank 0, which
> > >                        * occurs before any free memory is mapped.
> > >                        */
> > > -                     if (!memblock_limit) {
> > > +                     if (memblock_limit < PMD_SIZE) {
> > >                               if (!IS_ALIGNED(block_start, PMD_SIZE))
> > >                                       memblock_limit = block_start;
> > >                               else if (!IS_ALIGNED(block_end, PMD_SIZE))
> > >
> >
> > I applied this patch as well and it works well on rpi-2 model B.
> >
> 
> Thanks, Chester, that is good to know.
> 
> However, afaict, this only affects systems where physical memory
> starts at address 0x0, so I think we need a better fix.

This hack can be easily extended to handle systems with arbitrary start
address, but it's still a hack...

> I know Mike has been looking into the NOMAP stuff lately, and your
> original patch contains a hunk that makes this code (?) disregard
> nomap memblocks. That might be a better approach.

I was actually looking how to replace NOMAP with something else to make
memblock.memory consistent with actual physical memory banks. But this work
is stashed for now.

I'm not sure that skipping NOMAP regions would be good enough.
If I understand corrrectly, with Chester's original patch the reservation
of PMD aligned chunk of 32M for the kernel made the first conv-mem region
PMD aligned and then memblock_limit will be set to the end of this region.

Is there a reason for marking EFI_RESERVED_TYPE as NOMAP rather than simply
reserve them with memblock_reserve()?

-- 
Sincerely yours,
Mike.

