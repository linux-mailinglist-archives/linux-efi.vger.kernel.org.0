Return-Path: <linux-efi+bounces-3422-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 935E9A97834
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 23:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26A6174DCE
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8745F2D92EC;
	Tue, 22 Apr 2025 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4tHydMW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30C44C63;
	Tue, 22 Apr 2025 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356173; cv=none; b=K2iYUgnJtrvLCRELcIFzFQTcy3saZvXPtOZqpYnozU7XawK3Tl0+JMICkUM00/q2KJ7TOqWBZq4yYJEp0pVOOvcaniopTYOW43wk+oGrgybGDqj2wX/sGDjOda0r8l3UIiT9uPXWdDBBeqBii/d0g/F8DlmIMQwN42jvvk2kw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356173; c=relaxed/simple;
	bh=cUfr38oNyf5FiuP5Az5z+qfc1012SRvrP45HcXUZq2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MswKBaTVSSlaimmGEkBvNmi5Ft1Fx1OE2qQ49ubQqILmIOI8HTXzyV2PYS3mamzBjKba+7OVbhRZyoe4boFTQwRla/soqpL5XhWtmnf8OWLVENIBiUM4qpuG1okO0apsuG71NiwCxVO0UjrGnrOs1wpjWclLKh//K+jnAWzsxzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4tHydMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD78C4CEEF;
	Tue, 22 Apr 2025 21:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745356172;
	bh=cUfr38oNyf5FiuP5Az5z+qfc1012SRvrP45HcXUZq2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h4tHydMWGBzkNsJAaDxUwnmADNZnbFK11jaeXREqAvyQwjy5HkQClcOptSmCi1xC2
	 dhg4NHIJvUAW6m+RvjYCBd4Xmb+9NRf2v3LAaxTFa8m+msxLRVFywasG/LuV2Fjp0W
	 m18XWQIIUz3eUTX6IMnEwYrZ+P/ilQ1jABrbOkxRpwUxM/35FVSpnc+cYeP6FaMQz+
	 mOUjJAmBFVsyQRrFo4uy2OS/KPiuiMIWez445xG1dOqi7wpmAgGv/9E7ACKrEVs7O7
	 4VVjxzEl2AgDi1NvmRZiwYiVVAEjMKUUmuCyvFmuOuez13qXOKNuvxOZ8DFE3fSiUN
	 0znUL8t/lowUQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3106217268dso48820981fa.1;
        Tue, 22 Apr 2025 14:09:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7kvCzTEvmjkAxSGRgWgrbU1+bHXDID6mc3I4Mnw7T+utBKbIYqi/AUbF8sBYCMPVTOdewgFhm5lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMVyi2EN7HgxnvQZz0GJ3rvApVEwoBcKnNeX0ewBGrvVBryf5
	QnfeyTb0htmqFWfLsIBvCyk+M9SFqvC6F6lWgjYNc+zdOUFCvLX3U5+IsLm87ssbx97XhxNGDB9
	O8Vak9VeAOAyn+M1YW8+n/8piOGg=
X-Google-Smtp-Source: AGHT+IGECkHZEwYZpAAjD4PP33tzMkJ06C42kDwzhLn2NXoc33aFewNDYieYlyzoMcJuLlB120BJRxkcs7O4aEvoT6c=
X-Received: by 2002:a2e:b894:0:b0:30b:cc6a:ffd9 with SMTP id
 38308e7fff4ca-310903bc156mr50938111fa.0.1745356171224; Tue, 22 Apr 2025
 14:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418141253.2601348-8-ardb+git@google.com> <aAf0K4sMd8brAQ_z@gmail.com>
In-Reply-To: <aAf0K4sMd8brAQ_z@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 22 Apr 2025 23:09:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEALOpMggoxx6wVTdpTR14krSSrxFKoOKWAfh15x9z4CQ@mail.gmail.com>
X-Gm-Features: ATxdqUGfzivbHQib5siDP-hsmWvJwZX6k_R82PIwEbcyI7ATkxw5MA0M5mdVD2o
Message-ID: <CAMj1kXEALOpMggoxx6wVTdpTR14krSSrxFKoOKWAfh15x9z4CQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] x86: Refactor and consolidate startup code
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 21:55, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb+git@google.com> wrote:
>
> >  10 files changed, 1757 insertions(+), 1724 deletions(-)
>
> So I think this is a new build warning/failure (config attached),
> from objtool:
>
>   arch/x86/boot/startup/sev-startup.o: warning: objtool: vc_check_opcode_bytes+0x53: can't find switch jump table
>
> Note that it's a randconfig.
>
> No such warning triggers on:
>
>   a1b582a3ff61 Merge branch 'x86/urgent' into x86/boot, to merge dependent commit and upstream fixes
>
> which is the base of the commits:
>
>   ff4c0560ab02 x86/asm: Retire RIP_REL_REF()
>   681e2901330c x86/boot: Drop RIP_REL_REF() uses from early SEV code
>   a3cbbb4717e1 x86/boot: Move SEV startup code into startup/
>   234cf67fc3bd x86/sev: Split off startup code from core code
>   b66fcee1574e x86/sev: Move noinstr NMI handling code into separate source file
>   092071e0f63c vmlinux.lds: Include .data.rel[.local] into .data section
>   a1b582a3ff61 Merge branch 'x86/urgent' into x86/boot, to merge dependent commit and upstream fixes
>
> Unsurprisingly:
>
>   starship:~/tip> git bisect bad
>
>   a3cbbb4717e120f9e53fa7685909b310f7e99bf5 is the first bad commit
>   commit a3cbbb4717e120f9e53fa7685909b310f7e99bf5 (HEAD)
>   Author: Ard Biesheuvel <ardb@kernel.org>
>   Date:   Fri Apr 18 16:12:58 2025 +0200
>
>     x86/boot: Move SEV startup code into startup/
>

Yeah, my bad - I forgot to disable jump tables, which objtool doesn't
handle well to begin with, but this is much more difficult for jump
tables emitted under -fPIC

I've sent a patch to disable them.

