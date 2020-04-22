Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A0D1B3B95
	for <lists+linux-efi@lfdr.de>; Wed, 22 Apr 2020 11:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgDVJjw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Apr 2020 05:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgDVJjw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 22 Apr 2020 05:39:52 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8246C20775
        for <linux-efi@vger.kernel.org>; Wed, 22 Apr 2020 09:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587548391;
        bh=Cg6T/SYVV/2J7W3DhazFD9nfMftXA1YfQexPq+h/CkM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AFt0Xo0LdGBLRY7Chz4X8OIlX5NKUyagMyjilcIpP5Go+V3YJB9h1+YnSFZflGTjy
         lwk/0y7r5h/i4ooVwNW8wWPYZTzLtRwdSJCSgrUUP6cZeYSTZJPDMNmnxGs5sKc0Mi
         liCdCphAnrq8D6yvMh2ZeugICHbhgGaX/jm8mrlc=
Received: by mail-io1-f54.google.com with SMTP id w4so1635438ioc.6
        for <linux-efi@vger.kernel.org>; Wed, 22 Apr 2020 02:39:51 -0700 (PDT)
X-Gm-Message-State: AGi0PuaT5zDV7bPPCqzI+yoVxzUlLgZnNx1/FZ4c4YjEbtArk4+W/AOf
        WQps5TFWnEAHjZnPdoEtHACgDF9Egkx00edfyJE=
X-Google-Smtp-Source: APiQypKVq/myAx/zWRC6bt+1NqJbnUETAsMrlK6tFF+J/wKNjtlPYy2uH/OckKdmTGWLoDLoyx/H5mHDCpqqLocp590=
X-Received: by 2002:a02:7785:: with SMTP id g127mr23973436jac.134.1587548390869;
 Wed, 22 Apr 2020 02:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200413155521.24698-1-ardb@kernel.org> <20200413155521.24698-6-ardb@kernel.org>
In-Reply-To: <20200413155521.24698-6-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 22 Apr 2020 11:39:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFrzfKerYNL1c+iS33uMR++3w673kxg93bGfdG7ohWJsA@mail.gmail.com>
Message-ID: <CAMj1kXFrzfKerYNL1c+iS33uMR++3w673kxg93bGfdG7ohWJsA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] efi/libstub/arm64: align PE/COFF sections to
 segment alignment
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 13 Apr 2020 at 17:55, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The arm64 kernel's segment alignment is fixed at 64 KB for any page
> size, and relocatable kernels are able to fix up any misalignment of
> the kernel image with respect to the 2 MB section alignment that is
> mandated by the arm64 boot protocol.
>
> Let's increase the PE/COFF section alignment to the same value, so that
> kernels loaded by the UEFI PE/COFF loader are guaranteed to end up at
> an address that doesn't require any reallocation to be done if the
> kernel is relocatable.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/efi-header.S  | 2 +-
>  arch/arm64/kernel/vmlinux.lds.S | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>

Catalin, Will: any thoughts whether this should go via the arm64 tree
or the EFI tree? It is part of a change on the EFI side to stop
needlessly copying the kernel around before boot, but this particular
change could go through either tree, as it is not build time
dependency for the EFI changes, nor does it have a boot time impact
beyond making it more likely that the copy can be elided (but the code
still needs to deal with the possibility that it cannot be elided in
any case)



> diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
> index 914999ccaf8a..6f58998ef647 100644
> --- a/arch/arm64/kernel/efi-header.S
> +++ b/arch/arm64/kernel/efi-header.S
> @@ -32,7 +32,7 @@ optional_header:
>
>  extra_header_fields:
>         .quad   0                                       // ImageBase
> -       .long   SZ_4K                                   // SectionAlignment
> +       .long   SEGMENT_ALIGN                           // SectionAlignment
>         .long   PECOFF_FILE_ALIGNMENT                   // FileAlignment
>         .short  0                                       // MajorOperatingSystemVersion
>         .short  0                                       // MinorOperatingSystemVersion
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 497f9675071d..1d399db0644f 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -175,7 +175,7 @@ SECTIONS
>                 *(.altinstr_replacement)
>         }
>
> -       . = ALIGN(PAGE_SIZE);
> +       . = ALIGN(SEGMENT_ALIGN);
>         __inittext_end = .;
>         __initdata_begin = .;
>
> @@ -246,6 +246,7 @@ SECTIONS
>         . += INIT_DIR_SIZE;
>         init_pg_end = .;
>
> +       . = ALIGN(SEGMENT_ALIGN);
>         __pecoff_data_size = ABSOLUTE(. - __initdata_begin);
>         _end = .;
>
> --
> 2.17.1
>
