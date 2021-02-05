Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6DF310947
	for <lists+linux-efi@lfdr.de>; Fri,  5 Feb 2021 11:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhBEKip (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Feb 2021 05:38:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43168 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhBEKfq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Feb 2021 05:35:46 -0500
Received: from zn.tnic (p200300ec2f0bad000b74c3ca4e4ea61e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ad00:b74:c3ca:4e4e:a61e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B044D1EC04DF;
        Fri,  5 Feb 2021 11:35:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612521300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mpQ2H03vRziBvKFdKZ6tUIGAARtxtvomCBNzTQhxNf4=;
        b=WvoLruU+FJx9oOsfBOQwESy/LzPtM5fuXxYRrxKyg2J3ZIJoKMGA6UCqtGykPujB7eGHCP
        CE43nzJ9O5fKaW0l9aiIQXwVgIfdePyE9JH+TBeUwj7RwBidSDOO+K8MSst2DcREHXcZA2
        yNNV8rz8NpYhP3dQO7OwMudKDRYQmI0=
Date:   Fri, 5 Feb 2021 11:34:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
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
Message-ID: <20210205103457.GC17488@zn.tnic>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan>
 <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic>
 <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
 <20210203185148.GA1711888@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210203185148.GA1711888@localhost>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 03, 2021 at 11:51:48AM -0700, Nathan Chancellor wrote:
> x86_64 all{mod,yes}config with clang are going to ship broken in 5.11.

Dunno, it is still broken here even with those build assertions removed. And it
ain't even an all{mod,yes}config - just my machine's config with

CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
CONFIG_UBSAN_DIV_ZERO=y
CONFIG_UBSAN_SIGNED_OVERFLOW=y
CONFIG_UBSAN_UNSIGNED_OVERFLOW=y
CONFIG_UBSAN_OBJECT_SIZE=y
CONFIG_UBSAN_BOOL=y
CONFIG_UBSAN_ENUM=y
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set

and clang-10:

lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x253: call to __ubsan_handle_add_overflow() with UACCESS enabled
lib/strnlen_user.o: warning: objtool: strnlen_user()+0x244: call to __ubsan_handle_add_overflow() with UACCESS enabled
ld: init/main.o: in function `kmalloc':
/home/boris/kernel/linux/./include/linux/slab.h:557: undefined reference to `__ubsan_handle_alignment_assumption'
ld: init/initramfs.o: in function `kmalloc':
/home/boris/kernel/linux/./include/linux/slab.h:552: undefined reference to `__ubsan_handle_alignment_assumption'
ld: init/initramfs.o: in function `kmalloc_large':
/home/boris/kernel/linux/./include/linux/slab.h:481: undefined reference to `__ubsan_handle_alignment_assumption'
ld: init/initramfs.o: in function `kmalloc':
/home/boris/kernel/linux/./include/linux/slab.h:552: undefined reference to `__ubsan_handle_alignment_assumption'
ld: /home/boris/kernel/linux/./include/linux/slab.h:552: undefined reference to `__ubsan_handle_alignment_assumption'
ld: init/initramfs.o:/home/boris/kernel/linux/./include/linux/slab.h:552: more undefined references to `__ubsan_handle_alignment_assumption' follow
ld: mm/mremap.o: in function `get_extent':
/home/boris/kernel/linux/mm/mremap.c:355: undefined reference to `__compiletime_assert_327'
ld: mm/rmap.o: in function `anon_vma_chain_alloc':
/home/boris/kernel/linux/mm/rmap.c:136: undefined reference to `__ubsan_handle_alignment_assumption'
ld: mm/rmap.o: in function `anon_vma_alloc':
/home/boris/kernel/linux/mm/rmap.c:89: undefined reference to `__ubsan_handle_alignment_assumption'
ld: mm/rmap.o: in function `anon_vma_chain_alloc':
/home/boris/kernel/linux/mm/rmap.c:136: undefined reference to `__ubsan_handle_alignment_assumption'
ld: /home/boris/kernel/linux/mm/rmap.c:136: undefined reference to `__ubsan_handle_alignment_assumption'
ld: /home/boris/kernel/linux/mm/rmap.c:136: undefined reference to `__ubsan_handle_alignment_assumption'
ld: mm/vmalloc.o:/home/boris/kernel/linux/mm/vmalloc.c:1213: more undefined references to `__ubsan_handle_alignment_assumption' follow
make: *** [Makefile:1164: vmlinux] Error 1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
