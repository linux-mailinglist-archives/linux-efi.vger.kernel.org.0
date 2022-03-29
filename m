Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4131A4EB3B4
	for <lists+linux-efi@lfdr.de>; Tue, 29 Mar 2022 20:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbiC2Ste (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Mar 2022 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240709AbiC2Std (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Mar 2022 14:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02A2A1BFDC4
        for <linux-efi@vger.kernel.org>; Tue, 29 Mar 2022 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648579669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YU9NrQ7qR/EbmbaEdXYe2i+pIcnYUD7YyfctyhZp3Eo=;
        b=AZCNncq1BP96rPosS1vzW/7+k6xEWUISIftlS7OW0uxkF/zuR5f3pSTe6nWc6A/3wsp4Yz
        xlPiMgnqGXdTWP0RxC4ftpSn7e+h/33Z+QVhTP33FWOJxev/7KgeUtEFlZMSIdfGsVKWSs
        g4GBJmJ0I+PidfNS0osqQPrHoHtgUBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-nJkZiW8DPoGfT3MX3uCxFg-1; Tue, 29 Mar 2022 14:47:45 -0400
X-MC-Unique: nJkZiW8DPoGfT3MX3uCxFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2180985A5A8;
        Tue, 29 Mar 2022 18:47:45 +0000 (UTC)
Received: from random.internal.datastacks.com (unknown [10.2.17.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B29E32024CB7;
        Tue, 29 Mar 2022 18:47:44 +0000 (UTC)
From:   Peter Jones <pjones@redhat.com>
To:     baskov@ispras.ru
Cc:     ardb@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>
Subject: [PATCH] x86: Set the NX-compatibility flag in the PE header
Date:   Tue, 29 Mar 2022 14:47:43 -0400
Message-Id: <20220329184743.798513-1-pjones@redhat.com>
In-Reply-To: <20220329184712.vl7jzq23h5m5kvqh@redhat.com>
References: <20220329184712.vl7jzq23h5m5kvqh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Following Baskov Evgeniy's "Handle UEFI NX-restricted page tables"
patches, it's safe to set this compatibility flag to let loaders know
they don't need to make special accommodations for kernel to load if
pre-boot NX is enabled.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 arch/x86/boot/header.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 6dbd7e9f74c..0352e4589ef 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -163,7 +163,11 @@ extra_header_fields:
 	.long	0x200				# SizeOfHeaders
 	.long	0				# CheckSum
 	.word	IMAGE_SUBSYSTEM_EFI_APPLICATION	# Subsystem (EFI application)
+#ifdef CONFIG_DXE_MEM_ATTRIBUTES
+	.word	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	# DllCharacteristics
+#else
 	.word	0				# DllCharacteristics
+#endif
 #ifdef CONFIG_X86_32
 	.long	0				# SizeOfStackReserve
 	.long	0				# SizeOfStackCommit
-- 
2.35.1

