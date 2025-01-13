Return-Path: <linux-efi+bounces-2613-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63789A0B967
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 15:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A4B3A3C5E
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95023ED7F;
	Mon, 13 Jan 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcU3KHsC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB12451C7
	for <linux-efi@vger.kernel.org>; Mon, 13 Jan 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778364; cv=none; b=uw/q1OBs+717rxryD6RzafI7Zi+Rc7vqz/4CMp6C5J0uClBvH6uwKoeXjOWobvd+JiD5h7cE9l5FXkI8bLQyzi76xASBDXw8E3p7Pbv1CfXy/7Migvc4QcctAUNu3foIjKY6s77T1rb+L36BiRxLoLm6+UvcPruYfBHNZugy3Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778364; c=relaxed/simple;
	bh=vtjFb22sOyYN0URjnHGpdOp2r+nchub7kCKSAjg8r1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+iUyZmYCjWKBOIQ6Vab3xxum0I5J0+s881hQ1oyMrkyKLHuev/+EEyU0826szmKQrdg2mv78JVR7RSxtN9y96X4mOkEcV004VhzVYZimZ6Um4kUURO8GH1/QJKoErKpdQ3nNy/LJGMyGFWs308v3bs0+qjwzF17cmw6nGldpXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dcU3KHsC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa679ad4265so1023041666b.0
        for <linux-efi@vger.kernel.org>; Mon, 13 Jan 2025 06:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736778360; x=1737383160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbGS74CoYRC6HITNgfJj5iVQRYRBtTPZjkH5gxrs3J4=;
        b=dcU3KHsCK26bfVBwmKb5enz2JpzCdaFmKMItbdbUBSYvuJjJvZqG2hW0fbPAJ4QyBd
         HkXOTLgMy7taud/WK1KF4M7tjdZziXae9m55/eSkWQfbNSvodfDiiLCECB3FWCmLgpAs
         W52UmvpwPKYGE8vghrsiu0LucyMdqnesK9qXjtG35qbx9G6dAGGs1U4lUuPLbTNt1PXv
         2reNL8ShgecaYOGhTNfP/Ul48ay4OCao9VCtzPdiQ5seayguoCRx8i1BTASFY8DOuCdw
         jP2q0HUIORfgt7n357W2MIQ2RXEzthszujR3Hc5VJUv6VMqWK4YP0WbiJnXGkHbm46Hx
         oimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778360; x=1737383160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbGS74CoYRC6HITNgfJj5iVQRYRBtTPZjkH5gxrs3J4=;
        b=Wh64RpPsCM8TCakkwi14U6zCdZlahY+ALNMEYbdVxyx5o5RJbQDS6FaDTk8vyH1o/w
         PZiTHPyov2qFafKAMvnR1NWsG6tua8zjlPds0gVa/vmgoGRjyUS68Esbdxr4uo5mGqDJ
         3mHY29aEWK88Xw9FY9EhD3UifSLYL50sL3teHi48jCiA7pawOWGBKHbQtK1gtZod7mUk
         NoIKDYuO73tNCRLS+dGMfUGs3iCfuueUsgsfqoi0QT/3yKPbQaDJTlr3GxuSO051VA4h
         1KVIa3vfhNW4JN3PNPjaAML6SJk2yv7ecHzxzrCy8F6QTxbHkC4KtmBLEf8Q/izIXmF+
         Yc4g==
X-Forwarded-Encrypted: i=1; AJvYcCV+wjThjlI/k4tLrcOcT3m57yAWB0hB/UCDJrvkwmoCdN04LDFRTNJ+Xxdnwu4u3knotXSBu2Ia3ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBsp6GbVl9i5Ojr+w3fLvVlOdLWjbUYN4hOcv3LR5lRTbZTWy
	MDhO1qWvtZzwpO/CV89jq28KnkQ2AxH93NUn/kqPUPJCtmlxczXZfJzsaAIqo3o=
X-Gm-Gg: ASbGncvFiWTTCRJ9uVNOi34XUFs8+pjFkmie7yZsFaS3ZW7b/wJUKGAxMpXGMSf8Dac
	r3IFryrKKSl/KyqW5fT8sV+obl5sn4EfPhib95Yyg3P/UytW3pLA9lqmQpeLWEEa13a0O7LrxJk
	UdQHHW+AMtUsvmubSidlaafT/hwaj0FqTBLz1GmvZ5b2B9d3xp8zNFcwSToHtb6vxJFV9po5ErI
	ax5lWrTmsS89fS1CD5eNGDJyU+l2nuRqfUleeSLHsTcF3CoveY39FNG5LyQMA==
X-Google-Smtp-Source: AGHT+IEnKdGkClwyG7opxWkRcljwnKOVs7IVEdnY2tiY4md2d2c+zHEDMbTCN2pklGV0IVCxeDqfqg==
X-Received: by 2002:a17:907:3d91:b0:aa6:7ff9:d248 with SMTP id a640c23a62f3a-ab2c3c452c8mr1603204866b.8.1736778360297;
        Mon, 13 Jan 2025 06:26:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9060bccsm503321866b.22.2025.01.13.06.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:25:59 -0800 (PST)
Date: Mon, 13 Jan 2025 17:25:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] efivarfs: Fix a NULL vs IS_ERR() bug
Message-ID: <68a5cabb-c5b3-4090-b9be-bdb34ea5a35e@stanley.mountain>
References: <7f7565d8-ef9f-4e5f-834b-9735db01835a@stanley.mountain>
 <CAMj1kXEt6DJufw7Jv+nWYzt=SrBsiTmRrXeRZFYdA5zC+3M6kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEt6DJufw7Jv+nWYzt=SrBsiTmRrXeRZFYdA5zC+3M6kA@mail.gmail.com>

On Mon, Jan 13, 2025 at 03:18:05PM +0100, Ard Biesheuvel wrote:
> On Mon, 13 Jan 2025 at 07:16, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The kernel_file_open() function doesn't return NULL, it retursn error
> > pointers.  Fix the error checking to match.
> >
> > Fixes: eb11e99adef8 ("efivarfs: add variable resync after hibernation")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  fs/efivarfs/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> 
> Thanks - I'll fold this in rather than apply it on top though.

Sure.  No worries.

regards,
dan carpenter


