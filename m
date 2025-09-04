Return-Path: <linux-efi+bounces-4687-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88AEB43756
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 11:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636B31689C6
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFE82F83D4;
	Thu,  4 Sep 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwEjB7cg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2DD2F83CF;
	Thu,  4 Sep 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978756; cv=none; b=QKzw08TT4h0Hs8UASOfm9N2Rdxu5d/h5KNfnMXyHZmQzyD3vM8kXCVqvBMMYA1Srn2CPBhCrfaybh+K/5mY9lGSdwsEwGm7WILnuIr45JClv2zvK3v4Q5/OpfgiPUo9lYVy9TRAkgY36mNpO8Mxp0Cx5au9O8+CsKYb4mlbx4Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978756; c=relaxed/simple;
	bh=b7BACgAwQUb+uyXmCf5NXBvllTt2WyPGKAHbjgfVB+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0sLiEcOavSFmTSio/gSfLnX0cYLjEOJZSD/h365tXP8tlwf/pAXmIPParg303iNBia1r+u+dqyDmHtmTBylvBameOA6Ugt1RCY6cwI5HjDGWXuYm/gGiX6krhhvd04nVCZPz4hG6qeSgnV786s/GQs3Y85NavuromK2dZLJbZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwEjB7cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BDAC4CEFA;
	Thu,  4 Sep 2025 09:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756978755;
	bh=b7BACgAwQUb+uyXmCf5NXBvllTt2WyPGKAHbjgfVB+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WwEjB7cgK+eJtFldPWalpiAmq4p7ZPnN7tNvhCOJfmgcNzi/AWtgRp7qfM4BMPZl5
	 yhs75u2Ns8UpweYIiAiRFivc3oqDQ37QvXDSz5dbnPvUE8loGBee8pDogGFbE+L/mx
	 AfhRhPvAY5OIwkJOuCHEiEoolzNZ829Ijf9qVVRwHMm+UUVNwycqUnrnpGoej6kCdV
	 eFH8f4TaxIDFGCSrF0bVkw/0ArKdvhCGo54KCnPRWlXFOoAEFOln7QBf4FlGvdGw3z
	 iFu6sS05fcahe7VvGvuWv1aNukB9tbzhTr0CZ7i9UDuhrY2IUUb+F5fuVW91YLX76h
	 On0EeUW75DhZg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f6bdcc195so1681526e87.0;
        Thu, 04 Sep 2025 02:39:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuZV+rmZ+HnkjDyIoCfxj1qe8udho1qfaiY/cXej5+6O7UYbjHweEqg4h6l4+dou698UrUOxKv9R+qRqR+@vger.kernel.org, AJvYcCXWBhaoQXBAVzTc3r/hcNIPDLwFDrKXd9EITL6ULtlFwxMAbHn0YK9k1HTZqWbTQ0A1xRg7HcG7Wfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vmD7cSg/vuUx4GxIOiLH/ZBxFh8fvNAX9TiMdNbJ9q6KXGWg
	/iLZBZHkuSOBAnj+MHCFANlbP2geP7SmvgYs+A4FJ1gt0zVrB+TYjUGTpeFIXqXS4grP1niDANA
	haD5U+JpirST6kHg+y6EIXm+fT+h80i4=
X-Google-Smtp-Source: AGHT+IE+sZix8HxDMFoQ4qCVA3ERgwP0vsD+zEJb2XElfW+EN65uuxN8+XQS8HhSU1B4zUIkMiL6fynWNcS2PalYMqE=
X-Received: by 2002:a05:6512:63d9:b0:560:83e2:1db7 with SMTP id
 2adb3069b0e04-56083e220c3mr2265147e87.6.1756978754251; Thu, 04 Sep 2025
 02:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755721529.git.epetron@amazon.de> <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
 <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com>
 <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com> <20250904093455.73184-1-epetron@amazon.de>
In-Reply-To: <20250904093455.73184-1-epetron@amazon.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Sep 2025 11:39:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHTJxBMFX6J-QwcPRojLGMQsTNOH5Bz9kHk7CFdt1JApw@mail.gmail.com>
X-Gm-Features: Ac12FXwC151u6vsYrsntF6Gl_qF6tE-aW0TPl91D1Up2Kpmz5zWqn28--0rAVOE
Message-ID: <CAMj1kXHTJxBMFX6J-QwcPRojLGMQsTNOH5Bz9kHk7CFdt1JApw@mail.gmail.com>
Subject: Re: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
	bhe@redhat.com, changyuanl@google.com, graf@amazon.com, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nh-open-source@amazon.com, 
	rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 11:36, Evangelos Petrongonas <epetron@amazon.de> wrote:
>
> On Thu, 4 Sep 2025 09:19:21 +0200, Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Sat, 23 Aug 2025 at 23:47, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > (cc Ilias)
> > >
> > > Note to akpm: please drop this series for now.
> > >
> > > On Fri, 22 Aug 2025 at 04:00, Evangelos Petrongonas <epetron@amazon.de> wrote:
> > > >
> > > > When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> > > > early during device tree scanning. After kexec, the new kernel
> > > > exclusively uses this region for memory allocations during boot up to
> > > > the initialization of the page allocator
> > > >
> > > > However, when booting with EFI, EFI's reserve_regions() uses
> > > > memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> > > > rebuilding them from EFI data. This destroys KHO scratch regions and
> > > > their flags, thus causing a kernel panic, as there are no scratch
> > > > memory regions.
> > > >
> > > > Instead of wholesale removal, iterate through memory regions and only
> > > > remove non-KHO ones. This preserves KHO scratch regions, which are
> > > > good known memory, while still allowing EFI to rebuild its memory map.
> > > >
> > > > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> > > > ---
> > > > Changes in v3:
> > > >         - Improve the code comments, by stating that the scratch regions are
> > > >         good known memory
> > > >
> > > > Changes in v2:
> > > >         - Replace the for loop with for_each_mem_region
> > > >         - Fix comment indentation
> > > >         - Amend commit message to specify that scratch regions
> > > >         are known good regions
> > > >
> > > >  drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
> > > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > > >
> > >
> > > I'd rather drop the memblock_remove() entirely if possible. Could we
> > > get some insight into whether memblocks are generally already
> > > populated at this point during the boot?
> > >
> > >
> >
> > Ping?
>
> Hey Ard I was AFK travelling. I am back now and will get to it.
> PS: Keen to meet you later today in the KVM Forum.
>

Yes, let's catch up!

