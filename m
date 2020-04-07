Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A14D1A111A
	for <lists+linux-efi@lfdr.de>; Tue,  7 Apr 2020 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDGQUW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Apr 2020 12:20:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgDGQUW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 7 Apr 2020 12:20:22 -0400
Received: from zn.tnic (p200300EC2F0B2700A94266E658FF3DDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:a942:66e6:58ff:3ddd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 097001EC0985;
        Tue,  7 Apr 2020 18:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586276421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E2v4mp+3szxabTU0vOlMHMQo2mBvOQe/yuXd6KzDob8=;
        b=MqDa6vPLVSrMbPyL/UHC8ccTQgiu2pjvkX7MkrP1dyXrURAPJqjV/rpZPjjVkKYw6jEiIt
        4Fizdgew4SDnnYFmJ56bkzTaU0Ap0cP7+BcCmgWDKbN1fjIKj4GUR/7hz4vRZau2K/5PXN
        FGtnRCJ9D4G5Mpan6YePGsplZoxwTvo=
Date:   Tue, 7 Apr 2020 18:20:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, nivedita@alum.mit.edu
Subject: Re: [PATCH] Documentation: efi/x86: clarify EFI handover protocol
 and its requirements
Message-ID: <20200407162017.GD9616@zn.tnic>
References: <20200407153206.17360-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407153206.17360-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 07, 2020 at 05:32:06PM +0200, Ard Biesheuvel wrote:
> The EFI handover protocol was introduced on x86 to permit the boot
> loader to pass a populated boot_params structure as an additional
> function argument to the entry point. This allows the bootloader to
> pass the base and size of a initrd image, which is more flexible
> than relying on the EFI stub's file I/O routines, which can only
> access the file system from which the kernel image itself was loaded
> from firmware.
> 
> This approach requires a fair amount of internal knowledge regarding
> the layout of the boot_params structure on the part of the boot loader,
> as well as knowledge regarding the allowed placement of the initrd in
> memory, and so it has been deprecated in favour of a new initrd loading
> method that is based on existing UEFI protocols and best practices.
> 
> So update the x86 boot protocol documentation to clarify that the EFI
> handover protocol has been deprecated, and while at it, add a note that
> invoking the EFI handover protocol still requires the PE/COFF image to
> be loader properly (as opposed to simply being copied into memory). Also,
> drop the code32_start header field from the list of values that need to be
> provided, as this is no longer required.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  Documentation/x86/boot.rst | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> index fa7ddc0428c8..22ac52921692 100644
> --- a/Documentation/x86/boot.rst
> +++ b/Documentation/x86/boot.rst
> @@ -1399,14 +1399,19 @@ must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
>  must be __BOOT_DS; interrupt must be disabled; %rsi must hold the base
>  address of the struct boot_params.
>  
> -EFI Handover Protocol
> -=====================
> +EFI Handover Protocol (deprecated)
> +==================================
>  
>  This protocol allows boot loaders to defer initialisation to the EFI
>  boot stub. The boot loader is required to load the kernel/initrd(s)
>  from the boot media and jump to the EFI handover protocol entry point
>  which is hdr->handover_offset bytes from the beginning of
>  startup_{32,64}.

Perhaps a newline here.

> +The boot loader MUST respect the kernel's PE/COFF metadata when it comes
> +to section alignment, the memory footprint of the executable image beyond
> +the size of the file itself, and any other aspect of the PE/COFF header
> +that may affect correct operation of the image as a PE/COFF binary in the
> +execution context provided by the EFI firmware.
>  
>  The function prototype for the handover entry point looks like this::
>  
> @@ -1419,9 +1424,15 @@ UEFI specification. 'bp' is the boot loader-allocated boot params.
>  
>  The boot loader *must* fill out the following fields in bp::
>  
> -  - hdr.code32_start
>    - hdr.cmd_line_ptr
>    - hdr.ramdisk_image (if applicable)
>    - hdr.ramdisk_size  (if applicable)
>  
>  All other fields should be zero.
> +
> +NOTE: The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
> +      entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
> +      loading protocol, which removes the need for any knowledge on the part of
> +      the EFI bootloader regarding the internal representation of boot_params or
> +      any requirements/limitations regarding the placement of the command line
> +      and ramdisk in memory, or the placement of the kernel image itself.

Yap, nice.

I wonder if it might be even better if that would point people to
efi_load_initrd_dev_path() or better yet to an actual example of how to
do it.

Alternatively, the comment over initrd_dev_path almost spells it out
what to do so I guess you could repeat that comment here so that it is
perfectly clear, as in "We would like you to provide us an initrd in
this exact manner." :-)

In any case, thanks!

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
