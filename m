Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5435FDF2D
	for <lists+linux-efi@lfdr.de>; Thu, 13 Oct 2022 19:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJMRm2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Oct 2022 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJMRm1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Oct 2022 13:42:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6BEE09F6;
        Thu, 13 Oct 2022 10:42:26 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e733329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e733:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EC5211EC05DD;
        Thu, 13 Oct 2022 19:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665682941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8xuLhSs8dsjfQL2DoJpmLFVCxVAcAP14v8iSD+oUuBQ=;
        b=ZSHQJzyhXhcM4IDgdrqZZtst/sUodv3kkGVmHDukY1HQRyrbBWlLdrCUC44rGGzLVaGLxM
        J4yzTRS60rGBmDgTm/bEPn8YDuA8WOzqAY+fsYJq6mFFbcHY3I2hzQa7NocCtB5Wyx55/b
        FWwtWhGyZjstDOu2c1rBO4ozVuj0l/M=
Date:   Thu, 13 Oct 2022 19:42:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Huang Ying <ying.huang@intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Justin He <Justin.He@arm.com>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
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
Message-ID: <Y0hN+Cd8ZT1d9f7e@zn.tnic>
References: <20221010023559.69655-1-justin.he@arm.com>
 <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic>
 <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic>
 <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0gUpoaUBKw/jjaD@zn.tnic>
 <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
 <Y0hAuBkmiUGfCs8/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0hAuBkmiUGfCs8/@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 13, 2022 at 06:45:44PM +0200, Peter Zijlstra wrote:
> Borislav is thinking too much x86. Failed cmpxchg() does indeed not
> imply any memory ordering for all architectures -- and while the memory
> clobber (aka. barrier()) is equivalent to an smp_wmb() on x86, that most
> certainly doesn't hold for non x86 code.

Right, but the patch was addied by an Intel person, CCed:

152cef40a808 ("ACPI, APEI, GHES, Error records content based throttle")a

So I don't think he was thinking about ARM when doing that.

And that commit message doesn't say one whit why that memory barrier is
needed there.

Reading that comment, it sounds like he wanted a hw memory barrier -
MFENCE - but I don't see how normal data dependency wouldn't enforce the proper order
already...

So that barrier looks out of place there.

Btw, this is the next perfect example why I'm asking people to write
proper commit messages so that when we do git archeology later, we can
figure out why something was done the way it has been.

And in this case, we can't. ;-\

Because writing proper commit messages is for losers. Yeah, right.</sarcasm>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
