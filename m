Return-Path: <linux-efi+bounces-1264-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A529911D2B
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 09:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0BE282BDA
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 07:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA7716C863;
	Fri, 21 Jun 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMgVm1Xc"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0DA168C3A;
	Fri, 21 Jun 2024 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955929; cv=none; b=hSLIkOFEgycWfagzhRgwvadSBMUw5/PoDZiAKJgaTUPtbZ15K9nXxBnxxdpcQNFS2Z3EtLnPKUarusd0JVPF0POCXme98yU3jD+TBgOphGDPSRRA0r6/DTkDj8uFo993NvsAXhiLT9sqkGZvGSvaEMq5M4xrRbAgngiwlX4PbwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955929; c=relaxed/simple;
	bh=wog2iUWM/qimT1RRK3hiIlEBaTswqxfhQbhaB07axCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h034ExPMPD3MdDcDJ0JQevBoAoR3zxL3Gg04HrbM+Ia5E6QLDzugWT8bSxNvvWmSIFey4AOXiMPNFd/WaRvK7XoCLtORWvSIsNiPMMmsUdO6A2XedU9/WfKG75T1uQNQ+7wE99pObUtmrU4xXnEHaXuKL6saBJn1SW6Y+C2oW58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMgVm1Xc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77116C4AF0B;
	Fri, 21 Jun 2024 07:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718955929;
	bh=wog2iUWM/qimT1RRK3hiIlEBaTswqxfhQbhaB07axCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YMgVm1XcChN4/kMllhDGJV4AqXbxc4KGdFUGmJUUd1S3Xz+PrQb92Genvz8fEEGe/
	 FNVV7Jk7fiuCHX14NfMaeHgRVbS36+/l0V22peZKXs3amrm7sWuTWJvUJLdHdGCTfh
	 tyPi6z3kIlDDoWGtA6S0Fn6WeYxKDC8yW2BfGXETG7ME/XFJdjiDM2z2yNxN74zDth
	 RIEJreijbEn9wF6C7qRwqmVbgkYteOXs/y6g6CjvXAk1HcFFRjagCcK5lWbv7PFQ11
	 44JW8IqNp4P3hz5mSsOfOgxDJ9WjlRDJdQougVFXPMhckb+9dNFWjyYORamrhFJ+vH
	 nv5pefkCwPIeg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cd790645eso266907e87.3;
        Fri, 21 Jun 2024 00:45:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/7PLUzXvPdVXOJ81nCOAP9Ck78rNratYJL1UJTm2aWMAKhX3ED25hwMLXr7OQL8DErdFImBu2GfSj0v8HbBRd1xbXUfd42v/WeE99sCpgE6RaEUzLachIfyMCraI9v3fKBdqxTmK1Mg/N1RMo3q3J2KbPY+7PKPCJk1d0GskseR7yBQQt9Hh1EYcJR+ikVaG22E+49NXwrQDcyNxGiDk=
X-Gm-Message-State: AOJu0Yw87p6btHCkKffsvM54sXSe5DzIeu3gBNvPU48bikuosyjBG9xT
	puSG53yvvliSrmh6lTyIprbjv9228I3r1os5aG2LsEzkN50O/3GiOTRTXqRr69lVOCDrk8imVRb
	W4RFKW0w0S0ThTI1XuNXG39odU0U=
X-Google-Smtp-Source: AGHT+IE6GlXDE8Jy7yn5BXmfM6GwFGTVmZLmcHiygxSGEZeVb/H9dk59MnuHJMsC0SqxIJ4t78vZzyQi3VVq2wqVR2k=
X-Received: by 2002:ac2:5f96:0:b0:52c:785f:8fd9 with SMTP id
 2adb3069b0e04-52ccaa558fcmr4232084e87.10.1718955927704; Fri, 21 Jun 2024
 00:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718906288.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1718906288.git.mchehab+huawei@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Jun 2024 09:45:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHsyAhmV9K__pRh8cYJy-ed2-s5VLDE4GwMqNajvJE46w@mail.gmail.com>
Message-ID: <CAMj1kXHsyAhmV9K__pRh8cYJy-ed2-s5VLDE4GwMqNajvJE46w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Fix CPER issues related to UEFI 2.9A Errata
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 20:01, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The UEFI 2.9A errata makes clear how ARM processor type encoding should
> be done: it is meant to be equal to Generic processor, using a bitmask.
>
> The current code assumes, for both generic and ARM processor types
> that this is an integer, which is an incorrect assumption.
>
> Fix it. While here, also fix a compilation issue when using W=1.
>
> After the change, Kernel will properly decode receiving two errors at the same
> message, as defined at UEFI spec:
>
> [   75.282430] Memory failure: 0x5cdfd: recovery action for free buddy page: Recovered
> [   94.973081] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> [   94.973770] {2}[Hardware Error]: event severity: recoverable
> [   94.974334] {2}[Hardware Error]:  Error 0, type: recoverable
> [   94.974962] {2}[Hardware Error]:   section_type: ARM processor error
> [   94.975586] {2}[Hardware Error]:   MIDR: 0x000000000000cd24
> [   94.976202] {2}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x000000000000ab12
> [   94.977011] {2}[Hardware Error]:   error affinity level: 2
> [   94.977593] {2}[Hardware Error]:   running state: 0x1
> [   94.978135] {2}[Hardware Error]:   Power State Coordination Interface state: 4660
> [   94.978884] {2}[Hardware Error]:   Error info structure 0:
> [   94.979463] {2}[Hardware Error]:   num errors: 3
> [   94.979971] {2}[Hardware Error]:    first error captured
> [   94.980523] {2}[Hardware Error]:    propagated error captured
> [   94.981110] {2}[Hardware Error]:    overflow occurred, error info is incomplete
> [   94.981893] {2}[Hardware Error]:    error_type: 0x0006: cache error|TLB error
> [   94.982606] {2}[Hardware Error]:    error_info: 0x000000000091000f
> [   94.983249] {2}[Hardware Error]:     transaction type: Data Access
> [   94.983891] {2}[Hardware Error]:     cache error, operation type: Data write
> [   94.984559] {2}[Hardware Error]:     TLB error, operation type: Data write
> [   94.985215] {2}[Hardware Error]:     cache level: 2
> [   94.985749] {2}[Hardware Error]:     TLB level: 2
> [   94.986277] {2}[Hardware Error]:     processor context not corrupted
>
> And the error code is properly decoded according with table N.17 from UEFI 2.10
> spec:
>
>         [   94.981893] {2}[Hardware Error]:    error_type: 0x0006: cache error|TLB error
>
> Mauro Carvalho Chehab (3):
>   efi/cper: Adjust infopfx size to accept an extra space
>   efi/cper: Add a new helper function to print bitmasks
>   efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
>

Hello Mauro,

How this is v4 different from the preceding 3 revisions that you sent
over the past 2 days?

I would expect an experienced maintainer like yourself to be familiar
with the common practice here: please leave some time between sending
revisions so people can take a look. And if there is a pressing need
to deviate from this rule, at least put an explanation in the commit
log of how the series differs from the preceding one.

Thanks,
Ard.

