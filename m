Return-Path: <linux-efi+bounces-3252-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9CBA821AE
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 12:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022C87A2F68
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13DF2512D6;
	Wed,  9 Apr 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amYbdNv7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3911DF247;
	Wed,  9 Apr 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193138; cv=none; b=m3he9xAANFUfJrVWc4E+LF+aI5t+iFji6rYSy+43R/YYJ+aaD8VDpMaVmICkW6ymdtZhVlYS5U8FJ3/B6E0QAusQ6n1IHTw8UEzftizCsgLJzljMFlRhKFE5tqsz+NmwloL1SkQ74P7jIXq1hAeUHBH1PlMeTXDJ8SXsnPF06zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193138; c=relaxed/simple;
	bh=xrMoU0Tcu066RDLfO2h2jpz9TcYFNYa+zxpFqbPZCas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRyREmuE89t/+L9u5iJJ27xWJZCxpd6OMDyIZHDoV0yEovk3RtZQEYoD3JGEmEcebYsumJdbkrpO1ptTqNLPEQ6NUViGNkT1yCaN/37ZUiTIo9tCETz6Zoj9q+jscYQLjD1yqx0tGF3WniI0PBmEp00ytjnZJAuqoEXrX2UyqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amYbdNv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8C2C4CEE3;
	Wed,  9 Apr 2025 10:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744193138;
	bh=xrMoU0Tcu066RDLfO2h2jpz9TcYFNYa+zxpFqbPZCas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amYbdNv77hRJsy+HrOAbB3MAKL8fKw30rLPEZABrkzxMr5myWcG+XgCD+7I7VnAwE
	 LAdhiJ3Y0YIR2GFblIjFfrIX89UVyYian1C4f+vNGhc9W2zcCEDSuylHaSiZLGERWC
	 A6wWnAp/twyy6e0rf5ZsK46vDeE6kWmbqr4Qzcd2jlMrSaw8hl1F46jDn7GXX4+/9F
	 F3tw59vH5Rd6o2xly0a/blboZqibWgI7UD1XlaqpK843uARDfSne6BiP6+6uO+fMQ9
	 dQLZ8t6ocEUG+Mwg7Et85p2FURunlkNi9vtnk9V5vxlY3udW2HFkW++Zhvahvq0CjP
	 1bPvq3Bl72DcA==
Date: Wed, 9 Apr 2025 12:05:33 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v3 3/7] x86/boot: Move the early GDT/IDT setup code into
 startup/
Message-ID: <Z_ZGbVXOTPbGXleS@gmail.com>
References: <20250408085254.836788-9-ardb+git@google.com>
 <20250408085254.836788-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408085254.836788-12-ardb+git@google.com>


* Ard Biesheuvel <ardb+git@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Move the early GDT/IDT setup code that runs long before the kernel
> virtual mapping is up into arch/x86/boot/startup/, and build it in a way
> that ensures that the code tolerates being called from the 1:1 mapping
> of memory. The code itself is left unchanged by this patch.
> 
> Also tweak the sed symbol matching pattern in the decompressor to match
> on lower case 't' or 'b', as these will be emitted by Clang for symbols
> with hidden linkage.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/Makefile |  2 +-
>  arch/x86/boot/startup/Makefile    | 15 ++++
>  arch/x86/boot/startup/gdt_idt.c   | 83 ++++++++++++++++++++
>  arch/x86/kernel/head64.c          | 73 -----------------
>  4 files changed, 99 insertions(+), 74 deletions(-)

This causes the following build failure on x86-64-defconfig:

   arch/x86/boot/startup/gdt_idt.c:67:55: error: cast to generic address space pointer from disjoint ‘__seg_gs’ address space pointer [-Werror]

Thanks,

	Ingo

