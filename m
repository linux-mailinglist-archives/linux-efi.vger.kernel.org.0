Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB2C81A1CC5
	for <lists+linux-efi@lfdr.de>; Wed,  8 Apr 2020 09:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDHHnx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Apr 2020 03:43:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54658 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726795AbgDHHnw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Apr 2020 03:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586331831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cA+LU9MO2IhF0ttoEQMdBEQPoe9aDl0ajatYj/omepg=;
        b=HtH9F7RFAT/c417X4mfi42GaO7T6D+7bhApsciJvecCNmZ5oOGXz7/6TSS5iXSSRy/T2Xl
        Gl/apum64VEfJdVanuObZLuZhAgHkKrKvbcL2BINdrjamj/4LNDW6coehzkwlIzfDyWFnZ
        2LRsc7CaWYEnTc3i1NsliBrLg6T6/HI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-_5N3BPXQOs-lcVWYCVMsjg-1; Wed, 08 Apr 2020 03:43:47 -0400
X-MC-Unique: _5N3BPXQOs-lcVWYCVMsjg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 294BFDB62;
        Wed,  8 Apr 2020 07:43:45 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-5.pek2.redhat.com [10.72.13.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9180E9DD71;
        Wed,  8 Apr 2020 07:43:38 +0000 (UTC)
Date:   Wed, 8 Apr 2020 15:43:34 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Sergey Shatunov <me@prok.pw>, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Subject: Re: [PATCH 1/2] efi/x86: Move efi stub globals from .bss to .data
Message-ID: <20200408074334.GA21886@dhcp-128-65.nay.redhat.com>
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406180614.429454-1-nivedita@alum.mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 04/06/20 at 02:06pm, Arvind Sankar wrote:
> Commit
> 
>   3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from
>   bzImage")
> 
> removed the .bss section from the bzImage.
> 
> However, while a PE loader is required to zero-initialize the .bss
> section before calling the PE entry point, the EFI handover protocol
> does not currently document any requirement that .bss be initialized by
> the bootloader prior to calling the handover entry.
> 
> When systemd-boot is used to boot a unified kernel image [1], the image
> is constructed by embedding the bzImage as a .linux section in a PE
> executable that contains a small stub loader from systemd together with
> additional sections and potentially an initrd. As the .bss section
> within the bzImage is no longer explicitly present as part of the file,
> it is not initialized before calling the EFI handover entry.
> Furthermore, as the size of the embedded .linux section is only the size
> of the bzImage file itself, the .bss section's memory may not even have
> been allocated.

I did not follow up the old report, maybe I missed something. But not
sure why only systemd-boot is mentioned here.  I also have similar issue
with early efi failure.  With these two patches applied, it works well
then.

BTW, I use Fedora 31 + Grub2

> 
> In particular, this can result in efi_disable_pci_dma being true even
> when it was not specified via the command line or configuration option,
> which in turn causes crashes while booting on some systems.
> 
> To avoid issues, place all EFI stub global variables into the .data
> section instead of .bss. As of this writing, only boolean flags for a
> few command line arguments and the sys_table pointer were in .bss and
> will now move into the .data section.
> 
> [1] https://systemd.io/BOOT_LOADER_SPECIFICATION/#type-2-efi-unified-kernel-images
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Reported-by: Sergey Shatunov <me@prok.pw>
> Fixes: 3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")
> ---
>  drivers/firmware/efi/libstub/efistub.h  | 2 +-
>  drivers/firmware/efi/libstub/x86-stub.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index cc90a748bcf0..67d26949fd26 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -25,7 +25,7 @@
>  #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
>  #endif
>  
> -#ifdef CONFIG_ARM
> +#if defined(CONFIG_ARM) || defined(CONFIG_X86)
>  #define __efistub_global	__section(.data)
>  #else
>  #define __efistub_global
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 8d3a707789de..e7af6d2eddbf 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -20,7 +20,7 @@
>  /* Maximum physical address for 64-bit kernel with 4-level paging */
>  #define MAXMEM_X86_64_4LEVEL (1ull << 46)
>  
> -static efi_system_table_t *sys_table;
> +static efi_system_table_t *sys_table __efistub_global;
>  extern const bool efi_is64;
>  extern u32 image_offset;
>  
> -- 
> 2.24.1
> 

Thanks
Dave

