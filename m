Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF670726937
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 20:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjFGSxP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 14:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjFGSxO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 14:53:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699301BD0;
        Wed,  7 Jun 2023 11:53:07 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFB331EC0644;
        Wed,  7 Jun 2023 20:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686163986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=87vpP2FfhEOM4xjMq++nbMOrXdUL3e/0f37LDZIuVR8=;
        b=ERwufKKmWtcbgPK1Xk07JYe/m8a54Yi61aPOobv8YI2WI6erMC+W/mB4yjq9xGDlaFkEtr
        QP6C48I4kAyDr9Lvo30Aq1fmXW68M1RTjRhOuIdEwLywjpvV8XCpfkGB13OfigR37LZGk1
        XenyO7Z2aMC3GVrT4lcPP1rTNkDG4FI=
Date:   Wed, 7 Jun 2023 20:53:01 +0200
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
Subject: Re: [PATCH v5 01/20] x86/efistub: Branch straight to kernel entry
 point from C code
Message-ID: <20230607185301.GNZIDSDWX8xnTaeENe@fat_crate.local>
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607072342.4054036-2-ardb@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 07, 2023 at 09:23:23AM +0200, Ard Biesheuvel wrote:
> -	return bzimage_addr;
> +	if (IS_ENABLED(CONFIG_X86_64))
> +		/* add offset of startup_64() */
> +		bzimage_addr += 0x200;

Uh, magic.

Well, there's this:

arch/x86/boot/compressed/head_64.S:

        .code64
        .org 0x200
SYM_CODE_START(startup_64)
        /*
         * 64bit entry is 0x200 and it is ABI so immutable!
         * We come here either from startup_32 or directly from a
         * 64bit bootloader.


Looking at Documentation/arch/x86/boot.rst, we actually say in the
xloadflags section:

  Bit 0 (read): XLF_KERNEL_64

        - If 1, this kernel has the legacy 64-bit entry point at 0x200.

and header.S sets that:

xloadflags:
#ifdef CONFIG_X86_64
# define XLF0 XLF_KERNEL_64                     /* 64-bit kernel */

so you checking CONFIG_X86_64 is probably ok.

It might be cleaner, though, if you test XLF_KERNEL_64 directly and act
accordingly, although, do I understand it correctly, that the EFI
libstub goes together with the kernel it was built for so the checks
would be doing the same thing...? I.e., the libstub cannot be somehow
"glued" with another kernel or so, which doesn't set CONFIG_X86_64.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
