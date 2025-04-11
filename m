Return-Path: <linux-efi+bounces-3297-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D1A86600
	for <lists+linux-efi@lfdr.de>; Fri, 11 Apr 2025 21:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C670D462BA7
	for <lists+linux-efi@lfdr.de>; Fri, 11 Apr 2025 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C81E27781C;
	Fri, 11 Apr 2025 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FWrMeXGV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149FE2777E6;
	Fri, 11 Apr 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398876; cv=none; b=ljap9saD2NY2SdoiObvVt+/nFBpf1rbBbkKC5YJ5PTviorGboMdfTfx9cexUuwYcJYx1jNulwQazbzILSVQ+moPmHwF5IUOrLTX3IV61wL9T28FNfNFptWtaeqh8W04NrRwZ70X+AnxOi+N98iSrDwYvE9ya3jI/leCB2xBgXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398876; c=relaxed/simple;
	bh=WDI8AHSxcouOiGKBzyJF4GF/gQt4/zkOMb6XKdO/S9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZarKxCmFLG+gECf32JUxuUdmqo5p+8zLO2qDubBvnWHBzDFxPb2YBrk8oyvSTbtL7kl9aQoPjOb8fjhabwS/U5gnrnt+tw+486T0sxZA50a0Cr6RJX/W7wl1oa7TTg2/t/d5I+8UEyYMNdB0mqxWUgN62rPO6/46Cen0WCc5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FWrMeXGV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 977DA40E0243;
	Fri, 11 Apr 2025 19:14:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mkVW_60QBI94; Fri, 11 Apr 2025 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744398868; bh=mvbauw3IMdzaqgZIFEMMu1DZnqX6HT8Q0VdVTCO+BGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWrMeXGVxBi2R3KdfThs34lisXSW2+FDcEeJkSEsfDKq6SGFGMTmOT+LPNpO//iXh
	 p/y/F6ETdmbE8gnxAClj1ZjwkFz56XWUIO4Oo+q79BTsES8vte4qyyHk5CgnMn3OMl
	 F4y/8IPsGVHw7nQNSBvWMmhnQpu7igRR0+6nVzebjisK6YQbGYBfGi0zVTH77g77W2
	 rkBdlenOvWkE7WPSaeSYTMaC4w1XNdQcpWfWNyOqoRXtMla7DIHT9z++/RC/rehNbJ
	 pmMIi4OgHaJDp0A83kuINhUbt7AkRr3RS8uJ0iRseMAzUKVAkL/y3ZCq6ez3WY4mz8
	 YaMkdPhV55WY4Z15Aq5x067Jj4/d4OXMD3CdhFQBUu16zw44lh2AUPz2R7yGD4bvS+
	 GcguVHG44pZPqjcVQWeAptObglWN0JI/bmxoIVqYOlphZmHD5MI9VLCo/6CRwYBtR1
	 0j4s10obuN7fS+smPlwQBLLXlXijRut1lxSjksvODsQaJW6vpmVTFFinQ8rrmIPl4d
	 2mlm1le6Rah0q1UgBcWOWDcQunopNIx1KyPoSsUSzLW+orVJQkH1luwHzZSQikQfv+
	 B4aE8w2mnlBcAyFbxS9+Uw52TZalrdpNoxUJjUZitpp2EUcwC254tBahcad53BOxa9
	 mSghWJCdKVFT4IZ++TUS0tqU=
Received: from rn.tnic (ip-185-104-138-50.ptr.icomera.net [185.104.138.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EDE040E01FF;
	Fri, 11 Apr 2025 19:14:19 +0000 (UTC)
Date: Fri, 11 Apr 2025 21:15:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v4 00/11] x86: Refactor and consolidate startup code
Message-ID: <20250411191512.GDZ_lqQAJRiQyjHqjC@renoirsky.local>
References: <20250410134117.3713574-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410134117.3713574-13-ardb+git@google.com>

On Thu, Apr 10, 2025 at 03:41:18PM +0200, Ard Biesheuvel wrote:
> Ard Biesheuvel (11):
>   x86/asm: Make rip_rel_ptr() usable from fPIC code
>   x86/boot: Move the early GDT/IDT setup code into startup/
>   x86/boot: Move early kernel mapping code into startup/
>   x86/boot: Drop RIP_REL_REF() uses from early mapping code
>   x86/boot: Move early SME init code into startup/
>   x86/boot: Drop RIP_REL_REF() uses from SME startup code
>   x86/sev: Prepare for splitting off early SEV code
>   x86/sev: Split off startup code from core code
>   x86/boot: Move SEV startup code into startup/
>   x86/boot: Drop RIP_REL_REF() uses from early SEV code
>   x86/asm: Retire RIP_REL_REF()
> 
>  arch/x86/boot/compressed/Makefile                          |    2 +-
>  arch/x86/boot/compressed/sev.c                             |   17 +-
>  arch/x86/boot/startup/Makefile                             |   16 +
>  arch/x86/boot/startup/gdt_idt.c                            |   84 +
>  arch/x86/boot/startup/map_kernel.c                         |  225 +++
>  arch/x86/{coco/sev/shared.c => boot/startup/sev-shared.c}  |  375 +----
>  arch/x86/boot/startup/sev-startup.c                        | 1395 ++++++++++++++++
>  arch/x86/{mm/mem_encrypt_identity.c => boot/startup/sme.c} |   19 +-
>  arch/x86/coco/sev/Makefile                                 |   19 -
>  arch/x86/coco/sev/core.c                                   | 1726 ++++----------------
>  arch/x86/include/asm/asm.h                                 |    5 -
>  arch/x86/include/asm/coco.h                                |    2 +-
>  arch/x86/include/asm/mem_encrypt.h                         |    2 +-
>  arch/x86/include/asm/sev-internal.h                        |  112 ++
>  arch/x86/include/asm/sev.h                                 |   37 +
>  arch/x86/kernel/head64.c                                   |  285 +---
>  arch/x86/mm/Makefile                                       |    6 -
>  17 files changed, 2208 insertions(+), 2119 deletions(-)
>  create mode 100644 arch/x86/boot/startup/gdt_idt.c
>  create mode 100644 arch/x86/boot/startup/map_kernel.c
>  rename arch/x86/{coco/sev/shared.c => boot/startup/sev-shared.c} (78%)
>  create mode 100644 arch/x86/boot/startup/sev-startup.c
>  rename arch/x86/{mm/mem_encrypt_identity.c => boot/startup/sme.c} (97%)
>  create mode 100644 arch/x86/include/asm/sev-internal.h

Looks sensible at a glance. The devil's in the detail with that stuff,
ofc, so we will have to test it with as many toolchains and usage
scenarios as possible.

Thx.

