Return-Path: <linux-efi+bounces-2188-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038099D5F77
	for <lists+linux-efi@lfdr.de>; Fri, 22 Nov 2024 14:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DEDB288F3
	for <lists+linux-efi@lfdr.de>; Fri, 22 Nov 2024 13:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CDD1C9DD8;
	Fri, 22 Nov 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/P1owA2"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC352309B9
	for <linux-efi@vger.kernel.org>; Fri, 22 Nov 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280640; cv=none; b=oJvkbcS630+t50T2WIpk6yCjdLS9wzbcIvGasj47DMrB60u1RgUqw+F99Mc0SICjwO5OnlXuYUX7pKJQLoZVsnUp3rIgxBjg4KXxn3T/t76BOmsphPhNSiqB+CvG01Lt2xOepy1qiBpZQnsp95WDN9qenEJQ37pMKqeXjeH+VrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280640; c=relaxed/simple;
	bh=HkyjLPb734aAZvIolW+OLEzvFcUc7H4APut784A9G7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aND1L5shtNWu7BGbjySDKa+vdI4JmKF/+xA/nZYT8wHvg9wxEJZJylxudOmZYq2SMHWOb025z0CdLLKXxD7BAiB2tpZp77RURz9j0qSWwkEj9/SD2vr5n/z8qEQ9xFu+z161cxZpPCo+WfgQumz+saj7VLbuUTWiOrFKOR3ijkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/P1owA2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732280637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ft4564hHBGkICUTkZjOLlmPFHPv4/CYfCDRSgrLHfNA=;
	b=K/P1owA2WyQkFBA27jWS8Jgg9Ij0UYZ/80iZgEixAT22sheVfNKAZn9d/3CJ/Mv7ejyOMY
	n3qn1sO+EjAtGQv9py0uCvofWoEMuVoNbquOBx+rohHoWc1lQWTSsZl0P98EUDcNrUimzT
	vJ9RukJC53s2/ZNhlC8mKEqJH5Be9B8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-RAst2AVGOJWVMBV6nSju_A-1; Fri, 22 Nov 2024 08:03:56 -0500
X-MC-Unique: RAst2AVGOJWVMBV6nSju_A-1
X-Mimecast-MFC-AGG-ID: RAst2AVGOJWVMBV6nSju_A
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7a1e95f19so6156245ab.1
        for <linux-efi@vger.kernel.org>; Fri, 22 Nov 2024 05:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732280635; x=1732885435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ft4564hHBGkICUTkZjOLlmPFHPv4/CYfCDRSgrLHfNA=;
        b=FcRYEgQ9z5J/SNPXHN+2NF5+dUKmZ8Qe3Vrfb1CVJZRHcbvuAYjp8W23iRpqghc0oL
         /prCKa0KeMLmR7US21mNy/+VEPGiBd5RISugFvJ0Nb7o/3cw2OyVonsOaSqbZxh3uwk6
         WQVAx5m3y8QBvkez1TnXnzLHCGuEGO/o0I8W/49RyB91eRVRJd+rWJAYgFrvMlTu2++g
         9ppt/DaI/b8ixHwdK18pJgUYZ6FNW3ySNKvRiYkzrIEo1bpTxqzBvzt1kE819Rp3Ji0Y
         SLSGJ6VkUs9xrz9rdveM1tA/twgHmGxx3TYJnKXAsFs0m/RZ2jUJFEweDCqJ5Yr/PHvU
         HD6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWP8DrDKz2w48nXP3EetFyXrVaqf9mhWj5M9mmnpepYWETp/qk5HxYpdZTeGrPvBBc/7WoT07EUfGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VPo+VAdtgY4UgHck6wEmV7J9hvjnAIAzlBhrXB8lVR/U4qte
	aUctY0PyTQFypdqsYJEFleygA9jY0Hze1Okdn+pGGP9mbqrxxSQc3HixXBIC1avrZkN3K7nzIea
	v26bnd48dd3tKPCWZNb2mX7HocohKBvqThdgX6EGB6YTf2iAwrFflEfnQAhCpeQVVPi4RLfxoOr
	RtCcHKYypmNKJS3tKePtAPt/Hd1qldv3ZF
X-Gm-Gg: ASbGncs1b5gKb456Il290YDVfJUPG+u93JT97gnS3JsdOfzwMFE14vEPbo8KS5LYwpg
	AW+liyQAngxJMa/tzlIi6kBdGgDxiqVNB
X-Received: by 2002:a05:6e02:4416:10b0:3a7:a4ec:6cfc with SMTP id e9e14a558f8ab-3a7a4ec6eb1mr6221815ab.8.1732280635680;
        Fri, 22 Nov 2024 05:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjBIujeBiiBto12x7Ie0ZkLS7jCkUl1dIw1psG2/yNOJ8YhDHEILctT4OBs1UgwnhG2+2a8NNiGBzHeq0VFf0=
X-Received: by 2002:a05:6e02:4416:10b0:3a7:a4ec:6cfc with SMTP id
 e9e14a558f8ab-3a7a4ec6eb1mr6221485ab.8.1732280635355; Fri, 22 Nov 2024
 05:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112185217.48792-1-nsaenz@amazon.com> <20241112185217.48792-2-nsaenz@amazon.com>
In-Reply-To: <20241112185217.48792-2-nsaenz@amazon.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Nov 2024 21:03:49 +0800
Message-ID: <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanspas@amazon.de, nh-open-source@amazon.com, 
	stable@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
>
> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
> routine, kexec_enter_virtual_mode(), which replays the mappings made by
> the original kernel. Unfortunately, that function fails to reinstate
> EFI's memory attributes, which would've otherwise been set after
> entering virtual mode. Remediate this by calling
> efi_runtime_update_mappings() within kexec's routine.

In the function __map_region(), there are playing with the flags
similar to the efi_runtime_update_mappings though it looks a little
different.  Is this extra callback really necessary?

Have you seen a real bug happened?

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
>
Thanks
Dave


