Return-Path: <linux-efi+bounces-3839-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 088EDAE1369
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 07:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C9E1885ED9
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 05:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5268121A45D;
	Fri, 20 Jun 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG+bWHOa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B31AE877
	for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398728; cv=none; b=V2U4p7+XfQDJTvF46MgOCyts+BBWX9ao4NAxxcq1Aje5WHOObqGvDFsP/r9GL9FNndZ/GujbPCxjonnxEU2vlHzqDA4EifaJpHEJFVFN3lS1wqQAs4yG/K5hNhwL2n/av/FEtE39cEDlpe6/yeOOikitw9Q7fvtGiL6kjDpvI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398728; c=relaxed/simple;
	bh=FXlVtnMrcHlnFCbsDpFUh2+ZhpAWhbKP7UC/rwps2Mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7kUN98eafh0HQeHifPpgW02shVbzie87FEScLr57rF2MB16wwtqoIsyUTm6c+zN6Ba/JBGgqnlWk6uxYh74l6cjBh6PlvaAiNY4J/0SqqsoPxfPuiNMZi/iGabhvpzcnD82zINFYSpp3YMMvjSPTvvcW2Apddx4Uj3panRlWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qG+bWHOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E5DC4CEED
	for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 05:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750398727;
	bh=FXlVtnMrcHlnFCbsDpFUh2+ZhpAWhbKP7UC/rwps2Mc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qG+bWHOaJ8a92zc6hrDN/Si8kcOSmWInhO1Yw2gXJag1dYQBYDGVX4peBIuKQjy3v
	 tCSdAAxmn8S0eHLBK8CyoR5o2WCjLNsGWKp29k2A9Bge7f9S19jtkUZy14Fm0lbLUs
	 R+Aurr+Xh6r+Exfqzz/hLzp9oYujlvLMaLNLdbfUA9S+IE78rSEwoqwW9iC7R1wnOm
	 dEyu3twFiTjjTeZ5GR12qUs9mJy24tvnHS6SGcMJPMhoZ/bk59RSmOnLpL7kaTKkbd
	 nwnz3qIhTLFZNhPklS4mXxIrgDcBg7Cx5oH+Bc0Vic9vgbj+AtQkX0obucuYeVcbzH
	 FQJcVL8wvGQQA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso1403699e87.0
        for <linux-efi@vger.kernel.org>; Thu, 19 Jun 2025 22:52:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YyEEQnZWjJm9C+IpLi+NaQPjOrEfNfyepmeYaYLqNCOE8dbjkgB
	scwB2mis88Gg5Hks1GSKE3/EQnMLHHVHqFCG5TP3YbqUdPjnXXC2vyrn6hR6z72XG5MfsiuvdEv
	1PwE+MdjKfexroVB4mwSlMFuHn+YOGd4=
X-Google-Smtp-Source: AGHT+IEfY8Yw4nC1uB/IWjfg/wKmXYIY9Q8rdIKCoGDSL3IaS0dK19KQcJkwfEfKalgJO3/PoPBve+nyIrTfUxTTlAo=
X-Received: by 2002:a05:6512:3a82:b0:553:adf7:e740 with SMTP id
 2adb3069b0e04-553e3befa3bmr431374e87.28.1750398726088; Thu, 19 Jun 2025
 22:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618122008.264294-1-vkuznets@redhat.com> <CAMj1kXEB7TSF2hUFqwxzdxca6YuCTbQ9fZv1KBf917=FVCvTgA@mail.gmail.com>
In-Reply-To: <CAMj1kXEB7TSF2hUFqwxzdxca6YuCTbQ9fZv1KBf917=FVCvTgA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 20 Jun 2025 07:51:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFq+oVwuHhkCxYG5mhpeS1fStRURSg5i6+wLo-rxi=Phg@mail.gmail.com>
X-Gm-Features: AX0GCFuafpT0C6YR9niipWf_fiT-osrs2vF5fF_7JVI8OXEcYblGc8pVbUqRszU
Message-ID: <CAMj1kXFq+oVwuHhkCxYG5mhpeS1fStRURSg5i6+wLo-rxi=Phg@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix .data section size calculations when .sbat is present
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-efi@vger.kernel.org, Peter Jones <pjones@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Jun 2025 at 17:29, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 18 Jun 2025 at 14:20, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >
> > Commit 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT
> > section") neglected to adjust the sizes of the .data section when
> > CONFIG_EFI_SBAT_FILE is set. As the result, the produced PE binary is
> > incorrect and some tools complain about it. E.g. 'sbsign' reports:
> >
> >  # sbsign --key my.key --cert my.crt arch/arm64/boot/vmlinuz.efi
> >  warning: file-aligned section .data extends beyond end of file
> >  warning: checksum areas are greater than image size. Invalid section table?
> >
> > Note, '__data_size' was also used in the PE optional header. The field is
> > supposed to reflect "The size of the initialized data section, or the sum
> > of all such sections if there are multiple data sections.". While OVMF
> > based firmware doesn't seem to care much about what's there, it sounds like
> > including .sbat in the calculation is more correct.
> >
> > Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
> > Reported-by: Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> >  drivers/firmware/efi/libstub/zboot-header.S | 2 +-
> >  drivers/firmware/efi/libstub/zboot.lds      | 6 ++++--
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
>
> Thanks for the fix.
>
> > diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> > index b6431edd0fc9..65df5f52e138 100644
> > --- a/drivers/firmware/efi/libstub/zboot-header.S
> > +++ b/drivers/firmware/efi/libstub/zboot-header.S
> > @@ -41,7 +41,7 @@ __efistub_efi_zboot_header:
> >         .short          .Lpe_opt_magic
> >         .byte           0, 0
> >         .long           _etext - .Lefi_header_end
> > -       .long           __data_size
> > +       .long           __all_data_size
>
> Frankly, I'm not sure if this is even worth the hassle.
>
> There is also a 'size of uninitialized data' field, but given that the
> .data section has both initialized data and uninitialized data, and
> the fact that no loaders appear to care about these fields, let's just
> not bother.
>

... or add .sbat to SizeOfCode instead. (the preceding field)

