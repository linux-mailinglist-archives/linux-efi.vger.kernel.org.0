Return-Path: <linux-efi+bounces-3357-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8540DA92C23
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 22:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F053A7068
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E295146593;
	Thu, 17 Apr 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXdyBTlb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582F1C6B4;
	Thu, 17 Apr 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744921061; cv=none; b=Icpv+65FvuYcgwP8xX8Bi8IQtOARBjbx/DROkHqQUHsfyBh8Losa4XD5NCpWTi5EEGOrWd1Dy0eeeNYIHbaXB1NNxlFBG6P13V4CwteNK1mvTgTCO4dT0GKH+Xd7VoD82ovujawhDKq+LhZ6qwQg1ExTh87YeBcDbV3augk32N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744921061; c=relaxed/simple;
	bh=ylGcaqXs2CkFWNWnobHXJhkjC4qMgA3tVJ/2Z20Won8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzK492Im5exh73Ic6xyOhx3NYkp4lyx6ABBgFH4iv+0YrrCP4dZVSUzSucbVDHpvTFR08SA0bakPsIVKratJ+e+o+P5U8aUiygaZlqS4i/YNRMkgzpqbIUKhObl4sWOCPVksm/Xsq9eFHYGDVMSoDF9QxAIVNrhpM90FiEn32FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXdyBTlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336A0C4CEEA;
	Thu, 17 Apr 2025 20:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744921061;
	bh=ylGcaqXs2CkFWNWnobHXJhkjC4qMgA3tVJ/2Z20Won8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HXdyBTlbCt1dyeHOdi+EfWelczNK7KQOAal+MxUXpQ9gfQX4ZpO46koDmzJsH47+3
	 R47YGuoMCFROd3N33EbJ145UGi9OghOdX+w9+fmti7wHE979u1+WY582foSJq09y5W
	 VwN+0OYcmHZyY8IeKY/BkCdrlGSMzyol3Vr41GGSmZ21X9OWm2PZNmo2ewVhApgvyR
	 S9sqC0OyaJ9EiVm788Tuxpmf+SP0SULtPM/Q2llejb3o5vCkQmm47Kfi/UsNzQKOIY
	 cROdKIICtnFYQqs+ndn/DJGUuA+nDoPoJJUQxPZ9QW9eqXB0GgRVEku8RB+lPsS5SI
	 1CI1Fzz96v60w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549963b5551so1312691e87.2;
        Thu, 17 Apr 2025 13:17:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+kwl+tMRjXq36syAbqeMpK7h80XHUU1k2ahD5ySX/9ng5SJAJggLm6Epu1bRjT7vBnINj4erzAMY=@vger.kernel.org, AJvYcCUJtkP1P10tMDY7zmiBrS27Ix0xLrdna88lyK/we0jE0rpOPYBlMWmGz+8vP3ZC6hskt8eBDfEjEoDcGLye@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3GDVMy+OI7s0tAIGTO5uak0i5iNxQPQAxhQsYFZm2vGY53Qws
	uBEYjJA5+XAdIYrArLFF7VyXjZfLGF1py5Ku9VLUBakB10U8tAn+ob/kn70XpfTgr11+rE3equW
	WOKFHtuYh02Y2PZsVCYvk6/VD+cc=
X-Google-Smtp-Source: AGHT+IHC/qjBvVDkg0bOLRN2tbFVMMZ5e3m89Q/YIRaiRPwLsvxG2Cb9dZK4Juivo6D/U18CdE9gOG+RbuNpIoJVcqg=
X-Received: by 2002:a05:6512:1282:b0:545:2f0d:8836 with SMTP id
 2adb3069b0e04-54d6e662b3bmr46045e87.40.1744921059532; Thu, 17 Apr 2025
 13:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410132850.3708703-2-ardb+git@google.com> <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
 <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>
 <3f2b0089-a641-1e0c-3558-0a8dc174d1ec@amd.com> <CAMj1kXGvLQwea2J0E72tMhY-9iDCTmQm3drrHCTLyZ=hCP_iAg@mail.gmail.com>
 <96762dec-616b-b906-02b3-e006d43a8535@amd.com> <CAMj1kXFVeygkdnhtkGHsKfRgGXoMRpdjQ-wTO1RBLU_wERs_=Q@mail.gmail.com>
 <3196bc53-cb39-5501-b585-de175eed83af@amd.com> <c606da9b-f8f3-60ee-9e19-30e75a435c92@amd.com>
In-Reply-To: <c606da9b-f8f3-60ee-9e19-30e75a435c92@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 17 Apr 2025 22:17:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH4e3cFBZaaLpNqiE6A-T-zAKqfuSOuRX-Zz+M=e2Fr2Q@mail.gmail.com>
X-Gm-Features: ATxdqUHt0nH0JCb8hC_2A7962M_IHPT0IamO-24koQHBjBgHHsleghHD4fTmCSU
Message-ID: <CAMj1kXH4e3cFBZaaLpNqiE6A-T-zAKqfuSOuRX-Zz+M=e2Fr2Q@mail.gmail.com>
Subject: Re: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory acceptance
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 22:01, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/17/25 12:26, Tom Lendacky wrote:
> > On 4/17/25 11:38, Ard Biesheuvel wrote:
> >> On Thu, 17 Apr 2025 at 18:21, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>
> >>> On 4/17/25 11:14, Ard Biesheuvel wrote:
> >>>> On Thu, 17 Apr 2025 at 18:08, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>>>
> >>>>> On 4/11/25 14:00, Ard Biesheuvel wrote:
> >>>>>> On Fri, 11 Apr 2025 at 20:40, Borislav Petkov <bp@alien8.de> wrote:
> >>>>>>>
> >>>>>>> On Thu, Apr 10, 2025 at 03:28:51PM +0200, Ard Biesheuvel wrote:
> >>>>>>>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>>>>>>
> >>>>>>>> Communicating with the hypervisor using the shared GHCB page requires
> >>>>>>>> clearing the C bit in the mapping of that page. When executing in the
> >>>>>>>> context of the EFI boot services, the page tables are owned by the
> >>>>>>>> firmware, and this manipulation is not possible.
> >>>>>>>>
> >>>>>>>> So switch to a different API for accepting memory in SEV-SNP guests, one
> >>>>>>>
> >>>>>>> That being the GHCB MSR protocol, it seems.
> >>>>>>>
> >>>>>>
> >>>>>> Yes.
> >>>>>>
> >>>>>>> And since Tom co-developed, I guess we wanna do that.
> >>>>>>>
> >>>>>>> But then how much slower do we become?
> >>>>>>>
> >>>>>>
> >>>>>> Non-EFI stub boot will become slower if the memory that is used to
> >>>>>> decompress the kernel has not been accepted yet. But given how heavily
> >>>>>> SEV-SNP depends on EFI boot, this typically only happens on kexec, as
> >>>>>> that is the only boot path that goes through the traditional
> >>>>>> decompressor.
> >>>>>
> >>>>> Some quick testing showed no significant differences in kexec booting
> >>>>> and testing shows everything seems to be good.
> >>>>>
> >>>>
> >>>> Thanks.
> >>>>
> >>>>> But, in testing with non-2M sized memory (e.g. a guest with 4097M of
> >>>>> memory) and without the change to how SNP is detected before
> >>>>> sev_enable() is called, we hit the error path in arch_accept_memory() in
> >>>>> arch/x86/boot/compressed/mem.c and the boot crashes.
> >>>>>
> >>>>
> >>>> Right. So this is because sev_snp_enabled() is based on sev_status,
> >>>> which has not been set yet at this point, right?
> >>>
> >>> Correct.
> >>>
> >>
> >> OK. Would this do the trick? (with asm/sev.h added to the #includes)
> >
> > Yes, that works for booting. Let me do some kexec testing and get back
> > to you. Sorry, that might not be until tomorrow, though.
>
> Ok, found some time... looks good with kexec, too.
>

Thanks!

