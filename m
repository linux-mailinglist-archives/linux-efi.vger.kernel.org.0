Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37B13D523E
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jul 2021 06:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhGZDau (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Jul 2021 23:30:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:45915 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhGZDat (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 25 Jul 2021 23:30:49 -0400
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 16Q495Dp031409;
        Sun, 25 Jul 2021 23:09:06 -0500
Message-ID: <2567059e36501744b83c76f4646b073fabb4b1fd.camel@kernel.crashing.org>
Subject: Re: [PATCH] efistub: arm64: relax 2M alignment again for
 relocatable kernels
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
Date:   Mon, 26 Jul 2021 14:09:05 +1000
In-Reply-To: <20210722102600.58392-1-ardb@kernel.org>
References: <20210722102600.58392-1-ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2021-07-22 at 12:26 +0200, Ard Biesheuvel wrote:
> Commit 82046702e288 ("efi/libstub/arm64: Replace 'preferred' offset with
> alignment check") simplified the way the stub moves the kernel image
> around in memory before booting it, given that a relocatable image does
> not need to be copied to a 2M aligned offset if it was loaded on a 64k
> boundary by EFI.
> 
> Commit d32de9130f6c ("efi/arm64: libstub: Deal gracefully with
> EFI_RNG_PROTOCOL failure") inadvertently defeated this logic by
> overriding the value of efi_nokaslr if EFI_RNG_PROTOCOL is not
> available, which was mistaked by the loader logic as an explicit request
> on the part of the user to disable KASLR and any associated relocation
> of an Image not loaded on a 2M boundary.
> 
> So let's reinstate this functionality, by capturing the value of
> efi_nokaslr at function entry to choose the minimum alignment.
> 
> Fixes: d32de9130f6c ("efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure")
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> This fixes the regression that was discussed in [0], but given that it
> is very likely to break Ben's use case again, I'll sit on it for the
> time being.

The bug is in the version of grub carried by some distros actually. The
stricter alignment forces the stub to reallocate the image in ways that
manages to generally avoid it (but it's all luck). Long story short:
those grubs don't allocate room for the kernel bss (and don't zero it),
thus there's a chance for it to overlap other pre-boot allocations such
as EFI runtime services, the initrd, fdt, whatever else...

So the kernel will break more often with this patch until grub is fixed
in those distros (working on it ...).

Note: If you work on a distro and you carry the grub2 patch that takes
out LoadImage/StartImage from grub-core/loader/arm64/linux.c in favor
of the shim lock protocol, poke me, I have a patch for you :)

Cheers,
Ben.


