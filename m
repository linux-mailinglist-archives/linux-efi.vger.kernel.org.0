Return-Path: <linux-efi+bounces-3621-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E1AADBE7
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 11:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7913AE889
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38E2B9AA;
	Wed,  7 May 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="P8lrYmlr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB814012;
	Wed,  7 May 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611599; cv=none; b=bUXjcuPiuN42e0UqXuc94/ln1oZSJ8v8+gVTC3hqgly7ZG6/0QXXzzDfSfzRYZr4pj4aO0A04pIBKiqa0WFUqKak0Z2ict/th7fK4/XH3NeAWtw0RnTPwp0R8M92yqROERfLlExVI2aFLp9NhjuyjwdYo5fmAVdoeSmw5zHc3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611599; c=relaxed/simple;
	bh=VMA240LXAqTRDwypwBNfnbflCC0zonMAjdntMPWW6oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqP9B+LgmixNgbb3xReqKWy5buCy4w4/x1XPTdFmvWJvZ0kC+O9XShd90IhcRwtqkzvyjWcqhq3aIias60MSigq2/XLTmz9y7YlkWWXaWtXf8G7WJ3KmWSAB1x9DCfyRBuTn9YbqQyyG0LkI8Kl4ayv3DQEX6gPJ/iO4bGQZc2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=P8lrYmlr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3472D40E0239;
	Wed,  7 May 2025 09:53:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dk6229JfEtq3; Wed,  7 May 2025 09:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746611591; bh=Bhta1RNdemymUmw27Mlu0fCUuqi68ov8V02X4y4BXUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8lrYmlrWwxwm8uorVjxBCyJZV4QAfY/teN+GFbNZNV5Inp8DEeLu0ZQB+pkPTQhB
	 Ogtg19YVKcjPkFkzvRY5EDDIYAQXaSzoBWM1uC7UzBAVpMdyW29Cu7Ygs4rWQ9MepK
	 bo2kLaHDA55p4IAdXUcCSC3QxW0AEW3ZME4fjUh8Ds34eqvTifWRrna4+vCdreXCCu
	 nN6hIOJLQdGfn5OQfYPIk55XRuRndkuMUoj2jQtOhJIlPwJnyrCOv3h/ftjf2xTt3H
	 qZeUSNnFlYhTgaKwNfPBvMo3SYCcyjcMncYGKuI2x0NfeytWEHg1e73DnObfyfMbgY
	 v0V6/A5wqJ2P7V8xCTL3fA7RSrFTHLae9GsMGejFKB3n70YJodx7G9zITv55ybpkak
	 m6Un5X2Y6wrOhaiz+qFD64eEwAsXJOk3/0CUAdVHfJXHjcedi1hJoo50bsEreQT3tg
	 diEhi5wNOwK7hMgH9PNeXiu2p8YUhD3dHJRLQV3xT7rIY5OF7aCaAJBlviMlbBjJ+X
	 v1WQwgp/42Q3xPvzUwgaxuVNNt02GqgOi/Neb+Wmg1H3jSguSBBM3KZRWMS7tuGjan
	 irTqTeKa0IxtvRjaZL4CnEI//vXMKKT/Mu5EZn7OuF4FpNsj/S1lQQI0MmguqfWC2h
	 aoMotoHeFyvMwNgWm8PSyI2c=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74B7140E01ED;
	Wed,  7 May 2025 09:53:02 +0000 (UTC)
Date: Wed, 7 May 2025 11:52:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v2 00/23] x86: strict separation of startup code
Message-ID: <20250507095255.GMaBstd1-nsMixe3Kn@fat_crate.local>
References: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>

On Sun, May 04, 2025 at 11:52:30AM +0200, Ard Biesheuvel wrote:
>  arch/x86/boot/compressed/Makefile              |    6 +-
>  arch/x86/boot/compressed/misc.h                |   12 +-
>  arch/x86/boot/compressed/pgtable_64.c          |   12 -
>  arch/x86/boot/compressed/sev-handle-vc.c       |  134 +++
>  arch/x86/boot/compressed/sev.c                 |  210 +---
>  arch/x86/boot/compressed/sev.h                 |   21 +-
>  arch/x86/boot/compressed/vmlinux.lds.S         |    1 +
>  arch/x86/boot/startup/Makefile                 |   21 +
>  arch/x86/boot/startup/exports.h                |   14 +
>  arch/x86/boot/startup/gdt_idt.c                |   17 +-
>  arch/x86/boot/startup/map_kernel.c             |   18 +-
>  arch/x86/boot/startup/sev-shared.c             |  804 +-------------
>  arch/x86/boot/startup/sev-startup.c            | 1169 +-------------------
>  arch/x86/boot/startup/sme.c                    |   45 +-
>  arch/x86/coco/core.c                           |    2 +
>  arch/x86/coco/sev/Makefile                     |    6 +-
>  arch/x86/coco/sev/core.c                       |  189 +++-
>  arch/x86/coco/sev/{sev-nmi.c => sev-noinstr.c} |   74 ++

Can we drop the "sev-" prefix to filenames which are already in sev/
filepaths?

>  arch/x86/coco/sev/vc-handle.c                  | 1060 ++++++++++++++++++
>  arch/x86/coco/sev/vc-shared.c                  |  614 ++++++++++
>  arch/x86/include/asm/init.h                    |    6 -
>  arch/x86/include/asm/linkage.h                 |   10 +
>  arch/x86/include/asm/pgtable_64_types.h        |   43 +-
>  arch/x86/include/asm/setup.h                   |    2 +
>  arch/x86/include/asm/sev-internal.h            |   30 +-
>  arch/x86/include/asm/sev.h                     |   78 ++

Pfff, sev-internal and sev.

I guess I'll know how the new structure would look like once I go through this
but there are so many sev* files now.

Can we tone that down pls, through aggregation, moving up into headers and so
on?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

