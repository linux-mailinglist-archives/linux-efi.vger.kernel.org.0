Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F696E8BE1
	for <lists+linux-efi@lfdr.de>; Thu, 20 Apr 2023 09:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjDTHzJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Apr 2023 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjDTHzG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Apr 2023 03:55:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F626A1;
        Thu, 20 Apr 2023 00:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E162E64597;
        Thu, 20 Apr 2023 07:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B675C4339E;
        Thu, 20 Apr 2023 07:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681977294;
        bh=3dYxAbM0w2YLQKaBeIxofMwdEi0b0oi41zlv3iCrZs0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n9uvuF+GTTIknFp9X9VVJT1nxenZWRM267yHoad/8l0gFlj8Ud9BaiM785y/xK1Go
         brC6b3chkMeqoVjzkQHFB3Y3vpzz0yIsj9b0dD+3BSwlojO6UObKTc3Yrt65H/DTyn
         Qf6LbxRWb8OImxpNIbUhr7P+rVIOAN3AXla0+1uPYuLxZvquOTUkhj8E0VKx4NCP1e
         8TXwkkbDbedfnQYre/N0sg60fn9U2M1tMuUGRjjQuH9/S2M3hsP9Cj8lCQfG3nTkcp
         v50QvHCXmM1H9zA/GjjaxfuzRRYkdLgmXpU7ngYDI3ONY6EK05b47F3zUTF7qcTKm5
         isaM6u1y8AOFQ==
Received: by mail-lj1-f172.google.com with SMTP id h2so1735316ljh.13;
        Thu, 20 Apr 2023 00:54:54 -0700 (PDT)
X-Gm-Message-State: AAQBX9ebofRu6YnROtbcp2KPVMwovls2SFRyUH5xqpMKxD+It0SBflxM
        GgjE6XenM2TvQ0jTDE9a/HxnJWF4A+xrD2hOUus=
X-Google-Smtp-Source: AKy350Yf4xK1Q1jI+9d+7IlGT/7hCmLTr54srLNZb/aWfb5zgO4m8vL/5+Bsd6JED/03vQSAhtNns4ZyVVgdOl10xtk=
X-Received: by 2002:a05:651c:21c:b0:2a7:6f60:34f2 with SMTP id
 y28-20020a05651c021c00b002a76f6034f2mr160131ljn.33.1681977292253; Thu, 20 Apr
 2023 00:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230416120729.2470762-1-ardb@kernel.org> <jwvybt4sro56aiqvddn6jxdjpdelasdhl747c25kzv4vbjr7ph@fbtheokrtxce>
 <CAMj1kXE4xF9RJbaR0H6uuFxxroUJxQFo8WThb=SUa7H0OpDxUg@mail.gmail.com> <3zm36sbx4enlqaumxxz2gp3f6etwzhlfotqrqxsus2r6xulwvm@saqniauxenmi>
In-Reply-To: <3zm36sbx4enlqaumxxz2gp3f6etwzhlfotqrqxsus2r6xulwvm@saqniauxenmi>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Apr 2023 09:54:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF1eaORsUPk=8Mam8OCQbfcMEBca=Lr2tdN=nihiDqb=Q@mail.gmail.com>
Message-ID: <CAMj1kXF1eaORsUPk=8Mam8OCQbfcMEBca=Lr2tdN=nihiDqb=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] efi: Implement generic zboot support
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Thu, 20 Apr 2023 at 08:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Realistically, the second option is unlikely to ever be used on x86,
> > >
> > > What would be needed to do so?  Teach kexec-tools and grub2 parse and
> > > load zboot kernels I guess?
> >
> > I already implemented this for mach-virt here, so we can load Fedora
> > kernels without firmware:
> >
> > https://gitlab.com/qemu-project/qemu/-/commit/ff11422804cd03494cc98691eecd3909ea09ab6f
> >
> > On arm64, this is probably more straight-forward, as the bare metal
> > image is already intended to be booted directly like that. However,
> > the x86 uncompressed image requires surprisingly little from all the
> > boot_params/setup_header cruft to actually boot, so perhaps there it
> > is easy too.
>
> For existing boot loaders like grub I'd expect it being easy
> to code up, all the setup header code exists already, grub also
> has support for uncompressing stuff, so it should really be only
> zboot header parsing and some plumbing to get things going (i.e.
> have grub boot efi zboot kernels in bios mode).
>
> Disclaimer: didn't actually check grub source code.
>

I have :-(

> I suspect the bigger problem wrt. grub is that getting patches merged
> upstream is extremely slow and every distro carries a huge stack of
> patches ...
>

Yeah, Daniel has been asking me about LoadFile2 initrd loading support
for x86, so I think getting things merged is not going to be a problem
(although it will still take some time) - I can just implement it and
send it out at the same time.

But hacking/building/running GRUB is a rather painful experience, so I
have been kicking this can down the road.
