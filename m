Return-Path: <linux-efi+bounces-4278-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A654B01092
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 03:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630661890A86
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 01:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3FE555;
	Fri, 11 Jul 2025 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkOboRK+"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39A625;
	Fri, 11 Jul 2025 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195987; cv=none; b=tuxLTQeyIoXgINp9ivKOtpRT8bVTtIiAswmvawzcOEupHcnOd1lag8UMklaVYDNhcJFKzKFk8LfFJ0vMhHdpTzsa0tT9P0CmQi2WOweOElNRTdksSNutl9I4BGkLJs7QB2CmgcN12gf4kEnotSbpmYNXV1E6vYVRDH2Y5cUhK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195987; c=relaxed/simple;
	bh=3s9ya70fRuAtMbeXNZqI/wI3mNNpFXrGUgHz7iC5FZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJKFvdXG21Sp35XyBaCLYpYuQHEhbt0OfAg+c5Kg83Az4ihLwwfquKxnxpOq5I+ka0UEJpNHPx+QJACTChTEUUUfrfEHuxPQGPFr0EjePrgVrwpqEivgImVcJ35qNy0EpIJKs/SKoyngtNDwhno7ZTqsnMPjM0Hnt4bnD/d4QIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkOboRK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0151C4CEF4;
	Fri, 11 Jul 2025 01:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752195986;
	bh=3s9ya70fRuAtMbeXNZqI/wI3mNNpFXrGUgHz7iC5FZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DkOboRK+dzbQcbXSb6ZM4srfdImE3uoWJ0JA6knuDWitO+udLU2EehGG8fIQgHX3J
	 gkvpnqQ6+XVAtvkLpcKnOZTDFMv2iHkUmrEv2VI5kEsztx+JhZmtQZhbT4JIqPv12I
	 bZ4vVw/s/j/Rb9RD9ZWzOU3yFHUqRBGkFmFZpouz4QobAMVa57QzIgRHwavrtrTXEv
	 0rzqYKyx1WPj9mRBushGqtm0pb8axvGwquP3AUC8wyE5XBSsn9NFnkzRcasfF2x/8Q
	 JnUV6+fDrKw+sRDJnjJzKanWDG5nWaXA5qx8zdAUfE0hIRHBu3I7nsHznEoCHvkxwG
	 FYTCw1xF+h4uQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-555024588b1so1757296e87.1;
        Thu, 10 Jul 2025 18:06:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGmN/BrofNBo6qrtvowpHlxj2QqZrsgWr+UdAWOJ3t9I0SqlzGpPqYmN1M+nfM02SymXZjI1l0hOKw@vger.kernel.org, AJvYcCVNXh5uj7R7kc7gZdUMcGHC5AK/grHIxP6kS8K8S+Gf+6OkQcomil6HhGEEVqkhknVI7vfCZInjkfZIrxer@vger.kernel.org, AJvYcCXDsuPEEb3VDvsVsRIaLLn6b8cuyLS+hTiySMDgxYSOMA/5oTX67KGsqzoj6pkaED+QAi3Jy7pVYd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxDPHUalAIs1YCkvTXO5RSf2RHgV1MV7C1OikkWzYVPyd4MMD
	x4bi4Ad7uWRmjTN085sASsC8HHFjAHjGPHuCa7XnoM2lRfmCSyvfQ8x/s7DZ/ft6K4oSEZPmdPe
	Y8XIzYjgYRdDzBDew/YgJk2UwdOypz+w=
X-Google-Smtp-Source: AGHT+IE+3CUYH/gD3T7zT/PvUdYk4B6Ktm/C8FGrfNnQrO0FD/zBA/r82egJK1xA6pV6KiuBRkMaxwF2g3Dpml5Qj2E=
X-Received: by 2002:a05:6512:39d1:b0:553:a60d:6898 with SMTP id
 2adb3069b0e04-55a04645b4fmr271265e87.45.1752195985093; Thu, 10 Jul 2025
 18:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710084151.55003-1-feng.tang@linux.alibaba.com>
In-Reply-To: <20250710084151.55003-1-feng.tang@linux.alibaba.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 11 Jul 2025 11:06:13 +1000
X-Gmail-Original-Message-ID: <CAMj1kXHDFq3FZj4134CTcQZnke4t1=u6iRNNsQBvuhb3F6KurQ@mail.gmail.com>
X-Gm-Features: Ac12FXwlQMse1-xThF4QL3jSKxOhXMTEqDoi5hfv1fq0LHWKI1bQr6CujMt1wgA
Message-ID: <CAMj1kXHDFq3FZj4134CTcQZnke4t1=u6iRNNsQBvuhb3F6KurQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: efi: Add runtime check for the wakeup service capability
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 18:41, Feng Tang <feng.tang@linux.alibaba.com> wrote:
>
> The kernel selftest of rtc reported a error on an ARM server which
> use rtc-efi device:
>
>         RUN           rtc.alarm_alm_set ...
>         rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
>         rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
>         alarm_alm_set: Test terminated by assertion
>                  FAIL  rtc.alarm_alm_set
>         not ok 5 rtc.alarm_alm_set
>
> The root cause is, the underlying EFI firmware doesn't support wakeup
> service (get/set alarm), while it doesn't have the EFI RT_PROP table
> either. As Ard Biesheuvel clarified [1], this breaks the UEFI spec,
> which requires EFI firmware to provide a 'RT_PROP' table if it doesn't
> support all runtime services (Section 4.6.2, UEFI spec 2.10).
>
> This issue was also reproduced on ARM server from another vendor, which
> doesn't have RT_PROP table either. This means, in real world, there are
> quite some platforms having this issue, that it doesn't support wakeup
> service while not providing a correct RT_PROP table, which makes it
> wrongly claimed to support it.
>
> Add a runtime check for the wakeup service to detect and correct this
> kind of cases.
>
> [1]. https://lore.kernel.org/lkml/CAMj1kXEkzXsjm0dPhzxB+KdtzqADd4NmafKmw2rKw7mAPBrgdA@mail.gmail.com/
>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
>  drivers/rtc/rtc-efi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Thanks, I've queued this up now.

> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index fa8bf82df948..8d1b9bde6f66 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -259,6 +259,7 @@ static int __init efi_rtc_probe(struct platform_device *dev)
>         struct rtc_device *rtc;
>         efi_time_t eft;
>         efi_time_cap_t cap;
> +       efi_bool_t enabled, pending;
>
>         /* First check if the RTC is usable */
>         if (efi.get_time(&eft, &cap) != EFI_SUCCESS)
> @@ -272,7 +273,8 @@ static int __init efi_rtc_probe(struct platform_device *dev)
>
>         rtc->ops = &efi_rtc_ops;
>         clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
> -       if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES))
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES) &&
> +               efi.get_wakeup_time(&enabled, &pending, &eft) == EFI_SUCCESS)
>                 set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
>         else
>                 clear_bit(RTC_FEATURE_ALARM, rtc->features);
> --
> 2.39.5 (Apple Git-154)
>
>

