Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2234A5978FD
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 23:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiHQVfD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 17:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241642AbiHQVfC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 17:35:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC877E95;
        Wed, 17 Aug 2022 14:35:01 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61E331EC058B;
        Wed, 17 Aug 2022 23:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660772095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ru/cgvADbJiW8w5IiV58rSJlrqdyDvFI3tr2tbrj/vk=;
        b=Y+gh/Xt8pqyWjuRv7JYblZFKoRXX7/zOdUGBXwql0qeCTZ/QkNXwzyqNptcpiWSPnWPrdz
        Rf4D5jf6rvjEJeZzhsMbVa4kcly9dyKf3qStJYPKewC8ZUTXmyNRUyY0jtit9chxIf2mHM
        NfEriH4Z3NrRDGDubdKMUGpVPJxAqkI=
Date:   Wed, 17 Aug 2022 23:34:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     Justin He <Justin.He@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, "stable@kernel.org" <stable@kernel.org>
Subject: Re: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Message-ID: <Yv1e+Hez9ejaiHav@zn.tnic>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-3-justin.he@arm.com>
 <YvZnrTrXhRn8FV3I@zn.tnic>
 <DBBPR08MB45389A9DB098F1AC14C19074F76B9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <PH7PR84MB1838203B478319EA45167BB4826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvyruNX+BUi+O3Df@zn.tnic>
 <PH7PR84MB183888AC20B37A3D891C332D826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <Yv1V+gWICIcuNXdE@zn.tnic>
 <PH7PR84MB1838B5AE91C939D3C9D872A2826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR84MB1838B5AE91C939D3C9D872A2826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 17, 2022 at 09:09:41PM +0000, Kani, Toshi wrote:
> Since then, the change below enabled ghes_edac on Arm without this
> known-good platforms check.
> 
> commit eaa3a1d46 ("EDAC, ghes: Make platform-based whitelisting x86-only")

Bah, I had forgotten about that one...

In any case, edac_mc_add_mc* is too late in the init path - that check
should happen as the very first thing in the driver init function.

And looking at the ARM64 EDAC drivers, they're only a couple: thunderx,
xgene, bluefield, dmc-520... And I'd still prefer if their maintainers
explicitly ACK such a change to call ghes_get_devices() (for a lack of a
better idea) and not enable ghes_edac on them blindly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
