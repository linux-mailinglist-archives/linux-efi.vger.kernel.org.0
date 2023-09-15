Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93A97A1FD3
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 15:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbjION2x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 09:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjION2w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 09:28:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D9310D;
        Fri, 15 Sep 2023 06:28:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65863C43391;
        Fri, 15 Sep 2023 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694784527;
        bh=eLQxZiO1BkR+sY4fxTC6o/C0cAQMWJdVQ03PQW8hiJ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dT7bh/C+vY5bumGsJ9I2oPQ8SwFPLK8948IJ5WxjSjcwf7umhtduJE4+ypADyZUY4
         gHk0AWBpdz3RSgJ1lvKANgqy+8GihJnn9xMrFKP2x+4ZqzY0Jnb3uodsG8BL0btm2O
         7s8nVsU/xdLzcVExejFUNjDXLQU35deIMjECJvpI5hSmqCOPRn/VvkfX10+cnHehRL
         3oy8nQPTA5AvYMSrsRZ2K63T2Rr0x8edVuPJ4uQVsPIvH/fzG7a6e90OGwNHAiHMr3
         5Oqiwq2I0Kg4a6/Gsuxlk7GxOLrKbDsvyQs8qYZHo58SZGtYKUytW8m69LB9Vw9gpH
         r8hWj5LkKdo+A==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so34307261fa.2;
        Fri, 15 Sep 2023 06:28:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YxIhlojuoDwUfHIkQbW7PjHVqJF7lQ+65+AUB+8Tvnzb8JxFfUg
        VsGs/0gt+2B0WPSMCe3Wfc45m5lkzjVW68e/P7Q=
X-Google-Smtp-Source: AGHT+IGwj9C8NtjcJgz1Z6cunlHMwP39m/mnZKmUtiY92Y/OutXdxanFxtqRFk6O6qxzPn9l8yXbimkRM73Xsba4wM8=
X-Received: by 2002:a2e:9c85:0:b0:2bc:c326:54a2 with SMTP id
 x5-20020a2e9c85000000b002bcc32654a2mr1416500lji.50.1694784525534; Fri, 15 Sep
 2023 06:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com> <ZQQiUxh5vmeZnp7s@gmail.com>
 <ZQRAckHVxQZRNEGA@gmail.com> <CAGnOC3Zw49_30FkGY=RRLn-sCHNgFY_T0ugNJZCgg_T3opHm+Q@mail.gmail.com>
In-Reply-To: <CAGnOC3Zw49_30FkGY=RRLn-sCHNgFY_T0ugNJZCgg_T3opHm+Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Sep 2023 15:28:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEVA5iL79HwXdYOAXAr0ZemS6repMRi9b20VSU=u0Ee=Q@mail.gmail.com>
Message-ID: <CAMj1kXEVA5iL79HwXdYOAXAr0ZemS6repMRi9b20VSU=u0Ee=Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
To:     Ard Biesheuvel <ardb@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 15 Sept 2023 at 15:21, Ard Biesheuvel <ardb@google.com> wrote:
>
> On Fri, Sep 15, 2023 at 1:31=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wr=
ote:
> >
> >
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> > > > Ard Biesheuvel (15):
> > > >   x86/efi: Drop EFI stub .bss from .data section
> > > >   x86/efi: Disregard setup header of loaded image
> > > >   x86/efi: Drop alignment flags from PE section headers
> > > >   x86/boot: Remove the 'bugger off' message
> > > >   x86/boot: Omit compression buffer from PE/COFF image memory footp=
rint
> > > >   x86/boot: Drop redundant code setting the root device
> > > >   x86/boot: Grab kernel_info offset from zoffset header directly
> > > >   x86/boot: Drop references to startup_64
> > >
> > > I've applied these first 8 patches to tip:x86/boot with minor edits.
>
> Thanks.
>
> > > (Please preserve existing comment capitalization conventions ...)
> > >
>
> Ack
>
> > > >   x86/boot: Set EFI handover offset directly in header asm
> > > >   x86/boot: Define setup size in linker script
> > > >   x86/boot: Derive file size from _edata symbol
> > > >   x86/boot: Construct PE/COFF .text section from assembler
> > > >   x86/boot: Drop PE/COFF .reloc section
> > > >   x86/boot: Split off PE/COFF .data section
> > > >   x86/boot: Increase section and file alignment to 4k/512
> > >
> > > The rest conflicted with recent upstream changes, and I suppose it's
> > > prudent to test these changes bit by bit anyway.
> >
>
> Agreed. So you mean this conflicts with other stuff queued up in -tip
> already, right?
>
> > So, the first 8 patches broke the x86-64-defconfig-ish Qemu bzImage boo=
tup,
> > due to the 8th patch:
> >
> >   988b52b207a9fe74c3699bda8c2256714926b94b is the first bad commit
> >   commit 988b52b207a9fe74c3699bda8c2256714926b94b
> >   Author: Ard Biesheuvel <ardb@kernel.org>
> >   Date:   Tue Sep 12 09:01:01 2023 +0000
> >
> >       x86/boot: Define setup size in linker script
> >
> > I've removed it for now - but this side effect was not expected.
> >
>
> No, definitely not expected. I tested various combinations of i386 /
> x86_64 built with GCC / Clang doing EFI or BIOS boot.
>
> I'll rebase the remaining stuff onto -tip and see if I can reproduce this=
.

This is actually quite bizarre. x86_64_defconfig has
CONFIG_EFI_MIXED=3Dy and i tested that this change produces the exact
same bzImage binary in that case.

Could you send me the .config and the QEMU command line perhaps?
