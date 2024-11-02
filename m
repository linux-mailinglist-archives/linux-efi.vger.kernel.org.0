Return-Path: <linux-efi+bounces-2111-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966D19B9E0D
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 10:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A901C20FB8
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 09:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DD2154456;
	Sat,  2 Nov 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T92cCCsw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C380034;
	Sat,  2 Nov 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730538174; cv=none; b=HzqwUBWV6nr4t1pqI4lC+jj3WMoiOmcNQ0ji6pOeIdawP3H48MAGtC1zt4qnG2PTIixvUOSZ9nqyzuppBtFUOjnzE7hbKUX9Jtu3ycN9bdlrarC7hl2+9VPit91goYUf/Jj+Q6/kd5KwUjZBzqOMC1R4t9KxXUOJK/ftX2UiDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730538174; c=relaxed/simple;
	bh=LBoNUIt26/rOHWnEOHVZz/A27Sk+n0iu8cOSeH8LX0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+DvCPuBLR7bRFnlwK5q2H8WOY4nWQqfry8PNYIv24G4+H03IwltwtZqYyvvpSolBqApT91ARyxg/O9APQ9lBWQtxzW6SOFodYuQLVTUxJem+EVNkcU4bAh1nP1n4OTh2bALAYH0f1SwruG0JZlTAdAnGI63JNrQl7I9GJaEz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T92cCCsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636D3C4CED2;
	Sat,  2 Nov 2024 09:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730538173;
	bh=LBoNUIt26/rOHWnEOHVZz/A27Sk+n0iu8cOSeH8LX0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T92cCCswFZ6WUioUkTmAiZjzCFTDeI+a3/42QMv5GjnyNBbMyng9Px/d+iIX2InM9
	 3AZnttj3GzjwZ2lzOP/h3brXdgoQoGYzuA7WYBmAkbWiBU2dNjo+ZW4zQTGS7LUM1k
	 dbtmjb2bFrO/MAiO73+Bz6l3Ktq6bELYuCzxuV4NHaB+G9uYkwiiMwZfz8JwnG0i1J
	 n1+n5fO85Fg+fLTfst0zqL81ZEL9oe181eo59eLEmvaQkTlEzOAaKxuZUCFbWABq3Z
	 hPDmi4z6gt370GEiK8h4bl9GY/CLtSPP2i/8/XUdz0mRl4d4nIKN4N2gugIjuys4Er
	 8ZnA3qUSEqY+A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso2823551e87.2;
        Sat, 02 Nov 2024 02:02:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULTF9pE8Zea+O+PyN2fpTAGghZvguAzRw3FmT1J4R1uplp2bN+rLpdRv4VVnEElwz4CW1wm8u4wRBkLEI=@vger.kernel.org, AJvYcCUN7Pc8+4URK/Ew0rZys2kZ2IGGPE27S18QluhBWDbIub8QitxnTTQjgbVSYxVqRuy5BuVD4l0bMW4KH2kr@vger.kernel.org, AJvYcCUmCewdJe/an1WjEgGjYjtUL2FY0VkX7r8abUhsEDgMOGoHxkKngw8PwhKbzMZ+tUjdRBK2ryBS18lL@vger.kernel.org, AJvYcCWVLhwOzSPu9nAl0gtISzkmcU8DPo9u7srTa43kR3PLjIEIuUkAwj993HnmtWu+3KuvgcZx/ENXaBUQFy9Bo9h8@vger.kernel.org, AJvYcCX8FMkL7kmTxUyipybr0gnu6zC/3Vd0KYxDdl1p5JzAQRNF6Hia6/vkistTnSFyt1yismD2t4ZRvST4@vger.kernel.org
X-Gm-Message-State: AOJu0YwqBlbIriPCmD4Mang9w9zxjs0Tdgxm5GIAjltBzxupgtsITR1+
	WH1MfiuK6S8BTf4zP2GAOtfEz1iP0JXUpLipi7tAjo+rqGf4IZAjKk809gSEXfCNLelYMFEafc9
	Ds/7G9HecsxVf1U+smastyVbzTqM=
X-Google-Smtp-Source: AGHT+IH5OhSbyxPUwoV8Hi3NZvUJk62Sk/kM4uS3eDew9nHH5ECqnhoFDJijntPKiKzAeGwvpQ6+AOtWhMBUTM8YWgU=
X-Received: by 2002:a19:e043:0:b0:539:94aa:d512 with SMTP id
 2adb3069b0e04-53d65e1771emr2299160e87.53.1730538171706; Sat, 02 Nov 2024
 02:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org> <20241102062259.2521361-1-jarkko@kernel.org>
 <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org>
In-Reply-To: <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 2 Nov 2024 10:02:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
Message-ID: <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James.Bottomley@hansenpartnership.com, andrew.cooper3@citrix.com, 
	baolu.lu@linux.intel.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	davem@davemloft.net, dpsmith@apertussolutions.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, herbert@gondor.apana.org.au, hpa@zytor.com, 
	iommu@lists.linux-foundation.org, kanth.ghatraju@oracle.com, 
	kexec@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luto@amacapital.net, mingo@redhat.com, mjg59@srcf.ucam.org, 
	nivedita@alum.mit.edu, ross.philipson@oracle.com, tglx@linutronix.de, 
	trenchboot-devel@googlegroups.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Nov 2024 at 07:29, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Sat Nov 2, 2024 at 8:22 AM EET, Jarkko Sakkinen wrote:
> > DRTM needs to be able to set the locality used by kernel. Provide
> > TPM_IOC_SET_LOCALITY operation for this purpose. It is enabled only if
> > the kernel command-line has 'tpm.set_locality_enabled=1'. The operation
> > is one-shot allowed only for tpm_tis for the moment.
> >
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v2:
> > - Do not ignore the return value of tpm_ioc_set_locality().
> > - if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED))
> > - Refined kernel-parameters.txt description.
> > - Use __u8 instead of u8 in the uapi.
> > - Tested with https://codeberg.org/jarkko/tpm-set-locality-test/src/branch/main/src/main.rs
>
> This version has been also tested (and encountered bugs fixed). I wrote
> a small test program to verify that it works linked above.
>
> After the boot, the new ioctl can reset exactly once the locality. Other
> benefit is that the feature can be selected per driver (at this point
> tpm_tis drivers) and protection of the access with DAC, SELinux etc.
>
> And thanks to the kernel command-line parameter, it is an opt-in
> feature like it should because vast majority of users will probably
> never use trenchboot. I.e. set 'tpm.set_locality_enable=1' to have
> the ioctl available.
>
> I think this is a solution that at least I could live with. It has
> somewhat rigid commmon-sense constraints.
>

Before adding a kernel command line parameter, please ask yourself who
is going to set it and where, and whether there is any risk of abuse.
The kernel command line is external input that is not signed, and the
only known user of this set_locality feature is internal to the
kernel.

Same for the ioctl() [as well as the read-write sysfs node]: looking
at the code (patch 19/20) it doesn't seem like user space needs to be
able to modify this at all, at least not for the patch set as
presented. So for now, can we just stick with making the sysfs node
read-only?

The only thing I would recommend is exporting the set_locality()
symbol in a module namespace, so that it is obvious that it is not
intended for general use by other modules (although not impossible).
E.g., CRYPTO_INTERNAL does something similar, and if
MODULE_IMPORT_NS(CRYPTO_INTERNAL) appears in new code, reviewers are
alerted that it accesses internal APIs rather than ones intended for
other subsystems to use.

