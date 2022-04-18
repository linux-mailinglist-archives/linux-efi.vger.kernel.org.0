Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BEE505C1E
	for <lists+linux-efi@lfdr.de>; Mon, 18 Apr 2022 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiDRP7s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Apr 2022 11:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbiDRP7Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Apr 2022 11:59:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121FDF1B
        for <linux-efi@vger.kernel.org>; Mon, 18 Apr 2022 08:54:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o2so24742396lfu.13
        for <linux-efi@vger.kernel.org>; Mon, 18 Apr 2022 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=muYZw33hwSyG5ibVTGDvutUbYkYp8VVI0agZbsao0GQ=;
        b=ZUD8bIAuwFX0uDQkXwdfxBDO5xGtKspZjQm1+K6KPfJvlgGfThbVpuq4ptwKx70zFC
         er6LmktkWg8j/tiGOGeYGMnfS3L9McuEHJdOSj7Ni/LPYYLinXUYrOvSC4vagB/w6xiC
         KwEfmFvMB7e5Nw+3cTSKxkjvto5iaPcfgW/lGtqxobRlA0pi+gQqL+nOLabdR2BjuY2N
         rTonQad6QmVuRf6hiMwkKp6APv+pT0dGq4+eL7OpflUEZRPcmFHz4oLjEgt7HX7POkHs
         EmRnEg3fVs/J0SzIIU2rz+fRy4A2T33DZkS/JE9AYmcxfEvm67lU4xq6sBpKtQdL+QXR
         dpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=muYZw33hwSyG5ibVTGDvutUbYkYp8VVI0agZbsao0GQ=;
        b=zR6UfMq/GudApfWN9q1omg31NvVLJZEdTSBUXyLaK00AYAIdvitKYnorOxtp8Q01uU
         uz30vvF3myUWLFZ1IOR4O4/aLxO9bGC3RIkVz2vkxGv6LQryPO0gvyEbqiQPtws/QlOw
         YRYKSYPY4tJjI68ZEIPixEmenM1Nl98BJZTSYVmJCs23pOA02iOcISAd7BujYA6ceVY6
         zPZ3kiXBZKix55Ose39YbCHJade4+IRmoDuj1qte8+u1Tjb3a/3J+vcTqUBZNMh4Lzrl
         ZOepmyckJx71H7NK6poJ16rkrZRioRsmOpMN1HCtaSyzM6+2RP0N/0mFQokFIZ373Vc5
         XH3A==
X-Gm-Message-State: AOAM533FFtGfsOv9kF3eVDDX3IS2932IDKWUcsOSzlDAQ6nQFUAwgGEe
        8i5z01VjGgs/aHeNUKVt44kYRg==
X-Google-Smtp-Source: ABdhPJwZ/jVosT/a9D2Ro5q2t3tBFRd55s7uIBzB7DTojjbaukvUm04gwiUU9s1IkvjceizKbDSUvw==
X-Received: by 2002:a05:6512:3da8:b0:44a:73a4:3371 with SMTP id k40-20020a0565123da800b0044a73a43371mr8822829lfv.72.1650297250238;
        Mon, 18 Apr 2022 08:54:10 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t4-20020a2e7804000000b0024db2efb994sm740202ljc.39.2022.04.18.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 08:54:09 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0C014103A61; Mon, 18 Apr 2022 18:55:45 +0300 (+03)
Date:   Mon, 18 Apr 2022 18:55:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 3/8] efi/x86: Implement support for unaccepted memory
Message-ID: <20220418155545.a567xnxa6elglapl@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
 <Ylnwmvygp796+qcA@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylnwmvygp796+qcA@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Apr 16, 2022 at 12:24:26AM +0200, Borislav Petkov wrote:
> On Wed, Apr 06, 2022 at 02:43:38AM +0300, Kirill A. Shutemov wrote:
> > diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
> > index f088f5881666..8e3447a4b373 100644
> > --- a/Documentation/x86/zero-page.rst
> > +++ b/Documentation/x86/zero-page.rst
> > @@ -42,4 +42,5 @@ Offset/Size	Proto	Name		Meaning
> >  2D0/A00		ALL	e820_table		E820 memory map table
> >  						(array of struct e820_entry)
> >  D00/1EC		ALL	eddbuf			EDD data (array of struct edd_info)
> > +ECC/008		ALL	unaccepted_memory	Bitmap of unaccepted memory (1bit == 2M)
> 
> There's a perfectly fine spot at 0x78:
> 
> 	__u8  _pad3[8];                                 /* 0x078 */
> 
> why not take that one?

Good point. Will do.

> 
> >  ===========	=====	=======================	=================================================
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 8fd0e6ae2e1f..09993797efa2 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -102,6 +102,7 @@ endif
> >  
> >  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
> >  vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
> > +vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/unaccepted_memory.o
> >  
> >  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
> >  efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
> > diff --git a/arch/x86/boot/compressed/bitmap.c b/arch/x86/boot/compressed/bitmap.c
> > new file mode 100644
> > index 000000000000..bf58b259380a
> > --- /dev/null
> > +++ b/arch/x86/boot/compressed/bitmap.c
> > @@ -0,0 +1,24 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Taken from lib/string.c */
> > +
> > +#include <linux/bitmap.h>
> 
> verify_include_paths: Warning: Kernel-proper include at arch/x86/boot/compressed/bitmap.c:4 [+#include <linux/bitmap.h>]
> 
> Same game as before: put the stuff you need into a separate or a shared
> header and avoid the linux/ namespace include.

I'm confused here. What is wrong with linux/ include namespace?

Yes, we had story with <asm/io.h> that actually caused issue in
decompression code, but linux/ has a lot of perfectly portable
library-like stuff.

Could you explain what rules are?

> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include "error.h"
> > +#include "misc.h"
> > +
> > +static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +	/* Platform-specific memory-acceptance call goes here */
> > +	error("Cannot accept memory");
> > +}
> > +
> > +void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
> 
> That name is kinda misleading? It is not only marking as unaccepted - it
> is also accepting weird 2M misaligned chunks...

Hm. accept_or_mark_unaccepted()?

> > +{
> > +	/*
> > +	 * The accepted memory bitmap only works at PMD_SIZE granularity.
> > +	 * If a request comes in to mark memory as unaccepted which is not
> > +	 * PMD_SIZE-aligned, simply accept the memory now since it can not be
> > +	 * *marked* as unaccepted.
> > +	 */
> 
> That comment goes over the function name.
> 
> > +	/*
> > +	 * Accept small regions that might not be able to be represented
> > +	 * in the bitmap:
> > +	 */
> > +	if (end - start < 2 * PMD_SIZE) {
> > +		__accept_memory(start, end);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * No matter how the start and end are aligned, at least one unaccepted
> > +	 * PMD_SIZE area will remain.
> > +	 */
> > +
> > +	/* Immediately accept a <PMD_SIZE piece at the start: */
> 
> Immediately? As opposed to delayed?

Yes. Otherwise accept is delayed until the first allocation of the memory.

> > +	if (start & ~PMD_MASK) {
> > +		__accept_memory(start, round_up(start, PMD_SIZE));
> > +		start = round_up(start, PMD_SIZE);
> > +	}
> > +
> > +	/* Immediately accept a <PMD_SIZE piece at the end: */
> > +	if (end & ~PMD_MASK) {
> > +		__accept_memory(round_down(end, PMD_SIZE), end);
> > +		end = round_down(end, PMD_SIZE);
> > +	}
> > +
> > +	/*
> > +	 * 'start' and 'end' are now both PMD-aligned.
> > +	 * Record the range as being unaccepted:
> > +	 */
> > +	bitmap_set((unsigned long *)params->unaccepted_memory,
> > +		   start / PMD_SIZE, (end - start) / PMD_SIZE);
> > +}
> > diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
> 
> Why do you need a separate header?
> 
> We already have
> 
> arch/x86/include/asm/mem_encrypt.h
> 
> and this is kinda very much related...

I don't see it.

Memory encryption can be a reason to have unaccepted memory, but it is not
1:1 match. Unaccepted memory can be present without memory ecnryption if
data secruty and integrity guaranteed by other means.

<asm/mem_encrypt.h> is very AMD SME/SEV centric. I'm not sure it need to
exist in the way it is now.

> > +	u64 max_addr = 0;
> > +	int i;
> >  
> >  	status = efi_get_memory_map(map);
> >  	if (status != EFI_SUCCESS)
> > @@ -589,9 +601,57 @@ static efi_status_t allocate_e820(struct boot_params *params,
> >  		if (status != EFI_SUCCESS)
> >  			goto out;
> >  	}
> 
> This whole chunk you're adding here begs to be a separate function with
> the big fat comment placed over the function name.
> 
> Might just as well call it after allocate_e820() has been called.

Okay, I will move it into a separate function, but it has to be called
from allocate_e820() because it allocates and free the map.

> > +
> > +	if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> > +		goto out;
> > +
> > +	/* Check if there's any unaccepted memory and find the max address */
> > +	for (i = 0; i < nr_desc; i++) {
> > +		efi_memory_desc_t *d;
> > +
> > +		d = efi_early_memdesc_ptr(*map->map, *map->desc_size, i);
> > +		if (d->type == EFI_UNACCEPTED_MEMORY)
> > +			unaccepted_memory_present = true;
> > +		if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
> > +			max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
> > +	}
> > +
> > +	/*
> > +	 * If unaccepted memory is present allocate a bitmap to track what
> > +	 * memory has to be accepted before access.
> > +	 *
> > +	 * One bit in the bitmap represents 2MiB in the address space:
> > +	 * A 4k bitmap can track 64GiB of physical address space.
> > +	 *
> > +	 * In the worst case scenario -- a huge hole in the middle of the
> > +	 * address space -- It needs 256MiB to handle 4PiB of the address
> > +	 * space.
> 
> And you're saying that that efi_allocate_pages() below can really give a
> 256M contiguous chunk?

Yes, that's assumption. Is it too high ask to deal with 4PiB of PA?

-- 
 Kirill A. Shutemov
