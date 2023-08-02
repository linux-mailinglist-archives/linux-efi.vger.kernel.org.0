Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DCC76D30C
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 17:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjHBPzu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 11:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjHBPze (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 11:55:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C6E2701;
        Wed,  2 Aug 2023 08:55:25 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7865F1EC053F;
        Wed,  2 Aug 2023 17:55:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690991724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4Ix5zDGj/AnSytX9MQHc5/WTKPNGfN8exUCjp+sgZ80=;
        b=Xj3xxvmGvhJt/U23Kc8ElpFtFbhpZjmlF9CFWGNhBmQfogIaJCUdYE4PnPs4vmcE51BtZr
        08j6VPEE667AAxouDs7nf/CtCkZ46VxTRe5ZomHQTeOI1EjkIej9qKt13IfAq0K96MBP2X
        IyKfRB2q00uXUFDu0BOOcr7nk9WelyA=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0Qx9PwxlHf18; Wed,  2 Aug 2023 15:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690991721; bh=4Ix5zDGj/AnSytX9MQHc5/WTKPNGfN8exUCjp+sgZ80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kz64U4MONqF0z/eLh63O76J8JHb0SCKmXIbAVHS/+eVoWHvfhFVe0tug9D5PDjYlv
         8ZvZ97hTdSyLDJUrVk23joB4o7ekENAxFGO+c2qMOx70ERSIR3/ayQZNkCualAvBN9
         FAN6MvpQzoA3ljQPh13rCTt8xkjy0HA4BMgm/x7i7HBHTIbnUGuXNf5hhB9bhGRBBd
         ewA2q3hagiVF0WumZW1MKk+QV7RRdO1+SmTLh2D/BLXLADgthe78FuD9n+n6JW361j
         vmDF/N51bJ1VdF/+ahH5XgAys7OPJDNNOcnuQnzZN6TnyUdMQtWLsv0cW/KKlKzLN5
         Po+/VLpVLrx+U8sQdfMVgmdRPUjCjdmERKjAiW9DAB14zgo8ItLt3xfrKLWfyWqrLa
         PTqLnuDf9uLDu3zXpQuZEiUrEf2s0AEZ7PEy/Mtkv6HGEDwBl4pocdnQQXu1Q0NMHx
         Kygf7sYD58H1HC3PF/gOWCDeolpdeqcbfL9SyxFWTv5U/DZbYlYkHviUX6ZRs1Qj7P
         cY0JplgCIG3L7RiR+Twkvh7+19HknNdqzD1NRfZ3pm48TW3pvqYzOEe6BCxug5rDyf
         rTpruCyRy8JvKBWVDLycg8gzmhkpqj9mrptHtxAYUokR/4OxrKXGWU2yYQ5+TeJaEf
         KC3sLyKP/cCLK8ul2OqBFTW0=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E4EA40E01FF;
        Wed,  2 Aug 2023 15:55:02 +0000 (UTC)
Date:   Wed, 2 Aug 2023 17:55:01 +0200
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
Subject: Re: [PATCH v7 22/22] x86/efistub: Avoid legacy decompressor when
 doing EFI boot
Message-ID: <20230802155501.GDZMp8VfLCXCJog+vt@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-23-ardb@kernel.org>
 <20230802102600.GIZMovOIUDAJAXu0F5@fat_crate.local>
 <CAMj1kXH9f+xXe3j3Bx-tku8k9eiWO_BVw70ePbfEft4stxjjgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXH9f+xXe3j3Bx-tku8k9eiWO_BVw70ePbfEft4stxjjgw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 02, 2023 at 12:47:24PM +0200, Ard Biesheuvel wrote:
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-efistub-cleanup-v8
> 
> I'll prepare the v8 based on this branch after doing some more tests
> on bare metal. I'll probably send it out later today.

Thx, I'll run it here too.

> It depends on the timing. If we take the whole thing now, it should
> ideally go through -tip.

Now's fine, if it passes testing.

> There is a conflict with the kexec sev patch you just suggested on the
> list, though. I'll rebase onto that in any case, but if that causes
> any problems, we might decide to take everything except the last two
> (or three *) patches now, and defer those for later.

Right.

> * 'efi/libstub: Add limit argument to efi_random_alloc()' may conflict
> with some changes that may arrive via the RISC-V tree. That patch is
> completely independent, so perhaps I should put it on a shared stable
> branch in the EFI tree. Or alternatively, depending on how you decide
> to organize the branches, you could put it at the beginning of the
> topic branch where the RISC-V tree can merge it in.

I could simply give them the tip branch with the stuff and they can
merge it. It'll be immutable ofc.

> Or we might just ignore the conflict - it just adds a function
> argument to a function call that gets moved from one source file to
> the another in the conflicting branch, so it should be rather
> straight-forward to resolve.

That's also a possibility.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
