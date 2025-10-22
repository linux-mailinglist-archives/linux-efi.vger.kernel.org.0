Return-Path: <linux-efi+bounces-5082-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39125BFB329
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 11:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BDD34EB8D0
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AFF289376;
	Wed, 22 Oct 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T5RI+pdR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E915295DB8;
	Wed, 22 Oct 2025 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126069; cv=none; b=UM2dDAfrMryoGRJZgaY0BZdPGJl/kVKsN1eX34HHTstHSt/Of1giOIdQ1lPUBXeoRLWUPBgFZdsOKKI6sh3xKoiS+yZYSvvVOKzsEFJLSwrlD/bt677i+A6vYaF1q305UQsadQPdy2GqLADzhrnIrdNa2Dg4Ir5t/brCFF09E8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126069; c=relaxed/simple;
	bh=DQS+3Lj6HgUTKH2FCc9SUmL9e/0g86t6TGjbhFN296o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e23XFmFncI0Kp7DIwlT9knWVAWs6/3CqGBp1rhNeuP0LIwC3KiceOOK26/tYzYdX00mKsJf6xZDOM5UyHndhOMM791FSbGa6/V4SOP/8A2BtlkJc3QlBOPA9mK6KO2p3YMbGknvSJA/ZA6qVG9F5BbMCCfDJqxx5MwcRm2F/KLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T5RI+pdR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CE9140E01A5;
	Wed, 22 Oct 2025 09:41:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tymK5Eeqzp_j; Wed, 22 Oct 2025 09:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761126056; bh=U0GFp4v3c3eKRHJibnqVorD3KH7ifXU7oASjTdlgkDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5RI+pdRWtkGY0bmVzumnHP+wQOn8fnphNfo3caBE3jyhNTE2Niz5tTCIJ7KHvVs/
	 26ZO5SOWkxZJuJmH2V9jl59eEmNYvv4jUJPG4xZviXVSmITBzQ3N1c40Bw6U7Dw9Sg
	 1HGi+dzk9J/pHFb7/TnANesHiUeYtaZxVr1ZA+pZGytYD66iFDOm2lx3X9bYpY8gVu
	 +PEYUq2ym3lCVKRecTe3m5gYMUUWSXKXjr5v7+kWDGNf/+vzc7ACGpNJkrQdD0//A4
	 zeju34MkOCTIi7y13YA6hZzKz7tAertw+zIuRK35gIvPaOgKHceJh7nTQFx/aIEmUj
	 sPEN4EUMa5ueQSdnrJH5QwLv8bjmrbnElhxw2FbzmS6T49dV1NdpURDCd882SneeQb
	 LIaaEo0tpVYI98yWuqbGOb4ZXfDhUEfE3aGR4dP0gocu570Wb4Q928d0tsbu5MCbSD
	 Ey0sMdl/ufSy7y+144cbsaS8n7hqfZGOaKaTnQHIDnYPphta2Zokv/d4ssFxhy68XF
	 DiHiZ4KLg2k7OuqZL1bZLAPuspYO1JM+VAbOymlw2tre3ivOQz+KDPb+hy5GDDFOb/
	 q+XkG62oVboQm4jmD333vioCBng7OFKzOwYai02xL+WUFb3jBWyzTlAGvRrQs29vRV
	 TxGt5VmxX+B4DEQnK1TlI3ek=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 00BF540E00DA;
	Wed, 22 Oct 2025 09:40:28 +0000 (UTC)
Date: Wed, 22 Oct 2025 11:40:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20251022094019.GAaPimg3VCgRu6eELd@fat_crate.local>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-4-sohil.mehta@intel.com>
 <20251021200328.GMaPfnEDibnBrhNTmQ@fat_crate.local>
 <20251022082541.GL4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022082541.GL4067720@noisy.programming.kicks-ass.net>

On Wed, Oct 22, 2025 at 10:25:41AM +0200, Peter Zijlstra wrote:
> Initially the suggestion was to use stac/clac directly iirc; but that
> looses the information these are for LASS only. Hence the LASS specific
> ones.

Yap.

> (its an unfortunate arch detail that LASS and SMAP both use the AC flag
> and all that)

That is an implementation detail and users of the interface shouldn't care.

> But that's not the same, stac() and clac() are FEATURE_SMAP, these are
> FEATURE_LASS.

So?

Are you thinking of toggling features and then something else getting disabled
in the process?

> If you really want the _disable _enable naming that's fine with me, but
> then perhaps we should also s/clac/smap_disable/ and s/stac/smap_enable/
> for consistency.

So the enable/disable thing is I think what makes this a lot more
understandable when you read it this way: "disable linear address separation
around this code". And that is regardless of how the underlying machinery does
that toggling of LASS.

As to stac/clac - I wouldn't touch them. They've been there forever so it'll
only be unnecessary churn.

Btw, if you need an example which already does that:

arch/x86/include/asm/uaccess.h:37:#define __uaccess_begin() stac()
arch/x86/include/asm/uaccess.h:38:#define __uaccess_end()   clac()

So the lass_{enable,disable} will be yet another incarnation of this pattern.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

