Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349F9314176
	for <lists+linux-efi@lfdr.de>; Mon,  8 Feb 2021 22:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhBHVPf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Feb 2021 16:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbhBHVO6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Feb 2021 16:14:58 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE323C06178B
        for <linux-efi@vger.kernel.org>; Mon,  8 Feb 2021 13:14:17 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e24so747650ioc.1
        for <linux-efi@vger.kernel.org>; Mon, 08 Feb 2021 13:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FeiA79iLSDi0k0ZMiFHmOL8NHbfXhIuWSoTn/fGVeY=;
        b=ZclT1m870hHFi+lNdB6+VkCpGEahDMU00K4AuTfI994iegwXHwBXf6+iWDUUY1LGyR
         XFQH3YCADT7wCjJhqwG6cxOmKdutCmhDRQTxpSaqhujCxhiAqHojoEXzcYSryf/Aa+ym
         WgChKCCtgJxmsswJzN5qFl0y+bHQj0H5ecmf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FeiA79iLSDi0k0ZMiFHmOL8NHbfXhIuWSoTn/fGVeY=;
        b=AT9lgNeU6RFbqkkxWLyuj2+3uMacO68fsNtTiTeBnn3K4cgcO+8WZsLaZn5lES5Ck4
         UsLTiTphsxKj5yyJKfwlVS+h9dG32Cy59lbQg/6vPfSba8xxEvdxe7s/dgFGzxf41UA1
         v9rfpx52iC2mtuku9mMtXVQbCTlk860J1KBXwZGhw+05Z3s7xrMME/w8Emn7iJ6V8kfa
         WijHb2xxSP1VhfJGvospgnBSajIDBvuF36XG/fu8+5svOXRPJqR+hw6KT18jceEPbTnN
         z320KKExeFB0TYVA4EvxTqL/nra0Sk8Xe6pzha2BYcfQdlSOq3+7lx9d2rquzRovt5tS
         pctA==
X-Gm-Message-State: AOAM531ilUYahEg1T+8z6UEDE4QZx5P7TMngKL1QaliIUwPywtlgeMv1
        0tFgKEL6/WsMeij/aHNuxCQjmayPq90fysYcCeyW
X-Google-Smtp-Source: ABdhPJy0kax2flx8hj7WBbhdgj5nWwuM1G6DARrTIESg+pfqzKkTAS3xb9t2X4Tbcm8zJFirRtRmlKFMR1eDtkR0g5M=
X-Received: by 2002:a05:6602:2d4d:: with SMTP id d13mr16157926iow.0.1612818857262;
 Mon, 08 Feb 2021 13:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20210206100115.58074-1-xypron.glpk@gmx.de>
In-Reply-To: <20210206100115.58074-1-xypron.glpk@gmx.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 8 Feb 2021 13:14:06 -0800
Message-ID: <CAOnJCUJ+CvBHt1MXzGn2Hmc2J-NZYdxf4MGka7sh1SmozTbWCg@mail.gmail.com>
Subject: Re: [PATCH] docs: update EFI stub description
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Feb 6, 2021 at 2:02 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> * Mention RISC-V.
> * Update code references.
> * initrd= does not specify a path relative on the ESP but to the partition
>   from which the EFI stub was loaded (as specified in the loaded image
>   protocol).
> * Mention that ACPI tables and device trees are alternatives.
> * Provide the FDT GUID.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  Documentation/admin-guide/efi-stub.rst | 47 +++++++++++++++-----------
>  1 file changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
> index 833edb0d0bc4..9e1bb79e8655 100644
> --- a/Documentation/admin-guide/efi-stub.rst
> +++ b/Documentation/admin-guide/efi-stub.rst
> @@ -8,15 +8,20 @@ it as an EFI executable. The code that modifies the bzImage header,
>  along with the EFI-specific entry point that the firmware loader
>  jumps to are collectively known as the "EFI boot stub", and live in
>  arch/x86/boot/header.S and arch/x86/boot/compressed/eboot.c,
> -respectively. For ARM the EFI stub is implemented in
> -arch/arm/boot/compressed/efi-header.S and
> -arch/arm/boot/compressed/efi-stub.c. EFI stub code that is shared
> -between architectures is in drivers/firmware/efi/libstub.
> +respectively. For ARM the EFI stub entry point is implemented in
> +arch/arm/boot/compressed/efi-header.S.
>
> -For arm64, there is no compressed kernel support, so the Image itself
> -masquerades as a PE/COFF image and the EFI stub is linked into the
> -kernel. The arm64 EFI stub lives in arch/arm64/kernel/efi-entry.S
> -and drivers/firmware/efi/libstub/arm64-stub.c.
> +For ARM64 and RISC-V, there is no compressed kernel support, so the Image
> +itself masquerades as a PE/COFF image and the EFI stub is linked into the
> +kernel. The EFI stub entry point is in  arch/ARM64/kernel/efi-entry.S for
> +ARM64 and in arch/riscv/kernel/efi-header.S for RISC-V.
> +
> +EFI stub code that is shared between architectures is in
> +drivers/firmware/efi/libstub.
> +
> +The common secondary entry point efi_pe_entry() for ARM, ARM64, and RISC-V
> +into the stub is in drivers/firmware/efi/libstub/efi-stub.c while x86 uses
> +drivers/firmware/efi/libstub/x86-stub.c.
>
>  By using the EFI boot stub it's possible to boot a Linux kernel
>  without the use of a conventional EFI boot loader, such as grub or
> @@ -35,7 +40,7 @@ the extension the EFI firmware loader will refuse to execute it. It's
>  not possible to execute bzImage.efi from the usual Linux file systems
>  because EFI firmware doesn't have support for them. For ARM the
>  arch/arm/boot/zImage should be copied to the system partition, and it
> -may not need to be renamed. Similarly for arm64, arch/arm64/boot/Image
> +may not need to be renamed. Similarly for ARM64, arch/arm64/boot/Image
>  should be copied but not necessarily renamed.
>

Should we change the title of the paragraph to something like "How to
install EFI image"
 RISC-V image location can be added as well.
>
> @@ -55,10 +60,11 @@ multiple initrd files using the "initrd=" option. This is the only EFI
>  stub-specific command line parameter, everything else is passed to the
>  kernel when it boots.
>
> -The path to the initrd file must be an absolute path from the
> -beginning of the ESP, relative path names do not work. Also, the path
> -is an EFI-style path and directory elements must be separated with
> -backslashes (\). For example, given the following directory layout::
> +The path to the initrd file must be an absolute path from the beginning of
> +the partition from which the kernel was loaded, relative path names do not
> +work. Also, the path is an EFI-style path and directory elements must be
> +separated with backslashes (\). For example, given the following directory
> +layout::
>
>    fs0:>
>         Kernels\
> @@ -83,18 +89,19 @@ is passed to bzImage.efi.
>  The "dtb=" option
>  -----------------
>
> -For the ARM and arm64 architectures, a device tree must be provided to
> -the kernel. Normally firmware shall supply the device tree via the
> -EFI CONFIGURATION TABLE. However, the "dtb=" command line option can
> -be used to override the firmware supplied device tree, or to supply
> -one when firmware is unable to.
> +If ACPI tables are not available, a device tree must be provided to the
> +kernel. Normally the firmware shall supply the device tree as an EFI
> +configuration table with GUID b1b621d5-f19c-41a5-830b-d9152c69aae0.
> +However, the "dtb=" command line option can be used to override the
> +firmware supplied device tree, or to supply one when firmware is unable
> +to.
>
>  Please note: Firmware adds runtime configuration information to the
>  device tree before booting the kernel. If dtb= is used to override
>  the device tree, then any runtime data provided by firmware will be
>  lost. The dtb= option should only be used either as a debug tool, or
> -as a last resort when a device tree is not provided in the EFI
> -CONFIGURATION TABLE.
> +as a last resort when a device tree is not provided as an EFI
> +configuration table.
>

Some more clarification is required here as this option is only
enabled with EFI_ARMSTUB_DTB_LOADER.
That config option is not enabled for RISC-V to avoid legacy.

>  "dtb=" is processed in the same manner as the "initrd=" option that is
>  described above.
> --
> 2.30.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
