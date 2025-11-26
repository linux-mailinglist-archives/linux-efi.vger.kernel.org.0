Return-Path: <linux-efi+bounces-5705-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96239C8C38A
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 23:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 491024E1BF9
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 22:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C5284690;
	Wed, 26 Nov 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FKCD5IxZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E21FF7C7;
	Wed, 26 Nov 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764196328; cv=none; b=JQ6Qj9HlZvtfCQLYtoccagpnUTM1vVIcS4nxC2P4VQC2qqcQ0OYEVnPbvpi6DHQ0BfE0TEB2z220NzXYIWwtz1gbZIxvRZdEx03NFkk7ODZo60r9LNJEM6UrBH1o7bLF63LWXYpI32K3hCHfgWJlexB4HqBNTCjceC045IIs5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764196328; c=relaxed/simple;
	bh=YLjnLursXl70/WK1VKLykhQl4P+HAG9kGWxxvGu02iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRAELGYA8wse1SRGVw1AApj9kXxb8+PGEyepcvym4cJo4dEWMVmofUxX671PV0HdDIRqLihOxhkumBxta5WcqXo7xSskAxGYV/8IWQSSyFBAe5zTmb63uGkdigokthLAg0SLsq+okmZSeRmjbU1ssfybk2qQxqS9UbgASUItGv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FKCD5IxZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5D96040E0200;
	Wed, 26 Nov 2025 22:31:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 78zWO8m3eFdW; Wed, 26 Nov 2025 22:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764196310; bh=OCGX52XkArpHRB0malEGuxEN88kirZhyxtG2hjA3Tq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKCD5IxZ9QnWpJ6q9qf720njFD3v3xcOuhp5akzBOPGn6LfBpD4pj0ZRi215bvnVd
	 rKEuDt62gtO0ZqxVH2oUTEnSjivuz2c5IgvYkFx5NADGFttr8SDsZljG7VXKm0n1Ki
	 4ZAlNYITs7YAbfwbdT9Ylcfo3LXCtUC+6avsoBBVWULZ+cAt3eFZBLWcKM3jvyXxHy
	 av9ayYWfs3vN6OBlkiYz59JuXysW9VOO0SbTilZ4AfAfpzh2H9kpFQafx7VfPQzn2g
	 7PaxTQ7lDppVk2FXZIeGEwWDrcuz01l1Wya8Q/cG2hBII2Ua0+YTJzLBy912OBy58s
	 ibqqNlyXL4kcshkVFPIz7cy7+oZfFi5c7x8tSDMo0F3n6SnePE3SLI4wbX/BjtepN5
	 eCTagNmjXqK80RWzpUjNdYE475JTEyMkWyu8cjqAHGhT99lbonn8ztHu3fq5KGVBKy
	 MQRG/ovQYMfx3yKxblEa/XgnKAOQyg3c7u+ZqwvzOe60qEyxxlRVBc2bzCiJvEONz6
	 10t+lqAl0vM6B6lllVejc/uCvaJpOI/H/BW25LegEM2ut6aoXvZ+cKflFwt13yvb9/
	 AUbFn2SRxndw4kmPfncF0MmlINuHIdLn6DvLTdPNqq8rUFgGh+wnbsgGwSdULm3881
	 zPwSiP/GKjKYduli36CePJ0k=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 021BF40E01CD;
	Wed, 26 Nov 2025 22:31:33 +0000 (UTC)
Date: Wed, 26 Nov 2025 23:31:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "Pratik R. Sampat" <prsampat@amd.com>, linux-mm@kvack.org,
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, ardb@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
	thomas.lendacky@amd.com, michael.roth@amd.com
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>

On Wed, Nov 26, 2025 at 11:12:13AM +0000, Kiryl Shutsemau wrote:
> > diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
> > index 4f7027f33def..a220a1966cae 100644
> > --- a/arch/x86/boot/compressed/efi.h
> > +++ b/arch/x86/boot/compressed/efi.h
> > @@ -102,6 +102,7 @@ struct efi_unaccepted_memory {
> >  	u32 unit_size;
> >  	u64 phys_base;
> >  	u64 size;
> > +	bool mem_reserved;
> >  	unsigned long *bitmap;
> >  };
> >  
> 
> Again, this is ABI break for kexec.

ABI break for kexec? Is that a thing?

Since when do we enforce ABI compatibility for kexec and where are we
documenting that?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

