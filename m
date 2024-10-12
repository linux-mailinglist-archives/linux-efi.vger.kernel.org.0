Return-Path: <linux-efi+bounces-1943-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E2C99B518
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 15:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C58D1C212E5
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B0155A53;
	Sat, 12 Oct 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnloI4t2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15EE1E511;
	Sat, 12 Oct 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740181; cv=none; b=I6ThRP4Umq7HURo3i/ZPKGHtda9oVeBe4OHllMxlnJzxEKHN5pf/Q1SeQtC9VnjlN3eBmol3uXxXC0klO93TR0CQ2GkOLTbc0GxMfPq+XMTBB0LbFZJ3Q91EgDWuS1UHjgCaz8+T1yHJk962m3d91aPA+nfHkaeVIZuJaw05GAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740181; c=relaxed/simple;
	bh=TF1cpGxTnNgfwQ23rPidROlg26yiaLAxD22KOpMqiIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1cTdCEUJ+ibXL3yHlaGBhvh9Ez6GDzh2X7NVO0nAW7Snf0LF7VLGWXA3dcvK1rwegvzeJm8c0EdFfMytzoY05qGOTgyYQGvs1gIrbl+PfsWHjEKd59Q0BGJw52H0/+1iu7WhCthfk5ug+T/Ld4kfBrW5o9MQ+6dumCKS95Vng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnloI4t2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44650C4CEC6;
	Sat, 12 Oct 2024 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740181;
	bh=TF1cpGxTnNgfwQ23rPidROlg26yiaLAxD22KOpMqiIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PnloI4t2TBMn/AdlT65wGaaRuxOalZtnUk/AWAdw5YJ0d+BDIYJAU8H86NEWBRwMG
	 KJt5tujUhgQ55pJuZlTRdpY/Z2VJ3BPpjL5B6Txk/MHgbUeZFdrZepSckJ9RVwPEU8
	 7J0wfuM+hEIswp74CTy2DmkkOSAhd6yqc3FHK0ts+iEIVT6PYeWXPzJs0G46MU6S3T
	 kIZWwWVSK5gXnR9An5ateIbVYRVwyzCGa2t7Lxhoh+GkO6holw7l4CJENdeT1JVRgB
	 uq6vWFmFnaqs4ioX3luopCg/amJQrTc8uXOjfYhQo4R1CW2hWJCy7rS9/5ArkpoUqF
	 Dop//EReCofDg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e63c8678so549324e87.0;
        Sat, 12 Oct 2024 06:36:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW62zVWAG8R1o0Gsg3sYEhL8GT3tmeBbcdu2MQFqsdPDS5Glp0D3nXcGkgHZ1j9uvBJRo85XJ+gl9F4AnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpwdl14cUnIB+jHIKPYhSv7cn/95bVL3TiAW0QJfIDK1zVpfu0
	QpKXZT4msKVc2tKNHGngqUD7S7irNpLceYKdmrOwD9BHEGLlR6qoIaHZBhnCPIKGP3Iia/732VE
	/7oyiglQ9YxiMne1Otz0Ex/gGsrY=
X-Google-Smtp-Source: AGHT+IHPw1l7stJms9yUnkojoqkxKU2+GpIcpho97rcz2t/RFyqUl43xMCp7P6vUrIQV1VRAXWy25+Lnl0J5H1/aHKM=
X-Received: by 2002:a05:6512:39c7:b0:539:958a:8fb1 with SMTP id
 2adb3069b0e04-539e5730377mr971871e87.60.1728740179628; Sat, 12 Oct 2024
 06:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011224812.25763-1-jonathan@marek.ca> <20241011224812.25763-3-jonathan@marek.ca>
 <CAMj1kXHgFVs5Gt5hNao6DTZxqw4dO89OuUMH2tvdWPY1kxfc0Q@mail.gmail.com> <acdd3e0d-8ce4-264d-2328-05e7dc353817@marek.ca>
In-Reply-To: <acdd3e0d-8ce4-264d-2328-05e7dc353817@marek.ca>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 12 Oct 2024 15:36:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFe1ZYuR=45VhwMyHcZhSTQVwLrbZDWpgG7Zqw+Awws_A@mail.gmail.com>
Message-ID: <CAMj1kXFe1ZYuR=45VhwMyHcZhSTQVwLrbZDWpgG7Zqw+Awws_A@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi/libstub: consider CONFIG_CMDLINE for initrd= and
 dtb= options
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-efi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Oct 2024 at 14:04, Jonathan Marek <jonathan@marek.ca> wrote:
>
>
>
> On 10/12/24 3:54 AM, Ard Biesheuvel wrote:
> > On Sat, 12 Oct 2024 at 00:52, Jonathan Marek <jonathan@marek.ca> wrote:
> >>
> >> Replace cmdline with CONFIG_CMDLINE when it should be used instead of
> >> load_options.
> >>
> >> In the EXTEND case, it may be necessary to combine both CONFIG_CMDLINE and
> >> load_options. In that case, keep the old behavior and print a warning about
> >> the incorrect behavior.
> >>
> >
> > The core kernel has its own handling for EXTEND/FORCE, so while we
> > should parse it in the EFI stub to look for options that affect the
> > stub's own behavior, we should not copy it into the command line that
> > the stub provides to the core kernel.
> >
> > E.g., drivers/of/fdt.c takes the bootargs from the DT and combines
> > them with CONFIG_CMDLINE.
> >
> >
>
> I'm aware of that - the replacement the commit message is referring to
> is specifically for handle_cmdline_files() which this commit is modifying.
>

Ah ok - I missed that.

This is the kind of context that I'd expect in a cover letter, i.e.,
that the command line handling is inconsistent, and that we obtain the
command line from the loaded image twice.

Also, the fact the initrd= handling and dtb= are special, because
a) multiple initrd=  arguments are processed in order, and the files
concatenated,
b) the filenames are consumed as UTF-16 as they are plugged into the
file I/O protocols

> Currently efistub completely ignores initrd= and dtb= options provided
> through CONFIG_CMDLINE (handle_cmdline_files() only parses the EFI options)
>

Indeed. You haven't explained why this is a problem. initrd= and dtb=
contain references to files in the file system, and this does not seem
like something CONFIG_EXTEND was intended for.

> For the EXTEND case, I didn't implement the full solution because its
> more complex and EXTEND is not available on arm64 anyway, so I went with
> just printing a warning instead.

This code is shared between all architectures, so what arm64 does or
does not support is irrelevant.

Can you explain your use case please?

