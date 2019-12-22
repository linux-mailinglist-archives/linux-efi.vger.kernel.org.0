Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF82128EA3
	for <lists+linux-efi@lfdr.de>; Sun, 22 Dec 2019 16:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfLVP3y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 22 Dec 2019 10:29:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39276 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVP3y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 22 Dec 2019 10:29:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so13670964wmj.4
        for <linux-efi@vger.kernel.org>; Sun, 22 Dec 2019 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jtBPpOoQoQ6Nzsx1jZweqFkOCa4NS/yHAmtjuzJ2pl4=;
        b=GhSERaTO+1MMdchgV4oKzBxyB1GT8QzYx7hc86T8RRz7GSVNBZFcuvPJhfyOxOYXNn
         G/Kv3pTuSVIfNrD9m4LxRcR99J3cceg1BmbhdOpE5a3TrUsxtDqnDWm39wfnUjOGDrKa
         G2ciFaPGQqm3qYNHQoM7goDj3jcPmjqf9YnygAmjVsSPUlxInjckU8yztmNBwgqFUVq0
         iSEDvwcYcffOPuuN3khdJiu7ABbefDyD2l0hTQQnXBMrBiBd3Ek+CQ5lmQt8p774lD5y
         zlc+NRtC/SWcFy2Lzqj3N4+0pM8wID41NwAOoqkVgCyVjuzeikuaeIYDtlwuWgBv6vb+
         nGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jtBPpOoQoQ6Nzsx1jZweqFkOCa4NS/yHAmtjuzJ2pl4=;
        b=D7NaY8NGJ8vt1yn35HzJ1C9WYd1Je4F2tQGRQZ/fwTbkiB2zNqPX3Qp+edHmtOFiJN
         cegQyCSEbWL/KPTkvq7utll7+d2Nw28el7KiQF400ukYFKDLXgCVpR1+10SwrbkfaDcq
         w1/pEP/q1Aps4ipw42jBrmR5QyDabdOTWmCpCfkbrsf7KlhsXpm4x58QYT1C0Z8uDDYe
         j/1lhTTKsfWDnnMxbyQUgU0KmRa2F8YxllJu4B/fJRm/Wgbv1dsZQDb+XrkLNjX7JQNU
         PuTADXZB5Y/DRxOUiaRcgsyHaqwlv7meXSJ9PeLpLH3YHWp0119V+VTTJ2NyJmAKZ6BV
         G60w==
X-Gm-Message-State: APjAAAXEC0b7UGqS3vT7vumhS4uavmKhKwdt2oT8d0HffEXCqkHSnPzT
        s8VS8GhymWLdmarPIhx5W3FDQW1TMva4bpw6nEKm56twbkeRXRPm
X-Google-Smtp-Source: APXvYqy+wtz1wpdK8L7ddp7X7rWZBsXskuVPVMOnio+ZrazwUNt/vwLvIEk8vSzWR+xLF5S7NJcQAlMUE6F1QTRKAyc=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr28122102wmc.9.1577028591047;
 Sun, 22 Dec 2019 07:29:51 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu8gWLw5-LkKwU0reUcreLyC8s1hQSzrR__-myuHrdVr7Q@mail.gmail.com>
 <4FEC2A1B-91A5-4357-8594-8BC8BB3D02A4@amacapital.net>
In-Reply-To: <4FEC2A1B-91A5-4357-8594-8BC8BB3D02A4@amacapital.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 22 Dec 2019 16:29:48 +0100
Message-ID: <CAKv+Gu_3UUfJY1YsHGneR-fmr_T-o2ocQ7dtP0_EbKW2RtAsRw@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] efi/libstub/x86: avoid thunking for native
 firmware calls
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 22 Dec 2019 at 13:46, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>
> > On Dec 22, 2019, at 8:02 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org>=
 wrote:
> >
> > =EF=BB=BFOn Sat, 21 Dec 2019 at 22:22, Hans de Goede <hdegoede@redhat.c=
om> wrote:
> >>
> >> Hi Ard,
> >>
> >>> On 18-12-2019 18:01, Ard Biesheuvel wrote:
> >>> We use special wrapper routines to invoke firmware services in the
> >>> native case as well as the mixed mode case. For mixed mode, the need
> >>> is obvious, but for the native cases, we can simply rely on the
> >>> compiler to generate the indirect call, given that GCC now has
> >>> support for the MS calling convention (and has had it for quite some
> >>> time now). Note that on i386, the decompressor and the EFI stub are n=
ot
> >>> built with -mregparm=3D3 like the rest of the i386 kernel, so we can
> >>> safely allow the compiler to emit the indirect calls here as well.
> >>>
> >>> So drop all the wrappers and indirection, and switch to either native
> >>> calls, or direct calls into the thunk routine for mixed mode.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> I'm afraid that this patch breaks the boot on one of my machines.
> >>
> >> Specifically this patch breaks my GDP pocket machine. This is a Cherry
> >> Trail device with a 64 UEFI running a 64 bit kernel build.
> >>
> >> As soon as I cherry pick this patch into my personal 5.5.0-rc2 based
> >> tree, the GPD pocket stops booting and it stop so early on that I get =
0
> >> debug output. I guess I could try adding a few pr_efi_err calls
> >> and see if those still do something.
> >>
> >> I noticed that you have made some changes to this patch, I've
> >> tried updating it to the version from your efistub-x86-cleanup-v3
> >> branch, commit id a37d90a2c570a25926fd1645482cb9f3c1d042a0
> >> and I have also cherry-picked the latest version of all preceding
> >> commits, unfortunately even with the new version, the GPD pocket
> >> still hangs at boot.
> >>
> >> Unfortunately the nature of this patch makes it hard to figure
> >> out the root cause of this issue...
> >>
> >> I've also tried another Cherry Trail device with 64 bit UEFI and
> >> that does not suffer from this problem.
> >>
> >
> > Thanks Hans.
> >
> > There are a number of things that change in the way the calls are
> > made, but the most obvious thing to check is whether the stack needs
> > to be aligned, since that is no longer being done.
> >
> > If you have time to experiment a bit more, could you check whether
> > doing 'and $~0xf %rsp' before 'call efi_main' in the .S stub code for
> > x86_64 makes a difference?
>
> Hmm. Most of the kernel is compiled with the stack alignment set to 8, an=
d there a lot of asm that makes no effort to preserve alignment beyond 8 by=
tes.  So if EFI calls need 16 byte alignment, you may need to do something =
special.
>
> On new enough gcc (the versions that actually support the flags to set th=
e alignment to 8), maybe you can use function attributes, or maybe you can =
stick a 16-byte-aligned local variable in functions that call EFI functions=
?  The latter would be rather fragile.

This patch replaces open coded SysV to MS calling convention
translation to GCC generated code (using __attribute__((ms_abi)) which
we have been using for a long time in EDK2), because the former relies
on a wrapper function

efi_call(fn, ...)

which is type unsafe and relies on a lot of nasty casting, especially
combined with the mixed mode support. efi_call() is implemented as
below, and as Hans reports, omitting this sequence causes a boot
regression on one of the platforms he has tested this on.

So the question is which of the pieces below this UEFI implementation
is actually relying on, and the stack pointer alignment is my first
guess, but it could be any of the other things as well. Once we
identify what it is we are missing, I can simply stick it back in, but
without reverting to using the efi_call() thunk.

Note that the decompressor/stub are built with the default stack
alignment of 16 afaict, but if GRUB enters the decompressor with a
misaligned stack, we probably wouldn't notice until we hit something
like a movaps, right?

Thanks,
Ard.



#define SAVE_XMM \
    mov %rsp, %rax; \
    subq $0x70, %rsp; \
    and $~0xf, %rsp; \
    mov %rax, (%rsp); \
    mov %cr0, %rax; \
    clts; \
    mov %rax, 0x8(%rsp); \
    movaps %xmm0, 0x60(%rsp); \
    movaps %xmm1, 0x50(%rsp); \
    movaps %xmm2, 0x40(%rsp); \
    movaps %xmm3, 0x30(%rsp); \
    movaps %xmm4, 0x20(%rsp); \
    movaps %xmm5, 0x10(%rsp)

#define RESTORE_XMM \
    movaps 0x60(%rsp), %xmm0; \
    movaps 0x50(%rsp), %xmm1; \
    movaps 0x40(%rsp), %xmm2; \
    movaps 0x30(%rsp), %xmm3; \
    movaps 0x20(%rsp), %xmm4; \
    movaps 0x10(%rsp), %xmm5; \
    mov 0x8(%rsp), %rsi; \
    mov %rsi, %cr0; \
    mov (%rsp), %rsp

SYM_FUNC_START(efi_call)
    pushq %rbp
    movq %rsp, %rbp
    SAVE_XMM
    mov 16(%rbp), %rax
    subq $48, %rsp
    mov %r9, 32(%rsp)
    mov %rax, 40(%rsp)
    mov %r8, %r9
    mov %rcx, %r8
    mov %rsi, %rcx
    call *%rdi
    addq $48, %rsp
    RESTORE_XMM
    popq %rbp
    ret
SYM_FUNC_END(efi_call)
