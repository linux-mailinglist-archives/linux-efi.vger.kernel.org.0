Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F4D2F851E
	for <lists+linux-efi@lfdr.de>; Fri, 15 Jan 2021 20:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbhAOTIR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Jan 2021 14:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbhAOTIQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Jan 2021 14:08:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F3CC061757;
        Fri, 15 Jan 2021 11:07:36 -0800 (PST)
Received: from zn.tnic (p200300ec2f0acf007cb1195bb528937a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:cf00:7cb1:195b:b528:937a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 407601EC041D;
        Fri, 15 Jan 2021 20:07:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610737654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IL2Li+VoVRz1ZLH8TsjVaWowu41cqfDQQ4xb4rgDPpA=;
        b=kQSTl2hcvjHob0BnMyXEr6Eg/al13WgaiP34iPoaRgs0W1J6aI+bls+yDp3r1c4akasNFw
        75cO1KAvTsPUw7GR6EO5eKIgygI7vnxCy4N5FjM6ZqZCgAFIpXqeO+7F/eScWqHIbmqoFY
        YBmUwIKxK4c4m74+QeRN86lcKEA5mJQ=
Date:   Fri, 15 Jan 2021 20:07:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <20210115190729.GE9138@zn.tnic>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <20210115182300.GD9138@zn.tnic>
 <20210115183203.GA1991122@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115183203.GA1991122@ubuntu-m3-large-x86>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 15, 2021 at 11:32:03AM -0700, Nathan Chancellor wrote:
> I triggered it with CONFIG_UBSAN=y + CONFIG_UBSAN_UNSIGNED_OVERFLOW=y
> (it can be exposed with an allyesconfig/allmodconfig on mainline
> currently).

Yah, I can trigger with that, thanks.

But I'll be damned, check this out:

clang preprocesses to this:

 do { extern void __compiletime_assert_332(void) ; if (!(!(p4d_index((-68 * ((1UL) << 30))) != p4d_index((0xffffffffff000000UL))))) __compiletime_assert_332(); } while (0);

The resulting asm is:

.LBB1_32:
        movabsq $-73014444032, %r13     # imm = 0xFFFFFFEF00000000
        testb   $1, %al
        jne     .LBB1_33
.LBB1_34:
        xorl    %r14d, %ebx
        testl   $33554431, %ebx         # imm = 0x1FFFFFF
        je      .LBB1_36
# %bb.35:
        callq   __compiletime_assert_332

so the undefined symbol is there, leading to:

ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
/home/boris/kernel/linux/arch/x86/platform/efi/efi_64.c:140: undefined reference to `__compiletime_assert_332'

Now look at gcc:

It preprocesses to:

 do { extern void __compiletime_assert_332(void) __attribute__((__error__("BUILD_BUG_ON failed: " "p4d_index(EFI_VA_END) != p4d_index(MODULES_END)"))); if (!(!(p4d_index((-68 * ((1UL) << 30))) != p4d_index((0xffffffffff000000UL))))) __compiletime_assert_332(); } while (0);


Resulting asm:

$ grep __compiletime_assert_332  arch/x86/platform/efi/efi_64.s
$

That thing has been optimized away!

Which means, those build assertions are gone on gcc and they don't catch
diddly squat. I sure hope I'm missing something here...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
