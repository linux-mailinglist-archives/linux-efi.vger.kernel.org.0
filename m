Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D22C1295C3
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2019 13:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfLWMAo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Dec 2019 07:00:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45568 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfLWMAo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Dec 2019 07:00:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so16308207wrj.12
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 04:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOy2x6p9y5XnLLOlUaDY50AhmGryyxnSZH6gNhvVWlM=;
        b=uN9HloVYPMM9mlz8+/a8HEtzqvsoetmrbWxTZjQgttVLoLPQPgBXyX1MjaRiA4kgqf
         9qNFY2qBIhh9jQNYB5EqwqUaJl2CVIEV6t4xMIoy8OZJUKTVmw3KcX6WaTeXSStpf3MO
         w0SoF1kFX7r3EuPGgadtz1jGTxIUdqtndKoY3ybOBjE7mslnwk6o8AJjYvmk2/Dhk1cQ
         nrO4GTrDaSasC43ZIzLO3iORhZCUIRa8F7tr/GdiXuTO976Z+sq3+cLVo1naSOY6yS5y
         AyQ3wympy7frZod2brbbA7TQzYA2D3e6+Yg+g8WwsRG29fI9UM9vd6RgrpKiYwkYvvrP
         xu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOy2x6p9y5XnLLOlUaDY50AhmGryyxnSZH6gNhvVWlM=;
        b=gVjsO/OC0nT6tu2VLLAiqwQSVCmio/6f4IgeRnNHazL5EzizR1As2z4/NsUciAcUL3
         TrNflgB37LvnPWZkVI7ftsop7zIyjSwjdcZZ7pWBgP4ppEFYmCpuiHxYk009oI/6Hv34
         BHmUuNWXjkZtTJew26tYDi1Qnn0fXWWIAP6Cdpk0hfW8CY3p88PUQPPvvlTen/As4thx
         GGVrn0KqpS0//R5rG9+kw6AzRliFmPTOKRIPV6Kw/0vrjLXVqUHNT2PjdOBzAJqrVEfS
         5Ue9Ql9ZUc320OL30HHPCF/p3INiveeO4cVm7XV0O1Y550N6B0CXClK+/DEFvZJC7Kmd
         sPNg==
X-Gm-Message-State: APjAAAVlBWPmOZ+bD+Fc3qN82PYjcrgyCTKzNg3TkXoZfEM/BcOJfkY8
        FZp5WZ01g3EONr+ZHSGPaTdGJKk1n5ZJeFNxvEMoyA==
X-Google-Smtp-Source: APXvYqyYfy9/hUAaBk9YCq/TN9Z9cnX9dPXy/TsA0HLmpBYjyAYcyFTLsrgMc5OIMrqIXagOeK3RRXlbgIH2qCNLKwY=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr30732920wrw.246.1577102442234;
 Mon, 23 Dec 2019 04:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-11-ardb@kernel.org>
 <e7fc88c6-6281-f69b-ef9b-71572e40d6b9@redhat.com> <CAKv+Gu8gWLw5-LkKwU0reUcreLyC8s1hQSzrR__-myuHrdVr7Q@mail.gmail.com>
 <c82d02c3-c6e7-70af-37ad-5a8209ab8f22@redhat.com>
In-Reply-To: <c82d02c3-c6e7-70af-37ad-5a8209ab8f22@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 23 Dec 2019 13:00:31 +0100
Message-ID: <CAKv+Gu-BqrTrTfzHgUrn06NMC6Q4uf2TaF4UU2m512yvhFikaw@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] efi/libstub/x86: avoid thunking for native
 firmware calls
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 23 Dec 2019 at 12:49, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ard,
>
> On 22-12-2019 13:02, Ard Biesheuvel wrote:
> > On Sat, 21 Dec 2019 at 22:22, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Ard,
> >>
> >> On 18-12-2019 18:01, Ard Biesheuvel wrote:
> >>> We use special wrapper routines to invoke firmware services in the
> >>> native case as well as the mixed mode case. For mixed mode, the need
> >>> is obvious, but for the native cases, we can simply rely on the
> >>> compiler to generate the indirect call, given that GCC now has
> >>> support for the MS calling convention (and has had it for quite some
> >>> time now). Note that on i386, the decompressor and the EFI stub are not
> >>> built with -mregparm=3 like the rest of the i386 kernel, so we can
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
> >> tree, the GPD pocket stops booting and it stop so early on that I get 0
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
> Ok, so I made this change on top of a37d90a2c570a25926fd1645482cb9f3c1d042a0
> (the last "efi/libstub/x86: avoid thunking for native firmware calls" version
> I tried before reporting this problem) :
>
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -464,6 +464,7 @@ SYM_FUNC_START(efi_pe_entry)
>
>   handover_entry:
>          movq    efi_config(%rip), %rdi
> +       and     $~0xf, %rsp
>          call    efi_main
>          movq    %rax,%rsi
>          cmpq    $0,%rax
>
> And that does the trick, the GPD pocket boots successfully with commit
> a37d90a2c570a25926fd1645482cb9f3c1d042a0 + the above change.
>
> So it looks like your first hunch on how to fix this is correct :)
>

Excellent! Thanks for testing.

I'll fold this in.
