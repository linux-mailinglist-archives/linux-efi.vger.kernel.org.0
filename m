Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E412563F865
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 20:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLATf2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 14:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLATfD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 14:35:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820F3BDA
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 11:34:58 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x2so3778360edd.2
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 11:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nwb0JxDESDs5mtnW7GSBzDyyT2uzkUh2LxNi22Fshms=;
        b=joecMB3ipKXz2RuhKpefAX3tzaiSPtlNTyz7YvTkMRl+aIwcqplDkPON0gZjI79ANQ
         jBDLjVq0t/7cz3S3dUML9lfct/BLP24Wrmh1p5yJnM4YnOkrAalVh7bcLfcI7oIvkRCd
         6qpRm6gcmmP6YMvBQe/83vXxjkeMgsDOJYb8rxhuWj42AJlOTNF6g4TCUqmJu1w+Aykb
         /Z+amgnpzHOj91lLcmzAqr9N6vYKac/ozQel+QJK/Z12kOZZ9Jxc8nOXbzyZG+RpB1pm
         T0NMlTlVgwQ23lqzP7HbMOlNJQjZ3eDWezkVF09zrlD5L0RnJ9p7MrvXxdJvmpincfa5
         IfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwb0JxDESDs5mtnW7GSBzDyyT2uzkUh2LxNi22Fshms=;
        b=UnLzIVxO06oKoihWpvx9COh09YNlqn059idEp+voSb8POXR2PJsNSgTCJo/R3QmLN9
         Awg1KSjbsNw34Lu/rJ3z2oV982Ywbc++Dmb/BnhmELdWxteXoDoY/rcZdbD0aRAfza91
         59SLbc+jMDWoC9rlybAFeqw5WRH26nqLkWNuSDVCesOiD8vZX43ZcVTpOW0T1bXqG8Ej
         76eAXpz3h4tEka1SZVhybFu76EZktMZO1odJVH5Ry1aXc1sdBrXS10XbWv1TNbHIN57c
         4mxKFwS/C9zUrt6Abx1x+NN3daXLoGaej23V2jBUpUM0MozHyb1lko71J7g7TyYA7DvX
         C9Og==
X-Gm-Message-State: ANoB5plw+8tbz+KHSAe+j0a9itYkBKp8TBfQj+LNszho4QZoCVYJV8rp
        Qgv5W68Wk/ijMu51CISv9tyiAQ==
X-Google-Smtp-Source: AA0mqf4pNR+JAwtiOHM56a2ETbcekn87d0qG8g4MgC5pBWwzXk1cR0DD7D0wjGx4WwxpAmL/8pzSrg==
X-Received: by 2002:a05:6402:e0d:b0:466:4168:6ea7 with SMTP id h13-20020a0564020e0d00b0046641686ea7mr1391730edh.273.1669923297084;
        Thu, 01 Dec 2022 11:34:57 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id a20-20020a17090680d400b007c081cf2d25sm2094018ejx.204.2022.12.01.11.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:34:56 -0800 (PST)
Date:   Thu, 1 Dec 2022 20:34:55 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 12/14] efi/riscv: libstub: mark when compiling libstub
Message-ID: <20221201193455.2hr6mwm6sa6vnd3w@kamzik>
References: <20221130225614.1594256-1-heiko@sntech.de>
 <20221130225614.1594256-13-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130225614.1594256-13-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 30, 2022 at 11:56:12PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> We may want to runtime-optimize some core functions (str*, mem*),
> but not have this leak into libstub and cause build issues.
> Instead libstub, for the short while it's running, should just use
> the generic implementation.
> 
> So, to be able to determine whether functions, that are used both in
> libstub and the main kernel, are getting compiled as part of libstub or
> not, add a compile-flag we can check via #ifdef.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index ef5045a53ce0..777d1ab059e3 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  				   -fno-builtin -fpic \
>  				   $(call cc-option,-mno-single-pic-base)
>  cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> -				   -fpic
> +				   -fpic -DRISCV_EFISTUB
>  cflags-$(CONFIG_LOONGARCH)	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  				   -fpie
>  
> -- 
> 2.35.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
