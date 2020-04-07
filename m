Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8DC1A1046
	for <lists+linux-efi@lfdr.de>; Tue,  7 Apr 2020 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgDGPfj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Apr 2020 11:35:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46520 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgDGPfj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Apr 2020 11:35:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id g74so1550769qke.13;
        Tue, 07 Apr 2020 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VVevqv5RlYHEcc+VsjM+owOd+nD3tCu0YjZUMtZz+2E=;
        b=lLC8DsKJm4ae32XuTyENAFQ7tiTN+O/hWLs2IA0fs7KcgrsRV35TfQfxfZPwO0fECQ
         gPutAwzeLbJ1IOfB0Y1rs6Xm5wK2xfwCf5BMrnKRYR9H4SMxEBiW/8gb0+UFMHRWo/ke
         bxc7iYuoSpc5js44pnAxjKBTfFPBZsu8iBwoURTouYO2CeOCM7u7xy69JnxXdQYvhYNI
         LX87NbojQWNDUD+CLU22hh2g0LseuKH6QCYoAhvBWmiKfs19GMEmqXPwph5veTuqkRji
         XjGkVdxx/b0to+rBhIvaY/APqrwYQZyJQWrwoI4XB8om0p6Ogv3rYVmXC0UyEruI8/5k
         1dkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VVevqv5RlYHEcc+VsjM+owOd+nD3tCu0YjZUMtZz+2E=;
        b=IMcqNQNywmjAMrZY17oiFnl9S78zV5Dy8EPAkskdRLQXNIBKha9nFPJxFxl0nh+ZzD
         hYQxhj/8VEcPKzjMnzElqDEs4jq/aGZqcgcj8zUYPRIkSHgki7QDrRAvYjoK9dHeovB6
         nwzHTssrja+p43A3A7QlOrU2F1oz44w/omHqbOYgzxHlkjDSpb0tFso0FkCTYZI/vV8e
         FtTIbth05X0yKc9OWV1I80nBHcIgZMM4UKAYp8q/YzAt/FncwYKaMvoais8n4h/cbxaf
         h0B24yLg37h638KSbAzYzX6Q9F5x1OOuyJRykNLT171P1lCGeHxLbROgNe914qxmCZ+e
         KfQQ==
X-Gm-Message-State: AGi0Pub8/sqsDdA6lBqOsjWHJ3RF2HQHd9dba3bfmfdBjridFnaNnoTv
        +8sQ53VzpFIfk1a4hhkwvmw=
X-Google-Smtp-Source: APiQypLtjpuhHon36gDSxT/FeQxQ6So32gl0ImI03OBCbpdz9zSQPJyJaFdN5IxqvqxgxhD405xb0Q==
X-Received: by 2002:a05:620a:13ae:: with SMTP id m14mr2851662qki.214.1586273737786;
        Tue, 07 Apr 2020 08:35:37 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h13sm8337986qkj.21.2020.04.07.08.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 08:35:37 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 7 Apr 2020 11:35:35 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, nivedita@alum.mit.edu,
        bp@alien8.de
Subject: Re: [PATCH] Documentation: efi/x86: clarify EFI handover protocol
 and its requirements
Message-ID: <20200407153535.GA1627475@rani.riverdale.lan>
References: <20200407153206.17360-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407153206.17360-1-ardb@kernel.org>
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
     ^^ typo
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
> -- 
> 2.17.1
> 
