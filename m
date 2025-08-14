Return-Path: <linux-efi+bounces-4551-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD106B25F8B
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 932BC4E04F3
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274427144D;
	Thu, 14 Aug 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPiy8FDn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED91DD0C7;
	Thu, 14 Aug 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161488; cv=none; b=kgo1MKuCNwBOSJnfxJ5YR5GmQsF3a1Yj7ZmpidYwOQ72UA8WA2Abcsx4qSHEg+h5vP2dR0qvpFAmVi6uNjHY4xlcvIWxDDjx8Z97q9Q6jaTSb2Qt3OMVEmtjmL+iARnGFk8qBk+pXaptEELpQ9ztArNbU7Jir/9JEh81U/DJg7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161488; c=relaxed/simple;
	bh=3K2+utYOWI1/tS8F/jA495zSK9Pd3/hWjmP0VT6O5MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSwapRKCBsskcWWzuvlW4i1zWvyqOw+1pqnyQ9O54Pg8DPiQ6c0cgkOGAUpnU0FxvcU6X7eIC+WuznWAZNteOXmhezyZksEmJGgBKaCuhFeIDGORM7Xuo+ugzOsGdK4yShsCMQ32NEAlHbWImjM7+cY9mH+URl7lBYovTwVxjyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPiy8FDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5853DC4CEED;
	Thu, 14 Aug 2025 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755161488;
	bh=3K2+utYOWI1/tS8F/jA495zSK9Pd3/hWjmP0VT6O5MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPiy8FDnRHK2nENk+5i60ybFMnMxvDCGtWRu3Lwv0Oa09L5OYsd0KdMIqQ1okTAAk
	 mmDk+8QQYQod+SoyUkEECNbnDh4T8949CmI6NPffOxlxOHCEYWFW8y0ZZUI431mAYV
	 LZN77dV6uEtaJ1RvJkkc7d4P0UM9VlWuLcVCQRQWshH8iXwI48ne91jPME20Su7nMZ
	 UTCZotDp4Sy33WzGu/f8OYw6tSPbinNPLKWBmYRmL1Ef3sZLwapJlCxTEr+xIEP7lG
	 gXUmqqSZYf6Fwit0r2I5cHruJgp6GE/OXPF94U2WdF7NYfBiuE9GbVtwfPYGcqY9kD
	 8aSIZSnnVKvrA==
Date: Thu, 14 Aug 2025 11:51:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: ardb@kernel.org, changyuanl@google.com, graf@amazon.com,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH] efi: Support booting with kexec handover (KHO)
Message-ID: <aJ2jiZ8MPGGALfGH@kernel.org>
References: <aJmQNuQxLLtXjq2r@kernel.org>
 <20250814005321.31705-1-epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250814005321.31705-1-epetron@amazon.de>

On Thu, Aug 14, 2025 at 12:53:15AM +0000, Evangelos Petrongonas wrote:
> Hey Mike, thanks for your review,
> 
> On Mon, 11 Aug 2025 09:39:50 +0300, Mike Rapoport <rppt@kernel.org> wrote:
> > On Fri, Aug 08, 2025 at 04:36:51PM +0000, Evangelos Petrongonas wrote:
> > > When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> > > early during device tree scanning. After kexec, the new kernel
> > > exclusively uses this region for memory allocations during boot up to
> > > the initialization of the page allocator
> > >
> > > However, when booting with EFI, EFI's reserve_regions() uses
> > > memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> > > rebuilding them from EFI data. This destroys KHO scratch regions and
> > > their flags, thus causing a kernel panic, as there are no scratch
> > > memory regions.
> > >
> > > Instead of wholesale removal, iterate through memory regions and only
> > > remove non-KHO ones. This preserves KHO scratch regions while still
> > > allowing EFI to rebuild its memory map.
> >
> > It's worth mentioning that scratch areas are "good known memory" :)
> >
> 
> I Will do so on Rev2.
> 
> > > Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> > > ---
> > >
> > >  	 */
> > >  	memblock_dump_all();
> > > -	memblock_remove(0, PHYS_ADDR_MAX);
> > > +
> > > +	if (IS_ENABLED(CONFIG_MEMBLOCK_KHO_SCRATCH)) {
> >
> > It's better to condition this on kho_get_fdt() that means that we are
> > actually doing a handover.
> >
> 
> Hmm, I see that `kho_get_fdt()` is static. My first instinct was to use
> kho_enable() instead. Diving a bit more into the initialisation flow,
> during the `setup_arch()`->`efi_init()`, `kho_enable()` will return
> true if kho is enabled in the cmdline, but not if we are actually doing
> a KHO enabled kexec. However, in this case, the parsing of memory
> regions is going to be a noop in terms of functionality, but will
> contribute, negatively —though the overhead would likely be
> unmeasurable to the (cold) boot time. If we  want to avoid that, we
> might consider adding another function to the KHO API, like
> `is_booting_with_kho()`, that practically wraps the `kho_get_fdt()`.
> IMO, it feels a bit cleaner this way, as other components  don't
> necessarily (need to) know the internal FDT based implementation of
> KHO. That being said, I am definitely not the most experienced person
> when it comes to API design, so there is a high chance that I am way
> off :)
> 
> So to sum it up, I see three paths forward:
> 1. Condition with `kho_is_enabled()` instead of the CONFIG (accepting
>    the minor cold boot overhead)
> 2. Post another patch that extends the KHO API, adding a wrapper for
>    the `kho_get_fdt()`, like `is_booting_with_kho()` indicating that we
>    are booting with KHO enabled
> 3. Post another patch that exports the `kho_get_fdt()` directly.

My preference is for the second option, I'd just name it is_kho_boot()
 
> I am happy to implement any of the three, or any other suggestion you
> might have.
> 
> > > +		struct memblock_region *reg;
> > > +		phys_addr_t start, size;
> > > +		int i;
> > > +
> > > +		/* Remove all non-KHO regions */
> > > +		for (i = memblock.memory.cnt - 1; i >= 0; i--) {
> >
> > Please use for_each_mem_region()
> >
> 
> Todo in Rev2.
> 
> --
> Kind Regards,
> Evangelos.

-- 
Sincerely yours,
Mike.

