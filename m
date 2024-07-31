Return-Path: <linux-efi+bounces-1526-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8DB942D69
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 13:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62CE1C22849
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 11:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1488E1AD40E;
	Wed, 31 Jul 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rdfXlEsA"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864CD1A8BEF;
	Wed, 31 Jul 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426021; cv=none; b=AjJK32vnEIRJV5VlYR6/mfPH7KOhT/IAel2Jnx90auvSMty7qEUf7kMa1XCTxdqZG6RjmlqiWSw/RMkpVQLSkD2Q/DWpQr/CS/bY7IAP6ebETJ7eQ4AEbzk4S3yT6Bpk09xudRpP5EZZoN22AFErVk6HSMMX8iMHiFZZyiNi6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426021; c=relaxed/simple;
	bh=VB8zuIkGeiks0g6qaKKdnBCfHjxgfC4ibEqG9JE2fpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJ21bmbCytBgKFlHQr0LogfTg+QBG39kdyb+Hrbi7/NFR7M3masaPNB+NlcMcGoM9QIOtAS0prNFSJptHehdhHQK/yWE3lr3sXeeGNoFX/mjqqtHN8VveIOS31bJ+wG8XBT3dNXBUtJ8z0jfRtlmLF8xGDMANan3I8mL3pMgMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rdfXlEsA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2iiBapHi5E4yCyY0JG3xWUh4YuuU45iPPgouplI2hYc=; b=rdfXlEsAuUDE+tc0RwDhVPiUPT
	yQRkMAOiOUZONJLi8qJLFJFzzS+XyZLEabzmTKR/DJiOskzEO93Hw05cX8UZuC/DfFE7uFCL2w0CV
	66NNG1mfMq0TkwZcGYDYhVgAVkMn00eXOpr1pAd5kNxl8yJeQencJOVV0gs9qIvocFIKJvF+ZMPCG
	qt6TDhO4IFp7mnqTdIemPm47zi36pEv8KQeY0uzRXF9I1fVAPx5GoEZ7vH4G34YfXABkTJQiYqliI
	rIOZXWecIqN/EAkib4htRzYlrEBFTYI8J5x5vAEtxxrcD5aTVPaycmeOyoOooWk9MURYmwhxxqCuN
	ShYi6ymg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ7gX-0000000G3oZ-1riD;
	Wed, 31 Jul 2024 11:40:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A9120300820; Wed, 31 Jul 2024 13:40:00 +0200 (CEST)
Date: Wed, 31 Jul 2024 13:40:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Shivank Garg <shivankg@amd.com>,
	ardb@kernel.org, bp@alien8.de, brijesh.singh@amd.com,
	corbet@lwn.net, dave.hansen@linux.intel.com, hpa@zytor.com,
	jan.kiszka@siemens.com, jgross@suse.com, kbingham@kernel.org,
	linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
	michael.roth@amd.com, mingo@redhat.com, rick.p.edgecombe@intel.com,
	sandipan.das@amd.com, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCH 0/3] x86: Make 5-level paging support unconditional for
 x86-64
Message-ID: <20240731114000.GC33588@noisy.programming.kicks-ass.net>
References: <80734605-1926-4ac7-9c63-006fe3ea6b6a@amd.com>
 <87wml16hye.ffs@tglx>
 <jczq52e6vrluqobqzejakdo3mdxqiqohdzbwmq64uikrm2h52n@l2bgf4ir7pj6>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jczq52e6vrluqobqzejakdo3mdxqiqohdzbwmq64uikrm2h52n@l2bgf4ir7pj6>

On Wed, Jul 31, 2024 at 02:36:47PM +0300, Kirill A. Shutemov wrote:
> The risk with your proposal is that 5-level paging will not get any
> testing and rot over time.
> 
> I would like to keep it on, if possible.

Well, if it is boot time, you just tell your CI to force enable 5level
and you're done, right? Then the rest of us use 4 and we all good.

