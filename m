Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130485FDE63
	for <lists+linux-efi@lfdr.de>; Thu, 13 Oct 2022 18:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJMQmE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Oct 2022 12:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJMQmC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Oct 2022 12:42:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057D14D1F6;
        Thu, 13 Oct 2022 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PB0menPbE3/zpDuGtrrHUqPCxD+sXvFiKDjJnOk3le0=; b=mHw1gOFheyKaRkh11BkNeEkj4m
        5m0sxDMQ+cxlq3OgFmnoyU6NCtpU/ZvPzEvrDusPtCMElc2PJdltTrsRV9fBcr/nWM4k8a/3b1Eel
        pc8tsCDDGf7E7yhVGUwqttVQssDY1b64+3G6AOJ7fJ9dPAmEYhFdMdscOO1B82eLA1FIZmHT0USrV
        SJR1g0RbO41LuS2zPkirQNgmVoo841IgISVUjyXQna7/FVOtVzEuNIsRm6QfdjPx7uecnzsiouaie
        IGDK8IrzekdhFNh5DWu/zafmjBmVEkWzGs4wdi9i+t9loRcY2ge5XxHV3UM366yky/TsD4BLDGfVo
        dSZmkaog==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oj1Gz-003A4G-3k; Thu, 13 Oct 2022 16:41:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA50B3001CB;
        Thu, 13 Oct 2022 18:41:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 700722BDAF0D5; Thu, 13 Oct 2022 18:41:26 +0200 (CEST)
Date:   Thu, 13 Oct 2022 18:41:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Justin He <Justin.He@arm.com>
Cc:     Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
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
Message-ID: <Y0g/tkm3a3Rm2RlK@hirez.programming.kicks-ass.net>
References: <20221010023559.69655-1-justin.he@arm.com>
 <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic>
 <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic>
 <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 12, 2022 at 12:04:57PM +0000, Justin He wrote:

> > This is a combined diff - do a second patch which does only remove the
> > smp_wmb(). The smp_wmb() there is not needed as the cmpxchg() already
> > implies a smp_mb() so there's no need for that separate, explicit one.
> > 
> I have a concern about what if cmpxchg failed? Do we have to still
> guarantee the ordering since cmpxchg will not imply a smp_mb if it
> failed.
> 
> Besides, I didn't find the paired smp_mb or smp_rmb
> for this smp_wmb. Do you have any ideas?

failed cmpxchg does indeed not imply smp_mb; but in that case I can't
find a store it orders against; and the comment is utterly shite since
it doesn't spell out the ordering in any case.

The way I read that code is that the cmpxchg effectively publishes the
data and all it wants to ensure is that if the pointer is publised the
object is complete -- in which case the cpmxchg() is sufficient, on
success the object is published and you get the ordering, on failure the
object isn't published and nobody cares about the ordering anyway.

If there's anything else, the comment is in dire need of fixing anyway.
