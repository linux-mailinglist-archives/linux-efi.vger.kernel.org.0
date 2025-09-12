Return-Path: <linux-efi+bounces-4747-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D69B55915
	for <lists+linux-efi@lfdr.de>; Sat, 13 Sep 2025 00:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79275AC6547
	for <lists+linux-efi@lfdr.de>; Fri, 12 Sep 2025 22:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3D26FDA6;
	Fri, 12 Sep 2025 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI2QAFAp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC5E24DCE9
	for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715781; cv=none; b=OvpXANjPuDXX2iYD1tq5nu4N5cfJRC9Ntz//0s9A+CXfafdovrlR8yqljV7DqhwTyIhVq2oujXrETfi+WLxUy/NXhW6n/6cde9rt6w5SJM5TMoEiKF75s5/koABvnw+ve/B3B7GHUTKTbA/alAIx+esceopPKbrALEtLcUf0zUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715781; c=relaxed/simple;
	bh=gd76I0c3DRKFlg0RU30jLxRT8RNqHgwObwdp0lVkMi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVsrBwZJYI0MJC8kj8goES5WBTGOkzxsMijrErChnwYGFluW+isfQiSCYAtDLTRlhuzjBz9g+TWtt8JzAqNw6hY24L4v9FKYE1Dgl3OZc3wiso7iT5SWwOV4dAZjXvPgztAa1w0uS3k9RssbYva1fshgunOxuikOW1CM4Uzt84c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI2QAFAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37CEC4CEF5
	for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 22:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757715780;
	bh=gd76I0c3DRKFlg0RU30jLxRT8RNqHgwObwdp0lVkMi8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oI2QAFAp6Iw2GPKTfjZSINy3TJbqZMegV8uMapjMx6R6AeKsK5by+hAmyqaHoMtaS
	 M8krOng0ldw2s6H3PfiJKYA068ad/ZrT8J+gaBLN+k+6Kq4//mwWwFagOEOO19wF6r
	 Ld1gwnIQxKoamr+WwnVDesuGUqeFNwrFovQHVk8YYlNetowJC2p8mdiuecrpWmUDaO
	 EwyBynI6kU4i471s0VDsqgXuhWsmM1cGrgIU+uNZ2B8QK6LEJRrPtwvPuP8nYK2KDg
	 1aeBaWlHjqHc0SmZpBJiL/yqRezm9DdWvIW+08DrxZiDJj0TS74Iea0PMOv0ugPPNz
	 KO3Hj0yc+TVKA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-336b071e806so22638081fa.1
        for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 15:23:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXb57To3A173+zVSHg4HwjA3y678fPwY/Edh6oQ0+/bh2Tw30dZQ9imj8e3k/ZVyOBGipsMwTVj+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvfjqn9iOwWhdOS8lgbcGDG3z+wz5QVukC7aMovmuDoHVbRbYH
	hTpi8lB3CJaYzbXFp/aJqqnB941EmzxaJZ0HVbY7zWjF3rAgE4/5jWrymBG28BYtGmsvKfDzgb8
	Z/nXPpqSbHMB5blDqXPwnT+fLDQXt9ac=
X-Google-Smtp-Source: AGHT+IGIMYOMD+Lr01wnAl+ok40CJJ76lYuoLsrBF1nTELiv1Of3Fn8jz1WXHNKzAqgwGuVxmZGdGUnaEnZk3UoExGk=
X-Received: by 2002:a05:651c:516:b0:335:44d4:161b with SMTP id
 38308e7fff4ca-35139e558fdmr11742481fa.2.1757715778973; Fri, 12 Sep 2025
 15:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909080631.2867579-7-ardb+git@google.com> <20250909080631.2867579-5-ardb+git@google.com>
 <20250912203443.16159-1-Ashish.Kalra@amd.com>
In-Reply-To: <20250912203443.16159-1-Ashish.Kalra@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 13 Sep 2025 00:22:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFtFMp7xTgtGAy9o4s5OrVBLRax2y0N-OSmP8-bzorcKw@mail.gmail.com>
X-Gm-Features: Ac12FXzSGo65DF-ol_QAeWIk04k3o2pyJo2Dipp0bbtnDlMShG3SncMIhovT77E
Message-ID: <CAMj1kXFtFMp7xTgtGAy9o4s5OrVBLRax2y0N-OSmP8-bzorcKw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] x86/efistub: Don't bother enabling SEV in the EFI stub
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: ardb+git@google.com, bp@alien8.de, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 22:36, Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> >One of the last things the EFI stub does before handing over to the core
> >kernel when booting as a SEV guest is enabling SEV, even though this is
> >mostly redundant: one of the first things the core kernel does is
> >calling sme_enable(), after setting up the early GDT and IDT but before
> >even setting up the kernel page tables. sme_enable() performs the same
> >SEV-SNP initialization that the decompressor performs in sev_enable().
>
> >So let's just drop this call to sev_enable(), and rely on the core
> >kernel to initiaize SEV correctly.
>
> If the EFI stub no longer boots the core kernel via the traditional
> decompressor and jumps straight to it, there are some specific things
> which i see are being setup by the decompressed kernel before passing
> control to the uncompressed kernel such as calling sev_prep_identity_maps()
> as part of setting up the identity map:
>
> From sev_prep_identity_maps():
>
> The Confidential Computing blob is used very early in uncompressed
> kernel to find the in-memory CPUID table to handle CPUID
> instructions. Make sure an identity-mapping exists so it can be
> accessed after switchover.
>
> Won't this setup in identity mapping be needed to find the
> in-memory CPUID table as this won't exist if the EFI stub boots
> directly boots the core kernel skipping the decompressor ?
>

EFI maps all memory 1:1 so none of this is needed.

