Return-Path: <linux-efi+bounces-2687-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F145BA16853
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 09:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B76162B3C
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0186170A26;
	Mon, 20 Jan 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZCr8zZR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A97E1;
	Mon, 20 Jan 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737362743; cv=none; b=IaMsWg91EVhRrTAqzZEckgiEJDwhBWSGlS/lYkYEy9sGfA/9qNLYR7g/28kS8YApRfYVUruBOF8EkNu6T8q1oyqXbkl1UWK50CEjp/Xczvirr/mdOmLt86SjiW5Pz+d0Qxa6wN6IYTpTSJsNabJozuphE62+oa8+h/v64gPmkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737362743; c=relaxed/simple;
	bh=U++a4NdqFq4gJLMKAMpS0Xnn6qZhb+CIv8p4/SSgBwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzsPYvYPi8IzQXC9geB/DbmdpyViWotFwuxBI4Z0uvCTKnCDgfroc+HWdEXrkJ6dyoI3aeEcjIgH1reu+FqqGGMqk2zax43bIUliinv5tlpu1uFH4nIWM2LpzIsRXMrfKzMK6Och5fmAc1BYwNmCRrgv7zkgrOoqaRijaGCPlEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZCr8zZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E307FC4CEE3;
	Mon, 20 Jan 2025 08:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737362742;
	bh=U++a4NdqFq4gJLMKAMpS0Xnn6qZhb+CIv8p4/SSgBwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JZCr8zZRmQZrsjaLTOQQ/1Al+wWJNEiT/Som+AL5BwwqtTRldGnDGdB2WazhPI3gC
	 xfGaqlVjdusOOS5miNL619rCCQIs9GjaazA2fAp/Tt73WwdQkTD33gv6ly646L1LQ8
	 wrXCTbkl0ZnUmdeWxu+7pIZhhRLZwSC0Bp3IblPsQCg/eIFuo/De+JBzoR8iB4feEY
	 oxBD4BIjQnA47DCHvnICzONPWAQ3eoxI0WHnLv+qmln0FKJkp4LKegAmGrd8/Te0Qz
	 IBukWH+F6rU2b4mycWAIFyWXck3elBauwH4/+Z0bTki3bD6tzBuDza2N7kYivmgZQ/
	 uMhLCSN6UvzjA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30737db1ab1so15729621fa.1;
        Mon, 20 Jan 2025 00:45:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV87Q/J+xPbBhresew/8aSqD1li3sxEynSGXyEi5BP5yQ6aaFYGAEr29UulEAubGegvOVyz1v511vo=@vger.kernel.org, AJvYcCW8i9Q5Q6wJkzLJOyvgvtRXgJZqj/QBgXxedTO8bWBUNzUy61Eh/qN7PhAbNGbQfHgRSX0IK/Rv2VDtixFC@vger.kernel.org
X-Gm-Message-State: AOJu0YzmY9ROrSrLRi9kwqfVgg9rMm212t8RVtCnf34h5AUcBb6PT54d
	iLQST8iUZp2O4rxvSamzExS1zdGsr+5EIqYEt/65OOI+x3/2rSrk/Di5A8K6Vss/oE0J+tJDjid
	7JzElJD26yKNRf0/Ofn7uGyiLG10=
X-Google-Smtp-Source: AGHT+IEhw6olVGuAcpT5NmYmRmJ3RIwUr2GsCNyVENOToogeWobDWLsciqIf/BtomOem0c6TUygs2Ul1TXNWUmKwePs=
X-Received: by 2002:a2e:b554:0:b0:300:2731:4120 with SMTP id
 38308e7fff4ca-3072ca8b0a7mr32478761fa.15.1737362741288; Mon, 20 Jan 2025
 00:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXGLGmKU1Nvz8oo-aui1AtWo_8YDdT9cGtVweV9d6K6D3A@mail.gmail.com>
 <20250119173205.2965649-1-linux@t4c.dev>
In-Reply-To: <20250119173205.2965649-1-linux@t4c.dev>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 20 Jan 2025 09:45:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEeJattXAkvitfyu3KRRokkSMJZR0xgg_+DG2Mk-tMuoA@mail.gmail.com>
X-Gm-Features: AbW1kvYtZjcVSfBgsQjaSLDe9EVl1zo-e9COqIfi_rfz-99V9ja7wIAd5RV69N8
Message-ID: <CAMj1kXEeJattXAkvitfyu3KRRokkSMJZR0xgg_+DG2Mk-tMuoA@mail.gmail.com>
Subject: Re: [PATCH] efistub: add efi=quiet parameter to selectively silence
 efistub alone
To: "Hendrik 'T4cC0re' Meyer" <linux@t4c.dev>
Cc: linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jan 2025 at 18:32, Hendrik 'T4cC0re' Meyer <linux@t4c.dev> wrote:
>
> Hello!
>
> > Could you explain the use case please? Your concern is that removing
> 'quiet' from the command line is producing a few additional lines of
> output from the EFI stub at boot?
>
> Sure :) I boot a UKI (with Secure Boot and TPM measurements)  with an
> embedded splash image, and the cmdline
> 'memtest=2 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200n8'
>
> The stub by default (without 'quiet') will print messages regarding
> the UKI and it being measured into the TPM on the efifb (I assume)
> rendering on top of the displayed splash image.
>
> "EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path"
>  and "EFI stub: Measured initrd data into PCR 9" to be specific.
>
> > How is that a problem compared to
> the fact that you get the entire kernel log printed to the console?
>
> Very relevant question. Because of the 'memtest=2' flag, there is a
> delay during boot, which should be logged (with memtest progress) to
> the serial console. 'quiet' will silence these logs.
>
> > Is every single line printed there relevant to you, and only the ones
> emitted by the EFI stub are not?
>
> Basically, yes. I want the kernel's printk's, but not have the output
> of the efistub dipsplayed on top of the splash screen of the UKI.
>
> I did not find a way to redirect this output, and adding a 'efi=quiet'
> option seemed like a low hanging fruit.
>

I'd prefer to just raise the verbosity level of those messages instead.

