Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A835855B4
	for <lists+linux-efi@lfdr.de>; Fri, 29 Jul 2022 21:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbiG2Tr5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Jul 2022 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiG2Tr4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Jul 2022 15:47:56 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063E267586;
        Fri, 29 Jul 2022 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gSESq/zVK6WSQ3xcbCVSVTd/pkQVDwB+RHkhs8Ulxac=; b=gNAcLB5d5hgvc2ZzPkGFjiZVW7
        0wze4qmrg6EMBcxInS7qXkVTjCCvh+IdzCRriHcL10eYbixF8Fqa7w/I9C07CmmJIMPxBDt7O5VHJ
        75RVNHJd//nqO9xg5YO7UFgFbQE0GmGCv8A+gECGgvVeTpeGw3BSLBiW36dO/wStv3fsz7pxq1zAF
        wZU9FHxDfm8wx9NyiextdgXREkwhSoz4tRJ+r26MOhdEh9xz1DgVzY/qSM/+4kSZ9KKRdvsRn3Poo
        OPJHBOf05KYUFR+QRMLKXfLtzM7jqKM7B332IBErDQ21kEZKCnzqyZlETL3ipEjedfzqbpOsKuU3L
        M+ikN8QQ==;
Received: from [177.83.209.223] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oHVxf-00BMHE-D5; Fri, 29 Jul 2022 21:47:54 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        keescook@chromium.org, matt@codeblueprint.co.uk,
        mjg59@srcf.ucam.org, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v2 2/3] efi: efibc: Guard against allocation failure
Date:   Fri, 29 Jul 2022 16:45:31 -0300
Message-Id: <20220729194532.228403-3-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729194532.228403-1-gpiccoli@igalia.com>
References: <20220729194532.228403-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There is a single kmalloc in this driver, and it's not currently
guarded against allocation failure. Do it here by just letting the
reboot handler to proceed, in case this tentative allocation fails.

Fixes: 416581e48679 ("efi: efibc: avoid efivar API for setting variables")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

Notice the sha-1 hash of the efibc patch we're fixing is from efi/next,
might change in upstream once such patch is merged.
Feel free to remove the fixes tag if it makes sense, no issues from me =)

 drivers/firmware/efi/efibc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 7e3bf60d24e0..9a8d914f91a6 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -48,6 +48,8 @@ static int efibc_reboot_notifier_call(struct notifier_block *notifier,
 		return NOTIFY_DONE;
 
 	wdata = kmalloc(MAX_DATA_LEN * sizeof(efi_char16_t), GFP_KERNEL);
+	if (!wdata)
+		return NOTIFY_DONE;
 
 	len = efi_str8_to_str16(wdata, str, MAX_DATA_LEN - 1);
 
-- 
2.37.1

