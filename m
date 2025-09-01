Return-Path: <linux-efi+bounces-4665-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E52B3E707
	for <lists+linux-efi@lfdr.de>; Mon,  1 Sep 2025 16:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FCB2053FF
	for <lists+linux-efi@lfdr.de>; Mon,  1 Sep 2025 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A24D322550;
	Mon,  1 Sep 2025 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZfuV7txQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607792EDD76;
	Mon,  1 Sep 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736767; cv=none; b=EZlurPCb5YaeAogWWXYiUFAiFN6u5ypavwE9x7v3cEEsVNM4O3NpisegzRxuneHzjSzLz/UEIsJhmw0dhQDwa9T7dAQGfWbw+nMpSjkfGHbZ0dlMehluIdPOhWidBp7alBSa3brSejt7bTJoTg2oNs/WkgUyy3qUh31aERhO8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736767; c=relaxed/simple;
	bh=/j+qNkJJlASycZuV2P8ATcjk1hOImpi8fvYSxGWSyDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA8WugYJ2XD/hdxHFfhw06fs2xJvXC/SO8WnrkkHcWBqTZJBiYtqvlGd0qMqDni+Sq2XosO/PdxBTlVqALYyOTog709ODMuymubAt9miZgX0N+fCG24K0fXfB89l5Y7+vtqbOJ7+G5HvVUopcd4fiGC4TNaSodoYMq725LuAIvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZfuV7txQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EE4EE40E019F;
	Mon,  1 Sep 2025 14:25:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Mu04a5Vvsywo; Mon,  1 Sep 2025 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756736755; bh=HafVoSSKKEGThigXFItzGHLoZb2v+M1AD5rHWsxE4L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfuV7txQJpdK5U7Ma21NPCAu2fJDWCfZbE9dFvo3HRojVVMscW4owPu7hjtXswopM
	 lzuVGGhWmuVi16giHwK09ITvJdsDgeu37rLA8GKqV+XicmrKlNN2bcsIAlBqz2dTo9
	 daBTgq7OrQmRIAOiBmuE7XbjQQZWsGK9G10s1RUezZDmaWnLOHdjIZR+cNRCJeiQhF
	 pQqmnPco99MXzpl3M29gMSlCvMjwyqQbUx2hGPryvtdDBsxobO5bSKFBFnNq2KnAEl
	 s0GRMFDHpHHYdxtBUCYrooqse1QJvRTWRs8aJtTCouko6c/i1QkGPiB5BSN/Z8iTP7
	 5jJsuccQcY4WnNplgEuwdwvn9iLuisWNDDQfs3zArEdbe6BVaJLn/0kDyTOUY2/BnV
	 J+MdMymVY81rdxEk6AYol0qXceQmRhwwwmocRx8bPqX4xga6QZShImzC88u5E8kD6K
	 WaW5y7TnWGxHZh3cHusqrtQRURBQh+qyNS+DhXwrlXXDab3vDg71fsH4SBr+yt9r76
	 BGmT6nQ4cjmIYI3L6WxYeCqGr2JZPjLZBE01FCAqg+aYjwPpCv1gmUZyacoyIufPgc
	 KjEf7/SUFbir5xpg6ZAPd1KX+iYWvSZrOiZ7+8Wpk+O7PUscsqD84pjMuJrgqUZBOB
	 UXvkW5tFa9n/Ljy5036fWYio=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3759440E019E;
	Mon,  1 Sep 2025 14:25:44 +0000 (UTC)
Date: Mon, 1 Sep 2025 16:25:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v7 05/22] x86/sev: Move GHCB page based HV communication
 out of startup code
Message-ID: <20250901142538.GEaLWs4i5CVcdIJvC-@fat_crate.local>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-29-ardb+git@google.com>
 <20250831104945.GAaLQoyYmr316kHrKs@fat_crate.local>
 <CAMj1kXF-aD74+O_xf_f902wq2RdPpiXCEjJ9osbnEwAMoN_5Rw@mail.gmail.com>
 <CAMj1kXEQghhi4qCdV6PrYK-mTYFu5yVcn3fEOSZsC6vR7TiMEg@mail.gmail.com>
 <20250831111521.GAaLQuyYLUSN24_ZmT@fat_crate.local>
 <CAMj1kXFHrkY9R8xjrB_PFqswc2yOHGpPfEBq5WZ0rH_vbo55Mw@mail.gmail.com>
 <CAMj1kXHzK0pSjuRYcZ3E2PQzCx4PTAC-UDHirgFDPYEyLMtoeA@mail.gmail.com>
 <20250901135459.GAaLWlsx75fnPHveLl@fat_crate.local>
 <CAMj1kXFRSJ1zT5XvBE2JT1jm2peOs9aymHeydOYk8AZRO=JDbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFRSJ1zT5XvBE2JT1jm2peOs9aymHeydOYk8AZRO=JDbQ@mail.gmail.com>

On Mon, Sep 01, 2025 at 04:02:04PM +0200, Ard Biesheuvel wrote:
> Are you sure this can be removed? It is tested in other places too
> (arch/x86/coco/sev/core.c), and AIUI, it is a Linux defined CPU
> feature so it will never be set automatically.

It it set in scattered.c for the "late" code like sev/core.c:

arch/x86/kernel/cpu/scattered.c:51:     { X86_FEATURE_COHERENCY_SFW_NO,         CPUID_EBX, 31, 0x8000001f, 0 },

Tom added it to boot/cpuflags.c, in addition, for the early testing which
we're doing differently now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

