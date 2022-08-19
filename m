Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C409C59A566
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350713AbiHSSaA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 14:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349836AbiHSS36 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 14:29:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BFC13F8C;
        Fri, 19 Aug 2022 11:29:57 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9849329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9849:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B63901EC04E4;
        Fri, 19 Aug 2022 20:29:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660933791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PyT9/85JVzGP3jC5Crgn58YIj9u1Pbo5FkHQe8ujXP8=;
        b=Yjg2XX6u5aFtsDOFXcFvWGnQGNa4sHsElGU3UAOCQEQIKYIiI5EfB39BmVQpFBqkq8Rij2
        ntm6FbkBzr3YJIJrUX66ZF0WB8gsT2khVCY3kVEL2LGG9nAugXJiEYDIhD7t/JG1kJVDD9
        dRfJh9Pa6Q/tX9tLiq0JzSMJPwf/gtE=
Date:   Fri, 19 Aug 2022 20:29:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     Justin He <Justin.He@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Message-ID: <Yv/Wm/Zf0kdGgT33@zn.tnic>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-6-justin.he@arm.com>
 <DM4PR84MB18538A56870A280CDC4637A7826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <DBBPR08MB453891E87563F1BBE291248AF76C9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DM4PR84MB1853B213F2F45E495D9D6446826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR84MB1853B213F2F45E495D9D6446826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 19, 2022 at 05:48:39PM +0000, Kani, Toshi wrote:
> This flag is a static variable, say ghes_present, which is set to
> false initially. ghes_probe() sets it to true. ghes_edac_preferred()
> (aka. ghes_get_device) checks this flag at beginning and returns false
> if this flag is false. It does not get unlatched since ACPI GHES table
> is static.

What is that flag needed for at all?

There are two possibilities:

1. ghes_probe() succeeds. ghes_edac loads properly and other drivers use
ghes_get_devices() to know when to load.

2. ghes_probe() fails and that is caught during platform testing of all
those platforms who wish to use ghes_edac. BIOS is fixed and goto 1.

No need for funky flags whatsoever.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
