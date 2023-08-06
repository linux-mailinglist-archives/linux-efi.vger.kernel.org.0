Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59454771463
	for <lists+linux-efi@lfdr.de>; Sun,  6 Aug 2023 12:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHFKRp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Aug 2023 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHFKRp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Aug 2023 06:17:45 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46FC131;
        Sun,  6 Aug 2023 03:17:40 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 31DFC40E0191;
        Sun,  6 Aug 2023 10:17:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U1AK7kcEZdll; Sun,  6 Aug 2023 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691317055; bh=cGBlvXe5nfTxKa4rZNV7x1A+ypMAcyG/itGXCpuyhY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2rLiiVmk8WORAehH28yJ0e/Hir/x7xDeBqDfhnQkZ/KKxEzOebRhCZQggen0OH7k
         7wZp0JuS2cRcztbLdfd/1ibae4qxo9JiQSosgYtdxD6ApAnMphgXTCHY3ctOFFY2jg
         Mj/YVI33fJHYEVLPPDfnfNuV0eIEQ/mJiLMi59/GTzFuwIUYWYomqQmB4se54pJLFV
         +sXfkzFwJrAhW1NqRIuyXzQU+c7/dSxmgHVzsUk//A4XrsqeFIsJVDBXo7GHk5qffV
         6zGvUNOBJDEtJKmlcEvlfrVyEmT0OE534E6P+ghVsS01UUWtSYCJDxFr4SB1uurwKZ
         SiiyClnUkNJvlTLyPtw84CLQTdWgRA94PaC1SzEALTZS6xg9+7iQH5WhuSMWgR7RFj
         oduK64f+Y66j6w8HOq8acdBVB2YAqIgG9qzCjHhDUY/XuFx8l+6hZQubWCEKu+yvPl
         PahzDVPhr7TMJ0mAkNWwuIUuGh2lHc/kLjfLe0NWp3Hp00q96LgoPiczF+1X/x3B8J
         kerSfeq7OzpL2SFmH0JldMf96WtawdfYlUDMAa3LYGuYVvejdqwOeN8LnM3V5W3qtS
         l1EfoWandsOHrJvuJn3nYUyZEvIRYG/4p0enVh4Jta5/RpxEPCDZyu8zGWhmlKvTo3
         TB1hNs7qx+vShSHCRrDJHc7A=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A575440E0185;
        Sun,  6 Aug 2023 10:17:16 +0000 (UTC)
Date:   Sun, 6 Aug 2023 12:17:10 +0200
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
Subject: Re: [PATCH v8 00/23] efi/x86: Avoid bare metal decompressor during
 EFI boot
Message-ID: <20230806101710.GAZM9zJjwoNKFSfWD6@fat_crate.local>
References: <20230802154831.2147855-1-ardb@kernel.org>
 <20230805144030.GDZM5fXvaqXBLxwXfj@fat_crate.local>
 <CAMj1kXEFC6LwNiWrGGsXot4SO0wivqN_3Yi=T9OS0XJ4=MeNew@mail.gmail.com>
 <20230805210631.GEZM6518W3qOCYYgNK@fat_crate.local>
 <CAMj1kXE+jgLztL1mQ6VDkJWfAjSJnxapoUAsvqaSQmfi=kr=hg@mail.gmail.com>
 <CAMj1kXHi8=L8e=a5ci4yQFVrc=XqqJaMNvZuPXduwaAVfmm4_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHi8=L8e=a5ci4yQFVrc=XqqJaMNvZuPXduwaAVfmm4_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Aug 06, 2023 at 12:05:25PM +0200, Ard Biesheuvel wrote:
> I suspect this should fix the issue:
> 
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -110,6 +110,7 @@ SYM_CODE_START_NOALIGN(startup_64)
>          * programmed into CR3.
>          */
>         leaq    _text(%rip), %rdi
> +       movq    %r15, %rsi
>         call    __startup_64

Yah, I was suspecting we're not passing boot_params properly somewhere.
Aaand there it is.

So yes, that fixes it.

Lemme know when you've refreshed your branch so that I can continue
testing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
