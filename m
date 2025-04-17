Return-Path: <linux-efi+bounces-3354-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8943A922D7
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E8C172A8F
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DD8254850;
	Thu, 17 Apr 2025 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dndm/+Yg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAA83C0C;
	Thu, 17 Apr 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907901; cv=none; b=hrOi5Qd0oV3A8WEMF+pfsk5ivCeYnirXKXz0XemAyg6iaCH9ZR0UnBjbn+OAKR6CUoz0mIaAb+UffS+7onwRq1E1LZy9axEa2JS5DV4Gc0I4Z7Hb9SNZPSy4BvypelatvbcyBYy3fT0TLSZGu4TzGZYj6sCbE4zZub/KrKFOdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907901; c=relaxed/simple;
	bh=rFqPdgaxq5bPHs1u3HIibyPQvV0xl51RdnOC/QZNAfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJZy/e/RTSJ2bfjBpyOig8JZfMAbqjmJZb7d2SJvlOzUDCXrs/+dpfD+kFX265Jimci6E1SjBG4sKdi5DU56QQiZwbf60Udm9Lu9BGrbWl4wCUUFTzT3VDmXhcSqX9znJGshu2or9mU6UtIaAJR9SNTFdjDlzCclgDVFkxM3w4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dndm/+Yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DEAC4CEEC;
	Thu, 17 Apr 2025 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744907900;
	bh=rFqPdgaxq5bPHs1u3HIibyPQvV0xl51RdnOC/QZNAfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dndm/+YgYxPI4jAp9TaBHia9Kin485PblCLd1Iomrb1zEz+zkvYvg8aPUNHcr+geO
	 9NQIgnJCvPwQ+v9vd7eiuS6LsKeDQ0YtbRkAQJH8oD7I6H9YePLxC2W8lJPwLEgdrH
	 htmRm3bcBaTXOyz7rZYCahBU5JzV8gjwTmSOcTrPRSrtPcfs6UpORj24n2fsM1HACI
	 /ivzDsDAe6jaoji/9KYlARYYXoMeQPgIn7ttGw0Y1Y3TL5lVlYvy/iTN2c6cMr629v
	 Jl0p7wl3M2aANiZUdz3r4I90HgmcgxBU2djdW7VWpMkKFJwLNkTD2zB6Zobz15+dRv
	 O5qKbCf6VE5IA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54af20849adso1038454e87.1;
        Thu, 17 Apr 2025 09:38:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuDtJcOQ2q14jOIdx4hrtkkdGp/wib2Ik4dycLnNbM60xxZQNpD0uRga4jCXKcapRwBFPoT7Nw3DQ=@vger.kernel.org, AJvYcCVklJvemAGEVX4pL8Cy2f2SiuD5Qatx9XJ/PQui/Lqk9XUmxR6UVBF5BFfMWS5pE/3QUjnek+C10Q75MGHJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYlLwqUxxPXcTEcPDlDGTLIKTMC6sm7Yof6okLZAC4Isbw+Qs
	f85l0DHpD8FCJqc0k4PRnfzLcX6wNBnvJ8lG6SI3x9asRHMvuPDXK8TfydpbamoD/n18iuojMOu
	Xz6VkqBcYP4qPgGsNyGk/mzTqrmE=
X-Google-Smtp-Source: AGHT+IGh8+ZdSAxEZ29/KmbIXxXGUdJyYwzfj73vB80z1W5XlJrUd5nSlg98cr+P77Z6KAOL6RkSdE35KZOQGsAjvWM=
X-Received: by 2002:a05:6512:398d:b0:54d:3ea7:9110 with SMTP id
 2adb3069b0e04-54d6dc05ca4mr194995e87.27.1744907898782; Thu, 17 Apr 2025
 09:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410132850.3708703-2-ardb+git@google.com> <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
 <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>
 <3f2b0089-a641-1e0c-3558-0a8dc174d1ec@amd.com> <CAMj1kXGvLQwea2J0E72tMhY-9iDCTmQm3drrHCTLyZ=hCP_iAg@mail.gmail.com>
 <96762dec-616b-b906-02b3-e006d43a8535@amd.com>
In-Reply-To: <96762dec-616b-b906-02b3-e006d43a8535@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 17 Apr 2025 18:38:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFVeygkdnhtkGHsKfRgGXoMRpdjQ-wTO1RBLU_wERs_=Q@mail.gmail.com>
X-Gm-Features: ATxdqUHFhrBPmzFKFU1HhH2paC89etivSFLWAn32Cw95YDOaMRzXx_XbhDYpGLs
Message-ID: <CAMj1kXFVeygkdnhtkGHsKfRgGXoMRpdjQ-wTO1RBLU_wERs_=Q@mail.gmail.com>
Subject: Re: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory acceptance
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 18:21, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/17/25 11:14, Ard Biesheuvel wrote:
> > On Thu, 17 Apr 2025 at 18:08, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> On 4/11/25 14:00, Ard Biesheuvel wrote:
> >>> On Fri, 11 Apr 2025 at 20:40, Borislav Petkov <bp@alien8.de> wrote:
> >>>>
> >>>> On Thu, Apr 10, 2025 at 03:28:51PM +0200, Ard Biesheuvel wrote:
> >>>>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>>>
> >>>>> Communicating with the hypervisor using the shared GHCB page requires
> >>>>> clearing the C bit in the mapping of that page. When executing in the
> >>>>> context of the EFI boot services, the page tables are owned by the
> >>>>> firmware, and this manipulation is not possible.
> >>>>>
> >>>>> So switch to a different API for accepting memory in SEV-SNP guests, one
> >>>>
> >>>> That being the GHCB MSR protocol, it seems.
> >>>>
> >>>
> >>> Yes.
> >>>
> >>>> And since Tom co-developed, I guess we wanna do that.
> >>>>
> >>>> But then how much slower do we become?
> >>>>
> >>>
> >>> Non-EFI stub boot will become slower if the memory that is used to
> >>> decompress the kernel has not been accepted yet. But given how heavily
> >>> SEV-SNP depends on EFI boot, this typically only happens on kexec, as
> >>> that is the only boot path that goes through the traditional
> >>> decompressor.
> >>
> >> Some quick testing showed no significant differences in kexec booting
> >> and testing shows everything seems to be good.
> >>
> >
> > Thanks.
> >
> >> But, in testing with non-2M sized memory (e.g. a guest with 4097M of
> >> memory) and without the change to how SNP is detected before
> >> sev_enable() is called, we hit the error path in arch_accept_memory() in
> >> arch/x86/boot/compressed/mem.c and the boot crashes.
> >>
> >
> > Right. So this is because sev_snp_enabled() is based on sev_status,
> > which has not been set yet at this point, right?
>
> Correct.
>

OK. Would this do the trick? (with asm/sev.h added to the #includes)

--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -34,11 +34,14 @@ static bool early_is_tdx_guest(void)

 void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
+       static bool sevsnp;
+
        /* Platform-specific memory-acceptance call goes here */
        if (early_is_tdx_guest()) {
                if (!tdx_accept_memory(start, end))
                        panic("TDX: Failed to accept memory\n");
-       } else if (sev_snp_enabled()) {
+       } else if (sevsnp || (sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED)) {
+               sevsnp = true;
                snp_accept_memory(start, end);
        } else {
                error("Cannot accept memory: unknown platform\n");

> >
> > And for the record, could you please indicate whether you are ok with
> > the co-developed-by/signed-off-by credits on this patch (and
> > subsequent revisions)?
>
> Yep, I'm fine with that.
>

Thanks.

