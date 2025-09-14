Return-Path: <linux-efi+bounces-4822-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCF9B56C59
	for <lists+linux-efi@lfdr.de>; Sun, 14 Sep 2025 23:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B2117A9E6E
	for <lists+linux-efi@lfdr.de>; Sun, 14 Sep 2025 21:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79957224AF7;
	Sun, 14 Sep 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j+82wh8E"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5D1A9B24;
	Sun, 14 Sep 2025 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757884613; cv=none; b=msZdq54QfftFZRQv+bUJkEWihUKmgrb+MT2+/ovjp+KN/jX9ApgfCQgUoAcLgvFUUhqWDfk3dkDs3GgJRbwL6xbywTyiUapaqN6zCpYkklGr1jGvHi7ZuBsd7dOqtyk1zhtsn7rOLZOCcZVe4RfqsebeGm2ZmB0cPSpsh0H8/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757884613; c=relaxed/simple;
	bh=IEMGqZNj+OZ+xb84qevmEGyeadlozAYKBVxKCEu+PJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzCmo6Xq4Bso8FjqIy00oFZQpJR/6mtp77XW40zd68gWK2B7t+XBKT+s/TYP+FS0b5b0ef6cT5+ZONlPajVH5g1tvrRSQsuOzmZt55ZGeBYKjZrizcFH+T/d44YbCwmjpFtB/L7LufAv61OM2V0Y8aDu9LYRCdLPDTg23yEW5QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j+82wh8E; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 43D6F1A0DFC;
	Sun, 14 Sep 2025 21:16:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 092936063F;
	Sun, 14 Sep 2025 21:16:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76865102F2A78;
	Sun, 14 Sep 2025 23:16:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757884606; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=PrFkxRI/rM5SQxoVJY6C6jishZsikS57oIN/hwunQlI=;
	b=j+82wh8EW/26ftt8B3pTo1EF6a84LZS/ds3nQRpCwbhT3EnmTALAHRvlO8AaJPUcIhLHT/
	gl6jy60jXJho+DItqUqAiO30JedIhLNi6Q8iHiliohdlf/U1fzqVAfru1ocswYYozJrZ6b
	G8T1SuFDUk3FEl5M8tYxF5FckzXCm3SvxGXKysA2w/fNni0aqN7/YjLZ7Qrcx+e+82gmuN
	TrF/Uq8mV4ZHEstaLbfM1ST8YeXhs0i1w7ilUCrIHelmL+RBtOtGJN4y4l7FAtcPFuJc7e
	9AmDmRUv8YBvnRbWBiulqtUTQeRPGkyMscOZZNXSS0NMEANY+15EN7K4nD8YnA==
Date: Sun, 14 Sep 2025 23:16:29 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Bibo Mao <maobibo@loongson.cn>, linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
	x86@kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev
Subject: Re: (subset) [RFC PATCH 1/3] efi-rtc: Remove wakeup functionality
Message-ID: <175788449957.388732.6353062596898107602.b4-ty@bootlin.com>
References: <20250714060843.4029171-5-ardb+git@google.com>
 <20250714060843.4029171-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714060843.4029171-6-ardb+git@google.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 14 Jul 2025 08:08:45 +0200, Ard Biesheuvel wrote:
> The EFI rtc driver is used by non-x86 architectures only, and exposes
> the get/set wakeup time functionality provided by the underlying
> platform. This is usually broken on most platforms, and not widely used
> to begin with [if at all], so let's just remove it.
> 
> 

Applied, thanks!

[1/3] efi-rtc: Remove wakeup functionality
      https://git.kernel.org/abelloni/c/50562f9cd366

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

