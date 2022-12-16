Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463CC64EF0E
	for <lists+linux-efi@lfdr.de>; Fri, 16 Dec 2022 17:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLPQ3V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Dec 2022 11:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPQ3U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Dec 2022 11:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9656D5D
        for <linux-efi@vger.kernel.org>; Fri, 16 Dec 2022 08:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671208116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9K3or72XpnhxOqXX2kwUp8CP56k65jgChX6ZiTJs10g=;
        b=XEj+GAbZbgzW7QTFbC7WGqatTUQCWg4btpWQxQhjCgqYoAbOQ9eHCD9/kg664qEvTj8A44
        Z46a3Q8yr6FqouLr9lA7jFSJnR/7e5YfB4XaB+KfOBpcoJJu70wOGF/dI/qM4Nuzgt7hIG
        MxA2rOOfCPEiQvesOR4myBtvwNoOJI4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-1wu1gK5MM4aS-bK-XgRXVQ-1; Fri, 16 Dec 2022 11:28:34 -0500
X-MC-Unique: 1wu1gK5MM4aS-bK-XgRXVQ-1
Received: by mail-oi1-f197.google.com with SMTP id k26-20020a54469a000000b0035ac1417866so935049oic.18
        for <linux-efi@vger.kernel.org>; Fri, 16 Dec 2022 08:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K3or72XpnhxOqXX2kwUp8CP56k65jgChX6ZiTJs10g=;
        b=ID1jgMqhI2IRcqv7+zunxybXP/2m11ZLhBzzkP+CRzjAOsNXrH9DVjaX1xxVEElFPI
         Qb8+OngbjnX+EU+fr5gSWJWuSblsg7u4qLAQUkDP0kFMhuEx3CvdLmJ8JmpEAgI/P9Eh
         ZlwTBYPrsNpDxpnmd7F0b51MyvSvKK+sc3lghjIcp4x/xHFdY12hDR2VZZAACwBPl97i
         q+ygUvB5Rh2xopnsDF6JEieDgxzDeUu7Z6S78b8MjOO4sFb+FKRW1JdTTph1qqFOqVNm
         4I8nxJCe512wt4Zs49J7PWdvAffkbMg5JQ7PwpXtfHSAvtUvKTPyTb0FCv6w52/lqQFJ
         lDNA==
X-Gm-Message-State: ANoB5pk4WLqcX6T+C2kTesggcZUgY1HKMApqX8bex5HHGgvVbm8M2uKY
        gr0EtOO10FHr+NIb2i8A3RPtiSPBrcQVgLMynC4gI1zxNGAIdjCU3wf4gL5PlMMft1JkZc67GQQ
        jpRigzGgaex6YrqnAqJiT
X-Received: by 2002:a05:6830:2712:b0:66e:34d1:2081 with SMTP id j18-20020a056830271200b0066e34d12081mr17937486otu.17.1671208113879;
        Fri, 16 Dec 2022 08:28:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4RbWVIMJ1jxIC7/DqOBxs2gzUoH/AuRbYK0i0yJ3FfkN1X0tdRweHHF5VCbLB6aE7L3ymVUw==
X-Received: by 2002:a05:6830:2712:b0:66e:34d1:2081 with SMTP id j18-20020a056830271200b0066e34d12081mr17937474otu.17.1671208113651;
        Fri, 16 Dec 2022 08:28:33 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id y15-20020a056830108f00b006708a6274afsm1004911oto.25.2022.12.16.08.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:28:33 -0800 (PST)
Date:   Fri, 16 Dec 2022 10:28:30 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] efi: random: fix NULL-deref when refreshing seed
Message-ID: <20221216162830.3h5w5gg533wp6wk4@halaney-x13s>
References: <20221216091514.6298-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216091514.6298-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 16, 2022 at 10:15:14AM +0100, Johan Hovold wrote:
> Do not try to refresh the RNG seed in case the firmware does not support
> setting variables.
> 
> This is specifically needed to prevent a NULL-pointer dereference on the
> Lenovo X13s with some firmware revisions.
> 
> Fixes: e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s

Thanks Johan, this fixes the boot issue I was blindly fighting
yesterday.

> ---
>  drivers/firmware/efi/efi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 2e168e5b97de..1a9e2f70c550 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -432,7 +432,9 @@ static int __init efisubsys_init(void)
>  		platform_device_register_simple("efi_secret", 0, NULL, 0);
>  #endif
>  
> -	execute_with_initialized_rng(&refresh_nv_rng_seed_nb);
> +	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
> +		execute_with_initialized_rng(&refresh_nv_rng_seed_nb);
> +
>  	return 0;
>  
>  err_remove_group:
> -- 
> 2.37.4
> 

