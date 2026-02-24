Return-Path: <linux-efi+bounces-6214-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNHiFFFwnWk9QAQAu9opvQ
	(envelope-from <linux-efi+bounces-6214-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 10:33:05 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B480184A86
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 10:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05F0A30075E5
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0AA36A012;
	Tue, 24 Feb 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkzACdBF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36105274B43;
	Tue, 24 Feb 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925345; cv=none; b=FQU+NLoyv6HKFFN7gDSeIiVLdrg2PMx9Q6Ti9benEee6u0Sc54nOedwWUgFgpCxFBCMwQc0FGPnLHFGyq3gu9bOMEqbBKuUmcR5YUFhkaeDwk3sgEp0QDK7pVdVAmS8qweYYIYnm/GBRmoIUSLHympFA8/ytK+i6ilFNQg+io2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925345; c=relaxed/simple;
	bh=MhPzZ6IPkSbMVpSdEXmyDg4879I8IIzPI0L+1oFc8Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZW72Z362mLencvDQnxJL8XdhrBQagvvpGOGb5aLQywqOqRdhlvma4Mq8T+7xMXQX14wv96OrNTXcYAnf617xXKIzpHh16JdPXya3U7rY7IX7MQeGbtcgNNAsG263JEbOLSQ9Q7iQKDkBUU9gl1NnK1z9QvHn617Q22BkN3Ez9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkzACdBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF73C116D0;
	Tue, 24 Feb 2026 09:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771925344;
	bh=MhPzZ6IPkSbMVpSdEXmyDg4879I8IIzPI0L+1oFc8Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkzACdBFp7Gi1bnBPNqe9LdepLVyLwAAcTSbPhiPpUZYejSmpDirUB1dyQyFN7v1R
	 VtxoXczDGrNDIuMJzgkg4eiFkmxh+KKy4arwOP4JJyYEK26D7pIP8oa1xZKM/p6flD
	 htHhB/tY8naYuXrFPIzmvCAKyZQsv3RwrdGLjWwhqaVvIzdQotM2XZeMTJctTkYtL6
	 G3zngKA/5wIYmxRW4pRcUWe/l6tW3FC2yFd3jzmgWqoTEybQ7WeV+0euuGYRWDwn2t
	 gBiCvKLfTKhOipiCn5L/znakrpHser+tjPWF4dYmH1C8KwRESW/XMWtEHKXgYBQKIX
	 n2QkFK9Y0dFLw==
Date: Tue, 24 Feb 2026 11:28:56 +0200
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
Message-ID: <aZ1vWEgJNwc2nrrA@kernel.org>
References: <20260223075219.2348035-1-rppt@kernel.org>
 <b6f4edf5-7587-45d7-b81a-590d4f3d1ddd@app.fastmail.com>
 <aZwyNAbEqb8ZwLUM@kernel.org>
 <e2ad0845-2f87-418a-9f87-5ce619e004ef@app.fastmail.com>
 <aZw8xSI-TM-Gz84t@kernel.org>
 <bfe487fe-6868-4215-b5be-99a0360e9bd2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfe487fe-6868-4215-b5be-99a0360e9bd2@app.fastmail.com>
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
	TAGGED_FROM(0.00)[bounces-6214-lists,linux-efi=lfdr.de];
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
X-Rspamd-Queue-Id: 1B480184A86
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 01:18:41PM +0100, Ard Biesheuvel wrote:
> On Mon, 23 Feb 2026, at 12:40, Mike Rapoport wrote:
> > On Mon, Feb 23, 2026 at 12:17:22PM +0100, Ard Biesheuvel wrote:
> >>
> >> > I wasn't sure it's Ok to only unmap them, but leave in efi.memmap, that's
> >> > why I didn't use the existing EFI memory map.
> >> >
> >> > Now thinking about it, if the unmapping can happen later, maybe we'll just
> >> > move the entire efi_free_boot_services() to an initcall?
> >> 
> >> As long as it is pre-SMP, as that code also contains a quirk to allocate
> >> the real mode trampoline if all memory below 1 MB is used for boot
> >> services.
> >
> > initcall is long after SMP. It the real mode trampoline allocation is the
> > only thing that should happen pre-SMP?
> 
> early_initcall() should be early enough, those run before SMP init.

I don't think so. All initcalls run quite late in boot, early ones just run
before the others.
 
> >> But actually, that should be a separate quirk to begin with, rather than
> >> being integrated into an unrelated function that happens to iterate over
> >> the boot services regions. The only problem, I guess, is that
> >> memblock_reserve()'ing that sub-1MB region in the old location in the
> >> ordinary way would cause it to be freed again in the initcall?
> >
> > Right now we anyway don't free anything below 1M, I don't see why it should
> > change. 
> >
> >> But yes, in general I think it is fine to unmap those regions from the
> >> EFI page tables during an initcall.
> >
> > Thanks for confirming. I'll look into extracting the allocation of the real
> > mode trampoline to a separate quirk and then making the entire
> > efi_free_boot_services() an initcall.

There's another issue with making the entire efi_free_boot_services() an
initcall. It updates efi.memmap without any synchronization and if it'll
run after SMP init, there might be a concurrent access to the efi.memmap.

It seems to me that to be on the safe side the simplest and easiest for
backporting is to stick with my original version. 
 
> Thanks!

-- 
Sincerely yours,
Mike.

