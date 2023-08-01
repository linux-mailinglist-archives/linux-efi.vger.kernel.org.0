Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660CC76B1CB
	for <lists+linux-efi@lfdr.de>; Tue,  1 Aug 2023 12:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjHAKak (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 06:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjHAKaj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 06:30:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB35392;
        Tue,  1 Aug 2023 03:30:37 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CFFBC1EC00D9;
        Tue,  1 Aug 2023 12:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690885835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZYNCvFLvMTTU8HwtmFrgwvUT3pozsFpio1F/DyX1K4Q=;
        b=TcaBAy2FqGCFnc7VcnwDyN5hs+JI6sNUu5edOiZR6AIMlbOTD+Yc6lde7rQS1rjp7FdBmc
        ZDh8qJR+nktNWKoGhBkDC1yoSLwUlpKTMTMg7tcjrAufxgJB6Q9GA+tY9mpywmqaM6pc2x
        ELTJ9e8Iy7SP+FU0cPc5AvsldQ5QI+k=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VFYORMvHGobl; Tue,  1 Aug 2023 10:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690885832; bh=ZYNCvFLvMTTU8HwtmFrgwvUT3pozsFpio1F/DyX1K4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lqg6DtCNlzgvD5D2M8FY0aQfvDqMog5dIQmezHrROoBvwVYa+363P4mg5mTK3k2lj
         ZcFj0Es78CA0BytRh8PkcuEYq8Bh8JMljFLhm21EvCJRV3Tbjcy0xKbpwDP37UXpiM
         PESlkktECcbCp+It8GHgbrf7oxmsV9yZzj3JdEW+4GVBAFdKkc17+j7qGHflWcBtNW
         bFdUPQC8Zd8xaqcqFCpamQPhRE9hz8SVixfc9JyiGJoT2/i8TE4Q1uvYQyy7ZmEsUg
         xPsaNhVwc94A62KID6rTUkQZ4dY9nqaKpMkVelCTDL0O9k39It1ogBdn7TxcmZkdFA
         Zs5fjdLTdM58U7xi1+e0MbYuG3EFZS5QtZnvW1YYswNgkC4MsoTSXYnLENKYqEVGuI
         cu0wWD6ep7yt1pxfZ3rQ5x6lDB/tPNn6na3OWAh1McBsFIRtXQHoHtz9iqkq+S6rB1
         yDKD54+frpGE3gy4BYESOYdIH1mmrB2pZA4nkQVp67r3CyIwivahyJeO65l0uQhJPB
         THe4es56gK+zJRrWXkwCUZp81hh7SUQKYciVHacfHw3D0l27bgyP0BK1FzURw3B4BN
         Pt4qvnC8SqFXqROuWzWfC09+uQ+bNo9mBIkC17soB7pjxLsmiNb9h4Slzc+4F3Eqs0
         SlcpUPAnvMgxuwpG9cyAJS4U=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFE7540E0184;
        Tue,  1 Aug 2023 10:30:12 +0000 (UTC)
Date:   Tue, 1 Aug 2023 12:30:08 +0200
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
Subject: Re: [PATCH v7 11/22] x86/decompressor: Avoid the need for a stack in
 the 32-bit trampoline
Message-ID: <20230801103008.GCZMjesHuwb3IKCh2D@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-12-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728090916.1538550-12-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 28, 2023 at 11:09:05AM +0200, Ard Biesheuvel wrote:
> The 32-bit trampoline no longer uses the stack for anything except
> performing a far return back to long mode. Currently, this stack is
> placed in the same page that carries the trampoline code, which means
> this page must be mapped writable and executable, and the stack is
> therefore executable as well.
> 
> Replace the far return with a far jump, so that the return address can
> be pre-calculated and patched into the code before it is called. This
> removes the need for a stack entirely, and in a later patch, this will
> be taken advantage of by removing writable permissions from (and adding
> executable permissions to) this code page explicitly when booting via
> the EFI stub.
> 
> Not touching the stack pointer also makes it more straight-forward to
> call the trampoline code as an ordinary 64-bit function from C code.
> 
> Note that we need to preserve the value of RSP across the switch into
	    ^^

Passive voice pls.

> compatibility mode: the stack pointer may get truncated to 32 bits.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/head_64.S    | 64 ++++++++++----------
>  arch/x86/boot/compressed/pgtable.h    |  4 +-
>  arch/x86/boot/compressed/pgtable_64.c | 12 +++-
>  3 files changed, 44 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 491d985be75fd5b0..1b0c61d1b389fd37 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -449,9 +449,6 @@ SYM_CODE_START(startup_64)
>  	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
>  	call	*%rax
>  
> -	/* Restore the stack, the 32-bit trampoline uses its own stack */
> -	leaq	rva(boot_stack_end)(%rbx), %rsp
> -
>  	/*
>  	 * cleanup_trampoline() would restore trampoline memory.
>  	 *
> @@ -537,32 +534,37 @@ SYM_FUNC_END(.Lrelocated)
>   * EDI contains the base address of the trampoline memory.
>   * Non-zero ESI means trampoline needs to enable 5-level paging.
>   */
> +	.section ".rodata", "a", @progbits
>  SYM_CODE_START(trampoline_32bit_src)
> -	/* Grab return address */
> -	movq	(%rsp), %rax
> -
> -	/* Set up 32-bit addressable stack */
> -	leaq	TRAMPOLINE_32BIT_STACK_END(%rdi), %rsp
> -
> -	/* Preserve return address and other live 64-bit registers */
> -	pushq	%rax
> +	/* Preserve live 64-bit registers */
>  	pushq	%r15
>  	pushq	%rbp
>  	pushq	%rbx
>  
> +	/* Preserve top half of RSP in a legacy mode GPR to avoid truncation */
> +	movq	%rsp, %rbx
> +	shrq	$32, %rbx
> +
>  	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
>  	pushq	$__KERNEL32_CS
>  	leaq	0f(%rip), %rax
>  	pushq	%rax
>  	lretq
>  
> +	/*
> +	 * The 32-bit code below will do a far jump back to long mode and end
> +	 * up here after reconfiguring the number of paging levels.
> +	 */
> +.Lret:	shlq	$32, %rbx		// Reconstruct stack pointer

No side comments pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
