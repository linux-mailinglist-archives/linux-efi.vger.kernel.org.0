Return-Path: <linux-efi+bounces-6155-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBlxDrtDk2kP3AEAu9opvQ
	(envelope-from <linux-efi+bounces-6155-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 17:20:11 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BDC146088
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 17:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1AF83017BF2
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B53328F8;
	Mon, 16 Feb 2026 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkXWZvsx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590D331A46;
	Mon, 16 Feb 2026 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258794; cv=none; b=bcdV1ww6oqcH4aY9scBaGR1meIhQbOPUMv8a/qE4/OZ6xRKfE/gwYe+2OCWMniKix/iRp2atEbPYg8GcXLXr4FGWOIDH7v0XWgYUq7vUf3FAgMrT2Tl3X1XsjqWzxRRpdFutHDEWRFUSGqCO9CyLU9UFnkwa3booxbMaJw5QWUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258794; c=relaxed/simple;
	bh=Xdcj83X+S0jAZzhzAiEPWWH/OhbcSoEDUGOUeQEAPKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5uWYM0bh9beT+CE8/plz3KCZ+Ey3LF/MpBi/ufWg/fUEhnWh/aM9PhBYQNxKAKR38coV9fsdhKw+tJhbS4G30leXaXambLX4I1Vr/eHKpYxgZVuvhaBd41AeQcYNCzXWXRX5zM6yE5ZqDRzrw0GWMSBd8DklFrsUaBunk8EtY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkXWZvsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160DAC116C6;
	Mon, 16 Feb 2026 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771258793;
	bh=Xdcj83X+S0jAZzhzAiEPWWH/OhbcSoEDUGOUeQEAPKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkXWZvsxTA+V/n96k5wSHxcNjkLNZ8bSahD58XOBxcmWjA2/CrJ1B+W8vA0GxT00C
	 qHMIeAWh/+zHov1BNeNySXAIBkhc6ZF5L8NtiG/fx1/S+bIwq3y+m/0WUOkfZaluFA
	 nhTCqvNaYP8GyCwIa0R+vaoiKnvAamr54SynTI/f1tD5RFa4nG9DhbR6LlLw7dAXjF
	 WfhG1nElyEFP6HN6pyxBUgjQB5V30knOgAYQRHLFsDrRT/uz4siKz/dCQ2lEQeJ+Ex
	 bI20NA1FqzSq2AN3Ei5IN0AGDDhevDbUe1nbmrxqfGt6jGzxULYYm7HNxmFqZCr9Cz
	 zR+nu1kAvcmCw==
Date: Mon, 16 Feb 2026 18:19:46 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
	linux-efi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Moritz Sanft <ms@edgeless.systems>
Subject: Re: [PATCH 1/2] efi: Fix reservation of unaccepted memory table
Message-ID: <aZNDogxae67mAXDg@kernel.org>
References: <20260213154838.46567-1-kas@kernel.org>
 <20260213154838.46567-2-kas@kernel.org>
 <b3b073e4-d51e-4fd7-ad7c-7465dab412b6@intel.com>
 <aY9Mf8oZODGiDoXp@thinkstation>
 <6d6dd421-774c-4f29-84d5-3e449240eb93@intel.com>
 <aY9c80nXefdXjGXh@thinkstation>
 <aZCaE04vDpf2hDEc@kernel.org>
 <6a43f009-335f-44de-a48f-f48ee1e912d0@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a43f009-335f-44de-a48f-f48ee1e912d0@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6155-lists,linux-efi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95BDC146088
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 07:53:24AM -0800, Dave Hansen wrote:
> On 2/14/26 07:51, Mike Rapoport wrote:
> > Heh, it's x86's choice of memblock iterator that's rounding the ranges 😉
> 
> Ahh, good point. I was just assuming that the memblock iteration _had_
> to be over PFNs. Silly me.
> 
> > Maybe I miss some context, but my understanding is that for crash kernels
> > the unaccepted table is E820_TYPE_RESERVED and those are never added to
> > memblock.memory by e820 code, hence the call to memblock_add() in
> > reserve_unaccepted().
> > 
> > When x86 creates page tables, init_range_memory_mapping() walks
> > memblock.memory with for_each_mem_pfn_range() that rounds ranges that are
> > not page-aligned, which is normally fine, because it would mean that we
> > miss some partial pages that are divided between E820_RAM and
> > E820_SOMETHING_ELSE.
> > 
> > And Kiryl's intention to round up unaccepted to page boundary seems correct
> > to me.
> 
> It fixes the bug for sure.
> 
> I'm more worried about the next feature, or the existing features that
> also only working because memory is page-aligned somewhere (even though
> it isn't guaranteed to remain that way).
> 
> There are two choices for fixing this: One, we do Kiryl's fix plus
> checks to ensure that all the memblocks that generate direct mappings
> (is it _just_ the "memory" type?) are padded out to page-aligned boundaries.
> 
> The other alternative is to do for_each_mem_range() and do the padding
> universally when creating the mappings. Maybe _also_ with warnings or
> maybe a pr_debug().
> 
> I do still think it's a little wonky for memblock_add()'s management of
> the "memory" type to allow unaligned arguments when that type is also
> used to create page-aligned mapping structures. Memblocks themselves
> obviously need to be byte-level, but I'm not sure it's the right thing
> for the "memory" type API.

Well, we could make memblock_add() implicitly cut down the edges when it's
adding to memblock.memory and make everything there page aligned, but I
truly have no idea what will break and I'm sure something will :)

Another thing that's more on x86 side, is that translation from e820 to
memblock only adds E820_TYPE_RAM to memblock. And since in e820 these are
mutually exclusive with other e820 types, this could create non-aligned
chunks when firmware reservations are not page aligned. It also creates
unnecessary holes in memblock.memory that slow down memblock interation a
bit and more interestingly, everything that's not in E820_TYPE_RAM is
treated as IO and requires ioremap/memremap for access, even it is in DRAM.

If these reserved regions were added to memblock.memory along with being
memblock_reserve()ed we wouldn't hit the bug with unaccepted I believe some
others as well.

-- 
Sincerely yours,
Mike.

