Return-Path: <linux-efi+bounces-5623-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94165C74A50
	for <lists+linux-efi@lfdr.de>; Thu, 20 Nov 2025 15:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C3C135D35C
	for <lists+linux-efi@lfdr.de>; Thu, 20 Nov 2025 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9F2E88BD;
	Thu, 20 Nov 2025 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nuiVj335"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB522D6607
	for <linux-efi@vger.kernel.org>; Thu, 20 Nov 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649900; cv=none; b=bCqmXD2O76iQktri8KRgB1cIMIN0H7EB6BfEKDtN07Bi06c2gEkAmdKn04qcL5ZbRHTE0AJ5gva1ewg+SmLYJmv7tLET3dUHOHB8FCUgr8DxXsIThC8z3iRzP71udctmvjXD/uVAuFpsbfk5IdDaJb6f3hMMv2Xh1vJL2tbZVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649900; c=relaxed/simple;
	bh=ONNkBGi+pAcXAGfOCa4th/uzV5GK3jLbFcpMbgswvGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gosxo/xXg5rGDJ27iEaJmiG2mTkkJB9p0sehFDwnXD6XcTR0vmH69KPyLheQhhYGzAh8xpAbYySrVTYOKew537qClegQI//bz4Fi8gaFDfB3Sk9mpiKVojWQm93icuYLvpQMDcnNq+qGv1RHX/HvSj0UDFqNZSUpLhAAMqeuN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nuiVj335; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-433217b58d9so3986285ab.1
        for <linux-efi@vger.kernel.org>; Thu, 20 Nov 2025 06:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763649896; x=1764254696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIxJYE0wvk3wLqfYeDU58+f9Hu//Bm8wil67l0346m4=;
        b=nuiVj335IoySHCd5luaPE97MZ0Dk4VSukc1ZbgfDl39ep4bvbv8EfLH5YOJy0hY5NH
         /JPwKejoyOxaLVlawIJpej0B7dCREpkK4rVaG7Mw7zwBT01grcKpkrlqgku3FVdrp3iW
         L0w3choL0SRI0FirwVpbvHIaHj/04iCmXxZj39Nt55X/K2kOPDjNwIPk80byDFbBEM3T
         JG3XBK695M3riS7Sa1B8SqRa8hbTWiCvIS8HbwVfUhXh68bUjQRpVgmvO3CH4b8+9pD2
         ftGBkUQITW1bn/iFbuTQzV4bYTOTTTzmZAmr+U2X160XHKMjxK5kaKyYNcB7TrxRFVoW
         xiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763649896; x=1764254696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIxJYE0wvk3wLqfYeDU58+f9Hu//Bm8wil67l0346m4=;
        b=wqgqZL43R9quRnt0lFIjCKYC/9i2Hi+TnNdUXHDRUORzsUw4MOvLclrmFPBwvPn16y
         i6Jmpsoenk2Gnlrbzv6LgNOHknNBeplkJiFk1mpNNjpPO3wJw8bHkOc9ObskYctcZolZ
         D3Br/Nbcr4vMX0qlMrN3ROdErpD+ACHsylCpD0r34bnhvGPhgD955ahH7pad5C5T4wga
         9HjyZCoNw4Bf8uK58dOJQnshMpcNqZBL8rOjrYNO3FAono+l4i8gF5wdJtR0MgvGEcz+
         mNbccQaX8VBtwkt55+Wa3jN0ffO/bdg3SwFs7avWUXFwsXm9UgCTKjwLkaAbH7ZPJS1O
         3dMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBekL0Pj+lj8GVhcz0NImpspwWjQhKXjznk166Q6N2TlAlTLTVlsay64aoD5QTM9BFcnJ8D2qSrDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFlba6iifcd2IW70rJZk7/vdgwhnkSdPvA3kYiHwz47uwPhFvv
	4haAuHXwi+IYOAbLSGyRgE/Ap1hYc07zoM/3FLSUeUuG4OxudcGExwIbpVcSasZ/qW0=
X-Gm-Gg: ASbGncssaK0TM0cSwkzoLOou8nt4nO/5GprGOIS8cLZwNvpD259LyVE7lGsplJsL83K
	Qs3ci4HMiAC4aUMNSage/rwHlWc+OPbbF1UpsdQVJ1kW8ffeAOodAcRhcuW83tvI6xaF9xDQEhd
	Sl9qruS0jOUg6GutB6aG1J7yQ+G781WkXktA1Sv7sUr0BLpw0v+sdajHL9nmvlPX3rpdAlb03LJ
	meKTUKTy5SgFKjvf4rT9fzqKDLbSOB9rMxSrqqV0LF07BFmtD7oh2SIjDULdOPe199rsL7064ka
	LUSd8UvRl9koMyNi6WLXTvOoaS+ZcWPJ4/mLXRd8SWugWcdhz6iOSbxLB8z0jR1a3X4RdIegU2P
	aPWd9YFmjBYm2k1R9KquTLPLHbYiTITFk7oRXb/ZAfc2AF65XUIRq3pNjGtec7lAJxYHhnXYTwm
	TH7HnM+Q==
X-Google-Smtp-Source: AGHT+IGH129qdY0Bs8r1fTwuv2Zd+f3v8A11zGOrfEH1/mLJCq3AZQFHWR1rZfoTVBVyrWsHXJBc/w==
X-Received: by 2002:a05:6e02:3a03:b0:433:7e2f:839d with SMTP id e9e14a558f8ab-435a9074d95mr27932015ab.21.1763649896290;
        Thu, 20 Nov 2025 06:44:56 -0800 (PST)
Received: from [192.168.1.96] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a905e7fasm11606795ab.14.2025.11.20.06.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:44:55 -0800 (PST)
Message-ID: <32c1c5a1-840c-4faa-91e1-cc9165a7f241@kernel.dk>
Date: Thu, 20 Nov 2025 07:44:54 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/44] block: use min() instead of min_t()
To: david.laight.linux@gmail.com, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-efi@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, Josef Bacik <josef@toxicpanda.com>,
 Tejun Heo <tj@kernel.org>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-13-david.laight.linux@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251119224140.8616-13-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 3:41 PM, david.laight.linux@gmail.com wrote:
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index d74b13ec8e54..4e0c23e68fac 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -472,7 +472,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  		seg_size = lim->max_segment_size;
>  	else
>  		seg_size = lim->seg_boundary_mask + 1;
> -	lim->min_segment_size = min_t(unsigned int, seg_size, PAGE_SIZE);
> +	lim->min_segment_size = min(seg_size, PAGE_SIZE);
>  
>  	/*
>  	 * We require drivers to at least do logical block aligned I/O, but

This doesn't exist in the 6.19 branch, dropped.

-- 
Jens Axboe

