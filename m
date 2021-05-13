Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84337FA6D
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 17:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhEMPRn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 May 2021 11:17:43 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:41902 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhEMPRk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 May 2021 11:17:40 -0400
Received: by mail-wm1-f43.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so55128wmq.0;
        Thu, 13 May 2021 08:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RzW3hfIwG8KNpIuYYvcN7wwNDPoH5ZcYrcAh7yRYkRA=;
        b=RAQ0FITbYPJ3s/S0fnO2QYnqhd9zmu0tlxqH2Au+NxkrpVx86ailg40lSy74dkJGTx
         Hg114bcs1nmHTr6CxHHdJilBe6hXvE29kB4aNyfW72WD/XYMU1lS0NwOFHASq/lMH8Fm
         z3kJAjMqK/O7g+rn0ST4AGG9aS2BWuHlC4ImqqVySgwVZsworxwpOWqEQXOD9yq/eO1z
         bGzCYTe3yhqt7+CLMXbJ0Ofy97gHl6cOgBgGAIWupQQhGhrMw2soI9SoahMv+Z6PgWkC
         vPcV1oZfkPks6P0FsBNuR6lBqvUjuYdM5ewQ7UvWW8Qsp/dBvTKxpc8T3Vx6n6FcXzvV
         dbSQ==
X-Gm-Message-State: AOAM533WXbQD6eldlnP+bYNOts0pJE/fLu80lHlph/qHGMjvhL2jBiJs
        J6YdeVzQw46u+yCCcd2ppuU=
X-Google-Smtp-Source: ABdhPJyX1dK+4m59Uoq3vjk43fmBJYXqnMXrwlVKBN04PYK8JNzlDUGq18NLBqgIGq3DH6jXx9AiHg==
X-Received: by 2002:a7b:c012:: with SMTP id c18mr4451930wmb.94.1620918988569;
        Thu, 13 May 2021 08:16:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s83sm2432436wms.16.2021.05.13.08.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:16:27 -0700 (PDT)
Date:   Thu, 13 May 2021 15:16:25 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Subject: Re: [PATCH v10 5/7] arm64: hyperv: Initialize hypervisor on boot
Message-ID: <20210513151625.ww2cznl4myzwbvg5@liuwe-devbox-debian-v2>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-6-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620841067-46606-6-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 12, 2021 at 10:37:45AM -0700, Michael Kelley wrote:
> Add ARM64-specific code to initialize the Hyper-V
> hypervisor when booting as a guest VM. Provide functions
> and data structures indicating hypervisor status that
> are needed by VMbus driver.
> 
> This code is built only when CONFIG_HYPERV is enabled.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
[...]
>  /*
>   * Declare calls to get and set Hyper-V VP register values on ARM64, which
>   * requires a hypercall.
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 61845c0..7b17d6a 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -49,6 +49,7 @@
>  #include <asm/traps.h>
>  #include <asm/efi.h>
>  #include <asm/xen/hypervisor.h>
> +#include <asm/mshyperv.h>
>  #include <asm/mmu_context.h>
>  
>  static int num_standard_resources;
> @@ -355,6 +356,9 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	if (acpi_disabled)
>  		unflatten_device_tree();
>  
> +	/* Do after acpi_boot_table_init() so local FADT is available */
> +	hyperv_early_init();
> +

Arm maintainers, this requires your attention. Thanks.

The rest is Hyper-V specific, feel free to skip that portion.

Wei.

>  	bootmem_init();
>  
>  	kasan_init();
> -- 
> 1.8.3.1
> 
