Return-Path: <linux-efi+bounces-3691-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B787AB5E6F
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 23:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118B81670BC
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 21:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444721DF97C;
	Tue, 13 May 2025 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofRVpGit"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EDC27455;
	Tue, 13 May 2025 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747171921; cv=none; b=mktChZ0ZuvqOXLkfIk/k5k6F12PWWpmeckj9BvKVxuKI6kzt5zpgZOVfJ7N/OzHJRic2qEgmr9BS6xB2AR5wy62Qdd4T/Zs6VK4YrJ9WrQwP1OzTcHSjtrFl3aAdp6J6Kos6GnYtTzADJCRP6CyAvgESphNIk3prur+YynYLYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747171921; c=relaxed/simple;
	bh=vtont7pBKVGTHIS3kkA+kuU3PqsvDy6WKNRWFZLwdYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nebXo3AM76NDv+N5mroocFyQRftVTlDPIL+W6o9AG2aDeH+uqYYO4baNTHYjIXPDU/iKK6i6baotVatUsG9w1p6i0ufvgNLUyXwy/PY8Vc3ohmn6OsLcDhPagFvlqLdrr9XsoMEyaU8nd/08WL8kCaicR388uUu/VptRDrhCyPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofRVpGit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7255DC4AF0C;
	Tue, 13 May 2025 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747171920;
	bh=vtont7pBKVGTHIS3kkA+kuU3PqsvDy6WKNRWFZLwdYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ofRVpGitneODZDWC598tUSbkBaYGdzUVh9LMzedRodJI+pODrx4oXCEcsaSImLdi4
	 II5ZCV8Q3Jya+KR/Tn0d7tuuaxBrbeX4TRqOT3+OLuX+g5TvGVFoyZtYbLn/peFMhq
	 xYez1QKBbUw7cjpDqv/AJjwSzufUT9eFHmflzQSaYs5cn0ck2MqAcRqnjliuNJhZqx
	 Utb7WViN0ypESWyQTZxDEVQSq2OHM8qH/IQgDzvfUVjPuE/jXs31Zx24hpFFF3gC+O
	 weR7og99W+IhKZZMHTK5B8hTpHxEmXSBVd6EHaHowKD1ZbcRGkoe7/TN6p62+A0Mly
	 2LyR8O4FWrdrw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-550d6e7c563so105186e87.3;
        Tue, 13 May 2025 14:32:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXIxrCwYSN/R27O2Pwso+J3pD2oWFEEe1EZAgyi57xtuEL24Qz0L/OP3MsHAlWQzZjzN0Dax3bFsg=@vger.kernel.org, AJvYcCXz6R/3EfEVyCXr8cw1D9UYI/hE43xtS2A6iT7L8Y/YU/z6yy9pdTrYFG987j59qO41qy7GZFWf9+LRRhKU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+YOXaw9uy4t7dYurfadsxa27JGi2opqW84KQgz/eK6PdoTS0
	s0b8FqRxa+qtYJ5LUUc9MymIU+mg/WXBGjFk/SvqT6FrEoQ80RRRVJcnud/MSwZ/BpHH/mhDhHu
	XJVgwDN3kfHUAhDXDI0/MCYnNNwA=
X-Google-Smtp-Source: AGHT+IFah5KkIU5s8sOJ/ofHDJnBGbMaLR4nwWF/r1BcFv8yfu+jv0hFzpe01CbFrEJdQUUxcAwnd4+405+amPm6dG4=
X-Received: by 2002:a05:6512:6807:b0:549:38eb:d694 with SMTP id
 2adb3069b0e04-550d5fa0fe4mr261251e87.26.1747171918829; Tue, 13 May 2025
 14:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com> <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com> <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
 <aCMraFZ2yJQNyHf3@gmail.com> <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>
 <CAMj1kXEzKEuePEiHB+HxvfQbFz0sTiHdn4B++zVBJ2mhkPkQ4Q@mail.gmail.com> <20250513164432.GFaCN28I_GmSvzXeRJ@fat_crate.local>
In-Reply-To: <20250513164432.GFaCN28I_GmSvzXeRJ@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 13 May 2025 22:31:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHRgrmD41cNHnkBTMKfZjfRTm6uCx8XhGHZg6+iaY0x_w@mail.gmail.com>
X-Gm-Features: AX0GCFuLlga9nA7U8IjYWfhEYGlBKlRr2B-lUqH54zSjrvK6hbm_tx-zbp24YXE
Message-ID: <CAMj1kXHRgrmD41cNHnkBTMKfZjfRTm6uCx8XhGHZg6+iaY0x_w@mail.gmail.com>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 17:44, Borislav Petkov <bp@alien8.de> wrote:
>
...
> > I've done a preliminary pass upstream with RIP_REL_REF() and
> > rip_rel_ptr() and the use of the .head.text section for startup code
> > to ensure that we detect such issues at build time, and it has already
> > resulted in a number of true positives where the code in question
> > would have failed at boot time. At this point, I'm not aware of any
> > issues caused by absolute references going undetected.
> >
> > However, Linus kindly indicated that the resulting diagnostics
> > produced by the relocs tool do not meet his high standards, and so I
> > proposed another approach, which I am implementing now (see cover
> > letter for details). Note that this approach is also much more robust,
> > as annotating things as __head by hand to get it emitted into the
> > section to which the diagnostics are applied is obviously not
> > foolproof.
>
> AFAIR, this is what you've done for arm64 too, right?
>

The new approach proposed in this series is what I implemented before
for arm64, yes.

