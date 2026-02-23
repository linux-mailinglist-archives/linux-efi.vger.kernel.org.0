Return-Path: <linux-efi+bounces-6201-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TM2oONA8nGkkCAQAu9opvQ
	(envelope-from <linux-efi+bounces-6201-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 12:41:04 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336591759D3
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 12:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F2CB300D448
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C223644AD;
	Mon, 23 Feb 2026 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G75sdQiC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05DB3624D7;
	Mon, 23 Feb 2026 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846860; cv=none; b=nkS4/acL7fyr3Jwn1pRmNqqZknYoikQ+GCn4kAfI/ChvhntIbOpafUqbL3+VQkGgTYj6BTpddlSaVhx13+TYZvDH88X2M2n7KHDFgILQiO0X2TIURr9nxTQsdOY8ffLwdn47OJ4ku7nsDkKYrDNTmVntDXefNQaFi10pt+CtsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846860; c=relaxed/simple;
	bh=qrXa/Wr53xTJqgHdzVRXulaaQTYzTEAq+rdxL37Pyos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8Oz7VP8nKPh+uXjWYQTOdTuMXu87ATaSh01J3UHc4SbcpufUfzXuEqKXd5KOOBdWomSp0dyDKsn62pLNlcusiqouxXKLUVFM654phdZFb4/mx9c5AHQcHdgDwfPStM/hfYuQe/iF+yJORp8ha50ofw9oiflBL/h6Ra3L6awQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G75sdQiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0950C116C6;
	Mon, 23 Feb 2026 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771846860;
	bh=qrXa/Wr53xTJqgHdzVRXulaaQTYzTEAq+rdxL37Pyos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G75sdQiCUW2hAwslW/UziV6cmDnamVeOib744rgleMOjenaV1r49JpJsGpuADv/bm
	 MOuQuuo4Rfg64VRkqPgxnqsOmi6vvW0EkBLi6QGlJbnNlGjVkHMiUg8M00vF9U79Iu
	 W7qgQ2gRB9YoS7FJU1KOO84nGrJgKLY2qKQHxcyJpvK7DVTtrXPkQ44U3uzx3NEgF6
	 V1g4om58LSSMy1tmul2XG6bV1YXrrkF9oRfXPBsXpNVZ2j8rG5KqTt1+txUafiTKDn
	 f0efF1hjGJr2j2Fh8A1wsRaBfIewJvAFO1Rh0thJ+Ju5y46bRsJNxorGtjlC4hcolr
	 SD/4+ZPh+qD7A==
Date: Mon, 23 Feb 2026 13:40:53 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-efi@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/efi: defer freeing of boot services memory
Message-ID: <aZw8xSI-TM-Gz84t@kernel.org>
References: <20260223075219.2348035-1-rppt@kernel.org>
 <b6f4edf5-7587-45d7-b81a-590d4f3d1ddd@app.fastmail.com>
 <aZwyNAbEqb8ZwLUM@kernel.org>
 <e2ad0845-2f87-418a-9f87-5ce619e004ef@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ad0845-2f87-418a-9f87-5ce619e004ef@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6201-lists,linux-efi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 336591759D3
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:17:22PM +0100, Ard Biesheuvel wrote:
> 
> On Mon, 23 Feb 2026, at 11:55, Mike Rapoport wrote:
> > Hi Ard,
> >
> > On Mon, Feb 23, 2026 at 09:08:29AM +0100, Ard Biesheuvel wrote:
> >> Hi Mike,
> >> 
> >> On Mon, 23 Feb 2026, at 08:52, Mike Rapoport wrote:
> >> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >> >
> >> > efi_free_boot_services() frees memory occupied by EFI_BOOT_SERVICES_CODE
> >> > and EFI_BOOT_SERVICES_DATA using memblock_free_late().
> >> >
> >> > There are two issue with that: memblock_free_late() should be used for
> >> > memory allocated with memblock_alloc() while the memory reserved with
> >> > memblock_reserve() should be freed with free_reserved_area().
> >> >
> >> > More acutely, with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
> >> > efi_free_boot_services() is called before deferred initialization of the
> >> > memory map is complete.
> >> >
> >> > Benjamin Herrenschmidt reports that this causes a leak of ~140MB of
> >> > RAM on EC2 t3a.nano instances which only have 512MB or RAM.
> >> >
> >> > If the freed memory resides in the areas that memory map for them is
> >> > still uninitialized, they won't be actually freed because
> >> > memblock_free_late() calls memblock_free_pages() and the latter skips
> >> > uninitialized pages.
> >> >
> >> > Using free_reserved_area() at this point is also problematic because
> >> > __free_page() accesses the buddy of the freed page and that again might
> >> > end up in uninitialized part of the memory map.
> >> >
> >> > Delaying the entire efi_free_boot_services() could be problematic
> >> > because in addition to freeing boot services memory it updates
> >> > efi.memmap without any synchronization and that's undesirable late in
> >> > boot when there is concurrency.
> >> >
> >> > More robust approach is to only defer freeing of the EFI boot services
> >> > memory.
> >> >
> >> > Make efi_free_boot_services() collect ranges that should be freed into
> >> > an array and add an initcall efi_free_boot_services_memory() that walks
> >> > that array and actually frees the memory using free_reserved_area().
> >> >
> >> 
> >> Instead of creating another table, could we just traverse the EFI memory
> >> map again in the arch_initcall(), and free all boot services code/data
> >> above 1M with EFI_MEMORY_RUNTIME cleared ?
> > 
> > Currently efi_free_boot_services() unmaps all boot services code/data with
> > EFI_MEMORY_RUNTIME cleared and removes them from the efi.memmap.
> 
> Ah yes, I failed to spot that those entries are long gone by initcall
> time. Other architectures don't touch the EFI memory map at all, but x86
> mangles it beyond recognition :-)

Heh, EFI on x86 does a lot of, hmm, interesting things with memory, like
memremaping kmalloced memory and I it really begs for cleanups :)
 
> > I wasn't sure it's Ok to only unmap them, but leave in efi.memmap, that's
> > why I didn't use the existing EFI memory map.
> >
> > Now thinking about it, if the unmapping can happen later, maybe we'll just
> > move the entire efi_free_boot_services() to an initcall?
> >
> 
> As long as it is pre-SMP, as that code also contains a quirk to allocate
> the real mode trampoline if all memory below 1 MB is used for boot
> services.

initcall is long after SMP. It the real mode trampoline allocation is the
only thing that should happen pre-SMP?
 
> But actually, that should be a separate quirk to begin with, rather than
> being integrated into an unrelated function that happens to iterate over
> the boot services regions. The only problem, I guess, is that
> memblock_reserve()'ing that sub-1MB region in the old location in the
> ordinary way would cause it to be freed again in the initcall?

Right now we anyway don't free anything below 1M, I don't see why it should
change. 

> But yes, in general I think it is fine to unmap those regions from the
> EFI page tables during an initcall.

Thanks for confirming. I'll look into extracting the allocation of the real
mode trampoline to a separate quirk and then making the entire
efi_free_boot_services() an initcall.

-- 
Sincerely yours,
Mike.

