Return-Path: <linux-efi+bounces-2122-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0F89BB3EB
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2024 12:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBCF1C20894
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2024 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB21B0F2C;
	Mon,  4 Nov 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5AJpkIC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3081ABEDC;
	Mon,  4 Nov 2024 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721242; cv=none; b=BQ8xxNrK1WhvazED1MebD3GBpmqIcp9K6p9HYWjE9bFR5c6FbAkqkUl555s1TdxAGY4H1csxfIuwueYOzs+vZnDqhw1LZTn4hTfMYA1h6mi8q9f0QzGXnDZJ56QzZdQHmoa5ZTlKLhY4cNU2q+UHPJjl/ICJL9Kmm0DvLibIhgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721242; c=relaxed/simple;
	bh=9oCCQHDIR/wWCebYEb4OwIHMj8KuW9UZvQqffw9+o6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRNHQjuciL20fNiS9QxtTigk9F5YB/f/R1SDc9rxTNNcfDf+kGc+blJ/7Ux5UZyh5hIFN0SNkCMz0W0R9ZmCy5aPysbun2TlWqd/Kc4GVpTyNoR3a7o/G3kYoPZPD0wxPsmVc/BVAmOU0X6r4DOf1xTIgI1pla2004SKUD+8Bug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5AJpkIC; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53c73f01284so4568930e87.0;
        Mon, 04 Nov 2024 03:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730721239; x=1731326039; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oCCQHDIR/wWCebYEb4OwIHMj8KuW9UZvQqffw9+o6A=;
        b=g5AJpkIC1Pv+KFrlzB60ddZaQWe8r8AJ3owOmCDgiu7xuBjRK0xwqVmUxUj1TUVU03
         nPiPIzXqxwbAtEBjshfGADkZTv/BnQrCwcsSm6jM7uhA1wBySTqlkVd1G8QG6iwbXGJN
         VYOX9X2IfDYeY4r4e6vrhrvE6oa98cyPK5Yzz4mtx8jiW3PE7bma87E3DDp0GtzIGtTM
         VdMYgxQSMcFQGn8jpNPX6SP4+lVfA7K0EWM2ingZHFxD/mbp6dpfOuAFY75VLdf36VET
         bzCTb7/xPcuc2KCzc0s21gNQpyj/hRdSgUqZ2S3yvxrZatRD/0P700t53nV3r9FF7xWc
         OXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730721239; x=1731326039;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oCCQHDIR/wWCebYEb4OwIHMj8KuW9UZvQqffw9+o6A=;
        b=meKH3pan4NYC6SsJkbVU8Oa52LUBCw168IMmbuXS84xukj8f06fRw3Q/rdcu79wamw
         E4XWagJNCuC7qqFaI9Bi12ws/vWuNlUd9cTKeQU+tmzG2LSaNg2qLnkssQdDM9CLOYPe
         vfYhoLdRf7BByeTvWsyWCBsAgSBub4SO9vWcdrvwVPeDlDuftG/GNF4kZIHXJK9rukTU
         Arp4hCB6OhydlUx6nN1gHPAnpoQ9wzFj7JIDNE6kfldQ9/vp3DEbzBoRaDE1+yKbNAzK
         Ldrc1wTCNa+gXKLXAvjkrv7Uw744v31PVQSVyq+RRoXBxbSQm5Ud9GSqBeJjZQd4CcjE
         pO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV745LInLkf3qIH+a5+GW+WRq8TW/j7xR8J8uKDwXGyqLIep4sqNozrQnNwM1kUVF6YetZB3JUp+pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHJvuagauivYCbSNJ/Crv8Ht4OYpbpCfPfz01XP3tRICQLV+l
	4vzV1IwW1T+T04M0M01ZZtV43/3XLsFBUhEM+d1KusTrRVtzbnGh8ZgPWjqe
X-Google-Smtp-Source: AGHT+IGoCujG4x/64wc2erIbt4eP01F1+dPTpxpuUjLqJXFQuIDmFkMWs2YUZdOQkcHx/cdCHIiNFA==
X-Received: by 2002:a05:6512:b8a:b0:536:54e9:3a63 with SMTP id 2adb3069b0e04-53c79ea562amr6688287e87.49.1730721239007;
        Mon, 04 Nov 2024 03:53:59 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc96281sm1657553e87.15.2024.11.04.03.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:53:58 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 34D285A003D; Mon,  4 Nov 2024 14:53:58 +0300 (MSK)
Date: Mon, 4 Nov 2024 14:53:58 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] efi: Fix memory leak in efivar_ssdt_load
Message-ID: <Zyi11v-6V_ivKS5x@grain>
References: <ZyizcvscUWIyZYdE@grain>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyizcvscUWIyZYdE@grain>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Mon, Nov 04, 2024 at 02:43:46PM +0300, Cyrill Gorcunov wrote:
> When we load ssdt from efi variable (specified with efivar_ssdt=something
> boot command line argument) a name for the variable is allocated
> dynamically because we traverse all efi variables. Unlike an acpi table
> data, which is later used by acpi engine, the name is no longer needed
> once traverse is complete -- don't forget to free this memory.

Drop it for a while: found that ret variable is shadowed while compiler
didn't spit a warn about, not a bug but better fix it. Will send v2.

