Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA74129EA7
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 08:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfLXHuJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 02:50:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35447 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLXHuI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Dec 2019 02:50:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so19080370wro.2
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 23:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aJqStyccr13YwlNssyJxWv1D8GaNhZuyf/UBWegStCY=;
        b=gvXSgzzTvkK/O3vOocwdZnStDjQ4x/SfmdSg8ORFDFybxRQ7uEK5UnvMbrh7O5IE4Y
         PGkuhZL+Mk/jPJ2Ph+GdDv7J8dJim03Ofqjvf5oJPtACpiMauqnmtERT+mY3FQKnQQyl
         Kg7Q2BfDUYeSXJPh1cCmYJptkI3aO6rmRkBlsSRvWnGMMcSZTk/y4gY7zs7n4KPgRIf8
         5+ZYagt1WbKouKkIaHJRrGIQdofUW1PWcZVMdMijy4KMNpRCJNu69zY4MQQSMiYEHA2h
         KmTWjmy0nWqhQaz+3p4U+etYwppcQFmKH1UwVTUOQUBgRlhuMHMz9dbUXnjqBhzwrAO4
         A98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aJqStyccr13YwlNssyJxWv1D8GaNhZuyf/UBWegStCY=;
        b=jzbZsCQTMDlTNH+uV5ktBv/QzSnhepGIagdOUEMG7oKfLfbq9QIXOTsIkRZAKysn59
         WEwM37QKifBjtc9Wsn4KNvnoS3vUzyBCndavIbV0IxYzFbsXhOUOc1NKJcI+jttto3qn
         TCIxt9dav93oOw6FnAs4AjCj8pQJW+hMLHXMkGludoOYXTWLlmJ8cht/XqcA3kxtnjKu
         7IziSZhpC2YMGpkwRyM/bOit0O+Oof6gC/7+U3Qo31a35pam9XkSdiCX4BilLdZtPKVU
         SgZ6v04EKuhTPfZ1VQGSYNZGG42lQVZ7EZ/3qXzHVX3QmSVMtfSFCnfMkGTab0Zj1jhB
         gQhw==
X-Gm-Message-State: APjAAAWOnip46tC9e7Q/5ajArrAePHYQ5Lf0a4P59zTfFW/jcT3RwX+/
        0tsdyBvlYw6auLVoBZ4fRMYfGnTclfc62FJYch31Hg==
X-Google-Smtp-Source: APXvYqz+b6BiGOPN1ltXFHx+yOUjDc4oFhpreEaIniH9iWiNRXPYGaPi6TuyVoVGxlCG4eDQbWUY/e7FG+sh/nQvyRI=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr31773601wrr.32.1577173806336;
 Mon, 23 Dec 2019 23:50:06 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu9B4+MGP7gqpSiaYMaGG5u1K9D1nQ2sTvTt50qPhvwQFg@mail.gmail.com>
 <94A83725-602F-4253-B715-25C391672384@amacapital.net>
In-Reply-To: <94A83725-602F-4253-B715-25C391672384@amacapital.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 24 Dec 2019 08:50:05 +0100
Message-ID: <CAKv+Gu-v5jbD+62FKGXojU2ERp0tOpE6MSvUH+zpMu5rX-TJMw@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: disable paging at mixed mode entry
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, X86 ML <x86@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 24 Dec 2019 at 08:47, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>
> > On Dec 24, 2019, at 3:38 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org>=
 wrote:
> >
> > =EF=BB=BFOn Tue, 24 Dec 2019 at 03:15, Andy Lutomirski <luto@amacapital=
.net> wrote:
> >>
> >>> On Mon, Dec 23, 2019 at 7:23 AM Ard Biesheuvel <ardb@kernel.org> wrot=
e:
> >>>
> >>> The EFI mixed mode entry code goes through the ordinary startup_32()
> >>> routine before jumping into the kernel's EFI boot code in 64-bit
> >>> mode. The 32-bit startup code must be entered with paging disabled,
> >>> but this is not documented as a requirement for the EFI handover
> >>> protocol, and so we should disable paging explicitly when entering
> >>> the kernel from 32-bit EFI firmware.
> >>
> >> Does this mean that EFI is allowed to call the kernel with paging on
> >> but the text identity-mapped?
> >
> > Yes. This is explicitly mentioned in the spec. Paging may be on or
> > off, but all memory must be mapped 1:1
> >
> >> Have you seen this happen in practice?
> >>
> >
> > Yes. GRUB and OVMF both implement the EFI handover protocol, but OVMF
> > doesn't disable paging before calling the 32-bit entry point, and so
> > it explodes in startup_32(). GRUB calls the EFI handover entrypoint
> > with paging disabled, and so then everything works fine.
> >
> >> If the kernel is entered with paging on and the text not
> >> identity-mapped, this is going to blow up badly.
> >>
> >
> > Not just text: all of system memory is guaranteed to be 1:1 mapped if
> > paging is on when entering the kernel from EFI, so this should be
> > safe.
> > Note that this change only affects mixed mode configurations that use
> > OVMF instead of GRUB.
> >
> > We are using OVMF/qemu in kernelCI for test coverage of the EFI stub
> > for all architectures, and this is the missing puzzle piece to get it
> > working in x86 mixed mode as well.
>
> Sounds good to me, then.
>
> I admit to being a bit confused, since I would have sworn that I=E2=80=99=
ve personally tested mixed mode with OVMF.

Interesting that you should say that. I thought exactly the same, but
after noticing that it didn't work, I went back years testing old
kernels and old builds of OVMF, and no combination that I tried would
actually work without a change like the one in this patch. This is
using both KVM and emulation, so it doesn't seem likely that this is
caused by a change in QEMU.
