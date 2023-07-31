Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBA27694CC
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jul 2023 13:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGaL3N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jul 2023 07:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGaL3M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jul 2023 07:29:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D897C3;
        Mon, 31 Jul 2023 04:29:11 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B6B551EC05F5;
        Mon, 31 Jul 2023 13:29:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690802949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VrPGlj5TATHkbHdFB5PvJ46ZUhYf3roC1FY9CSw84mo=;
        b=BaZF2GrAggHVpH/btFtkO1x2MJx1gRSLxiZLpHGcsJyjYqquYuQSHxo08Gw2wyX5tmcMXl
        1HtI7kUoFkfhiWjQKEbY9lMb1cQE0jf6Cstu7bRpm0wVqZfumyEuDraPryeU5WYnZdSHGt
        NG/AISsV7E1UHgVmlH+U413cpJkmkfQ=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XbaPTmi5uCVQ; Mon, 31 Jul 2023 11:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690802946; bh=VrPGlj5TATHkbHdFB5PvJ46ZUhYf3roC1FY9CSw84mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVcu98usoipaL45pgASnXheXKzaRFYKBN55dIvyhs2J+3GxhIX6QHUG5+Nmy3eFvA
         ptjyad2pdaJCsJBMiUGXLfxNHy0zoJuvI253OuJStSs7urBE/tV9R7g1bueboQzU5F
         FnzWGMYo5tRgRukN5Bu5k74YV6svlh9PcrDo1XgidoSvXQucpaBmwv84tdmpOp+Dpq
         7Vwej6ykeDamRnKpqdnn7c8JCC0BFdMhQskZHp5xsEGMwSafYsKtxgybVLC7/VzICp
         mBYelfMFl6yRe0vQzyv+3v5sQFKpzXJ/0LqN14YmDEVhWmkAxOFdxKGAITyMbObBMg
         Q/lUyovTP/5DZB9VcwtY2IHuKI7ezgTFvy9CDxUcMe8XCID2MDsPhCY4JejzkaaMar
         HNFcxinL8RvrHHRjHVkQlLCUq1o3iMdvw6nbNhbsmOXgaaaQTIWK1uaiYg66ypFEyj
         fKw4no5fXUVOV8868ZZY7WFX4Ie3OO0yW1uYxNThwaY64FD4FalH36knHPb3tMlt7H
         HhSC+3MyRc0nqE1Mo6/MBmdtXP8IVhOwPxZMshXRnAfeAkJhlv/oehIUbg3NC6o8s4
         rgA665CPQpBpVSzn26F+HCgDbAkCAcZPXKy0ACWWf7HbNNopR/azi7W9V+qfPvBTMi
         BNwp/hL98J6lePqLoyqjc9wE=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F3DE540E01A4;
        Mon, 31 Jul 2023 11:28:46 +0000 (UTC)
Date:   Mon, 31 Jul 2023 13:28:42 +0200
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
Subject: Re: [PATCH v7 10/22] x86/decompressor: Use standard calling
 convention for trampoline
Message-ID: <20230731112842.GBZMea6qLHW+aZL3fB@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-11-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728090916.1538550-11-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 28, 2023 at 11:09:04AM +0200, Ard Biesheuvel wrote:
> Update the trampoline code so its arguments are passed via RDI and RSI,
> which matches the ordinary SysV calling convention for x86_64. This will
> allow this code to be called directly from C.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/head_64.S | 26 +++++++++-----------
>  arch/x86/boot/compressed/pgtable.h |  2 +-
>  2 files changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 1892679be2b6897a..491d985be75fd5b0 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -443,9 +443,9 @@ SYM_CODE_START(startup_64)
>  	movq	%r15, %rdi		/* pass struct boot_params pointer */
>  	call	paging_prepare
>  
> -	/* Save the trampoline address in RCX */
> -	movq	%rax, %rcx
> -
> +	/* Pass the trampoline address and boolean flag as args #1 and #2 */
> +	movq	%rax, %rdi
> +	movq	%rdx, %rsi
>  	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
>  	call	*%rax
>  
> @@ -534,15 +534,15 @@ SYM_FUNC_END(.Lrelocated)
>  /*
>   * This is the 32-bit trampoline that will be copied over to low memory.
>   *
> - * ECX contains the base address of the trampoline memory.
> - * Non zero RDX means trampoline needs to enable 5-level paging.
> + * EDI contains the base address of the trampoline memory.
> + * Non-zero ESI means trampoline needs to enable 5-level paging.
>   */

This is confusing - this talks about 32-bit and 32-bit registers but
uses the 64-bit calling convention because it gets called by 64-bit
code. Please add a short sentence clarifying that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
