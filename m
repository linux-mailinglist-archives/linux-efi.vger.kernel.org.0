Return-Path: <linux-efi+bounces-4509-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F95B19BB7
	for <lists+linux-efi@lfdr.de>; Mon,  4 Aug 2025 08:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202BD3B6255
	for <lists+linux-efi@lfdr.de>; Mon,  4 Aug 2025 06:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFBB230BF8;
	Mon,  4 Aug 2025 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lO1hjeQg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2EF22A4FE
	for <linux-efi@vger.kernel.org>; Mon,  4 Aug 2025 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290286; cv=none; b=cg5ESB9Q0EslXhIANS86sJ58gQbeg0XrM6vkX0SGLt/Rbo/EsitBtqa6G1FKhKq/MMZohH74w/raskxkqbJ/tvupnqDI1skn0ICn7oXYR3exUeRdttNYrPAELi61XwqSR2T/ZUwBxgA3yuAE08Mh8l2yB803Eojc8E1M/ntHGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290286; c=relaxed/simple;
	bh=AuHw3Q+s89vthrT+onb+aRrlNeHjbcR7n1dDceQEW04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH+uMpUDQXVN0VQ4X+sHccCvRIoAwfvqdp0HwcO1QF7VgUNgugV2BlhZeS1OTMpEYGw0jpWxCw2y9FJz9zsPRAfxEIeWHTfhfshSnMi3HkZtJtdN/CBQxXx0NrMzbJtyC77sLaxCfQtMLbN81OcI6W5UXlRswwaaJTq0K3Jx+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lO1hjeQg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2400f746440so31250995ad.2
        for <linux-efi@vger.kernel.org>; Sun, 03 Aug 2025 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754290284; x=1754895084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0OOSzyo7d6/tfFos1hXNw0iQjhEsi0n1KjZ6e/WbQ5Y=;
        b=lO1hjeQgIWsQMr8ieYxziX+sLcbMzQBo+CzPFFJr8Pt4pbsl6DvJfON1C8c8kWtzAD
         G0yrualP7/oRTKr3wu8PzGY9LtD/DZC9IqKmZYOFjeaCTOS509Gzg6ztANrJc57Slt4o
         2v7UwOWrPsWCTj7jZmYK1aNSBcabFrClWEhAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754290284; x=1754895084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OOSzyo7d6/tfFos1hXNw0iQjhEsi0n1KjZ6e/WbQ5Y=;
        b=pLGkxbDfk2k8Z15iCNS4uFEzoQ8BWf69wtBxuEmdiGO9g6Dojzx8m1ai4RLUgfTRum
         GxDIj3daDYdWInm/7usMZxmP8XrCYrR5lbk5doNpGoNamWcRcflSlbVUOmjAcV3P1JZC
         2igfxgLenYD5fwm0DZcd7PZ87xBjf0lDHYMxibpU0uAOP2e3ei2/6MONwDw0RWUDovip
         T5rKcAznod/cM8sbLy8RQcKMQ4jldhAKIehOQ/BTcBukquj+Ua2cZbvG5ryZyTcwkDU6
         XFbYTlUppmMJj/Y0ADS3v9vslPKFqCa5zI2Mqmvl44hjFrLGdbAyuboZfZOQLo+6hpU/
         X3ig==
X-Forwarded-Encrypted: i=1; AJvYcCWUUjelKpMd6RzRR5KG536FBkZwiKK9+HhYIjeNaa9OIWQF+7Aeckyzd50FFmVoQmvHurXKpBGdpUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR0sUi71il7cHAtCnyOkOV33gAJuG0qhj+FJ+nnvJawFCUs6ay
	vBUK4bT62gNa1tSuEHNJgjR8+Tylo0wc3CI1sXMr24yqICjioujxSqgs/LN02L4LBg==
X-Gm-Gg: ASbGncvPzGTv26hwulksDF8CutHBthjskzPtsQ3O241d3Y2TQxhcIamAos2qjDSfi4T
	GoTWEHgmoseQTc7EArlvWKSEItnGEoNhLdxYT8L1mAQD+Wf1tEFlqvsFn6r61u7EX2PFmaBD0TP
	iMNZVBzOf9+A3bvPIhzqHn0uVHa5a8u1kaV7NLpyQlch9OUBOEV9hDzHCw/jiuelcLRIM1QvhJt
	KSmb5fPHsEtAwaHIAWiVzFeoRqzwux7dvxafF2q64UuJ69iqHU+aQDONpsoxE0psKAvZjuL0H33
	xO0C9K9nwPpHifjXb1l7mQOsJ2pWU7ZAmMkcy5Xn7SI2dBqf96We5JqBbXmgDYODzU4GlC3wDkP
	gxxNuUUanHrMtS9ML8dlpD3SDDQ==
X-Google-Smtp-Source: AGHT+IHeG04vWPQLSEI5EHbS/VdNFUYX46iHYs9mR4PwPLXMkV/VqjBr1d8WMag8Q6tl/bIutdGYog==
X-Received: by 2002:a17:903:24f:b0:240:6fda:582a with SMTP id d9443c01a7336-24246f82e11mr124853375ad.23.1754290283941;
        Sun, 03 Aug 2025 23:51:23 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3668:3855:6e9a:a21e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a909sm100170555ad.123.2025.08.03.23.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:51:23 -0700 (PDT)
Date: Mon, 4 Aug 2025 15:51:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	brauner <brauner@kernel.org>, "James.Bottomley" <James.Bottomley@hansenpartnership.com>, 
	ardb <ardb@kernel.org>, "boqun.feng" <boqun.feng@gmail.com>, david <david@fromorbit.com>, 
	djwong <djwong@kernel.org>, hch <hch@infradead.org>, linux-efi <linux-efi@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	mcgrof <mcgrof@kernel.org>, mingo <mingo@redhat.com>, pavel <pavel@kernel.org>, 
	peterz <peterz@infradead.org>, rafael <rafael@kernel.org>, will <will@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, linux-pm <linux-pm@vger.kernel.org>, 
	senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/4] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <cudrf6vttxuxrihqcd5bw52oagvkw7oyvgil37l5iq6njsnqlm@ljgewfzdttx4>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250720192336.4778-1-safinaskar@zohomail.com>
 <tm57gt2zkazpyjg3qkcxab7h7df2kyayirjbhbqqw3eknwq37h@vpti4li6xufe>
 <CAJfpegsSshtqj2hjYt8+00m-OqXMbwpUiVJr412oqdF=69yLGA@mail.gmail.com>
 <19873ac5902.f6db52da11419.248728138565404083@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19873ac5902.f6db52da11419.248728138565404083@zohomail.com>

On (25/08/04 10:02), Askar Safin wrote:
> What about this timeout solution: https://lore.kernel.org/linux-fsdevel/20250122215528.1270478-1-joannelkoong@gmail.com/ ?
> Will it work? As well as I understand, currently kernel waits 20 seconds, when it tries to freeze processes when suspending.
> So, what if we use this Joanne Koong's timeout patch, and set timeout to 19 seconds?

I think the problem with this approach is that not all fuse connections
are remote (over the network).  One can use fuse to mount vfat/ntfs or
even archives.  Destroying those connections for suspend is unlikely to
be loved by users.

