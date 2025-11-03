Return-Path: <linux-efi+bounces-5332-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 741A9C2AF54
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 11:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F2EB4E8970
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B342D47E1;
	Mon,  3 Nov 2025 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeTTng1v"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F12F692D
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164925; cv=none; b=ob1fY92IqzJ8K3hbAnDUFwidN6d+Yk6m6NlThnWx9hNu/F8paNfghVFg+Rvjj0H6Gzc5OkCjHaGp1AZDa5SZPEij6O/jU2V1hyKxmVlPg1lQfSBy+0CWCuB8G9Db5CM3hoPIbuialVey3iqXBRAM0vzgP9ubKvXtdResKpqPPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164925; c=relaxed/simple;
	bh=xhQO8VSkQ5GiDk0IBRGYq79sb3rh8+nn0C4F5uknl2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmXaro9sBxNp6cN0C/2QpeX14Q5fTgqhlezIWWKbdUzrVFh0VLuu65dojQZa0SDQLr3+qub6LP7MQ96uZ3T1JO/sqpZMAhGZrmG1TwCqOwrdnZy0e06seaTGaRIKgr+vewL4EoBWI6QuYirtd7lfOE8k6bzs5TVdbdivABYnlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeTTng1v; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so1772512a91.2
        for <linux-efi@vger.kernel.org>; Mon, 03 Nov 2025 02:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762164923; x=1762769723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iYBAGRnwsaVRtnZ90Ik3LNRr3AXYbWscAtBfejKw57Q=;
        b=QeTTng1vrLOWiJemyTTniBAa63osCa/SCR3fNHV6ob6biaBcEIA7iG9btGtoF8jJhv
         HzzDBNU8BdoTZ1wNVKdCvp3MHAX3GF5Gst9BxmJSlXCZk5MMXUSuSYNOwiXPkq0bBg0W
         WLqtxk5+zcgzekjKSuo9g0LDegOHkqk0OF+yDqDrg8gLPsFNnvSCUzh3sMNFFBYPXbDU
         982lmbdo/g/e3tTd5R7+1XmzEXsu31M/Wy0TgcZsZTBVW2MDNYWwgMQNu2L9YO1/zAto
         s1Bz1pxoSUGiXgbbbqTeIBhGabkI094vrMuzkVDTTiSDjfr4WRHakR1nOD4GCL7i3ciP
         HZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762164923; x=1762769723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYBAGRnwsaVRtnZ90Ik3LNRr3AXYbWscAtBfejKw57Q=;
        b=CAonAy+DXrnYmrMPzysn8XfQgR98GHBrAXL0wLX0H1xKT2OK+ssCINCmXJ+qLS4Fc0
         qCtH8Ohd6+dC3xagyNaXfskFbwbmXbrCCwN4VBKYb959TunREGBgLts8xshOl/OlH6e9
         +6Vmb1YupPVC0vQBdmUoTqT/aH39a0lEVeZoQHkln/8gTqbUkaUVjC8amBaiye1CjMyJ
         TDZDIbUpy7FpEbvx3LnJpdTOPcJ47f/Wek8l32aaWj0GcjLLEbzcPz8ZbAVwzWv6en2g
         0YUKVQzyrxdFzqRXZ5XT3sb7scNRVlKR6VLbf7ZIdTE7MOhO8QAJJDficq2JQI4YRTQF
         jx/A==
X-Gm-Message-State: AOJu0YxmD2vmMRjBwevuhOd9gwVkVK/wujSvqCG/yZK3C5WR6kRVg45t
	DZFHkexBhtNPfjTCwIW/jv3iKSo5KownON3gkQxbWfzWSR/3DyZ5CUxmHUH9QY/b4kGMOjn/6G8
	MFdRrMCjRcr347lR/nOAqy24ZrXbT+5U=
X-Gm-Gg: ASbGncuQHXVdf0CYA+bnG45hwTbJ5AjSM1PwT49FLexzJfZGrYUHdgxN+m8doIGQOYo
	Yg4qd756Iskl1OD2j4ZEr3YC8mIXgFWWSSwMEVsZtfFaQmPZ5KWt9VSG4qu082TzkcLz/1ySXYF
	76PAJ6b0hgVNRJiBBXjJgeBU2GfNTcK4WXzSU5IWQfNucqaq/8jIouG30kKUmkWo1mcilA1N4qe
	3tklheXKmuVU6UmO9S0RamnhZ1bPZhBdxKJubApO1htvCdeXOdcMooG5GBrE9CBEabSLIw=
X-Google-Smtp-Source: AGHT+IH731P/OM4biNBl0y9xM2WQLcjL6aUh11HRLuKUDQBtvA91xGIKvKfLk6tpKhtCc/CbcHnr0Pf7BOct6oQgsj4=
X-Received: by 2002:a17:90b:3a10:b0:341:194:5e7d with SMTP id
 98e67ed59e1d1-341019461bamr5569334a91.24.1762164923261; Mon, 03 Nov 2025
 02:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102001411.108385-1-francescopompo2@gmail.com> <CAMj1kXEUL-Uv4tCx5NLVHDRo-BdEK1xJdee-UYs-ymE-mLxv0Q@mail.gmail.com>
In-Reply-To: <CAMj1kXEUL-Uv4tCx5NLVHDRo-BdEK1xJdee-UYs-ymE-mLxv0Q@mail.gmail.com>
From: =?UTF-8?Q?Francesco_Pomp=C3=B2?= <francescopompo2@gmail.com>
Date: Mon, 3 Nov 2025 11:14:47 +0100
X-Gm-Features: AWmQ_bm6XkP9BhW1ynD6Eq0mHhXY8svSBp4RcRzoqXvfgMS3u1RZvKcKQbULyFw
Message-ID: <CADr=TJdTcss14P43_jAj4tsEYukt=Z18SnjUNqMD95O_5KkNVA@mail.gmail.com>
Subject: Re: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 3 nov 2025 alle ore 09:19 Ard Biesheuvel
<ardb@kernel.org> ha scritto:
>
> Hello Francesco,
>
> On Sun, 2 Nov 2025 at 01:14, Francesco Pompo <francescopompo2@gmail.com> wrote:
> >
> > Some UEFI firmware implementations do not provide the SMBIOS Protocol,
> > causing efi_get_smbios_record() to fail. This prevents retrieval of
> > system information such as product name, which is needed by
> > apple_set_os() to enable the integrated GPU on dual-graphics Intel
> > MacBooks.
> >
> > Add a fallback that directly parses the SMBIOS entry point table when
> > the protocol is unavailable. Log when the fallback is used.
> >
> > Signed-off-by: Francesco Pompo <francescopompo2@gmail.com>
> > ---
> >  drivers/firmware/efi/libstub/efistub.h | 17 +++++
> >  drivers/firmware/efi/libstub/smbios.c  | 99 +++++++++++++++++++++++++-
> >  2 files changed, 113 insertions(+), 3 deletions(-)
> >
>
> On which platform does this fix an actual existing issue?

Hello Ard,

My Macbook Pro Late 2013, product name Macbook11,3 is affected.
Specifically at least the firmware version 478.0.0.0.0, released on
01/13/2023. I have no way to downgrade to check for other versions.

From what I have read on internet this should not be the only model to
be affected.

The issue is that apple_match_product_name() fails to obtain its info
via efi_get_smbios_record() and makes apple_set_os() fail too.

-- 
Francesco Pompo'

