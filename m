Return-Path: <linux-efi+bounces-3753-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2DABA941
	for <lists+linux-efi@lfdr.de>; Sat, 17 May 2025 12:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB4C7B24E1
	for <lists+linux-efi@lfdr.de>; Sat, 17 May 2025 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618701DE3DF;
	Sat, 17 May 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W4X7LqTj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C9190057;
	Sat, 17 May 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476027; cv=none; b=HNTmSRe2W1ZGjjqLkfpWGvvio1fIRoIJbKHhvHE6M2dDPzQrmBl7Os6v1tZBYDPO6/7veeZPfr9IpFsBDcnjof8rqui+Hn3/sC6p28CbSUMtFFX7k2B+j5BV3jEYR3xxx8kldlHhofBbEsaehizAjJGpOotf8W0FZgF1PcrdATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476027; c=relaxed/simple;
	bh=n/tyub/UDIshEqdErapRAxo680ky/xE8NVL862OiNNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuE9VoOUqmqg9PKRTzqhOdOm6G4Jh7QL5XEyt1mfjFFBtw1gT4VsI0XsjAl4ZWv8F1LAIR0oZ8IE3UHyI2TeUruW0boRxWGu0RePna/0qh85ThAu2FSa4//xkxtJbfM8zK6JjmemuXAmx11lW5lSu71aIgQ38Sk5XlUQwXLdD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W4X7LqTj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B432540E01ED;
	Sat, 17 May 2025 10:00:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OMOk4xaLhbMZ; Sat, 17 May 2025 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747476016; bh=vivSp+4H0/wgVkVpUciSmmSzamaN4dBOFfW2lgDH11Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4X7LqTjMnIOmlc+JRxxeDE7oLt+HBnUSv11CfEljwtqEc6Tdg5oRq/NkpAAJDHr+
	 2kyQdKjzJnWJiTVs1t4+t7K9MygaXFM7g7yiY/G0KNAso9mwq3/WAphBfg9QQJ3b7f
	 P7ygH2YTcH9GpTYmvpqvXrHnTbdEBeTxfynjdH881CZRhNeTSHBpG0nT/y90cRZQi0
	 CmGtXYAKyM7asX+4C8gfL+AUnOQcVHxqv5CTlsRljXxqLuWByv17FIgqDreBzVj1Jd
	 5c8VUIstlDrMHmaGtnPGSnd8MPDk5AtwLpqhLaRVa+RW3eG0KjfAz7Ep5KropZYiS4
	 /56bGX/lP/FSslXxbIXnk6vN6txHItp6/hKyhsKAyXLKNdXL5538DpXRALkbGoEcvO
	 pZNPfZS+2EMacmrX1/rrHzzUnnTTCMNpsl4Mrmb1Rwsm2Mt5DGg5qGv//Z3v6NPA3+
	 9B0aLK6yia1wFQwlkwW7mKbt3VgNkj9IQCUNFxiQ3pBVVJfpolCBr3SZetpRBfBgeW
	 BDW7OBhqaf65uRwNOyYR1L4qPs4pdFcCCzFHl6dF1YY0eCSCrFg8raNeg0v9kTCXKF
	 GpZRWljm6oQhxkF/DRnsm6e5YW9EJknYNYj90WxA9YRNv5g5CXaeCy479MrAdP2E37
	 q5cc4c3pW8lwgPYcxsBrgbwM=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1629940E016A;
	Sat, 17 May 2025 09:59:54 +0000 (UTC)
Date: Sat, 17 May 2025 11:59:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 0/4] x86: Make 5-level paging support unconditional for
 x86-64
Message-ID: <20250517095947.GAaCheE9tUvgSWMhpa@fat_crate.local>
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>

On Fri, May 16, 2025 at 03:33:02PM +0300, Kirill A. Shutemov wrote:
> Both Intel and AMD CPUs support 5-level paging, which is expected to
> become more widely adopted in the future.
> 
> Remove CONFIG_X86_5LEVEL.
> 
> In preparation to that remove CONFIG_DYNAMIC_MEMORY_LAYOUT and make
> SPARSEMEM_VMEMMAP the only memory model.
> 
> v3:
>  - Drop few "#if CONFIG_PGTABLE_LEVELS >= 5";
>  - Make PARAVIRT_XXL 64-bit explicitly and drop ifdefs
>    to support PGTABLE_LEVELS < 5;
>  - Add Reviewed-by tags from Ard;
> v2:
>  - Fix 32-bit build by wrapping p4d_set_huge() and p4d_clear_huge() in
>    #if CONFIG_PGTABLE_LEVELS > 4;
>  - Rebased onto current tip/master;
> 
> Kirill A. Shutemov (4):
>   x86/64/mm: Always use dynamic memory layout
>   x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
>   x86/64/mm: Make 5-level paging support unconditional
>   x86/paravirt: Restrict PARAVIRT_XXL to 64-bit only

The whole set passed randbuilds testing here too, and am running boot tests on
my pile of stinky hw.

If it passes, we could queue it all.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

