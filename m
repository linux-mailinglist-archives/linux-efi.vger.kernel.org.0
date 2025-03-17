Return-Path: <linux-efi+bounces-3010-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C4BA65A76
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 18:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3513177456
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D435F1ACEAD;
	Mon, 17 Mar 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIbO8428"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5291A3A8A
	for <linux-efi@vger.kernel.org>; Mon, 17 Mar 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231843; cv=none; b=OiqHROlmouc6eNZTYqdtS/NIeiFxGCIwsMox5SaeCWlZ/twC//WIrM/WVvt8j4vdDuKuILFns4FVFHbuRgihTRLBUdL/BDFXKui5YlSts9oH1+gqTIXp3gMk+/802V9LZ/8h7F9ypfuw9v4wh/m09Qdb0fNyGjKzK6rLNMKjTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231843; c=relaxed/simple;
	bh=c93AYaGKcGGVPweNb8RDtJ1JuwFpxuC9VZnWxeTrODY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1GNhlZeQJmp3KOBGV1MBGFHLCMFNvuAOLGQhJ6xopxwj7gb/4uCwphc93OpDEXDJNrMTtQKeBiLLzN1dblb5m/aKv/YHCCXO7rf/oRbrMxzTF9R81MpI9vfx5nt75JNnzjq5E1UQGFULRQZxwajczUyEzwFNFMbFFV0e2J8LS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIbO8428; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E3CC4CEF0
	for <linux-efi@vger.kernel.org>; Mon, 17 Mar 2025 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231843;
	bh=c93AYaGKcGGVPweNb8RDtJ1JuwFpxuC9VZnWxeTrODY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IIbO8428JgCJ9thxuIoO+TNyx+UGkjqiveU+xRlgLFNxvjASvC4NSMzj2GbJT1Fy1
	 y/ORmUKC79SiAJ4/y+C+DEjukUn8ACBBSNT2tR7nDZnU+lnUeZuQmkBL6yyYKzl+pe
	 2pvLNoaNLv+la82VcB/uiL4TtrtPlBkuL6RCufAfEzzIu+4CshhyYuuVjnk5Kn+Eyg
	 O2SOx/mKrqnz8Vg7+ATasXYzKf633w9/eZMHzJ7ab/FLeWhspfhoycSizqMuhosRLS
	 k1jkaHy5fuRIcGBpLbijcnemJ01ImNsXzu6tqYlun0HYeVdYDIXLgZeIMD6NCwaX9b
	 pnPdDk9FIPM/Q==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5439a6179a7so5207482e87.1
        for <linux-efi@vger.kernel.org>; Mon, 17 Mar 2025 10:17:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxOCRguhCyqwB56TwimyDZwvj0doK2+UUUMxjERkvovPc6jAVGQNiqLsfwH+6LjGbIYGxePThQCV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBPXXPsQkADVzi9ZlCi1t+0V8bRG/NjOoH0MaiVCQV6R+rtxx
	9mHUTkwdfbSjmHyKqBG/0uysrfhY7Ry0N+xNAalcpzL1042ChUDFhlO/ycAi6gXq3h23hAhzk45
	BBV2LKuwB1Fq5Se1HXOlQDU2+/o8=
X-Google-Smtp-Source: AGHT+IFwVz6rny4XTNf+dMUt9YOtPc1euUWoDwAYUaVS0ZWLiZSLfxo6hSIMMSV9HIazrsHmFLZWOnibFSiGRw9P0UI=
X-Received: by 2002:a05:6512:138b:b0:545:5d:a5c7 with SMTP id
 2adb3069b0e04-54a3734375bmr331908e87.21.1742231841610; Mon, 17 Mar 2025
 10:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202503171938.8Qee3VKa-lkp@intel.com> <57e58d07bad1cf890edbf80319a12fde95f30ef1.camel@HansenPartnership.com>
In-Reply-To: <57e58d07bad1cf890edbf80319a12fde95f30ef1.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 17 Mar 2025 18:17:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGKOpPVftCGG_53PB9-NO4p-PkgK8KyqvW0nd=ju0TtzQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoxZ6OUxYntAhq8VxtEjm4L0c0A4s9HsgFL4AWkUfr3petLid1DJklvfvQ
Message-ID: <CAMj1kXGKOpPVftCGG_53PB9-NO4p-PkgK8KyqvW0nd=ju0TtzQ@mail.gmail.com>
Subject: Re: [efi:urgent 10/10] fs/efivarfs/super.c:424:27: error: use of
 undeclared identifier 'INODE_CHILD'
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 13:33, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2025-03-17 at 19:49 +0800, kernel test robot wrote:
> >  > 424                inode_lock_nested(inode, INODE_CHILD);
>
> Sorry, was going to say on the other thread: the flag has to be
> I_MUTEX_CHILD, Al just had a thinko when he wrote the above.
>

Yeah - I might have build tested that myself, so mea culpa.

