Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1221130A2
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 18:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfLDRRy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 12:17:54 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37379 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDRRy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 12:17:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so520179qtk.4
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 09:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uJmxSM90BwOzzfnCIuJaV9fTmYo4GaP5ZVkBe3GqlAQ=;
        b=p62RXt/9TccQo8gUT6RUoVqezJF5HJZYGPQFcY/Q0vOTplwkif/Dflq4JNR96iE9Dc
         zd4GIMWIminNeEcO9hrDw9lRTenDYwN/x7MFE9HYNLLq/nT/yEtYDt0La+Lua+/XIhBG
         yLrADh2/j6IEvT5G9vjns0Vb4PPjYg6sP+GTuS3y4xvCmC56h5GuW35lvQFT6Rn0AWP/
         hEzdigz1bErHRa7F7bPstEZEP3kSIK3X/F4AR4OMWWcFdxQzjKrVSlcgi9x5VLmpDS6T
         c/FpvAKgHio3G6Q6LXsz1UfnbO9U+dGxYMfMYboZYFLKLj7O/ExjCp3xSz9nK+JPAtp8
         zKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJmxSM90BwOzzfnCIuJaV9fTmYo4GaP5ZVkBe3GqlAQ=;
        b=oqyDuySTFS00MCiWQ+1w8F9FuNfuqzxPgDWMaVYXeaV4Xb2Q/RHM89bvA9QSdHjeRT
         Iwai5/f0sLHoStN26S8DjwSwdT7ByErfbWTSYiLwAn+L+5fs2F5iZqY5xB1eFUKN0+Tt
         LWaM07L1GXzJv1JQjii6haCY7j3g/01F/LXN4W1t4KArzABLrcu43e/LqUIgie3qo20o
         cKpaeaD+z6BqrAb4RbNhfjSljAch/SdRAbhPLjNJ8w/LZwBRpPmYeOJj2Ci6i27k3BlD
         w4tsavTwiPyw+x7DzFOOa8WXgVVhYmHzqTz5t9+HI7zCOR839UFLGPM9MmbsAq39EX+m
         R/Gg==
X-Gm-Message-State: APjAAAW6OT/juOIR4rs2RyV6lbRgmICA0+RPv7o+xAm2VNBMMt7lAJhz
        ARfSCLmBp0uw5MZyj7wDjzZLeeM=
X-Google-Smtp-Source: APXvYqyFjloF4HHs2p8CJyaWpYiWdOKbFhcP8ySf1aoAj3Li0WFsP5nOT3NwG6pJkCbokqe5UPb+HQ==
X-Received: by 2002:ac8:4509:: with SMTP id q9mr3619553qtn.214.1575479871519;
        Wed, 04 Dec 2019 09:17:51 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id y184sm3950517qkd.128.2019.12.04.09.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 09:17:50 -0800 (PST)
Date:   Wed, 4 Dec 2019 12:17:44 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, mark.rutland@arm.com,
        james.morse@arm.com, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        d.hatayama@fujitsu.com, kexec@lists.infradead.org
Subject: Re: [PATCH] efi/memreserve: register reservations as 'reserved' in
 /proc/iomem
Message-ID: <20191204171744.o3ijdspnelqn5fgd@gabell>
References: <20191204145233.11962-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204145233.11962-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ard,

Thank you for sending the patch, but unfortunately it doesn't work for the issue...

After applied your patch, the LPI tables are marked as reserved in
/proc/iomem like as:

80300000-a1fdffff : System RAM
  80480000-8134ffff : Kernel code
  81350000-817bffff : reserved
  817c0000-82acffff : Kernel data
  830f0000-830fffff : reserved # Property table
  83480000-83480fff : reserved # Pending table
  83490000-8349ffff : reserved # Pending table

However, kexec tries to allocate memory from System RAM, it doesn't care
the reserved in System RAM.

Following example, kexec allocates memory 0x82ad0000-0x86640000 to locate
the initrd, and LPI tables are also in the memory region, so LPI tables
will be destroyed by kexec reboot.

# kexec -d -l /boot/vmlinuz-5.4.1+ --initrd=/boot/initramfs-5.4.1+.img
...
initrd: base 82ad0000, size 3b67c6fh (62291055)
...
segment[1].mem   = 0x82ad0000
segment[1].memsz = 0x3b70000   # 0x86640000 (== 0x82ad0000 + 0x3b70000)
...

I'm not sure why kexec doesn't care the reserved in System RAM, however,
if the kexec behaivor is right, the LPI tables should not belong to
System RAM.
Like as:

80300000-830effff : System RAM
  80480000-8134ffff : Kernel code
  81350000-817bffff : reserved
  817c0000-82acffff : Kernel data
830f0000-830fffff : reserved # Property table
83480000-83480fff : reserved # Pending table
83490000-8349ffff : reserved # Pending table
834a0000-a1fdffff : System RAM

I don't have ideas to separete LPI tables from System RAM... so I tried
to add a new file to inform the LPI tables to userspace.

Thanks,
Masa

On Wed, Dec 04, 2019 at 02:52:33PM +0000, Ard Biesheuvel wrote:
> Memory regions that are reserved using efi_mem_reserve_persistent()
> are recorded in a special EFI config table which survives kexec,
> allowing the incoming kernel to honour them as well. However,
> such reservations are not visible in /proc/iomem, and so the kexec
> tools that load the incoming kernel and its initrd into memory may
> overwrite these reserved regions before the incoming kernel has a
> chance to reserve them from further use.
> 
> So add these reservations to /proc/iomem as they are created. Note
> that reservations that are inherited from a previous kernel are
> memblock_reserve()'d early on, so they are already visible in
> /proc/iomem.
> 
> Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Cc: d.hatayama@fujitsu.com
> Cc: kexec@lists.infradead.org
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/efi.c | 29 ++++++++++++++++++--
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index d101f072c8f8..fcd82dde23c8 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -979,6 +979,24 @@ static int __init efi_memreserve_map_root(void)
>  	return 0;
>  }
>  
> +static int efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
> +{
> +	struct resource *res, *parent;
> +
> +	res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	res->name	= "reserved";
> +	res->flags	= IORESOURCE_MEM;
> +	res->start	= addr;
> +	res->end	= addr + size - 1;
> +
> +	/* we expect a conflict with a 'System RAM' region */
> +	parent = request_resource_conflict(&iomem_resource, res);
> +	return parent ? request_resource(parent, res) : 0;
> +}
> +
>  int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>  {
>  	struct linux_efi_memreserve *rsv;
> @@ -1001,9 +1019,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>  		if (index < rsv->size) {
>  			rsv->entry[index].base = addr;
>  			rsv->entry[index].size = size;
> -
>  			memunmap(rsv);
> -			return 0;
> +			return efi_mem_reserve_iomem(addr, size);
>  		}
>  		memunmap(rsv);
>  	}
> @@ -1013,6 +1030,12 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>  	if (!rsv)
>  		return -ENOMEM;
>  
> +	rc = efi_mem_reserve_iomem(__pa(rsv), SZ_4K);
> +	if (rc) {
> +		free_page(rsv);
> +		return rc;
> +	}
> +
>  	/*
>  	 * The memremap() call above assumes that a linux_efi_memreserve entry
>  	 * never crosses a page boundary, so let's ensure that this remains true
> @@ -1029,7 +1052,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>  	efi_memreserve_root->next = __pa(rsv);
>  	spin_unlock(&efi_mem_reserve_persistent_lock);
>  
> -	return 0;
> +	return efi_mem_reserve_iomem(addr, size);
>  }
>  
>  static int __init efi_memreserve_root_init(void)
> -- 
> 2.17.1
> 
> 
> 
