Return-Path: <linux-efi+bounces-4717-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E9B508E0
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 00:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CAA3BB468
	for <lists+linux-efi@lfdr.de>; Tue,  9 Sep 2025 22:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599DA2222AB;
	Tue,  9 Sep 2025 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CCdf1nNP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A49131D398;
	Tue,  9 Sep 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757457072; cv=none; b=kJdGdUFDuNAb6brKQiurTxWxdeXcUWSHfuJvWUfHGuchZBVq4xQbEUKsafceNRr/VSnS/zGD0cWFJiUFKdBbveJjIKv54h+aJrDhIVh1IB2r2C4IfWVSOU0bU7Xmcb4NbAUNnrL7KSJbLPsMRn9K32i5Mq8aqk2Ay0u7sbA7CVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757457072; c=relaxed/simple;
	bh=Aq7rwhGw9BxmW8+v547+5vJ3prHg5vZthWMnGnkCICw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2l5ZWfhi7RTIlsLMSNDLL49PFGn5cHUdzY+0apj196yWI/h3NuaDYCq/4fOqUm0Qwp2e61RN9Ouht2mjU3omExVu+tx8Rw69WGsD5Cyn8n1PdlKxaohhWw5iQyOOrmRId5/Hu0Ao/DpSIqHhYua06pKlW6Xu7wq021/+wcShuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CCdf1nNP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 95C1B40E01B0;
	Tue,  9 Sep 2025 22:21:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UCc0RgvktYy9; Tue,  9 Sep 2025 22:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757456473; bh=yY+SNAV5Bd45YJHqst6VM4vZn5WuUQNd3ZiyhsJWz/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCdf1nNPUDsoYVTb/C0Q6De/8CNc4EDxZvesMQtGCopupd1o3Iltj2/GyB8+QFvxI
	 ohg42ooSX/W9a0vmbWQXp42bglUrlATFZzswRKZ6F4VlCfuKhWQT4DVE3E6BKA1HNL
	 G2mNBNq+nKRFU1fBimeT7JjQhKAi7xXFYE/14/NuanB/GZlcg8XRxijHFXAjVYO8u0
	 JUmHWHeg3UyhzN4fYCCLLPEt68hwBATZnEuKDmsez+/IgXX7tmQe193vHwATbx26zH
	 pUZ0Laef0Imo0i0fpYjkna33SXtZXvuNAqGZGd7RfkaACdgO7u8SbM7Hg7VJqHcAJE
	 Ee4QTLbQGtpzzVlaJ32l9sVjtnY/I7Z2mMMInbDz46TgF3skVagCGoi9zqznUucGZA
	 S58lJC41Zi40Ocpaq6R/EzjsZU2um7ak1IZSE3rtu59ZzorQ0YeQCYH1Wce9EJWqPv
	 2t8lxzGz6OjVhZyXsDecEgoRficfBfCP3i9yrZICPA9pkt0pXOLfAgFIFZhyPFZ5H4
	 j8gA0ZzXqN5O7p6z1WSbCvTAfvW6nay3y9DO2Wj9gjTg8jsKYi9WbH3S7h74NNthPA
	 r2aZPL+fYFwtRhySB6kcogW/YYt3EH/77j0f3Cc0kDXUxISD8l5C+IhR4xyyxBqxtg
	 srQ0W3StIumpFvJcSrVaIZ+0=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2BA5840E00DD;
	Tue,  9 Sep 2025 22:21:00 +0000 (UTC)
Date: Wed, 10 Sep 2025 00:20:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>,
	Michael Roth <michael.roth@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v7 01/22] x86/sev: Separate MSR and GHCB based
 snp_cpuid() via a callback
Message-ID: <20250909222045.GDaMCoPUqawgEenBsF@fat_crate.local>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-25-ardb+git@google.com>
 <20250828153317.GJaLB2vSvuR20WzgQV@fat_crate.local>
 <fbb24767-0e06-d1d6-36e0-1757d98aca66@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbb24767-0e06-d1d6-36e0-1757d98aca66@amd.com>

On Tue, Sep 09, 2025 at 04:44:07PM -0500, Tom Lendacky wrote:
> It only uses the MSR protocol for particular CPUID values in
> snp_cpuid_postprocess(). If the CPUID leaf isn't in the CPUID table,
> then it will set the CPUID values to all 0 and then call the
> post-processing routine which may or may not call the HV.
> 
> The second call to __sev_cpuid_hv_msr() only happens if there is no
> CPUID table - which will be the case for SEV-ES. So you can't remove the
> second call.

This needs to be turned into a proper comment, at least, and stuck above it as
the situation there is clear as mud. Especially after the dropping of the GHCB
protocol call, which makes the confusion even more probable...

I'll do it tomorrow if you don't beat me to it today. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

