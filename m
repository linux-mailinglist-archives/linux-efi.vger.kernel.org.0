Return-Path: <linux-efi+bounces-1332-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256D891D74F
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 07:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9081B20B11
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 05:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C4F224DC;
	Mon,  1 Jul 2024 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWeEG5Z2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C27A17C61;
	Mon,  1 Jul 2024 05:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719810695; cv=none; b=GI1GdOaORRo1K63NFcvvyQTtfBFlmLvSyKuK5nEEF3A8/tolD2f6esARQZF45pH/NwKS6+41erKIfMM/2DTq67Lff92QyEAB6huQ85Q2pQRqtFitJcWP24nXrkVfy3R98LOy7UdWeW1snUVVkqllJgyJe/aeO5Ln5D50WhsDM5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719810695; c=relaxed/simple;
	bh=/xu6j3mzqMxyt5btghD36ts3zTipK1aGMS2i3uL+PWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzSNn71Z/sJ/a6F8zTWCmvcjKbCh735LKzpO8wcKQokOlDOvxZIKOLXJ752lzZQzQ/kZns4jiqGs4Py5iFtM+MYFm3Q2cTmLerAQmuuSlWQCIFuS3jR710RCjfZkiCuYWfyud9uUxrTg/0M3lj4k+E5nKltRmTE3TcMBUfD1qH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWeEG5Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1044C4AF0E;
	Mon,  1 Jul 2024 05:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719810694;
	bh=/xu6j3mzqMxyt5btghD36ts3zTipK1aGMS2i3uL+PWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eWeEG5Z2eL3gJVhqW4496zBJQSEW7A3jtOblVBN25VuzMlJRdS6Bj0qcHWEa4ZGWm
	 OniUzn4kI3nwFoA3EUjNsnjNIa8YhBAQehPuIyH0G0RsdmXdrWakgbpQOlZ9sassTZ
	 5d3PCFUcG8UBoiWXghUT0aimSDFY6nZjSJSQ5oIurGZor620yRGnBz7JZ9hggFYGPM
	 Myy58jhVwI41kHpMi6otKUf41dfTuuBU05rnKWKkep7XytNYyFbVAh6Ru6VBxWTmwe
	 hfrs+REbVrHXh3RnIQqa1YvMYtGMPxbk482Ulyt3XuvSPFJVA8HyHlK7p+/VEZoCph
	 F55UjEZMHLJQA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec59193468so20720921fa.1;
        Sun, 30 Jun 2024 22:11:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5GF7zAVc4K+kne4QUr5igXBllPnf1uz8maehx7Yk6eTUAg6/OhnPaF14qTgBLVeFNQpSIHI1TMmdFWjF9TMlqjJyrIDK+3pjTxAH6GkvClmYpsie944HRp5rK2bhl6fRbOa+e77K7
X-Gm-Message-State: AOJu0YwlV9vpkmXn2KE81zqrObOISZPQ41LM9Sw5WDChnX+e3eiPGCjc
	v7nQxiHNv8qn63ofXfwyFNsJ16XFTRgv8cLhKWjbk4J4NefjMxrbJBd2F8Q3aJcenlZIunaSd5C
	c78uQZZbc/7gv6B0YrafcYmvou/M=
X-Google-Smtp-Source: AGHT+IHx98RloeGcgZXJescxkH/qiEue+hEQSGzRXj+bZiMFYS37FwdPAUkewrHUBw2iodsw9bJI2DJbMzJ3ExBFPn0=
X-Received: by 2002:a2e:a484:0:b0:2ec:5f11:4f6b with SMTP id
 38308e7fff4ca-2ee5e37fa82mr11324111fa.10.1719810693008; Sun, 30 Jun 2024
 22:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com> <CADfWnbbWDgYe6g_CkEmpwAMfZf2kWLE5khB0GSfhojfvDFu5sA@mail.gmail.com>
In-Reply-To: <CADfWnbbWDgYe6g_CkEmpwAMfZf2kWLE5khB0GSfhojfvDFu5sA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 1 Jul 2024 07:11:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFuKstumJnygLi_hhu+6OrtjrPEX+SX=GELrU4sthAV7A@mail.gmail.com>
Message-ID: <CAMj1kXFuKstumJnygLi_hhu+6OrtjrPEX+SX=GELrU4sthAV7A@mail.gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os protocol
To: Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc: Aditya Garg <gargaditya08@live.com>, Hans de Goede <hdegoede@redhat.com>, 
	Lukas Wunner <lukas@wunner.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Kerem Karabay <kekrby@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 06:46, Orlando Chamberlain
<orlandoch.dev@gmail.com> wrote:
>
>
> On Mon, 1 Jul 2024 at 05:24, Aditya Garg <gargaditya08@live.com> wrote:
> >
> > From: Aditya Garg <gargaditya08@live.com>
> >
> > 0c18184de990 ("platform/x86: apple-gmux: support MMIO gmux on T2 Macs")
> > brought support for T2 Macs in apple-gmux. But in order to use dual GPU,
> > the integrated GPU has to be enabled. On such dual GPU EFI Macs, the EFI
> > stub needs to report that it is booting macOS in order to prevent the
> > firmware from disabling the iGPU.
> >
> > This patch is also applicable for some non T2 Intel Macs.
> >
> > Based on this patch for GRUB by Andreas Heider <andreas@heider.io>:
> > https://lists.gnu.org/archive/html/grub-devel/2013-12/msg00442.html
> >
> > Credits also goto Kerem Karabay <kekrby@gmail.com> for helping porting
> > the patch to the Linux kernel.
> >
> > Signed-off-by: Aditya Garg <gargaditya08@live.com>

> I've checked that this patch works for me when applied to 6.10-rc6.
> I can also use https://github.com/0xbb/gpu-switch to make the boot gpu
> the iGPU now.
>
> Tested-By: Orlando Chamberlain <orlandoch.dev@gmail.com> (MacBookPro16,1)
>

Thanks.

Is there any point to making this set_os() call if CONFIG_APPLE_GMUX
is not enabled?

