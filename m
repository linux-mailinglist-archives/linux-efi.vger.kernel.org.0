Return-Path: <linux-efi+bounces-3755-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A505ABD3D0
	for <lists+linux-efi@lfdr.de>; Tue, 20 May 2025 11:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5654A6B7F
	for <lists+linux-efi@lfdr.de>; Tue, 20 May 2025 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65C8264F9D;
	Tue, 20 May 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gkOgh9h5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F221B184;
	Tue, 20 May 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734276; cv=none; b=IVlE9M4fJEo5qpPlvjkNQiHeV/Imvbpdm442In7tMLHvasyoBDIKl3l0yVdYdr04+wo6fjfgp/0LeirfcHxWrhinVAdeThllqvdpLZO5Og1mc8Bhgr1oOZTWJHp10FYFNzpCCc8tyXwzSRfxkVszbuT1g70XqDgjWiQhquo+YNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734276; c=relaxed/simple;
	bh=bO+DvT6apIqfDNIy0+opP0c3rLtArKrovaS/OjzcRDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9RMDB1lEF3wksqTWJNcJ0Fr4kKEoz/EGXOgPk0r91KDoTZz7tQVdo4BnOiVpkpeZDViP3iw/ay6lboOTahW0ferAHajVJwlL8JKlM0mmaXd09Gc/QBiQV2+wKSQZzr8S/Ib0mfSszqJM3rMBnM/a/ZbWrvdNqVe9hVgpHcM2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gkOgh9h5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6689140E0192;
	Tue, 20 May 2025 09:44:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QJVdflCbhkG3; Tue, 20 May 2025 09:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747734260; bh=8XuSEfqTyKP4ftgDT3Tfzv5euFw1r4LAz8Ep7yXFTsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkOgh9h5LoBoj8C9a9jrO/WjCGmk7baPrtjkbhLD9RzEsl1u0G+iCNF6LmxaGp5lG
	 V3714mdsHmkwF+J8a0G1DLyPNGpYnjUWiTxr0dJR82L5RSrnKSckWmWq9ayfFX2uMJ
	 ZlZ+are26PzhsttjXQDzSnKf3l3r/HYjjllyKNXy3QTXmEvoA8cTS2ygQnV0Wh+imy
	 eauixXrWVAhR16Jzbx+o9i7Q9pfGiIxUeJvfIl+VdcLTQAfGHnyUyVGFPjUk80XsYE
	 JuG7SdoEasq9KmiNZw2DBHueGNg+y8Cp5pS/voik81L/lPlWgJZtF6hWWTDI1qC3aJ
	 ZXvbRH7eTM6ADVuFn33CYifrF3qMyDerz3YBRIRtcA0h6MsD7TI36rG73yVmrJ9FYo
	 QzCWzU5BgPX72QkhvkiGW2KLcV6ow8y61R0/Y0r3blHjXEk1vZcU4g477jZmfabwh6
	 H6hW/Fmimx2s9LLjZ/Jlk+svSZASnYOH/ZjxC2BHinCSOGS/HnetePqkLdUcMlS41S
	 qyI+wPeBOnr3qzqNOeSj0lUPPRz8seggQCYcmj0jG4HZ1Dqbm1kTERi4j/DaVQ6JRE
	 /KOgKEH0VggKSNj23245cnDwnlYRSYnYOfXTNK0mu7Hk+l/YltXZE2wvhFwFvkau1V
	 6CtFNoSas6La1NunPDk2MuxM=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5990940E0238;
	Tue, 20 May 2025 09:44:11 +0000 (UTC)
Date: Tue, 20 May 2025 11:44:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 04/21] x86/sev: Run RMPADJUST on SVSM calling area
 page to test VMPL
Message-ID: <20250520094405.GJaCxO5ZsGR3vFqH_V@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512190834.332684-27-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512190834.332684-27-ardb+git@google.com>

On Mon, May 12, 2025 at 09:08:39PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Determining the VMPL at which the kernel runs involves performing a
> RMPADJUST operation on an arbitary page of memory, and observing whether

Time to turn on that spellchecker... :-)

RMPADJUST operation on an arbitary page of memory, and observing whether
Unknown word [arbitary] in commit message.
Suggestions: ['arbitrary', 'obituary', 'arbiter', 'arbitrate', 'arbiters', 'Arbitron', 'arbitrage', 'artery', "arbiter's", 'orbiter']

arbitary, but results in the need to provide a PIC alias for it. So use
Unknown word [arbitary] in commit message.
Suggestions: ['arbitrary', 'obituary', 'arbiter', 'arbitrate', 'arbiters', 'Arbitron', 'arbitrage', 'artery', "arbiter's", 'orbiter']

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

