Return-Path: <linux-efi+bounces-3738-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E83AB9DE7
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 15:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00658A01E6E
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 13:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E541C84C5;
	Fri, 16 May 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C57zkcZH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E2189B80;
	Fri, 16 May 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747403111; cv=none; b=QtPjnSZNCCVCjnrs0U1SrGM10n4asR4aJkLIfZMXrx/T8vRCAXBwI7Qu/b1qtn8bvP0eaa1Byk6JQ6KnljPcahIO3AjBGBv2ugw0/1B7rBpNQ2NKAU5h9NNlQbhvc0NSCTvo/di3WdzmNeKgEPQ4UrLLoS0UJC2xIY69KJgMSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747403111; c=relaxed/simple;
	bh=NqMcz7kAbb5aJvvP9l+89oIjYYRsc8K6gsRCG9+3gWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k51nsvR/oS6f4m0LoEMwvF710qfoJlhtWUMdHMS+bFuF6wV+T0JAwwfG9VZrEkcRAHi+4Tw4mjdLbHOLqgUv11CAaPEiQV+sTpMXx7nhEtSW+HFeP7K/3hVnMe6pOf/uOszdgx4K0TQdlXpOSe8DWmBReViCkxuKodkoFjDXZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C57zkcZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0045FC4CEE4;
	Fri, 16 May 2025 13:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747403111;
	bh=NqMcz7kAbb5aJvvP9l+89oIjYYRsc8K6gsRCG9+3gWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C57zkcZHNxG39QzOBfiEQ5WVx5ny025ebHd7sSzDUPiXhD27xhutnCvPaPkakmlkh
	 EXRxTfnBntaPu//y0dnmPUBkLvyS5lUFyCrjo2uHghm3CRPSmK7aEOk0XAEkeAZUzo
	 NHr+5yTNdNKt4C1afkELV2RPT5+Dm6jSLXJjEnbe/ox6fEz/B4NGfz7VWGzb6y+nFb
	 RjeUDOkFjicEyfzWtqrZJSnXrEasrtFPHyZf65TXn27Kih4RmXxKcAREFvYfeB1L5H
	 ljf/u1Er13BfgSNLEjzBe2WAEe8A2Y8IMBiX+GhzFx6BZOlhyaqTk0o5Rfr/b3eKXJ
	 6Uw1Q3DeDT1rA==
Date: Fri, 16 May 2025 15:45:03 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Message-ID: <aCdBXxPNO4NtZ_Wl@gmail.com>
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
 <20250516123306.3812286-3-kirill.shutemov@linux.intel.com>
 <30570ca0-8da4-4ebc-84d6-0a4badfb7154@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30570ca0-8da4-4ebc-84d6-0a4badfb7154@intel.com>


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 5/16/25 05:33, Kirill A. Shutemov wrote:
> > 5-level paging only supports SPARSEMEM_VMEMMAP. CONFIG_X86_5LEVEL is
> > being phased out, making 5-level paging support mandatory.
> > 
> > Make CONFIG_SPARSEMEM_VMEMMAP mandatory for x86-64 and eliminate
> > any associated conditional statements.
> I think we have ourselves a catch-22 here.
> 
> SPARSEMEM_VMEMMAP was selected because the other sparsemem modes
> couldn't handle a dynamic MAX_PHYS{MEM,ADDR}_BITS introduced by 5-level
> paging. Now you're proposing making it static again, but keeping the
> SPARSEMEM_VMEMMAP dependency.
> 
> If you remove the dynamic MAX_PHYS{MEM,ADDR}_BITS, you should also
> remove the dependency on SPARSEMEM_VMEMMAP. No?

Isn't it the other way around? MAX_PHYS{MEM,ADDR}_BITS are now *always* 
dynamic, their value depending on whether LA57 is available and used.

Thanks,

	Ingo

