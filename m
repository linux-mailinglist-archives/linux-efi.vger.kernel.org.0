Return-Path: <linux-efi+bounces-3802-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684D6AC9311
	for <lists+linux-efi@lfdr.de>; Fri, 30 May 2025 18:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BB9505C0F
	for <lists+linux-efi@lfdr.de>; Fri, 30 May 2025 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2800E2356C3;
	Fri, 30 May 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fYhvI+zn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F618FC80;
	Fri, 30 May 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621314; cv=none; b=VDoSw6Fny8R6zHuWQllGYdbXYF9e04LcVSXsYlrms3TuRv0CEHbWYOKl3F+qvWSSUhlzwBOcXCPVp4FHWts9pi1Z7RRNuKAmkBo7IiJTlHoyOjIJOEeZZ2KqcDAL9kT+FKkjH8qaMGMmeQ/p4JFTHN8/Fb81UtG5ibDBqplNBDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621314; c=relaxed/simple;
	bh=Apu/G+DHY1jr+3ezjF701L9jbgVsYzVdLmfMBcdVKHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUB/mMYycLh3RZclNFm1M6C1zl5dHNQgSbCX81JhQOnjb/8OesO44iHxX9d1RGJnj8op/yffvHEr+8Xxi76abVfGqfWBC7tkbiu9YRSdJPrJxiRTGjKX9gm0k0sUgWA6FVheGsmHQQdLKuZrS6GE+eeVKecg4Trq1zQe9OIey5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fYhvI+zn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 415CC40E01A8;
	Fri, 30 May 2025 16:08:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jcEva94uPova; Fri, 30 May 2025 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748621303; bh=P0xzSJoODo1gq24yAKCnR+juAxDSku6fWVl26Y+tLoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYhvI+znEDvl9ltQ89DW9npnK0D98HzEqu9N/je3ZcU76YCkAvL6NSrb47+v5XPKj
	 sghfB2wWkAh00QEM3smRb1hxzR3yLd7amtYanQ+miR5Fovx0chqJqsWBRlJsyIMzmI
	 ZcEXUBKpJWQTEirjQxSRqWukH26XzxXfWOMkUme8sOHDc25UaUCkhOboKGJwRWtWO8
	 iAzl4CFiUR2fQjmfZR+zsE7sTyXS+3dVWxq5vb0UzQHb/xroQ7uFOmc9CalzaWrQuf
	 i5JrQtc1cSc5cqRA3It9RlcrpKzbxhg5YPyffFeEMbnUaiehA+Wvvbq2kgEsrQHZTf
	 PXUOK7aw36Iw7A2s8zl3mIJKrZAJpfgztM1bb62yVrN0wfyF352EYEnAEswmkS5avT
	 jOs8FwmXCuv01jk5swn0fdSyZISpjOrn3+ViySiEGAnWdJqh4vw/GjBSWpYvyb10Ou
	 tvW5KJB2PA1SaZp1WXfOyG5ys7+O9c/q0UVsZfdcaGVtl5lSSpjtrLjw7eRq29PD/M
	 KdWskg/0hRX9H2vp0qQfgIvIPYAxXFaxnsEDcA3sjxVWpcGbQYGHXvsc5F4yfrARGV
	 /tDxxzPuOZar2MesU7X7SCrEFFg808/0VxYm1yNZTF7/1k0hQTJDT+PmqyND2D7jmh
	 C1hXqMFCBQOq4BQQfHBgTyOI=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 743D440E015E;
	Fri, 30 May 2025 16:08:14 +0000 (UTC)
Date: Fri, 30 May 2025 18:08:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 12/21] x86/sev: Unify SEV-SNP hypervisor feature
 check
Message-ID: <20250530160809.GBaDnX6auAVJu9PFLr@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512190834.332684-35-ardb+git@google.com>
 <20250530111645.GAaDmTneZG7KOX0ApR@fat_crate.local>
 <CAMj1kXEzbBTYr2vF3g_z49muSTHwRY1QUm2iOFsaLNYuijqHDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEzbBTYr2vF3g_z49muSTHwRY1QUm2iOFsaLNYuijqHDg@mail.gmail.com>

On Fri, May 30, 2025 at 04:28:52PM +0200, Ard Biesheuvel wrote:
> > > +u64 __head snp_check_hv_features(void)
> > > +{
> > > +     /*
> > > +      * SNP is supported in v2 of the GHCB spec which mandates support for HV
> > > +      * features.
> > > +      */
> 
> ... get_hv_features() is only when SEV-SNP has already been detected.

Hmm, I see

void sev_enable(struct boot_params *bp)
{
	...

        /*
         * Setup/preliminary detection of SNP. This will be sanity-checked
         * against CPUID/MSR values later.
         */
        snp = early_snp_init(bp);

	...

        snp_check_hv_features();

        if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))

This is called here without checking the snp boolean.

And without checking the version it is fragile anyway. Why do you even need to
remove the version check?

Just leave it in.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

