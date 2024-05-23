Return-Path: <linux-efi+bounces-1076-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C6C8CD0FB
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 13:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8FC1F21870
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B5D144D03;
	Thu, 23 May 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+seZe7t"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81313D297;
	Thu, 23 May 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462826; cv=none; b=eGxfJw6B0gtx6+YF2kugxGYf295j5DTevv4PMmH8ltW4yoTnLxM0uefqRJeC56GnPCNoC3vydjrrlWCYSo9jtfzdT9Zg20yHQyvtrxqMLLcUPgxbo5PidMZdGzMjVsIiR57jckNeMwoP1PRKO3eXn9BMlx8rneT7R/E/zgxlSBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462826; c=relaxed/simple;
	bh=8Iv96qeK3XO6FCLRf729LFGYnVsyZm+QYnohsytJjMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtkEG+UFJvYsSIp1QIghjjCB99cXXBktr/aVRTXOnsW7BqJNgJr/fxssx6HRSsm6v9hBWuuKnFZn2MPnbmFxFiUMKaOIqqhjlFIEo/vsrKtBFVEVzWtFbtwmLJTRwzWgCrMUO8uIc7cVCqA7Q1Unyy1PK5+ew86zrf+OdhKWIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+seZe7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF729C4AF09;
	Thu, 23 May 2024 11:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716462825;
	bh=8Iv96qeK3XO6FCLRf729LFGYnVsyZm+QYnohsytJjMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H+seZe7tia9XlPVFbMv1VD3pMpCR28zP+PYcUgiD0HO1ott5vOkK+LXl8bv8ATOEV
	 Ad7Ijqn3GCoXbbBre2uB55H4H1dRQNmRXl/deA5egIYXocWhAF9rjgR8lVkJ5+o8NZ
	 OG5SDUld0NahdcHQMt64J6N7ht+au3cZ7TP09Urx3Iapvq5rotxpP0AiIYeXXglQ+6
	 eZ6rD75sGB4BUdqavP/iRsVStenQOXZHzPwo0753UW4DF8n8g0eL1BvpVIdVLbJYOM
	 wm7k3mmwTOQHb3zq+xrznKr/qzcbVsen8qnT1gcW3fzAwIv2+ZiRq09Avg0ymvLDR1
	 yv6vXxM56UoxA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b2fbe85f82so947956eaf.1;
        Thu, 23 May 2024 04:13:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKsIadf99X0BzkPk+l6LddPS9eZ9A6+jRMez0YTqkp7wEXO0YKFWS9JWCMRQBKNKZHtudmCb+rCO2IJDurGvSzkFQz1a2wLgjHaMh8iewwNxZLdBGcXPLLxLQVe8QFCbE66dCZFhRLS592oLfBB78rpdaTQBrs4jhwnN3yhQORWQ+lhIGhf1CZl+hJ20zfeWuEqHxRMLnUjAnsAQf6juZfjcFryIHPM4EPJWinszlC0CjsHtqXHwlKeT6AEQ==
X-Gm-Message-State: AOJu0Yw98/6IyxrJn++77Nj+MCIXnjt+u8gS22J55flQtqgm6K2hN+vS
	q2Ca/cPUE3um+2E9wFZDOOimyekt0TRyaOBaPp343DmTQXCZUsM1T9aRp2wY0Ng7SFAi2kYmQ//
	j3DDs1ISqFC3oGKBpiVMxDavdJoM=
X-Google-Smtp-Source: AGHT+IGDJUzVNILe+89DNDK58fKL2girzfjapTcy0TAMQFrntEneDV5GD9qcXO8dgV6h6vsQw1LQsO6L8qszS/mlEfc=
X-Received: by 2002:a05:6820:2c8a:b0:5b2:89f:452 with SMTP id
 006d021491bc7-5b6a240fad5mr4236608eaf.1.1716462825087; Thu, 23 May 2024
 04:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024052334-nape-wanting-0a2a@gregkh> <05f4290439a58730738a15b0c99cd8576c4aa0d9.1716461752.git.lukas@wunner.de>
In-Reply-To: <05f4290439a58730738a15b0c99cd8576c4aa0d9.1716461752.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 May 2024 13:13:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ihKzCbFxfVn9s5zB3WJepzi+dUPk1LFRMnbFF-9EV6nw@mail.gmail.com>
Message-ID: <CAJZ5v0ihKzCbFxfVn9s5zB3WJepzi+dUPk1LFRMnbFF-9EV6nw@mail.gmail.com>
Subject: Re: [PATCH] sysfs: Unbreak the build around sysfs_bin_attr_simple_read()
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	linux-acpi@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	intel-gvt-dev@lists.freedesktop.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 1:00=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> G=C3=BCnter reports build breakage for m68k "m5208evb_defconfig" plus
> CONFIG_BLK_DEV_INITRD=3Dy caused by commit 66bc1a173328 ("treewide:
> Use sysfs_bin_attr_simple_read() helper").
>
> The defconfig disables CONFIG_SYSFS, so sysfs_bin_attr_simple_read()
> is not compiled into the kernel.  But init/initramfs.c references
> that function in the initializer of a struct bin_attribute.
>
> Add an empty static inline to avoid the build breakage.
>
> Fixes: 66bc1a173328 ("treewide: Use sysfs_bin_attr_simple_read() helper")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/r/e12b0027-b199-4de7-b83d-668171447ccc@ro=
eck-us.net
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Works for me.

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  include/linux/sysfs.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index a7d725fbf739..c4e64dc11206 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -750,6 +750,15 @@ static inline int sysfs_emit_at(char *buf, int at, c=
onst char *fmt, ...)
>  {
>         return 0;
>  }
> +
> +static inline ssize_t sysfs_bin_attr_simple_read(struct file *file,
> +                                                struct kobject *kobj,
> +                                                struct bin_attribute *at=
tr,
> +                                                char *buf, loff_t off,
> +                                                size_t count)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_SYSFS */
>
>  static inline int __must_check sysfs_create_file(struct kobject *kobj,
> --
> 2.43.0
>

