Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251685FF42A
	for <lists+linux-efi@lfdr.de>; Fri, 14 Oct 2022 21:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiJNTki (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Oct 2022 15:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJNTkh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Oct 2022 15:40:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45298A837C;
        Fri, 14 Oct 2022 12:40:36 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ed329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ed:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70C4B1EC0745;
        Fri, 14 Oct 2022 21:40:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665776430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gS8YSB+heQVRjPD7iCJnDYGh7BxBWDNwHZ4jNTcuxBU=;
        b=M13u7k0pbfrU8wuADrTQVEqpeI8Y0B1I2VnJS6/MfDuTuPQeeTjPsITS+TOuwdYOTpOdCR
        K+MtYZU6CRQJI6NenTPCibhr5fig4MWHCBgylAWQ+84EBneoWZYlZ5gpswz3V/6bhYznaT
        z9QvCCxrpJZxIHRAtnhiDcRJ9c6TXEY=
Date:   Fri, 14 Oct 2022 21:40:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Justin He <Justin.He@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
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
Message-ID: <Y0m7KpdSAi6wIgfb@zn.tnic>
References: <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic>
 <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic>
 <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0gUpoaUBKw/jjaD@zn.tnic>
 <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
 <Y0hAuBkmiUGfCs8/@hirez.programming.kicks-ass.net>
 <Y0hN+Cd8ZT1d9f7e@zn.tnic>
 <CAMj1kXGQmo9xstNY9B8Mp2gujXLTqCsV1u3PQKLtHg-WpWeLDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGQmo9xstNY9B8Mp2gujXLTqCsV1u3PQKLtHg-WpWeLDA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 14, 2022 at 11:40:39AM +0200, Ard Biesheuvel wrote:
> The cache struct pointer should not be published until after the
> struct itself is fully populated. So on the producer side, some kind
> of hardware barrier is definitely needed, or the struct may appear
> half-baked to other cores that can read the updated pointer.

Ah, right you are, ghes_estatus_cached() is called in all kinds of
contexts and by other cores, sure.

> OTOH the code seems to be working fine as is, so why modify it at all?
> (apart from the purely cosmetic changes)

peterz questioned that smp_wmb() there and then we started digging. And
frankly, even if removing that barrier won't make any difference, I'd
still prefer it gone and have the code simpler and cleaner.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
