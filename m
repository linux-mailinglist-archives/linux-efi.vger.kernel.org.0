Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEC7603453
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 22:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJRUva (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 16:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJRUv3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 16:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCBF7C74C
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 13:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666126288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eWi6wuB5HGGcs2ZE5l92syX7bW4mEyCwXTaW+zedCrM=;
        b=Ix82LLwatEp3OlgKh3BvP2JbK/PjL3GUlZw9bwD6DnKr/oivmf2UJKa8XfskMpK4Pf2eKe
        OVIpqL81rX5KH7/jwaSWY2vMv6Y0y7soHE3B4uyKBvs+Wb/+YclrxfN/LO/OiwImzTRTg2
        86F2iX9Mg8NftPNAME2HHspqS595ZrY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-6hu93Nz5PluP7rG2sEfPfA-1; Tue, 18 Oct 2022 16:51:24 -0400
X-MC-Unique: 6hu93Nz5PluP7rG2sEfPfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 054BB3C3C968;
        Tue, 18 Oct 2022 20:51:24 +0000 (UTC)
Received: from random.internal.datastacks.com (unknown [10.2.17.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAF5F9E70;
        Tue, 18 Oct 2022 20:51:22 +0000 (UTC)
From:   Peter Jones <pjones@redhat.com>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Peter Jones <pjones@redhat.com>
Subject: [PATCH] efi/libstub: make memory protection warnings include newlines.
Date:   Tue, 18 Oct 2022 16:51:18 -0400
Message-Id: <20221018205118.3756594-1-pjones@redhat.com>
In-Reply-To: <5de2d80398986b81b6cfcdd35436bba8bf62c0e7.1662459668.git.baskov@ispras.ru>
References: <5de2d80398986b81b6cfcdd35436bba8bf62c0e7.1662459668.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efi_warn() doesn't put newlines on messages, and that makes reading
warnings without newlines hard to do.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 drivers/firmware/efi/libstub/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 4d6c7f4fb7e..1b874096109 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -293,7 +293,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 				rounded_end - rounded_start,
 				attr_clear);
 	if (status != EFI_SUCCESS) {
-		efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx",
+		efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx\n",
 			 (unsigned long)rounded_start,
 			 (unsigned long)rounded_end,
 			 status);
@@ -306,7 +306,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 				rounded_end - rounded_start,
 				attributes);
 	if (status != EFI_SUCCESS) {
-		efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx",
+		efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx\n",
 			 (unsigned long)rounded_start,
 			 (unsigned long)rounded_end,
 			 status);
-- 
2.37.1

