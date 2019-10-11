Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA944D4433
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 17:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfJKP3Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 11:29:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36484 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKP3X (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 11:29:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23so6006219pgk.3;
        Fri, 11 Oct 2019 08:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cb+CuGiPFhTsjsET+vWIxmNhs5/xA7pJX6xm8jBmGpg=;
        b=fpt5X2ZMVc9IuTJ2DQ0GVwI0Px4HqOiD7k1U0wKljj2FMmHeo6SyqW8ZEJetyb2OF7
         C1LymmBvyu3TZcGcZj6fsM5myh2AfEZF9sdBDItCo1JUOzgE03uvRv83is8t07P29sWA
         XcJX2LMU+FgyT7J8knfi2YX/+jKeTdJ5cYZpYXq7i/85X/bUpmu5KWLu34orbGpms2Gq
         mzl5KgIzSpsw6NYUnz+zIBQp04SPNTryvlomvFSKSzNpoKIKK19kl+eXEL5pWxuLx1Cs
         45NKR3OWexEs80ihEoc2M7gvjN5mN1j5cazMZhkCrUfztYMnFjBwjLaHQSDq3Ay1toGD
         b3cg==
X-Gm-Message-State: APjAAAVQJ9PPiowT1nHUslRnjNMLPiV0iXwRn5BkhfcYvEKbo+1fDMPZ
        MfR2jfPCZMv3LqfQ+HemkwU=
X-Google-Smtp-Source: APXvYqzQGIxVvL/RVKdZUGIOFS+l3gvznBmd+kdBx1Iip2tJWpJsNSmo6lTIrjfB8HSt2qDcGX7GxA==
X-Received: by 2002:aa7:9ed2:: with SMTP id r18mr16643022pfq.1.1570807762693;
        Fri, 11 Oct 2019 08:29:22 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 7sm7894675pgx.26.2019.10.11.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:29:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A969E403EA; Fri, 11 Oct 2019 15:29:20 +0000 (UTC)
Date:   Fri, 11 Oct 2019 15:29:20 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v7 4/8] firmware: Add new platform fallback mechanism and
 firmware_request_platform()
Message-ID: <20191011152920.GQ16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-5-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 04, 2019 at 04:50:52PM +0200, Hans de Goede wrote:
> diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmware_loader/Makefile
> index 0b2dfa6259c9..fec75895faae 100644
> --- a/drivers/base/firmware_loader/Makefile
> +++ b/drivers/base/firmware_loader/Makefile
> @@ -3,7 +3,7 @@
>  
>  obj-$(CONFIG_FW_LOADER_USER_HELPER) += fallback_table.o
>  obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
> -firmware_class-objs := main.o
> +firmware_class-objs := main.o fallback_platform.o
>  firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) += fallback.o

Why not just:

firmware_class-$(CONFIG_EFI_EMBEDDED_FIRMWARE) += fallback_platform.o

>  obj-y += builtin/
> diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
> index 21063503e4ea..c4350f2e7cc2 100644
> --- a/drivers/base/firmware_loader/fallback.h
> +++ b/drivers/base/firmware_loader/fallback.h
> @@ -66,4 +66,6 @@ static inline void unregister_sysfs_loader(void)
>  }
>  #endif /* CONFIG_FW_LOADER_USER_HELPER */
>  
> +int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt_flags);
> +

Inline this if not defined.

>  #endif /* __FIRMWARE_FALLBACK_H */
> diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
> new file mode 100644
> index 000000000000..7e9d730e36bf
> --- /dev/null
> +++ b/drivers/base/firmware_loader/fallback_platform.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/efi_embedded_fw.h>
> +#include <linux/property.h>
> +#include <linux/security.h>
> +#include <linux/vmalloc.h>
> +
> +#include "fallback.h"
> +#include "firmware.h"
> +
> +int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt_flags)
> +{
> +#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE

And we can do away with this eyesore.

Otherwise looks good!

  Luis
