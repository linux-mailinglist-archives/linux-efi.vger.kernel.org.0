Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780DD706F7F
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 19:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjEQRbx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 13:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQRbw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 13:31:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A5C26A3;
        Wed, 17 May 2023 10:31:50 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 370A61EC0666;
        Wed, 17 May 2023 19:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684344709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jSLldGrlFeDLob0SjoV+tDw0C7NLfpHCaoN5cOY2jz4=;
        b=pMZUdQSJF55h9VbGEMx3Xs57CkxQG7ExZK3q7hwHCUnBweJkpBQF6+bOsL1hPr+t2/MbW8
        0ure1g3c1cAKuXP2E9p/7Ib1dNXoZyVr3vIASYySVudFPtwFi0FkSHs1iuKLV0FD8tywbM
        puMrmiQtrXIMdVtZeRYiGci+Pr+wKaQ=
Date:   Wed, 17 May 2023 19:31:45 +0200
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
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/20] x86: decompressor: Use proper sequence to take
 the address of the GOT
Message-ID: <20230517173145.GEZGUPgRTiUFB2GwgG@fat_crate.local>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508070330.582131-2-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Please fix all your subjects as explained here:

https://kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

On Mon, May 08, 2023 at 09:03:11AM +0200, Ard Biesheuvel wrote:
> We don't actually use a global offset table (GOT) in the 32-bit

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

> diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> index 987ae727cf9f0d04..53cbee1e2a93efce 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -58,7 +58,7 @@ SYM_FUNC_START(startup_32)
>  	leal	(BP_scratch+4)(%esi), %esp
>  	call	1f
>  1:	popl	%edx
> -	addl	$_GLOBAL_OFFSET_TABLE_+(.-1b), %edx
> +	leal	(_GLOBAL_OFFSET_TABLE_ - 1b)(%edx), %edx

Yeah, that's a bit better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
