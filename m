Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4210F97529
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2019 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfHUIjm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Aug 2019 04:39:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbfHUIjm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Aug 2019 04:39:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7L8cOmk046875
        for <linux-efi@vger.kernel.org>; Wed, 21 Aug 2019 04:39:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh2hbrb3w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 21 Aug 2019 04:39:40 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 21 Aug 2019 09:29:35 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Aug 2019 09:29:31 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7L8TVPZ43385106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 08:29:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB57EA4040;
        Wed, 21 Aug 2019 08:29:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0E83A4051;
        Wed, 21 Aug 2019 08:29:29 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Aug 2019 08:29:29 +0000 (GMT)
Date:   Wed, 21 Aug 2019 11:29:28 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Chester Lin <clin@suse.com>, Juergen Gross <JGross@suse.com>,
        Joey Lee <JLee@suse.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>, Gary Lin <GLin@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the
 kernel base
References: <20190802053744.5519-1-clin@suse.com>
 <20190820115645.GP13294@shell.armlinux.org.uk>
 <CAKv+Gu_0wFw5Mjpdw7BEY7ewgetNgU=Ff1uvAsn0iHmJouyKqw@mail.gmail.com>
 <20190821061027.GA2828@linux-8mug>
 <CAKv+Gu8Yny8cVPck3rPwCPvJBvcZKMHti_9bkCTM4H4cZ_43fg@mail.gmail.com>
 <20190821071100.GA26713@rapoport-lnx>
 <CAKv+Gu99z3V1B68CU8qhNwwffqDxNBOM6t3Q8-V7qpbDkf-Cwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu99z3V1B68CU8qhNwwffqDxNBOM6t3Q8-V7qpbDkf-Cwg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19082108-0012-0000-0000-000003410850
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082108-0013-0000-0000-0000217B2ED0
Message-Id: <20190821082927.GC26713@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210093
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 21, 2019 at 10:29:37AM +0300, Ard Biesheuvel wrote:
> On Wed, 21 Aug 2019 at 10:11, Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Wed, Aug 21, 2019 at 09:35:16AM +0300, Ard Biesheuvel wrote:
> > > On Wed, 21 Aug 2019 at 09:11, Chester Lin <clin@suse.com> wrote:
> > > >
> > > > On Tue, Aug 20, 2019 at 03:28:25PM +0300, Ard Biesheuvel wrote:
> > > > > On Tue, 20 Aug 2019 at 14:56, Russell King - ARM Linux admin
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > >
> > > > > > On Fri, Aug 02, 2019 at 05:38:54AM +0000, Chester Lin wrote:
> > > > > > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > > > > > index f3ce34113f89..909b11ba48d8 100644
> > > > > > > --- a/arch/arm/mm/mmu.c
> > > > > > > +++ b/arch/arm/mm/mmu.c
> > > > > > > @@ -1184,6 +1184,9 @@ void __init adjust_lowmem_bounds(void)
> > > > > > >               phys_addr_t block_start = reg->base;
> > > > > > >               phys_addr_t block_end = reg->base + reg->size;
> > > > > > >
> > > > > > > +             if (memblock_is_nomap(reg))
> > > > > > > +                     continue;
> > > > > > > +
> > > > > > >               if (reg->base < vmalloc_limit) {
> > > > > > >                       if (block_end > lowmem_limit)
> > > > > > >                               /*
> > > > > >
> > > > > > I think this hunk is sane - if the memory is marked nomap, then it isn't
> > > > > > available for the kernel's use, so as far as calculating where the
> > > > > > lowmem/highmem boundary is, it effectively doesn't exist and should be
> > > > > > skipped.
> > > > > >
> > > > >
> > > > > I agree.
> > > > >
> > > > > Chester, could you explain what you need beyond this change (and my
> > > > > EFI stub change involving TEXT_OFFSET) to make things work on the
> > > > > RPi2?
> > > > >
> > > >
> > > > Hi Ard,
> > > >
> > > > In fact I am working with Guillaume to try booting zImage kernel and openSUSE
> > > > from grub2.04 + arm32-efistub so that's why we get this issue on RPi2, which is
> > > > one of the test machines we have. However we want a better solution for all
> > > > cases but not just RPi2 since we don't want to affect other platforms as well.
> > > >
> > >
> > > Thanks Chester, but that doesn't answer my question.
> > >
> > > Your fix is a single patch that changes various things that are only
> > > vaguely related. We have already identified that we need to take
> > > TEXT_OFFSET (minus some space used by the swapper page tables) into
> > > account into the EFI stub if we want to ensure compatibility with many
> > > different platforms, and as it turns out, this applies not only to
> > > RPi2 but to other platforms as well, most notably the ones that
> > > require a TEXT_OFFSET of 0x208000, since they also have reserved
> > > regions at the base of RAM.
> > >
> > > My question was what else we need beyond:
> > > - the EFI stub TEXT_OFFSET fix [0]
> > > - the change to disregard NOMAP memblocks in adjust_lowmem_bounds()
> > > - what else???
> >
> > I think the only missing part here is to ensure that non-reserved memory in
> > bank 0 starts from a PMD-aligned address. I believe this could be done if
> > EFI stub, but I'm not really familiar with it so this just a semi-educated
> > guess :)
> >
> 
> Given that it is the ARM arch code that imposes this requirement, how
> about adding something like this to adjust_lowmem_bounds():
> 
> if (memblock_start_of_DRAM() % PMD_SIZE)
>     memblock_mark_nomap(memblock_start_of_DRAM(),
>         PMD_SIZE - (memblock_start_of_DRAM() % PMD_SIZE));

memblock_start_of_DRAM() won't work here, as it returns the actual start of
the DRAM including NOMAP regions. Moreover, as we cannot mark a region
NOMAP inside for_each_memblock() this should be done beforehand.

I think something like this could work:

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 2f0f07e..f2b635b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1178,6 +1178,19 @@ void __init adjust_lowmem_bounds(void)
 	 */
 	vmalloc_limit = (u64)(uintptr_t)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
 
+	/*
+	 * The first usable region must be PMD aligned. Mark its start
+	 * as MEMBLOCK_NOMAP if it isn't
+	 */
+	for_each_memblock(memory, reg) {
+		if (!memblock_is_nomap(reg) && (reg->base % PMD_SIZE)) {
+			phys_addr_t size = PMD_SIZE - (reg->base % PMD_SIZE);
+
+			memblock_mark_nomap(reg->base, size);
+			break;
+		}
+	}
+
 	for_each_memblock(memory, reg) {
 		phys_addr_t block_start = reg->base;
 		phys_addr_t block_end = reg->base + reg->size;



 
> (and introduce the nomap check into the loop)

-- 
Sincerely yours,
Mike.

