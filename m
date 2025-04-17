Return-Path: <linux-efi+bounces-3352-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A97A92273
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 18:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E41718894A1
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D2254AE1;
	Thu, 17 Apr 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+d1J4Ee"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7AB254AE0;
	Thu, 17 Apr 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906510; cv=none; b=irg9/cEeLeTH0lrnFeL50Di+Cwow2SiME6MeRtx8gwG5Nt5SHsVR5vIhdu5xTEaPzNhp9iY9gYYpSQJDwBqkTh3I7cDsX5l285/Php+xLn3PXp3LS86SskXt+l+wfOxR/Izk72SoqF8C0Yaj0NyKgJGqQvwZMe4zUKI8+mw36Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906510; c=relaxed/simple;
	bh=zUJdNRgUdcltlPwaKWSrWAxnx1SFdIe5x0+jpNyu34M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5g6/apX6CLOiwNVws3c6dd+nE2Qz35vmzL79ExWDOwGg9nKg50bbiJWgm1Znma56caUfXjbjCK+ipT1ryiIjpSUeNKtPlc4+ENHtUkvrsqMhCJ+YBmAW53dob1MG/bzcM2ubVNFCLWT9Eb2o7O5dNGt/t0CbOHF9KMWuoQMlXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+d1J4Ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C03C4CEE4;
	Thu, 17 Apr 2025 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744906510;
	bh=zUJdNRgUdcltlPwaKWSrWAxnx1SFdIe5x0+jpNyu34M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d+d1J4EeVEMIYqW5HsZ6ctTeopAxbbpyMQsoHNdANYrJrAudAYOeiLCynUOZv/Szm
	 MvJMWwSqkR3DsBR3WDR83cg2lqgZ6L2j2THeHFg7+rQ66oktLYGSfJVpy3D73UM4wd
	 6yMi1mEfLapqeL3R2VIJIbbT6pC9M1x88ukYgCY0Od0jWFtsY/1tl8UlD1myijyr4e
	 ZcaIQm0H8l2bSaQ0DeibboC/iXaf1uHeeL9KWeBSVTytVAiZKZNnrJa1TLPedZblHX
	 fl8Cneh9n/vPKWMJulWhh33fTub15cMO+N7+tnGkjF59X8aCv/BkzUP5j0FPqBg876
	 +Yv0JdiCzFjZw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfed67e08so10202961fa.2;
        Thu, 17 Apr 2025 09:15:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuW/jHDPKvPQzL2b0nJW8dJUbm9WQAM7dnwjjawWC7gsXbAIohnpCQtBZYVmPJ43GeGbETFgD18PU=@vger.kernel.org, AJvYcCWKGCwT73x3L2YSpjQsthzd5U5O0UeOTqPGBR0TfwpHXU0aXapPGiSBMWWoVlMO/84N0AwjdgIu/NfwXEVP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4Z/uKardGWqXYr4yFu4EvtUp/q3HBd9UyJMFzrIRAL/+6sxY
	0uoSFOY5ThY3CMHgthRbBasDsMduYPZ5zcwawyQftwUnPQJMxESAQEQkinSB60DQeK/bPeRZkYa
	7ivKajZnBdSAklmzDmO/93Buy844=
X-Google-Smtp-Source: AGHT+IEAXvRaouni3tWSx9FYr0xWIerIUOFH8Q1eiz6v1ZSxnnF9iFOXDDi8FN3MdufQqURFWPvg6Nolo4N+4jZpG+c=
X-Received: by 2002:a05:651c:1549:b0:30b:a4f6:bb35 with SMTP id
 38308e7fff4ca-3107f6ce1c2mr29210341fa.22.1744906508620; Thu, 17 Apr 2025
 09:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410132850.3708703-2-ardb+git@google.com> <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
 <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com> <3f2b0089-a641-1e0c-3558-0a8dc174d1ec@amd.com>
In-Reply-To: <3f2b0089-a641-1e0c-3558-0a8dc174d1ec@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 17 Apr 2025 18:14:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGvLQwea2J0E72tMhY-9iDCTmQm3drrHCTLyZ=hCP_iAg@mail.gmail.com>
X-Gm-Features: ATxdqUFyu5qPSKCLHMuzbaKpi4kqcM4XAua3jtzNHT8wNl28Brlkq48WLqON7nI
Message-ID: <CAMj1kXGvLQwea2J0E72tMhY-9iDCTmQm3drrHCTLyZ=hCP_iAg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory acceptance
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 18:08, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/11/25 14:00, Ard Biesheuvel wrote:
> > On Fri, 11 Apr 2025 at 20:40, Borislav Petkov <bp@alien8.de> wrote:
> >>
> >> On Thu, Apr 10, 2025 at 03:28:51PM +0200, Ard Biesheuvel wrote:
> >>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>
> >>> Communicating with the hypervisor using the shared GHCB page requires
> >>> clearing the C bit in the mapping of that page. When executing in the
> >>> context of the EFI boot services, the page tables are owned by the
> >>> firmware, and this manipulation is not possible.
> >>>
> >>> So switch to a different API for accepting memory in SEV-SNP guests, one
> >>
> >> That being the GHCB MSR protocol, it seems.
> >>
> >
> > Yes.
> >
> >> And since Tom co-developed, I guess we wanna do that.
> >>
> >> But then how much slower do we become?
> >>
> >
> > Non-EFI stub boot will become slower if the memory that is used to
> > decompress the kernel has not been accepted yet. But given how heavily
> > SEV-SNP depends on EFI boot, this typically only happens on kexec, as
> > that is the only boot path that goes through the traditional
> > decompressor.
>
> Some quick testing showed no significant differences in kexec booting
> and testing shows everything seems to be good.
>

Thanks.

> But, in testing with non-2M sized memory (e.g. a guest with 4097M of
> memory) and without the change to how SNP is detected before
> sev_enable() is called, we hit the error path in arch_accept_memory() in
> arch/x86/boot/compressed/mem.c and the boot crashes.
>

Right. So this is because sev_snp_enabled() is based on sev_status,
which has not been set yet at this point, right?

And for the record, could you please indicate whether you are ok with
the co-developed-by/signed-off-by credits on this patch (and
subsequent revisions)?

