Return-Path: <linux-efi+bounces-840-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA01886378
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 23:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B9283F6A
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFDE53AC;
	Thu, 21 Mar 2024 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9kUQWHU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DC522F;
	Thu, 21 Mar 2024 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061302; cv=none; b=V4SJGonnk1AuXYDXOwm55eDRQ3H/44cpHfWjylweQFUASIrU/UoyDhlIRLZ4CGfBwoCNRD3e7FLW3w+SYuJslFfXtE77Wk2vsXg61rZG+8YlSZ0HNobcazJX1ZrEsP+rjlZncs/8bf5LihZn9jXpzzVt52Fv9PllGZfPRtfPNhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061302; c=relaxed/simple;
	bh=8kZQaLxa0VikRd55GghvL73ntNDipBA2PLPwjJcF8O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNDcfr7KQXdLFi0eqcKIFcNN25YHaeNCE5+PePqHF6wF/XdscVl6wHl02gTzzX181M4senUVu6s22uI7+7lnflP5WByHniMDVk4m3Eb/EmjCf/2idMGo80FUF40SuLILM55CFIS/yGwTEnieswDUw4UaeSqa6Azt1gp+7wmRymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9kUQWHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3562C433B2;
	Thu, 21 Mar 2024 22:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711061302;
	bh=8kZQaLxa0VikRd55GghvL73ntNDipBA2PLPwjJcF8O0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V9kUQWHUKrAxIDxKddw6QS53ZHLQ6X5EYKqO5x7O1t7DEKuxHMXMh6JCkM2F4qCts
	 YdIRzCqNRpMqefFTHj/9fTlxvASCuXh0Ayg0j5XHlF/OpKZUmsyPogMln+W0aLVa5d
	 SQVQZg2SXI834AJTH97UhGNjxCCUx9vZa9PXldDWMhimfumYd4qqF4aofD0QocHC7P
	 KlRHApAQFTB2VVaNbBTOfxM84xa8antNJDqyK9YAhr/bXAQis24xj0NpgKcI34Uma7
	 r6iOdFrjEY6GOaYXwt/31XSHvMMWOt5asDXifnesPwqoY4QLTjazUsnVlJEXaCzHo3
	 VgbaYExkvtApA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so25318461fa.1;
        Thu, 21 Mar 2024 15:48:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4HOHp7pO3kVcCSO3gu4BKNUSCqA5YTgb9cec7ejfyPRwsTQJngIMIZKcj+Mj9hSHKUKdxtWTXEId6P6w6RNCbdIqYVCUYXZhzCSHjC0jeokAOY94sClmSygUKYaqiUyUWwQfHgdSF
X-Gm-Message-State: AOJu0YzSkW6RNCbv/u/OUD+CA2f3NotT3y8+iJgWc6AVtkdeUqo5g9pJ
	6n7w4sNZcV9uSrg0wmMaeq9MA/BVmWSLk/+FUufVMLFRvvmqfbFDtLfU1nOFP16V8zAmfxWGurX
	0KDPbS5UrfdvvioWZDMPNgtO+Ql0=
X-Google-Smtp-Source: AGHT+IEkCE0TynYKmXJrH9D+6ZeTFav9F1+QTT/OoQMMonJCMsI6pzVreSsRQjPGTG1b43KSouEEZp1/wKs3HUzoxhg=
X-Received: by 2002:a05:6512:34c4:b0:515:940f:b7af with SMTP id
 w4-20020a05651234c400b00515940fb7afmr391674lfr.52.1711061300349; Thu, 21 Mar
 2024 15:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321150510.GI8211@craftyguy.net>
In-Reply-To: <20240321150510.GI8211@craftyguy.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 21 Mar 2024 23:48:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
Message-ID: <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: Clayton Craft <clayton@craftyguy.net>, Hans de Goede <hdegoede@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

(cc Hans)

On Thu, 21 Mar 2024 at 23:05, Clayton Craft <clayton@craftyguy.net> wrote:
>
> I've been chasing a problem with 32-bit EFI mixed mode booting on two different
> (x86_64) Intel Bay Trail platforms, where the system reboots or hangs seemingly
> very early somewhere before or after loading the kernel. I've not been able to
> get any output from the kernel or stub over efifb when the issue happens[0], and
> do not have serial console access on these systems.
>
> v6.8 fails for me, and presumably so does everything back to v6.2. v6.1 is able
> to boot OK on these platforms with mixed mode, and it looks like there are a lot
> of changes from 6.1..6.2 for EFI/mixed mode booting.

v6.1 just received some EFI related backports, so please check the
latest v6.1.y as well.

> I did managed to bisect the
> issue to:
>
>         commit e2ab9eab324cdf240de89741e4a1aa79919f0196
>         Author: Ard Biesheuvel <ardb@kernel.org>
>         Date:   Tue Nov 22 17:10:02 2022 +0100
>
>             x86/boot/compressed: Move 32-bit entrypoint code into .text section
>
> However I'm not sure how to proceed from here, or if my bisect is all that
> useful since the commit seems to be in the middle of a bunch of changes I do not
> understand. I've been using systemd-boot to test this (both the full bootloader
> and UKI w/ the sd-boot stub). Is 32-bit mixed mode on x86_64 working for others?
>

I usually test on 32-bit OVMF built with LOAD_X64_ON_IA32_ENABLE,
which allows the use of the compat entry point. This is different from
the EFI handover protocol, and I am not sure which one you are using.

I have never had any reports, or noticed any issues myself. Last time
I tried (some weeks ago) it was working for me.
CC'ing Hans who may have more data points.

