Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F7676B3AD
	for <lists+linux-efi@lfdr.de>; Tue,  1 Aug 2023 13:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjHALqL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 07:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjHALqK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 07:46:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5527C7;
        Tue,  1 Aug 2023 04:46:09 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5AFBE1EC00D9;
        Tue,  1 Aug 2023 13:46:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690890368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=j5zdlRHy2N71OOshcWSh5Rc0QlTp1GK/K7UaEmBcwu0=;
        b=aEoeIbaM5V/WN9b9mNxxTjN3k3E1jD+yGnkEvfH2MV7n41nrmcM/F9Ql0SA28C1j0W+HgC
        c414RCOKhwJ183F5/fUp9Fhnv7JSw0pcGtSz0xeRtuLByqvYlvJ+O5IQ+6BdP7Xq5rTNeJ
        I9bFBCgYxcorhsvrZRAEBKCRZUQuBpk=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rPkOABqQW4IN; Tue,  1 Aug 2023 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690890362; bh=j5zdlRHy2N71OOshcWSh5Rc0QlTp1GK/K7UaEmBcwu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sl9dQZ0VmvL/cLf+335vNqFY6E5+Q6KZyTp05J4PEpDW95YgCX+rIpmZA7xDeOXmW
         5xtB1rwSMx8VL07klwe899hu9GZd7lwrmCLNO4dTZxZrCgjvu/u9anrY+xHvUD133G
         swE6ePdohlDubcd1b4Itge8GKlCSituw3F2m1C6wmFJVTlZ/n+3kNSmavVX61xAYmT
         CRu12lDk5/isW7M/4JmaAKmsD3qtCrudISUQq8AUSXHt8wbK2rM4BAlJoJBT8JBtIj
         roA5CUUOAM2266Yv/6Oyu/rELJD41b17o4HnMf6Y+Yb1hniQFzqsX/Tg8RpdYZFH0w
         xHP4Oh1wuIFboA5sS+S3lUAb2HmtHBmZJjMgbKhzKWRikFcqul/ThAoKC8g2Xg+MVb
         kPomJGj1ftYx7fxfcAco7u+JrnOIoQ6MrIMK2aJ2IYeVqlGl7Iet1wljVkOuWyMzyM
         bNigjzYdyd6njKToWYBa2vXC9FLVS9qrfVen5A8NoXY123AbpqnsyiZo7ypWqagNCR
         LCQjty+dBuPQ7yRLdnEyamBOHJzslEN0c59NXNaks4+TKJTNsTzPo5egztdXedIx5S
         arheIEsexkTavADfxzmjy/CbSMrrCILIeMtI42onKx/JwaeCpnlWHMXk/esawcRLSQ
         pIkAOOP5srM9+VduDHhZagAw=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDC3740E01D3;
        Tue,  1 Aug 2023 11:45:42 +0000 (UTC)
Date:   Tue, 1 Aug 2023 13:45:42 +0200
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
Subject: Re: [PATCH v7 12/22] x86/decompressor: Call trampoline directly from
 C code
Message-ID: <20230801114542.GEZMjwZne986ZxI6eG@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-13-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728090916.1538550-13-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 28, 2023 at 11:09:06AM +0200, Ard Biesheuvel wrote:
> Instead of returning to the asm calling code to invoke the trampoline,
> call it straight from the C code that sets the scene. That way, the
> struct return type is no longer needed for returning two values, and the
> call can be made conditional more cleanly in a subsequent patch.
> 
> This means that all callee save 64-bit registers need to be preserved
> and restored, as their contents may not survive the legacy mode switch.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/head_64.S    | 28 +++++++-----------
>  arch/x86/boot/compressed/pgtable_64.c | 30 ++++++++------------
>  2 files changed, 23 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 1b0c61d1b389fd37..3f38db557112c155 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -430,24 +430,12 @@ SYM_CODE_START(startup_64)
>  #endif
>  
>  	/*
> -	 * paging_prepare() sets up the trampoline and checks if we need to
> -	 * enable 5-level paging.
> -	 *
> -	 * paging_prepare() returns a two-quadword structure which lands
> -	 * into RDX:RAX:
> -	 *   - Address of the trampoline is returned in RAX.
> -	 *   - Non zero RDX means trampoline needs to enable 5-level
> -	 *     paging.
> -	 *
> +	 * set_paging_levels() updates the number of paging levels using a

I'd say here "configure paging" or so.

> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index d66639c961b8eeda..649c51935fdec7ef 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -16,11 +16,6 @@ unsigned int __section(".data") pgdir_shift = 39;
>  unsigned int __section(".data") ptrs_per_p4d = 1;
>  #endif
>  
> -struct paging_config {
> -	unsigned long trampoline_start;
> -	unsigned long l5_required;
> -};
> -
>  /* Buffer to preserve trampoline memory */
>  static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
>  
> @@ -29,7 +24,7 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
>   * purposes.
>   *
>   * Avoid putting the pointer into .bss as it will be cleared between
> - * paging_prepare() and extract_kernel().
> + * set_paging_levels() and extract_kernel().
>   */
>  unsigned long *trampoline_32bit __section(".data");
>  
> @@ -106,10 +101,10 @@ static unsigned long find_trampoline_placement(void)
>  	return bios_start - TRAMPOLINE_32BIT_SIZE;
>  }
>  
> -struct paging_config paging_prepare(void *rmode)
> +asmlinkage void set_paging_levels(void *rmode)

So actually "paging_prepare" or "configure_paging" is more to the point
than setting paging levels. When I see set_paging_levels() I wonder what
levels are those and I have to look at the code and go, aaah, 5-level vs
4-level.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
