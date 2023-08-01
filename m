Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5745E76B46C
	for <lists+linux-efi@lfdr.de>; Tue,  1 Aug 2023 14:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjHAMI5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 08:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjHAMI4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 08:08:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED11982;
        Tue,  1 Aug 2023 05:08:55 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 137E31EC0532;
        Tue,  1 Aug 2023 14:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690891734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FxuoKK6iA7jCc7CzQE8tdfsQIpWnMGHsxXnMGYPo8xE=;
        b=R1puegKKMwq9A7Ettla/ygoHluAOB+uuC+jY4GkGwfhZ8BKNCVDNt7WUPn/f5IxzkS2WJz
        pEQTFswPQcfVT0N7nH0rDmxVwczi15U4BCd15xjZn+HXJgzkHLXs4iIqIirGpbN0jk9xnQ
        XS/nJuAKAioJ2k4ttVsc8Vnn32pM9d8=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d3fCGvSyTQ2D; Tue,  1 Aug 2023 12:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690891731; bh=FxuoKK6iA7jCc7CzQE8tdfsQIpWnMGHsxXnMGYPo8xE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMpBPOf+j+s+T/X+E3mpvvRXJCKfNR0pdYDI3FMeamHCVEM3xqx22cAnHTNVKrYgr
         ZjI4e2X7BIf3rq+Zw/azZ55JnIwFkhVnm7nE1fVf+uE2Cqc7OEOLMPXCUtzEzI5xQI
         aPkNFwuD+OMikuyEHL7HId4vWjPFnUchRUHHRlQfkgApk0Tvu5aLHES00/iVyTkiPO
         3XUbaqpkK08/EnXk7N+25wYJkGpVZgPz1SZsd/UqUJIfEMZ6mGTa8njnIfiLF73hI0
         iypIVStCIbnuz1ZEX371VznoV4pSsZiFcZ6OCxIdbWp4kcrAV3cGUvxNnlczdWhZOK
         /ppc46se1Krl6fbo23wOTE61QJxm+dCA6plkP3E4ZXBHm+xjU/UH4TSfOIAcKkEfAh
         VOl+kw1TxZTdpiSFzAny9A7Mor1hVOrMwC7F7JVB2GfQe3A57SA0L04VWmlxYkuBXB
         Yl9rF8p8nVWc0qRHkd4HEGHIpZn6PgdceUMuvyew1N7vxWu7XfToypFqmzNMxHwzvm
         jOepzoE57PH5fXTh6pXj8KveZayIh6M0i4ueTttScFANvxwbN5dMvRq0FXgYeKfDbq
         pJOKictcqgEZEZym0f6OcE1/7rphFnCegCT8yl+82yRYq+hLuG6+NQnwh31BuoIeB2
         MQux4kQSDzjROF8BqJEftI90=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57E5440E019D;
        Tue,  1 Aug 2023 12:08:32 +0000 (UTC)
Date:   Tue, 1 Aug 2023 14:08:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v7 14/22] x86/decompressor: Merge trampoline cleanup with
 switching code
Message-ID: <20230801120827.GFZMj1uzNMDs2gIi1f@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-15-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728090916.1538550-15-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 28, 2023 at 11:09:08AM +0200, Ard Biesheuvel wrote:
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index 4016444e6788304f..4f50af23a0854f18 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -101,9 +101,10 @@ static unsigned long find_trampoline_placement(void)
>  	return bios_start - TRAMPOLINE_32BIT_SIZE;
>  }
>  
> -asmlinkage void set_paging_levels(void *rmode)
> +asmlinkage void set_paging_levels(void *rmode, void *pgtable)

Please get rid of this silly rmode arg which gets passed in here as
boot_params and then gets assigned to an extern pointer to boot_params.
This is just silly. Just do what the other functions get from %r15 now
- a struct boot_params *bp arg.

But perhaps in a separate patch.

>  {
>  	void (*toggle_la57)(void *trampoline, bool enable_5lvl);
> +	void *trampoline_pgtable;
>  	bool l5_required = false;
>  
>  	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
> @@ -133,7 +134,7 @@ asmlinkage void set_paging_levels(void *rmode)
>  	 * the desired one.
>  	 */
>  	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
> -		return;
> +		goto out;
>  
>  	trampoline_32bit = (unsigned long *)find_trampoline_placement();
>  
> @@ -163,6 +164,8 @@ asmlinkage void set_paging_levels(void *rmode)
>  	 * The new page table will be used by trampoline code for switching
>  	 * from 4- to 5-level paging or vice versa.
>  	 */
> +	trampoline_pgtable = trampoline_32bit +
> +			     TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
>  
>  	if (l5_required) {
>  		/*
> @@ -182,31 +185,21 @@ asmlinkage void set_paging_levels(void *rmode)
>  		 * may be above 4G.
>  		 */
>  		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
> -		memcpy(trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long),
> -		       (void *)src, PAGE_SIZE);
> +		memcpy(trampoline_pgtable, (void *)src, PAGE_SIZE);
>  	}
>  
>  	toggle_la57(trampoline_32bit, l5_required);
> -}
> -
> -void cleanup_trampoline(void *pgtable)
> -{
> -	void *trampoline_pgtable;
> -
> -	trampoline_pgtable = trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
>  
>  	/*
> -	 * Move the top level page table out of trampoline memory,
> -	 * if it's there.
> +	 * Move the top level page table out of trampoline memory.
>  	 */
> -	if ((void *)__native_read_cr3() == trampoline_pgtable) {
> -		memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
> -		native_write_cr3((unsigned long)pgtable);
> -	}
> +	memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
> +	native_write_cr3((unsigned long)pgtable);
>  
>  	/* Restore trampoline memory */
>  	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
>  
> +out:
>  	/* Initialize variables for 5-level paging */
>  #ifdef CONFIG_X86_5LEVEL
>  	if (__read_cr4() & X86_CR4_LA57) {
> @@ -215,4 +208,5 @@ void cleanup_trampoline(void *pgtable)
>  		ptrs_per_p4d = 512;
>  	}
>  #endif
> +	return;

No need for that one. It'll return without it. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
