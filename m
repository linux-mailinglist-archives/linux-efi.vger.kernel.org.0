Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9BF4F9BA1
	for <lists+linux-efi@lfdr.de>; Fri,  8 Apr 2022 19:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiDHR2R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Apr 2022 13:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiDHR2Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Apr 2022 13:28:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5810519C824;
        Fri,  8 Apr 2022 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649438772; x=1680974772;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=pQq1owev8Q5T9051hb6/0m0SGVCr590UO3Rp5qg5yhg=;
  b=KhSaKoHnxTmOsLAOGhcJLpRAyXb6ZmogB27XQfveGc9ek0yd3SOsiQxL
   h6OKVVw5LkzyQgGA7Uo2oDU3FoCgY+IqLPzkZIDoPOBhESMhvDjuQ91C0
   lNL4DXuS28IG6CssQBAAhQ/eacBy3t7gEKDOsYYBKpvpKs/HiQUya7aQs
   eehFk+M86ZpcDB3EAszBrjlFBEY5Yvcs11s81wB50ybFCM+GsvmJpBjfK
   KhIe5/bSMlLv2VyLXYg2g4W0s5H7in9Uu4cm+tt/K6rC7oEaYIOXI6N2+
   /5np+pzMpawrIWFO8AtV49C1LCK8rW4Ld8mH2WgZ+u050emwKAovruLUK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261823585"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261823585"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:26:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525459701"
Received: from tsungtae-mobl.amr.corp.intel.com (HELO [10.134.43.198]) ([10.134.43.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:26:10 -0700
Message-ID: <c4b987d5-00d3-40ea-4c20-bf82b7512dec@intel.com>
Date:   Fri, 8 Apr 2022 10:26:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 3/8] efi/x86: Implement support for unaccepted memory
In-Reply-To: <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/5/22 16:43, Kirill A. Shutemov wrote:
> +void mark_unaccepted(struct boot_params *params, u64 start, u64 end)
> +{
> +	/*
> +	 * The accepted memory bitmap only works at PMD_SIZE granularity.
> +	 * If a request comes in to mark memory as unaccepted which is not
> +	 * PMD_SIZE-aligned, simply accept the memory now since it can not be
> +	 * *marked* as unaccepted.
> +	 */
> +
> +	/*
> +	 * Accept small regions that might not be able to be represented
> +	 * in the bitmap:
> +	 */
> +	if (end - start < 2 * PMD_SIZE) {
> +		__accept_memory(start, end);
> +		return;
> +	}

This is not my first time looking at this code and I still had to think
about this a bit.  That's not good.  That pathological case here is
actually something like this:

| 4k | 2044k + 2044k | 4k |
^ 0x0 	     ^ 2MB	  ^ 4MB

Where we have a 2MB-aligned 4k accepted area, a 4088k unaccepted area,
then another 4k accepted area.  That will not result in any bits being
set in the accepted memory bitmap because no 2MB region is fully accepted.

The one oddball case is this:

| 4k | 2044k |    2048k   |
^ 0x0 	     ^ 2MB	  ^ 4MB

Which would fall into the if() above, but *can* have part of its range
marked in the bitmap.

Maybe we need something more like this:

	/*
	 * Accept small regions that might not be able to be represented
	 * in the bitmap.  This is a bit imprecise and may accept some
	 * areas that could have been represented in the bitmap instead.
	 * But, the imprecision makes the code simpler by ensuring that
	 * at least one bit will be set int the bitmap below.
	 */

Although that's seeming a _bit_ verbose, and somewhat duplicates the
comment below.

> +	/*
> +	 * No matter how the start and end are aligned, at least one unaccepted
> +	 * PMD_SIZE area will remain.
> +	 */
> +
> +	/* Immediately accept a <PMD_SIZE piece at the start: */
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
> new file mode 100644
> index 000000000000..cbc24040b853
> --- /dev/null
> +++ b/arch/x86/include/asm/unaccepted_memory.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2020 Intel Corporation */
> +#ifndef _ASM_X86_UNACCEPTED_MEMORY_H
> +#define _ASM_X86_UNACCEPTED_MEMORY_H
> +
> +#include <linux/types.h>
> +
> +struct boot_params;
> +
> +void mark_unaccepted(struct boot_params *params, u64 start, u64 num);
> +
> +#endif
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index b25d3f82c2f3..16bc686a198d 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -217,7 +217,8 @@ struct boot_params {
>  	struct boot_e820_entry e820_table[E820_MAX_ENTRIES_ZEROPAGE]; /* 0x2d0 */
>  	__u8  _pad8[48];				/* 0xcd0 */
>  	struct edd_info eddbuf[EDDMAXNR];		/* 0xd00 */
> -	__u8  _pad9[276];				/* 0xeec */
> +	__u64 unaccepted_memory;			/* 0xeec */
> +	__u8  _pad9[268];				/* 0xef4 */
>  } __attribute__((packed));
>  
>  /**
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

The changelog should probably say something about how the kexec()
incompatibility is going to be rectified in the future.

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
> +
>  endmenu

BTW, what happens if this is compiled out?  Do TDX guests just lose all
the unaccepted memory?

Should TDX be selecting this or something?

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

This seems worthy of a pr_info().  We're effectively throwing away
memory with this "continue", right?

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
> +	u64 max_addr = 0;
> +	int i;
>  
>  	status = efi_get_memory_map(map);
>  	if (status != EFI_SUCCESS)
> @@ -589,9 +601,57 @@ static efi_status_t allocate_e820(struct boot_params *params,
>  		if (status != EFI_SUCCESS)
>  			goto out;
>  	}
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
> +	 *
> +	 * TODO: handle situation if params->unaccepted_memory has already set.
> +	 * It's required to deal with kexec.

Ahhh....  That's good info for the changelog.

> +	 * The bitmap will be populated in setup_e820() according to the memory
> +	 * map after efi_exit_boot_services().
> +	 */
> +	if (unaccepted_memory_present) {
> +		unsigned long *unaccepted_memory = NULL;
> +		u64 size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
> +
> +		status = efi_allocate_pages(size,
> +					    (unsigned long *)&unaccepted_memory,
> +					    ULONG_MAX);
> +		if (status != EFI_SUCCESS)
> +			goto out;
> +		memset(unaccepted_memory, 0, size);
> +		params->unaccepted_memory = (unsigned long)unaccepted_memory;
> +	} else {
> +		params->unaccepted_memory = 0;
> +	}
> +
>  out:
>  	efi_bs_call(free_pool, *map->map);
> -	return EFI_SUCCESS;
> +	return status;
> +
>  }
>  
>  struct exit_boot_struct {
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index ccd4d3f91c98..b0240fdcaf5b 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -108,7 +108,8 @@ typedef	struct {
>  #define EFI_MEMORY_MAPPED_IO_PORT_SPACE	12
>  #define EFI_PAL_CODE			13
>  #define EFI_PERSISTENT_MEMORY		14
> -#define EFI_MAX_MEMORY_TYPE		15
> +#define EFI_UNACCEPTED_MEMORY		15
> +#define EFI_MAX_MEMORY_TYPE		16
>  
>  /* Attribute values: */
>  #define EFI_MEMORY_UC		((u64)0x0000000000000001ULL)	/* uncached */

