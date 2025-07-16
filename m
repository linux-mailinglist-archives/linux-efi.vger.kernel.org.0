Return-Path: <linux-efi+bounces-4378-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C99B0723D
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 11:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D20A16FCE5
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E212EF9C5;
	Wed, 16 Jul 2025 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uNq51tV6"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6E2727E1;
	Wed, 16 Jul 2025 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659700; cv=none; b=pq5mDEWSUSCJgyxtPV8upPguJ05Go9JB3rYzS93N8UN9pF5nB/Y4or/wx1q5WMD6P63fuUVdKGDgW3/vFZxhaxKi8ljCNAZRCOKvWpt6BhKCe4WI1x/HgaTG2KJAoQFsQuAkAD09zzlwKNe2bCdXRlOJxMz0cR0891h2ZJscbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659700; c=relaxed/simple;
	bh=kEOm77ecIV5R75V8qpciS/uicdu49/LXJvltcPh2imw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdTf43KStSWBn/be0a/Lcn77G7a4fsqcPePmOYruQ6505RNvk2syQUQuRzq0fZbdKPdeKpR6jRSBtXK/fGJZ5okFNPKfBbxDAqiQVk5lowRdcHP+vSNRSL63JGhbiOk68x6SCclPbxbPNnoPyst/xLWaKt7qu0F/yGXRWglBLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uNq51tV6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UIA9FE4LYRJmDHiys+W1RlA6OGCujbo0RUNMRWi9vXc=; b=uNq51tV6Joz/2lK15A4uZaDCup
	Q269EtJJZCG9gE5Sxdl4TQoYy47zgXjCNQfYotmJydU2vjrswTEhqIxn7oOX4B6W7MHuG/zPWP7Cl
	oBzS+Ga0Hdj5wSwXlagvZM0wOkpKfGQiEcNXiYtpvw1ErciSD0PqpKnV7EURy7ofn2cHeG2QAl4SZ
	1gii0OUn1v21cdLPH5IcwMFsvJZeazt0xfeUL/KRFSd0n9GSQ7oHhj93ufEJRSghWNd/zISaPUyEX
	a+CJ2tazB1xqa9g+orO5ysndczT8dT6ix6bEWzNZ7/yiLAybi890Drl8JkKsFwIKB1i2pmjEI6Yev
	sdfFC/ew==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubyqe-0000000G9iT-0jAx;
	Wed, 16 Jul 2025 09:54:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BB919300186; Wed, 16 Jul 2025 11:54:46 +0200 (CEST)
Date: Wed, 16 Jul 2025 11:54:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v5 15/22] objtool: Add action to check for absence of
 absolute relocations
Message-ID: <20250716095446.GV905792@noisy.programming.kicks-ass.net>
References: <20250716031814.2096113-24-ardb+git@google.com>
 <20250716031814.2096113-39-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716031814.2096113-39-ardb+git@google.com>

On Wed, Jul 16, 2025 at 05:18:30AM +0200, Ard Biesheuvel wrote:
> index d967ac001498..5d1d38404892 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4643,6 +4643,39 @@ static void disas_warned_funcs(struct objtool_file *file)
>  		disas_funcs(funcs);
>  }
>  
> +static int check_abs_references(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	struct reloc *reloc;
> +	int ret = 0;
> +
> +	for_each_sec(file, sec) {
> +		/* absolute references in non-loadable sections are fine */
> +		if (!(sec->sh.sh_flags & SHF_ALLOC))
> +			continue;
> +
> +		/* section must have an associated .rela section */
> +		if (!sec->rsec)
> +			continue;
> +
> +		/*
> +		 * Special case for compiler generated metadata that is not
> +		 * consumed until after boot.
> +		 */
> +		if (!strcmp(sec->name, "__patchable_function_entries"))
> +			continue;
> +
> +		for_each_reloc(sec->rsec, reloc) {
> +			if (reloc_type(reloc) == R_ABS64) {

This should probably also check R_ABS32. Yes, your current only user is
x86_64 so R_ABS64 covers things, but we're getting more and more archs
using objtool. No reason this check shouldn't also work on PPC32 for
example.

> +				WARN("section %s has absolute relocation at offset 0x%lx",
> +				     sec->name, reloc_offset(reloc));
> +				ret++;
> +			}
> +		}
> +	}
> +	return ret;
> +}

