Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5914A166651
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 19:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBTSaG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 13:30:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42638 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgBTSaG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Feb 2020 13:30:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so5718592wrd.9
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 10:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rpcE/RwUFcc0SDsm9ejjXXsVqa+BppFjkRUEvinhf4Q=;
        b=0UhvMwLpSQTQKF4fGL2Kzg8XXbMh5iYsjGE79A6icNxEepbvH+bMk9YWgTOlQET2oR
         gPp7WwE9z6T6t3/jGbl7HoKhAMzB14P9dRPnJivNzPGXL+Ekmkucb+5qxn2dkqjsfEJm
         gK2huI0mYaK6Uc6LsCsnsSQbAWAQUrJLwSBYPDcMnwe70WJZT8OFS/jc3ZtWRysEw9uz
         /5Co/wHaDmYmSSc2wK5jLRiz8Cch3XrEI1CIU7RMu7S2Q4yYiNPUPkGb3+LdWE+bzrog
         LlS/N9XcalRkxqyx1TiNSL6EvYXXP0qmopcNTzU71WvnpiI8/UEysxeY2dQMHVPeYEUf
         xkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rpcE/RwUFcc0SDsm9ejjXXsVqa+BppFjkRUEvinhf4Q=;
        b=ZR2tT9KwoLaxnNWq5D+VHTxgZuLP1jeXDZ616qqJe4mckpOeJ5c49q7O26ypW6O5hq
         EVihaTBWButzyg4jb+/O5Ukr9q6zjd70ejWLy6TvFYWuZ5XaNKP8V/viqpvTp2HZUgKx
         oVP+jFHIIRvLfXpln0hn2WIHtocaPwy26ETNLylO2cn+Igm6Thc10bih+jnIP1H7Cd9D
         tKZ4AjCLQ2RhOKsriEt+qF6OUEyYTvqh2GfN/q4I85WWpfh3xrxKs+sL8btCI5MUH3Xu
         LQK2UV9txKyO/pnXMiJDWfbIRuBvmpS4/SjkR2Hd0HNPwLGEVOtHoaL74Eu+oezRjakQ
         IPpg==
X-Gm-Message-State: APjAAAWMVmHfN1+C3GY6CzLyFKq7Xnj7WZvFqKeJj0SeVExshDHfsXTX
        tF4PcGS1B9RRLD3Zs6zIZrHa6Q==
X-Google-Smtp-Source: APXvYqxqXyv0X+BkWYCzwSSpwZm52wJdjImOFNbuLxX9cBOAw7OEeImvi4bPZe0O2M55ElxHwjHAzQ==
X-Received: by 2002:adf:f401:: with SMTP id g1mr42843118wro.129.1582223403229;
        Thu, 20 Feb 2020 10:30:03 -0800 (PST)
Received: from bivouac.eciton.net (bivouac.eciton.net. [2a00:1098:0:86:1000:23:0:2])
        by smtp.gmail.com with ESMTPSA id q14sm481830wrj.81.2020.02.20.10.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 10:30:02 -0800 (PST)
Date:   Thu, 20 Feb 2020 18:30:01 +0000
From:   Leif Lindholm <leif@nuviainc.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        atish.patra@wdc.com
Subject: Re: [PATCH 3/3] efi/arm: rewrite FDT param discovery routines
Message-ID: <20200220183001.GE23627@bivouac.eciton.net>
References: <20200219152440.11561-1-ardb@kernel.org>
 <20200219152440.11561-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219152440.11561-4-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 19, 2020 at 16:24:40 +0100, Ard Biesheuvel wrote:
> The efi_get_fdt_params() routine uses the early OF device tree
> traversal helpers, that iterate over each node in the DT and invoke
> a caller provided callback that can inspect the node's contents and
> look for the required data. This requires a special param struct to
> be passed around, with pointers into param enumeration structs that
> contain (and duplicate) property names and offsets into yet another
> struct that carries the collected data.
> 
> Since we know the data we look for is either under /hypervisor/uefi
> or under /chosen, it is much simpler to use the libfdt routines
> directly, and try to grab a reference to either node directly, and
> read each property in sequence.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/fdtparams.c | 203 ++++++++------------
>  1 file changed, 85 insertions(+), 118 deletions(-)
> 
> diff --git a/drivers/firmware/efi/fdtparams.c b/drivers/firmware/efi/fdtparams.c
> index 7a384b307c56..23af4062e913 100644
> --- a/drivers/firmware/efi/fdtparams.c
> +++ b/drivers/firmware/efi/fdtparams.c
> @@ -5,154 +5,121 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/efi.h>
> -#include <linux/of.h>
> +#include <linux/libfdt.h>
>  #include <linux/of_fdt.h>
>  
> -#include <asm/early_ioremap.h>
> +#include <asm/unaligned.h>
>  
> -#define UEFI_PARAM(name, prop, field)			   \
> -	{						   \
> -		{ name },				   \
> -		{ prop },				   \
> -		offsetof(struct efi_fdt_params, field),    \
> -		sizeof_field(struct efi_fdt_params, field) \
> -	}
> -
> -struct efi_fdt_params {
> -	u64 system_table;
> -	u64 mmap;
> -	u32 mmap_size;
> -	u32 desc_size;
> -	u32 desc_ver;
> -};
> -
> -struct params {
> -	const char name[32];
> -	const char propname[32];
> -	int offset;
> -	int size;
> +enum {
> +	SYSTAB,
> +	MMBASE,
> +	MMSIZE,
> +	DCSIZE,
> +	DCVERS,
>  };
>  
> -static __initdata struct params fdt_params[] = {
> -	UEFI_PARAM("System Table", "linux,uefi-system-table", system_table),
> -	UEFI_PARAM("MemMap Address", "linux,uefi-mmap-start", mmap),
> -	UEFI_PARAM("MemMap Size", "linux,uefi-mmap-size", mmap_size),
> -	UEFI_PARAM("MemMap Desc. Size", "linux,uefi-mmap-desc-size", desc_size),
> -	UEFI_PARAM("MemMap Desc. Version", "linux,uefi-mmap-desc-ver", desc_ver)
> +static __initconst const char name[][22] = {

I was going to complain about that 22, and I still think it looks a
bit iffy, but I can't find a compiler that doesn't throw a warning if
the value changes, so I guess I'm being over sensitive.

> +	[SYSTAB] = "System Table         ",
> +	[MMBASE] = "MemMap Address       ",
> +	[MMSIZE] = "MemMap Size          ",
> +	[DCSIZE] = "MemMap Desc. Size    ",
> +	[DCVERS] = "MemMap Desc. Version ",
>  };
>  
> -static __initdata struct params xen_fdt_params[] = {
> -	UEFI_PARAM("System Table", "xen,uefi-system-table", system_table),
> -	UEFI_PARAM("MemMap Address", "xen,uefi-mmap-start", mmap),
> -	UEFI_PARAM("MemMap Size", "xen,uefi-mmap-size", mmap_size),
> -	UEFI_PARAM("MemMap Desc. Size", "xen,uefi-mmap-desc-size", desc_size),
> -	UEFI_PARAM("MemMap Desc. Version", "xen,uefi-mmap-desc-ver", desc_ver)
> -};
> -
> -#define EFI_FDT_PARAMS_SIZE	ARRAY_SIZE(fdt_params)
> -
> -static __initdata struct {
> -	const char *uname;
> -	const char *subnode;
> -	struct params *params;
> +static __initconst const struct {
> +	const char	path[17];
> +	const char	params[5][26];

And I guess the same is true here, but the 5 *could* theoretically be
replaced by a compile-time calculation of DCVERS - SYSTAB + 1. That
may not be less error prone however. Finishing the enum on a
somethingMAX entry might make it slightly better?

But the error checking isn't really what I'm after, but getting rid of
the opaqueness. Could we have comments about which specific string
lengths we're matching against here for us bears of very little brain?

/
    Leif

>  } dt_params[] = {
> -	{ "hypervisor", "uefi", xen_fdt_params },
> -	{ "chosen", NULL, fdt_params },
> -};
> -
> -struct param_info {
> -	int found;
> -	void *params;
> -	const char *missing;
> +#ifdef CONFIG_XEN
> +	{
> +		"/hypervisor/uefi",
> +		{
> +			[SYSTAB] = "xen,uefi-system-table",
> +			[MMBASE] = "xen,uefi-mmap-start",
> +			[MMSIZE] = "xen,uefi-mmap-size",
> +			[DCSIZE] = "xen,uefi-mmap-desc-size",
> +			[DCVERS] = "xen,uefi-mmap-desc-ver",
> +		}
> +	},
> +#endif
> +	{
> +		"/chosen",
> +		{
> +			[SYSTAB] = "linux,uefi-system-table",
> +			[MMBASE] = "linux,uefi-mmap-start",
> +			[MMSIZE] = "linux,uefi-mmap-size",
> +			[DCSIZE] = "linux,uefi-mmap-desc-size",
> +			[DCVERS] = "linux,uefi-mmap-desc-ver",
> +		}
> +	}
>  };
>  
> -static int __init __find_uefi_params(unsigned long node,
> -				     struct param_info *info,
> -				     struct params *params)
> +static int __init efi_get_fdt_prop(const void *fdt, int node, int dtp, int pp,
> +				   void *var, int size)
>  {
>  	const void *prop;
> -	void *dest;
> +	int len;
>  	u64 val;
> -	int i, len;
>  
> -	for (i = 0; i < EFI_FDT_PARAMS_SIZE; i++) {
> -		prop = of_get_flat_dt_prop(node, params[i].propname, &len);
> -		if (!prop) {
> -			info->missing = params[i].name;
> -			return 0;
> -		}
> -
> -		dest = info->params + params[i].offset;
> -		info->found++;
> +	prop = fdt_getprop(fdt, node, dt_params[dtp].params[pp], &len);
> +	if (!prop) {
> +		pr_err("Can't find property '%s' in device tree!\n",
> +		       dt_params[dtp].params[pp]);
> +		return 1;
> +	}
>  
> -		val = of_read_number(prop, len / sizeof(u32));
> +	val = (len == 4) ? (u64)be32_to_cpup(prop) : get_unaligned_be64(prop);
>  
> -		if (params[i].size == sizeof(u32))
> -			*(u32 *)dest = val;
> -		else
> -			*(u64 *)dest = val;
> +	if (size == 8)
> +		*(u64 *)var = val;
> +	else
> +		*(u32 *)var = (val <= U32_MAX) ? val : U32_MAX; // saturate
>  
> -		if (efi_enabled(EFI_DBG))
> -			pr_info("  %s: 0x%0*llx\n", params[i].name,
> -				params[i].size * 2, val);
> -	}
> +	if (efi_enabled(EFI_DBG))
> +		pr_info("  %s: 0x%0*llx\n", name[pp], size * 2, val);
>  
> -	return 1;
> +	return 0;
>  }
>  
> -static int __init fdt_find_uefi_params(unsigned long node, const char *uname,
> -				       int depth, void *data)
> +u64 __init efi_get_fdt_params(struct efi_memory_map_data *mm)
>  {
> -	struct param_info *info = data;
> +	const void *fdt = initial_boot_params;
> +	unsigned long systab;
> +	struct {
> +		void	*var;
> +		int	size;
> +	} target[] = {
> +		[SYSTAB] = { &systab,		sizeof(systab) },
> +		[MMBASE] = { &mm->phys_map,	sizeof(mm->phys_map) },
> +		[MMSIZE] = { &mm->size,		sizeof(mm->size) },
> +		[DCSIZE] = { &mm->desc_size,	sizeof(mm->desc_size) },
> +		[DCVERS] = { &mm->desc_version,	sizeof(mm->desc_version) },
> +	};
>  	int i;
>  
> +	BUILD_BUG_ON(ARRAY_SIZE(target) != ARRAY_SIZE(name));
> +	BUILD_BUG_ON(ARRAY_SIZE(target) != ARRAY_SIZE(dt_params[0].params));
> +
>  	for (i = 0; i < ARRAY_SIZE(dt_params); i++) {
> -		const char *subnode = dt_params[i].subnode;
> +		int node;
> +		int j;
>  
> -		if (depth != 1 || strcmp(uname, dt_params[i].uname) != 0) {
> -			info->missing = dt_params[i].params[0].name;
> +		node = fdt_path_offset(fdt, dt_params[i].path);
> +		if (node < 0)
>  			continue;
> -		}
>  
> -		if (subnode) {
> -			int err = of_get_flat_dt_subnode_by_name(node, subnode);
> +		if (efi_enabled(EFI_DBG))
> +			pr_info("Getting UEFI parameters from %s in DT:\n",
> +				dt_params[i].path);
>  
> -			if (err < 0)
> +		for (j = 0; j < ARRAY_SIZE(target); j++) {
> +			if (efi_get_fdt_prop(fdt, node, i, j, target[j].var,
> +					     target[j].size)) {
>  				return 0;
> -
> -			node = err;
> +			}
>  		}
> -
> -		return __find_uefi_params(node, info, dt_params[i].params);
> +		return systab;
>  	}
> -
> +	pr_info("UEFI not found.\n");
>  	return 0;
>  }
> -
> -u64 __init efi_get_fdt_params(struct efi_memory_map_data *memmap)
> -{
> -	struct efi_fdt_params params;
> -	struct param_info info;
> -	int ret;
> -
> -	pr_info("Getting EFI parameters from FDT:\n");
> -
> -	info.found = 0;
> -	info.params = &params;
> -
> -	ret = of_scan_flat_dt(fdt_find_uefi_params, &info);
> -	if (!info.found) {
> -		pr_info("UEFI not found.\n");
> -		return 0;
> -	} else if (!ret) {
> -		pr_err("Can't find '%s' in device tree!\n", info.missing);
> -		return 0;
> -	}
> -
> -	memmap->desc_version	= params.desc_ver;
> -	memmap->desc_size	= params.desc_size;
> -	memmap->size		= params.mmap_size;
> -	memmap->phys_map	= params.mmap;
> -
> -	return params.system_table;
> -}
> -- 
> 2.17.1
> 
