Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AAB48CBFE
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 20:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbiALTbI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 14:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbiALT3h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jan 2022 14:29:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67249C061751
        for <linux-efi@vger.kernel.org>; Wed, 12 Jan 2022 11:29:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u13so11635663lff.12
        for <linux-efi@vger.kernel.org>; Wed, 12 Jan 2022 11:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hsIYvPFsQpFlvnu+4QvX7hPubnwS5nh6fnjUwOjpcw4=;
        b=W9nZI7OOzFut0ywxhhcABMfJKkyquB1m3dTmKINFu3ueD7bAzW4z5a83Pcpls1SFN1
         m3b+WpSYv5SfdlyxKty+oPMy1O5igtGRhpIMYkrcm0PEs2a/jZT9ZUFtj469XXeO4tye
         cEvlIOERhl4+rFqZlCFbWT27dBDKraoRGMr6T5ZncsS+gCf0kX3rDvv8R9pCf+6B/bb8
         K1JqW84x4QYKr+A4LYaj1YRaucBpTF148u0Lff3Fsjzpu/Snk5RrOfBV25gDswIaPfd5
         0H4EH0vebLGoOhZ1fdumRGFCrwbjtwMFdZnZXo1tfcX4TC3CpYijiVifSs63KH2HLnit
         5Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hsIYvPFsQpFlvnu+4QvX7hPubnwS5nh6fnjUwOjpcw4=;
        b=U4invVqGreYegFjB881YtCaq9YRPF0CGwcdnU8d/drE/Kun/TapnEaiUKePUC1qi3i
         Y2XDiX9uggMSSch5OhHfsf1ist/KPFAOlgE6Rl9yomP1K19gMgFeBK60HYRiUSonQ9Fy
         +D5FgMuesWAyq3/tXNTj49JrRV+RFLk5Tpj79Slk4QjOr3iklZOJmDLC8jhaEUKCVzEY
         boFFSvstqEBT1o8hMs6kc8ts+g7Tor93BZueqwCz3i+ixVZDfMhUvHUCv39RavvET5Fm
         DDP0dw86LFp+k63wDUi1USkYBaQO04xvQnD51SGR7aDnsXF4ZZ0hsefCXZwavsHCsqB9
         PxJg==
X-Gm-Message-State: AOAM532rEE7nvJb6sq9Q4U7qmvH4GQih4bfoZvlwWoBzlCyMKOprfNdU
        SNjOeRmDbEoefy0tgGjvwh4mnw==
X-Google-Smtp-Source: ABdhPJwfteyA3AxwkXuikDGECkDTTZNKK9LbcePDkVLp26AbPKfei0LSJ9JM3HlNHHeCMcQnGlCG0A==
X-Received: by 2002:a05:651c:982:: with SMTP id b2mr666698ljq.55.1642015773947;
        Wed, 12 Jan 2022 11:29:33 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p9sm72383lfu.83.2022.01.12.11.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:29:32 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1B9F2103A6D; Wed, 12 Jan 2022 22:29:55 +0300 (+03)
Date:   Wed, 12 Jan 2022 22:29:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/7] efi/x86: Implement support for unaccepted memory
Message-ID: <20220112192955.amelr4sq662pfv67@box.shutemov.name>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
 <20220111113314.27173-4-kirill.shutemov@linux.intel.com>
 <b3348430-1b91-4b8b-b70c-76d48f8737f7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3348430-1b91-4b8b-b70c-76d48f8737f7@intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 11, 2022 at 09:17:19AM -0800, Dave Hansen wrote:
> On 1/11/22 03:33, Kirill A. Shutemov wrote:
> ...
> > +void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
> > +{
> > +	/*
> > +	 * The accepted memory bitmap only works at PMD_SIZE granularity.
> > +	 * If a request comes in to mark memory as unaccepted which is not
> > +	 * PMD_SIZE-aligned, simply accept the memory now since it can not be
> > +	 * *marked* as unaccepted.
> > +	 */
> > +
> > +	/* Immediately accept whole range if it is within a PMD_SIZE block: */
> > +	if ((start & PMD_MASK) == (end & PMD_MASK)) {
> > +		npages = (end - start) / PAGE_SIZE;
> > +		__accept_memory(start, start + npages * PAGE_SIZE);
> > +		return;
> > +	}
> 
> I still don't quite like how this turned out.  It's still a bit unclear to
> the reader that this has covered all the corner cases.  I think this needs a
> better comment:
> 
> 	/*
> 	 * Handle <PMD_SIZE blocks that do not end at a PMD boundary.
> 	 *
> 	 * Immediately accept the whole block.  This handles the case
> 	 * where the below round_{up,down}() would "lose" a small,
> 	 * <PMD_SIZE block.
> 	 */
> 	if ((start & PMD_MASK) == (end & PMD_MASK)) {
> 		...
> 		return;
> 	}
> 
> 	/*
> 	 * There is at least one more block to accept.  Both 'start'
> 	 * and 'end' may not be PMD-aligned.
> 	 */

Okay, looks better. Thanks.

> > +	/* Immediately accept a <PMD_SIZE piece at the start: */
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
> 
> 	/*
> 	 * 'start' and 'end' are now both PMD-aligned.
> 	 * Record the range as being unaccepted:
> 	 */

Okay.

> > +	if (start == end)
> > +		return;
> 
> Does bitmap_set()not accept zero-sized 'len' arguments?

Looks like it does. Will drop this.

> > +	bitmap_set((unsigned long *)params->unaccepted_memory,
> > +		   start / PMD_SIZE, (end - start) / PMD_SIZE);
> > +}
> 
> The code you have there is _precise_.  It will never eagerly accept any area
> that _can_ be represented in the bitmap.  But, that's kinda hard to
> describe.  Maybe we should be a bit more sloppy about accepting things up
> front to make it easier to describe:
> 
> 	/*
> 	 * Accept small regions that might not be
> 	 * able to be represented in the bitmap:
> 	 */
> 	if (end - start < PMD_SIZE*2) {
> 		npages = (end - start) / PAGE_SIZE;
> 		__accept_memory(start, start + npages * PAGE_SIZE);
> 		return;
> 	}
> 
> 	/*
> 	 * No matter how the start and end are aligned, at
> 	 * least one unaccepted PMD_SIZE area will remain.
> 	 */
> 
> 	... now do the start/end rounding
> 
> That has the downside of accepting a few things that it doesn't *HAVE* to
> accept.  But, its behavior is very easy to describe.

Hm. Okay. I will give it a try. I like how it is now, but maybe it will be
better.

> 
> > diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
> > new file mode 100644
> > index 000000000000..cbc24040b853
> > --- /dev/null
> > +++ b/arch/x86/include/asm/unaccepted_memory.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (C) 2020 Intel Corporation */
> > +#ifndef _ASM_X86_UNACCEPTED_MEMORY_H
> > +#define _ASM_X86_UNACCEPTED_MEMORY_H
> > +
> > +#include <linux/types.h>
> > +
> > +struct boot_params;
> > +
> > +void mark_unaccepted(struct boot_params *params, u64 start, u64 num);
> > +
> > +#endif
> > diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> > index b25d3f82c2f3..16bc686a198d 100644
> > --- a/arch/x86/include/uapi/asm/bootparam.h
> > +++ b/arch/x86/include/uapi/asm/bootparam.h
> > @@ -217,7 +217,8 @@ struct boot_params {
> >   	struct boot_e820_entry e820_table[E820_MAX_ENTRIES_ZEROPAGE]; /* 0x2d0 */
> >   	__u8  _pad8[48];				/* 0xcd0 */
> >   	struct edd_info eddbuf[EDDMAXNR];		/* 0xd00 */
> > -	__u8  _pad9[276];				/* 0xeec */
> > +	__u64 unaccepted_memory;			/* 0xeec */
> > +	__u8  _pad9[268];				/* 0xef4 */
> >   } __attribute__((packed));
> >   /**
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 2c3dac5ecb36..36c1bf33f112 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -243,6 +243,20 @@ config EFI_DISABLE_PCI_DMA
> >   	  options "efi=disable_early_pci_dma" or "efi=no_disable_early_pci_dma"
> >   	  may be used to override this option.
> > +config UNACCEPTED_MEMORY
> > +	bool
> > +	depends on EFI_STUB
> > +	help
> > +	   Some Virtual Machine platforms, such as Intel TDX, introduce
> > +	   the concept of memory acceptance, requiring memory to be accepted
> > +	   before it can be used by the guest. This protects against a class of
> > +	   attacks by the virtual machine platform.
> 
> 	Some Virtual Machine platforms, such as Intel TDX, require
> 	some memory to be "accepted" by the guest before it can be used.
> 	This requirement protects against a class of attacks by the
> 	virtual machine platform.
> 
> Can we make this "class of attacks" a bit more concrete?  Maybe:
> 
> 	This mechanism helps prevent malicious hosts from making changes
> 	to guest memory.
> 
> ??

Okay.

> > +	   UEFI specification v2.9 introduced EFI_UNACCEPTED_MEMORY memory type.
> > +
> > +	   This option adds support for unaccepted memory and makes such memory
> > +	   usable by kernel.
> > +
> >   endmenu
> >   config EFI_EMBEDDED_FIRMWARE
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index ae79c3300129..abe862c381b6 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -740,6 +740,7 @@ static __initdata char memory_type_name[][13] = {
> >   	"MMIO Port",
> >   	"PAL Code",
> >   	"Persistent",
> > +	"Unaccepted",
> >   };
> >   char * __init efi_md_typeattr_format(char *buf, size_t size,
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index a0b946182b5e..346b12d6f1b2 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -9,12 +9,14 @@
> >   #include <linux/efi.h>
> >   #include <linux/pci.h>
> >   #include <linux/stddef.h>
> > +#include <linux/bitmap.h>
> >   #include <asm/efi.h>
> >   #include <asm/e820/types.h>
> >   #include <asm/setup.h>
> >   #include <asm/desc.h>
> >   #include <asm/boot.h>
> > +#include <asm/unaccepted_memory.h>
> >   #include "efistub.h"
> > @@ -504,6 +506,13 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
> >   			e820_type = E820_TYPE_PMEM;
> >   			break;
> > +		case EFI_UNACCEPTED_MEMORY:
> > +			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> > +				continue;
> > +			e820_type = E820_TYPE_RAM;
> > +			mark_unaccepted(params, d->phys_addr,
> > +					d->phys_addr + PAGE_SIZE * d->num_pages);
> > +			break;
> >   		default:
> >   			continue;
> >   		}
> > @@ -575,6 +584,9 @@ static efi_status_t allocate_e820(struct boot_params *params,
> >   {
> >   	efi_status_t status;
> >   	__u32 nr_desc;
> > +	bool unaccepted_memory_present = false;
> > +	u64 max_addr = 0;
> > +	int i;
> >   	status = efi_get_memory_map(map);
> >   	if (status != EFI_SUCCESS)
> > @@ -589,9 +601,55 @@ static efi_status_t allocate_e820(struct boot_params *params,
> >   		if (status != EFI_SUCCESS)
> >   			goto out;
> >   	}
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
> > +	 * If unaccepted memory present allocate a bitmap to track what memory
> 
> 			       ^ is
> 
> > +	 * has to be accepted before access.
> > +	 *
> > +	 * One bit in the bitmap represents 2MiB in the address space: one 4k
> > +	 * page is enough to track 64GiB or physical address space.
> 
> That's a bit awkward and needs a "or->of".  Perhaps:
> 
> 	* One bit in the bitmap represents 2MiB in the address space:
> 	* A 4k bitmap can track 64GiB of physical address space.

Okay.

> 
> > +	 * In the worst case scenario -- a huge hole in the middle of the
> > +	 * address space -- It needs 256MiB to handle 4PiB of the address
> > +	 * space.
> > +	 *
> > +	 * TODO: handle situation if params->unaccepted_memory has already set.
> > +	 * It's required to deal with kexec.
> 
> What happens today with kexec() since its not dealt with?

I didn't give it a try, but I assume it will hang.

There are more things to do to make kexec working and safe. We will get
there, but it is not top priority.

-- 
 Kirill A. Shutemov
