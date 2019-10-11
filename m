Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53FDD439F
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 17:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfJKPCa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 11:02:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33958 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfJKPCa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 11:02:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so4606668pll.1;
        Fri, 11 Oct 2019 08:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMw6A0ySkqQiHBiai+B0CQpXt1FaZKXX8wNTsnQc/K0=;
        b=Kr4TcxoIMagG1aOtgJcN6J3+geo1bECM8/MhHlwlaxS97GuwZtjyR1gZF4cr4qk1By
         HWm6ooEfzS1P+ngkp6l6KfFo52LcCUpjTYy/3uZX0Cev0I8Q2k09+2d7Epd8jD9IQqdE
         SY/zsTE5HIR/Z57TJQDHtuCP70Elgj06RIhL8ad7AnzQtbxVgbituIhr7KArl3SCNJue
         +JdK5QVb8/KqxFMinjdJoiFY/oX0YmmiTjpbSWeGR99VPwYEJWl9Ks021YqafAzchnmT
         Ra3uwV22zBFnccUgEG6yGvCIVDnzDdytGmXIuDOcpe1UwOBqekb3bUX+JHNrIz/WpQi4
         Q2Ag==
X-Gm-Message-State: APjAAAUQUbsveecKypjETih7UsEvQcVJw68mqoP4uRPvCvIqZJcE9YRP
        /TjT77zG4tNcVXq8i5L1kYc=
X-Google-Smtp-Source: APXvYqwiHpLlmejt3NOWkh5ZzK0HvNb2LO/lm/1gCZziXECNv4ZVkshN0LjJ36LM8n4uhzFARU3Xug==
X-Received: by 2002:a17:902:d909:: with SMTP id c9mr15684424plz.216.1570806149053;
        Fri, 11 Oct 2019 08:02:29 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id l1sm15633824pja.30.2019.10.11.08.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:02:28 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4BE50403EA; Fri, 11 Oct 2019 15:02:27 +0000 (UTC)
Date:   Fri, 11 Oct 2019 15:02:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Scott Branden <scott.branden@broadcom.com>,
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
Subject: Re: [PATCH v7 3/8] firmware: Rename FW_OPT_NOFALLBACK to
 FW_OPT_NOFALLBACK_SYSFS
Message-ID: <20191011150227.GO16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-4-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 04, 2019 at 04:50:51PM +0200, Hans de Goede wrote:
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 62ee90b4db56..665b350419cb 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -606,7 +606,7 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
>  		return false;
>  	}
>  
> -	if ((opt_flags & FW_OPT_NOFALLBACK))
> +	if ((opt_flags & FW_OPT_NOFALLBACK_SYSFS))
>  		return false;
>  
>  	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
> @@ -630,10 +630,11 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
>   * interface. Userspace is in charge of loading the firmware through the sysfs
>   * loading interface. This sysfs fallback mechanism may be disabled completely
>   * on a system by setting the proc sysctl value ignore_sysfs_fallback to true.
> - * If this false we check if the internal API caller set the @FW_OPT_NOFALLBACK
> - * flag, if so it would also disable the fallback mechanism. A system may want
> - * to enfoce the sysfs fallback mechanism at all times, it can do this by
> - * setting ignore_sysfs_fallback to false and force_sysfs_fallback to true.
> + * If this false we check if the internal API caller set the
         ignore_sysfs_fallback set to true or force_sysfs_fallback is
	 set to false

Otherwise looks good. You can add:

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
