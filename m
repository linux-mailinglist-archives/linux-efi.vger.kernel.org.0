Return-Path: <linux-efi+bounces-6228-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKkeLCfIoWkVwQQAu9opvQ
	(envelope-from <linux-efi+bounces-6228-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 17:36:55 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 572371BADE2
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 17:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BADF3301E5CD
	for <lists+linux-efi@lfdr.de>; Fri, 27 Feb 2026 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B4346AFF;
	Fri, 27 Feb 2026 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB9xUxSA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03994346AF4;
	Fri, 27 Feb 2026 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210211; cv=none; b=Iy7/DMLNw2ciSRg/eq645O57hLmg6ChaHOBIx0KC8sxb664Yiz11aNeGFSfGNlCiQl5c/C0TsrYhXefPg2QUHMOqqSwo8iDYgxQRGhc565LGj+bVNvpsVpxarGPr3AbkJ9UK6YIvvRmXE1bS2WMIBYjxjHuyKJQPe+bclk4SW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210211; c=relaxed/simple;
	bh=Z3uhduLHgelJSPSi026On/FywI8UKkvvjlJZUY1E4uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4D7hI/LCGcYGwOda4go6qrFfHAv1hzevN6LyErDCSbRaVPLGnU4/g38SKTXmVX4F3HE2svlFGP65SwhInK28GiwnmlY2jJQ1cTyDLGTo8WG5zKya03cetl3WyNNRZrsD6KJd1rDt8HzLdgFxU5JxX65QpxFF6qvrjvTRIM25lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB9xUxSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1501EC116C6;
	Fri, 27 Feb 2026 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772210210;
	bh=Z3uhduLHgelJSPSi026On/FywI8UKkvvjlJZUY1E4uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MB9xUxSAbn+Di/nKHpsy4Owu9dULnOKmLKkKAH28ikPcwz8E+RbfqqGz2GrfUKoS2
	 rvjh4SLv6O9JiT+L+6SpQ0H/DrDTd5iZ4+QO2UVbr+MNaN2vtvrRDHMh8InzWzLS16
	 cncFCKpao/cWYr+w7ULn5xRgtHEAxOxUtF8TV9x/Gfm0Xhf56APc04TeRI/vI1HLWn
	 rCK2y6qdS+KgajafeMKD0K51X5N68v1p6QI6T4oKzSBTbcUtFAPrySuzhetHWqfeao
	 I9O/HuD47cl1xQtwtjRali7R0u0JCyq+rfuleR6cQliX8wPX4/lv7UgeBNEjV4a1Vi
	 RyCLvFYLUeHLQ==
Date: Fri, 27 Feb 2026 17:36:33 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] kbuild: Consolidate C dialect options
Message-ID: <aaHIEQPiAbd7DGlW@derry.ads.avm.de>
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
 <20260223-fms-anonymous-structs-v1-1-8ee406d3c36c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-fms-anonymous-structs-v1-1-8ee406d3c36c@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6228-lists,linux-efi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kernel.org,xen0n.name,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,alien8.de,linux.intel.com,zytor.com,linaro.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nsc@kernel.org,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-efi,lkml];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,derry.ads.avm.de:mid]
X-Rspamd-Queue-Id: 572371BADE2
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:10:28PM -0700, Nathan Chancellor wrote:
> Introduce CC_FLAGS_DIALECT to make it easier to update the various
> places in the tree that rely on the GNU C standard and Microsoft
> extensions flags atomically. All remaining uses of '-std=gnu11' and
> '-fms-extensions' are in the tools directory (which has its own build
> system) and other standalone Makefiles. This will allow the kernel to
> use a narrower option to enable the Microsoft anonymous tagged structure
> extension in a simpler manner. Place the CC_FLAGS_DIALECT block after
> the configuration include (so that a future change can move the
> selection of the flag to Kconfig) but before the
> arch/$(SRCARCH)/Makefile include (so that CC_FLAGS_DIALECT is available
> for use in those Makefiles).
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  Makefile                              | 16 ++++++++++++----
>  arch/arm64/kernel/vdso32/Makefile     |  3 +--
>  arch/loongarch/vdso/Makefile          |  2 +-
>  arch/parisc/boot/compressed/Makefile  |  2 +-
>  arch/powerpc/boot/Makefile            |  3 +--
>  arch/s390/Makefile                    |  3 +--
>  arch/s390/purgatory/Makefile          |  3 +--
>  arch/x86/Makefile                     |  6 +-----
>  arch/x86/boot/compressed/Makefile     |  6 +-----
>  drivers/firmware/efi/libstub/Makefile |  3 +--
>  scripts/Makefile.warn                 |  5 -----
>  11 files changed, 21 insertions(+), 31 deletions(-)
> 

Reviewed-by: Nicolas Schier <nsc@kernel.org>

