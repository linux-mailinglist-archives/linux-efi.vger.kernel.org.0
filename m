Return-Path: <linux-efi+bounces-424-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA8C8390D9
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jan 2024 15:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5731C26286
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jan 2024 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE045F841;
	Tue, 23 Jan 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppHqqNFz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546DA5D8E2;
	Tue, 23 Jan 2024 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018974; cv=none; b=h1uLkyV/swrIHXc44z3E96qbark1b2BxAxKZaZT9e/pxvaZQ63IMsge6D4aJ9bA6jn/IAeCKim9Tte7YUGXxxtGI7ylLepqI7QR9pl4+kVg0YjYXTcHxp7TjfcUYarCuH1auLa0sW02MOr6u8c7aE9P298AP/RNF+yL6MM5pDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018974; c=relaxed/simple;
	bh=x18mpmJro5flNVGD2BpaCxLaAP5fpLRtDPD8Jo9qjCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ak3VfVmcrsNDwSmbHQOV4WC3u7rgSGxa+bRSQEcA8gFdoDvI4XFgqh/JXP8snyEBosL9DLWAda7KKHJ5pFIELMW5Qa4yA0Bt6VjzvUim22zj76467C6bS4S/xWYo96yRG3A1+5pZ8rPAe07c/v3wEIjA7DIZCEUkdNZthwnFRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppHqqNFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E2AC43399;
	Tue, 23 Jan 2024 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706018973;
	bh=x18mpmJro5flNVGD2BpaCxLaAP5fpLRtDPD8Jo9qjCw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ppHqqNFzFFDxZqh5xnF9HBcR6ETc/FDcYX/tfq7n7rVCe2E7V0PqKyVM1xcS9SiyL
	 gouHh+7H/uRuTVxdwxP7bCbpR9cVCYUyKzPctLhzPlbFTeMhJs/MxJ+T+WgDm662Me
	 1JSmH83MM1n5G2TuKSWHPZwlyCztIoJBHnobYQ60Kv08NVXUt+5rv4rw/pjGy5oxYE
	 RzMq4iGuXsDS8c8oITLzb7Vfubp2fK8AJKY11+sUhegyXhwWJHFHXFDS0buRvzTj8j
	 1/3pIj3dwWn06U+SeToSesFbGJilKIAcIs8lmhta4j8y41B8DK10m8S7pY3qillLpE
	 AaPlJCN668SpA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cdeb4b9aa4so48507151fa.0;
        Tue, 23 Jan 2024 06:09:33 -0800 (PST)
X-Gm-Message-State: AOJu0Yy8OSiM+JYnQj76dzwHspcE/QCCVmiSujtOJYfDjVoQYqypTIt7
	65jpnOXkh8DnY1Bx2ZY96/xjgViS1yzGiJmjq1Sl2FQNkQp6aH7iFAam9FHVyzAv0qtAvTTRkQa
	G+fVvlS8TGqoPvZ0gLThafNF0XLA=
X-Google-Smtp-Source: AGHT+IFXFBiVEzEW0PA38msV198qzhBgtr2zSF/2KRMWEtZoPDqPnCvkeVjb6k+7+PaKXnEceQJLhdoaovLN+3Rvy/c=
X-Received: by 2002:a2e:9a16:0:b0:2cd:cda6:55de with SMTP id
 cy22-20020a2e9a16000000b002cdcda655demr3956964ljb.14.1706018971944; Tue, 23
 Jan 2024 06:09:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122231507.1307793-1-timschumi@gmx.de> <CAMj1kXHSSRacU3hp6D3sdUKDESi1FoD33Qi=5Df+=_biZ-vqhA@mail.gmail.com>
 <223a4e75-2e06-4bc6-a70c-823f0eb308d7@gmx.de>
In-Reply-To: <223a4e75-2e06-4bc6-a70c-823f0eb308d7@gmx.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 23 Jan 2024 15:09:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEKF_a6wLtoMYCwBKEVDo6k1u=Cas-=4Ar4WnANHNu+cg@mail.gmail.com>
Message-ID: <CAMj1kXEKF_a6wLtoMYCwBKEVDo6k1u=Cas-=4Ar4WnANHNu+cg@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: Iterate variables with increasing name buffer sizes
To: Tim Schumacher <timschumi@gmx.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Peter Jones <pjones@redhat.com>, linux-efi@vger.kernel.org, 
	Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 14:55, Tim Schumacher <timschumi@gmx.de> wrote:
>
> On 23.01.24 12:24, Ard Biesheuvel wrote:
> > On Tue, 23 Jan 2024 at 00:15, Tim Schumacher <timschumi@gmx.de> wrote:
> >>
> >> This sidesteps a quirk in a few old (2011-ish) UEFI implementations,
> >> where a call to `GetNextVariableName` with a buffer size larger than 512
> >> bytes will always return `EFI_INVALID_PARAMETER`.
> >
> > I wonder if we might just reduce this to 512 and be done with it.
> > Presumably, Windows boots fine in UEFI mode on these machines, which
> > suggests that it passes a value <= 512 too, and I don't recall ever
> > encountering systems using extremely long variable names (i.e., longer
> > than 512 byte)
>
> I'd rather avoid introducing deviations from the specifications on the
> kernel side as well.

Which specification would this deviate from?

> Someone or something might legitimately set a large
> variable name, so we'd have to have resize logic anyways (to resize from
> 512 to 512+). Also, as mentioned on the patch, I'm entirely unsure what
> the size ends up being used for, so I'd rather err on the side of
> caution (most importantly in regards to the buffer size).
>
> Windows _does_ boot fine (and is able to read all the variables), so
> they presumably start off with 512 or smaller. FreeBSD definitely starts
> from 512, but they also implement additional resize logic.
>
> In regards to complexity of the proposed solution, how about we approach
> this from the other side? Start off with advertising 1024 bytes of
> buffer storage, and cut that value in half (without actually resizing
> the buffer) as long as we get `EFI_INVALID_PARAMETER` while on the first
> run.
>
> If we ever get `EFI_BUFFER_TOO_SMALL`, we know that something is wrong
> with the UEFI implementation (because that either means that something
> claims to be larger than 1024 bytes, or that our assumptions about the
> quirk don't hold up) and can bail out and log as appropriate. That would
> limit the complexity to the machines that need it, completely omit the
> need for resize logic, and would still be specification compliant.

Yes, I would prefer to keep this as simple as possible.

