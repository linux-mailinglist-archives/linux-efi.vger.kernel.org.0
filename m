Return-Path: <linux-efi+bounces-2163-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A59CF418
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 19:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C22CB2C2E9
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0C18732E;
	Fri, 15 Nov 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqkC1QSn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCA12D05D;
	Fri, 15 Nov 2024 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695779; cv=none; b=kXONaIQG6zc8ITnOTiQqZZj5knIn3eb4jKrF0oif32gFb5ZI479umhep6N+bzpfjBHjjQz1is4uFVz1U1y5x7ihKKV3sC8ym0nvfs2q6b5D6+CoEFugjwXTRK0Z6s0k6jbQ6tqKGuhQmS9LrZv0Emng+q8UVZbK3p/0WXbbNhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695779; c=relaxed/simple;
	bh=PrdkLr/EQyTqrtIGHA4z4OxH59XHJjGhfhBo2e8efow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axrpp8VVPOPImpxC+8DzFpdRLP5WkQ+3oJPNIE3hgVnpAtZNLtGyXPbd6hy+FFM8th5q46o87FPjxJgISO7qAK3rEk/SJRmWyiUZRixGtv074CU2qpsgLI/ItKSDmWWW/FAYl0EZtxqy50onUYduKiO//8Q/2jZFbgCUVzIZyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqkC1QSn; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso21527831fa.2;
        Fri, 15 Nov 2024 10:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731695776; x=1732300576; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnxqbvpvlpG+oeSwyVyxhaOUpVslX+0mk0k6Mxf+aTY=;
        b=OqkC1QSn4u93hHHFUKqS9QJ8zqhMl3OTSpNRVwSFke7e//cpevLCVxDMYR1RDNNBPB
         +W7NY/+1fClxv7HqswnGd9cBVys/pxa60pclPclKNZJ1czVMwN0jb3idcvFqdZCPHOOe
         9GiN40OxEPbgnIqR1T3tD9YBOoJ9Y7Qvkfh6ZNa1TROpXJO6waHnKn4ITFbp4md6vWjh
         XxrYkcdz2tFB/F0xO8a3iB4BnxZ4Oo80sftVFnrvJJzz6J2xpqpTq6HB/mAu0b6wFP+T
         iUBaiTQtIgNcUmvjCRccdGNwYUohwIlO3P2oKyTDyQgxveGcSLpz++6B+VcrgfmkHkwH
         KLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731695776; x=1732300576;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnxqbvpvlpG+oeSwyVyxhaOUpVslX+0mk0k6Mxf+aTY=;
        b=V3kPmavtO71Es00whlSg1JAdwoVPU12nd3COUbyOIMt3X96jcdmXQ8ie+7KdldZt5A
         cpGsCGhX5TP9EvaKWyhYRqWh5Hz6xY631BCXHh4gV70xURpd4f2ZLdPdVbnwJ6zpoq/S
         ucEyNqN3fSL5MJcUGbeeMo8S8iffjOqzcd2KP7PrGQRX8WBil/XjlGhrcYjj7tUR8l6a
         +/PKLjESjx9uhw4tq5xTV3nVbLu+FrSWnegjEQo4jN+LUWlENGH5tESLN5ueU9T1lwmI
         72q5G3UBuPwT+/oC/O/kxGqO7SPm0DE5y6+QpOm181FC89c8B4UW88ZOVBvmCO7GSzIm
         jZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkshxID30M3Zp6icE1N3xjMsHMtuy0nLLVZIZLfSh3CqmYO8f81iMoxT3XVdNXkIu9Ll/0qJAE/Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxFo/bEMezFc1hOfDIK33dksbo8YCfejWiwibbbEfV3bLjSEP
	Vg5wwKrP0zU1KKlbbuDagXcmqmTaZBExeo2g7xL/oLgq9IbD8CoSiGmxl/Ld
X-Google-Smtp-Source: AGHT+IEKUHqvqLfTE1UeZB502FbEu11dYN46SU1bWuAYi8xeIVnCTMXyOlyJFqdwv9Pc/HfkVWjzLQ==
X-Received: by 2002:a05:651c:220c:b0:2fb:62ad:89fe with SMTP id 38308e7fff4ca-2ff60959422mr21175421fa.16.1731695775305;
        Fri, 15 Nov 2024 10:36:15 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff59859e07sm6169141fa.91.2024.11.15.10.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 10:36:14 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 5970C5A0061; Fri, 15 Nov 2024 21:36:14 +0300 (MSK)
Date: Fri, 15 Nov 2024 21:36:14 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] efi: Fix memory leak in efivar_ssdt_load
Message-ID: <ZzeUnn99B47FAA6R@grain>
References: <ZyizcvscUWIyZYdE@grain>
 <Zyi11v-6V_ivKS5x@grain>
 <Zyi6g8W0OqKcng6S@grain>
 <CAMj1kXEujWSOLjtwqSrmeP8yxuYof_Vn-vPVFi+gA2m=p64sEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEujWSOLjtwqSrmeP8yxuYof_Vn-vPVFi+gA2m=p64sEw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Fri, Nov 15, 2024 at 06:02:07PM +0100, Ard Biesheuvel wrote:
> > It is still unclear for me why we don't exit with error if acpi_load_table
> > failed but continue to iterate keys and don't report a caller with error
> > instead. I didn't change this logic for backward compatibility sake but
> > still looks suspicious.
> >
> 
> I've queued this up now.
> 
> I think there may be cases where it might make sense, or at least,
> where currently, we might rely on the behavior where acpi_load_table()
> failures are ignored. If a table references an object that does not
> exist in the namespace (e.g., because some I2C controller is
> disabled), it might still make sense to load remaining SSDTs if they
> describe things that are unrelated.

Yeah, sound reasonable. Thanks, Ard!

