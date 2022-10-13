Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A137F5FDB04
	for <lists+linux-efi@lfdr.de>; Thu, 13 Oct 2022 15:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJMNhz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Oct 2022 09:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJMNhx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Oct 2022 09:37:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84AA5143F;
        Thu, 13 Oct 2022 06:37:51 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e733329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e733:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DB8C1EC054C;
        Thu, 13 Oct 2022 15:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665668266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EmYBLVOiMUuM+RODYtYXcffudc/+Ogx/DDE0gYCil7U=;
        b=OZUMz+OxHh+lwtAeniW1/rexhDd7+lG+ovqcaYcrkDTFT04h1cESWqeeg3thaNhiGLIGtD
        JsisTkujOaQQTE6wtJCyxLdAsP/PE4nGhCB3pNuPGQgKxei5++Nf6fW8Jy6m9U5jmm7guf
        U2pmYireE6tvSKMYuKu0KXPvDsvceok=
Date:   Thu, 13 Oct 2022 15:37:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Justin He <Justin.He@arm.com>
Cc:     Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Message-ID: <Y0gUpoaUBKw/jjaD@zn.tnic>
References: <20221010023559.69655-1-justin.he@arm.com>
 <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic>
 <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic>
 <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 12, 2022 at 12:04:57PM +0000, Justin He wrote:
> I have a concern about what if cmpxchg failed? Do we have to still
> guarantee the ordering since cmpxchg will not imply a smp_mb if it
> failed.

Of course it will imply that. At least on x86 it does. smp_wmb() is a
compiler barrier there and cmpxchg() already has that barrier semantics
by clobbering "memory". I'm pretty sure you should have the same thing
on ARM.

And even if that weren't the case, the write barrier is, as the comment
says, "new_cache must be put into array after its contents are written".

Are we writing anything into the cache if cmpxchg fails?

> Besides, I didn't find the paired smp_mb or smp_rmb for this smp_wmb.

Why would there be pairs? I don't understand that statement here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
