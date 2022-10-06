Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E3C5F64C0
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJFLDN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJFLDM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 07:03:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96783F25;
        Thu,  6 Oct 2022 04:03:11 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e732329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e732:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 357151EC0409;
        Thu,  6 Oct 2022 13:03:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665054186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lI2U8GUzh56RaXmUbzcG4s1t1kCj4GC+HIaGfQgEczQ=;
        b=Q9FGB2RHtc5XLgiBhHeuiAF3alhbaXqshtYmVOXu46ogUed/6VjX6WwCC/3r0Z4toUaLCM
        ooVpczIDhlmyJ/I/X6GQmMcQee93RgIhxfvDuCmGfatt3vYKIs3LfsAm3k+BxAy+ExslgF
        CDaUcQSilycXnf/7auZadzF7H56K0Sk=
Date:   Thu, 6 Oct 2022 13:03:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 03/16] x86/compressed: efi-mixed: move bootargs
 parsing out of 32-bit startup code
Message-ID: <Yz615Qc1K284jlH9@zn.tnic>
References: <20220921145422.437618-1-ardb@kernel.org>
 <20220921145422.437618-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921145422.437618-4-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 21, 2022 at 04:54:09PM +0200, Ard Biesheuvel wrote:
> Move the logic that chooses between the different EFI entrypoints out of
> the 32-bit boot path, and into a 64-bit helper that can perform the same
> task much more cleanly. While at it, document the mixed mode boot flow
> in a code comment.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/efi_mixed.S | 43 ++++++++++++++++++++
>  arch/x86/boot/compressed/head_64.S   | 24 ++---------
>  2 files changed, 47 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
> index 67e7edcdfea8..77e77c3ea393 100644
> --- a/arch/x86/boot/compressed/efi_mixed.S
> +++ b/arch/x86/boot/compressed/efi_mixed.S
> @@ -22,6 +22,49 @@
>  
>  	.code64
>  	.text
> +/*
> + * When booting in 64-bit mode on 32-bit EFI firmware, startup_64_mixedmode()
> + * is the first thing that runs after switching to long mode. Depending on
> + * whether the EFI handover protocol or the compat entry point was used to
> + * enter the kernel, it will either branch to the 64-bit EFI handover
> + * entrypoint at offset 0x390 in the image, or to the 64-bit EFI PE/COFF
> + * entrypoint efi_pe_entry(). In the former case, the bootloader must provide a
> + * struct bootparams pointer as the third argument, so the presence of such a
> + * pointer is used to disambiguate.
> + *
> + *                                                             +--------------+
> + *  +------------------+     +------------+            +------>| efi_pe_entry |
> + *  | efi32_pe_entry   |---->|            |            |       +-----------+--+
> + *  +------------------+     |            |     +------+---------------+   |
> + *                           | startup_32 |---->| startup_64_mixedmode |   |
> + *  +------------------+     |            |     +------+---------------+   V
> + *  | efi32_stub_entry |---->|            |            |     +------------------+
> + *  +------------------+     +------------+            +---->| efi64_stub_entry |
> + *                                                           +-------------+----+
> + *                           +------------+     +----------+               |
> + *                           | startup_64 |<----| efi_main |<--------------+
> + *                           +------------+     +----------+
> + */

That is much appreciated.

Questions:

- is this whole handover ABI documented somewhere?

- efi32_pe_entry() is the 32-bit PE/COFF entry point? I.e., that is
called by a 32-bit EFI fw when the kernel is a PE/COFF executable?

But then Documentation/admin-guide/efi-stub.rst talks about the EFI stub
and exactly that. Hmm, so what is efi32_pe_entry() then?

> +SYM_FUNC_START(startup_64_mixedmode)

	... mixed_mode

I guess.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
