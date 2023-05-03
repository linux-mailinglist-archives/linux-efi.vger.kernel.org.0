Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1336F5DAF
	for <lists+linux-efi@lfdr.de>; Wed,  3 May 2023 20:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjECSNw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 May 2023 14:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjECSNv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 May 2023 14:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9EBD;
        Wed,  3 May 2023 11:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F52162F41;
        Wed,  3 May 2023 18:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DCFC433A0;
        Wed,  3 May 2023 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683137621;
        bh=LjbEDUiSwpxNcgm6NPH5ebIYUZu456EdaU5CS2r6bEE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rRrjcjdJTxowlBapk4KZmC44K++ZtRgCzl0kQwU8UQ5QTYjCv6ASpE2SZlJ6q2ILp
         4HknGGr6hR81aoWzewsoAtr7vaPIYFt7ugM20YH88dwLl4bCZcYr8zxXha9sfH+VfD
         oms14mRAbTQ1Qp+Try+cEGyV6INb1rzD9054QHOTgvMcdpAmiXpA7zb2D5V/Z3igFn
         yRWAL92SoLVOYX8j8Bu442TJhbW5y9jv4pWrpgmJQH72U/TAHmJhYl3MAk5uGggoiO
         3CUFByzhH+r3nYBoi2cSy3qwcI7nvvZ2vZMkSupdCOZtN1Q0AUaNMyFcEFwJz0MBa6
         UsBSj4rn1OiGw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so6344808e87.1;
        Wed, 03 May 2023 11:13:41 -0700 (PDT)
X-Gm-Message-State: AC+VfDwVuz/5Z6PPpDdk+engr9HGVxDipcYlWCtiUaNiXtcVjCuuge02
        jEHEfYyjr+0b1FBL1a0mFqlbtTcWa/qCkH37dew=
X-Google-Smtp-Source: ACHHUZ4Xm7RRAFP1zDvLerPYL3+hEkNnebwvJM9C6jsiTtcTJTtF2le2gxURzUC3io1gQ8eJlNW5sDaWrf+ufCAjrSY=
X-Received: by 2002:a2e:9cc2:0:b0:2ac:6858:45b9 with SMTP id
 g2-20020a2e9cc2000000b002ac685845b9mr251370ljj.20.1683137619507; Wed, 03 May
 2023 11:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230416120729.2470762-1-ardb@kernel.org> <5694ea5d-da9a-413e-9499-02a54588a953@app.fastmail.com>
 <CAMj1kXH5+scbFuaOP+VC7EHEZcn-tmp3nk=9uYGYGfJyb0S92Q@mail.gmail.com> <44b21bb3-a65d-4560-9fe5-c7ddc260ddc0@app.fastmail.com>
In-Reply-To: <44b21bb3-a65d-4560-9fe5-c7ddc260ddc0@app.fastmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 3 May 2023 20:13:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHiw2_7HAJND4HryTRqbTLoucyC4yATPXOTUnA1tkeyzA@mail.gmail.com>
Message-ID: <CAMj1kXHiw2_7HAJND4HryTRqbTLoucyC4yATPXOTUnA1tkeyzA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] efi: Implement generic zboot support
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 3 May 2023 at 19:55, Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Apr 21, 2023, at 6:41 AM, Ard Biesheuvel wrote:
> > On Fri, 21 Apr 2023 at 15:30, Andy Lutomirski <luto@kernel.org> wrote:
> >>
> >>
> >>
> >> On Sun, Apr 16, 2023, at 5:07 AM, Ard Biesheuvel wrote:
> >> > This series is a proof-of-concept that implements support for the EF=
I
> >> > zboot decompressor for x86. It replaces the ordinary decompressor, a=
nd
> >> > instead, performs the decompression, KASLR randomization and the 4/5
> >> > level paging switch while running in the execution context of EFI.
> >>
> >> I like the concept.  A couple high-level questions, since I haven=E2=
=80=99t dug into the code:
> >>
> >> Could zboot and bzImage be built into the same kernel image?  That wou=
ld get this into distros, and eventually someone could modify the legacy pa=
th to switch to long mode and invoke zboot (because zboot surely doesn=E2=
=80=99t need actual UEFI =E2=80=94 just a sensible environment like what UE=
FI provides.)
> >>
> >
> > That's an interesting question, and to some extent, that is actually
> > what Evgeny's patch does: execute more of what the decompressor does
> > from inside the EFI runtime context.
> >
> > The main win with zboot imho is that we get rid of all the funky
> > heuristics that look for usable memory for trampolines and
> > decompression buffers in funky ways, and instead, just use the EFI
> > APIs for allocating pages and remapping them executable as needed
> > (which is the important piece here) I'd have to think about whether
> > there is any middle ground between this approach and Evgeny's - I'll
> > have to get back to you on that.
> >
>
> Hmm.  I dug the tiniest bit into the history.  The x86/boot/compressed st=
uff has an allocator!  It's this:
>
>         free_mem_ptr     =3D heap;        /* Heap */
>         free_mem_end_ptr =3D heap + BOOT_HEAP_SIZE;
>
> plus a trivial and horrible malloc() implementation in include/linux/deco=
mpress/mm.h.  There's one caller in x86/boot/compressed.
>
> And, once upon a time, the idea of allocating enough memory to store the =
kernel from the decompressor would have been a problem.  I'm willing to cla=
im that we should not even try to support x86 systems that have that little=
 memory (at least not once they've gotten long mode or at least flat 32-bit=
 protected mode working).  We should not try to allocate below 1MB (my lapt=
op will cry), but there's no need for that.
>
> So maybe the middle ground is to build a modern, simple malloc(), and bac=
k it by EFI when EFI is there and by just finding some free memory when EFI=
 is not there?
>
> This would be risky -- someone might have a horrible machine that has tro=
uble with a simple allocator.

The malloc() is the least or our concerns, tbh. It is only used by the
decompression library itself, and it is backed by a statically
allocated block of BSS.

Having just gone through this again, the main issues are:

1) The 4/5 level switching trampoline, which runs in the page tables
of the loader/EFI stub, and assumes that it is fine to grab a random
chunk of low memory, stash its contents somewhere, use it for some
code, a stack and a root level page table so we can do the x86 long
mode paging off/paging on salsa, and then copy back the contents and
carry on as if nothing happened. We currently have some code in the
stub that strips all NX restrictions from a generously overdimensioned
block of low memory so copying and running code like this actually
works.

2) We need an accurate description in the PE/COFF header of what needs
to be executable and what needs to be writable, so we can splt the
regions. This only matters for code that runs under EFI's mappings, so
not a lot.

3) The payload relocates itself to the end of the decompression buffer
so it doesn't overwrite itself before completing. This is fragile and
also unnecessary when there is a page allocator and plenty of memory,
but afaict, this all executes under the decompressor's own page tables
so the RO/NX attributes that EFI sets are not a concern here. It
would, of course, be nice if we could avoid relying on RWX mappings
here.

4) I think it was you who pointed out that the demand paging 1:1 map
should really only get triggered for data accesses and not code
accesses, so it would be nice if we could create such mappings with NX
attributes.

I've had another go at running the decompressed kernel directly,
without going through the decompressor logic at all, but I missed the
fact that SEV does a substantial amount of work in the decompressor
too, so I'm no longer convinced that this is a viable approach. But
I'm looking into this.

I just finished some patches [0] that only address 1), based on the
work I posted earlier. I'll send those out once -rc1 comes around.


[0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=
=3Defi-x86-cleanup-la57
