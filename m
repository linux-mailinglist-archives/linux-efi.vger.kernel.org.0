Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6B59FE74
	for <lists+linux-efi@lfdr.de>; Wed, 24 Aug 2022 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiHXPht (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Aug 2022 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbiHXPhX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Aug 2022 11:37:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC344D273;
        Wed, 24 Aug 2022 08:37:22 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EBDF71EC0532;
        Wed, 24 Aug 2022 17:37:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661355437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JYAdElWSvwdqbqowgbtvuq6MWUw4TqGpXu8bQC/7Pm0=;
        b=UvaT53Lw6sp3lDU5FY7nZjsV1hbuTZWYAMmqdC8eKRyh9ltPO6tLwxIlwKk+8WTRQWWyyA
        AMVCFJSIqSBkfPt8bkMdizEECMfOW+s1lKwp+rXmY5TNNh3+/CH31j9ASnJsPM2WPV/yIF
        o75/irqxga5m3fD7BkiINcNIrsXo/Xg=
Date:   Wed, 24 Aug 2022 17:37:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jia He <justin.he@arm.com>
Cc:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-doc@vger.kernel.org, stable@kernel.org
Subject: Re: [RESEND PATCH v3 3/9] EDAC/ghes: Make ghes_edac a proper module
 to remove the dependency on ghes
Message-ID: <YwZFqHvcEzVpAxzn@zn.tnic>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220822154048.188253-4-justin.he@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 22, 2022 at 03:40:42PM +0000, Jia He wrote:
> Commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in
> apci_init()") introduced a bug that ghes_edac_register() would be invoked
> before edac_init(). Because at that time, the bus "edac" hadn't been even
> registered, this created sysfs /devices/mc0 instead of
> /sys/devices/system/edac/mc/mc0 on an Ampere eMag server.
> 
> To remove the dependency of ghes_edac on ghes, make it a proper module. Use
> a list to save the probing devices in ghes_probe(), and defer the
> ghes_edac_register() to module_init() of the new ghes_edac module by
> iterating over the devices list.
> 
> Co-developed-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Jia He <justin.he@arm.com>
> Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
> Cc: stable@kernel.org

Why is this marked for stable?

The prerequisite patches are needed too. I guess this needs to be
communicated to stable folks somehow by doing

Cc: stable@kernel.org # needs commits X, Y, ...

but I guess the committer needs to do that because only at commit time
will X and Y be known...

So, is there any particular reason why this should be in stable?

> @@ -1442,7 +1449,9 @@ static int ghes_remove(struct platform_device *ghes_dev)
>  
>  	ghes_fini(ghes);
>  
> -	ghes_edac_unregister(ghes);
> +	mutex_lock(&ghes_devs_mutex);
> +	list_del_rcu(&ghes->elist);

Is that list RCU-protected?

> +	mutex_unlock(&ghes_devs_mutex);
>  
>  	kfree(ghes);

...

> @@ -566,3 +549,35 @@ void ghes_edac_unregister(struct ghes *ghes)
>  unlock:
>  	mutex_unlock(&ghes_reg_mutex);
>  }
> +
> +static int __init ghes_edac_init(void)
> +{
> +	struct ghes *g, *g_tmp;
> +
> +	if (!IS_ENABLED(CONFIG_X86))
> +		force_load = true;

No, this is not how this works.

> +	ghes_devs = ghes_get_devices(force_load);
> +	if (!ghes_devs)
> +		return -ENODEV;

You simply need to check force_load here.

> +	list_for_each_entry_safe(g, g_tmp, ghes_devs, elist) {
> +		ghes_edac_register(g->dev);
> +	}
> +
> +	return 0;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
