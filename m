Return-Path: <linux-efi+bounces-2161-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306659CF1DB
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 17:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45B72861E8
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3031D61AC;
	Fri, 15 Nov 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kODFfmSE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425131D61A3;
	Fri, 15 Nov 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688798; cv=none; b=sDb8DzWyFIXEvj91Gctkpz4qQw3jHvSjurgA5bkiq0ajalEcZmtgUezJcixAg85W/9u+SUxEh8QHQYU1fHiIU/rFzCdE1rrhkxz+Vc0g+fb0427QtKWjpuImubBl9zUw5wAIiFZu4qziizgU3s+4Ws5KQghTNUdK5CJeJnQR+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688798; c=relaxed/simple;
	bh=t1mHSIeHwWXgRLmkrrmBgqlQYmk5zzZwd34nRRtso6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc/vBjne8z/LtG01oxVxYxS8/2ktkobVWj6XFUQKdE//KxWneBL+LhnwOGc/qTEofQjscp2IVsJQZFf40Es9cngs2CU8m0xphC1xmlm29BG/c/XlQPhOCxzmR2mpg+Fs1dVb6pEs4X6XckWb/buxpnrk4hs3c36EPuD2LPcnk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kODFfmSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E77C4CED5;
	Fri, 15 Nov 2024 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688798;
	bh=t1mHSIeHwWXgRLmkrrmBgqlQYmk5zzZwd34nRRtso6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kODFfmSEDCffQECaHSSMMg50IhTVq8FxxtH+YcScfmllBgDrqQVxS8dKrV1crrlUP
	 Fmrc9StfUxoQ33m4RcZDFamAbzMJT9pacgugwYQYydD5fGcRXTgMJ50U7rl6r/nLWz
	 5N5PXhs1+qsL/f+r5jOLtU+iaRXZM9Z4JBG7RK2ZQDs7iYiwLN6xM5GlTCbKO74U9/
	 L/IIDsHcvouGBokmAYgRxxi/zP47uWxrj+znvYKyfI0lw8etxD1gZSIU/ayMc9CdGT
	 OJ4/02Ww6N5awcEDmoUbSvvfAk4V3IpMzI9PD9qXJelbHNvnYHevrKm662M+wkP2M7
	 VApSEY43o0FBA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53da5a27771so2352942e87.2;
        Fri, 15 Nov 2024 08:39:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIZAnbEIqZGGLnYujafiCEtRn4ctkY6MbUKKTbVoYF8GzRYfj8zhuWen3MKTbmqZFagzvynMJifa9gN2aZ@vger.kernel.org, AJvYcCV8sKgmjm4haVuN16JjH7IlZoXKIGb2zZsJtVwczUo+Q2v2WJvHok5ca2uBzJHnpq3KJAylYufiN4U=@vger.kernel.org, AJvYcCWiNJZuDoYJeS/4tswCCm6p1Yn73vxHwPH2T03gpMItMOT0TUM5dtmQeEHlVmmWIDGQIf6RsTav@vger.kernel.org
X-Gm-Message-State: AOJu0YzvXR9y3lE6Xa9zUt4tlag35j0wPreVfFzg/j80KECnwXl5X2X/
	TSWP8612dmgPew5sjqCSGM9vmB8DkGYEK0U4k2bx/RQa+mKKECPFKpnpzsz9BYs6Vk5MBOoRnSd
	gNk/aBAGMfyr1LzCX/o+hoDpOyhY=
X-Google-Smtp-Source: AGHT+IFLsie8pokR3jzGTAZqEFIhmQehBwU5ZZj22RDpZvJo+/+0M2kyNHP4E9apz6b9Okiyf78iEXFW/nZqzt0La7g=
X-Received: by 2002:a05:6512:398f:b0:539:f827:2fbc with SMTP id
 2adb3069b0e04-53dab2a21dcmr1494682e87.26.1731688796514; Fri, 15 Nov 2024
 08:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112185217.48792-1-nsaenz@amazon.com> <20241112185217.48792-2-nsaenz@amazon.com>
In-Reply-To: <20241112185217.48792-2-nsaenz@amazon.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Nov 2024 17:39:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGopsux6+xnsXW6vvQDJH9Y3_Ofq_QYvDa-SGt8AJ0nWQ@mail.gmail.com>
Message-ID: <CAMj1kXGopsux6+xnsXW6vvQDJH9Y3_Ofq_QYvDa-SGt8AJ0nWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanspas@amazon.de, nh-open-source@amazon.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 19:53, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
>
> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
> routine, kexec_enter_virtual_mode(), which replays the mappings made by
> the original kernel. Unfortunately, that function fails to reinstate
> EFI's memory attributes, which would've otherwise been set after
> entering virtual mode. Remediate this by calling
> efi_runtime_update_mappings() within kexec's routine.
>
> Cc: stable@vger.kernel.org
> Fixes: 18141e89a76c ("x86/efi: Add support for EFI_MEMORY_ATTRIBUTES_TABLE")
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
>
> ---
>
> Notes:
> - Tested with QEMU/OVMF.
>


I'll queue these up, but I am going drop the cc stable: the memory
attributes table is an overlay of the EFI memory map with restricted
permissions for EFI runtime services regions, which are only mapped
while a EFI runtime call is in progress.

So if the table is not taken into account after kexec, the runtime
code and data mappings will all be RWX but I think this is a situation
we can live with. If nothing breaks, we can always revisit this later
if there is an actual need.

Thanks,


>  arch/x86/platform/efi/efi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 375ebd78296a..a7ff189421c3 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -765,6 +765,7 @@ static void __init kexec_enter_virtual_mode(void)
>
>         efi_sync_low_kernel_mappings();
>         efi_native_runtime_setup();
> +       efi_runtime_update_mappings();
>  #endif
>  }
>
> --
> 2.40.1
>

