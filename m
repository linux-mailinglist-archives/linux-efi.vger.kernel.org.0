Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5276CB39
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjHBKro (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 06:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjHBKrm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 06:47:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF18103;
        Wed,  2 Aug 2023 03:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AAC161910;
        Wed,  2 Aug 2023 10:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD478C433CD;
        Wed,  2 Aug 2023 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690973257;
        bh=A6vuhSEghmX/9x0Jw6AbTwio7Sk496g+SSjoZqziaRM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MbpBG6oS8ognEtAvko3wYiZciDFdMkO+bhmQ+q7W3xGtNZ2oL3hdB68wUYyCrdIeP
         QT3Jh4MAJPM7sdZ18Rby4F2IBCV+IjS4hJbbTazOU3vboA4a6D70ssXIk/Q64CAVV/
         tdO0XtL5FJeWpS6iF1ZsK2bvEjHfwoC0MDvtkjW/KQxUGGvH3fM+SF+wK6qGkiIKlp
         r2d5js5jM9L50olEVxXiFuHVDmPus/g/dO4yYZre+iz4xA7x7ArSh237CQYHG6CvpX
         cKqHB1ryry7F4eIU5WFu1umc2ZIj0Z3bf8ACbMUBNjwY6V2upZx1uZVtMl11hFt7wd
         z6lE0XV6AhoXg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe0e201f87so1021204e87.0;
        Wed, 02 Aug 2023 03:47:37 -0700 (PDT)
X-Gm-Message-State: ABy/qLZXuL0DYKcuuALvkC209KI6RyNrERNBJ1VUviH049pqzw2A3I47
        OgHx56s0btHAmE3iuhu2gguhXWSmQDanw07aJLs=
X-Google-Smtp-Source: APBJJlG/L1ZeTXYXTUdvTu3JwLhDDxBKCQuHkBfDIbbthjCvbmYZwfRlEgbHYd3/8qTMAfJN/PFPbVqD+vflkvn/8pI=
X-Received: by 2002:ac2:465e:0:b0:4f9:5693:3d2c with SMTP id
 s30-20020ac2465e000000b004f956933d2cmr1766319lfo.34.1690973255688; Wed, 02
 Aug 2023 03:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230728090916.1538550-1-ardb@kernel.org> <20230728090916.1538550-23-ardb@kernel.org>
 <20230802102600.GIZMovOIUDAJAXu0F5@fat_crate.local>
In-Reply-To: <20230802102600.GIZMovOIUDAJAXu0F5@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Aug 2023 12:47:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH9f+xXe3j3Bx-tku8k9eiWO_BVw70ePbfEft4stxjjgw@mail.gmail.com>
Message-ID: <CAMj1kXH9f+xXe3j3Bx-tku8k9eiWO_BVw70ePbfEft4stxjjgw@mail.gmail.com>
Subject: Re: [PATCH v7 22/22] x86/efistub: Avoid legacy decompressor when
 doing EFI boot
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2 Aug 2023 at 12:26, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jul 28, 2023 at 11:09:16AM +0200, Ard Biesheuvel wrote:
> > The bare metal decompressor code was never really intended to run in a
> > hosted environment such as the EFI boot services, and does a few things
> > that are problematic in the context of EFI boot now that the logo
> > requirements are getting tighter.
>
> Please spend a sentence or two explaining those. After some time has
> passed, no one will remember what that tightening of the requirements
> was.
>

OK. The next paragraph already covers this to some extent, but i'll
add some more prose here to clarify it further.

> So yeah, other than those minor nitpicks, I like the thing, all in all.
>

Good.

> Pls send v8 so that I can run it here on my machines. A git branch would
> be cool too.
>

OK

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-efistub-cleanup-v8

I'll prepare the v8 based on this branch after doing some more tests
on bare metal. I'll probably send it out later today.

> As to merging this, I presume you want it to go through tip?
>

It depends on the timing. If we take the whole thing now, it should
ideally go through -tip.

There is a conflict with the kexec sev patch you just suggested on the
list, though. I'll rebase onto that in any case, but if that causes
any problems, we might decide to take everything except the last two
(or three *) patches now, and defer those for later.

* 'efi/libstub: Add limit argument to efi_random_alloc()' may conflict
with some changes that may arrive via the RISC-V tree. That patch is
completely independent, so perhaps I should put it on a shared stable
branch in the EFI tree. Or alternatively, depending on how you decide
to organize the branches, you could put it at the beginning of the
topic branch where the RISC-V tree can merge it in.

Or we might just ignore the conflict - it just adds a function
argument to a function call that gets moved from one source file to
the another in the conflicting branch, so it should be rather
straight-forward to resolve.
