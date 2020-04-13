Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E361A6EBE
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 23:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389337AbgDMVyN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389286AbgDMVyL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Apr 2020 17:54:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A45DC0A3BE2
        for <linux-efi@vger.kernel.org>; Mon, 13 Apr 2020 14:54:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so10823827wmk.5
        for <linux-efi@vger.kernel.org>; Mon, 13 Apr 2020 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2YrxFswkx7hDllVIsDVbzNNztgUR6Vkh9Ws2W9v0sU=;
        b=S9tY0EwJ0DuckJovjeInEXlrGKO2+8M+UJjAQNxtSEHCABWcJrCv/FH8NxKGKNYGgk
         eyx0wTZ5zhhpfDX1eFiNK7yAbuWgJ3GrMZ0cinZzhaqluce2O7yyc1PXRfrsWqI0N7mH
         f9iB6dT8Fbpxh4Vmc19lHugKZi/s6WM4hqAbOWtMw5baLt1tc5TNXR7//SDq/IcUyAbw
         lQVSvBUJnK4g8MhUdHCQjuoczqcMFlRzHMDNpZZyLZb1d2p7bZac1MTQ21FKk2tHTMxV
         Pv7pBwT1bKUu8LgcDVVS+Vv37thyxOSQTxmqu9lBp7VR0gtifwgNeL7cbJwW86dACaYK
         rGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2YrxFswkx7hDllVIsDVbzNNztgUR6Vkh9Ws2W9v0sU=;
        b=EEktAhpQjUr5G25xsqzuYd9CppGyQOZEiTQwK/XPYTwYTj07ohygGWX7Nxeuovq6D8
         nzzJM4KglATdsTpTbR21mzDeLMVcfTXz+/Nu+87cerZFEtRsxHBhr+QQAQDh6tPqK8rB
         edhu/Pmj9W/X8E5cfaGRD3e/lQY55ggph71cgGtAIMf12P93YfW1kvPj9KeShRELlPc8
         7EIK7Mwci91j3pe/uhfUTlx+oVf4JIpKsWoG8x8XGdt4o7Erh+C+FkZok2U4P9HQzIad
         lfFl2edLd521WgW+Oe/2g9LtFgaM6gxI6Af+l6qo1gyLS/mAMKymrzrb9ckqz1xoBhBd
         WO3Q==
X-Gm-Message-State: AGi0PuZSSPGYwwoGNfYFy6eb//G9M2zJnSJjYwqFHzudoa7exZf77HMg
        5Jow6nLzPJrIXZAp9/XvrBQUbvvfNB2ACH8CFIglOO4=
X-Google-Smtp-Source: APiQypLR+TgWBKP/kkMmQfl3pNKIeF2HWnQrkpYuKf4da4NMDuLoi6OHvBqTmJaukhMVepYAflj20L2qUMY42xQhy9s=
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr9270601wmj.186.1586814849695;
 Mon, 13 Apr 2020 14:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200413155521.24698-1-ardb@kernel.org>
In-Reply-To: <20200413155521.24698-1-ardb@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 13 Apr 2020 14:53:58 -0700
Message-ID: <CAOnJCULxNtk99sudMD5Rn5ao0orwcarOAwg7NPXMK6ZdXmwNOA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] efi/libstub: simplify arm64 kernel image loading
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, nivedita@alum.mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 13, 2020 at 8:55 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On arm64, the kernel image used to be virtually mapped via the linear
> region, making the two mappings correlated in a way that required the
> kernel to be located at the start of the linear region, or the memory
> below would not be accessible. For this reason, the EFI stub loader
> code for arm64 has the notion of a 'preferred offset' for the physical
> placement of the kernel image, and tries to put the kernel there, or
> at least as low as possible in physical memory (unless KASLR is active,
> in which case the placement is randomized)
>
> When KASLR was introduced, the virtual mapping of the kernel was moved
> into the vmalloc region, and now, regardless of whether KASLR support
> is built in or active, the kernel can be placed anywhere in physical
> memory without any detrimental side effects on the linear region.
>
> This means that we can drop the notion of 'preferred offset' entirely,
> and invoke the kernel in place if the PE/COFF loader loaded it at the
> right offset. If not, we can invoke the ordinary UEFI top down page
> allocator to reallocate it elsewhere in memory. By updating the PE/COFF
> metadata, we can inform the PE/COFF loader about the desired alignment,
> making it less likely that we need to move the kernel image in the first
> place.
>
> Ard Biesheuvel (8):
>   efi/libstub/random: align allocate size to EFI_ALLOC_ALIGN
>   efi/libstub/random: increase random alloc granularity
>   efi/libstub/arm64: replace 'preferred' offset with alignment check
>   efi/libstub/arm64: simplify randomized loading of kernel image
>   efi/libstub/arm64: align PE/COFF sections to segment alignment
>   efi/libstub: add API function to allocate aligned memory
>   efi/libstub/arm64: switch to ordinary page allocator for kernel image
>   efi/libstub: move efi_relocate_kernel() into separate source file
>
>  arch/arm64/kernel/efi-header.S             |   2 +-
>  arch/arm64/kernel/vmlinux.lds.S            |   3 +-
>  drivers/firmware/efi/libstub/Makefile      |   3 +-
>  drivers/firmware/efi/libstub/alignedmem.c  |  57 ++++++
>  drivers/firmware/efi/libstub/arm64-stub.c  |  92 +++-------
>  drivers/firmware/efi/libstub/efistub.h     |  18 +-
>  drivers/firmware/efi/libstub/mem.c         | 191 +-------------------
>  drivers/firmware/efi/libstub/randomalloc.c |   6 +-
>  drivers/firmware/efi/libstub/relocate.c    | 174 ++++++++++++++++++
>  9 files changed, 280 insertions(+), 266 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/alignedmem.c
>  create mode 100644 drivers/firmware/efi/libstub/relocate.c
>
> --
> 2.17.1
>

Oops. I just noticed this series after I sent out a v2.
I see that efi_low_alloc is removed now and the handle_kernel_image is
simplified for arm64.
I will update the risc-v uefi series accordingly. Sorry for the noise.

--
Regards,
Atish
