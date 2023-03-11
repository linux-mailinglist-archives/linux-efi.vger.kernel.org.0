Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843D16B5CF1
	for <lists+linux-efi@lfdr.de>; Sat, 11 Mar 2023 15:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCKOmt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Mar 2023 09:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCKOms (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Mar 2023 09:42:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5248A13D47;
        Sat, 11 Mar 2023 06:42:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC5FC60C74;
        Sat, 11 Mar 2023 14:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5015EC433A1;
        Sat, 11 Mar 2023 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678545764;
        bh=Urok4PcGPI2IQWfQn+1HYMcvD4HijH+RQr1qJ2Gegcw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q3HErYPeIPvEX4wjqfrzRNR8Hy/C1Ym8cc6ePhVKIOUt5EPIVogQV2UgAOFwOlRU5
         VwXx8wkWnD5o0jKV7OJP8Z7tiyVWbA3jpgA4cUofRVduJyJESzfK28zcyon7CCfmUz
         30z2Yy6q0HZpPswScHiMN3mFdk60yoBJbfLrPN2ivY0ykUcGOrmS0jpAhS8pgEmhEp
         XQ7RY0RaXG6/Il/Y0Ih0zmI04goUKTtB3M8KKuU7gikIIXU30mnQG8m7b5Rf6zbFWe
         54fjf3+f34mATO8Gvjo1HboFidI5Fv0P/H96t1zyaJb7DP3COegYCotj0TsfL7a8bU
         XMRRBXOEehdpg==
Received: by mail-lj1-f171.google.com with SMTP id a32so8320852ljq.1;
        Sat, 11 Mar 2023 06:42:44 -0800 (PST)
X-Gm-Message-State: AO0yUKUBamZxzjD2DLUslzx4mZOGGfDUywHHGqMaveuee4kQSK5OqXHb
        ow+VQdJB2sqmF2f+DrovjKI+g/EFzJXmHjC0sRc=
X-Google-Smtp-Source: AK7set/V1qUONTXCzyTUfCKUCTGR7HLLg1JMnaoaWjoS1H6r6Pqb1so6aNf3GEMZ3CEyeqLIxMis8PpJv10nBja3IgI=
X-Received: by 2002:a05:651c:11c6:b0:295:d460:5a2d with SMTP id
 z6-20020a05651c11c600b00295d4605a2dmr8998274ljo.2.1678545762309; Sat, 11 Mar
 2023 06:42:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <8211c633eb5dceeabee2996a4db91cd971cf7c77.1671098103.git.baskov@ispras.ru>
 <CAMj1kXFPtA4f3kW1U2-LAQFEuOvLsis=Ursj40xRrg-cvtK=gA@mail.gmail.com> <1df839eccd88063485d1702d5f98d5b8@ispras.ru>
In-Reply-To: <1df839eccd88063485d1702d5f98d5b8@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 11 Mar 2023 15:42:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHBMMr+EyEQxcn-P4DT+12aeUsbfPMzJB4NWtRqtKUTaQ@mail.gmail.com>
Message-ID: <CAMj1kXHBMMr+EyEQxcn-P4DT+12aeUsbfPMzJB4NWtRqtKUTaQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/26] x86/boot: Align vmlinuz sections on page size
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 11 Mar 2023 at 15:30, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2023-03-10 17:43, Ard Biesheuvel wrote:
> > On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >>
> >> To protect sections on page table level each section
> >> needs to be aligned on page size (4KB).
> >>
> >> Set sections alignment in linker script.
> >>
> >> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> >> Tested-by: Peter Jones <pjones@redhat.com>
> >> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> >> ---
> >>  arch/x86/boot/compressed/vmlinux.lds.S | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S
> >> b/arch/x86/boot/compressed/vmlinux.lds.S
> >> index 112b2375d021..6be90f1a1198 100644
> >> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> >> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> >> @@ -27,21 +27,27 @@ SECTIONS
> >>                 HEAD_TEXT
> >>                 _ehead = . ;
> >>         }
> >> +       . = ALIGN(PAGE_SIZE);
> >>         .rodata..compressed : {
> >> +               _compressed = .;
> >>                 *(.rodata..compressed)
> >
> > Can you just move this bit into the rodata section below?
>
> I don't think that easily possible, as the layout need
> to stay compatible with in-place extraction for non-UEFI boot.
> For that execution path the code in .head.text moves everything
> behind it to the end of the extraction buffer and extraction
> code overwrites compressed kernel blob progressively during
> extraction. And that is why we have effectively have two code
> sections...
>

A right - thanks for explaining that to me.

So in the end, I think it doesn't matter in any case if we just stick
to a single .text section with R-X attributes and a single .data
section with RW- attributes.


> >
> >> +               _ecompressed = .;
> >>         }
> >> +       . = ALIGN(PAGE_SIZE);
> >>         .text : {
> >
> > Please use
> >
> > .text : ALIGN(PAGE_SIZE) {
> >
> > which marks the section as being page aligned, rather than just being
> > placed on a 4k boundary.
>
> Will fix in v5.
>
> >
> >>                 _text = .;      /* Text */
> >>                 *(.text)
> >>                 *(.text.*)
> >>                 _etext = . ;
> >>         }
> >> +       . = ALIGN(PAGE_SIZE);
> >>         .rodata : {
> >>                 _rodata = . ;
> >>                 *(.rodata)       /* read-only data */
> >>                 *(.rodata.*)
> >>                 _erodata = . ;
> >>         }
> >> +       . = ALIGN(PAGE_SIZE);
> >>         .data : {
> >>                 _data = . ;
> >>                 *(.data)
> >> --
> >> 2.37.4
> >>
