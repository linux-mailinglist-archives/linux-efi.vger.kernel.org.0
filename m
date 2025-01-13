Return-Path: <linux-efi+bounces-2609-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4438A0AF2B
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 07:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABF43A065E
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 06:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F2230D38;
	Mon, 13 Jan 2025 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ihd6Kn3F"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676ED145A16
	for <linux-efi@vger.kernel.org>; Mon, 13 Jan 2025 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748962; cv=none; b=YMX87IRVJUT80VeunCXo3uA/DWQ2aa2ObvjeiXpgapQ4UAMJpHvgQF196hfGJmIJxv05RxK80XAVYQ5rwSCyRaWuzjjj/JrWxRPHtc8c4V/maJzlDyj36UmyV7bnhbk8RojUqO2I7VTZADeEg8NutgICN3zUYDGrgrq7ljUgP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748962; c=relaxed/simple;
	bh=HDIQlLSSIWxnjcOUeF2giiJnQXHfIYD0kokOmD+7EWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hNk4UtJCZjaUfcsgVQZ6F02CHieVYa8xnZp2E2h0mdcaKlbw5uNMNpLGTFSR5mRZ2M+CAbpksqNTXblqmIz3iaJTunQY0mxxjgN147lsIE+tkOgg2TMhWUqIrH0HC/+H07VMs1pC5u7xKTi/7jMnhQ5pC83Gx59wfaCwfqv6BpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ihd6Kn3F; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so5846616a12.1
        for <linux-efi@vger.kernel.org>; Sun, 12 Jan 2025 22:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736748959; x=1737353759; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pjJbm+GL3xMGT2PHevSgzgHjM9ueX6e0WLe9Qs+akw=;
        b=Ihd6Kn3FkxeURxRXPXJUVdBVw1v7iOaCLXuOfosE1vSAAlXrFNaMyg1W/DyP1y1C23
         Tei1iWQwWc46yiJegF0/Ese1+0/N4qYAOBRxhUt1NoxokZ48avxBTGMP/Y2ia02ixnNN
         HAgyYKt9rMS8dtGGIRCYlYbq74Cd+Xvn8yvHUWFuGWWNahmS270T9T5yNM+1iaO/C2dW
         zHwdQbMmmuYRlovfzMVlkQEMdFG9Qse+UVsgQ5VJp6yzFp56lpEuX+QP47APZCpJr+RZ
         Zua2WTZAY1g//Qyzplq6+Iyhh1Q+vyVgkM00/rTav/OAJHVYqOYXjJOK+uF6Qsf777KQ
         1PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736748959; x=1737353759;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pjJbm+GL3xMGT2PHevSgzgHjM9ueX6e0WLe9Qs+akw=;
        b=CqpkwAgmCwiqoFTQg1Wdyyg60oLButwmbTKL/hjUkv8CAi7O3AMz67GhifwTX0fmzR
         m/me+rZm+60NLFX1DvG9UG/j71KTOuhJysG98PmLXTjX6jXcxp/1SSLLtySio2pLeWYV
         9wjp0ot2oEoXcBUcReQVnQC5A5ye5496wrLM6MR90hGTkGaj9OYk37+Ofcv3K7+hNNvD
         NzkUu4FQ7y2+yJMsM4UchO7dZOMHeVweOvgShw3Pc76J2I8UqaDaO16JyZy03MVvlzPw
         sBHUuKZOXKsqsiqxgPh3OhoywmmAAVRKg4rn0oXfdw1NBqm9IWtGwvZxKCxAzjDvMJxI
         DCGg==
X-Forwarded-Encrypted: i=1; AJvYcCVhb6/O61TUJ0RUIsGHJXU9S5DRub3nVuD4lML/FypUyTVQ98N5aL31o7ckNfNkBaXbNok9R9s86fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCOQNxWGbtKxnXRTOOiPplGaQu+CuOZ0BqY0u9l+nc5nt7pr8
	FI3V5PM8ABJErIFVUxufaOtSWNTkfdwaOedKdEFlSw2ujeFhDBKlXnQlTh8BsBU=
X-Gm-Gg: ASbGncuRdLkQA7ERIzIuoyfZu4KOeAjrQ9+BQsmTO6whlt0Yh532lG87DRwRZStUlAQ
	1Q7Z7xjove0fF8P3t3WZJmjYf0cysQK4j0FRdfb6fZeUemHBS/+qAMh/AhRocL9QgSveDt9x35N
	MCB7iGAFl4LaeDMhWD1TrJAyoT0KnLGp11+pOPZihj3fhBarLh7kI2YouP8tecvCcAlyi+xVVtX
	5709cVvO1MFCt+lTAMDDgWadSadshesDmb2/6R+Py6wF3hRVp6X/0NlTG9edw==
X-Google-Smtp-Source: AGHT+IGq08j5sMzi1AzMjZ1y83V0c4GO8GFxsXUHAj6RdJN05L0egWonX5MsDLpHWtkmf38w3+RFfg==
X-Received: by 2002:a05:6402:27cd:b0:5d3:cf89:bd3e with SMTP id 4fb4d7f45d1cf-5d972e708d2mr40816202a12.30.1736748958783;
        Sun, 12 Jan 2025 22:15:58 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c4477sm4308820a12.51.2025.01.12.22.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:15:58 -0800 (PST)
Date: Mon, 13 Jan 2025 09:15:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] efivarfs: Fix a NULL vs IS_ERR() bug
Message-ID: <7f7565d8-ef9f-4e5f-834b-9735db01835a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kernel_file_open() function doesn't return NULL, it retursn error
pointers.  Fix the error checking to match.

Fixes: eb11e99adef8 ("efivarfs: add variable resync after hibernation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/efivarfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 961264f628dc..968e4af7b7e4 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -492,7 +492,7 @@ static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
 	/* O_NOATIME is required to prevent oops on NULL mnt */
 	file = kernel_file_open(&path, O_RDONLY | O_DIRECTORY | O_NOATIME,
 				current_cred());
-	if (!file)
+	if (IS_ERR(file))
 		return NOTIFY_DONE;
 
 	rescan_done = true;
-- 
2.45.2


