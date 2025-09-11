Return-Path: <linux-efi+bounces-4734-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A2B532BB
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 14:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280A91CC016B
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22338322549;
	Thu, 11 Sep 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW14L4cK"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6665322536;
	Thu, 11 Sep 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595004; cv=none; b=ewtt19fGg508aqKrp3M6iYyfNzGdz6btW+41h3+ipdROrrFEbMpcrIuHfTpQTD7yMonJr7kltJDghidyXOTla/vbs4sDhV3/cXIf0QhrSqspapLerh5Tvye/hVs+rIbhMaV5+rbYH2i0IJsJlGm6oTbmCuQRs2q5HrXTokMvDi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595004; c=relaxed/simple;
	bh=BMIUK1+4ZGU7sEfYZEU/14/S7jBlhbO/ImkwvUZM6Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfbQz9O3ECnBEkBFsxlzi0ofTY+84sXD2x106XkpCoXlWgPT5eG++VKnMFyQCBwjqSP559Fj1S3cmB/bZGbvPvPBiwENr67Vnj/H/jMZ0wuUSsK2Py2K2Qe4MP8TR/U1JbevRwae43dmMu60jZBby2A1gfKdUb1J3Cv6OLm+umY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW14L4cK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E694C4CEFD;
	Thu, 11 Sep 2025 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757595003;
	bh=BMIUK1+4ZGU7sEfYZEU/14/S7jBlhbO/ImkwvUZM6Zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dW14L4cKP1q+jsWKljM5v+JZEX2QBm56mIEi9Mvk7721gU7o/hUOiHvhQ4cOFJNZZ
	 FW34nZnbtBMwm9hD7W32Updrws0Hh4EI2pcBL6tJYqm2J5vqiADtAdgKFnsqC5xaVz
	 X+CpI0Y9wSBUlBHi+6e+NLYMllIX9XKqCUMwuEorPKFKl4FF8y8rcagBAaQyYlzIac
	 sv8w1Q00bHUfYQC1980DxdNkFVB/ak8XAJRfnpuUZvGpHVPP6/PgENjc1EiQ1X0YQR
	 l/6yt+vi9MTdX8hrZIPsH1Z8RqRxnpqeqSNFLSlA8/x0CWnieTWh/+YadNQtg6yOVI
	 IwZdknJ/aVz9w==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-56d1b40ed70so477292e87.3;
        Thu, 11 Sep 2025 05:50:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3HCMfFHc4K2QCnNrhMD9QkNZz5TrSyMqSw+PFBhMimtZrFcqJnAFuURgODcH2cZYq3+El0UOfV8Q=@vger.kernel.org, AJvYcCUIWmTkMWD6pNSpVjSePQv7G6g7kqRvn58VlQvLZ6m3Z8O7Jp/Pk1ShMwdPyCf8H7telbXZGac6LcBEqwba@vger.kernel.org, AJvYcCUhnfji/NN5bAYbonmvHX8XxkRIhCkzMr+lxJ6FdAZ2+GVe/0gITAe/37SGYdjmaY0shKW+pcQ+ijS9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrz0K2DjZuFJZWhLteSB8LbsBWZjnIOt8zJk7Ru9OT9V+qk/Kl
	qmqg/n4mJ2M5sokcyhq4ZaBh7lf+aehD00W+4omz+qOC90tBp7TaBUFgePzSXfrh2szdZiWzLYn
	sLxpq/saTqzTET9EnAaHEz7JLzvI06Vg=
X-Google-Smtp-Source: AGHT+IHV4d8eI4lIWGGACKtN9SWdkLlkmrv3qKSfocI9aFx9ZkgHzd2sNTRgdmQJFfb2vJkct1yKW68/joJ+O6RS5Gc=
X-Received: by 2002:a05:651c:1116:20b0:338:11e1:c7d9 with SMTP id
 38308e7fff4ca-33b603008f6mr47449521fa.43.1757595001754; Thu, 11 Sep 2025
 05:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910015738.14848-2-bagasdotme@gmail.com> <CAMj1kXHCi1pr3XNzwe7b7EFBkPGjkppeNWNSvy4wU1VBHj9kfA@mail.gmail.com>
 <c30fb598-2878-4bdd-ab84-4f4d07d0db5d@app.fastmail.com>
In-Reply-To: <c30fb598-2878-4bdd-ab84-4f4d07d0db5d@app.fastmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Sep 2025 14:49:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFtdqN+cDVVWK1KTbfyfe0kazHt1t1XmPz58uf+axknOg@mail.gmail.com>
X-Gm-Features: Ac12FXxw7_iwUPPuK9VmAhBbGDG0qqGTDTMLJY4mdIX7KYY4b8hnYxCGYgEpQcg
Message-ID: <CAMj1kXFtdqN+cDVVWK1KTbfyfe0kazHt1t1XmPz58uf+axknOg@mail.gmail.com>
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
To: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux EFI <linux-efi@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 13:23, Hugo Osvaldo Barrera <hugo@whynothugo.nl> wrote:
>
>
>
> On Thu, 11 Sep 2025, at 08:46, Ard Biesheuvel wrote:
> > On Wed, 10 Sept 2025 at 03:58, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >>
> >> From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
> >>
...
> >> +For sample implementations, refer to `the original u-boot implementation`_ or
> >> +`the implementation in candyboot`_.
> >> +
> >> +.. _the original u-boot implementation: https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
> >> +.. _the implementation in candyboot: https://git.sr.ht/~whynothugo/candyboot/tree/4097b2538d7f1cf85f03922bf42409490b666202/item/src/main.rs#L225
> >>
> >
> > What is candyboot, and why are we adding this plug for it into the
> > Linux documentation?
>
> It's a UEFI stub loader which can load the Linux kernel and provide it with an
> initramfs using the above described protocol.
>
> The original version of this patch was based on my notes researching _how_
> to implement this stub loader. The implementation is quite minimal, so I think
> it serves as a useful reference example.
>

I think one example reference is sufficient, and I think piggybacking
a plug of your own project onto a documentation refactoring patch is
slightly dodgy, to be completely honest.

Where is candyboot used, and what does it add to the existing u-boot
reference, which is the most widely used EFI implementation after EDK2
for non-x86 systems? If anything, we should be referring to the OVMF
implementation here.

