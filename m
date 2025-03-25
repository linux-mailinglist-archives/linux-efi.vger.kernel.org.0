Return-Path: <linux-efi+bounces-3082-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A2A7040A
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 15:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C2D3ACBBB
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D225A35D;
	Tue, 25 Mar 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCFBymxF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41B25A62C
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913574; cv=none; b=q4URjrbXjtHulru0pxvDxcSYCO1mG91EA1SaZsTCUxsaJ28mvQxZofyWHY1tEj80CWOG3joChtQ1KqnoFgaUYsnFk1eqvgyh7TohM+wbrMX6myWlsaBvoqJLJFOKcv3QMFO3LZXwN7+xus1mLQjjbTCuV4qRJ7B103p8qFB0WTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913574; c=relaxed/simple;
	bh=KVA2dd4ciwmrrGt2z7Y9LUOZ8VR+A+g0jNFDnopbRfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWNIBlncw+0Cq33PdFx0VaPYamKUcfFPrRfXi0qTiCjp/G/RJs0MSS9iX4MQgVxSTcai0rreVerixQY31zHdM2akuwFL8TT/d1mXIBlAm1T1ppvAC7IoR9PdcTpqCnla2EDnuqsr3K3Q2qH/UMVR4TAIHCaGcAmQsEQ2imu1Vvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCFBymxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8DDC4CEEA
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742913574;
	bh=KVA2dd4ciwmrrGt2z7Y9LUOZ8VR+A+g0jNFDnopbRfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uCFBymxFMlzvNl89wSL39ZR30U5SrMLqWpfsZbb8kUToAqEqXLhv8xoA19bigtvvu
	 eNLebU0JZFbhvhZMlDnpAokkJNdg9+dgx6I5Oz8Ha4Q/MLT2N1DfCMutnpIq6Sun4G
	 9Qykc9ImiG16TIKGBcG2W2GMLyGvsRAMO6w+UD+dtdsCv7Gyh9iXnXwa4bsFxCA4CC
	 CtxOJhhyrtM4oxoI/q1+R66Wc6yWCPfOZoQP58kMB5I5L59DoYSx9p8qyJbegp5ptK
	 52ryjgc8pLRG7Ba3YDkjZfNUNNYqh7+7RKPxYgTu061qLDEBn0WxR9d3L/9Bg296hU
	 xC4EsBw2f50yw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so57538901fa.1
        for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 07:39:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJ8dxYjWJ/dh3r40Y2Yq6Sw3jVG+wftZGm4VbQR89R6SasjkvTeCVmWLWT1eCMjP72ZeBi6+mOqIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8kAbmeBbNc0Xe79ZZrMx7oDwROr1BOXw1NBQ9I9vkMhCd/tO
	LciROuORKNHKdais+YOp74bsV+gexGVBay4xmYqKhUdVWL+ysjkPRKFHzwJSRsdCsghHr9xiWBl
	WvMcox0imCPhCO1JmvidcweZ3W1Q=
X-Google-Smtp-Source: AGHT+IGW1KtMbvBtpQ6eJmVnpiAF83MeSDJyU36wvG6d78kD2XdK0+qsrbUXt/u+aJclZinpSHYv4hjwAi5Qe0D51gQ=
X-Received: by 2002:a05:651c:211f:b0:30b:a8c2:cbd3 with SMTP id
 38308e7fff4ca-30d7e2ba282mr63919951fa.28.1742913572316; Tue, 25 Mar 2025
 07:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325091614.1203411-2-ardb+git@google.com> <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
 <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com>
 <ervuw7mwzvcyizkchy3nz4357ahz5kdfzc227exlrc5yabq4im@g2kzsrdbkdf6>
 <CAMj1kXEzzNnohJat5REp5mAUCSd4v_ft6F=P6vB95z6+f1MMfw@mail.gmail.com> <4xm3bmuhmdbnn6fkmhmnrtkcdiwj76dcr7gujam45nqvgupvj3@caytleltmyzj>
In-Reply-To: <4xm3bmuhmdbnn6fkmhmnrtkcdiwj76dcr7gujam45nqvgupvj3@caytleltmyzj>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 25 Mar 2025 15:39:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFERrdioZ8_07rwDVUAoq=OLDvLCRUS6BN3GXnJoJPuAA@mail.gmail.com>
X-Gm-Features: AQ5f1JpmAS-HnO2_068k7J_GS9p1rxccfN4ugJ3b764lSA8hcng6MseCs9KQRWg
Message-ID: <CAMj1kXFERrdioZ8_07rwDVUAoq=OLDvLCRUS6BN3GXnJoJPuAA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Do not accept parts of memory before ExitBootServices()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-coco@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 14:44, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Mar 25, 2025 at 02:09:54PM +0100, Ard Biesheuvel wrote:
> > > Since the problem happens before ExitBootServices(), can we allocate this
> > > memory range with EFI API and free it back?
> > >
> >
> > In principle, yes - we could allocate these misaligned chunks as
> > EfiLoaderData, and it wouldn't even be necessary to free them, as they
> > would become available to the OS automatically.
> >
> > But doing this in setup_e820() is tricky, because every page
> > allocation modifies the EFI memory map, and we may have to restart
> > from the beginning. And there is no guarantee that some asynchronous
> > event in the firmware context does not attempt to allocate some pages,
> > in a way that might result in another misaligned unaccepted region.
>
> Looking again at the code, setup_e820() (and therefore
> process_unaccepted_memory()) called after efi_exit_boot_services() in
> exit_boot(), so we can't use EFI API to allocate memory.
>

Ah yes, I misremembered that. It also means that it is fine in
principle to take over the communication with the hypervisor.

However, this is still tricky, because on SEV-SNP, accepting memory
appears to rely on the GHCB page based communication being enabled,
and this involves mapping it down to a single page so the C bit can be
cleared. It would be nice if we could simply use the MSR based
protocol for accepting memory.

> And it bring us back to the issue being platform-specific. It should be
> able to accept memory in principle.
>

Indeed.

> I remember testing TDX boot with ridiculously large unit_size, like 256M.
> And accept logic worked fine for me.
>
> > So ideally, firmware would adopt the same granularity when accepting
> > memory, and we wouldn't have this problem. (Or maybe this is why
> > nobody noticed until I found it by inspection?)
>
> It would be nice, yes, but we need to deal with requirements in current
> spec.
>

Yeah :-(

