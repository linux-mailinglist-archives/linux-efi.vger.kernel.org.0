Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D0359EFB
	for <lists+linux-efi@lfdr.de>; Fri,  9 Apr 2021 14:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhDIMpK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Apr 2021 08:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231370AbhDIMpK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Apr 2021 08:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617972297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvnPWZA5WYAbjq6DAmDLsT765wKi9L7F6ktZ4467iS8=;
        b=TlibWYSu6rfGbUxTnQRv9azQv/5iSA+K79K4hgZOjl33p0HE+TxcQo0A6KcInDkf59oUQI
        pyKed8YRLYncUatGkJtV/Naaewj9ZAICVAzwbpdUTFN8i4KOFJcmjNOOpmyemZVPamUOmx
        KMxFY9K2PHEtrzEMGVMDdgrMRxt1z3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-xe4MRLsANf-LYo9N6WjUpQ-1; Fri, 09 Apr 2021 08:44:53 -0400
X-MC-Unique: xe4MRLsANf-LYo9N6WjUpQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81DA7107ACCD;
        Fri,  9 Apr 2021 12:44:51 +0000 (UTC)
Received: from localhost (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A66660BE5;
        Fri,  9 Apr 2021 12:44:46 +0000 (UTC)
Date:   Fri, 9 Apr 2021 20:44:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, x86@kernel.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dvhart@infradead.org, andy@infradead.org,
        hpa@zytor.com, kexec@lists.infradead.org, dyoung@redhat.com
Subject: Re: [PATCH] x86/efi: Do not release sub-1MB memory regions when the
 crashkernel option is specified
Message-ID: <20210409124443.GA20513@MiWiFi-R3L-srv>
References: <20210407140316.30210-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407140316.30210-1-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 04/07/21 at 10:03pm, Lianbo Jiang wrote:
> Some sub-1MB memory regions may be reserved by EFI boot services, and the
> memory regions will be released later in the efi_free_boot_services().
> 
> Currently, always reserve all sub-1MB memory regions when the crashkernel
> option is specified, but unfortunately EFI boot services may have already
> reserved some sub-1MB memory regions before the crash_reserve_low_1M() is
> called, which makes that the crash_reserve_low_1M() only own the
> remaining sub-1MB memory regions, not all sub-1MB memory regions, because,
> subsequently EFI boot services will free its own sub-1MB memory regions.
> Eventually, DMA will be able to allocate memory from the sub-1MB area and
> cause the following error:
> 

So this patch is fixing a problem found in crash utility. We ever met
the similar issue, later fixed by always reserving low 1M in commit
6f599d84231fd27 ("x86/kdump: Always reserve the low 1M when the crashkernel
option is specified"). Seems the commit is not fixing it completely.

> crash> kmem -s |grep invalid
> kmem: dma-kmalloc-512: slab: ffffd52c40001900 invalid freepointer: ffff9403c0067300
> kmem: dma-kmalloc-512: slab: ffffd52c40001900 invalid freepointer: ffff9403c0067300
> crash> vtop ffff9403c0067300
> VIRTUAL           PHYSICAL
> ffff9403c0067300  67300   --->The physical address falls into this range [0x0000000000063000-0x000000000008efff]
> 
> kernel debugging log:
> ...
> [    0.008927] memblock_reserve: [0x0000000000010000-0x0000000000013fff] efi_reserve_boot_services+0x85/0xd0
> [    0.008930] memblock_reserve: [0x0000000000063000-0x000000000008efff] efi_reserve_boot_services+0x85/0xd0
> ...
> [    0.009425] memblock_reserve: [0x0000000000000000-0x00000000000fffff] crash_reserve_low_1M+0x2c/0x49
> ...
> [    0.010586] Zone ranges:
> [    0.010587]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.010589]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.010591]   Normal   [mem 0x0000000100000000-0x0000000c7fffffff]
> [    0.010593]   Device   empty
> ...
> [    8.814894] __memblock_free_late: [0x0000000000063000-0x000000000008efff] efi_free_boot_services+0x14b/0x23b
> [    8.815793] __memblock_free_late: [0x0000000000010000-0x0000000000013fff] efi_free_boot_services+0x14b/0x23b


In commit 6f599d84231fd27, we call crash_reserve_low_1M() to lock the
whole low 1M area if crashkernel is specified in kernel cmdline.
But earlier efi_reserve_boot_services() invokation will break the
intention of the whole low 1M reserving. In efi_reserve_boot_services(),
if any memory under low 1M hasn't been reserved, it will call
memblock_reserve() to reserve it and leave it to
efi_free_boot_services() to free.

Hi Lianbo,

Please correct me if I am wrong or anything is missed. IIUC, can we move
efi_reserve_boot_services() after reserve_real_mode() to fix this bug?
Or move reserve_real_mode() before efi_reserve_boot_services() since
those real mode regions are all under 1M? Assume efi boot code/data
won't rely on low 1M area any more at this moment.

Thanks
Baoquan

> 
> Do not release sub-1MB memory regions even though they are reserved by
> EFI boot services, so that always reserve all sub-1MB memory regions when
> the crashkernel option is specified.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/platform/efi/quirks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 67d93a243c35..637f932c4fd4 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -18,6 +18,7 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/realmode.h>
>  #include <asm/reboot.h>
> +#include <asm/cmdline.h>
>  
>  #define EFI_MIN_RESERVE 5120
>  
> @@ -303,6 +304,19 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>   */
>  static __init bool can_free_region(u64 start, u64 size)
>  {
> +	/*
> +	 * Some sub-1MB memory regions may be reserved by EFI boot
> +	 * services, and these memory regions will be released later
> +	 * in the efi_free_boot_services().
> +	 *
> +	 * Do not release sub-1MB memory regions even though they are
> +	 * reserved by EFI boot services, because, always reserve all
> +	 * sub-1MB memory when the crashkernel option is specified.
> +	 */
> +	if (cmdline_find_option(boot_command_line, "crashkernel", NULL, 0) > 0
> +		&& (start + size < (1<<20)))
> +		return false;
> +
>  	if (start + size > __pa_symbol(_text) && start <= __pa_symbol(_end))
>  		return false;
>  
> -- 
> 2.17.1
> 

