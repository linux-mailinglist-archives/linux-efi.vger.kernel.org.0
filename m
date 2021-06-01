Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5AC3978EF
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jun 2021 19:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhFARVH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Jun 2021 13:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231918AbhFARVF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 1 Jun 2021 13:21:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B375E610C9;
        Tue,  1 Jun 2021 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622567964;
        bh=q1sbzRBTpAxr0jTVMrGbHfxE6MisoOTVV2xrIOplyF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDC4ObUwc0z2+/NXM43bGUUH634E+DSTDo58hx4EHsxrPIgyluNYrUO+QMv584mzw
         CxufNq/L31bShhVuXpBxWa+aaFpP9pX7rOlFkHVOnLuSXl/R2oXTS+StjynK8O4GbF
         KVFEhiRc56++gCHEqGWPoXAwJDT+oigiyW2SSN+a8RWrY+mJG1b/1vA393HWxD8HJk
         dUPTWt0QD1afJo5K1hs/422cEOsej/mTxyj48PGjBMayJn3Fljkh6kbujRf3fM9k5s
         whEDRpaIcQkqSEn8eff+rgOzZvddMbp66eUIP/ELkQW7xnFRigNvzsqUkKL/zSgch1
         mIHt1ai5THAuw==
Date:   Tue, 1 Jun 2021 20:19:13 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/setup: always reserve the first 1M of RAM
Message-ID: <YLZsEaimyAe0x6b3@kernel.org>
References: <20210601075354.5149-1-rppt@kernel.org>
 <20210601075354.5149-2-rppt@kernel.org>
 <20210601090653.GB361405@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601090653.GB361405@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Baoquan,
On Tue, Jun 01, 2021 at 05:06:53PM +0800, Baoquan He wrote:
> On 06/01/21 at 10:53am, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> ......  
> 
> > diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> > index 7850111008a8..b15ebfe40a73 100644
> > --- a/arch/x86/platform/efi/quirks.c
> > +++ b/arch/x86/platform/efi/quirks.c
> > @@ -450,6 +450,18 @@ void __init efi_free_boot_services(void)
> >  			size -= rm_size;
> >  		}
> 
> Thanks for taking care of the low-1M excluding in
> efi_free_boot_services(), Mike. You might want to remove the old real
> mode excluding code either since it's been covered by your new code.

Unfortunately I can't because it's important that set_real_mode_mem() would
reuse memory that was occupied by EFI boot services and that is being freed
here.

According to the changelog of 5bc653b73182 ("x86/efi: Allocate a trampoline
if needed in efi_free_boot_services()"), that system has EBDA at 0x2c000 so
we reserve everything from 0x2c000 to 0xa0000 in reserve_bios_regions() and
most of the memory below 0x2c0000 is used by EFI boot data. So with such
memory layout reserve_real_mode() won't be able to allocate the trampoline.
Yet, when the EFI boot data is free, the room occupied by it will be reused
by the real mode trampoline via set_real_mode_mem().
 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index b15ebfe40a73..be814f2089ff 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -409,7 +409,6 @@ void __init efi_free_boot_services(void)
>  	for_each_efi_memory_desc(md) {
>  		unsigned long long start = md->phys_addr;
>  		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
> -		size_t rm_size;
>  
>  		if (md->type != EFI_BOOT_SERVICES_CODE &&
>  		    md->type != EFI_BOOT_SERVICES_DATA) {
> @@ -430,26 +429,6 @@ void __init efi_free_boot_services(void)
>  		 */
>  		efi_unmap_pages(md);
>  
> -		/*
> -		 * Nasty quirk: if all sub-1MB memory is used for boot
> -		 * services, we can get here without having allocated the
> -		 * real mode trampoline.  It's too late to hand boot services
> -		 * memory back to the memblock allocator, so instead
> -		 * try to manually allocate the trampoline if needed.
> -		 *
> -		 * I've seen this on a Dell XPS 13 9350 with firmware
> -		 * 1.4.4 with SGX enabled booting Linux via Fedora 24's
> -		 * grub2-efi on a hard disk.  (And no, I don't know why
> -		 * this happened, but Linux should still try to boot rather
> -		 * panicking early.)
> -		 */
> -		rm_size = real_mode_size_needed();
> -		if (rm_size && (start + rm_size) < (1<<20) && size >= rm_size) {
> -			set_real_mode_mem(start);
> -			start += rm_size;
> -			size -= rm_size;
> -		}
> -
>  		/*
>  		 * Don't free memory under 1M for two reasons:
>  		 * - BIOS might clobber it
> 
> >  
> > +		/*
> > +		 * Don't free memory under 1M for two reasons:
> > +		 * - BIOS might clobber it
> > +		 * - Crash kernel needs it to be reserved
> > +		 */
> > +		if (start + size < SZ_1M)
> > +			continue;
> > +		if (start < SZ_1M) {
> > +			size -= (SZ_1M - start);
> > +			start = SZ_1M;
> > +		}
> > +
> >  		memblock_free_late(start, size);
> >  	}
> >  
> > diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> > index 2e1c1bec0f9e..8ea285aca827 100644
> > --- a/arch/x86/realmode/init.c
> > +++ b/arch/x86/realmode/init.c
> > @@ -29,14 +29,16 @@ void __init reserve_real_mode(void)
> >  
> >  	/* Has to be under 1M so we can execute real-mode AP code. */
> >  	mem = memblock_find_in_range(0, 1<<20, size, PAGE_SIZE);
> > -	if (!mem) {
> > +	if (!mem)
> >  		pr_info("No sub-1M memory is available for the trampoline\n");
> > -		return;
> > -	}
> > +	else
> > +		set_real_mode_mem(mem);
> >  
> > -	memblock_reserve(mem, size);
> > -	set_real_mode_mem(mem);
> > -	crash_reserve_low_1M();
> > +	/*
> > +	 * Unconditionally reserve the entire fisrt 1M, see comment in
> > +	 * setup_arch()
> > +	 */
> > +	memblock_reserve(0, SZ_1M);
> >  }
> >  
> >  static void sme_sev_setup_real_mode(struct trampoline_header *th)
> > -- 
> > 2.28.0
> > 
> 

-- 
Sincerely yours,
Mike.
