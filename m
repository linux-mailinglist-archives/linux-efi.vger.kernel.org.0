Return-Path: <linux-efi+bounces-1012-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E48BAABF
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2024 12:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9E51F2215D
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2024 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F45D433DD;
	Fri,  3 May 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUjOY8R0"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B96C2E9;
	Fri,  3 May 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732286; cv=none; b=cUmu1qKdYZ7UltxzsoqHYhFP2hxOn+Hpb5NjH8LvTbIn4KsbFbBFTlZMnlqdbFqf0ABC+FeY892M5M/T5tT4sJ936MKS7BmjNECuvlqN0RTW97k7RDDvPUqufSTumFxaqYQ7gOUEcA8j0bPhrFYP0i1OrFbF0afIEoMV1S04nMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732286; c=relaxed/simple;
	bh=nc6rjh+82Q/1R41FiW6o6l8t57/kihiXaaePxvwXWbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKelovyrWEVZufkX3iEKEupOhJd2gvjZeVlbm/ozi5oEcdcSEl6HehZSU6mPpvpJD3oUjHa3t9JO1XeOxMSq/5cQhs55Aiq22g9sEnZVJVM5i05yCPIoAe+8xNUWRqHkLaBNqcsF3q5XQJdpX2QxrONdJ/ThOFaeQFPSmWK5bIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUjOY8R0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1714CC4AF14;
	Fri,  3 May 2024 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714732286;
	bh=nc6rjh+82Q/1R41FiW6o6l8t57/kihiXaaePxvwXWbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WUjOY8R0riCUpqevZNqBlpaVexrXrd2SqhJV/cXhQ6QJzVNBQiXfnhq7sgMuEzk6o
	 iQYY68ZIbaVFBws38gwir7lz+bnEUI/kXvvDFiDX8p6HLY7EYIcr64WR9ecyr3BnxW
	 Vu38RtrGRKOJD87kDRRj6wEzidnuDDBYtlEkonhifFEqLkvP57/aCuE3xZNMzupOjN
	 7y3hAzH3ZXwqQvtBqBjwdLrS1JTCMOr+4pqrIsljkusRxzJgnx1jp6+yArzGHo2XHD
	 Y/Cdm4T+rvwD4/3dRZ5kEP8zq4u6/3nqcUp1cWIP/BxQx0UJ34XsXpDBZD/qZ8qM1R
	 Cjbpji9TTCRoQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2df9af57b5eso91029771fa.2;
        Fri, 03 May 2024 03:31:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWF7EZ0RvWh/orDrOrgRczuZe1bjrAlNpOs2r0MH0H9cdAQWSsXyZq1agVRLH3OpcBNE+JJDR8JSNkuilndSbnK/bnCrlCcgzM03j6g
X-Gm-Message-State: AOJu0YyErBjLwmBocti4u6rICulTL3auMzBR6j9sNXhs0rWlg42kGmYF
	91TIXshAqiyxCEjsS2/P5k84+Hz9594OTWRnnjRB4TJQhY9JXM7h7cLxOfotF7WqR0/T2YvLSCJ
	XlHCPcAoQuviBX9B5XBpsJpHgMiY=
X-Google-Smtp-Source: AGHT+IHtel9Xf2xd1QPpAHkRvwx0va3yjkn+x43uAJYWhhh3bC1oZRJaFxoQq+jcdpqxM7m8YUbDzS+sVjB94J5lqZw=
X-Received: by 2002:a05:651c:d5:b0:2e2:466b:1a67 with SMTP id
 21-20020a05651c00d500b002e2466b1a67mr1351512ljr.46.1714732284413; Fri, 03 May
 2024 03:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411004907.649394-1-yu.c.chen@intel.com> <ZiZ2yUI09QIrYr/4@chenyu5-mobl2>
 <CAMj1kXGdRkiLh+3DePZuejaqEphyP=gN6bnK6v08ueP3MP40EA@mail.gmail.com>
In-Reply-To: <CAMj1kXGdRkiLh+3DePZuejaqEphyP=gN6bnK6v08ueP3MP40EA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 3 May 2024 12:31:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHLGMXtD-Ad_1TKPmkrvppeNNtKUn-G5q4jr8ZKOab18Q@mail.gmail.com>
Message-ID: <CAMj1kXHLGMXtD-Ad_1TKPmkrvppeNNtKUn-G5q4jr8ZKOab18Q@mail.gmail.com>
Subject: Re: [PATCH v2] efi/unaccepted: touch soft lockup during memory accept
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-efi@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Nikolay Borisov <nik.borisov@suse.com>, Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org, 
	"Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 19:12, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 22 Apr 2024 at 16:40, Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > On 2024-04-11 at 08:49:07 +0800, Chen Yu wrote:
> > > Commit 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused
> > > by parallel memory acceptance") has released the spinlock so
> > > other CPUs can do memory acceptance in parallel and not
> > > triggers softlockup on other CPUs.
> > >
> > > However the softlock up was intermittent shown up if the memory
> > > of the TD guest is large, and the timeout of softlockup is set
> > > to 1 second.
> > >
> > > The symptom is:
> > > When the local irq is enabled at the end of accept_memory(),
> > > the softlockup detects that the watchdog on single CPU has
> > > not been fed for a while. That is to say, even other CPUs
> > > will not be blocked by spinlock, the current CPU might be
> > > stunk with local irq disabled for a while, which hurts not
> > > only nmi watchdog but also softlockup.
> > >
> > > Chao Gao pointed out that the memory accept could be time
> > > costly and there was similar report before. Thus to avoid
> > > any softlocup detection during this stage, give the
> > > softlockup a flag to skip the timeout check at the end of
> > > accept_memory(), by invoking touch_softlockup_watchdog().
> > >
> > > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
> > > Reported-by: "Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
> > > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > ---
> > > v1 -> v2:
> > >        Refine the commit log and add fixes tag/reviewed-by tag from Kirill.
> >
> > Gently pinging about this patch.
> >
>
> Queued up in efi/urgent now, thanks.

OK, I was about to send this patch to Linus (and I am still going to).

However, I do wonder if sprinkling touch_softlockup_watchdog() left
and right is really the right solution here.

Looking at the backtrace, this is a page fault originating in user
space. So why do we end up calling into the hypervisor to accept a
chunk of memory large enough to trigger the softlockup watchdog? Or is
the hypercall simply taking a disproportionate amount of time?

And AIUI, touch_softlockup_watchdog() hides the fact that we are
hogging the CPU for way too long - is there any way we can at least
yield the CPU on this condition?

