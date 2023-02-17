Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4369ADFC
	for <lists+linux-efi@lfdr.de>; Fri, 17 Feb 2023 15:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBQOX6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Feb 2023 09:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBQOX5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Feb 2023 09:23:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90AD7DA4;
        Fri, 17 Feb 2023 06:23:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A066B82C18;
        Fri, 17 Feb 2023 14:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FA3C433EF;
        Fri, 17 Feb 2023 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676643834;
        bh=7H2DeJNOEk7tlRz3sYy/zEMbu3crAXpNlXvgJu8H2B4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ryliv6CyfFtLPk07eFlM1P/VsYsX/f6nTJIhgKkH254ZWYbt9cspnrn7f4QUOpptC
         fjf3jxU0IFBjuoBPtPxdS+v1NW1iWasjA66+9Q3Rb2wBNfm+14lGYI41ySDBL75BGu
         7rrRGEtg277a9mtwJrZmnk6xcJonfwNLkFssKam4UBKiuShXyCEdxfBwKiVAJJM8/m
         dAU5npIUenIDIyvvYu+EOFTgJpiYwucd10LTamfKfrCM7wdIswihhnWoVziYyDh/bW
         NC027eQkGGG7gOkZKAN1N7EhLSOdirgZavRFYI+Od9xv4sZzhHx3MU2WUBopfGUezC
         8X0d+3A88l+uQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH] rtc: efi: Avoid spamming the log on RTC read failure
Date:   Fri, 17 Feb 2023 15:23:38 +0100
Message-Id: <20230217142338.1444509-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=ardb@kernel.org; h=from:subject; bh=7H2DeJNOEk7tlRz3sYy/zEMbu3crAXpNlXvgJu8H2B4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj743p2GXrREsNQPTcNdf5BEQsIa5li4nOa/vDP VT7oy+Ci+KJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY++N6QAKCRDDTyI5ktmP JOQMDADAj7RTrpvWaj/z9/rWenkV64kqh5DBzl+USFcDavcgaH9/HcyE/xMykGaNQtKzRTyZB6O 52ewPcDnWvyZxAubHoM8vQB8CVs3eVE30PpWWjv7pKUGrbqopFbsxoENfUnHG/BExKRSOu99deN CdlzHSBbWg2Hiy5QLY06dy1JeL22opoORoCiux6vS81PRnEJUBzO3PRs4LHkd01KtwM4R3Y86RS 8X38i3YmXU8wqrE3O3BhCBL3Jpkyf+DLxIqabkxUpJgIn1/9cKwp3qEot8wjqs/LxgaiOlERG7f cSH7S9dpfVPPWR/gICye4knitO0kwiqL7qAEHHVVnsB+Wwtn4tZBcT9MgMPW+YxztFraXUMPvrg LPWReVlyoUwsdxrXc93euUs13Qg3wH2ZGIza49byPzjAoAqJ1a/scwJb0ESsAjGerE2A8AIUnAq jFAZC8FxB16GF5LCDfsmHfzZtcqugLQ3tE1gNhUO9L+F7jJYDoA+lzxzdiuiEoTcMno4w=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There are cases where the EFI runtime services may end up in a funny
state, e.g., due to a crash in the variable services, and this affects
other EFI runtime services as well.

That means that, even though GetTime() should not return an error, there
are cases where it might, and there is no point in logging such an
occurrence multiple times.

This works around an issue where user space -apparently- keeps hitting
on /dev/rtc if it fails to read the h/w clock, resulting in a tsunami of
log spam and a non-responsive system as a result.

Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Link: https://lore.kernel.org/all/Y2o1hdZK9GGDVJsS@monolith.localdoman/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/rtc/rtc-efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index e991cccdb6e9cee4..174959f783b8309b 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -164,7 +164,7 @@ static int efi_read_time(struct device *dev, struct rtc_time *tm)
 
 	if (status != EFI_SUCCESS) {
 		/* should never happen */
-		dev_err(dev, "can't read time\n");
+		dev_err_once(dev, "can't read time\n");
 		return -EINVAL;
 	}
 
-- 
2.39.1

