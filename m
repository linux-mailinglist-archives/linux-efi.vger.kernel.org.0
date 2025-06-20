Return-Path: <linux-efi+bounces-3841-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1081AE18D5
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 12:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307CA1BC0608
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FEB1CAA6D;
	Fri, 20 Jun 2025 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF8U5i6l"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21662836BD
	for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415407; cv=none; b=ZX0/R+gBjQeEB8aEodFojBR6oMEfmMPGcJhKX8iEGXB7Djb214CAJBRQ/PE1tmiQez6tDaObVCT031+VH1kxo2GFmaWGeBzoS/RzUpco9IDnIJdYWRURAmg0YDogTkcXm8Eos8+zpfHKxpIixdsSc916fXy1sK2ycJUxr6FMPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415407; c=relaxed/simple;
	bh=ccV6c+DkezprEeFSKLwncA7DfNKoTiRF/vUiz2N2fX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jv8E5XfTpogyDyPksPH6WSrWoyxWMPiUulG7Ai5HROhyHrxGOtwjCQSVwC3IJnnTHR8v6+DOLMx6thsBVJmNWOZVNoxuYs/j0Xwwoq17ws2z23LSYncvvxzSxWlWGcheh41hlkQ99cHjgkYw67vMLKw4lfxw8xkuWL1rryvurJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF8U5i6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9C8C4CEEF
	for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750415407;
	bh=ccV6c+DkezprEeFSKLwncA7DfNKoTiRF/vUiz2N2fX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XF8U5i6ltQ6Wf2zeSCjzeJ6l2kmARg7pzD9gBNTNZtMJxNvsTBjE+g2MhBUMWkm6Z
	 bs58NbVPpi/7B+95K4NxbGZ50i+ps7BeeevixYpiZsLa692k8rVnjeqSfDIT4EBljx
	 JZ12puDeSqMCMF+NqQ5CZtZs+PUCJ4U54+Nt0y17GKKAaHfQJSawA50ct5GsUbCDMG
	 nyZFkUimdmQ7AocSroyz7/GRNwrP2d33EXXakXNUmDxoSMK5kprytllfjBr2TkMcen
	 yI+mLuCadsK5po9o/vPHETqct1yF8BN7Dx2mgfFchAFGcaymb0oYjIKVFwRPHUoCt1
	 mfx8fPUv7SIVQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55220699ba8so2027241e87.2
        for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 03:30:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz65Jn6ztLetNg5HJk5E1OGfAEdbJySxegFRaT9W+2YikYJajFF
	TXESfqRQo7q6Hnmre5/c2fF8dz3KYEKXDAjL9TPXV7sjVSbD6xM+vA8zgyO34OyAlRnLfmqoIT3
	sVNgid9WTT4x0NflXGur3TKvAjq68kes=
X-Google-Smtp-Source: AGHT+IFc1oTtTg3Yypugy4KsPjRzip4f3IMbAoonE8pEJ/jjk2iTL4wwY4aZ8PHeHEgcBmwzRIkEV3pyI66UIxGn0ws=
X-Received: by 2002:a05:6512:3a89:b0:550:d4f3:84a6 with SMTP id
 2adb3069b0e04-553e3be8a88mr808836e87.33.1750415405586; Fri, 20 Jun 2025
 03:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618122008.264294-1-vkuznets@redhat.com> <CAMj1kXEB7TSF2hUFqwxzdxca6YuCTbQ9fZv1KBf917=FVCvTgA@mail.gmail.com>
 <CAMj1kXFq+oVwuHhkCxYG5mhpeS1fStRURSg5i6+wLo-rxi=Phg@mail.gmail.com> <874iwaq0yj.fsf@redhat.com>
In-Reply-To: <874iwaq0yj.fsf@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 20 Jun 2025 12:29:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGh_Edw5-45HfufUvLneV6u66bv3ZfVVB5LAf3d8vE8=Q@mail.gmail.com>
X-Gm-Features: AX0GCFtjY2Eo4rCcucxQI9MiJRiv4mJKZlu_iDMpsAapDuS43hG0NXGhQ-jbECg
Message-ID: <CAMj1kXGh_Edw5-45HfufUvLneV6u66bv3ZfVVB5LAf3d8vE8=Q@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix .data section size calculations when .sbat is present
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-efi@vger.kernel.org, Peter Jones <pjones@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Jun 2025 at 10:19, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > On Thu, 19 Jun 2025 at 17:29, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Wed, 18 Jun 2025 at 14:20, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >> >
> >> > Commit 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT
> >> > section") neglected to adjust the sizes of the .data section when
> >> > CONFIG_EFI_SBAT_FILE is set. As the result, the produced PE binary is
> >> > incorrect and some tools complain about it. E.g. 'sbsign' reports:
> >> >
> >> >  # sbsign --key my.key --cert my.crt arch/arm64/boot/vmlinuz.efi
> >> >  warning: file-aligned section .data extends beyond end of file
> >> >  warning: checksum areas are greater than image size. Invalid section table?
> >> >
> >> > Note, '__data_size' was also used in the PE optional header. The field is
> >> > supposed to reflect "The size of the initialized data section, or the sum
> >> > of all such sections if there are multiple data sections.". While OVMF
> >> > based firmware doesn't seem to care much about what's there, it sounds like
> >> > including .sbat in the calculation is more correct.
> >> >
> >> > Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
> >> > Reported-by: Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
> >> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> > ---
> >> >  drivers/firmware/efi/libstub/zboot-header.S | 2 +-
> >> >  drivers/firmware/efi/libstub/zboot.lds      | 6 ++++--
> >> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >> >
> >>
> >> Thanks for the fix.
> >>
> >> > diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> >> > index b6431edd0fc9..65df5f52e138 100644
> >> > --- a/drivers/firmware/efi/libstub/zboot-header.S
> >> > +++ b/drivers/firmware/efi/libstub/zboot-header.S
> >> > @@ -41,7 +41,7 @@ __efistub_efi_zboot_header:
> >> >         .short          .Lpe_opt_magic
> >> >         .byte           0, 0
> >> >         .long           _etext - .Lefi_header_end
> >> > -       .long           __data_size
> >> > +       .long           __all_data_size
> >>
> >> Frankly, I'm not sure if this is even worth the hassle.
> >>
> >> There is also a 'size of uninitialized data' field, but given that the
> >> .data section has both initialized data and uninitialized data, and
> >> the fact that no loaders appear to care about these fields, let's just
> >> not bother.
> >>
> >
> > ... or add .sbat to SizeOfCode instead. (the preceding field)
> >
>
> I was wondering how to make it consistent with yet-unmerged x86
> patch. In v3:
> https://lore.kernel.org/linux-efi/20250603091951.57775-1-vkuznets@redhat.com/
> .sbat was accounted as SizeOfCode but the section is
> "IMAGE_SCN_CNT_INITIALIZED_DATA", not "IMAGE_SCN_CNT_CODE" so I sent v4
> yesterday:
> https://lore.kernel.org/linux-efi/20250619151759.355893-1-vkuznets@redhat.com/
> which made .sbat accounted in SizeOfInitializedData.
>

I agree that making it consistent is preferred, but I really don't see
the point of obsessing over this - the field is basically unused in
practice.

