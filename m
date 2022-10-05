Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2235E5F573D
	for <lists+linux-efi@lfdr.de>; Wed,  5 Oct 2022 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJEPOH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Oct 2022 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJEPOH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Oct 2022 11:14:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05E26E2C3;
        Wed,  5 Oct 2022 08:14:05 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7a3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7a3:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 767291EC0529;
        Wed,  5 Oct 2022 17:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664982840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=R3TwZBSPpDKUiyo8k8CnrauVQH4WeXZyWPcE47XsIJk=;
        b=qKqinGoSJi+3VUWCGlae2nlKs2V2fhVgFevONbjO9DEbdCoMplq60XbnVrfUhQrlhuL634
        e2Kk8oQrIY8yvOCIA/dGIRrYX0q8RKrB4+XAG/XuesE8yaeD+GWGwQx8i3+Qn3BL8LhFZi
        p6g8Hp1GV24CTvWxVV3PHdx+vz/DADQ=
Date:   Wed, 5 Oct 2022 17:13:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jia He <justin.he@arm.com>
Cc:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v7 3/8] EDAC:ghes: Move ghes_edac.force_load to ghes
 module parameter
Message-ID: <Yz2fM+IbEkKmt8Ct@zn.tnic>
References: <20220929023726.73727-1-justin.he@arm.com>
 <20220929023726.73727-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929023726.73727-4-justin.he@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 29, 2022 at 02:37:21AM +0000, Jia He wrote:
> ghes_edac_register() is too late to set this module flag ghes_edac.force_load.
> Also, other edac drivers should not be able to control this flag.
> 
> Move this flag to the module parameter in ghes instead.
> 
> Suggested-by: Toshi Kani <toshi.kani@hpe.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
> ---
>  drivers/acpi/apei/ghes.c |  8 ++++++++
>  drivers/edac/ghes_edac.c | 10 +++-------
>  include/acpi/apei.h      |  2 ++
>  3 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 8cb65f757d06..b0a6445c6da2 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -109,6 +109,14 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>  bool ghes_disable;
>  module_param_named(disable, ghes_disable, bool, 0);
>  
> +/*
> + * "ghes.edac_force_enable" forcibly enables ghes_edac and skips the platform
> + * check.
> + */
> +bool ghes_edac_force_enable;
> +EXPORT_SYMBOL(ghes_edac_force_enable);
> +module_param_named(edac_force_enable, ghes_edac_force_enable, bool, 0);

Why is this exported?

In the exemplary patch I sent you, that thing is static.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
