Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5C330FFF6
	for <lists+linux-efi@lfdr.de>; Thu,  4 Feb 2021 23:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBDWOE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Feb 2021 17:14:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47090 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhBDWOC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 4 Feb 2021 17:14:02 -0500
Received: from zn.tnic (p200300ec2f0c7e0006ca03b6d355ef00.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7e00:6ca:3b6:d355:ef00])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F35AF1EC03C1;
        Thu,  4 Feb 2021 23:13:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612476801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qUcBmX7dmaTykemYNBo1gvegAj0QB+Et810B66xa7FI=;
        b=RMPqKhZGJ2bsiL2depyJvChrKeZSRXFqHO1SPI2325gfkUEJ6lEUVP3xOpz9fuOUPhtXIP
        DSpjZAgR5lyHa4OQyWPjDntaH0rAGuEcgsqomb6ErD2IoSb1wztiyB0kIgcOqrWwuJtRn7
        XHMmPJxqnj/GX8ybRcZtbX2XyPKQARA=
Date:   Thu, 4 Feb 2021 23:13:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <20210204221318.GI32255@zn.tnic>
References: <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan>
 <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic>
 <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
 <20210203185148.GA1711888@localhost>
 <CAMj1kXFPOvkcw573wzKzMQOgT-nddFcAZo9M4Lk+idn_1UBbnA@mail.gmail.com>
 <20210204105155.GA32255@zn.tnic>
 <YBxqnosGDroAnpio@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBxqnosGDroAnpio@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 04, 2021 at 04:43:58PM -0500, Arvind Sankar wrote:
> This should check EFI_VA_END instead of EFI_VA_START, and maybe throw in
> a BUG_ON if EFI_VA_END >= EFI_VA_START.

No need:

        if (efi_va < EFI_VA_END) {
                pr_warn(FW_WARN "VA address range overflow!\n");
                return;
        }

We already check we're not going over at map time. And our runtime
services range is hardcoded. And we're switching to that PGD on each
runtime services call.

So I don't see the point for keeping any of the assertions.

Unless you have other valid arguments for keeping them...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
