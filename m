Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6DD2731FE
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 20:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgIUSdY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Sep 2020 14:33:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65333 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUSdY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Sep 2020 14:33:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41FBEFAEF7;
        Mon, 21 Sep 2020 14:33:19 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=oiZRJ65Z01rqQhOIWcIF1gPDqI0=; b=oqqrru
        9jMIdmIDIdBwL7iMfS7DUX287/Ze8k7Q9qXNjQLYrMfL1XbCPfjgex5J+zgceNtH
        1X5gzpEicsnFKrBp05I16YaWfWdvjHC/aBmidNv0OX3N2C7x0VzSVNf/+WRC5sd4
        bZLRhpkCWC29T1xnZNsKAre4re/eavlx5k8cs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38F84FAEF6;
        Mon, 21 Sep 2020 14:33:19 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=Ptc/FCC8Ze9dgvLdQtZwSt1cJOOMpBk6wQsCkVzQTJI=; b=zmPI/Nlpr/F+qvy/3TfCvQRY+AMRymZlZB0aMSSuf56+8iwgow7NnQ/Mt4JvUU07Rbl2uXnmOl7aucUungYGIXZn/YN3wii/QLuuRfhKkORiakEZeRoKoQwaR6K9ByFLhzh79JHpJs6vB8rZbR+7m/Gj5TrqxRzG4Jkm5hlulGs=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C33EFAEF4;
        Mon, 21 Sep 2020 14:33:16 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 1C64D2DA074C;
        Mon, 21 Sep 2020 14:33:14 -0400 (EDT)
Date:   Mon, 21 Sep 2020 14:33:14 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 00/10] ARM: p2v: reduce min alignment to 2 MiB
In-Reply-To: <20200921154117.757-1-ardb@kernel.org>
Message-ID: <nycvar.YSQ.7.78.906.2009211431270.2680@knanqh.ubzr>
References: <20200921154117.757-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: E9E4835A-FC38-11EA-A7C8-843F439F7C89-78420484!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 21 Sep 2020, Ard Biesheuvel wrote:

> This series is inspired by Zhei Len's series [0], which updates the
> ARM p2v patching code to optionally support p2v relative alignments
> of as little as 64 KiB.
> 
> Reducing this alignment is necessary for some specific Huawei boards,
> but given that reducing this minimum alignment will make the boot
> sequence more robust for all platforms, especially EFI boot, which
> no longer relies on the 128 MB masking of the decompressor load address,
> but uses firmware memory allocation routines to find a suitable spot
> for the decompressed kernel.
> 
> This series is not based on Zhei Len's code, but addresses the same
> problem, and takes some feedback given in the review into account:
> - use of a MOVW instruction to avoid two adds/adcs sequences when dealing
>   with the carry on LPAE
> - add support for Thumb2 kernels as well
> - make the change unconditional - it will bit rot otherwise, and has value
>   for other platforms as well.
> 
> Patch #1 fixes a BE8 bug in the existing code. 
> 
> Patch #2 incorporates a patch from a different series [1] that introduces
> the adr_l and str_l macros, for use in subsequent patches.
> 
> Patch #3 moves the p2v patching code into a separate assembler source file,
> as suggested by Nico.
> 
> Patches #4 to #8 perform some preparatory clean up to make the real changes
> easier to review, and more maintainable going forward.
> 
> Patch #9 switches the ARM/LPAE and Thumb2 p2v patchable sequences to MOVW,
> so that we can extend the size of the immediate field in a later patch.
> 
> Patch #10 increases the size of the low order immediate to 11 bits, so that
> we can deal with any physical to virtual displacement that is a multiple of
> 2 MiB.
> 
> Tested in QEMU using various permutations of the the following configuration
> options:
> - ARM mode vs Thumb2 mode
> - LE vs BE8
> - LPAE vs non-LPAE
> - 3/1 split, 2/2 split, 3/1 opt split
> 
> with the following diff applied to decompress the kernel at an address which
> is not 16 MiB aligned:
> 
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -275,6 +275,7 @@ not_angel:
>                 and     r4, r4, #0xf8000000
>                 /* Determine final kernel image address. */
>                 add     r4, r4, #TEXT_OFFSET
> +               add     r4, r4, #SZ_2M
>  #else
>                 ldr     r4, =zreladdr
>  #endif
> 
> Changes since RFC/RFT:
> - new patches #1 - #3 and #8
> - drop bogus patching of ADD/SUB instructions, which is unnecessary, and only
>   happens to work when the p2v displacement is exactly 2 GiB like on QEMU when
>   running a 3/1 split
> - use a copious amount of comments to make the code more understandable and
>   maintainable
> 
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> 
> [0] https://lore.kernel.org/linux-arm-kernel/20200915015204.2971-1-thunder.leizhen@huawei.com/
> [1] https://lore.kernel.org/linux-arm-kernel/20200914095706.3985-1-ardb@kernel.org/
> 
> Ard Biesheuvel (10):
>   ARM: p2v: fix handling of LPAE translation in BE mode
>   ARM: assembler: introduce adr_l, ldr_l and str_l macros
>   ARM: p2v: move patching code to separate assembler source file
>   ARM: p2v: factor out shared loop processing
>   ARM: p2v: factor out BE8 handling
>   ARM: p2v: drop redundant 'type' argument from __pv_stub
>   ARM: p2v: use relative references in patch site arrays
>   ARM: p2v: simplify __fixup_pv_table()
>   ARM: p2v: switch to MOVW for Thumb2 and ARM/LPAE
>   ARM: p2v: reduce p2v alignment requirement to 2 MiB
> 
>  arch/arm/Kconfig                 |   2 +-
>  arch/arm/include/asm/assembler.h |  84 +++++++
>  arch/arm/include/asm/memory.h    |  57 +++--
>  arch/arm/kernel/Makefile         |   1 +
>  arch/arm/kernel/head.S           | 142 ------------
>  arch/arm/kernel/phys2virt.S      | 238 ++++++++++++++++++++
>  6 files changed, 364 insertions(+), 160 deletions(-)
>  create mode 100644 arch/arm/kernel/phys2virt.S
> 
> -- 
> 2.17.1
> 
> 
