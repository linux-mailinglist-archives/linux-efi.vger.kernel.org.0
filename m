Return-Path: <linux-efi+bounces-474-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0DC8494ED
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 08:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1998A1C21F35
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 07:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964510A2E;
	Mon,  5 Feb 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQBn57kr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03710A17;
	Mon,  5 Feb 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119956; cv=none; b=DD89YYLRYJPdmL54dmUgiq27Sj0f8HL1fyYrGxWtQMGYpW18/0Uns8LerJzOlb7GhpnFqir4HishF6tURbgFOYgjCyrlyuKVEHJUO2eZ2Na9q9FDpXcT8b7qvhjLIs96CxTt5HQUwehAVw9CHXULlBh+NCj3pNYPqr1O3rq9UNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119956; c=relaxed/simple;
	bh=cSw8mDWHjalYI52Rm+2AZgbXENZSTc0ja1Bi3Y3KWMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AniXIMJOtDbtev/BdDcbabYvGNLv4xfNUh2BUNwhUbnvhphmYrO7nhXJ2uP+FkHDx7Ckm6fxR3ODJ/dRPZW9palh8fWyr92G9OMD3DBJ3p2CtBvgR6x//khVjLZB7BSGbKKV0jTWRygX9Pn774+154Ziw1+DuwPhGXHsal5Bu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQBn57kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320C1C43390;
	Mon,  5 Feb 2024 07:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707119956;
	bh=cSw8mDWHjalYI52Rm+2AZgbXENZSTc0ja1Bi3Y3KWMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sQBn57krhMGaitEfAKDI0uoOG8KBlpr1v0zCM8oUbu8IXRs/15CA9gA/pYhznmkE3
	 7voTiRrEDtEhbxdyXLjLSWViOiAUrHg3ESXlVl92rKEG7Cc9mKwcvZerzap/F8i2P6
	 beRwJtoymfTz2wEYVKbbaHNJ9rYJV6bgSg0p++WRjbFaXZwqkgopDAVRGkMf/8Bujo
	 VgiIfaA1DRDYTc7DIA7jWctr6g1guGnm6N81kv2P/Az6x7j97V/SXjZoJxGqb3F3Tw
	 eMHetXwXzc1+aQsBZmlqqThytnIimERrxTPnyRZtxHfLqHhpAKV+Uk5IEKyicEIThZ
	 kpKwsElx1fTkQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51117bfd452so6844467e87.3;
        Sun, 04 Feb 2024 23:59:16 -0800 (PST)
X-Gm-Message-State: AOJu0YzEc8a5X49O1U7teycOFaf9/MoK9v1l2ssSd34nJY/NjiOgjuqF
	ZQstZQ9d9iNNi/1eH4j8XhUB4QUni2vz/U2OyQQ6Y5R6dX94MphkJ7TVle+3QQ6sB+xhUtZVKKg
	iHyY2oyOw9RI5LM6AhBgGWPzjsIg=
X-Google-Smtp-Source: AGHT+IGaUT0cbi7KEe0nJl3L7U2S562Yst+e/NVoEV3wV8JUunT6BvX8cFWlVQHiQnN8EWUxryYmOLkGDxoVP0bFLiE=
X-Received: by 2002:a2e:9081:0:b0:2cd:1366:4aa9 with SMTP id
 l1-20020a2e9081000000b002cd13664aa9mr5208270ljg.25.1707119954401; Sun, 04 Feb
 2024 23:59:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHzAAWQ6srV6LVNdmfbJhOwhBw5ZzxxZZ07aHt9oKkfYAdvuQQ@mail.gmail.com>
 <ZcBCiqOroolz1hoh@archie.me> <CAHzAAWQ2snWppQK_D3cSR6m35htVqM+4Su9f1JT9oWZ2A9Vznw@mail.gmail.com>
 <CAMj1kXFyVKRg0DTTrZGPGfVPxqY5zsXbK+Sxp0GBid-msqe46w@mail.gmail.com>
In-Reply-To: <CAMj1kXFyVKRg0DTTrZGPGfVPxqY5zsXbK+Sxp0GBid-msqe46w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 5 Feb 2024 08:59:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFTFjM3LjJk=M4ZcO7=vfFxSH2c_GPu3YpwByZkVknkcw@mail.gmail.com>
Message-ID: <CAMj1kXFTFjM3LjJk=M4ZcO7=vfFxSH2c_GPu3YpwByZkVknkcw@mail.gmail.com>
Subject: Re: Broken section alignment in 6.7 and 6.8rc EFI stub
To: Mike Beaton <mjsbeaton@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux EFI <linux-efi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ivan Hu <ivan.hu@canonical.com>, 
	Jeremy Kerr <jk@ozlabs.org>, Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 08:47, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 5 Feb 2024 at 08:37, Mike Beaton <mjsbeaton@gmail.com> wrote:
> >
> > On Mon, 5 Feb 2024 at 02:06, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > >
> > > So v6.7 onwards misses .reloc section, right?
> > >
> > > Confused...
> >
> > Reloc info is still present as normal in data directories, e.g.
> > `llvm-objdump -p` shows NumberOfRvaAndSizes = 6. Reloc info is taken
> > from index 5 https://github.com/tianocore/edk2/blob/master/MdePkg/Include/IndustryStandard/PeImage.h#L128
> > . (I've been told a dummy .reloc section was dumped recently?)
> >
>
> So there are a couple of things going on here:
> - the .reloc section was indeed dropped because we could not find any
> evidence anywhere that the reason it was added is still valid;
> - the .compat section uses a non-1:1 RVA mapping, to avoid padding,
> but reading the PE/COFF spec again, I suppose this is not compliant.
>
> Note that objdump looks broken too, on an image I have locally, I get
>
> (llvm-readelf -a)
>
>   Section {
>     Number: 2
>     Name: .compat (2E 63 6F 6D 70 61 74 00)
>     VirtualSize: 0x8
>     VirtualAddress: 0xB82000
>     RawDataSize: 4096
>     PointerToRawData: 0x4000
>
> (objdump -h)
>
>   1 .compat       00000008  0000000000b82000  0000000000b82000  00004000  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>
> So the .compat section is in the correct spot in the file view but not
> in the memory view.
>
> Given that the .setup section is not relevant to EFI boot anyway, we
> could try to use the same file mapping as the virtual mapping, and
> just split the content preceding .text across the .setup and .compat
> sections arbitrarily.
>
> Could you try the below?
>

OK, never mind - that violates the section alignment.

