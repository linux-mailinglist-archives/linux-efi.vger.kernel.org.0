Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97211503089
	for <lists+linux-efi@lfdr.de>; Sat, 16 Apr 2022 01:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356283AbiDOW1K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Apr 2022 18:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356278AbiDOW1J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Apr 2022 18:27:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF1B2F3A3;
        Fri, 15 Apr 2022 15:24:34 -0700 (PDT)
Received: from zn.tnic (p200300ea971b588b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:588b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCE461EC051F;
        Sat, 16 Apr 2022 00:24:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650061469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Bd8XWaIH2Z8xMIFDPo7yPy9hCbsLmfXqmKHrfanH38Q=;
        b=irRJCf0cIv30P3OVMvXmfYhw0UUsGb+Z4PKxgW9s/BF0pIgE/iGK+pn9H5ZAxoM7wUpLdr
        f9APe9URqawjjEau91wHzNTC2CEo+4XuO7UBppOU2J0swjFY9wqQ0iv/NzPG5fngRqz2fb
        eBFDLMB2n4UUNiHwtptZLHRDE2ByEyc=
Date:   Sat, 16 Apr 2022 00:24:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <Ylnwmvygp796+qcA@zn.tnic>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 06, 2022 at 02:43:38AM +0300, Kirill A. Shutemov wrote:
> diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
> index f088f5881666..8e3447a4b373 100644
> --- a/Documentation/x86/zero-page.rst
> +++ b/Documentation/x86/zero-page.rst
> @@ -42,4 +42,5 @@ Offset/Size	Proto	Name		Meaning
>  2D0/A00		ALL	e820_table		E820 memory map table
>  						(array of struct e820_entry)
>  D00/1EC		ALL	eddbuf			EDD data (array of struct edd_info)
> +ECC/008		ALL	unaccepted_memory	Bitmap of unaccepted memory (1bit == 2M)

There's a perfectly fine spot at 0x78:

	__u8  _pad3[8];                                 /* 0x078 */

why not take that one?

>  ===========	=====	=======================	=================================================
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 8fd0e6ae2e1f..09993797efa2 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -102,6 +102,7 @@ endif
>  
>  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>  vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
> +vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/unaccepted_memory.o
>  
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
>  efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
> diff --git a/arch/x86/boot/compressed/bitmap.c b/arch/x86/boot/compressed/bitmap.c
> new file mode 100644
> index 000000000000..bf58b259380a
> --- /dev/null
> +++ b/arch/x86/boot/compressed/bitmap.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Taken from lib/string.c */
> +
> +#include <linux/bitmap.h>

verify_include_paths: Warning: Kernel-proper include at arch/x86/boot/compressed/bitmap.c:4 [+#include <linux/bitmap.h>]

Same game as before: put the stuff you need into a separate or a shared
header and avoid the linux/ namespace include.

> +void __bitmap_set(unsigned long *map, unsigned int start, int len)
> +{
> +	unsigned long *p = map + BIT_WORD(start);
> +	const unsigned int size = start + len;
> +	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
> +	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
> +
> +	while (len - bits_to_set >= 0) {
> +		*p |= mask_to_set;
> +		len -= bits_to_set;
> +		bits_to_set = BITS_PER_LONG;
> +		mask_to_set = ~0UL;
> +		p++;
> +	}
> +	if (len) {
> +		mask_to_set &= BITMAP_LAST_WORD_MASK(size);
> +		*p |= mask_to_set;
> +	}
> +}
> diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
> new file mode 100644
> index 000000000000..d363acf59c08
> --- /dev/null
> +++ b/arch/x86/boot/compressed/unaccepted_memory.c

arch/x86/boot/compressed/mem.c

simply. That "unaccepted_memory" everywhere is a mouthful and too specific.

> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "error.h"
> +#include "misc.h"
> +
> +static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	/* Platform-specific memory-acceptance call goes here */
> +	error("Cannot accept memory");
> +}
> +
> +void mark_unaccepted(struct boot_params *params, u64 start, u64 end)

That name is kinda misleading? It is not only marking as unaccepted - it
is also accepting weird 2M misaligned chunks...

> +{
> +	/*
> +	 * The accepted memory bitmap only works at PMD_SIZE granularity.
> +	 * If a request comes in to mark memory as unaccepted which is not
> +	 * PMD_SIZE-aligned, simply accept the memory now since it can not be
> +	 * *marked* as unaccepted.
> +	 */

That comment goes over the function name.

> +	/*
> +	 * Accept small regions that might not be able to be represented
> +	 * in the bitmap:
> +	 */
> +	if (end - start < 2 * PMD_SIZE) {
> +		__accept_memory(start, end);
> +		return;
> +	}
> +
> +	/*
> +	 * No matter how the start and end are aligned, at least one unaccepted
> +	 * PMD_SIZE area will remain.
> +	 */
> +
> +	/* Immediately accept a <PMD_SIZE piece at the start: */

Immediately? As opposed to delayed?

> +	if (start & ~PMD_MASK) {
> +		__accept_memory(start, round_up(start, PMD_SIZE));
> +		start = round_up(start, PMD_SIZE);
> +	}
> +
> +	/* Immediately accept a <PMD_SIZE piece at the end: */
> +	if (end & ~PMD_MASK) {
> +		__accept_memory(round_down(end, PMD_SIZE), end);
> +		end = round_down(end, PMD_SIZE);
> +	}
> +
> +	/*
> +	 * 'start' and 'end' are now both PMD-aligned.
> +	 * Record the range as being unaccepted:
> +	 */
> +	bitmap_set((unsigned long *)params->unaccepted_memory,
> +		   start / PMD_SIZE, (end - start) / PMD_SIZE);
> +}
> diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h

Why do you need a separate header?

We already have

arch/x86/include/asm/mem_encrypt.h

and this is kinda very much related...

> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 2c3dac5ecb36..b17ceec757d0 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -243,6 +243,21 @@ config EFI_DISABLE_PCI_DMA
>  	  options "efi=disable_early_pci_dma" or "efi=no_disable_early_pci_dma"
>  	  may be used to override this option.
>  
> +config UNACCEPTED_MEMORY
> +	bool
> +	depends on EFI_STUB
> +	depends on !KEXEC_CORE
> +	help
> +	   Some Virtual Machine platforms, such as Intel TDX, require
> +	   some memory to be "accepted" by the guest before it can be used.
> +	   This mechanism helps prevent malicious hosts from making changes
> +	   to guest memory.
> +
> +	   UEFI specification v2.9 introduced EFI_UNACCEPTED_MEMORY memory type.
> +
> +	   This option adds support for unaccepted memory and makes such memory
> +	   usable by kernel.

... by *the* kernel.

> +
>  endmenu
>  
>  config EFI_EMBEDDED_FIRMWARE
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 5502e176d51b..2c055afb1b11 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -747,6 +747,7 @@ static __initdata char memory_type_name[][13] = {
>  	"MMIO Port",
>  	"PAL Code",
>  	"Persistent",
> +	"Unaccepted",
>  };
>  
>  char * __init efi_md_typeattr_format(char *buf, size_t size,
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index d18cac8ab436..e7601fd612aa 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -9,12 +9,14 @@
>  #include <linux/efi.h>
>  #include <linux/pci.h>
>  #include <linux/stddef.h>
> +#include <linux/bitmap.h>
>  
>  #include <asm/efi.h>
>  #include <asm/e820/types.h>
>  #include <asm/setup.h>
>  #include <asm/desc.h>
>  #include <asm/boot.h>
> +#include <asm/unaccepted_memory.h>
>  
>  #include "efistub.h"
>  
> @@ -504,6 +506,13 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
>  			e820_type = E820_TYPE_PMEM;
>  			break;
>  
> +		case EFI_UNACCEPTED_MEMORY:
> +			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> +				continue;
> +			e820_type = E820_TYPE_RAM;
> +			mark_unaccepted(params, d->phys_addr,
> +					d->phys_addr + PAGE_SIZE * d->num_pages);
> +			break;
>  		default:
>  			continue;
>  		}
> @@ -575,6 +584,9 @@ static efi_status_t allocate_e820(struct boot_params *params,
>  {
>  	efi_status_t status;
>  	__u32 nr_desc;
> +	bool unaccepted_memory_present = false;

This wholly written out "unaccepted_memory" everywhere is too much and
too long. How about 

	bool unaccept_mem;

or so?

> +	u64 max_addr = 0;
> +	int i;
>  
>  	status = efi_get_memory_map(map);
>  	if (status != EFI_SUCCESS)
> @@ -589,9 +601,57 @@ static efi_status_t allocate_e820(struct boot_params *params,
>  		if (status != EFI_SUCCESS)
>  			goto out;
>  	}

This whole chunk you're adding here begs to be a separate function with
the big fat comment placed over the function name.

Might just as well call it after allocate_e820() has been called.

> +
> +	if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> +		goto out;
> +
> +	/* Check if there's any unaccepted memory and find the max address */
> +	for (i = 0; i < nr_desc; i++) {
> +		efi_memory_desc_t *d;
> +
> +		d = efi_early_memdesc_ptr(*map->map, *map->desc_size, i);
> +		if (d->type == EFI_UNACCEPTED_MEMORY)
> +			unaccepted_memory_present = true;
> +		if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
> +			max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
> +	}
> +
> +	/*
> +	 * If unaccepted memory is present allocate a bitmap to track what
> +	 * memory has to be accepted before access.
> +	 *
> +	 * One bit in the bitmap represents 2MiB in the address space:
> +	 * A 4k bitmap can track 64GiB of physical address space.
> +	 *
> +	 * In the worst case scenario -- a huge hole in the middle of the
> +	 * address space -- It needs 256MiB to handle 4PiB of the address
> +	 * space.

And you're saying that that efi_allocate_pages() below can really give a
256M contiguous chunk?

> +	 *
> +	 * TODO: handle situation if params->unaccepted_memory has already set.
> +	 * It's required to deal with kexec.
> +	 *
> +	 * The bitmap will be populated in setup_e820() according to the memory
> +	 * map after efi_exit_boot_services().
> +	 */
> +	if (unaccepted_memory_present) {
> +		unsigned long *unaccepted_memory = NULL;

So if you call this simply

		unsigned long *mem = ...

> +		u64 size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
> +
> +		status = efi_allocate_pages(size,
> +					    (unsigned long *)&unaccepted_memory,
> +					    ULONG_MAX);

... you'd have this on a single line:

		status = efi_allocate_pages(size, (unsigned long *)&mem, ULONG_MAX);

> +		if (status != EFI_SUCCESS)
> +			goto out;
> +		memset(unaccepted_memory, 0, size);
> +		params->unaccepted_memory = (unsigned long)unaccepted_memory;

... and then have this assignment more readable:

		params->unaccepted_memory = (unsigned long)mem;

as it shows the important var being ->unaccepted_memory and mem only a
local helper.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
