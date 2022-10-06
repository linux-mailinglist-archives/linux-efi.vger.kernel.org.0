Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0E5F6477
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 12:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJFKm2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 06:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiJFKm0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 06:42:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9BC8C446;
        Thu,  6 Oct 2022 03:42:24 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e732329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e732:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 497A11EC0628;
        Thu,  6 Oct 2022 12:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665052939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+pCJrtOwK+Uo2UQpXTLUgG0fyVzkU2Sjv8mXeksdilA=;
        b=L+dsRHI8jyAjyyVmODg/+gLiUkxWMamXrTnkeNjcGuJgn4kuABa+mkwCpkheF4i+9Mzd8a
        z1jVTF9427aKhpiJnS770wCeW2Vj84/x3vzsyMTCfjYPM7hGxDU4wPOM3ZLtbkYPje2HjV
        yLDZFYkFncHSpqRoEFmj+SibM7Qt7Wg=
Date:   Thu, 6 Oct 2022 12:42:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 02/16] x86/compressed: efi-mixed: move 32-bit
 entrypoint code into .text section
Message-ID: <Yz6xBROUBPyaUSoB@zn.tnic>
References: <20220921145422.437618-1-ardb@kernel.org>
 <20220921145422.437618-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921145422.437618-3-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 21, 2022 at 04:54:08PM +0200, Ard Biesheuvel wrote:
> Move the code that stores the arguments passed to the EFI entrypoint
> into the .text section, so that it can be moved into a separate
> compilation unit in a subsequent patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/head_64.S | 34 ++++++++++++--------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index d33f060900d2..1ba2fc2357e6 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -303,24 +303,28 @@ SYM_FUNC_START(efi32_stub_entry)
>  	popl	%ecx
>  	popl	%edx
>  	popl	%esi
> +	jmp	efi32_entry
> +SYM_FUNC_END(efi32_stub_entry)
>  
> +	.text
> +SYM_FUNC_START_LOCAL(efi32_entry)
>  	call	1f
> -1:	pop	%ebp
> -	subl	$ rva(1b), %ebp
> -
> -	movl	%esi, rva(efi32_boot_args+8)(%ebp)
> -SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
> -	movl	%ecx, rva(efi32_boot_args)(%ebp)
> -	movl	%edx, rva(efi32_boot_args+4)(%ebp)
> -	movb	$0, rva(efi_is64)(%ebp)
> +1:	pop	%ebx

I'm guessing according to the EFI mixed mode calling convention, %ebx is
not a live register which gets overwritten here...?

Looking at efi32_pe_entry() from where this is called, %ebx looks live.

What am I missing?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
