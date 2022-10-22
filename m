Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A55A608E12
	for <lists+linux-efi@lfdr.de>; Sat, 22 Oct 2022 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJVPYD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Oct 2022 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJVPYC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Oct 2022 11:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599BC12767
        for <linux-efi@vger.kernel.org>; Sat, 22 Oct 2022 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666452240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UWUkuuCod8l5bJVZ5tTL+4nS+qttcoxn4McrP045ChQ=;
        b=TJokguSn0Db3cXEbhlwYxS2ygiK9/C6rZNGZUXpuGx6OIc0G/xyRnR4xrM4XyV2bR6LjC5
        tJYmwQfb2TvLWXOAJjevCLk0sfRNV9oLfGRcPkI9jICPsyhOxU8FPbGJmghQvbtI7TWZf0
        7QHewkQ8i/QITCSxsPOrvHtmG3J5BHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-ffCSfy1EOGur2LgQwF961Q-1; Sat, 22 Oct 2022 11:23:56 -0400
X-MC-Unique: ffCSfy1EOGur2LgQwF961Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62CE08027F5;
        Sat, 22 Oct 2022 15:23:56 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3AE22024CBF;
        Sat, 22 Oct 2022 15:23:55 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/tpm: Pass correct address to memblock_reserve
Date:   Sat, 22 Oct 2022 08:23:52 -0700
Message-Id: <20221022152352.1033750-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

memblock_reserve() expects a physical address, but the address being
passed for the TPM final events log is what was returned from
early_memremap(). This results in something like the following:

[    0.000000] memblock_reserve: [0xffffffffff2c0000-0xffffffffff2c00e4] efi_tpm_eventlog_init+0x324/0x370

Pass the address from efi like what is done for the TPM events log.

Fixes: c46f3405692d ("tpm: Reserve the TPM final events table")
Cc: Matthew Garrett <mjg59@google.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Bartosz Szczepanek <bsz@semihalf.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/firmware/efi/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 8f665678e9e3..e8d69bd548f3 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -97,7 +97,7 @@ int __init efi_tpm_eventlog_init(void)
 		goto out_calc;
 	}
 
-	memblock_reserve((unsigned long)final_tbl,
+	memblock_reserve(efi.tpm_final_log,
 			 tbl_size + sizeof(*final_tbl));
 	efi_tpm_final_log_size = tbl_size;
 
-- 
2.37.2

