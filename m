Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB0396FF1
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jun 2021 11:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhFAJIq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Jun 2021 05:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233252AbhFAJIp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Jun 2021 05:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622538424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wwyq+d8kaa3gE2iFZ3mOrS7Gyye0u9Y9IgFDFZTKJ9s=;
        b=PjC+qSHS6V1NGrAXD5AscFZzz+FCrIKqy69DJ/XnCmiRBDvYVINI1hhUhBah+tNm+k7jfx
        +kIzT5SSzULJoFP6gynBq0OCGuK5MxLyPCudF5r8OXbXpEtuv1cGH+yXWTT4tOCgIasIZ2
        rG33uo9BqJ2ew1clunfrjinvjKu77RE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-ZIwBcJjnPNS5dwTQpNN6pw-1; Tue, 01 Jun 2021 05:07:03 -0400
X-MC-Unique: ZIwBcJjnPNS5dwTQpNN6pw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DEB4803624;
        Tue,  1 Jun 2021 09:07:00 +0000 (UTC)
Received: from localhost (ovpn-13-211.pek2.redhat.com [10.72.13.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49D6469108;
        Tue,  1 Jun 2021 09:06:56 +0000 (UTC)
Date:   Tue, 1 Jun 2021 17:06:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/setup: always reserve the first 1M of RAM
Message-ID: <20210601090653.GB361405@MiWiFi-R3L-srv>
References: <20210601075354.5149-1-rppt@kernel.org>
 <20210601075354.5149-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601075354.5149-2-rppt@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 06/01/21 at 10:53am, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
......  

> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 7850111008a8..b15ebfe40a73 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -450,6 +450,18 @@ void __init efi_free_boot_services(void)
>  			size -= rm_size;
>  		}

Thanks for taking care of the low-1M excluding in
efi_free_boot_services(), Mike. You might want to remove the old real
mode excluding code either since it's been covered by your new code.

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index b15ebfe40a73..be814f2089ff 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -409,7 +409,6 @@ void __init efi_free_boot_services(void)
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
 		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
-		size_t rm_size;
 
 		if (md->type != EFI_BOOT_SERVICES_CODE &&
 		    md->type != EFI_BOOT_SERVICES_DATA) {
@@ -430,26 +429,6 @@ void __init efi_free_boot_services(void)
 		 */
 		efi_unmap_pages(md);
 
-		/*
-		 * Nasty quirk: if all sub-1MB memory is used for boot
-		 * services, we can get here without having allocated the
-		 * real mode trampoline.  It's too late to hand boot services
-		 * memory back to the memblock allocator, so instead
-		 * try to manually allocate the trampoline if needed.
-		 *
-		 * I've seen this on a Dell XPS 13 9350 with firmware
-		 * 1.4.4 with SGX enabled booting Linux via Fedora 24's
-		 * grub2-efi on a hard disk.  (And no, I don't know why
-		 * this happened, but Linux should still try to boot rather
-		 * panicking early.)
-		 */
-		rm_size = real_mode_size_needed();
-		if (rm_size && (start + rm_size) < (1<<20) && size >= rm_size) {
-			set_real_mode_mem(start);
-			start += rm_size;
-			size -= rm_size;
-		}
-
 		/*
 		 * Don't free memory under 1M for two reasons:
 		 * - BIOS might clobber it

>  
> +		/*
> +		 * Don't free memory under 1M for two reasons:
> +		 * - BIOS might clobber it
> +		 * - Crash kernel needs it to be reserved
> +		 */
> +		if (start + size < SZ_1M)
> +			continue;
> +		if (start < SZ_1M) {
> +			size -= (SZ_1M - start);
> +			start = SZ_1M;
> +		}
> +
>  		memblock_free_late(start, size);
>  	}
>  
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 2e1c1bec0f9e..8ea285aca827 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -29,14 +29,16 @@ void __init reserve_real_mode(void)
>  
>  	/* Has to be under 1M so we can execute real-mode AP code. */
>  	mem = memblock_find_in_range(0, 1<<20, size, PAGE_SIZE);
> -	if (!mem) {
> +	if (!mem)
>  		pr_info("No sub-1M memory is available for the trampoline\n");
> -		return;
> -	}
> +	else
> +		set_real_mode_mem(mem);
>  
> -	memblock_reserve(mem, size);
> -	set_real_mode_mem(mem);
> -	crash_reserve_low_1M();
> +	/*
> +	 * Unconditionally reserve the entire fisrt 1M, see comment in
> +	 * setup_arch()
> +	 */
> +	memblock_reserve(0, SZ_1M);
>  }
>  
>  static void sme_sev_setup_real_mode(struct trampoline_header *th)
> -- 
> 2.28.0
> 

