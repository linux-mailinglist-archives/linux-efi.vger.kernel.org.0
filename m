Return-Path: <linux-efi+bounces-1693-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32237973B33
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 17:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6199B1C23C0B
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D7E1990CD;
	Tue, 10 Sep 2024 15:13:52 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A59194132
	for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981231; cv=none; b=kmCLWLrHkfBRTKOJBk9kgPNcSTLpBSEuAONsuY50x3ttO2fNckF/eRskL06iExvowOjgUttWIU3fVIsFcXGu4bYl0aGgyegs2uhJVBZjZ/D5GosMBs+pTI4Y9Czb81aD0t8LYr+RfXPw6iDeHKuUSwDP66rouL/BK737ImVU6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981231; c=relaxed/simple;
	bh=Kp11Bd5HCbSKNFqzpW/39jWGsMiturTeK702AvqEM/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLRVDWzhLKXwQLA1FISXWdPAY/9Fu3uIMk/Xa1vG4vK0exdsGl7I67B86Oxcrq2H6Q84sZR/b7faXwERmkRv7Hvtk5MMbhW34GvBCU2Ej/03HriWtpz6r569G6pxi+y0pNTUGvVcEvAnwWfwTO0A7/8CYjxcSE5JpRKPikC3pxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d4093722bso459437966b.0
        for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 08:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981228; x=1726586028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT/8R/5BLp+GREKZ2zNCykpf17IboodqIA5H60ak+44=;
        b=LpsJd77S5kjztulx7LI9nRtgXaAwG0XmyHEiTGiNf5/2PLRfQYG7ASINns5JDO7dE1
         u+vvqc7ZKpCSakujR2VEyRFYIPJLSf82KgTscYQaUdUNRo0oBdgVUDSbUZKyrXKzHLZS
         nOsLjk+DgN61Qgod8le0xCnTeZbPh3fxsuJY0JkWu790A2i+GANwd0gXKYNGeGfNQFkD
         U+M6yjICmvymQJQbEJx1QRi2uF7dv5tlBZfYVXJTKM8YFJOD7hXMRZGdpfy8/2kLFp1p
         EPsGST5vRyK/Vc59j5zzSuru2HH164TcMjqxqkkdw3A8aQmhMx7rjKnDii+u/kXqBJQK
         mNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhy+oF2VA9auluVedbvtpLrFlKalVxaTrXGJhiRbFOOT8Mx4IX7AHCae3gtgLegnNDLZDT1lqoAKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuU39iRelxNPZ5GL/WXb8LMrODLJAxDJgUYYEdicOz8TDCJ5TA
	yax4pQ1KBKK9SnYbuS7CIC89ty8t2TMXC82J1AP+XW8fOx2H/tTD
X-Google-Smtp-Source: AGHT+IGa324Mp4PeWqG8pH6t0Eo2JNJfFvVRTDFBDbp+jS0qdKR+yK3pu1oX1FOFMuTRkhs3lJJw7g==
X-Received: by 2002:a17:907:6088:b0:a8d:1142:1d68 with SMTP id a640c23a62f3a-a8ffaaa54c5mr136500066b.2.1725981227436;
        Tue, 10 Sep 2024 08:13:47 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ceb1ffsm500604766b.146.2024.09.10.08.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:13:46 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:13:44 -0700
From: Breno Leitao <leitao@debian.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org, kexec@lists.infradead.org,
	bhe@redhat.com, vgoyal@redhat.com, devel@edk2.groups.io,
	rppt@kernel.org, usamaarif642@gmail.com, gourry@gourry.net,
	rmikey@meta.com
Subject: Re: EFI table being corrupted during Kexec
Message-ID: <20240910-uppish-gopher-of-spirit-f14f0e@devvm32600>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
 <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>

Hello Eric,

On Tue, Sep 10, 2024 at 09:26:00AM -0500, Eric W. Biederman wrote:
> > I am wondering if that memory region/range should be part of e820 table that is
> > passed by EFI firmware to kernel, and if it is not passed (as it is not being
> > passed today), then the kernel doesn't need to respect it, and it is free to
> > overwrite (as it does today). In other words, this is a firmware bug and not a
> > kernel bug.
> >
> > Am I missing something?
> 
> I agree that this appears to be a firmware bug.  This memory is reserved
> in one location and not in another location.

That was is our current understanding also, but, having the same issue
in EDK2 and on a real machine firmware was surprising.

Anyway, I've CCed the EDK2 mailing list in this thread as well, let's
see if someone has any comment.

> As I recall the memblock allocator is the bootstrap memory allocator
> used when bringing up the kernel.  So I don't see reserving something
> in the memblock allocator as being authoritative as to how the firmware
> has setup memory.
> 
> I would suggest writing a patch to update whatever is calling
> memblock_reserve to also, or perhaps in preference to update the e820
> map.  If the code is not x86 specific I would suggest using ACPI's
> arch_reserve_mem_area call.

Should all memblock_reserve() memory ranges be mapped to e820 table, or,
just specific cases where we see problems?

Thanks

