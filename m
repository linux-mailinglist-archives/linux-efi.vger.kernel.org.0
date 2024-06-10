Return-Path: <linux-efi+bounces-1188-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB209023C0
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 16:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7DC1F2627D
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAC67E767;
	Mon, 10 Jun 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BoYbLXII"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD084D2A;
	Mon, 10 Jun 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028740; cv=none; b=EOGTeN6zp3UTQ9apjUbL0WPostvRS+ORIqEzXJlAHK/upL2t7NunPCwgs7Rhzlmweytzr/jiKyzML0bH0qQ6yvlTXbUbdzpKWgskq2m+zOb+tOPhtu5OLPLa9yarWphqpRT4FsNN3N0msCJZjkRZU2bGkc21HoqWDgVljWj/iEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028740; c=relaxed/simple;
	bh=xAFr7ozPpI8DuqOfWnDR2BQJvB3UgfxfbtowfoYvgBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXLYGMAALBMLF96R8MZ6lOfsDN0zRLoL5H2yowSzOljO62hOE8pzomZpc7HH5E7Szk/F+d/lj61225SCcebma1kthq402DCEPuG54C+H3LDJ6RqZKMNxf6i6FwgSgoiVSt7DeaaJs+q32u49zWAfhtmX0T2FZ43OsXPczgdDVxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BoYbLXII; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B0F2240E0081;
	Mon, 10 Jun 2024 14:12:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F7bdWQwRfOpn; Mon, 10 Jun 2024 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718028731; bh=Q2BNtRklMm/oGfJO8WR6592/uoN7Ou98TXBAEZPJFRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoYbLXIII6dSl9aiajG6s2LxJqHKd/s7l4nNyqmMDOP2bRiVZ0iTtpm6TKADwME4N
	 wArWddpsjvrLPgPDWLgD1WHJ+hzrc8JNf+qAycwhzoJS8foAdSe2txy9OMDGZUcHm9
	 VXMGVV67YV5l67JlWTz62j0f/j/X48QkcM2SOce1Lx5SabCRmUbdDCwM4TaYVj+DsB
	 IyfimZsImk0SsPaX9wEmy7t8qdjzm6tD1sgGqjHbkikddhG2VzVxp9Z7byN8fNUX/z
	 o2ZTeGehghmYIQE0Mpe14EtT3SrvVDKJPMo7B9fmwG31EQg61TzF8Y6yUvAdOmnuwz
	 3gkp6l9QSlCdVOtI1Z65UiJA2asaXPZnY77IctA5Pr4afwKZk1izoi0D2cRHEK8boW
	 ssZWIP10I9eH5WW+SbVJwmVco+PtwCM77zrHbEod9tNWhxVROMjVQL6EmGdjPEDNsh
	 PbBJMvFMyqSk0UqG4c7mgYL1rk2r96tfNdV1XZdBLlVRtEuBZDrsEUG3WFY1jrF86U
	 AKg6f2sj+j5CmTPIdbnqquMg3c0ZhpqqGrOMI2CoylYSNwGfcBoDNfydhjQt0t2W8a
	 2GtecUwBf76J8YRte/zVR1Ah4b57Mno+EMfqNFUAxBWMEL+fwTulfTqdUkTXyWbfdT
	 8a+0+f0deAtdXSa06zIOjUxw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 537B840E0027;
	Mon, 10 Jun 2024 14:12:02 +0000 (UTC)
Date: Mon, 10 Jun 2024 16:11:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Ashish Kalra <Ashish.Kalra@amd.com>, Dave Young <dyoung@redhat.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] x86/efi: Free EFI memory map only when installing a new
 one.
Message-ID: <20240610141156.GDZmcJrEi11xESpy3a@fat_crate.local>
References: <20240610140932.2489527-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240610140932.2489527-2-ardb+git@google.com>

+ Dan because of

f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")

Thanks Ard.

On Mon, Jun 10, 2024 at 04:09:33PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The logic in __efi_memmap_init() is shared between two different
> execution flows:
> - mapping the EFI memory map early or late into the kernel VA space, so
>   that its entries can be accessed;
> - cloning the EFI memory map in order to insert new entries that are
>   created as a result of creating a memory reservation
>   (efi_arch_mem_reserve())
> 
> In the former case, the underlying memory containing the kernel's view
> of the EFI memory map (which may be heavily modified by the kernel
> itself on x86) is not modified at all, and the only thing that changes
> is the virtual mapping of this memory, which is different between early
> and late boot.
> 
> In the latter case, an entirely new allocation is created that carries a
> new, updated version of the kernel's view of the EFI memory map. When
> installing this new version, the old version will no longer be
> referenced, and if the memory was allocated by the kernel, it will leak
> unless it gets freed.
> 
> The logic that implements this freeing currently lives on the code path
> that is shared between these two use cases, but it should only apply to
> the latter. So move it to the correct spot.
> 
> Cc: Ashish Kalra <Ashish.Kalra@amd.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Link: https://lore.kernel.org/all/36ad5079-4326-45ed-85f6-928ff76483d3@amd.com
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/platform/efi/memmap.c | 5 +++++
>  drivers/firmware/efi/memmap.c  | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
> index 4ef20b49eb5e..4990244e5168 100644
> --- a/arch/x86/platform/efi/memmap.c
> +++ b/arch/x86/platform/efi/memmap.c
> @@ -97,6 +97,11 @@ int __init efi_memmap_install(struct efi_memory_map_data *data)
>  	if (efi_enabled(EFI_PARAVIRT))
>  		return 0;
>  
> +	if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
> +		__efi_memmap_free(efi.memmap.phys_map,
> +				  efi.memmap.desc_size * efi.memmap.nr_map,
> +				  efi.memmap.flags);
> +
>  	return __efi_memmap_init(data);
>  }
>  
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 3365944f7965..3759e95a7407 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -51,11 +51,6 @@ int __init __efi_memmap_init(struct efi_memory_map_data *data)
>  		return -ENOMEM;
>  	}
>  
> -	if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
> -		__efi_memmap_free(efi.memmap.phys_map,
> -				  efi.memmap.desc_size * efi.memmap.nr_map,
> -				  efi.memmap.flags);
> -
>  	map.phys_map = data->phys_map;
>  	map.nr_map = data->size / data->desc_size;
>  	map.map_end = map.map + data->size;
> -- 
> 2.45.2.505.gda0bf45e8d-goog
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

