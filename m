Return-Path: <linux-efi+bounces-5284-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD870C23FE6
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 10:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B4FD34A12D
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8632E136;
	Fri, 31 Oct 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCCyI58p"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41C32D44A
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901529; cv=none; b=bUKuX6cjNlMdzxAXnl+nsyBKPHV8UzfI1qlCUIRSV+S+G0OCEpaShUYEif9hsTcBVF/lO5aRfNq6iGZe9XE5QNoBXHkrMluTbO0V00M2vlj/qAH2y5O2/A48+iNuGbx28izJ/QIDhrei6CyHaGLvq6JCHwpuWX4zhAa7BGgOw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901529; c=relaxed/simple;
	bh=eTKgCRHXJ2ttsTcaNiE+n665NDkdon4ccb7z2QxZkLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9WzEJF1IBiJooLxxrKSLJepMvULEF7B+cEbMldwsBpUjDLsX9UgAJUxKNwFC++R/0C4I/dGvTu2V4B32UslFMoRz4nmChKZG6nEOTTNXvz7o3BrIe0BPGHInIld0n4/sdQAZ+3pd0QqIQpbW2b2GRuijVbIA7Rgzt6flNnD0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCCyI58p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F36AC4CEF1
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 09:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761901529;
	bh=eTKgCRHXJ2ttsTcaNiE+n665NDkdon4ccb7z2QxZkLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tCCyI58p4NXE9j2AYlOilbllj+ceXfrTCqgb319SHV43EG2At5MNkx76QzhYRkTII
	 Qxqx3anwIr//+EOyWZl/NuyKiai4fYT3+dYM2SSlga+vAeFOsbTXPSERs8QFVlX2E4
	 Lm8JGOJGuft7DlAZNHtjSV1ksZh0zzbNlfcUn+yIPghiCEU4jkeNa0j6avSGy3ms90
	 9dxTaxgUf5T2MzdvWLBh6bIHA0cpocjAq1srsxdd+nPEQdDKYUaOYbiXSdbLmYjcLB
	 jUtidO6dWRYROMG9rw33SgA8vFZbtrJKVd+4vXyMyDKgy7uHlYw6jtHwm9F++t/NpT
	 vIGEtwEoUKraQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5930f751531so2096040e87.3
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 02:05:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaXBYMiOVJRe/EZ3wmdD+Y4JgEKXw4shQCdbpE3737WPvQQH0P7LgRzpTY6V6ePkthtakxtLHXzGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4h1zENVQwgV6HLmGIbWwJZwnS/N136QzJ+mhlTGjuxcGzb8In
	LFy4aL5FhC8dApeYNzx1mPeco4nJd2xt7mtMU0whHGPHrwelS2fhYc0N1BGkQLlUXNxWvyr9PFS
	cpSF4o7gv1azbIyySLUszlQ+jCd2yi/Y=
X-Google-Smtp-Source: AGHT+IE7b83tXRjmclJn2avYmt6XtvERRHTx5LrGseWwdXtkY4M3M6KW2ebXYIVYmSbAzUGZb4o1I6v7gq5sYFVpZVk=
X-Received: by 2002:a05:6512:234c:b0:592:f8c0:c917 with SMTP id
 2adb3069b0e04-5941d50dd57mr1067998e87.10.1761901527758; Fri, 31 Oct 2025
 02:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022114527.618908-1-adriana@arista.com> <20251031084101.701159-1-adriana@arista.com>
 <20251031084101.701159-2-adriana@arista.com> <CAMj1kXG8hOMXzbbP2akJLB27hGJ_S28hcOL2c7k1uGA23hHUpA@mail.gmail.com>
In-Reply-To: <CAMj1kXG8hOMXzbbP2akJLB27hGJ_S28hcOL2c7k1uGA23hHUpA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 Oct 2025 10:05:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGykgmJey8SgGuKBC8DdwnfqYTiop9OMo1UbcRdw=4cNg@mail.gmail.com>
X-Gm-Features: AWmQ_blRWekdn2tndAk532XPWCtNvPNe5S6diOrP7TlzawjZdaa-VvWSFigqvUI
Message-ID: <CAMj1kXGykgmJey8SgGuKBC8DdwnfqYTiop9OMo1UbcRdw=4cNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: firmware: Add binding for SMBIOS
 /chosen properties
To: adriana <adriana@arista.com>
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, robh@kernel.org, 
	krzk@kernel.org, jdelvare@suse.com, frowand.list@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, vasilykh@arista.com, 
	arm.ebbr-discuss@arm.com, boot-architecture@lists.linaro.org, 
	linux-efi@vger.kernel.org, uefi-discuss@lists.uefi.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 09:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 31 Oct 2025 at 09:41, adriana <adriana@arista.com> wrote:
> >
> > From: Adriana Nicolae <adriana@arista.com>
> >
> > Signed-off-by: Adriana Nicolae <adriana@arista.com>
> > ---
> >  .../bindings/firmware/linux,smbios-table.yaml | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml b/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
> > new file mode 100644
> > index 000000000000..b78d8ec6025f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
> > @@ -0,0 +1,26 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2025 Arista Networks
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/firmware/linux,smbios-table.yaml#
>
> Should the file name reflect the property? I.e., linux,smbios3-table.yaml
>

And maybe the property should be called linux,smbios3-entrypoint?

Sorry for the bikeshedding but this will be set in stone as soon as we
deploy it so better to get it right the first time.

> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Memory location for SMBIOS table
> > +
> > +description: |
> > +  This property is used in the /chosen node to pass the physical address
> > +  of SMBIOS (System Management BIOS) or DMI (Desktop Management Interface)
> > +  tables from firmware to the kernel. This is typically used on non-EFI
> > +  platforms like ARM/ARM64.
> > +
>
> 'like ARM/ARM64' is both unnecessary and inaccurate, so better to drop it.
>
> > +maintainers:
> > +  - Adriana Nicolae <adriana@arista.com>
> > +  - Rob Herring <robh+dt@kernel.org>
> > +
> > +properties:
> > +  linux,smbios3-table:
> > +    $ref: /schemas/types.yaml#/definitions/uint64
> > +    description:
> > +      The 64-bit physical address of the SMBIOSv3 entry point structure.
> > +
> > +additionalProperties: true
> > --
> > 2.51.0
> >

