Return-Path: <linux-efi+bounces-6211-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DEQNrfcnGl/LwQAu9opvQ
	(envelope-from <linux-efi+bounces-6211-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 00:03:19 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC1817EB75
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 00:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5139730DC0DD
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 23:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA43F37D105;
	Mon, 23 Feb 2026 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+fu9p4B"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7A34CFC4;
	Mon, 23 Feb 2026 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887753; cv=none; b=NpYZan65GizD0C+pNKFrtOaD2xYW6Cs65/bJWVTuzChpiWdjYTqwweBbfXwVljibNt+2AH5FeU7O5WwEBwfN9t/qzH2pmOFR2TtAHKgy0R4GRiTXqtd3bFmZe2BayOhBy8oyIHBd1uXj/XXveagP+tCGhYQ8Yn26yyCmaRSPD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887753; c=relaxed/simple;
	bh=nT0awucs3thOhxybhtypZ+eYhg7lv1UzxhZoWxrV7JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqphRfl4aNtD6t5VL2lspO1UMpjWrQoZl+HFe+TP3BCHroxfst+Y4zz+WbhojUnqCVcDE9rFsOwC/4UkFfJI3Ft/jec6FPHjECgAtviATzJin3l1Gw98PqFkbXQIRQWEU90AwUjZ9KxxjuT8Paj6JAicxZkfCEO5h0J2h5Kwkcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+fu9p4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48409C116C6;
	Mon, 23 Feb 2026 23:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887753;
	bh=nT0awucs3thOhxybhtypZ+eYhg7lv1UzxhZoWxrV7JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+fu9p4BCluguUa+f3d7BCn1pI2i9AqAEMBzkLqH4bddGKT5WSOohV6ymAwB0/TBL
	 lXNzrl+hmSZblzdOixCvwDFcjW9iJo5ImvPlqCzkT22dc1XMIZWAMVzlyyqxTDXaZ5
	 4A5XwGEGtPXUctEhtggMXSRCQOq7U1cR9rpjbXPVnxUBOrPDtTlXe7A3JD/7+OhTOF
	 pTf4SXBjLVNbVuMyClIxv9c3QaOT9qAcBGv/vWbbNANtpasn+pQ210tXeKbMh0saY3
	 VU3OBF9raOPDCjnuuQKM50HH+X66NKDZ7QZi6Z7SFHAdAZXCsNZW64QbGHR00fFjZH
	 58/1MtBytYDmg==
Date: Mon, 23 Feb 2026 15:02:32 -0800
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] kbuild: Use '-fms-anonymous-structs' if it is
 available
Message-ID: <202602231459.2A1DD53E0@keescook>
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
 <20260223-fms-anonymous-structs-v1-2-8ee406d3c36c@kernel.org>
 <202602231432.20F3F0CF@keescook>
 <20260223225311.GA2462602@ax162>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223225311.GA2462602@ax162>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6211-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,arm.com,xen0n.name,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,alien8.de,linux.intel.com,zytor.com,linaro.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-efi,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AC1817EB75
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 03:53:11PM -0700, Nathan Chancellor wrote:
> On Mon, Feb 23, 2026 at 02:33:35PM -0800, Kees Cook wrote:
> > Series looks good to me. One style question, why go the round-trip with
> > Kconfig instead of doing it all with a fallback in the Makefile:
> > 
> > CC_FLAGS_DIALECT += $(call cc-option,-fms-anonymous-structs,-fms-extensions)
> 
> I might be misunderstanding how Kbuild works but
> arch/$(SRCARCH)/Makefile may have logic for selecting CROSS_COMPILE,
> which can impact the selection of $(CC), so I cannot use cc-option prior
> to its inclusion but I need CC_FLAGS_DIALECT to be included before
> arch/$(SRCARCH)/Makefile in the main build so that they can be used
> within it, which is only possible after Kconfig has run. This is
> probably worth more flushing out in the code or a comment since it is
> subtle.

Will Kconfig see a different CC than Makefile? Regardless, I trust your
judgement here! I actually rather prefer having it exposed via Kconfig.
:)

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook

