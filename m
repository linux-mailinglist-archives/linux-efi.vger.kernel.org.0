Return-Path: <linux-efi+bounces-3735-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB438AB9CFD
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 15:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD46517E351
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB99242910;
	Fri, 16 May 2025 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhJ0nrPV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991F1E521E;
	Fri, 16 May 2025 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401081; cv=none; b=DDNty2SWAp7en8y89iUISDPRHEWh4hhv+Bp/I0Id3QU20P29+JVvatZMKEhrBkpmzWJgxPV7c9Y4VCwftC8dx8wcU+MSTXQVY1uTmDdfhqSctQp4O+ZppLGjreB6owBfZhiH59fT9TghrneuLHJp4UYI3T1X+bcyrgZUpReJwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401081; c=relaxed/simple;
	bh=Y5IJQArWKZojIwz8YwoWpp+zcmIA7tz4vRRbPRaHX8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0MlzmWi4eH/9hJf/gibERIQWQUsf5N39A6JVX4hKjneShrf1fMogPd0cvbLcoYbzpjXJvr0v3mPz58jmL2G1jVBjDPlxmXaIDTv82QURYFYZ+L1ImRz0khllAabIesiJhWrDzpIhKQJRiWk5CP1TURiRdX9atRTjC2Q8869aKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhJ0nrPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2951C4CEE4;
	Fri, 16 May 2025 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747401081;
	bh=Y5IJQArWKZojIwz8YwoWpp+zcmIA7tz4vRRbPRaHX8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhJ0nrPVTAVitrgm8e+OIzyODhuLG8+lk7vnbSiF8TUaEDcDJUtUFjspR3GY8WaPb
	 HeYn6Le7+IwF+tt4EWa49aucCnxIUlUhIoQAVJZmI8Avq1TF8k90jGf3yO97bVh1cr
	 fDUMrnicgpvwv7UcsYqgrYn2Y8LspbBOXo9cl+0xCJDFGquOZ1KmBkvyMbTOD0pMi9
	 JrNbmZv9eNv5B26MyOguTePssoW+Ja8TNdIAQDde4JWZOHE2Z7dcItgUdYQrBOfclM
	 2eaPL6i1IXfMODxv+2wj2MVuB+ZJBk2vjkWWnIqHQDp301yJD38tF9adtzqFaBdJAy
	 xmmVyV76bk+rg==
Date: Fri, 16 May 2025 15:11:14 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
	linux-efi@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv3 0/4] x86: Make 5-level paging support unconditional for
 x86-64
Message-ID: <aCc5cm_ZC-y9OnyA@gmail.com>
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

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

Wow, -v1 was sent almost a year ago. :-)

> Kirill A. Shutemov (4):
>   x86/64/mm: Always use dynamic memory layout
>   x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
>   x86/64/mm: Make 5-level paging support unconditional
>   x86/paravirt: Restrict PARAVIRT_XXL to 64-bit only

>  24 files changed, 14 insertions(+), 142 deletions(-)

Okay, this series makes a lot of sense, because in practice all major 
distros have 5-level paging enabled:

  .config.opensuse.default:     CONFIG_X86_5LEVEL=y
  .config.ubuntu.localinstall:  CONFIG_X86_5LEVEL=y
  .config.fedora.generic:       CONFIG_X86_5LEVEL=y
  .config.rhel.generic:         CONFIG_X86_5LEVEL=y

So the !CONFIG_X86_5LEVEL case gets very little runtime testing by 
distributions and users.

So I've applied the first two patches to tip:x86/core:

  x86/mm/64: Always use dynamic memory layout
  x86/mm/64: Make SPARSEMEM_VMEMMAP the only memory model

as they are fairly straightforward.

Patch #3:

  x86/64/mm: Make 5-level paging support unconditional

... might have to wait until after v6.16-rc1, as it's a higher risk 
patch.

  x86/paravirt: Restrict PARAVIRT_XXL to 64-bit only

... and this one depends on patch #3.

Does this approach sound good to everyone?

Thanks,

	Ingo

