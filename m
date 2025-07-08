Return-Path: <linux-efi+bounces-4187-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9715AFC739
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 11:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54A21BC3572
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B0826658F;
	Tue,  8 Jul 2025 09:40:04 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DDE263899;
	Tue,  8 Jul 2025 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967603; cv=none; b=n8ryW0Uwh0Hz5fX6MOIMhESFxtWSEfCI+X5QgOpxc0cbGKsXAyt1zv5EfKU6+J9RVWhNqWB56+A8ySjBz0LrZLNhUPydoDCYDvnBC2MRL/A5RFgqf9fh6S+IvAzfqy/c7l7ztFenHFkuQTw90niWfiKGIKBtv2gy9D2cQ+BaNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967603; c=relaxed/simple;
	bh=/juqDHVkSFYcxrJeW4anGnUPTRAjelc4Xxu89KkV+6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWqy0sW7/XCegv25dvhDOWM1ZGlMf72MKXBiKGr5cxdoNhac5Ag6z8K/mewW8IxzWfverkApKHYSQXIh2hwjek/x4/hXjWSxO9M7aCV4wx619OUxk6MocmPb7rFbuYf2+kJf+hdy3rEaHHbqWsPX2lSzJ3QohnvJPDf9KSPyorc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso8052381a12.0;
        Tue, 08 Jul 2025 02:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751967600; x=1752572400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDGRwzwOvCrWWFQfPfpra9qYK3fJVDbD/wSIIQxXnMM=;
        b=jbKUGsMNN8fnLoFaNadN1v3IHHlvLV7qSP3Gh0F2p55jG+DpDNPK7SnXyC4UnSIoK+
         Ga8pNl4/kc/+hwpgVZdmB7c4FmeYTzuCjrvJov0pl2d7cAHC/iJqfv9VRPKny2Vi0/Q0
         f0f8Ce7/UXxgAcxpevJniTE74fydYvgAKAziMtiSLiOXFu4Ph8/hxJJeSvynk+j+Pz3J
         elSMiRNPZmtnq0r1jEhezK0AmY5+UqltwohZaSw+mRJMt4TcdyV9duEkYK8R+DQDKQR+
         /Lq61bIBRjWB3N3KavLbt2+bleeIyy4MUlh7uJNiWzGIqpDl8toaKPSCPzJl2SKtdgMT
         SgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm2hisHZPt1T8lcD5f3gNIJFdzDcAAAhFz/Go3/SQ3x8wvCvtV9TM1PqLZIZt9P0d4NV6/OpeWjVQ=@vger.kernel.org, AJvYcCXgL1ceJ2h9D5IAsKLpQAIMqaQHwCM2Q/pNKiyIXqsVysY2SB2+3EzotBfl/rItAK55jJPJeZwFaWllHGS/@vger.kernel.org
X-Gm-Message-State: AOJu0YxAcwrgkDXc4NVrQasjOLXrCXgkl5qxg39W4m/oPq9yGZxBGTGu
	QS0K6fzoq/UGdpbezqDDn1etH/ouY6EcO3zW+x6Uw3GJ7HIZGIVXvZrA
X-Gm-Gg: ASbGncu048cUUkvhKFNODpw2hzQ03Dw6cgdvrIOapFM54Khah8wgjgF+xiqppxb7C1J
	/0O6qSLWcsB2OOXmHtVAZj6SMrFWVgEltuMILi8u/xWx+QU8LehYWOtdSaTtDYpHbgiDDOsD35X
	6qgi7IGdyUlyZ1o+ep4lXpm5tJuB+95rNhZZ/NmvqzweRpybpI79wG9L59vUHRgV/z5kS5X4Xwf
	BMlnb/JvvAtA2ytfx3JeSnL6hSjASovK+gLZRGWnDR5DyT9uW47KwuvS9bNglYawgDq19fJPElq
	LzPjEgVLbKBjv9kTM900nqHcDsokUlLh1vDq6NdKF/VKH5hQcI3f
X-Google-Smtp-Source: AGHT+IEKuh5P5XxfGU6tISC7d/SWRHDTdhtCdRwTY574SCwgIN9VltFkhI6/5VSmmx/mAhn8r/NsaQ==
X-Received: by 2002:a17:907:97d0:b0:ae3:7022:b210 with SMTP id a640c23a62f3a-ae6b0b1ec6amr238872866b.12.1751967599680;
        Tue, 08 Jul 2025 02:39:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e6f30sm864599066b.33.2025.07.08.02.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 02:39:58 -0700 (PDT)
Date: Tue, 8 Jul 2025 02:39:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, leo.yan@arm.com, kernel-team@meta.com
Subject: Re: [PATCH 1/8] arm64: Enable VMAP_STACK support
Message-ID: <aGznbObwbaZlnD17@gmail.com>
References: <20250707-arm64_vmap-v1-0-8de98ca0f91c@debian.org>
 <20250707-arm64_vmap-v1-1-8de98ca0f91c@debian.org>
 <aGwCfRkYqcYBvxZK@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGwCfRkYqcYBvxZK@J2N7QTR9R3>

Hello Mark,

On Mon, Jul 07, 2025 at 06:23:09PM +0100, Mark Rutland wrote:
> On Mon, Jul 07, 2025 at 09:01:01AM -0700, Breno Leitao wrote:
> > Enable virtually mapped kernel stacks for ARM64. This provides better
> > stack overflow detection and improved security by mapping kernel stacks
> > in vmalloc space rather than using direct mapping.
> > 
> > VMAP_STACK helps catch stack overflows early by placing guard pages
> > around kernel stacks, and also provides better isolation between
> > kernel stacks and other kernel data structures.
> > 
> > All dependencies are satisfied for arm64: HAVE_ARCH_VMAP_STACK is
> > already selected above, and KASAN_VMALLOC is selected when KASAN is
> > enabled, meeting the KASAN dependency requirements.
> 
> I reckon it might be better to say something like:
> 
> | arm64: Mandate VMAP_STACK
> |
> | On arm64, VMAP_STACK has been enabled by default for a while now, and
> | the only reason to disable it was a historical lack of support for
> | KASAN_VMALLOC. Today there's no good reason to disable VMAP_STACK.
> |
> | Mandate VMAP_STACK, which will allow code to be simplified in
> | subsequent patches.
> 
> ... to make it clear that we're not changing the default, and we are
> removing the ability to deselect VMAP_STACK.
> 
> Either way, the patch itself looks good to me.

Thanks for the suggestion. I will update and respin.

Thanks for the review,
--breno

