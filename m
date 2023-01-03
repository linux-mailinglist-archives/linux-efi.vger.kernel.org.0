Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3A065C1B8
	for <lists+linux-efi@lfdr.de>; Tue,  3 Jan 2023 15:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjACOVJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Jan 2023 09:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjACOVI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Jan 2023 09:21:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FBC103E;
        Tue,  3 Jan 2023 06:21:02 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C35001EC050B;
        Tue,  3 Jan 2023 15:21:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672755660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y2lMNFRbTCBvtpE0tVvmu7BZzOhA8eUbudyQ9zFc2rg=;
        b=K6+UVr5X3tzkIkUeK2Xva7KYiJtp9twfwujIBube7NjMmd5dtNBxZMM9gtIWVhujHdqzOo
        QbkxhtVi0qRNa7atPIIA44ov01SyhLrTMEvbipQVa4S5/HMxwOsZAsbB5KufNqx+qS7LeB
        /zFFULKxRKEjW7PcJmhydT9s8xEP3yQ=
Date:   Tue, 3 Jan 2023 15:20:55 +0100
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
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 06/14] efi/x86: Implement support for unaccepted memory
Message-ID: <Y7Q5x7qV/Cmc/p8s@zn.tnic>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
 <20221207014933.8435-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221207014933.8435-7-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 07, 2022 at 04:49:25AM +0300, Kirill A. Shutemov wrote:
> The implementation requires some basic helpers in boot stub. They
> provided by linux/ includes in the main kernel image, but is not present
> in boot stub. Create copy of required functionality in the boot stub.

Leftover paragraph from a previous version. Can be removed.

...

> +/*
> + * The accepted memory bitmap only works at PMD_SIZE granularity.  This
> + * function takes unaligned start/end addresses and either:

s/This function takes/Take/

> + *  1. Accepts the memory immediately and in its entirety
> + *  2. Accepts unaligned parts, and marks *some* aligned part unaccepted
> + *
> + * The function will never reach the bitmap_set() with zero bits to set.
> + */
> +void process_unaccepted_memory(struct boot_params *params, u64 start, u64 end)
> +{
> +	/*
> +	 * Ensure that at least one bit will be set in the bitmap by
> +	 * immediately accepting all regions under 2*PMD_SIZE.  This is
> +	 * imprecise and may immediately accept some areas that could
> +	 * have been represented in the bitmap.  But, results in simpler
> +	 * code below
> +	 *
> +	 * Consider case like this:
> +	 *
> +	 * | 4k | 2044k |    2048k   |
> +	 * ^ 0x0        ^ 2MB        ^ 4MB
> +	 *
> +	 * Only the first 4k has been accepted. The 0MB->2MB region can not be
> +	 * represented in the bitmap. The 2MB->4MB region can be represented in
> +	 * the bitmap. But, the 0MB->4MB region is <2*PMD_SIZE and will be
> +	 * immediately accepted in its entirety.
> +	 */
> +	if (end - start < 2 * PMD_SIZE) {
> +		__accept_memory(start, end);
> +		return;
> +	}
> +
> +	/*
> +	 * No matter how the start and end are aligned, at least one unaccepted
> +	 * PMD_SIZE area will remain to be marked in the bitmap.
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

...

> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 6787ed8dfacf..8aa8adf0bcb5 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -314,6 +314,20 @@ config EFI_COCO_SECRET
>  	  virt/coco/efi_secret module to access the secrets, which in turn
>  	  allows userspace programs to access the injected secrets.
>  
> +config UNACCEPTED_MEMORY
> +	bool
> +	depends on EFI_STUB

This still doesn't make a whole lotta sense. If I do "make menuconfig" I don't
see the help text because that bool doesn't have a string prompt. So who is that
help text for?

Then, in the last patch you have

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -888,6 +888,8 @@ config INTEL_TDX_GUEST
        select ARCH_HAS_CC_PLATFORM
        select X86_MEM_ENCRYPT
        select X86_MCE
+       select UNACCEPTED_MEMORY
+       select EFI_STUB

I guess you want to select UNACCEPTED_MEMORY only.

And I've already mentioned this whole mess:

https://lore.kernel.org/r/Yt%2BnOeLMqRxjObbx@zn.tnic

Please incorporate all review comments before sending a new version of
your patch.

Ignoring review feedback is a very unfriendly thing to do:

- if you agree with the feedback, you work it in in the next revision

- if you don't agree, you *say* *why* you don't

> +	help
> +	   Some Virtual Machine platforms, such as Intel TDX, require
> +	   some memory to be "accepted" by the guest before it can be used.
> +	   This mechanism helps prevent malicious hosts from making changes
> +	   to guest memory.
> +
> +	   UEFI specification v2.9 introduced EFI_UNACCEPTED_MEMORY memory type.
> +
> +	   This option adds support for unaccepted memory and makes such memory
> +	   usable by the kernel.

...

> +static efi_status_t allocate_unaccepted_bitmap(struct boot_params *params,
> +					       __u32 nr_desc,
> +					       struct efi_boot_memmap *map)
> +{
> +	unsigned long *mem = NULL;
> +	u64 size, max_addr = 0;
> +	efi_status_t status;
> +	bool found = false;
> +	int i;
> +
> +	/* Check if there's any unaccepted memory and find the max address */
> +	for (i = 0; i < nr_desc; i++) {
> +		efi_memory_desc_t *d;
> +		unsigned long m = (unsigned long)map->map;
> +
> +		d = efi_early_memdesc_ptr(m, map->desc_size, i);
> +		if (d->type == EFI_UNACCEPTED_MEMORY)
> +			found = true;
> +		if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
> +			max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
> +	}
> +
> +	if (!found) {
> +		params->unaccepted_memory = 0;
> +		return EFI_SUCCESS;
> +	}
> +
> +	/*
> +	 * If unaccepted memory is present, allocate a bitmap to track what
> +	 * memory has to be accepted before access.
> +	 *
> +	 * One bit in the bitmap represents 2MiB in the address space:
> +	 * A 4k bitmap can track 64GiB of physical address space.
> +	 *
> +	 * In the worst case scenario -- a huge hole in the middle of the
> +	 * address space -- It needs 256MiB to handle 4PiB of the address
> +	 * space.
> +	 *
> +	 * TODO: handle situation if params->unaccepted_memory is already set.
> +	 * It's required to deal with kexec.

A TODO in a patch basically says this patch is not ready to go anywhere.

IOW, you need to handle that kexec case here gracefully. Even if you refuse to
boot a kexec-ed kernel because it cannot support handing in the bitmap from the
first kernel, yadda yadda...

> +	 *
> +	 * The bitmap will be populated in setup_e820() according to the memory
> +	 * map after efi_exit_boot_services().
> +	 */
> +	size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
> +	status = efi_allocate_pages(size, (unsigned long *)&mem, ULONG_MAX);
> +	if (status == EFI_SUCCESS) {
> +		memset(mem, 0, size);
> +		params->unaccepted_memory = (unsigned long)mem;
> +	}
> +
> +	return status;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
