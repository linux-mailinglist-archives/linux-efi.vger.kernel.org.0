Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED89764BB8A
	for <lists+linux-efi@lfdr.de>; Tue, 13 Dec 2022 19:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiLMSFM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Dec 2022 13:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiLMSFJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Dec 2022 13:05:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2023BDE
        for <linux-efi@vger.kernel.org>; Tue, 13 Dec 2022 10:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670954664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9442XwFq1UOnuBhQolOjrgRBVO4GjmHmhrVClvO1uGo=;
        b=GwWW8qFBe5ahLcCVxQ4rdRM84ViLdxxhzSf6gg+5BO4mzALJ9neVZx0TUpuFcqDk65Zxch
        PkmUaPo90KWu2mIHe5SL1p0J1VKXKaeDIBqN9RIKFcE/FV42DO0AL/RweFuSwch4yODx3/
        0Hg1pbG5a3kcqXG2PlmTsftOZCajruM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326--myBm3lRMLecQIMerV2KPw-1; Tue, 13 Dec 2022 13:04:22 -0500
X-MC-Unique: -myBm3lRMLecQIMerV2KPw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F3508032E6;
        Tue, 13 Dec 2022 18:04:21 +0000 (UTC)
Received: from random.internal.datastacks.com (unknown [10.2.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82EE3492B00;
        Tue, 13 Dec 2022 18:04:20 +0000 (UTC)
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
Subject: [PATCH 2/2] efi/x86: don't try to set page attributes on 0-sized regions.
Date:   Tue, 13 Dec 2022 13:04:03 -0500
Message-Id: <20221213180403.1308507-2-pjones@redhat.com>
In-Reply-To: <20221213180403.1308507-1-pjones@redhat.com>
References: <20221213180317.qoy2l3mcpjparocq@redhat.com>
 <20221213180403.1308507-1-pjones@redhat.com>
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

In "efi/x86: Explicitly set sections memory attributes", the following
region is defined to help compute page permissions:

          /* .setup [image_base, _head] */
          efi_adjust_memory_range_protection(image_base,
                                             (unsigned long)_head - image_base,
                                             EFI_MEMORY_RO | EFI_MEMORY_XP);

In at least some cases, that will result in a size of 0, which will
produce an error and a message on the console, though no actual failure
will be caused in the boot process.

This patch checks that case in efi_adjust_memory_range_protection() and
returns the error without logging.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 drivers/firmware/efi/libstub/mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index d52841adcc2..d20b1986c9e 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -247,6 +247,9 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 	efi_physical_addr_t rounded_start, rounded_end;
 	unsigned long attr_clear;
 
+	if (size == 0)
+		return EFI_INVALID_PARAMETER;
+
 	/*
 	 * This function should not be used to modify attributes
 	 * other than writable/executable.
-- 
2.38.1

