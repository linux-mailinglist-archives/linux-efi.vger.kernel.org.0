Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFFB14E9BD
	for <lists+linux-efi@lfdr.de>; Fri, 31 Jan 2020 09:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgAaIrt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jan 2020 03:47:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45377 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgAaIrt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jan 2020 03:47:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id f25so6229859ljg.12
        for <linux-efi@vger.kernel.org>; Fri, 31 Jan 2020 00:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2UsTg9sJleOEkW6MKHgQhUGOtlWWQFx7+63ORKNAZE=;
        b=nruTZgZUgUjDpGYe7fB/R+WuWavZS6uAJYdMjlHtTzlR1RpqUbhSD4CE4kKtQfLcLp
         dVXDp5me3uI0jzNo9Kf3RkrQ5i2PaFnNLXifALlxGhCnpK+Z2sZHtjzRemD4QYb1IXc4
         Pps29YyWIxxn4FrvmPnau4U+Er/PfpIJOhmYZ1iOnNr7pmCyUa7dH5eMpZj3eYpWYmD9
         eNvrm3m7aaVlcF2QZFqJq+chHFKF3IGHmK+qRGiqRRPx0K4dJFUgFFXmx3CApYXch7rn
         XsmIyKwPHKvO51m8stKbAbvkLuFvCtwerU2utuRuiPNxUkjGg9OQD8no3eaSQ1Lqvzug
         dHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2UsTg9sJleOEkW6MKHgQhUGOtlWWQFx7+63ORKNAZE=;
        b=QyM5sMyGLT+YZsoRaBMJamzZU52lDM9Yy50NUn6cT+zmE0m5QaFyGK/c/YRveqZzr1
         vR2XFRyYjVxH1r993B44qnWSNWYI2z1J2vn+DI4/Vf/nCoeNE1n52oKnaPOHQIevCtMO
         zcV+Lv8d74vn3Zc3br0Vz0KuYdvXlJw4aGyhr+v2hJrC2qvrhfCHmxF5vk2C2/Gz/d7R
         5xuXaq8QSruo2k1Bw4Kh5Wmv5OqpCztbHFSLARQF3+2JVuX8WdmIPldpONPAFhj7V6gI
         n2p2e4D86xWySsngOCzHGkAH0y50qMquP9tFVxC9a+WR5sPWFd52LSHpzCCsuzr4Loay
         WJHg==
X-Gm-Message-State: APjAAAXt0QIve735lVF0nfu6y2H0mxwCcBW1v/MzYHop9jYzfXLA7KPU
        b/232cij7QkrlpMEC/52gl6wUz6Ym7qAyol5Mq5TuLGUqC3QcPfO
X-Google-Smtp-Source: APXvYqxS6JCjgiyvsY2Q+GNa8i0iWPWiHxTM8C4cSpLLHMWeLfVPBymKfoHXZNpSg7/sCIz8N5DhB8tPpx9e6aQza1U=
X-Received: by 2002:adf:8564:: with SMTP id 91mr11037955wrh.252.1580460165016;
 Fri, 31 Jan 2020 00:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
In-Reply-To: <20200130200440.1796058-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 31 Jan 2020 09:42:34 +0100
Message-ID: <CAKv+Gu8JGC21R+ngSYtVxFDF7m2nvX=Opo1fkvdFSq-Fz_7B_Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] Remove 64-bit GDT setup in efi_main + doc fixes
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Thanks Arvind, this is good stuff.


On Thu, 30 Jan 2020 at 21:04, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> For the 64-bit kernel, we do not need to setup a GDT in efi_main, as the
> next step in the boot, startup_64, will set one up.
>

This seems obvious, but I need a nod from Ingo or Boris before I can take this.

> This series factors out the GDT setup into a separate function and
> restricts it to the 32-bit kernel. The memory allocation for the GDT is
> also changed from allocating a full page via efi_alloc_low to the
> required space (32 bytes) from alloc_pool boot service.
>

Can we go all the way and simply make this

if (IS_ENABLED(CONFIG_X64_32)) {
  static const struct desc_struct desc[] __aligned(8) = {
    {}, /* The first GDT is a dummy. */
    {}, /* Second entry is unused on 32-bit */
    GDT_ENTRY_INIT(0xa09b, 0, 0xfffff), /* __KERNEL_CS */
    GDT_ENTRY_INIT(0xc093, 0, 0xfffff), /* __KERNEL_DS */
  };
  struct desc_ptr gdt = { sizeof(desc) - 1, (unsigned long)desc };

  native_load_gdt(&gdt);
}

(and drop the #defines from eboot.h that we no longer use)

> The final two patches are doc fixes to clarify that the 32-bit EFI
> handover entry point also requires segments/GDT to be setup, and that
> for 64-bit mode we don't have any special segment requirements (the
> 64-bit doc currently is just a copy of the 32-bit doc which isn't
> right).
>
> Arvind Sankar (8):
>   efi/x86: Use C wrapper instead of inline assembly
>   efi/x86: Allocate the GDT pointer on the stack
>   efi/x86: Factor GDT setup code into a function

Given the above, I don't think we need the separate function, but if
we do, please drop the 64-bit code first, otherwise there is much more
churn than necessary.

>   efi/x86: Only setup the GDT for 32-bit kernel
>   efi/x86: Allocate only the required 32 bytes for the GDT
>   efi/x86: Change __KERNEL_{CS,DS} to __BOOT_{CS,DS}
>   Documentation/x86/boot: Clarify segment requirements for EFI handover
>   Documentation/x86/boot: Correct segment requirements for 64-bit boot
>
>  Documentation/x86/boot.rst              |  15 +-
>  arch/x86/boot/compressed/eboot.c        | 174 ++++++++++--------------
>  arch/x86/boot/compressed/efi_thunk_64.S |   4 +-
>  3 files changed, 85 insertions(+), 108 deletions(-)
>
> --
> 2.24.1
>
