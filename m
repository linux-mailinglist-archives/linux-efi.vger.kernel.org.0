Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50AD311009
	for <lists+linux-efi@lfdr.de>; Fri,  5 Feb 2021 19:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhBEQyG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Feb 2021 11:54:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233549AbhBEQt5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Feb 2021 11:49:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BEE864E75;
        Fri,  5 Feb 2021 18:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612549899;
        bh=ZBO58XuSLGoSIwV7OGo7aZ3r+3zbKVqiVTGcBJc1TbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eS0W03i6dAJPBLwrq1hqRWG6biv2ghW/VRQ95qDexIpMKku2X7JInKK9aImANrT2D
         OIpp4VGFTv5mFXwI49isItZfynX3QsYpbNxMKm04jlugWYzBF7vpsYa/8V84c9H/3Y
         USch21mY7kkgO1pAlCGhWmxfga1KFCS2oqfW9OPqrx0A9w3zcRcq6h7cI7UM8BHlSz
         r/WkI4uFNJ/qG6GRfSOGbX02JPPALfgg3C6fK08t1WKaOAe3urbp8Tcpz4Hp4VoEQl
         ymj9WAFGI+uXwioN9Mss9npgEPXxwKk0TVJk5E+ASgoVu+2BNkAlHlLJm9dws12AxD
         mnvmEMHLnW0pg==
Date:   Fri, 5 Feb 2021 11:31:35 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <20210205183135.GA3393009@localhost>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan>
 <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic>
 <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
 <20210203185148.GA1711888@localhost>
 <20210205103457.GC17488@zn.tnic>
 <CAKwvOdnAoNrbAs2kLng-k3L8j4hGS5HtJUv3L-pVwi+5dARQfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnAoNrbAs2kLng-k3L8j4hGS5HtJUv3L-pVwi+5dARQfg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 05, 2021 at 10:27:54AM -0800, Nick Desaulniers wrote:
> On Fri, Feb 5, 2021 at 2:35 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Feb 03, 2021 at 11:51:48AM -0700, Nathan Chancellor wrote:
> > > x86_64 all{mod,yes}config with clang are going to ship broken in 5.11.
> >
> > Dunno, it is still broken here even with those build assertions removed. And it
> > ain't even an all{mod,yes}config - just my machine's config with
> >
> > CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> > CONFIG_UBSAN=y
> > # CONFIG_UBSAN_TRAP is not set
> > CONFIG_CC_HAS_UBSAN_BOUNDS=y
> > CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
> > CONFIG_UBSAN_BOUNDS=y
> > CONFIG_UBSAN_ARRAY_BOUNDS=y
> > CONFIG_UBSAN_SHIFT=y
> > CONFIG_UBSAN_DIV_ZERO=y
> > CONFIG_UBSAN_SIGNED_OVERFLOW=y
> > CONFIG_UBSAN_UNSIGNED_OVERFLOW=y
> > CONFIG_UBSAN_OBJECT_SIZE=y
> > CONFIG_UBSAN_BOOL=y
> > CONFIG_UBSAN_ENUM=y
> > CONFIG_UBSAN_ALIGNMENT=y
> > CONFIG_UBSAN_SANITIZE_ALL=y
> > # CONFIG_TEST_UBSAN is not set
> >
> > and clang-10:
> >
> > lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x253: call to __ubsan_handle_add_overflow() with UACCESS enabled
> > lib/strnlen_user.o: warning: objtool: strnlen_user()+0x244: call to __ubsan_handle_add_overflow() with UACCESS enabled
> > ld: init/main.o: in function `kmalloc':
> > /home/boris/kernel/linux/./include/linux/slab.h:557: undefined reference to `__ubsan_handle_alignment_assumption'
> > ld: init/initramfs.o: in function `kmalloc':
> > /home/boris/kernel/linux/./include/linux/slab.h:552: undefined reference to `__ubsan_handle_alignment_assumption'
> > ld: init/initramfs.o: in function `kmalloc_large':
> > /home/boris/kernel/linux/./include/linux/slab.h:481: undefined reference to `__ubsan_handle_alignment_assumption'
> > ld: init/initramfs.o: in function `kmalloc':
> > /home/boris/kernel/linux/./include/linux/slab.h:552: undefined reference to `__ubsan_handle_alignment_assumption'
> > ld: /home/boris/kernel/linux/./include/linux/slab.h:552: undefined reference to `__ubsan_handle_alignment_assumption'
> > ld: init/initramfs.o:/home/boris/kernel/linux/./include/linux/slab.h:552: more undefined references to `__ubsan_handle_alignment_assumption' follow
> > ld: mm/mremap.o: in function `get_extent':
> > /home/boris/kernel/linux/mm/mremap.c:355: undefined reference to `__compiletime_assert_327'
> 
> ^ this one is https://lore.kernel.org/lkml/20201230154104.522605-1-arnd@kernel.org/.
> Trying to get the last of these tracked down.  I think there were some
> changes to UBSAN configs that weren't tested with clang before merged.

The rest of these should be resolved by
https://lore.kernel.org/r/20210205023257.NJnJdyyZk%25akpm@linux-foundation.org/,
which is currently on its way to Linus.

Cheers,
Nathan
