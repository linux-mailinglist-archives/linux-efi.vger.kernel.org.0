Return-Path: <linux-efi+bounces-4615-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 482C9B36024
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 14:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED591BA650C
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297D225795;
	Tue, 26 Aug 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ3InD8D"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D6202F8E;
	Tue, 26 Aug 2025 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212860; cv=none; b=BDw4f2Tkw3lc2jHw7up5ZNiKkHCqhas8SvlS7yymEQIUqNO2YW9h1bnB1WurpZQmGDm5/KyGzWiwCwz1J9g2N8O4rWtI0q/dFYcHzO63u7IJTgZstlVEZiq7D65p6eRDw9F9pFoforNnQw27UFnuaTieMdxBth1e7VZFstiJ4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212860; c=relaxed/simple;
	bh=0Q51vRiKOQmozJ7U6guRwOuXBGUGd6mwPCGGWpzr/yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7zCAdHOsP7ZWy9QTkwv5DyRb4JSbJkIDpf6fyI5yBYsW6K1uWmlEa5jPzZAp159JC/AYCUErXctFQaMG/yZaD7pTuzceMEJ60iSM4CtL2ii3ORbZJUGRtt/gCuclWMm8eVjRBRLJkpHQzpTI1S2J0Kugh4/y4hk7dRTFDQP8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ3InD8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DF8C116B1;
	Tue, 26 Aug 2025 12:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756212858;
	bh=0Q51vRiKOQmozJ7U6guRwOuXBGUGd6mwPCGGWpzr/yA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qQ3InD8DPoYC5tkHnmrWE7nVUst5ruw7TyD4u2OHli9c49273pJhM7ZnGz6JMHpQf
	 oVlUYJ2K3jWsJso2wbBf+3jc+KZUw1reORmJX076qoOt6/gMI3KNjKIMT20cM9qpzS
	 u5s3ImBRKl1RnAgKhTQA7Q3HIRGW5jAq2LDoYIwnH3YMs/pD8dje4tr61mNVD/MyQ/
	 Iah9ZyYE2uP/+xTnPHSCs+IddxogBIg3D8ZgTD2gacRtfygCAtx7rx83xp6HzImInE
	 xZVCrHgULfWzBcPJJ5Gzf2wvg86riZy/Ro9QXU3kcpKJYR2Auqka0WRn33gaEiPaLF
	 I9GqMfqE692Dg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f48d62057so1896411e87.1;
        Tue, 26 Aug 2025 05:54:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtFQbN3cGaAldFFHjGfSkTGVPDpc7ob2MAUy7X8vvHbDm4TpkiUKqqM5wg/s08ad7oDK+magrfqAg=@vger.kernel.org, AJvYcCX6XDn8C0EJqmfyoANqss1fVxPy12qMPsfpkwfyb7/yzz6KKliwklk1eKrKFg+8/W/DKBmFW7WyxvY3BYFO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5kkAvj/woqjFnODYqWxhZtVOaljgcanYDiZPT+MT15y1J3V4l
	0yC6LtyRUMkIayXryMJkdhJpOm+yfn8RsK0rZxvFVnHAa+JehPjwF5hxPakKcJjUQOGy6N7+UHH
	+MlTGBoPeRXNjd/gtF/iyZq/drXmBWco=
X-Google-Smtp-Source: AGHT+IFWvbcBz0XAXBN1cZWESGc5SJUBfOqwBeXw8VGqjxg3jIzwcE+awVTOvorbXVpXT2x0GqDdsjbzxFRdoSMWu3Q=
X-Received: by 2002:a05:6512:31ca:b0:55f:4ede:6518 with SMTP id
 2adb3069b0e04-55f4ede6715mr663727e87.6.1756212857163; Tue, 26 Aug 2025
 05:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756138033.git.jan.kiszka@siemens.com> <aK2Tx5yeQeMoLMKn@sumit-X1>
In-Reply-To: <aK2Tx5yeQeMoLMKn@sumit-X1>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 26 Aug 2025 14:54:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH6VifL3Dqts95qs2U8yBqKMOTLMFYVF2nD1QVt4ACKcw@mail.gmail.com>
X-Gm-Features: Ac12FXx3YRLiGmqmzzb7lP2_NeH2Jt8h8F4l9RpA34-6UmEf8kow39K5xMYq8hE
Message-ID: <CAMj1kXH6VifL3Dqts95qs2U8yBqKMOTLMFYVF2nD1QVt4ACKcw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] efi: stmm: Fix for incorrect buffer allocation and cleanups
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, 
	Hua Qian Li <huaqian.li@siemens.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 13:00, Sumit Garg <sumit.garg@kernel.org> wrote:
>
> On Mon, Aug 25, 2025 at 06:07:09PM +0200, Jan Kiszka wrote:
> > Changes in v3:
> >  - improve description of patch 3
> >
> > Changes in v2:
> >  - simplify page allocation approach
> >  - switch to returning EFI_DEVICE_ERROR on ENOMEM
> >  - drop efi return value argument from setup_mm_hdr
> >
> > One critical fix for the EFI StMM driver, one error return code
> > adjustment and two smaller cleanups.
> >
> > Note that the suggestion to convert tee_shm_register_kernel_buf to take
> > pages instead of buffer addresses is not forgotten, just in the backlog.
> > I wanted to avoid that the critical fix has to wait for me finding time
> > to refactor the API as well.
> >
> > Jan
> >
> > Jan Kiszka (4):
> >   efi: stmm: Fix incorrect buffer allocation method
> >   efi: stmm: Do not return EFI_OUT_OF_RESOURCES on internal errors
> >   efi: stmm: Drop unused EFI error from setup_mm_hdr arguments
> >   efi: stmm: Drop unneeded null pointer check
> >
> >  drivers/firmware/efi/stmm/tee_stmm_efi.c | 61 +++++++++++-------------
> >  1 file changed, 27 insertions(+), 34 deletions(-)
>
> LGTM, for the series:
>
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>

Thanks all - I've queued these up now.

