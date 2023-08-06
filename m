Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4522B77144C
	for <lists+linux-efi@lfdr.de>; Sun,  6 Aug 2023 12:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjHFKFl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Aug 2023 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHFKFk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Aug 2023 06:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F08611D;
        Sun,  6 Aug 2023 03:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5D361028;
        Sun,  6 Aug 2023 10:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6D7C433CB;
        Sun,  6 Aug 2023 10:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691316338;
        bh=VZ5GVUQPDjKt21Zcn+VayYYZpoqhGa0Z+aHB0bMUUEE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lH0B0hdjiIWlp6CXWjQetMdNHOyNDR/0mCFj4XqeiC6EVqqN9c/v4N9gYFKYhpwca
         rh8k2rpj1y1ClWARKygabscnzh33tNHFzg69DvkN9tcJZhrWVGL/SHTELCe3o1MH+D
         i7BiaeXe9oP9oMjCJZeJSvRVeaics0MjRKXhDjQfPBHnc4j5MikUJ3JJ97htx/EHc2
         OHEib2WmC87KxdKavLuutDOXaDh9TTSDxEmkeE1H0mx6YtCbgfliEbkLgU6ENlq1lk
         hBKLOS5kV5LNiM3fUSX+u7CdrXgij/xOfYmFfIohrmtsKaGqwGcR0rWzMbOgM2zqUe
         4uLUN5XqHMLqA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so5914574e87.3;
        Sun, 06 Aug 2023 03:05:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YzNopJK08yU4h+ETT1YdVkezoYIuC/glEvIniiXyBYtL16XI84w
        sboPRQ1nIK1cgzfk1L8n0a9MRcRHnP1GA+RzcVw=
X-Google-Smtp-Source: AGHT+IFzzdaH9mDAtHXdlVGRxkOmKkpd/ElQCYQum/OtJBPCDy/KpyZYX3ILQlkaTQo3lLu38SrMDekJYWYqW6ig3nk=
X-Received: by 2002:ac2:5937:0:b0:4f8:7551:7485 with SMTP id
 v23-20020ac25937000000b004f875517485mr3446727lfi.5.1691316336624; Sun, 06 Aug
 2023 03:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230802154831.2147855-1-ardb@kernel.org> <20230805144030.GDZM5fXvaqXBLxwXfj@fat_crate.local>
 <CAMj1kXEFC6LwNiWrGGsXot4SO0wivqN_3Yi=T9OS0XJ4=MeNew@mail.gmail.com>
 <20230805210631.GEZM6518W3qOCYYgNK@fat_crate.local> <CAMj1kXE+jgLztL1mQ6VDkJWfAjSJnxapoUAsvqaSQmfi=kr=hg@mail.gmail.com>
In-Reply-To: <CAMj1kXE+jgLztL1mQ6VDkJWfAjSJnxapoUAsvqaSQmfi=kr=hg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 6 Aug 2023 12:05:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHi8=L8e=a5ci4yQFVrc=XqqJaMNvZuPXduwaAVfmm4_Q@mail.gmail.com>
Message-ID: <CAMj1kXHi8=L8e=a5ci4yQFVrc=XqqJaMNvZuPXduwaAVfmm4_Q@mail.gmail.com>
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

On Sun, 6 Aug 2023 at 00:19, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 5 Aug 2023 at 23:07, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Sat, Aug 05, 2023 at 07:37:17PM +0200, Ard Biesheuvel wrote:
> > > So this is the host booting, right?
> >
> > Yes.
> >
> > > So is the position of the C bit perhaps getting detect incorrectly?
> >
> > I don't know yet. But the evildoer is someone else:
> >
> > 02d47ce2ae02 ("x86/head_64: Store boot_params pointer in callee save register")
> >
> > after bisection. More staring later as to why...
> >
>
> How bizarre.
>
> But that was a bonus patch anyway, so we could just drop it for now.

I suspect this should fix the issue:

--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -110,6 +110,7 @@ SYM_CODE_START_NOALIGN(startup_64)
         * programmed into CR3.
         */
        leaq    _text(%rip), %rdi
+       movq    %r15, %rsi
        call    __startup_64

        /* Form the CR3 value being sure to include the CR3 modifier */
