Return-Path: <linux-efi+bounces-2134-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E59C5009
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 08:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52E81F22607
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 07:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7526520B214;
	Tue, 12 Nov 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvUNRxQG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474FF20B1FD;
	Tue, 12 Nov 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398164; cv=none; b=n3QS4PBzpQqa4sjoulsIDg+4DCA8vlgGdBE9d4lwYLa1dSD8EzNcD8UJssoAMzvU5E4d2qXT+7WRr2Tr7bOl6LoTMl1vd6jZp1r4froi7kWjZaAb2C28m0dmcam8vEDd1QyaSRlkd4KUGuP2CRl2cJJHk2Njb4hwgi57ujtBjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398164; c=relaxed/simple;
	bh=V9lX4iOMzdPywPlNVTTgzZTq+EE2SHNVw6w3LpJCgP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkmcEx1qrR/ofyq7Y4J83wEjxOQlAT35hN+ByspawcClOU2jorKZhRxl4V/TLEA9SSZezsPVb8fQd1bZD/Cx5WBQEuaWJgDv1Hv4vBzE4aORMKzD49r8Uc3ZiRCDwnz2czSLy30QOv9VdsFGS2ofBCGSEqB0/AUbMZgA9m/xMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvUNRxQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13C2C4CED7;
	Tue, 12 Nov 2024 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731398163;
	bh=V9lX4iOMzdPywPlNVTTgzZTq+EE2SHNVw6w3LpJCgP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uvUNRxQGwDLlyDIQwFsfNXgmJshsTPmK7ijHBg1b7NsMU8uCSlpROaRjvEjZhlgSA
	 NsyACToEgfYZMvuz1MnOAmazyRfENqtqZT8ZPosmZwa4br+A8byz2DnyLiIXPq8cXa
	 Gh5L+J85W5VHfP1cRMV96DrdI6PC4aehyJKbS1B1sLIuOCbpeWjnNIMUTiDV5TEr4e
	 A0w1IRMTsvQswnZCXH4n6TCtZog+cbu/DQz49GevXDOLAnfidSiHpJJr+a5j0OTweQ
	 G+VjHH82+dJ9sKd2mYSJKkT1dj3n/Lmx0N32Mt2Vcia5tv2OHwQwJvfJYRC71sJ7J/
	 FFBVZRvwDy4HQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb5111747cso46086811fa.2;
        Mon, 11 Nov 2024 23:56:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpUzF74KyxYvpajzDgWkViDrPeLNMucR3Sm4hrgd46kI+T+KHWhpjgl8nek+SlNOF8VimRJY09@vger.kernel.org, AJvYcCVCxSg8b62ojUmW7d6yHHcpk1EWlwJb8hi3qS22zBx1zULX9xsf0gYsPHkZQsDyVqE24GtK5rzIrJ5HFOik@vger.kernel.org, AJvYcCWoNel0MzrDYhhDbRpF89okJae0f/r3H/A9bvOGfAndLwptt8N4Lfad6BeLdCtRWJt5VUEfMvVTJBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwVrl9TgKpUCeCVAz2W8JOK8UshfvcKpagQSIJoOiDwdPbiD2
	pcca0i9tZATzT4jkQSSO46hPySoEjoUMgtIZ8CLY53dFcnd4n1AtP/I4v8pgeXc05s6cZqRND83
	mH7ic8HQPQQWfRUmhYoqwmohXN9Y=
X-Google-Smtp-Source: AGHT+IGY9YhvWdpxD2zz5N0EyUndIKkLeiILNNLD8iIOOYe7vN1EggpGO5+5vqq7VgKlrwsqUOFjp3dKHHkeNbYFcoE=
X-Received: by 2002:a05:651c:2111:b0:2fb:44ca:801c with SMTP id
 38308e7fff4ca-2ff2030961amr71061341fa.35.1731398162160; Mon, 11 Nov 2024
 23:56:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111214527.18289-1-nsaenz@amazon.com>
In-Reply-To: <20241111214527.18289-1-nsaenz@amazon.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 12 Nov 2024 08:55:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH2FRxwryJ9kz4CThWG_D30nW6g-UJzxW9uRQzBAZEetA@mail.gmail.com>
Message-ID: <CAMj1kXH2FRxwryJ9kz4CThWG_D30nW6g-UJzxW9uRQzBAZEetA@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Apply EFI Memory Attributes after kexec
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Sai Praneeth <sai.praneeth.prakhya@intel.com>, 
	Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanspas@amazon.de, nh-open-source@amazon.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 22:45, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
>
> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
> routine, kexec_enter_virtual_mode(), that replays the mappings made by
> the original kernel. Unfortunately, the function fails to reinstate
> EFI's memory attributes and runtime memory protections, which would've
> otherwise been set after entering virtual mode. Remediate this by
> calling efi_runtime_update_mappings() from it.
>
> Cc: stable@vger.kernel.org
> Fixes: 18141e89a76c ("x86/efi: Add support for EFI_MEMORY_ATTRIBUTES_TABLE")
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
>
> ---
>
> Notes:
> - I tested the Memory Attributes path using QEMU/OVMF.
>
> - Although care is taken to make sure the memory backing the EFI Memory
>   Attributes table is preserved during runtime and reachable after kexec
>   (see efi_memattr_init()). I don't see the same happening for the EFI
>   properties table. Maybe it's just unnecessary as there's an assumption
>   that the table will fall in memory preserved during runtime? Or for
>   another reason? Otherwise, we'd need to make sure it isn't possible to
>   set EFI_NX_PE_DATA on kexec.
>
>  arch/x86/platform/efi/efi.c | 1 +
>  1 file changed, 1 insertion(+)
>

Thanks.

I think we should just drop support for the EFI_PROPERTIES_TABLE - it
was a failed, short-lived experiment that broke the boot on both Linux
and Windows, and was replaced with the memory attributes table shortly
after.


> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 88a96816de9a..b9b17892c495 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -784,6 +784,7 @@ static void __init kexec_enter_virtual_mode(void)
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

