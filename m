Return-Path: <linux-efi+bounces-3585-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8177AA8700
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 16:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DF3177047
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B891B0F19;
	Sun,  4 May 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8PW1jib"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2401FAA;
	Sun,  4 May 2025 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746370536; cv=none; b=BMezJsYuoJbWbSPvxVbVTzlEsRIPXym01qK/RcgY35Ac+eNkH7aHiB/I/LzF1lG/sLmUZrYoFBWYtmNMuoXFRk2coBOR1TaDQWHKlNfNR9CoeZvP4klg6HVfvNKooSdsDWWXsAYbbCEoxoVQ0gnM7B2xF84sgNvyamOl+ZhihkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746370536; c=relaxed/simple;
	bh=86tEPUVuBzAhlwgRC09NxBCBvjUH0qEMop1gzGm9ycU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJrIasnL60BLmTRiInG6swl/GtKlEFnayfSvYViR4bSkUN1zAYY/Ng5zhGPLWAMuNSmPggfVccqsIvE9Cp06x34fvs0r2qqxEWVhrYDeuoN/zBp0lunyVYMNMfRwM00/sAtHIB6+O1S5mxV5tYAeEs4o4a5Qji9g3pe/tlDfH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8PW1jib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13F0C4CEF1;
	Sun,  4 May 2025 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746370536;
	bh=86tEPUVuBzAhlwgRC09NxBCBvjUH0qEMop1gzGm9ycU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s8PW1jib9LCyi7dtyzdkJmCJ3ASrFlDO8Usv2UgBSJqDxQI5qh+2JmOAujFjZzYaS
	 81owPGb3bA8+LTFUs4w5gA6E3mUgZD3u32TdG5e01MhtAapK+0dvxOzS+4L4oHtP1W
	 jH/ssSkB/ICrue3beGVelrSJuBuRjBXqUANTCWT1gnkmXk1dreTbmiDveVo0bKmGWi
	 AtbSHLRz/5Gt4chMopSNZ0UBGKYPT+qMYMAcKoCBL+SNj5Lx7JqOHj8e7ZjXVAgws4
	 iVFJdBkOMUUJaMJbIKp3t5AVi+sBRUUAw8blADWKgyGD/DrBrBuw0PXZmN2mBVR1Vc
	 ymG42LG96MmTw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30ddad694c1so37647241fa.2;
        Sun, 04 May 2025 07:55:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjFZEGQ11mGZ2QXF1Iqxl/eGZbPnWpZPVgsxgM9Cej8J1eg46TMxhd2jrs36/fCuH84aI+fY04HtO7uU2/@vger.kernel.org, AJvYcCVpN7uG1wAf2T6mPovfxmn8JSQr1499rkTgSFuyPpfxW7bYX9apQ5RwIZNLfHntQg3WyMrTFdhRvsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqunQPzxnYxttVhVKCpscOibeEJtgAvlb6cybdo8JN8rs0rlva
	lpcTM9F7+0OJqZiaetRtvn5HPS74v7vFu2XX+blFLMR/fAAInvwbY8HOfmpaPoRAyuddHde2AcV
	CkJnNEkom31ZEhWTlJMP+kJoy82A=
X-Google-Smtp-Source: AGHT+IFh++Rv4or39k0AXKcHDCcHZNIeTFmq58+4Z8xvhl3jruf+MkCfuZeKSgebmpwceTaBeTHNkH2szWqPgOBcd0M=
X-Received: by 2002:a2e:a582:0:b0:30b:ee44:b692 with SMTP id
 38308e7fff4ca-32352606c21mr14838821fa.33.1746370534993; Sun, 04 May 2025
 07:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com> <aBdz-4hJu0zp40mC@gmail.com>
In-Reply-To: <aBdz-4hJu0zp40mC@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 4 May 2025 16:55:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE7Ctbsu+z2WST9s22NFvPVXoymPfidjJSXgdfvtWZVxg@mail.gmail.com>
X-Gm-Features: ATxdqUFFO8-StVY_JgAC2gyAegFVo0AB59R3mJ0xgmMqdiUCkm7xG67ZISDP8Mo
Message-ID: <CAMj1kXE7Ctbsu+z2WST9s22NFvPVXoymPfidjJSXgdfvtWZVxg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 00/23] x86: strict separation of startup code
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 May 2025 at 16:04, Ingo Molnar <mingo@kernel.org> wrote:
>
>
...
>
> So to move this forward I applied the following 7 patches to
> tip:x86/boot:
>
>         x86/boot: Move early_setup_gdt() back into head64.c
>         x86/boot: Disregard __supported_pte_mask in __startup_64()
>         x86/sev: Make sev_snp_enabled() a static function
>         x86/sev: Move instruction decoder into separate source file
>         x86/linkage: Add SYM_PIC_ALIAS() macro helper to emit symbol aliases
>         x86/boot: Add a bunch of PIC aliases
>         x86/boot: Provide __pti_set_user_pgtbl() to startup code
>
> Which are I believe independent of SEV testing.
>

Excellent.

> I also merged in pending upstream fixes, including:
>
>    8ed12ab1319b ("x86/boot/sev: Support memory acceptance in the EFI stub under SVSM")
>
> Which should make tip:x86/boot a good base for your series going
> forward?
>

Yes, that helps a lot, thanks.

Please also consider the patch

  x86/sev: Disentangle #VC handling code from startup code
  11 files changed, 1694 insertions(+), 1643 deletions(-)

It just moves code around, but it is rather large and is likely to
cause merge conflicts if it lives out of tree for too long. The +/-
delta is mostly down to the fact that a new file vc-handle.c is added
which duplicates most of the #includes of the file that it was split
off from.

