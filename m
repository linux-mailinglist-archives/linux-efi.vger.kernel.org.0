Return-Path: <linux-efi+bounces-2805-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20B4A3D8B1
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2025 12:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11507188FCCF
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2025 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E01C5D5C;
	Thu, 20 Feb 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fgffrj8q"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCEB1AF0B8;
	Thu, 20 Feb 2025 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050984; cv=none; b=KhR32BBwQDL4rYE3aV6aIpoxqWE9k2qEsozohnrD2pS6uVARnRl1Pb5GYbIADDT6q8/9Eq8oxbdHS8Fpor39KzJOjysdlEl1vxQIwF6V8bFrtDdOe4JTpK4wd6CVEkKPbktd4gzd5CQhOgqakIgD/w+MEBsDYEv9rOs33rwUATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050984; c=relaxed/simple;
	bh=xIyuCdDta91RFhrabLJ97xYbBUE+BNLouOxyJyc5NLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L05RXn0hmEup1yVkILfL47RnDefNYLA9fI5eg9FQ+Mrlz3fDp81ZvP6K27NoqrZL2Haj2N3jEd+ISHHNovWSiOZFX9LDxQe40QF2hXWklRurHeJZuBYfOujanP1F3V3U1mo0LxGpeuSOCjLy8l9Aiq7hP0WrpZjm+60/+lK/3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fgffrj8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ADBC4CED6;
	Thu, 20 Feb 2025 11:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050983;
	bh=xIyuCdDta91RFhrabLJ97xYbBUE+BNLouOxyJyc5NLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fgffrj8qgLn50N+wd4lWvqBK8aI6OMkY1KI+S7pMSaEdNfszfkWScFozrxV3JHIl1
	 fO8dmpbXxTRKVZpT2xTpK68UM9BmvX5zRlalOHN4SdO+TZ+4PvcmNq86bL0zH2dw7l
	 UtYh/ZXuELQMhR/n2JpjYsSMqOqIGNFzmHPNOMbgZ5vPTTUp206u/CvKtY6jKTH3R6
	 yIxBJ0tp6du4ygvgEAsir8LOmbIfZwokqOLbQmQRllx9p1G/L86A4/TjpNfKnmQgYT
	 vLXmptik8s3JaSQqQtUKt1Ac5mBNBvlDwoCcqgTSWYTdMz+2kbJTAsa03CpG89Wpft
	 LN0qJn3iE8ljA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30797730cbdso7784201fa.3;
        Thu, 20 Feb 2025 03:29:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmOSW1fi+RUGHKvdGTBPEInMtZqFVERW6v6N/WKIKT6667drBxTAXUBTRbQY+XTSl3+iEw2p0KFW3uFho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzkStpeG3qSLAJsnfqkXzxLdLhiqWcdIwT1Bxv2abIfELyg8QU
	IFpjzRA7FMp7XW7BvLqvNbznmLmKmYlEAfCDsZGUfzoQWnWG5UCgM1VQC+3yWVmbtDCeLjpduo4
	M12WslK5m+rbc+4yiZ3QT3M/a7Tw=
X-Google-Smtp-Source: AGHT+IFxxOOpQAUw+YlRFR6QBjCLOInd7MEmyYr+AvpjWokAv0szFn1WY0uNYzQd9wZ1XIBKhwLBI13f9jyZbRMxN/k=
X-Received: by 2002:a2e:3612:0:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-30a44ed1b0amr26869851fa.18.1740050981562; Thu, 20 Feb 2025
 03:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210174941.3251435-9-ardb+git@google.com>
In-Reply-To: <20250210174941.3251435-9-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Feb 2025 12:29:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHOqMM5uGxLTYuEf9KrxY5WzYvwo847JzoB-Qa2SN67Sg@mail.gmail.com>
X-Gm-Features: AWEUYZl6helD3VifwDamRDcDq4rF2tI3pz2H_S1p02AOqkD8vFTeE6BS-0gLbm4
Message-ID: <CAMj1kXHOqMM5uGxLTYuEf9KrxY5WzYvwo847JzoB-Qa2SN67Sg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] x86/efi/mixed: Decouple from legacy decompressor
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	hdegoede@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 18:50, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Since commit
>
>   a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
>
> booting via the EFI stub no longer relies on the legacy decompressor,
> and instead, the kernel proper is decompressed by code executing in the
> context of the EFI boot services, and subsequently invoked directly.
>
> The only remaining dependency is the EFI mixed mode startup code, which
> makes a detour via the legacy decompressor's 32-bit entrypoint, in order
> to obtain a 1:1 mapping of memory, which is a prerequisite for 64-bit
> execution on x86.
>
> This detour requires some fiddly setup on the part of the mixed mode
> startup code, which has to stash the firmware stack pointer and boot
> arguments in memory, and create a fake struct boot_params to trick the
> code in startup_32 to behave as intended.
>
> This dependency also impedes reuse of the EFI stub code in other
> contexts, such as generic EFI zboot, which will reuse the EFI stub but
> not the legacy decompressor.
>
> So remove this dependency, by replacing this detour with a minimal
> reimplementation of the 1:1 mapping code. With some further cleanup
> applied on top, the line count drops substantially, but without loss of
> functionality. The resulting code can operate independently from the
> legacy decompressor, and is therefore moved out of arch/x86/boot/ and
> into the EFI libstub/ directory.
>
> Changes since v1 [0]:
> - Create new long mode GDT that extends the firmware's 32-bit only GDT
>   so that preserving/restoring data segment selectors or swapping out
>   GDTs and IDTs is no longer needed at all.
> - Rebase onto v6.14-rc1
>
> [0] https://lore.kernel.org/all/20250108182218.1453754-8-ardb+git@google.com/
>
> Ard Biesheuvel (7):
>   x86/efistub: Merge PE and handover entrypoints
>   x86/efi/mixed: Check CPU compatibility without relying on verify_cpu()
>   x86/efi/mixed: Factor out and clean up long mode entry
>   x86/efi/mixed: Set up 1:1 mapping of lower 4GiB in the stub
>   x86/efi/mixed: Remove dependency on legacy startup_32 code
>   x86/efi/mixed: Simplify and document thunking logic
>   x86/efi/mixed: Move mixed mode startup code into libstub
>

Unless anyone minds, I'd like to queue this up in the EFI tree.

Boris, Ingo?

