Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19DB6E7D52
	for <lists+linux-efi@lfdr.de>; Wed, 19 Apr 2023 16:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjDSOpy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Apr 2023 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjDSOpx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Apr 2023 10:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79936D317;
        Wed, 19 Apr 2023 07:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2267263851;
        Wed, 19 Apr 2023 14:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DC9C433A8;
        Wed, 19 Apr 2023 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681915497;
        bh=wWkzRl1bal72Ksstv2NW9WU1+ZfobVIm+Keq4QJzHOM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AW1ycGEg70wqx4sbMR5KKjxHpdpWo8ojboJjJXNi1+UhU2HzrVi6iBk2smkaSETGN
         nCU1KMdD8zN8DgWQkEGFvx0nVXQfqYhkjpzVGxsfVXkQE+gvB2U319PbXWbXu0BkFD
         A70H2Gl8qq9kmQklhtU0iwS0q8/YQxgiJ2qUSQ6WJWK2BCupLW7WB5/w256Cl0Vw6s
         fnSqiT01FAVr6uSbeGGChXferxHjiR7tQ26YhoiJP+74D3C19Ovs9Ysfz4TAURTJy1
         gQImPbbwGDHu1e5nszzeRdl2ld0cFuclN/jWyOc6VWQM5PHUJB6/S6gf9jL/Kj8gC+
         Ey8xngZ6NM97Q==
Received: by mail-lj1-f175.google.com with SMTP id k15so16578630ljq.4;
        Wed, 19 Apr 2023 07:44:57 -0700 (PDT)
X-Gm-Message-State: AAQBX9f7E/HyJGz4mmkCvx7fj76NMLcpwG8G1hevg/XhWWGAGeIy1zpT
        pmTn6UT5NRoNuUHXBYcfwQJkMu8nLLvMdXDVpqI=
X-Google-Smtp-Source: AKy350bCMi+LROSXgZOTDyz9U+/dbBjR1BGsAJxbDf18an2K6nxd2pTYEyUVm0Dl7Z3tqnheaAXp16510oSO8ply7uE=
X-Received: by 2002:a05:651c:238:b0:2a7:a638:d2a1 with SMTP id
 z24-20020a05651c023800b002a7a638d2a1mr862694ljn.18.1681915495467; Wed, 19 Apr
 2023 07:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230416120729.2470762-1-ardb@kernel.org> <jwvybt4sro56aiqvddn6jxdjpdelasdhl747c25kzv4vbjr7ph@fbtheokrtxce>
In-Reply-To: <jwvybt4sro56aiqvddn6jxdjpdelasdhl747c25kzv4vbjr7ph@fbtheokrtxce>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Apr 2023 16:44:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE4xF9RJbaR0H6uuFxxroUJxQFo8WThb=SUa7H0OpDxUg@mail.gmail.com>
Message-ID: <CAMj1kXE4xF9RJbaR0H6uuFxxroUJxQFo8WThb=SUa7H0OpDxUg@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 19 Apr 2023 at 07:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Sun, Apr 16, 2023 at 02:07:26PM +0200, Ard Biesheuvel wrote:
> > This series is a proof-of-concept that implements support for the EFI
> > zboot decompressor for x86. It replaces the ordinary decompressor, and
> > instead, performs the decompression, KASLR randomization and the 4/5
> > level paging switch while running in the execution context of EFI.
> >
> > This simplifies things substantially, and makes it straight-forward to
> > abide by stricter future requirements related to the use of writable and
> > executable memory under EFI, which will come into effect on x86 systems
> > that are certified as being 'more secure', and ship with an even shinier
> > Windows sticker.
> >
> > This is an alternative approach to the work being proposed by Evgeny [0]
> > that makes rather radical changes to the existing decompressor, which
> > has accumulated too many features already, e.g., related to confidential
> > compute etc.
> >
> > EFI zboot images can be booted in two ways:
> > - by EFI firmware, which loads and starts it as an ordinary EFI
> >   application, just like the existing EFI stub (with which it shares
> >   most of its code);
> > - by a non-EFI loader that parses the image header for the compression
> >   metadata, and decompresses the image into memory and boots it.
>
> I like the idea to have all EFI archs handle compressed kernels the same
> way.
>
> But given that going EFI-only on x86 isn't a realistic option for
> distros today this isn't really an alternative for Evgeny's patch
> series, we have to fix the existing bzImage decompressor too.
>

I tend to agree, although some clarification would be helpful
regarding what is being fixed and why? I *think* I know, but I have
not been involved as deeply as some of the distro folks in getting
these requirements explicit.

> Realistically, the second option is unlikely to ever be used on x86,
>
> What would be needed to do so?  Teach kexec-tools and grub2 parse and
> load zboot kernels I guess?
>

I already implemented this for mach-virt here, so we can load Fedora
kernels without firmware:

https://gitlab.com/qemu-project/qemu/-/commit/ff11422804cd03494cc98691eecd3909ea09ab6f

On arm64, this is probably more straight-forward, as the bare metal
image is already intended to be booted directly like that. However,
the x86 uncompressed image requires surprisingly little from all the
boot_params/setup_header cruft to actually boot, so perhaps there it
is easy too.

There is an unresolved issue related to kexec_load_file(), where only
the compressed image is signed, but the uncompressed image is what
ultimately gets booted, which either needs the decompression to occur
in the kernel, or a secondary signature that the kernel can verify
after the decompression happens in user space.

Dave and I have generated several ideas here, but there hasn't been
any progress towards a solution that seems palatable for upstream.
