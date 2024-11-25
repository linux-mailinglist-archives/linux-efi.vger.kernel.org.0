Return-Path: <linux-efi+bounces-2205-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5079D8BAA
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E0EBB237EC
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 17:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00301B415A;
	Mon, 25 Nov 2024 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1GdwETX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4D41C92;
	Mon, 25 Nov 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557208; cv=none; b=VO7EdncpNqcZ02ApyTF7CTGgkQ2aG24PuexrLxZFDgPGFmruNdfLK6hG5EcBWp/OOxUCuJF2azjq5umcB/NQbD0lNHY5kpm5j0wnUiVGZxCuyML25LVf+lKfii5vN26ltaBqvvCyYaPQnEXyrU4pIfQagSGkGvNDlu1wXMRUtek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557208; c=relaxed/simple;
	bh=Sy85kf3vcC34kSnYFUkbxzk6hppjvfyhk9EOtB98BRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9/bSFCe9XzJaWuswZF06YkHDIvSou+yWVSLxUacaWI7ZKc4s0Pdp4c1z72KEBh6KxCrW9I4QdB4rxHq/RDMiSIBP6/PXKADvALJv8DBtYe/66XA7RvS1in1MC74SprGzegpI1yTEW+GV+m7aqkGRH0rzq10ksitjc0HHtStrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1GdwETX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2C9C4CECE;
	Mon, 25 Nov 2024 17:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732557206;
	bh=Sy85kf3vcC34kSnYFUkbxzk6hppjvfyhk9EOtB98BRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K1GdwETXZNvu7Zbuh0jWSBrXqxRg9qF8odzr6B98um053N8lDx5269wpk2/udcf0f
	 jQMVR5DX3UNXws5aHNY+WW3vWJpHwtMRe6SyutsbNodcuWMX4VyOfZqfddv8N6XyXH
	 AjCeh+TffRKNaq2fgP9Qb1lefC+ho6CMwp/As9BGp0NeUD/mc9eeUDWRYeSRU3+ieZ
	 kuL7xTlYKAirRFwD4PAa+PNEmDC0vTHKwZYNy9I1XD6FDGnZLQEhJRLDitO+5zKT7h
	 K9UQ8CcaZAxgwoKwcLe0XPXZXGXxDB61vA+Mbdeyor2Z8Oa0XDCPCy2NE/cFZxVc2x
	 u614aGFNtItQQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffc1f72a5bso13919911fa.1;
        Mon, 25 Nov 2024 09:53:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8orN/CHdkKtV33MFdLrY53ehaeA+N4xVst22uw6hbk6bqQSEuCK/QNDlp9z0WQ41+UN5B6v0RTkPFWJy3@vger.kernel.org, AJvYcCXk/IIXppDC+Jr+oDfS6Hy9ZIDeLqHexX2kiXK38DoGpL9f4dqjyxg9lUOUL1ANDmX5OO2qikc+B0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGNivP49LbNpq1Ih6SX6NLipUwKBD1s2MGefWjZpusu7OlRH/G
	Y5HazVKLDKn6hjA1hAOkNyQgTtC4jCPi9jT6Qvfvp4z3xgbOCpd8cUrhfCiXqzrb9HmfAZBmHuB
	PN5SmO8lDK9RjFQk/i52pgFfyJlM=
X-Google-Smtp-Source: AGHT+IErTOjhBpAu53njDQQIpCJYn5/RbRSbWCA8X67r2W2Xsb5NbVmoZQeuB8i563OKA0Jfwogv9HqgM6n2g9Vol8c=
X-Received: by 2002:a05:651c:199e:b0:2ff:b3f0:68d9 with SMTP id
 38308e7fff4ca-2ffcc281ea0mr1089891fa.3.1732557205067; Mon, 25 Nov 2024
 09:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125170758.518943-1-yeoreum.yun@arm.com> <20241125170758.518943-3-yeoreum.yun@arm.com>
 <CAMj1kXG4A4h3=bZC6kSrwsZa7p4RZ-uN5N67pZUFLOQ2RJE64w@mail.gmail.com> <Z0S3wiugr0JML/cV@e129823.arm.com>
In-Reply-To: <Z0S3wiugr0JML/cV@e129823.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 25 Nov 2024 18:53:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFOdGaYiVWOyFEK+Lz97YdzAu+AWj5trZBTL+Xc_DXnmA@mail.gmail.com>
Message-ID: <CAMj1kXFOdGaYiVWOyFEK+Lz97YdzAu+AWj5trZBTL+Xc_DXnmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/fdt: ignore dtb when acpi option is used with force
To: Levi Yun <yeoreum.yun@arm.com>
Cc: broonie@kernel.org, sami.mujawar@arm.com, sudeep.holla@arm.com, 
	pierre.gondois@arm.com, hagarhem@amazon.com, catalin.marinas@arm.com, 
	will@kernel.org, guohanjun@huawei.com, Jonathan.Cameron@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 18:46, Levi Yun <yeoreum.yun@arm.com> wrote:
>
> Hi Ard.
>
> > I take it this is working around buggy firmware that passes both a DT
> > and ACPI tables, and the DT in question is broken?
> >
> > If so, this should be fixed in the firmware. The EFI stub does not
> > reason at all about ACPI boot vs DT boot, and I would prefer to keep
> > it that way, especially because this code is shared with other
> > architectures. For instance, the meaning of acpi= could differ between
> > architectures, or they may not implement ACPI in the first place.
>
> What I concern is that It doesntt necessary to check DT
> otherwise if the FDT variable in variable storage's contents is
> corrupted, it would complain while it check in early_init_dt_scan()
> thou the dt isn't used in boot process.
>

The DT is not stored in a variable.

If CONFIG_EFI_ARMSTUB_DTB_LOADER is enabled, it may be provided via
dtb= on the command line, but I have little sympathy for a user that
passes both dtb= *and* acpi=force, so this is a scenario that we can
ignore.

Otherwise, it is taken from a EFI config table, which is just a
<guid,addr> tuple describing a location in physical memory where the
firmware has placed a DT. If the firmware puts a corrupted DT there,
the firmware should be fixed instead.

acpi=force is intended to force the use of ACPI tables on a system
that provides both.

> also, although acpi= could differ from architecture, the force option's menaing
> seems the same over architecture (ignore DT boot with ACPI tables).
>
> So I think the check the "acpi=force" option to prevent loading DT seems
> good.
>

The EFI stub does not care about ACPI vs DT boot, and I'd prefer to
keep it that way unless there is a good reason.

Which real-world problem does this patch aim to solve?

