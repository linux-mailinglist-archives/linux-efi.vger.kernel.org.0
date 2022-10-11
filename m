Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61F05FB4D7
	for <lists+linux-efi@lfdr.de>; Tue, 11 Oct 2022 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJKOpw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Oct 2022 10:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJKOpw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Oct 2022 10:45:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C38F4DB57;
        Tue, 11 Oct 2022 07:45:50 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e717329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e717:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95A031EC058A;
        Tue, 11 Oct 2022 16:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665499545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CBtcYErXPbo1FB0vxdU7KXTR1am7Ih8oyW4Mdfq5JAk=;
        b=Kyh4L3Fg9r6gKmPgTWhLfqqp8UCd8dnhwk96AzSfnYL05Kb4QhH0fnj5hp8ZYUOllRgfrS
        68Mi/2WxsO/OtVvoE/1a7EB6uWm4DHgK6FOF/Ac35m97F+W2F/+whJcTfC/kW8RB6GIbxM
        5fxN4ufMbgJFfMIrSyPtPNlOxXyAoFA=
Date:   Tue, 11 Oct 2022 16:45:38 +0200
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
Message-ID: <Y0WBklS1XpB5as+m@zn.tnic>
References: <20221010023559.69655-1-justin.he@arm.com>
 <20221010023559.69655-7-justin.he@arm.com>
 <Y0VGkUxpqiIzIFzB@zn.tnic>
 <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 11, 2022 at 02:32:48PM +0000, Justin He wrote:
> My original purpose is to make it pass the sparse checking.

Then do this pls.

This is a combined diff - do a second patch which does only remove the
smp_wmb(). The smp_wmb() there is not needed as the cmpxchg() already
implies a smp_mb() so there's no need for that separate, explicit one.

But it would be prudent to have it in a separate patch just in case.

Thx.

---
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 85acfc589fb7..fd285bf8d114 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -154,7 +154,7 @@ struct ghes_vendor_record_entry {
 static struct gen_pool *ghes_estatus_pool;
 static unsigned long ghes_estatus_pool_size_request;
 
-static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
+static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
 static int ghes_panic_timeout __read_mostly = 30;
@@ -842,9 +842,7 @@ static void ghes_estatus_cache_add(
 			slot_cache = cache;
 		}
 	}
-	/* new_cache must be put into array after its contents are written */
-	smp_wmb();
-	if (slot != -1 && cmpxchg(ghes_estatus_caches + slot,
+	if (slot != -1 && cmpxchg((struct ghes_estatus_cache ** __force)(ghes_estatus_caches + slot),
 				  slot_cache, new_cache) == slot_cache) {
 		if (slot_cache)
 			call_rcu(&slot_cache->rcu, ghes_estatus_cache_rcu_free);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
