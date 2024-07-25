Return-Path: <linux-efi+bounces-1492-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1D093C23A
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 14:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B242282CCB
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853FA185E6E;
	Thu, 25 Jul 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaYlcS3A"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E426281;
	Thu, 25 Jul 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911355; cv=none; b=KgfGPPmkTj+yMKwdJUYpP+lmHjoBi80Rq3q2lY6WE0aX+l7LeSQSwuJhWD1KrWXo1qTB5efxVCHPEF+VmS8WXpEIT7Kme2GAfBHnjMD6jjJHj5Cv0/o1AeiC7dvZLeLQSbYZlogY5AYlBzBu+07cd9qtr7yvITAEEdrf2ouvWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911355; c=relaxed/simple;
	bh=87zWLJqLUcaZ72R572yUdL60qC59nEPx4aBWVTGjVzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAvhq82KgTmtNYCZ/gG/TcbBygbcBjio7fBBRbd3YP6U9Sp8MvKWycATlOOJ0y1nF8h9OiEiSEAfXnGJx8WGzClN4xbeKWJ++DkoOP4H46HPbWX+HRqoEFgL+aX/hUDPd672tep/L95BTMvyDPp8Ti6IEdJnwoi3X2o+BhDTfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaYlcS3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA485C4AF0A;
	Thu, 25 Jul 2024 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721911355;
	bh=87zWLJqLUcaZ72R572yUdL60qC59nEPx4aBWVTGjVzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MaYlcS3AVW6ZUTYpNtsHYFLSEb6WNRiwg8wQjPO6qRTTfHoH7LGoKXnzCZKxxw0JB
	 bdXueHm6qRnedDUT0xXPCOEDTCVtiKzMd+XBX+k1+4Am8A8NXLhfkoIDfhyHl32w2g
	 Ez3awiv5lPjRlt8s2sXbzuBZcX1eiTsRUmStiaLUTQzFNzsy9HvDVLiVTnuAFdlPCS
	 asDYnFCudj8w69eZf1pBKEcPxVty6G1n6Co+Ya26Tm8G4KJER3fSYuACkTmLYlWybn
	 TRHCDnCp50NC0wY4WOLRR2tgF1MKZZKaY4SQnl8tPr8Tv2+IkljULAtp52wGShBwnq
	 p885LaUwLbRSg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so260003e87.0;
        Thu, 25 Jul 2024 05:42:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7bH8PLWhkjl0imHzfcC5omJ25NgpDzyE1ii+kQ2hUEYma3z7tj0KxDFCyhfa8VHINGmDRBraXLud2ZnzeHCLX8FLUK9aUSpfVkT2wmgK8lpt+/vAe8tDU1IUYE4TrTbflaNxk2jH7
X-Gm-Message-State: AOJu0YwEAgoev6rOoG7rBY5BeB1TGDxIFQ7M7EJwirQUyAAQMm0qTueP
	U5LnLpCUT3bSPjov6PE6Nqk0QeWfQpflMPTpiR3Fx2o3QwcW1CR6SBQBkdC2qWDvWPSSCMW6d9b
	xKcXJ08srAgiW69yNWZ2PjxSszeA=
X-Google-Smtp-Source: AGHT+IFm1ATFaDokRieHZrD3ZfARhXsvkGg+nDTJLcbwGXGLQB6lgqzI2vtoBfIWXQfpFtsOKesaJEsrHKS01x1B+4g=
X-Received: by 2002:a05:6512:224e:b0:52e:8071:e89d with SMTP id
 2adb3069b0e04-52fd608395amr1892550e87.40.1721911353287; Thu, 25 Jul 2024
 05:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701140940.2340297-4-ardb+git@google.com> <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de> <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqElRH38f_XV3fKK@wunner.de> <MA0P287MB021789D73CAD62C16BCF0306B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqEsdkVvwsq-CgeB@wunner.de>
In-Reply-To: <ZqEsdkVvwsq-CgeB@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 25 Jul 2024 14:42:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFRbncyRRxMKAbZDzZDFNSzm3Xq0CU918iXiPEZfkTmYA@mail.gmail.com>
Message-ID: <CAMj1kXFRbncyRRxMKAbZDzZDFNSzm3Xq0CU918iXiPEZfkTmYA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
To: Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <gargaditya08@live.com>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Kerem Karabay <kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>, 
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 18:31, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, Jul 24, 2024 at 04:26:58PM +0000, Aditya Garg wrote:
> > > On 24 Jul 2024, at 9:31 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > I note that on x86, the efistub walks over all PCI devices in the system
> > > (see setup_efi_pci() in drivers/firmware/efi/libstub/x86-stub.c) and
> > > retrieves the Device ID and Vendor ID.  We could additionally retrieve
> > > the Class Code and count the number of GPUs in the system by checking
> > > whether the Class Code matches PCI_BASE_CLASS_DISPLAY.  If there's
> > > at least 2 GPUs in the system, invoke apple_set_os.
> >
> > This also looks like a good idea, but I'm not well aware of the pci
> > quirks in the Linux kernel. So, would consider it a bug report for
> > the maintainers to fix.
>
> This is not a PCI quirk in the kernel.  The efistub is a separate
> program.  I'm saying that the efistub already walks over all PCI devices,
> it would be trivial to hook into this to count GPUs, recognize the T2
> device or do something else entirely.
>

Thanks for the analysis, and for the suggestions.

I wouldn't object to changes to the EFI stub that implement something
along these lines, although I'd like to understand a bit better what
the actual issue is.

If PCI resource allocation is the culprit here, wouldn't it be better
to force Linux to reallocate those from scratch? IIRC there is already
a command line option for this.

