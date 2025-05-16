Return-Path: <linux-efi+bounces-3740-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206B7AB9E39
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 16:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039A51BA0D03
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561FB11CA9;
	Fri, 16 May 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFue6Bcg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92C219E0;
	Fri, 16 May 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404502; cv=none; b=Jmz3MQ1sklCLhAOlCy2H/KszPOa8hSL0/Prfkqhiyo/hgQ2FSt7N1APTbaAeXVjGiTjF0GQ6VtK0VjVBMVZRx89UKiMH4bGVUduCFyFCgfq6Wu9Io/DuyI9SWngg2haBMM1/wQ0FlEyCoNIj2J0ttclO3Mg2l/VbzTwPx4myShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404502; c=relaxed/simple;
	bh=S0UMLpnZ2LCy67bBVlX9k8i+8TEK54UopOU4ZIM201E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfdwOtAz0RJBVr4tBtTpjnkI1N49QFQnPCG7U4WRR8xODMBcxPgM5pgUdpd7TgLCVjAgJytq89DZzovmoNAcSVW5IPKCzXUlOPorC2MyUb9wXzZyzlqcu35TJ0E73kJZQrvv90AEBfeFqDa7AZrCvXzCnRjc9gSU1udS48zcYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFue6Bcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7A3C4CEE4;
	Fri, 16 May 2025 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747404501;
	bh=S0UMLpnZ2LCy67bBVlX9k8i+8TEK54UopOU4ZIM201E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFue6Bcgdymnr+9kcKWC4RHjfE44xDWPRwL4CHK6AsQsUwaC69XLGdW3cVBy2U2+H
	 FxrcIfKT5s4dD/f912TbUXt9L1wo+WWPBzflWrv66/RQ8yObYQZ+KGKc4PAz8GMgyE
	 kt3DQqmpyyME/vQQpzZmtLeJV/U2X/TUz+l/20R/Zjo4pUSLokaeDa64Z/qp5ED5Fp
	 4AzQWH/Tnpa9se76mtKq/jis3M/pVD1vWuoC+nu9l6nSUjg6sdYPzs4GpoDS2KDZXh
	 0o+TqDdhjCe0GQTBD65y3dkRmK+MNJLqnEk9E6HgCy+URdsDDffaLgPlucPtkQHfmC
	 Mec8EjpzJL8kg==
Date: Fri, 16 May 2025 16:08:14 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCHv3 2/4] x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory
 model
Message-ID: <aCdGzpXSVx15gz90@gmail.com>
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
 <20250516123306.3812286-3-kirill.shutemov@linux.intel.com>
 <30570ca0-8da4-4ebc-84d6-0a4badfb7154@intel.com>
 <rqkfqkkli57fbd5zkj3bwko44kmqqwnfdm766snm26y2so52ss@6it24qxv356q>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rqkfqkkli57fbd5zkj3bwko44kmqqwnfdm766snm26y2so52ss@6it24qxv356q>


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> On Fri, May 16, 2025 at 06:42:03AM -0700, Dave Hansen wrote:
> > On 5/16/25 05:33, Kirill A. Shutemov wrote:
> > > 5-level paging only supports SPARSEMEM_VMEMMAP. CONFIG_X86_5LEVEL is
> > > being phased out, making 5-level paging support mandatory.
> > > 
> > > Make CONFIG_SPARSEMEM_VMEMMAP mandatory for x86-64 and eliminate
> > > any associated conditional statements.
> > I think we have ourselves a catch-22 here.
> > 
> > SPARSEMEM_VMEMMAP was selected because the other sparsemem modes
> > couldn't handle a dynamic MAX_PHYS{MEM,ADDR}_BITS introduced by 5-level
> > paging. Now you're proposing making it static again, but keeping the
> > SPARSEMEM_VMEMMAP dependency.
> > 
> > If you remove the dynamic MAX_PHYS{MEM,ADDR}_BITS, you should also
> > remove the dependency on SPARSEMEM_VMEMMAP. No?
> 
> I guess. But how?
> 
> And is there any value to support !SPARSEMEM_VMEMMAP?

Not really IMHO:

  .config.opensuse.default:    CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
  .config.ubuntu.localinstall: CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
  .config.fedora.generic:      CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
  .config.rhel.generic:        CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y

Thanks,

	Ingo

