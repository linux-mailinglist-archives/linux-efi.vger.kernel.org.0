Return-Path: <linux-efi+bounces-3095-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AD1A713B1
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 10:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1301D170DC2
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C9D19ADBA;
	Wed, 26 Mar 2025 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuW7T6SN"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139A1531C5
	for <linux-efi@vger.kernel.org>; Wed, 26 Mar 2025 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981324; cv=none; b=CqFdzsfc7cP/5pwYaznvEpPey1jMNatm3fQMPOuPq8OV/rJXVHN/HxvO289qyRbQ7F2yLCS1Uikj0yOJyFeejbRwXPBxBkKUsNuIRfLQunyWnl8VeMdPDvmK7cCLc9wSxDWPKEF9Zd/S/L7TW6/FHkI5JNMIfxlUjPe/BAPvsus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981324; c=relaxed/simple;
	bh=q9/n6xLXsg9cP0fsy15b0++dlcAF+G/WhyWx6lN0+Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouEgy/VW/C6lv/ktZNCBYnFx2BrDqwPoOPsOA5IeFFS0l9UIqaHjLM0g4LkYkLYS3SCZPEJM+kvAlY1dN386jajUTUV8od2T0VqUnj3Wl4oS47EX8FKlaguzc+n9XlCBhM/lFTNrliSdVEWipxqEDTvcTnINUOIiXji2QXyLTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuW7T6SN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B39C4CEEA
	for <linux-efi@vger.kernel.org>; Wed, 26 Mar 2025 09:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742981324;
	bh=q9/n6xLXsg9cP0fsy15b0++dlcAF+G/WhyWx6lN0+Zs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CuW7T6SNRUALRP1iNFIjI2o768oBi3xAhd15l2JUAOG43EQrKpF+8tDeT44K2HxCj
	 g5VtY96x44p3ynHZg7pQdiub5MhHR3X8lqYvM862WGOSMxAg5zSY4deGCiGrGsj9tr
	 XPz8OyNtB3CxNnyF5NVcVRx5wl6pxR5cnBKcJi2aBllwEJHv8iy2WWKUJG3ZHJHqul
	 QvpQqrQpydRV7VJW+ESBxG9EOzW5LXNZpHraUK3M64n0Ksxh1dfK3X8WD7Hg5nt8XI
	 s/hwSjmIKMvuiXJp3EAw0Kd4SZpGWBkUz16zMYNSzMsSlWNljOheVI1i8FXxp24Qpo
	 JCS/KIAjbUg4A==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54af20849adso718989e87.1
        for <linux-efi@vger.kernel.org>; Wed, 26 Mar 2025 02:28:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUBN3joc42U+dFs8UDy5GrAnDzwNrtktM34qKQemzDr3YmtGwKtBCZSLNuiNRgaoBPF4P7Hb24dsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsE65jsBekL0ilRZx6O+FD9RmZoWw77t+XK43yiEs/GcOzjJSU
	CbMWi5m6SBCyzTNbiFKRa37nWIJWsQydsGk8MLbDXTTeJnl61Ln6WVnL8ipl1Y62UXv+F/V5V8i
	kVgXV8td9PLYJTWRWzh+RJNP7xEQ=
X-Google-Smtp-Source: AGHT+IFXWbs1fX8iTQbUdYaL5sHwQsN622JIoeRiZKLkfZCQUyfP3od4fb8/AWHW7pdVSkn65pic8TS75oiivWFYFM4=
X-Received: by 2002:a05:6512:6cd:b0:54a:f743:3137 with SMTP id
 2adb3069b0e04-54afaca81acmr974655e87.19.1742981322689; Wed, 26 Mar 2025
 02:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325091614.1203411-2-ardb+git@google.com> <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
 <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com>
 <ervuw7mwzvcyizkchy3nz4357ahz5kdfzc227exlrc5yabq4im@g2kzsrdbkdf6>
 <CAMj1kXEzzNnohJat5REp5mAUCSd4v_ft6F=P6vB95z6+f1MMfw@mail.gmail.com>
 <4xm3bmuhmdbnn6fkmhmnrtkcdiwj76dcr7gujam45nqvgupvj3@caytleltmyzj>
 <CAMj1kXFERrdioZ8_07rwDVUAoq=OLDvLCRUS6BN3GXnJoJPuAA@mail.gmail.com> <d6eb83a9-d1b1-7028-9cfd-1ab3fa0d6269@amd.com>
In-Reply-To: <d6eb83a9-d1b1-7028-9cfd-1ab3fa0d6269@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 26 Mar 2025 10:28:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE35QQ7b3uSF4Ufv6VXyjCfPyveUO1KLPKwsgoHu8iE=w@mail.gmail.com>
X-Gm-Features: AQ5f1Jpnd9eYwLni4mh8jwISb_Oxtq4dxdAx4qp4jDGul2n1bzqdn0OFaRBdMIY
Message-ID: <CAMj1kXE35QQ7b3uSF4Ufv6VXyjCfPyveUO1KLPKwsgoHu8iE=w@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Do not accept parts of memory before ExitBootServices()
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-efi@vger.kernel.org, linux-coco@lists.linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 17:30, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 3/25/25 09:39, Ard Biesheuvel wrote:
> > On Tue, 25 Mar 2025 at 14:44, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> >>
> >> On Tue, Mar 25, 2025 at 02:09:54PM +0100, Ard Biesheuvel wrote:
> >>>> Since the problem happens before ExitBootServices(), can we allocate this
> >>>> memory range with EFI API and free it back?
> >>>>
> >>>
> >>> In principle, yes - we could allocate these misaligned chunks as
> >>> EfiLoaderData, and it wouldn't even be necessary to free them, as they
> >>> would become available to the OS automatically.
> >>>
> >>> But doing this in setup_e820() is tricky, because every page
> >>> allocation modifies the EFI memory map, and we may have to restart
> >>> from the beginning. And there is no guarantee that some asynchronous
> >>> event in the firmware context does not attempt to allocate some pages,
> >>> in a way that might result in another misaligned unaccepted region.
> >>
> >> Looking again at the code, setup_e820() (and therefore
> >> process_unaccepted_memory()) called after efi_exit_boot_services() in
> >> exit_boot(), so we can't use EFI API to allocate memory.
> >>
> >
> > Ah yes, I misremembered that. It also means that it is fine in
> > principle to take over the communication with the hypervisor.
> >
> > However, this is still tricky, because on SEV-SNP, accepting memory
> > appears to rely on the GHCB page based communication being enabled,
> > and this involves mapping it down to a single page so the C bit can be
> > cleared. It would be nice if we could simply use the MSR based
> > protocol for accepting memory.
>
> We can probably do something along this line since there is an existing
> function, __page_state_change(), that performs MSR protocol PSC. If we
> change the arch_accept_memory() calls in process_unaccepted_memory() to
> arch_accept_memory_early() then we can differentiate between this early
> alignment setup timeframe. The early function can also use
> sev_get_status() instead of sev_snp_enabled().
>
> Let me mess around with it a bit and see what I come up with.
>

Cheers.

So IIUC, it would be sufficient to check sev_get_status() against
MSR_AMD64_SEV_SNP_ENABLED, and use the PSC MSR to transition each
unaccepted page that is in the misaligned head or tail of the region
to private.

Pardon my ignorance, but does that mean that in principle,
sev_enable() et al could be deferred to early startup of the kernel
proper (where the other SEV startup code lives) ?

We have been playing whack-a-mole with PIC codegen issues there, and
so it might make sense to consolidate that logic into a single [PIC]
chunk of code that is somewhat isolated from the rest of the code
(like the kernel/pi code on arm64)

