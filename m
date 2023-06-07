Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75F97269F7
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 21:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjFGTjt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 15:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjFGTjr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 15:39:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7111FF9;
        Wed,  7 Jun 2023 12:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B9E7639C1;
        Wed,  7 Jun 2023 19:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08220C4339B;
        Wed,  7 Jun 2023 19:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686166775;
        bh=AKTymSRstky51rNcwFMqSebZvlyLOHkg+jOGR6m7xeM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l2GixvRScrPgsV3RnFaui8KLFVQvxnxQsemEPkHSQt4q96h2QvM9aDQDcUFAQEyL9
         t7ylzH0KJ2OFxYsXqBUcM5pIcviwAxCpAOvdFAI1Wo4QAZV0mush0NGChegGgx76Cz
         M7PVlP34LQcds/cO12rZCu5IJA2MBosjFqbvnnlsosKAyOMS8Y+HWXqwzU/KdHr12t
         9GYy0Rd+y5dXStjYRS7TepwGTXeWP5gCAiAlG3wCdAUQkUJjBjnhPzXFIiSYRboKlT
         olcCkuWgVdZuk9TA5gFUyhWzBbhhK6sifiS0sN22hlBTF2Eecv3GudMoL/r1f4weQF
         rUl7VRCpkdW8g==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b203360d93so10105031fa.3;
        Wed, 07 Jun 2023 12:39:34 -0700 (PDT)
X-Gm-Message-State: AC+VfDwhWUn14AXzC/U8H63vL/WBsf2TmNaR1gteZFK6Mu2I4EFq59hx
        q6lNJ2tAvMudk4JyG/fG4tG1hbVb5VMN9l6Cl/E=
X-Google-Smtp-Source: ACHHUZ44Q2SRLqBfw3pNCr1fipyVC+3FNJnXjMQijwLy8IatrbI/7m84kx3V+0+FRSNhsPzuUy7vxD+fzXG0IFLBPTY=
X-Received: by 2002:a2e:6e13:0:b0:2a8:e480:a3c8 with SMTP id
 j19-20020a2e6e13000000b002a8e480a3c8mr2488721ljc.44.1686166772946; Wed, 07
 Jun 2023 12:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230607072342.4054036-1-ardb@kernel.org> <20230607072342.4054036-2-ardb@kernel.org>
 <20230607185301.GNZIDSDWX8xnTaeENe@fat_crate.local>
In-Reply-To: <20230607185301.GNZIDSDWX8xnTaeENe@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 7 Jun 2023 21:39:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH=GXAktkcubpFLKuSV84Yi5fcZREPxFHyT2EtQaMAR2w@mail.gmail.com>
Message-ID: <CAMj1kXH=GXAktkcubpFLKuSV84Yi5fcZREPxFHyT2EtQaMAR2w@mail.gmail.com>
Subject: Re: [PATCH v5 01/20] x86/efistub: Branch straight to kernel entry
 point from C code
To:     Borislav Petkov <bp@alien8.de>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 7 Jun 2023 at 20:53, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jun 07, 2023 at 09:23:23AM +0200, Ard Biesheuvel wrote:
> > -     return bzimage_addr;
> > +     if (IS_ENABLED(CONFIG_X86_64))
> > +             /* add offset of startup_64() */
> > +             bzimage_addr += 0x200;
>
> Uh, magic.
>
> Well, there's this:
>
> arch/x86/boot/compressed/head_64.S:
>
>         .code64
>         .org 0x200
> SYM_CODE_START(startup_64)
>         /*
>          * 64bit entry is 0x200 and it is ABI so immutable!
>          * We come here either from startup_32 or directly from a
>          * 64bit bootloader.
>
>
> Looking at Documentation/arch/x86/boot.rst, we actually say in the
> xloadflags section:
>
>   Bit 0 (read): XLF_KERNEL_64
>
>         - If 1, this kernel has the legacy 64-bit entry point at 0x200.
>
> and header.S sets that:
>
> xloadflags:
> #ifdef CONFIG_X86_64
> # define XLF0 XLF_KERNEL_64                     /* 64-bit kernel */
>
> so you checking CONFIG_X86_64 is probably ok.
>
> It might be cleaner, though, if you test XLF_KERNEL_64 directly and act
> accordingly, although, do I understand it correctly, that the EFI
> libstub goes together with the kernel it was built for so the checks
> would be doing the same thing...? I.e., the libstub cannot be somehow
> "glued" with another kernel or so, which doesn't set CONFIG_X86_64.
>

This code gets removed again later in the series, so i didn't bother
with any of this.

I think checking those XLF flags from code is something to avoid in
any case - it is part of the file representation, and consumed by
loaders. I am not sure we can assume that they are always accessible
from the running code (and EFI is not guaranteed to load the first
sector as this is the file header not the payload)
