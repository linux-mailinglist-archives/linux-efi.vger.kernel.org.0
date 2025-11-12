Return-Path: <linux-efi+bounces-5486-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AA8C532CC
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 16:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9B6C54091C
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214E342530;
	Wed, 12 Nov 2025 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et7SB2ie"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D5D34252C
	for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961307; cv=none; b=G4bCt4H/P3tRmSbixDD59gGqpzhbvNof/Btf7/1tpUp5BE9rTEsf/AXUNorTjHGTiBTUaUcN/1gZ3DF0/ocPCb0rezNk7kCLM3CefdAs6Bb0LXjb4xZytNAeBBqFbCz2klNz7IvpeQDFDp7dc8g4Ljd9xvS7u/dgNHndOzgoJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961307; c=relaxed/simple;
	bh=Tp/Oos39fG6Rt6CEYu6p8aP1uEaAHS2MI4e8EuiAzrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlXDTFiPsUWkeQ/S4AqPNpq94ZgNnq+hA/QAAM+CRFsNo5VdmW+roANlG74CFz9SX0wVXqZHxt2b2IcC7wypUQ2KLdgdg3x/DACRwqU3yvbqRaDXNNC8fdWTW47SyQsRpdwzmx+fyEmQ8LO9CpaGmYzR3uDqysXWMoqsoZfsPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et7SB2ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B569AC2BCC4
	for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762961306;
	bh=Tp/Oos39fG6Rt6CEYu6p8aP1uEaAHS2MI4e8EuiAzrk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=et7SB2ieZMadA/JvC7jUJCGdCnGfMy71tJH2tp9D3+hV/xkqZw5l6Y9MDC7bE06tg
	 8tL78pxUomD5m+liN/d7g7wIaEgEyOW0EBQh0en4MdScpMVkg0Qhgi+lmR73TKhzX1
	 XpY0BHuuQIQ6SHAUpP69ThYir7AAWhYOoZoFQY+BVod6ZbJ5It2+EMsCqWoBVFm/Gf
	 XKfABh7MRua5WLTou8ItAiSOS/KSOkmgqGYxgAPiV6ozeAW3LaUsdabEUm9a5yi9dv
	 au+XOENywP2pt0efPtfLOLRPNmjRDU4a+YcZ/GV7zkqGwkv/nGQtFMtEclbmcyDKlw
	 XDy6pa4J6is/g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37b95f87d4eso6106751fa.1
        for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 07:28:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8jagWMf5jjF3h2AlA9bI8RCkFKDrwFY+lzCIV1tUwMrpriAPrFYp55FML8MJ9luixvUJdqWf0nKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzayA9PAjlIZYXp5HzcWwnd5wr3Bxve9537sBA3gUJ/0iJhgcq6
	8yYg91Im/C27afX02LcXCMmmhRowTBrBsMyOF6Ozl6KG3glPzrNG1FcNAMvJ/HBHHfDOnDlXlCI
	lofUoQaMfwOLZ97uW595mfzzh9zwsdaU=
X-Google-Smtp-Source: AGHT+IHvpXz5FAxXakLAllU2lH9LAYAjCAIp7Ff2/9yxXEII2MZtL6hl3MqXketkutBXtpWAJfsWh0I/hj7LuroaZy4=
X-Received: by 2002:a05:6512:3b9d:b0:594:2efe:ead5 with SMTP id
 2adb3069b0e04-59576e44fcfmr1285666e87.53.1762961304971; Wed, 12 Nov 2025
 07:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-5-sohil.mehta@intel.com> <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>
 <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com>
 <7c26ae81-3495-457b-9f64-f5b2e169a63b@intel.com> <DDEF6164-D1E6-4003-A251-804738CB59E0@zytor.com>
 <CAMj1kXGyTo=4Va1PevMQyCauEKSutfSPo6je0Ps09TabhTe4zQ@mail.gmail.com> <E9396874-5D2D-413D-A5D1-A28E4D429C51@zytor.com>
In-Reply-To: <E9396874-5D2D-413D-A5D1-A28E4D429C51@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 12 Nov 2025 16:28:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXECkKeDUDdjmrQjcYk=2Y5ydTV2L1Pg73X7uCC-=DC9Ww@mail.gmail.com>
X-Gm-Features: AWmQ_blwOyFxQE32pbr8LGfqIke9Ktv3MU0a68eclFWL2Ds2jepFFjUJAha1mFU
Message-ID: <CAMj1kXECkKeDUDdjmrQjcYk=2Y5ydTV2L1Pg73X7uCC-=DC9Ww@mail.gmail.com>
Subject: Re: [PATCH v11 4/9] x86/alternatives: Disable LASS when patching
 kernel code
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org, 
	Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Sean Christopherson <seanjc@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Nov 2025 at 16:23, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On November 12, 2025 7:18:33 AM PST, Ard Biesheuvel <ardb@kernel.org> wrote:
> >On Wed, 12 Nov 2025 at 15:58, H. Peter Anvin <hpa@zytor.com> wrote:
> >>
> >> On November 12, 2025 6:51:45 AM PST, Dave Hansen <dave.hansen@intel.com> wrote:
> >> >On 11/12/25 05:56, Ard Biesheuvel wrote:
> >> >...
> >> >>> it looks like we would now need to toggle
> >> >>> CR4.LASS every time we switch to efi_mm. The lass_enable()/_disable()
> >> >>> naming would be more suitable for those wrappers.
> >> >>>
> >> >> Note that Linux/x86 uses SetVirtualAddressMap() to remap all EFI
> >> >> runtime regions into the upper [kernel] half of the address space.
> >> >>
> >> >> SetVirtualAddressMap() itself is a terrible idea, but given that we
> >> >> are already stuck with it, we should be able to rely on ordinary EFI
> >> >> runtime calls to only execute from the upper address range. The only
> >> >> exception is the call to SetVirtualAddressMap() itself, which occurs
> >> >> only once during early boot.
> >> >
> >> >Gah, I had it in my head that we needed to use the lower mapping at
> >> >runtime. The efi_mm gets used for that SetVirtualAddressMap() and the
> >> >efi_mm continues to get used at runtime. So I think I just assumed that
> >> >the lower mappings needed to get used too.
> >> >
> >> >Thanks for the education!
> >> >
> >> >Let's say we simply delayed CR4.LASS=1 until later in boot. Could we
> >> >completely ignore LASS during EFI calls, since the calls only use the
> >> >upper address range?
> >> >
> >> >Also, in practice, are there buggy EFI implementations that use the
> >> >lower address range even though they're not supposed to? *If* we just
> >> >keep LASS on for these calls is there a chance it will cause a
> >> >regression in some buggy EFI implementations?
> >>
> >> Yes, they are. And there are buggy ones which die if set up with virtual addresses in the low half.
> >
> >To elaborate on that, there are systems where
> >
> >a) not calling SetVirtualAddressMap() crashes the firmware, because,
> >in spite of being clearly documented as optional, not calling it
> >results in some event hook not being called, causing the firmware to
> >misbehave
> >
> >b) calling SetVirtualAddressMap() with an 1:1 mapping crashes the
> >firmware (and so this is not a possible workaround for a))
> >
> >c) calling SetVirtualAddressMap() crashes the firmware when not both
> >the old 1:1 and the new kernel mapping are already live (which
> >violates the UEFI spec)
> >
> >d) calling SetVirtualAddressMap() does not result in all 1:1
> >references being converted to the new mapping.
> >
> >
> >To address d), the x86_64 implementation of efi_map_region() indeed
> >maps an 1:1 alias of each remapped runtime regions, so that stray
> >accesses don't fault. But the code addresses are all remapped, and so
> >the firmware routines are always invoked via their remapped aliases in
> >the kernel VA space. Not calling SetVirtualAddressMap() at all, or
> >calling it with a 1:1 mapping is not feasible, essentially because
> >Windows doesn't do that, and that is the only thing that is tested on
> >all x86 PCs by the respective OEMs.
> >
> >Given that remapping the code is dealt with by the firmware's PE/COFF
> >loader, whereas remapping [dynamically allocated] data requires effort
> >on the part of the programmer, I'd hazard a guess that 99.9% of those
> >bugs do not involve attempts to execute via the lower mapping, but
> >stray references to data objects that were not remapped properly.
> >
> >So we might consider
> >a) remapping those 1:1 aliases NX, so we don't have those patches of
> >RWX memory around
> >b) keeping LASS enabled during ordinary EFI runtime calls, as you suggest.
>
> Unless someone has a code pointer in their code.

That is a good point, especially because the EFI universe is
constructed out of GUIDs and so-called protocols, which are just
structs with function pointers.

However, EFI protocols are only supported at boot time, and the
runtime execution context is much more restricted. So I'd still expect
the code pointer case to be much less likely.

