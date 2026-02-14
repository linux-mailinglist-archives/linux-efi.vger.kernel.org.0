Return-Path: <linux-efi+bounces-6142-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vKM/HR+akGlIbgEAu9opvQ
	(envelope-from <linux-efi+bounces-6142-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sat, 14 Feb 2026 16:51:59 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEF013C5D7
	for <lists+linux-efi@lfdr.de>; Sat, 14 Feb 2026 16:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19CBB301A92A
	for <lists+linux-efi@lfdr.de>; Sat, 14 Feb 2026 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6232FB969;
	Sat, 14 Feb 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zcsc2E3/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45827A916;
	Sat, 14 Feb 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771084315; cv=none; b=Zrb9TnZn0MP0ro8L+AVAI7RRKKlZNMbrYkfNl3kAEYwm5TOJ1OeuyCY+jOqpGSUPyvwbGp2ITk4Wt4yOEEq+2HuxQCdMoWEElcSThJKsYCMpTAcjt3oHtn+xtd0Fj0+sZ+004tfXw9ZZERlaKbir0moy6GGciVXeDDET2R/o9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771084315; c=relaxed/simple;
	bh=gqasDy2xb54ndlBw62GJHZO2RJmh2bA9prsyInGKGKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3m81A4VuSy+p17uV+Rqs0RJ5wca1gG67+Us7E1TFGg8EozWZUiOYhUdosCsotXpPRO/+LXVLxQlYdGqYtP6Q+ObUasb/UlZFpee8Uyti/6d/j1mgdz5GCeFrH5KUEy7M8SmL+mbxOBOzGVgehxLxLuEZ3ZZoe11XAz5S6gjPrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zcsc2E3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B52C16AAE;
	Sat, 14 Feb 2026 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771084315;
	bh=gqasDy2xb54ndlBw62GJHZO2RJmh2bA9prsyInGKGKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zcsc2E3/35RhPbFkNNnuqUTR8J0Vzr5V+E2+QVinLK6eLhF/ka9hS3vXgOdxlcTAI
	 yUO3YZmhJ/mZlBz3PR1JszQ0tpGtVCvP97hocYWK/lBZCYD3t4Mhq4EfYWWs47e2hQ
	 PUxfuzMvH0MHgT73KYfmMamZS0CTSvJVAswGCqog0wJHHk8nEN+oabrnpexRSDiQxF
	 yQQNWTcQsPnlcOunoMrj5LhIXHGZJpycyRQt4BFYAO2MUNMDFEPHZ8v0B47sbAP+lP
	 yU962dDLKCcOuw6MIGOjmnlPoBc15UpIh/WxbF72I/8bw9rleOo6G/k27hxzifRUL5
	 S3CU+LA/8EHew==
Date: Sat, 14 Feb 2026 17:51:47 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
	linux-efi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Moritz Sanft <ms@edgeless.systems>
Subject: Re: [PATCH 1/2] efi: Fix reservation of unaccepted memory table
Message-ID: <aZCaE04vDpf2hDEc@kernel.org>
References: <20260213154838.46567-1-kas@kernel.org>
 <20260213154838.46567-2-kas@kernel.org>
 <b3b073e4-d51e-4fd7-ad7c-7465dab412b6@intel.com>
 <aY9Mf8oZODGiDoXp@thinkstation>
 <6d6dd421-774c-4f29-84d5-3e449240eb93@intel.com>
 <aY9c80nXefdXjGXh@thinkstation>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY9c80nXefdXjGXh@thinkstation>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-6142-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BDEF013C5D7
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 05:20:14PM +0000, Kiryl Shutsemau wrote:
> On Fri, Feb 13, 2026 at 08:46:55AM -0800, Dave Hansen wrote:
> > On 2/13/26 08:14, Kiryl Shutsemau wrote:
> > >> The memblock code seems to be able to handle arbitrary alignment just fine.
> > > Memblock will track it, but, as the comment says, anything smaller than
> > > page size will not be mapped, but we need the table to be accessible by
> > > kernel.
> > 
> > That seems really, really fragile.
> > 
> > We should first make sure this is intentional memblock behavior and not
> > a bug before we go add more hacks on top of it.
> > 
> > Why would you even present a byte-level reservation interface if it is
> > free to just silently ignore some of the ranges by rounding them off later?

Heh, it's x86's choice of memblock iterator that's rounding the ranges ;)

Maybe I miss some context, but my understanding is that for crash kernels
the unaccepted table is E820_TYPE_RESERVED and those are never added to
memblock.memory by e820 code, hence the call to memblock_add() in
reserve_unaccepted().

When x86 creates page tables, init_range_memory_mapping() walks
memblock.memory with for_each_mem_pfn_range() that rounds ranges that are
not page-aligned, which is normally fine, because it would mean that we
miss some partial pages that are divided between E820_RAM and
E820_SOMETHING_ELSE.

And Kiryl's intention to round up unaccepted to page boundary seems correct
to me.

> My guess that multiple memblock_add() calls might add up to the full
> page size.

I'm not following here. Can you explain what do you mean?

Multiple memblock_add() calls to adjacent ranges will coalesce into one
larger range. But I don't see how is that related.

> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

-- 
Sincerely yours,
Mike.

