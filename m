Return-Path: <linux-efi+bounces-4672-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18147B419CD
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 11:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0746561C14
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991F2820A5;
	Wed,  3 Sep 2025 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNAGXnWh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D391078F;
	Wed,  3 Sep 2025 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891268; cv=none; b=rbstnm9uCuAsVoRmcQMJbXYCtLtkTAM4m9RMaQPUr46sqc4P3GS6NGI6Qlhb1YOQ7ywtgbTaGo1CCGrWCp5wm6sNQPPbdmv4Wh6j1qZ5tHbBtij1Jku4VVL3gywiFTYDqbqkWg/M+/d1K4kBW+kfIspaMHGnJe05gQRnBgiFl6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891268; c=relaxed/simple;
	bh=Xqpq8Lc24IQoRH2EdIwCFD7uSsvo6VHZfwDcz+uivYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uk9XoSJo+fjCGPeijzwMPHVW8u7xYgYpVcjtEf96cjpE8dK4uZW1rgYs0XPJAAdO8oKoVzMmhWO1lM98lpeh3nv7JXtjLI4E0rqBi3RCQkbN3DiSGCdZvQkoYm3cGjhFsohUsyypFSAm5KZcIdZO8vaXHM99vEcST7/1cveFOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNAGXnWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA82AC4CEF7;
	Wed,  3 Sep 2025 09:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756891267;
	bh=Xqpq8Lc24IQoRH2EdIwCFD7uSsvo6VHZfwDcz+uivYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TNAGXnWhh6/lhSuuUQYOYwTX4doC3NsUofRbj886sxg+P8fAQ1YAAjrz9E++PxNbi
	 7oVbUPWWgs1/96rclNc6rvmbbPLG+e5hYJudmhKzZudLK4L3u/OBLVOzci/JAgBOEO
	 IUIQUexzl7b6fC678c2Y1Mvj2SW58JJjEaZRryg08d8cTBMAY+fQNx3LIpZUlrDDkT
	 1qg1kiQ/X5eF5juK155EbmlpMR0eCVSxU+fEV/E3NfBuN9WzajB9I7XIZb130IuoOK
	 mglBdUM9ZQuLaZrfbBfn352GnOzyFyp6pvVgSsueQRzdIHige7NYlEuqu/vlDk7dbI
	 BN8mVTQm8Ih4w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5607a240c75so3016187e87.2;
        Wed, 03 Sep 2025 02:21:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+V/sstWao8KxThB+xiRjrnDmILhaWCwHNhUGw/tHlBhnqJSvUydfa6d5xG1qGHSEmlwAKKp4u4mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaTVQOh7PqGqKEYSGDdiUzE9rgv7Bw8oEAzrLpUl4RLHMZ6mK4
	Wp0VYNSjsz+AfcUn6LZHQWRmX2oaZ2TWwO3YW+N/kRCFDwZwVxxmBTgagQ0HzdfYe+Yl/k88v+L
	vjdkGqgPJfI1jWy443uthTBi2sgEfp98=
X-Google-Smtp-Source: AGHT+IHHSFPCMO6lkAiXBWIg9zb2ZT3AvY5q9nCCZGd/CTk2IoHlYtAPrzO2zhFxRqjWUN5WN9SlNL450f+rRVVqL6Y=
X-Received: by 2002:a05:6512:31c6:b0:55f:4f99:f3cb with SMTP id
 2adb3069b0e04-55f708bce2emr4645380e87.15.1756891266072; Wed, 03 Sep 2025
 02:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com> <20250828102202.1849035-45-ardb+git@google.com>
In-Reply-To: <20250828102202.1849035-45-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 3 Sep 2025 11:20:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEz89RyRCv94ubGcq3=fs27DaNNkJ8ZT46ifKNqu9+ixg@mail.gmail.com>
X-Gm-Features: Ac12FXxwoFz7Fg92ES6w39pX5Vz2xLwZrrckhWtub9BIBLa0-sdbiEm5OB7dItw
Message-ID: <CAMj1kXEz89RyRCv94ubGcq3=fs27DaNNkJ8ZT46ifKNqu9+ixg@mail.gmail.com>
Subject: Re: [PATCH v7 21/22] x86/boot: Move startup code out of __head section
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 12:23, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Move startup code out of the __head section, now that this no longer has
> a special significance. Move everything into .text or .init.text as
> appropriate, so that startup code is not kept around unnecessarily.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/sev.c      |  3 --
>  arch/x86/boot/startup/gdt_idt.c     |  4 +--
>  arch/x86/boot/startup/map_kernel.c  |  4 +--
>  arch/x86/boot/startup/sev-shared.c  | 36 ++++++++++----------
>  arch/x86/boot/startup/sev-startup.c | 14 ++++----
>  arch/x86/boot/startup/sme.c         | 26 +++++++-------
>  arch/x86/include/asm/init.h         |  6 ----
>  arch/x86/kernel/head_32.S           |  2 +-
>  arch/x86/kernel/head_64.S           |  2 +-
>  arch/x86/platform/pvh/head.S        |  2 +-
>  10 files changed, 45 insertions(+), 54 deletions(-)
>

As reported here [0], this patch needs the next hunk folded in to
avoid breaking CPU hotplug on i386

--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -136,6 +136,9 @@ SYM_CODE_END(startup_32)
  * If cpu hotplug is not supported then this code can go in init section
  * which will be freed later
  */
+#ifdef CONFIG_HOTPLUG_CPU
+       .text
+#endif
 SYM_FUNC_START(startup_32_smp)
        cld
        movl $(__BOOT_DS),%eax

[0] https://lore.kernel.org/all/202509022207.56fd97f4-lkp@intel.com/T/#u

