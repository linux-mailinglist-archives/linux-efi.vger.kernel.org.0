Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 562651427C0
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2020 11:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgATKBo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jan 2020 05:01:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43090 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATKBo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Jan 2020 05:01:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so28835112wre.10
        for <linux-efi@vger.kernel.org>; Mon, 20 Jan 2020 02:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2lVqw3aXdiTtPnezQDZ+n4lBvZ99XrH9Ru6/JMEuUU=;
        b=MY4ws/OBUrxtpXZMZ2t6+zZGMWkTaRxak1WqyO6kRZtdGNqYJIOePpfWoE7Y9LcA94
         RmWdhP2U7wZnudx4w9qXEYoU5HgKS2B3Y+mT/ddSgDfXiP9MHS223nrOu5Wk6aVyZFWO
         u8XPFun2WxekinWdCILF2dNuI2gwTft9slo36IMnVAGEXNUg5UdnJSfEQfMQnXVyZxLC
         hdYy0QDHNPReWzevO/hoI/tRJg1BIwXh3Z1d3f2rPCZV4TzuNSaUdBnD3F2RSHaUtmso
         0lPxEhN5RBitxs7zEgeNAbTgMHiKa1gyGO/tM9JGVYgj48KH7dB8b2ZPJ26HjdqEWANW
         /drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2lVqw3aXdiTtPnezQDZ+n4lBvZ99XrH9Ru6/JMEuUU=;
        b=PQiGIKR3eMHmUTU8Cit/Sm1fO5Sb44sR8YAkrm5n4AvoH+JSGzukpAIeQwsdvQuk5H
         wNuw3Y7hyiXiq/qQmFSNMr7wZgR1IRt8lM6CBsEXgjv2rClm/0Tkf9oP0O5fHXnhbi8S
         csDgfsLQj6+OfwQICyZ5IvkRqkn5Hy9FgVnh/vZtzAAx1WdTI5Gl6e1ODMaFMWRl7TqX
         1+FWvBn6BgNVO7mA/BZ6OOyGuSplDIrkkwm3prgRVNnVSmCvu7Ydf4JT+5hAa2pWUkdC
         x1QjcUIs4JY1mQUtCneePAShU9fbrnCijcb3idvGCAj9hEKJrTsKeSvjrhmBEMAQ0qWt
         RF+Q==
X-Gm-Message-State: APjAAAU9vAZtrA+AL/ajkEHgIm5lxS5HM4TEd65G6xWBY93v+Qr38W7J
        BIrm2PSldO4ZU9VstnR97wbJi7NK6LZI8L+CwuHMNuyu2YSpIQ==
X-Google-Smtp-Source: APXvYqzjU3PVKY9z9F67tGaMfVR47AnIXvUfeSu5VaPkSoO+WUEhRBVl549G5n7cmFanqYM2DRkedfjVTClr7GmIC8o=
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr17217941wrm.262.1579514502263;
 Mon, 20 Jan 2020 02:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20200118165705.16544-1-ardb@kernel.org> <20200120094856.GA102981@gmail.com>
In-Reply-To: <20200120094856.GA102981@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 20 Jan 2020 11:01:30 +0100
Message-ID: <CAKv+Gu8_gn8b1iUg9hjd+KddCoOtb4gsxQTQ_devWy8WUJDjyg@mail.gmail.com>
Subject: Re: [PATCH 0/3] EFI fixes for -next
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 20 Jan 2020 at 10:49, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > A couple of fixes for more unusual configurations that weren't caught in
> > my testing before. One for KASAN, one for the LLVM linker and one for the
> > old EFI memory map when running on mixed mode systems.
> >
> > These apply onto the Git pull request [0[ that I sent out at the beginning
> > of the week.
> >
> > [0] https://lore.kernel.org/linux-efi/20200113172245.27925-1-ardb@kernel.org/
> >
> > Ard Biesheuvel (3):
> >   efi/x86: avoid KASAN false positives when accessing the 1:1 mapping
> >   x86/boot/compressed: relax sed symbol type regex for LLVM ld.lld
> >   efi/x86: disallow efi=old_map in mixed mode
> >
> >  arch/x86/boot/Makefile         |  2 +-
> >  arch/x86/platform/efi/efi_64.c | 11 ++++++-----
> >  arch/x86/platform/uv/bios_uv.c |  2 +-
> >  3 files changed, 8 insertions(+), 7 deletions(-)
>
> Just a minor bugreport, in some (weird) config combinations we now get
> this build failure:
>
>   ld: arch/x86/platform/efi/efi_64.o: in function `efi_set_virtual_address_map':
>   efi_64.c:(.init.text+0x1419): undefined reference to `__efi64_thunk'
>   ld: efi_64.c:(.init.text+0x1530): undefined reference to `efi_uv1_memmap_phys_prolog'
>   ld: efi_64.c:(.init.text+0x1706): undefined reference to `efi_uv1_memmap_phys_epilog'
>
> Config attached.
>
> I believe the trigger condition is:
>
>   !CONFIG_X86_UV
>   CONFIG_EFI=y
>

Strange.

Those references to missing symbols are guarded by efi_is_mixed() and
efi_have_uv1_memmap(), both of which are static inline bool()
functions wrapping IS_ENABLED() checks against CONFIG_EFI_MIXED and
CONFIG_X86_UV, respectively. IOW, it is unexpected that the compiler
doesn't const-propagate those expressions and optimize away the
references entirely.

Is there any special debug or diagnostic options enabled?
