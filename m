Return-Path: <linux-efi+bounces-3803-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FF5AC932A
	for <lists+linux-efi@lfdr.de>; Fri, 30 May 2025 18:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1603CA2467F
	for <lists+linux-efi@lfdr.de>; Fri, 30 May 2025 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9A235057;
	Fri, 30 May 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2LVbONO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F701201100;
	Fri, 30 May 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621577; cv=none; b=pSQoaMwQ/7/f/y9PDkKbRkeuAtcigFi9v3KwCetQtiysa6Ni53JYjozZJgC2ppvEAyckGqhEERyLfYQNxGRzI+An2laaRhWjUReEk6ZmtoxXWi3/edXGrGM7Yu7du5NpTLGZrcFecxw5H0+CoCezIR2Ns66acTkIjga37Pu+nAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621577; c=relaxed/simple;
	bh=qHb0Zr+wBBx5YCrrrucwymk256PfXF/K3j1/py67w1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzMZO3xWzcDBrBAk9PiQzkTCo4ab7EJfxLEc1OHI53J9yWb/4aBZeLnrIQjAjVT3qYqkrG/BPFgHi4XC0/f8bG96s+q1BpeJekYHDyMYaZicNLkruz4Lk/ptLiJLKj5vvVbWkAdLHyPT/LC3d1Qb6ILPuasVxCcvGtG5pYu04w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2LVbONO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55D4C4CEEE;
	Fri, 30 May 2025 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748621576;
	bh=qHb0Zr+wBBx5YCrrrucwymk256PfXF/K3j1/py67w1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U2LVbONOLENC0SSxnFVPwy6KF84qZhqfHshVyCjZf4AsR1OdpxiT+0bjA0tfgbrLC
	 ku7Pdru5iJ8K3Ju7qcHRxm6bpfLR31QmIvZhKoD3JFcEVI52zr1TtYQLYV/+8EBEns
	 WBa6pThc/Lh8WbecNRzrAzK8Io6Vp5Vj9i+9ecJON4bI98/odjme4TmOaKO+mPWECO
	 w3fIS0qHqcxQUP7Z9+bKgRcQ6xUu25ff3rfln7J3ce8uapIb0pVTp2j41VT0Bd3d4x
	 c3fx4Iq3SFVTvOBNxUhY4LwgRN5u0YYBvmtQOS2J+e3/ToKnBz9lpOtAzyP7i8gn2A
	 l7KdVQQASJCOA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54d6f933152so3322940e87.1;
        Fri, 30 May 2025 09:12:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBbfPlurh+luo1FnYC1hzjPUqZZs2NgLHbjFP/FHcuMNfmyvR2jOSCC/0Cq9yPQ94f8scxkBvurm714hf9@vger.kernel.org, AJvYcCX3Cf1iloL2J/kPO54/WZLxMBxy9TRPR4rJdATQs6y0ubxpswp4madyGaJ3uVK46subcZLlyu7RHg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ngvpM9TklaJKWQz/RlkKKG6QcucdjpCOrlkfZb6ZoGRW4MSz
	Gwu4YPpmf1+pdFVLZGfrNoSTMWcZE5wWnBU84Tj16T0abhCTzl9Td5aS8hX9GbenAvp9yoTttoo
	z4FlXHvjZDenfKTRUtZ8DyoCDfMvxSU0=
X-Google-Smtp-Source: AGHT+IHwZV4mqTqRE3lmPEJbXM+Gb9AQ/0rpHd+UeKYSZtrfDsudGTdNhQ84S+QvEU/Wuv9EDKI1XJqUGy2okIaWe88=
X-Received: by 2002:a05:6512:220d:b0:553:3945:82a3 with SMTP id
 2adb3069b0e04-5533d14f17amr880099e87.9.1748621575303; Fri, 30 May 2025
 09:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com> <20250512190834.332684-35-ardb+git@google.com>
 <20250530111645.GAaDmTneZG7KOX0ApR@fat_crate.local> <CAMj1kXEzbBTYr2vF3g_z49muSTHwRY1QUm2iOFsaLNYuijqHDg@mail.gmail.com>
 <20250530160809.GBaDnX6auAVJu9PFLr@fat_crate.local>
In-Reply-To: <20250530160809.GBaDnX6auAVJu9PFLr@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 30 May 2025 18:12:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEeJMV5AX9NjLYEwukvpKrDQCvzRyEivj43P7TRH3qFVg@mail.gmail.com>
X-Gm-Features: AX0GCFsVhN6DYhScAr0jOTTn1yBQuOI5_Xccmyw26HwyP9XrDXqBluV9BpaqrxY
Message-ID: <CAMj1kXEeJMV5AX9NjLYEwukvpKrDQCvzRyEivj43P7TRH3qFVg@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/21] x86/sev: Unify SEV-SNP hypervisor feature check
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 May 2025 at 18:08, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, May 30, 2025 at 04:28:52PM +0200, Ard Biesheuvel wrote:
> > > > +u64 __head snp_check_hv_features(void)
> > > > +{
> > > > +     /*
> > > > +      * SNP is supported in v2 of the GHCB spec which mandates support for HV
> > > > +      * features.
> > > > +      */
> >
> > ... get_hv_features() is only when SEV-SNP has already been detected.
>
> Hmm, I see
>
> void sev_enable(struct boot_params *bp)
> {
>         ...
>
>         /*
>          * Setup/preliminary detection of SNP. This will be sanity-checked
>          * against CPUID/MSR values later.
>          */
>         snp = early_snp_init(bp);
>
>         ...
>
>         snp_check_hv_features();
>
>         if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
>
> This is called here without checking the snp boolean.
>
> And without checking the version it is fragile anyway. Why do you even need to
> remove the version check?
>

Because the assignment is moved out of the startup code later.

