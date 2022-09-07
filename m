Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE565AF9E3
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 04:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIGCdL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 22:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIGCdK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 22:33:10 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A01293229
        for <linux-efi@vger.kernel.org>; Tue,  6 Sep 2022 19:33:04 -0700 (PDT)
X-UUID: 45cbe75e8763406dba3810755e4434fc-20220907
X-CPASD-INFO: 2930848a23544d76ab7174cf58a7f62d@e4ltUGVmZpFeU3eAg6eCcIGTZ2FnYIO
        1d3KBaJRmXoSVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBhXoZgUZB3gXttUGhiaA==
X-CLOUD-ID: 2930848a23544d76ab7174cf58a7f62d
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:1.0,URL:-5,TVAL:185.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:77.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:1.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:2,DUF:4210,ACD:72,DCD:72,SL:0,EISP:0,AG:0,CFC:0.336,CFSR:0.138,UAT:0,RAF
        :0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,EA
        F:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 45cbe75e8763406dba3810755e4434fc-20220907
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 45cbe75e8763406dba3810755e4434fc-20220907
X-User: chenzhang@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <chenzhang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2071156634; Wed, 07 Sep 2022 10:33:27 +0800
From:   chen zhang <chenzhang@kylinos.cn>
To:     ardb@kernel.org, baskov@ispras.ru, ilias.apalodimas@linaro.org
Cc:     chenzhang_0901@163.com, linux-efi@vger.kernel.org,
        chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH] efi/x86: libstub: remove unused variables
Date:   Wed,  7 Sep 2022 10:32:55 +0800
Message-Id: <20220907023255.35237-1-chenzhang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RDNS_DYNAMIC,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The variable "has_system_memory" is unused in
function ‘adjust_memory_range_protection’, remove it.

Signed-off-by: chen zhang <chenzhang@kylinos.cn>
---
 drivers/firmware/efi/libstub/x86-stub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 05ae8bcc9d67..43ca665af610 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -220,7 +220,6 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
 	unsigned long end, next;
 	unsigned long rounded_start, rounded_end;
 	unsigned long unprotect_start, unprotect_size;
-	int has_system_memory = 0;
 
 	if (efi_dxe_table == NULL)
 		return;
-- 
2.25.1

