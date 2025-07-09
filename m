Return-Path: <linux-efi+bounces-4243-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCFFAFE641
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 12:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86967BC79F
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBFD2C17A1;
	Wed,  9 Jul 2025 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk1G6/ad"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6C2C15B7;
	Wed,  9 Jul 2025 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057758; cv=none; b=FWUI5KTuSkqvi6OsjZGDkKhj+43uYacOKs9V2VHS2TqvoEPJPXOtFG4rEy2gXeHbcQergoe0SUyMfu2PAgYG/OKV2eVWYAHLLm0GicqMyDp0oTUp5YXSusbtQbErLV4t3YDVR3U+qa6BhBpyUF0ewyTGb7dIDR5bg/xYAcHBCBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057758; c=relaxed/simple;
	bh=sBRCZngRfe6dRj1UrXu3RD6/ZzAbgtyPm4EePZudNv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9O9S9ow9F7oqz3Pv14RO5p3A0puzlBxzGqFHcPKnTKcbkLuiu5N1SNg30+XHE3k4/lSbBpP+xVR8OhAjr6rEVnn8yqm5OQzRUhNS6JeIfZG9Kioc9gVLNITtH1J1Wui+++Gj9vsIXAKLQWBiPbF0Q23VeFoLYx7MgCY9n7lbhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk1G6/ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED00C4CEF6;
	Wed,  9 Jul 2025 10:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057757;
	bh=sBRCZngRfe6dRj1UrXu3RD6/ZzAbgtyPm4EePZudNv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fk1G6/adhsEYGvG8soZ6E/2YNcjbAgUWyU7Zxg7RlHgIzYt5RtbPij+lmTCTnpZu8
	 7u7rooPYsgY3kjbHP7OK+MHgaoHUCVL4Holo2eXd+835meah8Xw3wNoQHDnXbXf5t7
	 tLX/qgI4HZUJA/nE0HaOhFmzvJ4xLsroXfC4xB4DmYgqEAVS7P0PptwtgdX+c+lcW+
	 P4Ov4HDCufgwShLIVwDHK3071BX+ajpOZC/MucmVbaBOmgeGFyQdgPC6kFIGVIW7gP
	 6i3dlpZjtMKx9S5lYJaFsUUhGPAurW9YAXW1g2+D0nTxhUySJkuRmKxkYDJ2RnV1mO
	 OI48OtRL97/vA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso50933971fa.3;
        Wed, 09 Jul 2025 03:42:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4GawfGmZJIv3P9umYO0iuvEVFFhf2VForxAsnsZ2JoO2AqLUNkufSnkok1nLko/JEXuvZKxuVfAhUSMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJbTTbCCvbaEuUeh1sJns/2/eFAMkMb1gu+WHKcCdptEyOK14
	9KUhn3AHExQRb9R/Z/uuzFncVkNcYAqWsfkHWWwP4tzVEXi8h41sh9LUSzCLFwbadFCKq8jGQFb
	cVMyWAw6Xlwzo+HRmJxgpclJwjQHObYQ=
X-Google-Smtp-Source: AGHT+IGWnw6v+oWs8UVNAhgRmhN+MIznxbITpm0slRODpzWHfcIdpjJWY7BfGRIBieQjpqU2UT34QCQweiOss5dZjMI=
X-Received: by 2002:a05:6512:2394:b0:553:522f:61bb with SMTP id
 2adb3069b0e04-558fa877a72mr718213e87.12.1752057756131; Wed, 09 Jul 2025
 03:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709103541.7268-1-feng.tang@linux.alibaba.com>
In-Reply-To: <20250709103541.7268-1-feng.tang@linux.alibaba.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Jul 2025 20:42:24 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEvxPjFsqoMzZnb2zxSf9uyLVzuzKEeKD4fLEux3NbUhw@mail.gmail.com>
X-Gm-Features: Ac12FXyF2Jaa_zw3OTWt2PHD6pHE8hXdWa3EGEfEiZpNWct9xDnM5Xi6ZjieDTM
Message-ID: <CAMj1kXEvxPjFsqoMzZnb2zxSf9uyLVzuzKEeKD4fLEux3NbUhw@mail.gmail.com>
Subject: Re: [PATCH] efi: remove the rtc-wakeup capability from default value
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 20:35, Feng Tang <feng.tang@linux.alibaba.com> wrote:
>
> The kernel selftest of rtc reported a error on an ARM server:
>
>         RUN           rtc.alarm_alm_set ...
>         rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
>         rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
>         alarm_alm_set: Test terminated by assertion
>                  FAIL  rtc.alarm_alm_set
>         not ok 5 rtc.alarm_alm_set
>
> The root cause is, the unerlying EFI firmware doesn't support wakeup
> service (get/set alarm), while it doesn't have the efi 'RT_PROP'
> table either. The current code logic will claim efi supports these
> runtime service capability by default, and let following 'RT_PROP'
> table parsing to correct it, if that table exists.
>
> This issue was reproduced on ARM server from another verndor, and not
> reproudce on one x86 server (Icelake). All these 3 platforms don't have
> 'RT_PROP' tables, so they are all claimed to support alarm service,
> but x86 server uses real CMOS RTC device instead rtc-efi device, and
> passes the test.
>
> So remove the wakeup/alarm capability from default value, and setup
> the capability bits according to the 'RT_PROP' table parsing.
>

What does this achieve? The test result is accurate, as the platform
violates the spec by not implementing the RTC wakeup services, and not
setting the RT_PROP table bits accordingly.

What do we gain by pretending that the platform is not broken, and
lying about it?

> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
>  drivers/firmware/efi/efi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index e57bff702b5f..7cf35376a2f7 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -789,6 +789,17 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>                 }
>         }
>
> +       /*
> +        * After bootup, the runtime_supported_mask was set to be capable of
> +        * all features, which could be kind of too optimistici. In real
> +        * world, many platforms don't support advanced RTC wakeup runtime
> +        * service, while they don't provide RT_PROPERTY table either, which
> +        * led to rtc-wakeup capability being worngly claimed.
> +        *
> +        * So remove the wakeup capbility from default value, and let the
> +        * RT_PROPERTY do the judge.
> +        */
> +       efi.runtime_supported_mask &= ~EFI_RT_SUPPORTED_WAKEUP_SERVICES;
>         if (rt_prop != EFI_INVALID_TABLE_ADDR) {
>                 efi_rt_properties_table_t *tbl;
>

Doesn't this break the RTC wakeup services on platforms that do
implement them, and don't expose a RT_PROP table?

