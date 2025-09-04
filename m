Return-Path: <linux-efi+bounces-4684-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B9B43394
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 09:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D967A6871
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 07:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19BA299922;
	Thu,  4 Sep 2025 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkpRQhtW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB223D7D0;
	Thu,  4 Sep 2025 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970375; cv=none; b=sZwDCgcGXUnAkugrCZLlgMx/biM8N9lstaMIAzZJ8PPmtQf8U9EKwD5NmOeQdTAqBzgWAsRi6ThZFSY0xMd1ixf0gQin19jEr15efVNt+QA787SxBqcgUhzZ1gg3vGl2pnn2ldVVw38CvBKZjFGWCJGrtz7sLZ/HEehaS+O7F2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970375; c=relaxed/simple;
	bh=72oYlNKXXmAjA5Q5e13+DWrwi/CpM80zljJXvzw63aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3BDHcaunE59z+Z31y3OUTRiYvcpsT0W3RFpwKSF+H0/+/iosjuVIqCp20TsB9oFzfDkrhVgf+TWmqjRgRzhTBqh8/WHGRSwX0sQlqxqdxu3yrGgAyE24q7FSvpPLyAl3JMTxXg8W0PXMYn6T5/9rOXwFR/LMoaJErJ8RNGBT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkpRQhtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633E4C4CEFA;
	Thu,  4 Sep 2025 07:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756970375;
	bh=72oYlNKXXmAjA5Q5e13+DWrwi/CpM80zljJXvzw63aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RkpRQhtW+a9Y5lrqRKRhT35FXEw1JPCeIWAQrYQnCH0PzIhHfBAOhG2Y5tMpknarz
	 Pl6vzMh5wTJkjfijbtkfNLawzbNfsDaIq0XFhQ03u1qXSHpsWOyAsewXLQkmGGDpF4
	 g5AZtKvc/NMoBuOSrEYboremIyftnqUZnccdN63+lyYaqC2zXAg1ev7wfVJH2lBPPs
	 JVWLymM+QXBvbXwT51vLAHuB98LJ3hPXoXOI0XidDfDFuhAkXtfKW2uJbzeDUKLK45
	 gu3YhlMYSQbv5cDMx39swAF/M58+EsE1FTxDMYZouqSbCtxD0PLFI34ZU+9r65T2RB
	 b7Av9NcRTOQvQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so615037e87.0;
        Thu, 04 Sep 2025 00:19:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYrD1EUn4okIdh9ojyq48KhMGhjaKeJ4HOdHn14wCgEXNVJCHgChPMSkP4mh/Jm7eR88ElK9kAmBE=@vger.kernel.org, AJvYcCXLxESFQFDg8TZUkM11ZvPvW9QkH9JjQDqxORazMkZdSBvgvbjqK2cLoLDIYTNCz91iOFjhTW9V4JSKj0Mk@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0Afkgp4sQG4fB8IV3EyEfxQiHGORgyu2UA5pZhVsLfpUWv5a
	/VE11zR0aOrFE4OC0rC/xMdvJv7kqmbXvmia57UIfdfF3Gw1Q+H9FTCwhsoa0B9Fx72LO4XIU+r
	G1O+aRO0eOf685VPS4hg92d/uWyChMFU=
X-Google-Smtp-Source: AGHT+IEFvmAnCvfgO7PlnrG1BYUxZTjjsz6BPZ180OOcQw+OkZ+byNbMMbmHC7LJX6qhewccjpN/hH5j8/8g6mEFmZQ=
X-Received: by 2002:a05:6512:239a:b0:560:8d97:8bb8 with SMTP id
 2adb3069b0e04-5608d978cd1mr1413481e87.32.1756970373660; Thu, 04 Sep 2025
 00:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755721529.git.epetron@amazon.de> <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
 <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com>
In-Reply-To: <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Sep 2025 09:19:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com>
X-Gm-Features: Ac12FXzg-Gwf5w9Dkz74akKGMbsagt1QMuLWSxeot3bSIi-D7R24FEVq60rM11k
Message-ID: <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
To: Evangelos Petrongonas <epetron@amazon.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Changyuan Lyu <changyuanl@google.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Aug 2025 at 23:47, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Ilias)
>
> Note to akpm: please drop this series for now.
>
> On Fri, 22 Aug 2025 at 04:00, Evangelos Petrongonas <epetron@amazon.de> wrote:
> >
> > When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> > early during device tree scanning. After kexec, the new kernel
> > exclusively uses this region for memory allocations during boot up to
> > the initialization of the page allocator
> >
> > However, when booting with EFI, EFI's reserve_regions() uses
> > memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> > rebuilding them from EFI data. This destroys KHO scratch regions and
> > their flags, thus causing a kernel panic, as there are no scratch
> > memory regions.
> >
> > Instead of wholesale removal, iterate through memory regions and only
> > remove non-KHO ones. This preserves KHO scratch regions, which are
> > good known memory, while still allowing EFI to rebuild its memory map.
> >
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> > ---
> > Changes in v3:
> >         - Improve the code comments, by stating that the scratch regions are
> >         good known memory
> >
> > Changes in v2:
> >         - Replace the for loop with for_each_mem_region
> >         - Fix comment indentation
> >         - Amend commit message to specify that scratch regions
> >         are known good regions
> >
> >  drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> >
>
> I'd rather drop the memblock_remove() entirely if possible. Could we
> get some insight into whether memblocks are generally already
> populated at this point during the boot?
>
>

Ping?

