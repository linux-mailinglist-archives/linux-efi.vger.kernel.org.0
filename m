Return-Path: <linux-efi+bounces-3361-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC8AA933A1
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 09:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FED54667E3
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 07:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FD3269CF0;
	Fri, 18 Apr 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxPxT+sj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6C20FAB1;
	Fri, 18 Apr 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962213; cv=none; b=kLIcMRBwGlW8OB3RvcLalG8SSwL7nMm8OE/Kwnqead1Fd+MaYxVt/oNkN5YD2g/moKT8xcNm+/SJCtAamiUr4Ggq1OU0+BcM0BKHkC6VCR8JkzFPdVwmb4Un16z3MQKTR0k0tf81Urjcm95hm8tLvz2xzx3XYf18IFKjimk+Ge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962213; c=relaxed/simple;
	bh=2UdZ3qTLAl5ywz9M0xFZCT+nXRQCqFmZSjigQ8KtX60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPjAxYQgu6XDYImr42kIAR2nPNb9WFM4TDqezNQUo6WLx2QeretSd/D5ChD35hjgM+6dh7kzspmpI1wH/OynaFQesXRJ5cqwg29K8qXGHQcRM9Fw3meQTRAQlJ+AB/X9IVujyJs2hIbZYamAxsDj1s1bleZuYD9Kqfpzv6elI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxPxT+sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7C3C4CEE2;
	Fri, 18 Apr 2025 07:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744962212;
	bh=2UdZ3qTLAl5ywz9M0xFZCT+nXRQCqFmZSjigQ8KtX60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxPxT+sj19iqe0k1iQuI2AHFVb074liHeI3q2TcazaGlYxVhJimFusFeLkc86mNby
	 6EF9L7JgG2Vp86SOU6hrFhxi+Ny9oLnx9CSeA+mBm0QqIeURWbHGjrDlQ1+QEL0j18
	 QXCLl2MFIzHvUZaJH+TLm7FzlBibd1dTyW4Eq2NqmM5IJPeYe281OKEaDI1pr9OeEa
	 I6Cqw77Mmv+iqDTVRP7TYhICHoS6TooUgWft3aG9B41NUQexPLy45bUHOCarJcO2Yr
	 6mqRO5sIHp5yqa8fhXVS0KA86ErHPD4lFbtUp2rTWNt8bgR2r9nF1C7XP8VLw4kJAl
	 akSi67588Ycwg==
Date: Fri, 18 Apr 2025 09:43:28 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory
 acceptance
Message-ID: <aAICoBecodJfFXMk@gmail.com>
References: <20250410132850.3708703-2-ardb+git@google.com>
 <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
 <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>
 <3f2b0089-a641-1e0c-3558-0a8dc174d1ec@amd.com>
 <CAMj1kXGvLQwea2J0E72tMhY-9iDCTmQm3drrHCTLyZ=hCP_iAg@mail.gmail.com>
 <96762dec-616b-b906-02b3-e006d43a8535@amd.com>
 <CAMj1kXFVeygkdnhtkGHsKfRgGXoMRpdjQ-wTO1RBLU_wERs_=Q@mail.gmail.com>
 <3196bc53-cb39-5501-b585-de175eed83af@amd.com>
 <c606da9b-f8f3-60ee-9e19-30e75a435c92@amd.com>
 <CAMj1kXH4e3cFBZaaLpNqiE6A-T-zAKqfuSOuRX-Zz+M=e2Fr2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH4e3cFBZaaLpNqiE6A-T-zAKqfuSOuRX-Zz+M=e2Fr2Q@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> > >> OK. Would this do the trick? (with asm/sev.h added to the #includes)
> > >
> > > Yes, that works for booting. Let me do some kexec testing and get back
> > > to you. Sorry, that might not be until tomorrow, though.
> >
> > Ok, found some time... looks good with kexec, too.
> >
> 
> Thanks!

I've turned this into this tag for the -v4 patch:

 Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks,

	Ingo

