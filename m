Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A85BED7B
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 21:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiITTTR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 15:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiITTTQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 15:19:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1A261D68;
        Tue, 20 Sep 2022 12:19:14 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e791329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e791:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C7241EC01D4;
        Tue, 20 Sep 2022 21:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663701549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FEzgIy7+VixOuaBNBHyswL6EnQKt/p0p/2LZpYHPS9U=;
        b=mn7vCIJGvsWZLdM9xxpNou/6M4KSIPKPBzD8db6NOZvjnFqZi3TX9ksfL4zkdDNaH9Fh7D
        Jn0s9NdlwuKB0lAVopNcz9qg/ODzwUsB4YusCJF9hofr6XVkzS8isw3wie50qMYLIZi8dP
        Rc2aaia0xXB0QB6c9RB39MdDOyM9yGo=
Date:   Tue, 20 Sep 2022 21:19:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 1/6] x86/head_64: clean up mixed mode 32-bit entry code
Message-ID: <YyoSKYQFDiqcqXWA@zn.tnic>
References: <20220815134223.740112-1-ardb@kernel.org>
 <20220815134223.740112-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220815134223.740112-2-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 15, 2022 at 03:42:18PM +0200, Ard Biesheuvel wrote:
> The x86_64 32-bit entry code is a jumble of EFI and SEV routines, which
> is not good for maintainability. Let's isolate the EFI mixed mode code
> and combine it with the boot service thunk that lives in another .S
> file, so that we can remove it from head_64.S

Who is "we"?

Please use passive voice in all text.

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/Makefile       |   6 +-
>  arch/x86/boot/compressed/efi_mixed.S    | 358 ++++++++++++++++++++
>  arch/x86/boot/compressed/efi_thunk_64.S | 195 -----------
>  arch/x86/boot/compressed/head_32.S      |   4 -
>  arch/x86/boot/compressed/head_64.S      | 149 +-------
>  drivers/firmware/efi/libstub/x86-stub.c |   3 +-
>  6 files changed, 370 insertions(+), 345 deletions(-)

So I'm really nervous about patches touching early asm code where
multiple things happen all at once instead of each logical change being
split into a single patch: here I see code movement but then other
functionality is being added too.

So I'd really appreciate it if you split this one into smaller, obvious,
even boring patches - this will simplify review considerably. For
example, do only a mechanical code movement in one patch and then add
the new startup_64_mixedmode thing in another. And so on.

That would be greatly appreciated.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
