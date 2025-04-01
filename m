Return-Path: <linux-efi+bounces-3148-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30041A7723E
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 03:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD59C16B489
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 01:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81F913C9C4;
	Tue,  1 Apr 2025 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vEZCj0z3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B713A258
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743469870; cv=none; b=kT4HKZB+UHYUpn0f0gc4Q/SvR4f8UdCcpevRXAt2tcE5sC8OWnd/i4UsKSKa1Eui2EYdtmd6/0WoLdnQ322FTVnLg5rFSU0c/YmYEUCx8BxdSEPJ+sGsdoa38ynj5DlcCCjoMujuk3DzbI8ERi9vkbptlTpulJpJildaVe82G18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743469870; c=relaxed/simple;
	bh=c4VRjFgdPHYVEXSgwVTJK9NOPjH1pvGIrhY1YvoLmpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sv9uB3QsBI0M4zpKezlgQ8DVhTyB7sI6B4izBL7qR0tjQ6d8er+jUoCZfDvSqqPmn/2ufokJ2noHrPaaCfHwv/AJO4+zfyZ3AaVeM/S70VhsQMMnjtz2rJsEjIbJ5ESA7U8VgCxba+5wVxz0SOkGkGl+eTabJY0wC4aEgLG+YPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=vEZCj0z3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2243803b776so21408075ad.0
        for <linux-efi@vger.kernel.org>; Mon, 31 Mar 2025 18:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743469868; x=1744074668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSOCXG/bLgDc7ME6ApTEkqOXZXXVJMqkGl0AyQAQOxU=;
        b=vEZCj0z3Tjcqz6RBOsS5Whdq4AUiNMkctqwkdVKEg9yxZRxzC9Fg6Fv8JMfs9r8UZd
         ACKrNII4bULPCYXSEzFsSaJVb4w/HQdFnBCnU7tkDkjQAzVebmotcu57DI3ERsmlFIK8
         zPZmEPznvvXHGU/lXDLh+yXxyiXZ3CDvxz7iu0C0VkVlAd4dNCAKoxAK2DOSJF+uUThh
         lfFgJSpUENtqATDkE0sSFfAD8R6QceelfQk4Gbtz1RHDpebBHJcO8kTPOcU97Kqo9QBo
         +E6FLFqi/PZdguLMv0Kqa81aNLkAZmqFwkoxGWe820fP5ZN99ld60s+eFFx0lkZO7pVY
         HU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743469868; x=1744074668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSOCXG/bLgDc7ME6ApTEkqOXZXXVJMqkGl0AyQAQOxU=;
        b=Urqc+frA60UHPBADsXspYEVM/QFe/Xy3CFDmefKUD7AD7wWJ+7zs/VeBB2A/JmuUZ/
         uVzG0NBNo6Hh4OFA00+0dqajogeZeSBAbq7C0+Drj9cCzyrAa+wS97jDB69VooaHBHkQ
         doRWQPexnjrCsJl6uSqZ5yL/EudNZOscb4RwKr/4nhnZlPDiCmQFI2a7HTS+QnJzUzTF
         GatR4RemcMmCXACiJo60IzVZIovRl4vV+1LVqZLb1wVisxG/X1NJ0ukfuG8JHgPDAYeO
         HpRTbR0lJ71KQr5x9aOX/NtlGSkspz7TDUi/NbTTp9Z/TAPNrMrpVe9S8W7Ew8db6EMW
         SXIw==
X-Forwarded-Encrypted: i=1; AJvYcCXsSSLzgc7bM3R+AoaotMv8vkl1iiJa+x9UpOaU6YpXmbSwF4oFafzfO+fogEPJm9AhJM8UteRnhkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/CSaUornWzcVB3QXqokHabO5gzpGFsvncdGBIMehwC0XXtWhs
	7+UDt95l6hoFYeoN5f9Eic/pvmF67n4Ry5cFWD/4TAaEEJs/fensg+oDeVxVJ+A=
X-Gm-Gg: ASbGncu/gY1CkkO6CMF6uU5y4+qS2TVb0em3XAYRN85oRkH1lAKC043cnePbIa4Lx0j
	Q6CL736OUkvdAqq5IYP8mSuehniChSER/cvZ9R1eics3HRDqeH8NLY8UYP6DJDxFC3G4UchVIF9
	FRtAYJDaf2my+a4F9fubfLdBgy02ezdwhAknDpq7ORh6TiIeegEiaCrwwAnCPUkc2INq0qTVqkk
	msEyVdtx1TCt7gs4OVJOrMfaudSWaYjS2miyOsFyDfR7nDjRuPPyN9Kr/nSCszYnPKCGH7Kpd5s
	S6+OKYJohTQm61mLSe4avzOOkQ1ItVW3bY6/WPOloFBCP6tAMuwOiHw6eOioLYUFj8rQWcHhX8+
	OC+cLtRD4a9B6mI4k3A2QSDqQ2oQq
X-Google-Smtp-Source: AGHT+IFLfpDROybDyATP4hEqXJeYrPhcFQxWBwYKhCahugcasGxplhhifiK5A1Cetc20wuxbo6MSnA==
X-Received: by 2002:a17:902:9689:b0:224:584:6f04 with SMTP id d9443c01a7336-2292f95d89bmr122418275ad.18.1743469868573;
        Mon, 31 Mar 2025 18:11:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73971063d24sm7614688b3a.86.2025.03.31.18.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 18:11:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tzQ9g-00000002u8k-2xKY;
	Tue, 01 Apr 2025 12:11:04 +1100
Date: Tue, 1 Apr 2025 12:11:04 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org, hch@infradead.org, rafael@kernel.org,
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] xfs: replace kthread freezing with auto fs freezing
Message-ID: <Z-s9KG-URzB9DwUb@dread.disaster.area>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <20250401-work-freeze-v1-3-d000611d4ab0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-work-freeze-v1-3-d000611d4ab0@kernel.org>

On Tue, Apr 01, 2025 at 02:32:48AM +0200, Christian Brauner wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> The kernel power management now supports allowing the VFS
> to handle filesystem freezing freezes and thawing. Take advantage
> of that and remove the kthread freezing. This is needed so that we
> properly really stop IO in flight without races after userspace
> has been frozen. Without this we rely on kthread freezing and
> its semantics are loose and error prone.
> 
> The filesystem therefore is in charge of properly dealing with
> quiescing of the filesystem through its callbacks if it thinks
> it knows better than how the VFS handles it.
> 
.....

> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 0fcb1828e598..ad8183db0780 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -636,7 +636,6 @@ xfsaild(
>  	unsigned int	noreclaim_flag;
>  
>  	noreclaim_flag = memalloc_noreclaim_save();
> -	set_freezable();
>  
>  	while (1) {
>  		/*
> @@ -695,8 +694,6 @@ xfsaild(
>  
>  		__set_current_state(TASK_RUNNING);
>  
> -		try_to_freeze();
> -
>  		tout = xfsaild_push(ailp);
>  	}
>  

So what about the TASK_FREEZABLE flag that is set in this code
before sleeping?

i.e. this code before we schedule():

                if (tout && tout <= 20)
                        set_current_state(TASK_KILLABLE|TASK_FREEZABLE);
                else
                        set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);

Shouldn't TASK_FREEZABLE go away, too?

> diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
> index c5136ea9bb1d..1875b6551ab0 100644
> --- a/fs/xfs/xfs_zone_gc.c
> +++ b/fs/xfs/xfs_zone_gc.c
> @@ -993,7 +993,6 @@ xfs_zone_gc_handle_work(
>  	}
>  
>  	__set_current_state(TASK_RUNNING);
> -	try_to_freeze();
>  
>  	if (reset_list)
>  		xfs_zone_gc_reset_zones(data, reset_list);
> @@ -1041,7 +1040,6 @@ xfs_zoned_gcd(
>  	unsigned int		nofs_flag;
>  
>  	nofs_flag = memalloc_nofs_save();
> -	set_freezable();
>  
>  	for (;;) {
>  		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);

Same question here for this newly merged code, too...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

