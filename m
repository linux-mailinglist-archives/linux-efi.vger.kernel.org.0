Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A2D27719F
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgIXMvy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 08:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgIXMvw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Sep 2020 08:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600951911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJBRoQhryzoD/4RnzQOqOmlzEp2ggdRKtKgYCaMeG6A=;
        b=RfrkcRVL7OkRyiV5LpNeF2yp7O0YwSdKtx+1IlyRjLpCVKCiET7ON9QeL07WoDSB5AgA/C
        9vlk2wxnUgdTqMw7VEN0nOIvgfWYTqmGPKzbl5B2v/YwU+XaGMNigsNKN+CX72Ky5PWjcH
        h6LF2tyyL28/wsU0prpHx7S7asLCy9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-jTyAVLvbOW2tgWvQV8BXQw-1; Thu, 24 Sep 2020 08:51:49 -0400
X-MC-Unique: jTyAVLvbOW2tgWvQV8BXQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BC6556B59;
        Thu, 24 Sep 2020 12:51:48 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-35.ams2.redhat.com [10.36.114.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 788175BBDC;
        Thu, 24 Sep 2020 12:51:47 +0000 (UTC)
Subject: Re: [PATCH] efi: add definition of EFI_MEMORY_CPU_CRYPTO and ability
 to report it
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
References: <20200924115619.20740-1-ardb@kernel.org>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <48b4ff00-733e-9e2c-0e24-a7b50f3ab685@redhat.com>
Date:   Thu, 24 Sep 2020 14:51:46 +0200
MIME-Version: 1.0
In-Reply-To: <20200924115619.20740-1-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 09/24/20 13:56, Ard Biesheuvel wrote:
> Incorporate the definition of EFI_MEMORY_CPU_CRYPTO from the UEFI
> specification v2.8, and wire it into our memory map dumping routine
> as well.
> 
> To make a bit of space in the output buffer, which is provided by
> the various callers, shorten the descriptive names of the memory
> types.
> 
> Cc: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> This could be split into two or even three patches, but this might need
> to go into -stable as well, so presented as a single patch.
> 
>  drivers/firmware/efi/efi.c | 47 ++++++++++----------
>  include/linux/efi.h        |  1 +
>  2 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 3aa07c3b5136..ebb59e52294f 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -714,7 +714,7 @@ void __init efi_systab_report_header(const efi_table_hdr_t *systab_hdr,
>  		vendor);
>  }
>  
> -static __initdata char memory_type_name[][20] = {
> +static __initdata char memory_type_name[][13] = {
>  	"Reserved",
>  	"Loader Code",
>  	"Loader Data",
> @@ -722,14 +722,14 @@ static __initdata char memory_type_name[][20] = {
>  	"Boot Data",
>  	"Runtime Code",
>  	"Runtime Data",
> -	"Conventional Memory",
> -	"Unusable Memory",
> -	"ACPI Reclaim Memory",
> -	"ACPI Memory NVS",
> -	"Memory Mapped I/O",
> -	"MMIO Port Space",
> +	"Conventional",
> +	"Unusable",
> +	"ACPI Reclaim",
> +	"ACPI Mem NVS",
> +	"MMIO",
> +	"MMIO Port",
>  	"PAL Code",
> -	"Persistent Memory",
> +	"Persistent",
>  };
>  
>  char * __init efi_md_typeattr_format(char *buf, size_t size,
> @@ -756,26 +756,27 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
>  	if (attr & ~(EFI_MEMORY_UC | EFI_MEMORY_WC | EFI_MEMORY_WT |
>  		     EFI_MEMORY_WB | EFI_MEMORY_UCE | EFI_MEMORY_RO |
>  		     EFI_MEMORY_WP | EFI_MEMORY_RP | EFI_MEMORY_XP |
> -		     EFI_MEMORY_NV | EFI_MEMORY_SP |
> +		     EFI_MEMORY_NV | EFI_MEMORY_SP | EFI_MEMORY_CPU_CRYPTO |
>  		     EFI_MEMORY_RUNTIME | EFI_MEMORY_MORE_RELIABLE))
>  		snprintf(pos, size, "|attr=0x%016llx]",
>  			 (unsigned long long)attr);
>  	else
>  		snprintf(pos, size,
> -			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
> -			 attr & EFI_MEMORY_RUNTIME ? "RUN" : "",
> -			 attr & EFI_MEMORY_MORE_RELIABLE ? "MR" : "",
> -			 attr & EFI_MEMORY_SP      ? "SP"  : "",
> -			 attr & EFI_MEMORY_NV      ? "NV"  : "",
> -			 attr & EFI_MEMORY_XP      ? "XP"  : "",
> -			 attr & EFI_MEMORY_RP      ? "RP"  : "",
> -			 attr & EFI_MEMORY_WP      ? "WP"  : "",
> -			 attr & EFI_MEMORY_RO      ? "RO"  : "",
> -			 attr & EFI_MEMORY_UCE     ? "UCE" : "",
> -			 attr & EFI_MEMORY_WB      ? "WB"  : "",
> -			 attr & EFI_MEMORY_WT      ? "WT"  : "",
> -			 attr & EFI_MEMORY_WC      ? "WC"  : "",
> -			 attr & EFI_MEMORY_UC      ? "UC"  : "");
> +			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
> +			 attr & EFI_MEMORY_RUNTIME		? "RUN" : "",
> +			 attr & EFI_MEMORY_MORE_RELIABLE	? "MR"  : "",
> +			 attr & EFI_MEMORY_CPU_CRYPTO   	? "CC"  : "",
> +			 attr & EFI_MEMORY_SP			? "SP"  : "",
> +			 attr & EFI_MEMORY_NV			? "NV"  : "",
> +			 attr & EFI_MEMORY_XP			? "XP"  : "",
> +			 attr & EFI_MEMORY_RP			? "RP"  : "",
> +			 attr & EFI_MEMORY_WP			? "WP"  : "",
> +			 attr & EFI_MEMORY_RO			? "RO"  : "",
> +			 attr & EFI_MEMORY_UCE			? "UCE" : "",
> +			 attr & EFI_MEMORY_WB			? "WB"  : "",
> +			 attr & EFI_MEMORY_WT			? "WT"  : "",
> +			 attr & EFI_MEMORY_WC			? "WC"  : "",
> +			 attr & EFI_MEMORY_UC			? "UC"  : "");
>  	return buf;
>  }
>  
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 6f9dc44d6d8e..9cc8b11d26de 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -122,6 +122,7 @@ typedef	struct {
>  				((u64)0x0000000000010000ULL)	/* higher reliability */
>  #define EFI_MEMORY_RO		((u64)0x0000000000020000ULL)	/* read-only */
>  #define EFI_MEMORY_SP		((u64)0x0000000000040000ULL)	/* soft reserved */
> +#define EFI_MEMORY_CPU_CRYPTO	((u64)0x0000000000080000ULL)	/* supports encryption */
>  #define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
>  #define EFI_MEMORY_DESCRIPTOR_VERSION	1
>  
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

