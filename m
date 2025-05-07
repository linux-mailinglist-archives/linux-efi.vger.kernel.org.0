Return-Path: <linux-efi+bounces-3622-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57467AADBFF
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 11:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEFC4E04CE
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0860211299;
	Wed,  7 May 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GmmzQ1Ka"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D24421171D;
	Wed,  7 May 2025 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611899; cv=none; b=JwYGytw/QpQRNhpBNTFe3vuGLdodtxCvsHgDfvfWaRty6QrfquxKBtcmSagO1jsEh0R0n/Ln1TiDLhNVL1GWpQwUQpehX25D69rRiuAEknDj4Q+gmbOcDl7vW6J3lV8pYeoShsQYsISwoY2Vl82g+BQI4+Nf7Fj3JM6GXKW4doA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611899; c=relaxed/simple;
	bh=vuEFNCY+tWWCETEmTOXpsR3v2z6yRVWaOyJU5sL0l2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZiw33wiqaFgxi4q8bw/yJ+jX1oJoYZb5vWt9aPULUNesnaKEbEUgwFw2GSO40HWH1dTqWCCjAsiOvcOf48Lv+pG+O7XG9AqnC48OEWxpYU+4nq6SwdMJ9KJcnFEX4PqR1uYqPRGgVLdomn0Mq/laBOhrEUtoD/bQ+rt8GlOgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GmmzQ1Ka; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 26D6940E01FA;
	Wed,  7 May 2025 09:58:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1D33ZZGcJmh5; Wed,  7 May 2025 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746611891; bh=GVf4RoAqYoi1vRwmugZ9f4u/hX2lI0oCWwhhT5Q/hPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmmzQ1Kactg7nmX/rGEWozSHQq9U74UACCllTaDCunPjIY2+WkGVqvi+hvsyN9uM7
	 CL1cGHLDrGWyF4QrxxsfFhy8DHI1X19K/POwJHyTwJlOYP5VtU8HY8Q3uB2KTAuyjg
	 /1kR3AlCBJisihVeWL+qPNaAY4nMoXbgH7jL3rTu5DbRMlubruP18bUIsmRiS6TPh/
	 3a4AfuCbR9u4sApH2jNKiaWt9iz8noVpn3XVlH+2H/ootUeW1QTOIafW60YcK2rxHa
	 1xtP0AeQ9wXKXkFZLLDR29WSLgaPO+euMJHZmW3yyZHoCknZYqZQjR2FV51LWTL9JC
	 gJhtuj33zWi3jnV07QyBVoZl6GVKgob9+crqwFXQnqibJJ5cojgTP5x4DB46ZjQaKt
	 ZXlbxI605cybPpwyaWLVyQB8urPXeCW47PNw7BXmzpoTTrddQnJH/aE3sNbY1Z7e2c
	 VsdWtPuCj+wEdzbdYtybWuPlutuLzyqoUxD0uYStKRyd9sCPbFxxoBfMvsz2SbEhVC
	 YhBa18YeSdtqkvtqHd66Afm+jel8HZcK+5HML3MzAuH+0ObSRPZp1WJdk+B/SrJwFr
	 BIGYOIvobGVs+KFJM4on8TFPoYrgJCUhfUmVicBiV8n3gnTo2A+pbbITYTg8AegeEf
	 rXOlb2snquQRP1DX5ieBLvpA=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8386040E0222;
	Wed,  7 May 2025 09:58:02 +0000 (UTC)
Date: Wed, 7 May 2025 11:58:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v2 05/23] x86/sev: Move instruction decoder into
 separate source file
Message-ID: <20250507095801.GNaBsuqd7m15z0kHji@fat_crate.local>
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250504095230.2932860-30-ardb+git@google.com>

On Sun, May 04, 2025 at 11:52:35AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> As a first step towards disentangling the SEV #VC handling code -which
> is shared between the decompressor and the core kernel- from the SEV
> startup code, move the decompressor's copy of the instruction decoder
> into a separate source file.

Why?

I'm still unclear why that happens.

I'd like to read some blurb in those commit messages which explains the big
picture: the insn decoder bits are going to be in the bla mapping because...
, and because... and this is wonderful because ...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

