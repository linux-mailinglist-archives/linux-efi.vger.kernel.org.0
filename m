Return-Path: <linux-efi+bounces-5621-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB0C72DB1
	for <lists+linux-efi@lfdr.de>; Thu, 20 Nov 2025 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 950AE2FAF1
	for <lists+linux-efi@lfdr.de>; Thu, 20 Nov 2025 08:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A730ACE5;
	Thu, 20 Nov 2025 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpSj3qWN"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B833054EF
	for <linux-efi@vger.kernel.org>; Thu, 20 Nov 2025 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627163; cv=none; b=L5kZn2SnmY1wavjzSjavl9aQ5ZqbpS/84TsKGwOQSuMS3Y9LR9HuEyR0E8mIIH3AYVZ4YaGZ6m/PLbWT+WDwHCVp8TEwFDwy1GRH8BFnlM6XMWhFFywCNx/+QfPhCJnBp9wDsWhtcOdLJpNA2SVlUwlV3JsLtLXPUtKy1b/ShWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627163; c=relaxed/simple;
	bh=OEeY3eM4SMJL+Ea3Ja/Sk9WOVj/3hy84rThzWeIeGaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHvPRB6M3LU0HaZs7hB5VBEjrCfHmJy6WZWkj35jQaNmBxiuubwhzFwDohsYKSyDPpkni0pfJ2jHQmznI+EyElOuq14+Sb5SW3M8zwLikmgnmjycpbu+3ixZn3mlBYPnLMzyHm1CjBlLRgDxp5RD3wUoMJhN0YYCk9MDK7k4qyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpSj3qWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B091DC4AF09
	for <linux-efi@vger.kernel.org>; Thu, 20 Nov 2025 08:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763627162;
	bh=OEeY3eM4SMJL+Ea3Ja/Sk9WOVj/3hy84rThzWeIeGaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YpSj3qWNa6FK15HtXwIoD0JIY9kMeWG2A9qOgbkwktfFbLppdtU5Xyk3u7V9UmGFC
	 J9UubnsJ/9INFvJbw/f3wy16fl0YvDL5g6vnFyDh9OmscUelQxfyZIlEXSwYMT4Qup
	 OO9A8yetFKBy3Q4p42uYNaKaN5Qa0wiogeTudk8UD/Dm5WbJJrz611bwYT3mc3eVUd
	 MrmhjLMi6G535Hdbb3ynvyWM1AZOJdub570xCx2XEq4oQwLl3h02Kt9kR985v2rPq9
	 JqvkfiGhFsPUwCCLBJi5Wdvzxk2rmDToEbrJ4Msu540Jc9q/V26Fs0MNouI6EVsEeY
	 Ro2s2LdfhAOug==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5943d20f352so572717e87.0
        for <linux-efi@vger.kernel.org>; Thu, 20 Nov 2025 00:26:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoZDeDGotCOzPLfIBtexg0bVrZQcfyZLfWtBjIlbjMIZxKDvUwhMY4Xq/kMW1E1aHVDSYuA1XZwNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Qugepve18upPXzLN/CXkUkfJMIRwNMZwAdVnQCrkoK0zy5ON
	nKgkz9dDFNfLv3L6hrICHUIdmHwuXFuiTm4MCGZVcgw7yEZZJQnONg7t9wdxWHp1LxjLsVASFNR
	umUdITqn+eoAcHyrnNYjMxY2c7JP3KN0=
X-Google-Smtp-Source: AGHT+IHiBMzE+cKDKsvpAs68V/eq6DCC7fPpOIDUrhIYdqsiUykno6/IaC1mjBU8NMiHP4cXCHrqT4h04vHsXqIC/ok=
X-Received: by 2002:a05:6512:3f19:b0:592:f27d:75d4 with SMTP id
 2adb3069b0e04-5969e321ac5mr632019e87.45.1763627161049; Thu, 20 Nov 2025
 00:26:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119123011.1187249-5-ardb+git@google.com> <4ca283ad-c549-4da4-93f9-e3cf17ab45a4@suse.de>
 <3bae83d1-bb88-49d3-94a3-3aa56da93bf9@suse.de>
In-Reply-To: <3bae83d1-bb88-49d3-94a3-3aa56da93bf9@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Nov 2025 09:25:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFk=EvC7CW42gko3Wve_6vFgKUm8HXvLNXEnTLuZqxXng@mail.gmail.com>
X-Gm-Features: AWmQ_bnnZQYM_sBdXaROLjjj5XvjzE77MMNuf998o7GnUWVZErFiEOtuUeO7rSQ
Message-ID: <CAMj1kXFk=EvC7CW42gko3Wve_6vFgKUm8HXvLNXEnTLuZqxXng@mail.gmail.com>
Subject: Re: [PATCH 0/3] video/efi: Support FIRMWARE_EDID on non-x86
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 09:19, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
>
>
> Am 20.11.25 um 08:56 schrieb Thomas Zimmermann:
> > Hi,
> >
> > thanks for addressing the remaining EDID support.
> >
> > First of all, you need to cc dri-devel@lists.freedesktop.org  on any
> > further revisions.
> >
> > Am 19.11.25 um 13:30 schrieb Ard Biesheuvel:
> >> From: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> Refactor the screen_info handling so non-x86 platforms booting via the
> >> EFI stub also have access to the EDID data exposed by the EFI boot
> >> services.
> >
> > I don't like how this series complicates everything to make non-x86
> > easier. But the general idea of using efi_screen_info goes into the
> > right direction. It's just not generic enough.
> >
> > The sysfb code transfers struct screen_info as device parameter [1].
> > Drivers later fetch it on probe [2].  The direct ref to the global
> > edid_info [3] only exists because we have no means of transferring it
> > as device data.
> >
> > So instead of using efi_screen_info, let's declare struct
> > sysfb_display with screen_info and edid_info.  The header would be
> > linux/sysfb.h.  We transfer this to all related drivers.  The generic
> > EFI code would set it up like efi_screen_info and the x86 code would
> > decalre it at [4]; replacing the existing state.
>
> If this proposal works for EFI, I could do the changes in graphics
> drivers and then resubmit the EDID series with an additional patch for
> generic EFI.
>

That sounds great, thanks.

