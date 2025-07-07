Return-Path: <linux-efi+bounces-4173-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA14AFB85E
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 18:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F29F17918F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093DA215062;
	Mon,  7 Jul 2025 16:09:00 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535691E25FA;
	Mon,  7 Jul 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904539; cv=none; b=fpRS66zEYm1ecJP+9UrcqGHzC1qcxSJO1hyodLHUgFigQOG75/KAwDXrrtPDrhS8uZ/bEQuu1k99/DCbc/egycbExaPReo03clZVixqslvMi4voIHss8bpTeuV0+NOGOFwpKStOwT9S4iXwr2UZi7rKmo2WtSYXJbsED/vdfgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904539; c=relaxed/simple;
	bh=hGAL0RAlsyh7P8ZqSXpWzyJtAQXtSCnscC0y+VSp0nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX0fNvftFmI6irlD4l2eK8LdVUhkAMWFdvpR78GZL6pySP9mcVW19oc7SUu/CC7ONOTT69RGhAiNiypUeCxTchhoAUYrE8U0kVOmyy0lHN/sI67PMhBmDoGYH1OD+BrhRvjKv0cRtMP3tuQW88HJcKWwBwcw/G1v5omeS7gBAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb5ec407b1so553185066b.1;
        Mon, 07 Jul 2025 09:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751904536; x=1752509336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukbvHzZfhwx6533qERNgaNRmfc+1+i0ljL79gEDoL88=;
        b=ujiMjUU3LLg5+DNrpWRnQCC3vSVITQp4tHWdjbPcRMYN6BdDr5oNwzbSg83GsgqQIn
         4Dqgdh9OOGeUmtOk3+IECzl+OFEl3+2SkpUopYJ3NPbrluENm9HYOna0RgZvAJhiA98S
         KXQrn1IPFDlwyg8qWi1y39LTHnZSww4qL019TX8+1+kll5D1y+X+RwOda6hOLd6TtYNS
         88Rrw7w+SqQekfQ9jGD16LET92SpmPDRfT7fG0tG6guKJm5vRjYTPs2bokowK0aZclYE
         VDZqeshmf1/mzhqk94TuD/mzu8p6C5JMKf5r5hbKocd9lX9UeaL0qF+hhmxW3CINKvps
         a6oA==
X-Forwarded-Encrypted: i=1; AJvYcCW7zePZjP5PLbU7zoKU/UgQfxKIeBve1xWqekXj952f/QAMsn0OCInOCFOL3A5xRHTFGxB4qi8NN5Q=@vger.kernel.org, AJvYcCWkEXPMPpVYaSOLvHBvwZlGgmHanJdx+r7rOZkMBwQpSG3+PUD7HyfDrKTPOTzc+yJIuqbKC1jdVHL+s0ld@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+4Vs2Q4hE0unNNYN/9CeEbnmt1V2hUh0un8Be4Vmca8EdtcF
	zTO0eezyApTugH5mI+QWqkLfY7P9TceIlUfd9DePf9pLOHNRhUEY5pPE
X-Gm-Gg: ASbGncv9K2hkkhBeERNHVmvjd9uJ1ifUjdTmT/Kq/AcsYjV+GopqmfDXzF3yXJNNd3P
	zmI1+I8PnVJRwqS3hm26RWogcpI6qWRHOXOfdgkXpUunEDZZgclHPEHdwEi9+icHO6Mf9TFXohA
	ePqfAJfaYRAtKoDerjmxH53mFavc/47S7q8kd/EWd5/GiFFZrW44uHyxn/CPhY14RfQpsWCjR15
	5jZw8Cl7fXUMWNatyNhEM3jVHyAw0Mz1r59mli3PpwWoHXZD42noGJIV7KWCWTigZwR60goL1JM
	U6mW0Tcdu8sfCGAmS92BbcGrh6T03+Y5BCUI92PZcZFCONAxn7MA5w==
X-Google-Smtp-Source: AGHT+IFRCwe+M2LN1raXwbrfTy1qnj/eKSyDlwd2ZulMHGxXV5lbkUCyxCU9OUDf418Cp2+/qD3ZbQ==
X-Received: by 2002:a17:906:2412:b0:ae0:bdc2:9957 with SMTP id a640c23a62f3a-ae3fbdea236mr1001311166b.61.1751904536006;
        Mon, 07 Jul 2025 09:08:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6abfadbsm729371066b.80.2025.07.07.09.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:08:55 -0700 (PDT)
Date: Mon, 7 Jul 2025 09:08:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, usamaarif642@gmail.com,
	rmikey@meta.com, andreyknvl@gmail.com, kasan-dev@googlegroups.com,
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] arm64: efi: Fix KASAN false positive for EFI runtime
 stack
Message-ID: <aGvxEYDP8pVlalaz@gmail.com>
References: <20250624-arm_kasan-v1-1-21e80eab3d70@debian.org>
 <aGaxZHLnDQc_kSur@arm.com>
 <CAMj1kXFadibWLnhFv3cOk-7Ah2MmPz8RqDuQjGr-3gmq+hEnMg@mail.gmail.com>
 <aGfK2N6po39zyVIp@gmail.com>
 <aGfYL8eXjTA9puQr@willie-the-truck>
 <aGfZwTCNO_10Ceng@J2N7QTR9R3>
 <aGsYkFnHEkn0dBsW@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGsYkFnHEkn0dBsW@arm.com>


On Sun, Jul 06, 2025 at 07:45:04PM -0500, Catalin Marinas wrote:
> On Fri, Jul 04, 2025 at 02:40:17PM +0100, Mark Rutland wrote:
> > On Fri, Jul 04, 2025 at 02:33:35PM +0100, Will Deacon wrote:
> > > I would actually like to select VMAP_STACK unconditionally for arm64.
> > > Historically, we were held back waiting for all the various KASAN modes
> > > to support vmalloc properly, but I _think_ that's fixed now...
> > > 
> > > The VMAP_STACK dependency is:
> > > 
> > > 	depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC
> > > 
> > > and in arm64 we have:
> > > 
> > > 	select KASAN_VMALLOC if KASAN
> > > 
> > > so it should be fine to select it afaict.
> > > 
> > > Any reason not to do that?
> > 
> > Not that I am aware of.
> > 
> > I'm also in favour of unconditionally selecting VMAP_STACK.
> 
> So am I.

Thanks. I've played a bit with it, and did some mechanical work, and
send a v1.

https://lore.kernel.org/all/20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org/

