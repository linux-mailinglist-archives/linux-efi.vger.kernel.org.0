Return-Path: <linux-efi+bounces-3804-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4436BAC9409
	for <lists+linux-efi@lfdr.de>; Fri, 30 May 2025 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F85D1C07DC0
	for <lists+linux-efi@lfdr.de>; Fri, 30 May 2025 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18281D5154;
	Fri, 30 May 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OXW30ueo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47337080C;
	Fri, 30 May 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624131; cv=none; b=bfDXPF2ygIP6xmLD0QkEltphrO3k9eYUvi8PA087MpukMJ8SB8xBArCzwCbQ1MgnN7ilXWPAoTDc1OrdfNjYXPL9HFDaWBTobicfrT8Bky2Gfuo7RndxfVHkYtILaNJk6ZgcOA16+YWkpTpWaLat2p1if98FXubzBA7GAd70BhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624131; c=relaxed/simple;
	bh=Y/ZNDhbZPxI5Q5vNyohghTIT08W7HC5P+HaToWQcWnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUZoabc+SLnDprFvu99/Ur/nyaApwyMzAnFtQDAkSPebD8yQMc/jY05Bh+CQEN0oxtSyAAa61PoRMBIFGoKwozlNHYlX/szN4RpRcERcpw6FNqoSXMg4zk/Wd5ml3svkJUQSCZncinXLi0YC2aajkAbUi5+uUFALjC4e2+NeofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OXW30ueo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 335E540E0184;
	Fri, 30 May 2025 16:55:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wsJhCYL0F5jm; Fri, 30 May 2025 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748624122; bh=UCnscb2i8GAhr3D1Oc4ttNw0LBD6aNo9sqHqBYCJ8KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXW30ueoiS9Iufb5/GF5ghVFPwi+ZsJRctr5KVrHYU+4Eu4STzsRNWHb23bDb9bRY
	 +HGLsvde6DPDjUGmlnyEYfyJOJ5/r1f1DiXYWiJu/yQ4MBprnJbAdMnmaWv5g2OvOq
	 63nBqnuallzvsEIzeWkfxDUDPBD2/KaNQQqjMmxXhvnJWdyKT0ELyfA242yJkrJoQN
	 6VLT9zK+KxAhwBj/J6xNnYAm1zr4HgxaVZmmTLmR4ADcFYcjAIIum63d7z2TC4qLzK
	 kQGj/OEId9G3rpO5cIzT/GekCyVsVK81Ft9PGt881yND2uhicN+iyM5CLytgMlapxL
	 /fd4TdDsatNNl0h4O/XNzKTvMcFylNULEVQCTxwogu/IlKyeo7NaGYadpMe19WiVRZ
	 zhe+Gx3j8KgCJtQ05sBrPriKeGssxkHblQscUCL9o7eT8VIIrq4LRADOd3UUkK7IIB
	 TF6X3sOihGYgPFKcfzpfwgWA5yTsY5p0pgNN55tf2U/YPqhl6oS/pZf3GsYU5IqL1K
	 vSwT0bfMHiZ8bgt2wIxylkFSa1Pn4saT1bgFxAlP5YILMhHIQ/v/exvu4299C8zelw
	 N55bEk9N8lx4b9/JY7eKujGzqyXo8Ckqz1Y4ykGsLZAK2KTcvzGivbLE61svN3OUh9
	 fUv/Fz8lbiyh+D09rPeaydZI=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D71240E015E;
	Fri, 30 May 2025 16:55:13 +0000 (UTC)
Date: Fri, 30 May 2025 18:55:07 +0200
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
Message-ID: <20250530165507.GBaDni69NqgOi4mFNn@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512190834.332684-35-ardb+git@google.com>
 <20250530111645.GAaDmTneZG7KOX0ApR@fat_crate.local>
 <CAMj1kXEzbBTYr2vF3g_z49muSTHwRY1QUm2iOFsaLNYuijqHDg@mail.gmail.com>
 <20250530160809.GBaDnX6auAVJu9PFLr@fat_crate.local>
 <CAMj1kXEeJMV5AX9NjLYEwukvpKrDQCvzRyEivj43P7TRH3qFVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEeJMV5AX9NjLYEwukvpKrDQCvzRyEivj43P7TRH3qFVg@mail.gmail.com>

On Fri, May 30, 2025 at 06:12:43PM +0200, Ard Biesheuvel wrote:
> Because the assignment is moved out of the startup code later.

Yeah, we will have to check ghcb version though.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

