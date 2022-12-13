Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA92F64BB88
	for <lists+linux-efi@lfdr.de>; Tue, 13 Dec 2022 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiLMSFG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Dec 2022 13:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbiLMSFF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Dec 2022 13:05:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0729D1DF3B
        for <linux-efi@vger.kernel.org>; Tue, 13 Dec 2022 10:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670954655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JF2s0tm6WDQRqQHFNtrMHbtnveQJl7hXDtEAPn+pSMA=;
        b=WExQXCoiOPsQA4r18oIk1+CGOYqpJIFeVqqnMGsLIQAPKwg0U8B+sCOnDcXhVex52A3WhV
        DrGR84le3eGfrbvm7gnu9AqU87RQVMKVk81YEbVri7vhdMq2zL795K4RjUZMMTCr2Z1gky
        0nGvWDAFLk4SMk0Kf+HvkFq/88x/AQk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-_ZICaESyNZOLTHro1IRTMg-1; Tue, 13 Dec 2022 13:04:11 -0500
X-MC-Unique: _ZICaESyNZOLTHro1IRTMg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A4DA29324AF;
        Tue, 13 Dec 2022 18:04:11 +0000 (UTC)
Received: from random.internal.datastacks.com (unknown [10.2.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BED3492B02;
        Tue, 13 Dec 2022 18:04:10 +0000 (UTC)
From:   Peter Jones <pjones@redhat.com>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] efi/x86: don't set unsupported memory attributes
Date:   Tue, 13 Dec 2022 13:04:02 -0500
Message-Id: <20221213180403.1308507-1-pjones@redhat.com>
In-Reply-To: <20221213180317.qoy2l3mcpjparocq@redhat.com>
References: <20221213180317.qoy2l3mcpjparocq@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On platforms where the firmware uses DXE, but which do not implement the
EFI Memory Attribute Protocol, we implement W^X support using DXE's
set_memory_attributes() call.  This call will fail without making any
changes if an attribute is set that isn't supported on the platform.

This patch changes efi_adjust_memory_range_protection() to avoid trying
to set any attribute bits that aren't set in the memory region's
capability flags.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 drivers/firmware/efi/libstub/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index d10996e4eb0..d52841adcc2 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -192,6 +192,7 @@ static efi_status_t adjust_mem_attrib_dxe(efi_physical_addr_t rounded_start,
 
 		desc.attributes &= ~(EFI_MEMORY_RO | EFI_MEMORY_XP);
 		desc.attributes |= attributes;
+		desc.attributes &= desc.capabilities;
 
 		unprotect_start = max(rounded_start, desc.base_address);
 		unprotect_size = min(rounded_end, next) - unprotect_start;
-- 
2.38.1

