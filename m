Return-Path: <linux-efi+bounces-5101-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E95BFFE24
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 10:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A91AB354A06
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FCA2FF67F;
	Thu, 23 Oct 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYb/5IzA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799552F8BE6
	for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207714; cv=none; b=kv61RNTzH2HBfrNoOZgNXzYNoimgNqnKgKF9cCQ2lWX+jbcVkn2eAeaHdqtOvLej6yZB+yQG4Is/fTRVnof6eH+Ik2IkR6oRPQ8kLl1X5f1/JzehhNQDAp3ifUl1tmeTbhTKkwooKU1z6CvXtleLfxX+1WQauqHD9mNbDxHmazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207714; c=relaxed/simple;
	bh=Mq7wTbaDVrxT5aUwhMPrXpPQYEJ56iNmucEbpajeaW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f30nugN/MQgDeAq0XnOOT2/vFrWfk0DRymdD4pL5iU1Xx1o3L5QFlAQA9aJzak38mpRifk+cxC1RweY2zRLmm5WtxebZJR5MyMjKzCVvOnFWr3+AKG+3FB8VBwibKTAl+P3mBV0SpuqpbyNw+nysvCq1u6eYTRfXuq1TL6dPA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYb/5IzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD990C4AF0D
	for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 08:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761207713;
	bh=Mq7wTbaDVrxT5aUwhMPrXpPQYEJ56iNmucEbpajeaW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bYb/5IzAiRYC+or/Q8dBd12Jn6lz/LZcxJEms7PXqNQjIZPbIl/TZkioFwLPQFXr5
	 ubOPwq+pvakPSbgPE0V8MA053A8LvvijWONqHCfLrQSMLiniBfemwM8JtdgobJhLil
	 damyu+Tox2rPfSL7dB+Lo1MBBjogPnN9Rg8qA5YxdiVH7eKXIicrnfE7f57G6Ib0+P
	 O0UqbBhkqiOeNJ684Sf5mk10I/nQyoENN9NLAqzWsh+TX75L5skzIzXo/evGyvpNzn
	 hLD3jsGJR6uAZsh7DpJyPZOIStyI4aQLo22WvU2JUPTC3ew2PkhU1g7buNK4A7I0LN
	 FgBcY4aBLWRZw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3737d0920e6so8324721fa.1
        for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 01:21:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjylKC4wQpvtXfXADUhMxooLflwUCnwnOyjzKKjuTRHwFfHi4lvqcylcZJxcuxVpuO9b1+kqWY7EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFt8IS50g5E+XPVW49uLL1Orog2+TH51JQVB1ehLO0VpwdnVhT
	Df1a0LZuAoiOs8eM6Hee7gYQ1mnVaYRb/3qaqpcN2Eze0gdA8i+CncI+yKxQ/MRiq/zFyPWf6GS
	Zv2Ed0l2f5CQP0Z3lNysTcOpBUTDqNp4=
X-Google-Smtp-Source: AGHT+IGXuEQHrmcpO18jgiQje5gxecX+jQhPRhIZD8/umfhj/iVRHLDn4WDCLHjK5/dO5vBUN3lPnOpu+1uaOPX8hXA=
X-Received: by 2002:a05:6512:3a90:b0:579:f4b3:bd2d with SMTP id
 2adb3069b0e04-591d8591713mr8820336e87.57.1761207712093; Thu, 23 Oct 2025
 01:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
 <20251022114527.618908-1-adriana@arista.com> <20251022201953.GA206947-robh@kernel.org>
 <CAERbo5z6BzHqQxXdxPxmxE_eDR7GGGbt3A8kB0gQiWFBE-28Ug@mail.gmail.com>
In-Reply-To: <CAERbo5z6BzHqQxXdxPxmxE_eDR7GGGbt3A8kB0gQiWFBE-28Ug@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 23 Oct 2025 10:21:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGYinTKiyYhNYWJvoJeUJScCGnyq=ozLgjKAm7_wzG8QA@mail.gmail.com>
X-Gm-Features: AS18NWAyqpmDp3gFCmfLNnMi4KMri802uIuHk78GHsmKD8sw7K_d0CMpt3v68sU
Message-ID: <CAMj1kXGYinTKiyYhNYWJvoJeUJScCGnyq=ozLgjKAm7_wzG8QA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] DMI: Scan for DMI table from DTS info
To: Adriana Nicolae <adriana@arista.com>
Cc: Rob Herring <robh@kernel.org>, krzk@kernel.org, jdelvare@suse.com, 
	frowand.list@gmail.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, vasilykh@arista.com, arm.ebbr-discuss@arm.com, 
	boot-architecture@lists.linaro.org, linux-efi@vger.kernel.org, 
	uefi-discuss@lists.uefi.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Oct 2025 at 04:21, Adriana Nicolae <adriana@arista.com> wrote:
>
> On Wed, Oct 22, 2025 at 11:19=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
> >
> > On Wed, Oct 22, 2025 at 04:45:25AM -0700, adriana wrote:
> > > Some bootloaders like U-boot, particularly for the ARM architecture,
> > > provide SMBIOS/DMI tables at a specific memory address. However, thes=
e
> > > systems often do not boot using a full UEFI environment, which means =
the
> > > kernel's standard EFI DMI scanner cannot find these tables.
> >
> > I thought u-boot is a pretty complete UEFI implementation now. If
> > there's standard way for UEFI to provide this, then that's what we
> > should be using. I know supporting this has been discussed in context o=
f
> > EBBR spec, but no one involved in that has been CC'ed here.
>
> Regarding the use of UEFI, the non UEFI boot is used on Broadcom iProc wh=
ich
> boots initially into a Hardware Security Module which validates U-boot an=
d then
> loads it. This specific path does not utilize U-Boot's UEFI
> implementation or the
> standard UEFI boot services to pass tables like SMBIOS.
>

What prevents this HSM validated copy of u-boot from loading the kernel via=
 EFI?

> Because there's no UEFI configuration table available in this boot mode, =
we need
> an alternative mechanism to pass the SMBIOS table address to the kernel. =
The
> /chosen node seemed like the most straightforward way for the bootloader =
to
> communicate this non-discoverable information.
>
> I wasn't aware of the EBBR discussions covering this. I've added the
> boot-architecture and arm.ebbr-discuss lists to the Cc. If there's a pref=
erred
> EBBR-compliant way to handle this for non-UEFI boots, I'm happy to adapt
> the approach.
>

For the record, I don't see a huge problem with accepting SMBIOS
tables in this manner, but it would be better if a description of this
method was contributed to the DMTF spec, which currently states that
the only way to discover SMBIOS tables on non-x86 systems is via the
SMBIOS/SMBIOS3 EFI configuration tables. Doing so should prevent other
folks from inventing their own methods for their own vertically
integrated systems. (Other OSes exist, and from a boot arch PoV, we
try to avoid these Linux-only shortcuts)

However, the DT method should *only* be used when not booting via
UEFI, to avoid future surprises, and to ensure that existing OSes
(including older Linux) can always find the SMBIOS tables when booting
via UEFI.

Also, I would suggest to pull the entire entrypoint into DT, rather
than the address in memory of either/both entrypoint(s). Both just
carry some version fields, and the address of the actual SMBIOS data
in memory, and the only difference between SMBIOS and SMBIOS3 is the
size of the address field (32 vs 64 bits)

