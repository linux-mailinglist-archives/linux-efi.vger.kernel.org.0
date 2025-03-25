Return-Path: <linux-efi+bounces-3078-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A901DA7014E
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 14:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED12B17425B
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBBA25EFB9;
	Tue, 25 Mar 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/Jz2HVx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF025EF9E
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906477; cv=none; b=MCxt0C1Rh8DiK8g515/T4I459WeBn9el8ruIHCbQBO4ppQERl55OrUrp2/h4np5PF/N8/SBF5/4ovb4ZpstpgC+VayTZIXydsy34d6YrDHWClzAG69OT8qgXgNZvPJm+3ThVg5haCtFv3CZAR2mL6rfsUxBl0WY6jPVsHfe43Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906477; c=relaxed/simple;
	bh=TjT/edaPfw7veC1totmZ5fh/pBHQoe4SNNHDx6PVRjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fz7FbGLG5aOP+IZEXyyUvyvPGxLVQ4KBqE1CySd19Niwtv3LwM0+grP8VMXtBl3/B+EJzvt1ZmVwwuQrWX2L8w0vY/+EAms4vK29+VHNffGiXOSFeyOE3GNkWdABtlE2DrT+IwVjBVkOe2QfvptcETOQ3f86pCqyicJK/jPKwVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/Jz2HVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D7BC4CEE9
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742906477;
	bh=TjT/edaPfw7veC1totmZ5fh/pBHQoe4SNNHDx6PVRjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c/Jz2HVxsmlpVLSaXFri7wjxbwB6pTD0kM5bZ/5X1yrXD9s++n9PbeKyTzo6mAfe1
	 +zDNh7xRjoyKGPIwmKTfdm4W+vGyuHsZ0pYmigwQUfkVvkL2rShO6caaexYmLOoj3C
	 nVwDO7k7mS9TefD6TpzzrBK4ghuXQtAfSlEvBGVl6TTTRjbaVVOW9m0CNmizr/bKok
	 MPLpq7Lq4nn6Miw64MteV1iXND36jmkVeLRvhXEzKE9JPCjZXEISGzD+NYEaM09uWm
	 HApsQd/mx1RmFmgkJzfwa/WFSRxpOT7Aom9DZ0mxT917+JHeY+p8pyuHaBmtaHfop7
	 KJCupi6+iW0jA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so6292130e87.1
        for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 05:41:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVnWpn6UkTEXtKvH0XitXSsW77pkDMsSim4Al3wrbLeNQ7z79j7FRC17b1F3Tw4KcP9DSFZbr2Ujw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZ1dYhRNmxomFIhAy6u57dUEXVlwWN4vDYnNwjF9lkSYimOOn
	9YGrVkMYmY0w97rMvsKqUVmS0/ImbppA3vlWdKXAB9n0GF6ipBr/t+RL1qDQkDucvdJeh7IvlMK
	qCRUZpFKIU/QVasfikJb7d7c6Kmc=
X-Google-Smtp-Source: AGHT+IGZJrNWJtLHhyETBKb3+vnvvCGNE4l3Rf+Da8iyQm0foKJJJ+m3txiyG2Dn7f9IY/85pBTIQiEAvy9Nl0ADAzk=
X-Received: by 2002:a05:6512:3b06:b0:545:4cb:b25d with SMTP id
 2adb3069b0e04-54ad64868a1mr5277938e87.13.1742906475387; Tue, 25 Mar 2025
 05:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325091614.1203411-2-ardb+git@google.com> <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
In-Reply-To: <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 25 Mar 2025 13:41:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com>
X-Gm-Features: AQ5f1Jr858vDUiWQm3fgcXZAWP651r3j5a8-3Ne2aCzIKMNzTah3V5UWSYW5oEI
Message-ID: <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Do not accept parts of memory before ExitBootServices()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-coco@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 13:36, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Mar 25, 2025 at 10:16:15AM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Currently, setup_e820() in the x86 EFI stub records unaccepted memory in
> > the associated bitmap, which has a 2 MiB granularity. To avoid
> > ambiguities, any unaccepted region that is not aligned to 2 MiB will be
> > partially accepted upfront, so that all regions recorded into the bitmap
> > are aligned to the bitmap's granularity.
> >
> > On SEV-SNP, this results in calls into the SEV support code before it is
> > initialized, and crucially, before ExitBootServices() is called, which
> > means that the firmware is still in charge at that point, and
> > initializing the SEV support code is not even permitted.
> >
> > So instead, round the unaccepted regions outwards, so that all
> > unaccepted memory is recorded as such in the bitmap, along with possibly
> > some pages that have already been accepted. This is less efficient in
> > theory, but should rarely occur -and therefore not matter- in practice.
>
> NAK.
>
> It opens us for double-accept attacks:
>
> https://lore.kernel.org/all/zuz27i7ffrsa3hksveuroxpwxos5qx65py23gvupaadizwrsss@uhb6ye4j2eqn/
>

So what fix are you proposing? The code is currently broken.

