Return-Path: <linux-efi+bounces-898-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BE3891464
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 08:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E621F22E73
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 07:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AC13D549;
	Fri, 29 Mar 2024 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjKSfDUl"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36140852;
	Fri, 29 Mar 2024 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697682; cv=none; b=ikwOSE1fgGbG0RZtF+H8JCqvglQtJdaRmJS0bPNW3/3f3PImbDeHAa6MF45iKnGVk0L2QojAyv2Tbcd5Jctiik5k3YcDmq1pyT4CmEHjhJrg6O0DlAtH1/R/l2U8KMa4pYuoPFxz7GWtCqIxK7P189NYkJ6Ub05FaFmf8ed1AZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697682; c=relaxed/simple;
	bh=6FG3wosaxtyLrhKBe6+/jrm0xfxaIALs5W2/r51MfkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzGKElpSL6QyKGPDSnjq2/pnfBQ92YY/V9Sg5GZMQHwini6pCUOFoXRfRDS2NZcBLyG8C1QPNU2HGZc84FcNHgbO3O6BYiVVe4WA3HDYDxrrR5PcRG9IN9TgYnIvt/OWGbLR614FppPg4SeHRYFPVPdcldoFurR6GFHwjrjvCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjKSfDUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5740DC433C7;
	Fri, 29 Mar 2024 07:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711697682;
	bh=6FG3wosaxtyLrhKBe6+/jrm0xfxaIALs5W2/r51MfkA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kjKSfDUlrcS0CpZtobwMc+OiCCECbiyslJkYRNNtRJDXSbFngdqFe2odOAuFpVBDf
	 nfEOFqdSw3budycquk0WG4QgdG3kf50nNL5/+FUWipmjlibJAgQx0rSinFhXbpppJd
	 NkKrUYWUhU+TlS1NYLAQqdm2Wi0AerI4PUYnIqYg/kdTNQmqMpODNylKtccbg1lteO
	 tZsfvmvAXMhciiD1uS5T5u23Z0RFyQ7J8OkhFVW+eoXaTXxDP6IxUxpHvoqziMR8L8
	 sYgRRw4dCFkjevwzKBR1PjKGB64E/D2M9KNGjrjVO+f6VPaTB+p0kiT6foeZbOxqxr
	 XoxpsLIpsB4YQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so22262981fa.0;
        Fri, 29 Mar 2024 00:34:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIMcRBZrWx6Ppfiwex+JfOyTwY4NfdETmpcX4/KvGPuDGQqy3/4O0KofVjCNfThQ2s3joWoD8WllfhiK+bbG/CvkFphgDcjbzVrXlInhFK
X-Gm-Message-State: AOJu0YwKS3BSuSans2F7vjaOm9kdcoAHiUe7dm0yrWYgYu4Lq/YOPdiN
	tAd1i1/F8A0hPDEfQK/e40XnmOONlkRzsGnFIIfpkfrB1/s8m/bMu9p0N3hzV/aakfm84jt8K7N
	FI/JeKZEonRx10N671xBJaLdvnuA=
X-Google-Smtp-Source: AGHT+IGOW+lpZSdg3nT58nShezLxHTQjE5g07mxmSQjt/giLHqglxYnQv7B5tT0rjUtg1S2PYRzoPu++OKH1xt2irgY=
X-Received: by 2002:a2e:9e58:0:b0:2d6:f698:7ecf with SMTP id
 g24-20020a2e9e58000000b002d6f6987ecfmr875392ljk.9.1711697680655; Fri, 29 Mar
 2024 00:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315002616.422802-1-timschumi@gmx.de> <CAMj1kXEvQS8e95A55po-nKn8cGou8Dn9nNhidt_QSqL02WawpQ@mail.gmail.com>
 <2a500ade-a91d-15f2-e5ae-7f261e6a84b4@igalia.com>
In-Reply-To: <2a500ade-a91d-15f2-e5ae-7f261e6a84b4@igalia.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 29 Mar 2024 09:34:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHEzDzFk+6jo0UNFQ9RptRS==88XjnvxLiZThZAm6pF-A@mail.gmail.com>
Message-ID: <CAMj1kXHEzDzFk+6jo0UNFQ9RptRS==88XjnvxLiZThZAm6pF-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi: pstore: Request at most 512 bytes for variable names
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-efi@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>, 
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 21:46, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 15/03/2024 06:16, Ard Biesheuvel wrote:
> > [...]
> > As an aside, you really want to avoid EFI pstore in general, and
> > specifically on such old systems with quirky UEFI implementations.
> >
>
> Hi Ard, this comment made me very curious; apart from old quirky UEFI
> implementations, what's the reason you see to avoid using efi-pstore in
> general ?
>
> Thanks in advance for your insights!

I'm just not impressed by the general quality of implementations -
relying on this when the system is going down is a reasonable last
resort, perhaps, but if other options are available, I'd prioritize
those.

And this is for the oops/panic logs only - other uses of pstore seem
better served with ordinary file based persistence.

