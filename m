Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4179077146E
	for <lists+linux-efi@lfdr.de>; Sun,  6 Aug 2023 12:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjHFKVz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Aug 2023 06:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjHFKVy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Aug 2023 06:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE571BC2;
        Sun,  6 Aug 2023 03:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00FB561041;
        Sun,  6 Aug 2023 10:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63408C4339A;
        Sun,  6 Aug 2023 10:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691317310;
        bh=5MxN0ZEI3oscpBXHNaeo0xXUc0krIcllOd8IitDAOXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uafJ0QgmsAFeLeqLuvbtI/tAaTVRrwmMkeXtAGD8Md2MMg/TkR8ieB7x9qevNpTTR
         XifxV4+1exA/A4e0GVHJY/+nGViC2bcebPxLuWQfpNtGsxkv6WvHjLhdAdxPTR3c0b
         PcUS+nnKRMoHN9Cy3tZX1B591oLlKMipfWRiepu7fjGydw4LHpalrdYc8wgeMK4g8x
         VlLxfYqeZrbNewR/5ynQmYTdU9Np+MOt78DNpWlYhKH2VRyiO0J9JibZBt0mHXvi8s
         K4Yb6T2a1EJJh0zkO7biO/kMuNRmakMrRVMTrBA18MQKMb7v/xr+jI7emb11mG+OX8
         5GhJNXU6X6v/Q==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso5814250e87.0;
        Sun, 06 Aug 2023 03:21:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx56i6wZ9qS20twKuWS4eBC/iPQrWK4IxE8O/r1dApZwmx+WMrC
        qx3ZOfR72K1MAWzFyjy1mFPZxCUIUVBX/tCmgSs=
X-Google-Smtp-Source: AGHT+IEi9APuxkPXwmJBhseNBGKyi8NmGQdI5nwqKDTfqhHf2fVMHifhrclkg9am8TzdxkFkwK/poWzaNq0PsbT1+cQ=
X-Received: by 2002:a05:6512:3586:b0:4f4:d071:be48 with SMTP id
 m6-20020a056512358600b004f4d071be48mr3825926lfr.14.1691317308158; Sun, 06 Aug
 2023 03:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230802154831.2147855-1-ardb@kernel.org> <20230805144030.GDZM5fXvaqXBLxwXfj@fat_crate.local>
 <CAMj1kXEFC6LwNiWrGGsXot4SO0wivqN_3Yi=T9OS0XJ4=MeNew@mail.gmail.com>
 <20230805210631.GEZM6518W3qOCYYgNK@fat_crate.local> <CAMj1kXE+jgLztL1mQ6VDkJWfAjSJnxapoUAsvqaSQmfi=kr=hg@mail.gmail.com>
 <CAMj1kXHi8=L8e=a5ci4yQFVrc=XqqJaMNvZuPXduwaAVfmm4_Q@mail.gmail.com> <20230806101710.GAZM9zJjwoNKFSfWD6@fat_crate.local>
In-Reply-To: <20230806101710.GAZM9zJjwoNKFSfWD6@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 6 Aug 2023 12:21:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHnA=fNNpL47OFHcEs1Kr48YCnFYVE=AX+7o1YYVmCtCQ@mail.gmail.com>
Message-ID: <CAMj1kXHnA=fNNpL47OFHcEs1Kr48YCnFYVE=AX+7o1YYVmCtCQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/23] efi/x86: Avoid bare metal decompressor during
 EFI boot
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 6 Aug 2023 at 12:17, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Aug 06, 2023 at 12:05:25PM +0200, Ard Biesheuvel wrote:
> > I suspect this should fix the issue:
> >
> > --- a/arch/x86/kernel/head_64.S
> > +++ b/arch/x86/kernel/head_64.S
> > @@ -110,6 +110,7 @@ SYM_CODE_START_NOALIGN(startup_64)
> >          * programmed into CR3.
> >          */
> >         leaq    _text(%rip), %rdi
> > +       movq    %r15, %rsi
> >         call    __startup_64
>
> Yah, I was suspecting we're not passing boot_params properly somewhere.
> Aaand there it is.
>
> So yes, that fixes it.
>
> Lemme know when you've refreshed your branch so that I can continue
> testing.
>

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-efistub-cleanup-v9
