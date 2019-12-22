Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215B9129006
	for <lists+linux-efi@lfdr.de>; Sun, 22 Dec 2019 22:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfLVVZS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 22 Dec 2019 16:25:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42298 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfLVVZS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 22 Dec 2019 16:25:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so14651824wro.9
        for <linux-efi@vger.kernel.org>; Sun, 22 Dec 2019 13:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=veNvg3ynoyc+dv9tmH5nIS5n4b3b89cItfMCcAo4Jcw=;
        b=dnyqSS2CURM+NFua8pApS/ArbxJm4m054CpEwgcMAkuWW1J0i+rea8LwWnpdarL7sO
         65bipM1YqYmKugCTfpstleKBf80YSduvKkw6Ua1iZ64BNrJ58+X7XXIYOkzIrVnvSWfB
         8YT30hCLVXR5o7tQk7niFMTfZ/vyWPvpUlgEpJzBhaqPOrrErRbD+55CrvUhZ3j89LZn
         qjQzcVO4Kf0IKVAvzOl3AlumJON4BP7byDkyzsoHOp1PYps21ALZZZEr0+WZYYQqtWG3
         8rLz16LlKx63rD4+ZKxWkJyJpJ2YdDZjZaWIzRYQsO5f6JzDQ9EHVRJEPZrJ5KK4km6I
         wvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=veNvg3ynoyc+dv9tmH5nIS5n4b3b89cItfMCcAo4Jcw=;
        b=OkIRRkt08pZAvmuOXPIVrowBkBQVVQCDQLIT7Zfd2hhOO6KdWS10LIRNdoj6qvpWrd
         3Sgyxpg7DwTEDiGxsFOVvZGcauvUOIT+b+SLBOFTRyayWfrA9//rib4YMsZi+wrz1qYg
         WRopvyEGr6gJlejowXPg2xRGvi2zEVg+mFnpB5gb1Au4u2I+kvdPJ4LZtcan9nkMBn47
         viB6KMlhH3A7nGMaYB0E90P5KfYHk6dB60BZt2382vwIPE4PuicQoA28agKn4ommw/Qq
         /WVWHBlMax6o1pI4aH5iPumg7UCBssYKoVNRLGmFOHC8eRAdtDgDZ4JVVjK5kJust0UQ
         5smQ==
X-Gm-Message-State: APjAAAVxG+b2p1kQKdiYoQwB/gKmuh8eWEyG89LjpKH5KffbcJQtiZF0
        A+a3j143+JAguE5AutvHC8rV3KIcj49H4hc171zPo6XMASglVg==
X-Google-Smtp-Source: APXvYqyBSTYfGq7Zl5IBG1C8Aha9B61jSPF1UY4JhjcyOaeGxREa2rcz9Sb14iimashJzpfqsEZwTBb4Lttg7kmdGTk=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr26131292wrs.200.1577049915433;
 Sun, 22 Dec 2019 13:25:15 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu8gWLw5-LkKwU0reUcreLyC8s1hQSzrR__-myuHrdVr7Q@mail.gmail.com>
 <4FEC2A1B-91A5-4357-8594-8BC8BB3D02A4@amacapital.net> <CAKv+Gu_3UUfJY1YsHGneR-fmr_T-o2ocQ7dtP0_EbKW2RtAsRw@mail.gmail.com>
 <20191222211257.GA23363@rani.riverdale.lan>
In-Reply-To: <20191222211257.GA23363@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 22 Dec 2019 22:25:13 +0100
Message-ID: <CAKv+Gu-J7npYr7dRfvf8_--eMdpZaa09HD2SkXUyQfv8UyY3Mw@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] efi/libstub/x86: avoid thunking for native
 firmware calls
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 22 Dec 2019 at 22:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sun, Dec 22, 2019 at 04:29:48PM +0100, Ard Biesheuvel wrote:
> > On Sun, 22 Dec 2019 at 13:46, Andy Lutomirski <luto@amacapital.net> wro=
te:
> > >
> > > Hmm. Most of the kernel is compiled with the stack alignment set to 8=
, and there a lot of asm that makes no effort to preserve alignment beyond =
8 bytes.  So if EFI calls need 16 byte alignment, you may need to do someth=
ing special.
> > >
> > > On new enough gcc (the versions that actually support the flags to se=
t the alignment to 8), maybe you can use function attributes, or maybe you =
can stick a 16-byte-aligned local variable in functions that call EFI funct=
ions?  The latter would be rather fragile.
> >
> > This patch replaces open coded SysV to MS calling convention
> > translation to GCC generated code (using __attribute__((ms_abi)) which
> > we have been using for a long time in EDK2), because the former relies
> > on a wrapper function
> >
> > efi_call(fn, ...)
> >
> > which is type unsafe and relies on a lot of nasty casting, especially
> > combined with the mixed mode support. efi_call() is implemented as
> > below, and as Hans reports, omitting this sequence causes a boot
> > regression on one of the platforms he has tested this on.
> >
> > So the question is which of the pieces below this UEFI implementation
> > is actually relying on, and the stack pointer alignment is my first
> > guess, but it could be any of the other things as well. Once we
> > identify what it is we are missing, I can simply stick it back in, but
> > without reverting to using the efi_call() thunk.
> >
> > Note that the decompressor/stub are built with the default stack
> > alignment of 16 afaict, but if GRUB enters the decompressor with a
> > misaligned stack, we probably wouldn't notice until we hit something
> > like a movaps, right?
> >
> > Thanks,
> > Ard.
> >
>
> Won't the entry code misalign the stack when efi_main is called,
> assuming the stack was properly aligned at efi_stub_entry? There needs
> to be a sub $8, %rsp in there, no?
>
> arch/x86/boot/compressed/head_64.S:
>
> #ifdef CONFIG_EFI_STUB
>         .org 0x390
> SYM_FUNC_START(efi64_stub_entry)
> SYM_FUNC_START_ALIAS(efi_stub_entry)
>         movq    $1, %rcx
> handover_entry:
>         call    efi_main        <--- this will enter efi_main with a misa=
ligned stack?
>         movq    %rax,%rsi
>         movl    BP_code32_start(%esi), %eax
>         leaq    startup_64(%rax), %rax
>         jmp     *%rax
> SYM_FUNC_END(efi64_stub_entry)
> SYM_FUNC_END_ALIAS(efi_stub_entry)
> #endif
>

Indeed, well spotted. Note that the above is the version from the top
of that branch, but the version that Hans tested isn't any different.
