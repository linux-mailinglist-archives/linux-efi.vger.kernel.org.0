Return-Path: <linux-efi+bounces-6216-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFDhJIZ1nWmAQAQAu9opvQ
	(envelope-from <linux-efi+bounces-6216-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 10:55:18 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9F4184FD0
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 10:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74831304EA91
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A537107E;
	Tue, 24 Feb 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhbfiEy6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7336F412;
	Tue, 24 Feb 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926830; cv=none; b=rwukth2T64Co4rtAxG/2jpxgTIe+j95n0azDI9+bI+EzMnOn26W8vDaOYk1NbsR0Rh/4atDy0EcagFhjf1TDQvEi9gax5ZH59zT9lQPfXqkeUbz5PPDOzZA9nS1Xj8jjxAhtR/LwP0Y+Nvb9DbdSkp2WeS/iBMgqBADOSsfVqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926830; c=relaxed/simple;
	bh=r7eHhH2PfG5WZuFexz3hpA8FZFXdMilcr/EoFqc7eI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPh7X6sZJ22GbVkIxSGwoKik1GkRLFJ43MsxrQZOyYWkFxeKt011LNTB2z5wro8FpE0QSwiTbcCtkz4uP9PsL7I4ohUSsi8QvdpKazqOVWvNbzzFPnrvMs1ABBiELlLHlGADalZl+G056NiZRumGN+/cUOR5QyH/y9NmS7mb/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhbfiEy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292E7C116D0;
	Tue, 24 Feb 2026 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771926830;
	bh=r7eHhH2PfG5WZuFexz3hpA8FZFXdMilcr/EoFqc7eI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhbfiEy6gxAbMMC5gQAl8nQMiG1ZfhDqZvjCWmBDhYebQHskLcLix/joSge4RXZbK
	 TlruXp01XKOQKUi7btZZj6jI4t7TivvALbCIwgmiSfVsiKDiOeaLF2RCG+WMVEzVx0
	 ehCsE+SR2qKI1icKwegdje4HpM326V61a0vODhnm+5oS/dO/fUgLQZP0XK92xOmeDr
	 Sh/oUd24MLkkHgCGgcqvCicXygmoZT/LLNHxZe2anEfjfJNJgz3KTNGWhinOigT7Lf
	 /Y84R4XjZXxVAIEQxX336X6niiGiVFR1eZNg2Vv/uhLmHzYJJjni3g37pjOHHqa7P7
	 7USnqOtLdchJg==
Date: Tue, 24 Feb 2026 11:53:43 +0200
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
Message-ID: <aZ11J7D_iBuG_qjC@kernel.org>
References: <20260223075219.2348035-1-rppt@kernel.org>
 <b6f4edf5-7587-45d7-b81a-590d4f3d1ddd@app.fastmail.com>
 <aZwyNAbEqb8ZwLUM@kernel.org>
 <e2ad0845-2f87-418a-9f87-5ce619e004ef@app.fastmail.com>
 <aZw8xSI-TM-Gz84t@kernel.org>
 <bfe487fe-6868-4215-b5be-99a0360e9bd2@app.fastmail.com>
 <aZ1vWEgJNwc2nrrA@kernel.org>
 <3a01d817-e08c-45ec-b5a7-4a8d9ecd0fc6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a01d817-e08c-45ec-b5a7-4a8d9ecd0fc6@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6216-lists,linux-efi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC9F4184FD0
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:29:59AM +0100, Ard Biesheuvel wrote:
> 
> 
> On Tue, 24 Feb 2026, at 10:28, Mike Rapoport wrote:
> > On Mon, Feb 23, 2026 at 01:18:41PM +0100, Ard Biesheuvel wrote:
> >> On Mon, 23 Feb 2026, at 12:40, Mike Rapoport wrote:
> >> > On Mon, Feb 23, 2026 at 12:17:22PM +0100, Ard Biesheuvel wrote:
> >> >>
> >> >> > I wasn't sure it's Ok to only unmap them, but leave in efi.memmap, that's
> >> >> > why I didn't use the existing EFI memory map.
> >> >> >
> >> >> > Now thinking about it, if the unmapping can happen later, maybe we'll just
> >> >> > move the entire efi_free_boot_services() to an initcall?
> >> >> 
> >> >> As long as it is pre-SMP, as that code also contains a quirk to allocate
> >> >> the real mode trampoline if all memory below 1 MB is used for boot
> >> >> services.
> >> >
> >> > initcall is long after SMP. It the real mode trampoline allocation is the
> >> > only thing that should happen pre-SMP?
> >> 
> >> early_initcall() should be early enough, those run before SMP init.
> >
> > I don't think so. All initcalls run quite late in boot, early ones just run
> > before the others.
> > 
> 
> It is documented as running before SMP. If that is no longer true, we should fix the documentation.

Ah, my bad, it is running before SMP. 

-- 
Sincerely yours,
Mike.

