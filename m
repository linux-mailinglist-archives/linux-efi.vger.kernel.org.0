Return-Path: <linux-efi+bounces-1343-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0285191D96C
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 09:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E311C21D57
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 07:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB22811FE;
	Mon,  1 Jul 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFSdvMRN"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117180C15;
	Mon,  1 Jul 2024 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820295; cv=none; b=fFbqBS4Z4P6d/3JeX9BoOS78WBAMa0N8caRQPYK2x21nODVW/1sSJ8aWSWTmpTS9DfGBFE7EGtwa3cWNWUl6x4IJXvEnWh4Ql3XZnMClVd9VOmENgpTlb4TUnODbd7w6c/yLipynTBuDcJz1umWcJnW+uczFXjfV9umoYfOdO+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820295; c=relaxed/simple;
	bh=w3AW7dJjexsKSTEgmpkSgb3wySS8bdBRSNdMI06WEck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaCmTUU3aOuqfkM3x5oDUic0Yj5MLBeZsKViw6ViV7/8oFxevuukz1K9MQsDNKSnrQ9led497NMBPErbOqihTMLDdnatR3gz8I7sxUDid4SbZMi/EbcHybvdrW8qwrtjUD60wHw6iIuvcCQL2PT1mYmb2vBalhgBUaFMT4wEtnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFSdvMRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79A2C4AF0C;
	Mon,  1 Jul 2024 07:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719820294;
	bh=w3AW7dJjexsKSTEgmpkSgb3wySS8bdBRSNdMI06WEck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LFSdvMRNNXbTZRlM0Lk4rPcHdPlw426EvmNJb4lIflF5FScv/MiIHMERGzjJZboe1
	 KruMPAcqSZ71wkXEvYpVO5oMpov2d7S0wmH5XwgKlQySfFH/Hl3P+8sRGLy8wd7MW2
	 jVc58LqPhIDdj+F5mh4svc35rVCxhLGX1We5RC3ydVURCda9HCqPi7Ecz650rPO/Qe
	 dUCqrKALhp6KEZxcRYDo2V4kzzBmV5fVgYSKlpq5OLeDMbNdyI8Otw8xc/vdZzx53v
	 f0DtzaMagbWVy3qtoT6/a/9TPdnECf/WR8ig8mPE87Bm+JgA0tt602Ief3jza3PcYd
	 KIdFzYoil27Tg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so27136911fa.3;
        Mon, 01 Jul 2024 00:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnI1uzTkBJeOsSiFWEzd2v2oKi1HZOy6Zl6WiFHSPS98rVL7sx21+9dK6XwSaIfyEUY8coblEFjA4uYEnJn/8EBry2RopjkjfTHbXkeZmUX/i74KME8rs/Y4rfqVK8zIxwVIbFE5KD
X-Gm-Message-State: AOJu0YxWbbhrgX6Y7QuTb1RdDTlFJw6lmVhArfqVgiVvp100meqHGBPh
	WX/eukJpnCHbRt89mPISqkCUeM56O3SiJU+13Iu2+tu7Z1v7GZMKEkKKJGVRhmmtoVG73LcWBFM
	FVoQZ8uudlv8pWiGiOWUn5jvEqWU=
X-Google-Smtp-Source: AGHT+IFdPX35Wske54n83HCpvKC4i4Mx4xBNDHqV0NdgRTla5v/JxTyd//0RbNOwf8ntwmVivFT3hrYY9i3v2YRmLp0=
X-Received: by 2002:a05:651c:2c8:b0:2ec:5488:da with SMTP id
 38308e7fff4ca-2ee5e6f2bd8mr27272391fa.40.1719820293131; Mon, 01 Jul 2024
 00:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de> <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de> <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
 <ZoJPgSlZJ3ZlU2zL@wunner.de> <CAMj1kXHR+mCR5eibj23S26-PN6yLPD1uf9+H2fEEDhNWOh6TjA@mail.gmail.com>
 <ZoJeVWMU8yg4CRLl@wunner.de>
In-Reply-To: <ZoJeVWMU8yg4CRLl@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 1 Jul 2024 09:51:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFRNrmyAtVaqHr+RWQ22+++u70eJ__brLjmJa0ocyc0Bw@mail.gmail.com>
Message-ID: <CAMj1kXFRNrmyAtVaqHr+RWQ22+++u70eJ__brLjmJa0ocyc0Bw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os protocol
To: Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <gargaditya08@live.com>, Hans de Goede <hdegoede@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Kerem Karabay <kekrby@gmail.com>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 09:44, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Jul 01, 2024 at 09:30:34AM +0200, Ard Biesheuvel wrote:
> > Assuming that Intel Macs implement the EFI SMBIOS protocol, reusing
> > the existing pieces should be rather straight-forward. Something like
> > the below should work in that case (whitespace damage courtesy of
> > gmail)
> >
> > Note that the smbios.c  libstub source file needs some changes to
> > build correctly for x86 with CONFIG_EFI_MIXED=y, but I can take care
> > of that.
>
> Orlando, Aditya, could you test Ard's patch with CONFIG_EFI_MIXED=n?
>

Yes, please test so we can check whether Intel Macs expose this
protocol in the first place.

Note that the following hunk is needed too:

diff --git a/drivers/firmware/efi/libstub/Makefile
b/drivers/firmware/efi/libstub/Makefile
index 06f0428a723c..1f32d6cf98d6 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -77,5 +77,5 @@
 lib-$(CONFIG_ARM)              += arm32-stub.o
 lib-$(CONFIG_ARM64)            += kaslr.o arm64.o arm64-stub.o smbios.o
-lib-$(CONFIG_X86)              += x86-stub.o
+lib-$(CONFIG_X86)              += x86-stub.o smbios.o
 lib-$(CONFIG_X86_64)           += x86-5lvl.o
 lib-$(CONFIG_RISCV)            += kaslr.o riscv.o riscv-stub.o

