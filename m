Return-Path: <linux-efi+bounces-967-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B78B8B10BB
	for <lists+linux-efi@lfdr.de>; Wed, 24 Apr 2024 19:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5A51F258FF
	for <lists+linux-efi@lfdr.de>; Wed, 24 Apr 2024 17:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938C016D326;
	Wed, 24 Apr 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlgk8zRo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3F16D323;
	Wed, 24 Apr 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978754; cv=none; b=MsOvCIt2ORF/nYNfDjhdh535KAm1F+45JtHMvFPaksF7/U3wt9xKVWnR/R20wDX3o33JBKh+sJYeTVXZZGjCuzHTdU3F+hV4xf2Yn8om42ds9rC9MFAnJqHk83fgoPsm+2812fseTpz3BqJU8zxwKEHzQRNW5AR33b8tA9IdY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978754; c=relaxed/simple;
	bh=Kkt+YSmlIUMjWbiX/GoYafA5lRKE9xD3stveC0qUvmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHiC0R/hvPdafp2saMh71Ye82lXYuFvsrdqSLMRj8odYmULNLjM/Brhx6z+IeOjU1zmi+Ps+p1B0IyOYqt6N+1Yv7EkS2aPUxhDpdtAU8ZdWuIVt4PyXlcgIYSNWWFCq8P/2xeWUDiaXFxiPNPktfVIt5B5ipUPhNuuSMyLZTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlgk8zRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACD4C2BD11;
	Wed, 24 Apr 2024 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713978754;
	bh=Kkt+YSmlIUMjWbiX/GoYafA5lRKE9xD3stveC0qUvmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hlgk8zRoBFgiTu4cHuAAFfiJOpNQb6jzqeB6PI52v5ko9LqOPIQE2+LsSKFYiQrHA
	 EQmHaurrWmx4TuISFEKERvO9wxwQcL6uDtkKQ8zfhph95ixEZuTAxAfHVp83hJnCW/
	 J1bmUs6FDSfIYRU3LaiRGoXfbCGeyQFoltGQXJlUEqqO2lBB0A4BoFrtEAE7NF94+3
	 fy8BEg+X3ag4Ok9hJEe/r7NeaFqmnoB1svunfOoOQf/YsYx96WgupX5AYPGetm9PGh
	 L2dyOG+FKGdqp9/GB96SpIJr5SOa9iINPG3PFhnBoCY/ab7JVfGazBLFO3wEnWWdiw
	 NK6nebuAQnOKA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51b2f105829so38715e87.3;
        Wed, 24 Apr 2024 10:12:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+CHVoAW7a56ptjm5+Nj7LzEy8b9tF0DYEaUcDGxiX0OPV2uGKReN6lh8tuLRRGhj8xkO7nOVZ/zDJmd+IWcZTJlZLpOjKtGqfNiss
X-Gm-Message-State: AOJu0Yz4tvTkmvnYGh3ce3flUABZdRiqf5XdFd5sC8400JpVvrtIHcvD
	hMCq1naWbodAtIMVZKXRetFgVSwGYoV2UegsGYHX/bgIIyt6CbKYSay2pqA2E7w7VGeJt8D/VlF
	allnIA/YSmqguLNgpVoiI4CLIV+M=
X-Google-Smtp-Source: AGHT+IFylpELUugGSA1hGuuC3zfhaMOA+fwjdt07ZGe43Ydi4oygeR25mHBbZo39tsn6NuKNZ3DZKXgHj/A8s6lJenY=
X-Received: by 2002:ac2:5b12:0:b0:51b:2f81:7361 with SMTP id
 v18-20020ac25b12000000b0051b2f817361mr2649433lfn.57.1713978752374; Wed, 24
 Apr 2024 10:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411004907.649394-1-yu.c.chen@intel.com> <ZiZ2yUI09QIrYr/4@chenyu5-mobl2>
In-Reply-To: <ZiZ2yUI09QIrYr/4@chenyu5-mobl2>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 24 Apr 2024 19:12:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGdRkiLh+3DePZuejaqEphyP=gN6bnK6v08ueP3MP40EA@mail.gmail.com>
Message-ID: <CAMj1kXGdRkiLh+3DePZuejaqEphyP=gN6bnK6v08ueP3MP40EA@mail.gmail.com>
Subject: Re: [PATCH v2] efi/unaccepted: touch soft lockup during memory accept
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-efi@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Nikolay Borisov <nik.borisov@suse.com>, Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org, 
	"Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 16:40, Chen Yu <yu.c.chen@intel.com> wrote:
>
> On 2024-04-11 at 08:49:07 +0800, Chen Yu wrote:
> > Commit 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused
> > by parallel memory acceptance") has released the spinlock so
> > other CPUs can do memory acceptance in parallel and not
> > triggers softlockup on other CPUs.
> >
> > However the softlock up was intermittent shown up if the memory
> > of the TD guest is large, and the timeout of softlockup is set
> > to 1 second.
> >
> > The symptom is:
> > When the local irq is enabled at the end of accept_memory(),
> > the softlockup detects that the watchdog on single CPU has
> > not been fed for a while. That is to say, even other CPUs
> > will not be blocked by spinlock, the current CPU might be
> > stunk with local irq disabled for a while, which hurts not
> > only nmi watchdog but also softlockup.
> >
> > Chao Gao pointed out that the memory accept could be time
> > costly and there was similar report before. Thus to avoid
> > any softlocup detection during this stage, give the
> > softlockup a flag to skip the timeout check at the end of
> > accept_memory(), by invoking touch_softlockup_watchdog().
> >
> > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
> > Reported-by: "Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v1 -> v2:
> >        Refine the commit log and add fixes tag/reviewed-by tag from Kirill.
>
> Gently pinging about this patch.
>

Queued up in efi/urgent now, thanks.

