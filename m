Return-Path: <linux-efi+bounces-1037-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED558C6BA1
	for <lists+linux-efi@lfdr.de>; Wed, 15 May 2024 19:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48451B24002
	for <lists+linux-efi@lfdr.de>; Wed, 15 May 2024 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D843AD4;
	Wed, 15 May 2024 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxvPnn0P"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927928680;
	Wed, 15 May 2024 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794983; cv=none; b=XbpCFIY46vw26LRLEG279XMGl8IwVNwX10sTuPIH8zv/voVJktjrOf1L2/0MlQqvcRGqmaf/MljLoQSqGDYB9RWzXdeQeB73oR6vzsJNFaTJNWZgU1XjnyRrGb9Y6GFam5yzL8K2EVa73hLKeZ4tcuCE3ZexvapbEO2EwlCW36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794983; c=relaxed/simple;
	bh=+2jezA4tzmackJBF0Q+owMmDvh4B99B+iW1Z69bVj6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIUbL5M9e5+8KQ/DCvV+rgnTE5/Or+BSVnj54Y78FEXdycBDw+B0Iiutka0/egApUM7u9O7plTas+0ZGcBZe88m+sNCba1ytuB8nhFLvt2pOZ6tiH8ARQYjBLshzYhlJMDWRkykt6pyzIEdjxzoH/e7vA1gAnbdP2/gxNiFvLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxvPnn0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9EBC32781;
	Wed, 15 May 2024 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715794982;
	bh=+2jezA4tzmackJBF0Q+owMmDvh4B99B+iW1Z69bVj6w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nxvPnn0PS27/q0qKZr1ddhC9LXUdOUl+SWOd1aGrGurKTFz6ODBnMNkKe8Ok4J21y
	 bD/L0by2HC6wh6DAbOdz7oldAIIc9X72Cbh9pu0vqNdE2+udJ3d7agzDvVOsY6BmfH
	 rPEDy2CRpO4hJQaCiCk1qRICcyjoCwL7UPZ3tIXmuim3MtR8mA6VPFOVFnPqukGklB
	 Rbdrz4wX2yxhIRzd719vYk4y9p8AmuxS3prAgs0uHh5s7fCajAwdDX6xpC1y7fsWNJ
	 3FRdflX8oyqZpV++1WYj3OofKWpDIrI2gMM/+pI3G/WSvp8OXV4/RxCoaFaP37YJ8w
	 A04G/KoKPRMbQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f1bf83f06so9018732e87.1;
        Wed, 15 May 2024 10:43:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJDwUq3DOuMC+RnnOvKN2xqMzsrB3EHqiKieRqlLePNZXcRjRGmeaFRDq6aYUZxefyC3XajBpz0Hl7Sfo4dJcUB2EjQdFKB9AFbFNcW2jOWkGrklpbtp3G6p/+OEeI9p8a5gGfViBVB1IBU5iqXh3tTQelh3KBiNL8iTAQeK/a
X-Gm-Message-State: AOJu0YwLtb5rYbHHbTvCrXYcU+Ha0eACsU7fQ4yVYpOhE1TFDYgMZMnM
	pisKRS/sYZ2vFcekN+sQg5XPRySrx2H/r9vfPXQpe0k/gKJnUtbsNFpyjqzMe4r/pBerboXgaw8
	Azhyu9YlUdJcLtCPJoecwmZMmdJg=
X-Google-Smtp-Source: AGHT+IG3JT/3EHxo6OFaMXZ0gQCWCAhBcDpT+zlsqflYcTKqqQvfS9Ucv/AtAQ4sOeWbWtvrJiUZwbPxKfVK9WarPTI=
X-Received: by 2002:a05:6512:2356:b0:519:6953:2ffc with SMTP id
 2adb3069b0e04-5221007027amr12979190e87.42.1715794980678; Wed, 15 May 2024
 10:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FA5F6719-8824-4B04-803E-82990E65E627@akamai.com>
In-Reply-To: <FA5F6719-8824-4B04-803E-82990E65E627@akamai.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 15 May 2024 19:42:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE2ZvaKout=nSfv08Hn5yvf8SRGhQeTikZcUeQOmyDgnw@mail.gmail.com>
Message-ID: <CAMj1kXE2ZvaKout=nSfv08Hn5yvf8SRGhQeTikZcUeQOmyDgnw@mail.gmail.com>
Subject: Re: Regression in 6.1.81: Missing memory in pmem device
To: "Chaney, Ben" <bchaney@akamai.com>, Kees Cook <keescook@chromium.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tottenham, Max" <mtottenh@akamai.com>, 
	"Hunt, Joshua" <johunt@akamai.com>, "Galaxy, Michael" <mgalaxy@akamai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(cc Kees)

On Wed, 15 May 2024 at 19:32, Chaney, Ben <bchaney@akamai.com> wrote:
>
> Hello,
>                 I encountered an issue when upgrading to 6.1.89 from 6.1.=
77. This upgrade caused a breakage in emulated persistent memory. Significa=
nt amounts of memory are missing from a pmem device:
>
> fdisk -l /dev/pmem*
> Disk /dev/pmem0: 355.9 GiB, 382117871616 bytes, 746323968 sectors
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 4096 bytes
> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
>
> Disk /dev/pmem1: 25.38 GiB, 27246198784 bytes, 53215232 sectors
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 4096 bytes
> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
>
>         The memmap parameter that created these pmem devices is =E2=80=9C=
memmap=3D364416M!28672M,367488M!419840M=E2=80=9D, which should cause a much=
 larger amount of memory to be allocated to /dev/pmem1. The amount of missi=
ng memory and the device it is missing from is randomized on each reboot. T=
here is some amount of memory missing in almost all cases, but not 100% of =
the time. Notably, the memory that is missing from these devices is not rec=
laimed by the system for general use. This system in question has 768GB of =
memory split evenly across two NUMA nodes.
>
>         When the error occurs, there are also the following error message=
s showing up in dmesg:
>
> [    5.318317] nd_pmem namespace1.0: [mem 0x5c2042c000-0x5ff7ffffff flags=
 0x200] misaligned, unable to map
> [    5.335073] nd_pmem: probe of namespace1.0 failed with error -95
>
>         Bisection implicates 2dfaeac3f38e4e550d215204eedd97a061fdc118 as =
the patch that first caused the issue. I believe the cause of the issue is =
that the EFI stub is randomizing the location of the decompressed kernel wi=
thout accounting for the memory map, and it is clobbering some of the memor=
y that has been reserved for pmem.
>

Does using 'nokaslr' on the kernel command line work around this?

I think in this particular case, we could just disable physical KASLR
(but retain virtual KASLR) if memmap=3D appears on the kernel command
line, on the basis that emulated persistent memory is somewhat of a
niche use case, and physical KASLR is not as important as virtual
KASLR (which shouldn't be implicated in this).

