Return-Path: <linux-efi+bounces-4184-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7095FAFC416
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 09:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B344A28E7
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 07:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2466220F38;
	Tue,  8 Jul 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPbEBw32"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B207219EB;
	Tue,  8 Jul 2025 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959892; cv=none; b=hoPOsUjK3Q4uOFo2eD3ZSR+QXCghD2hZJtzp51XZ5o81HPaa+PFVuswtX+rRlxMI6tVCaQLvUE5a6wvCGbP9AC7MuwiPqu7Lgr7pstDYfo/rzvN4fpVG5di4VYbiee6BiNGao9hMVi5+cWtyr3YxvxTp0X0ARFnAh4WccJUPraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959892; c=relaxed/simple;
	bh=MlUe7YjPi2XVBEnNzzyal8ramm9RNKQA1CAJDniusLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8R1QjSB7jok/bYhj2PFs99Vt2iqMRfH63kndgqic15Aria8NGzD7FKz1pDaiDfSQyEbpT1rSCGqntmnbJK95kYst252HwIfkTGWQ7RDjwJ05OjMh8RC/Jf8vEFERXPNjGp0A7qdYlkUHh1kVoBCSgbgE0IwS9N8OWBw3guvJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPbEBw32; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54d98aa5981so5264079e87.0;
        Tue, 08 Jul 2025 00:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751959889; x=1752564689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exD3M65dbWRtMEZ/ZXC6r2bHo19os4rszBrES3ubxwo=;
        b=iPbEBw32exQN+EmAKSk1hobao4UEWbdtUpTczzXd4HALm94vVadZ+iq8PV2c26LT3M
         hNPx95cquTSzqFiUv44Fk1mhyhs6nSpjHBRmaEjumseJ8Zq8C0knpXHZbOg3o4kd8UE1
         2NL5dA+Wchd92YJK325iZNOH4/RQjZhl29knPxL6cv4dXMeyhyYVbZUQJuAy/y2M4Nh1
         jO7J1RBonXt72A1E9A6mWUIHdRENNyxi/MHAaMFPZ+tMBO1JfkphmfQ857wcgwp6EYa7
         9dV3LiF+z6CLTYNIO3TOBdi8GIQCdDK9IpAVwqsgFUFrfEXLLPJ+8urD9npMOzBLR5mD
         ZvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751959889; x=1752564689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exD3M65dbWRtMEZ/ZXC6r2bHo19os4rszBrES3ubxwo=;
        b=Pi9kbMtQS4TFkUfKhCDgd1wDJ7X6jdoWvodROeiFPIJAaLhn8o9NEHYRQNiqGBoFOa
         83LjJQnpitOYiuTp9dfHAVKNscnT7bD3pD4vNwb0Pj875bL3ILktajWhHRDOqeDcSnbE
         txzq+ekeGlF0i6BLOUT25XwjUcajRlTYLY5P2/DxcWTlxvL/EEIwrT/v5lq79BNe+/px
         zLr+4QrbNtPFAg84Hiv20PWxCEUNyx7o7PwVnr4yrU9ywjkSzeORdZQ+9yzLwl0oTVKt
         1KOVDh5em92LxAtZbFii7maGEE85VDUWVepX/t5y9HgZYA2Q2PG2A9h/JQOnxDgH8WgZ
         AafA==
X-Forwarded-Encrypted: i=1; AJvYcCWhBD+xx/t/YN/rT1AWh0ldJqBu9zqmYJ7sOuWTY+/LgL8MW/RQCLVVmCHWjF8UEd0I6SM+3+hkP0coLtb/@vger.kernel.org, AJvYcCXnDlv49B4Xpu16cWqFfmMgvm273bPOGu0dNdZ5tZzNvqk9JAO4P4+wOrHQJg67zl8mj+2n1NEbGlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7FN/2LHiKEh//yBFFujsZnj4fgXVmfo+J3XshuM5GbA4aV3E
	h0EuMp1Xu0u5RHbOFUwasJ0QIbF1GjPHjuHTG311bDPy7t50nK/xurpXskiDY9gS6fIFzzF3UIb
	IjEJeoiabLO8hd8ByBC+gKlfte5ns4F8=
X-Gm-Gg: ASbGncsFTI/fJFQxAvMiBs3m6aaejte26/+pZ2H9tFLCqxvRxXii4ZyjfjwWicz/kUO
	9x2WKls5nExUq7Kw+JzMPNY3w84VpH1pTtKKCTxVHCrqbtCzfcR5PK47XV/sS0vAm98Ba305WMd
	ekIMns4O7xBCOuMlP4dkPmaF9IsX+zblEthcLwVkQ9Ga9XA1fBECXKFQ==
X-Google-Smtp-Source: AGHT+IEts99pniQ9nHC2u+MXKQIsQ3YOelCQ0jt33EmeDq94p9MuS3pKwGbz837PpP3iD2sWhVDGWol1x/LbV/+vilI=
X-Received: by 2002:a05:6512:2c8f:b0:553:cf7d:72a0 with SMTP id
 2adb3069b0e04-557a1235e1fmr3735363e87.5.1751959888889; Tue, 08 Jul 2025
 00:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-efi-default-loglevel-v1-1-12b80db5af16@gmail.com>
In-Reply-To: <20250708-efi-default-loglevel-v1-1-12b80db5af16@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 8 Jul 2025 02:31:17 -0500
X-Gm-Features: Ac12FXxJnxVzJVQLuyc2cpApS5tJkzi4ewqWCvH2C9WMplrCX_HhhslYn9NprRg
Message-ID: <CALHNRZ9T0dHzbXBUdBa4hE-Ao8ebeLLPRX+1ThkuLT+Rp8_Jeg@mail.gmail.com>
Subject: Re: [PATCH] efistub: Lower default log level
To: webgeek1234@gmail.com
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 2:30=E2=80=AFAM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> Some uefi implementations will write the efistub logs to the display
> over a splash image. This is not desirable for debug and info logs, so
> lower the default efi log level to exclude them.
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/firmware/efi/libstub/printk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmware/efi=
/libstub/printk.c
> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd746a9c54abbb=
e61a4bf70f1a8c4 100644
> --- a/drivers/firmware/efi/libstub/printk.c
> +++ b/drivers/firmware/efi/libstub/printk.c
> @@ -5,13 +5,13 @@
>  #include <linux/ctype.h>
>  #include <linux/efi.h>
>  #include <linux/kernel.h>
> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> +#include <linux/kern_levels.h>
>  #include <asm/efi.h>
>  #include <asm/setup.h>
>
>  #include "efistub.h"
>
> -int efi_loglevel =3D CONSOLE_LOGLEVEL_DEFAULT;
> +int efi_loglevel =3D LOGLEVEL_NOTICE;
>
>  /**
>   * efi_char16_puts() - Write a UCS-2 encoded string to the console
>
> ---
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> change-id: 20250708-efi-default-loglevel-4da5a36cac87
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>

This patch was originally suggested a few months ago [0], but as far
as I can tell was never queued for merge. Since I'm also hitting a
case where this is relevant, I'm sending this in to bring attention
back to it.

Sincerely,
Aaron

[0] https://lore.kernel.org/all/CAMj1kXFKSrVx4SO_T8sHU=3D4hie8pjk8CUWQDV8oh=
+bz=3DxMn4rw@mail.gmail.com/

