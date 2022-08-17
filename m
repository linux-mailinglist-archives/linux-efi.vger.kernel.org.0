Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D863959785F
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 23:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbiHQU4t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 16:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241930AbiHQU4q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 16:56:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B26AA3F5;
        Wed, 17 Aug 2022 13:56:37 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 664C81EC04E4;
        Wed, 17 Aug 2022 22:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660769791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tiVP7B7HqlfzlVZrDZyL75M10GyjhcXbSwt07RTWZz4=;
        b=Ayv1JslMZL8aHi7lmTwUrwErDmFhCns2DXnPfcwP1ZOzGxyfumd79YfsIECTf3/8jtq4CY
        OFkuFnmJ5Msr+LtZi1xc7pDi2lOdFj2RGpjwRv24vR0RAIJBt79eMbpWoUiJychaR4habb
        Vc1dbgCzGJMjWOFJjJNo07kUBBkVQJM=
Date:   Wed, 17 Aug 2022 22:56:26 +0200
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
Message-ID: <Yv1V+gWICIcuNXdE@zn.tnic>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-3-justin.he@arm.com>
 <YvZnrTrXhRn8FV3I@zn.tnic>
 <DBBPR08MB45389A9DB098F1AC14C19074F76B9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <PH7PR84MB1838203B478319EA45167BB4826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvyruNX+BUi+O3Df@zn.tnic>
 <PH7PR84MB183888AC20B37A3D891C332D826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR84MB183888AC20B37A3D891C332D826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 17, 2022 at 08:22:58PM +0000, Kani, Toshi wrote:
> ghes_edac is used on Arm. This original issue happened on a non-HPE
> platform.

Remember: ghes_edac loads only on known-good platforms - not the other
way around. If ARM folks wanna use it there, then I'd expect explicit
enablement to do so.

> to keep it protected from any edac driver.

You got this all backwards. If anything, the kernel should be protected
from ghes.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
