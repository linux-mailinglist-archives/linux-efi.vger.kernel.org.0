Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991174EE3DA
	for <lists+linux-efi@lfdr.de>; Fri,  1 Apr 2022 00:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbiCaWN3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 18:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242294AbiCaWN2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 18:13:28 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611A32467D5;
        Thu, 31 Mar 2022 15:11:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dr20so2108365ejc.6;
        Thu, 31 Mar 2022 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSHqaeCwi2QD3QGRa2HT7kH4AFnUyMZ52I3NV95q5GM=;
        b=Pan4DsKz/3eGh99T01l3+pjIWjhQWcMXgqhP6g3wWts1Nc3tuD/v8nE9cIUShX+1+6
         N/uT3WyhLdhLZgH7p1Pmpp7rn/jgGyhrMzyPT7FomwdA68v5BrmFhiFhngsP0zuxLk19
         EblbpXz3Mb5bfjrFqtCdvFNawCYr5KizCrMMS3hgv0WApHIRzMTyao8DS6ByGRnz7adF
         Ijlmoivly5IS86Mrg9+YuixMXgwVSq9t8x76CtIBcf5iH8bMmuXRN/Igzua63es8gYG0
         F3J+KX0GoAKD5VFYOCaX6YYnjj63XR5AsJemXHpmRPaozh18Sr+D232fxWKoQx2ofHni
         tKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSHqaeCwi2QD3QGRa2HT7kH4AFnUyMZ52I3NV95q5GM=;
        b=XwssCdNT02qwbQJr0A46qrddAbJ5hJPs8tVhkBsJFfx31+PQwGLxJvHymrmLRCAeZK
         K81Pi/9/+xvx3qPqSkZKJpApSktq+6UaYm2SvwyTdKrzLaF1/1BqoC6cSx57LoqBDEoj
         bVLeJaQq7STa4c/5pybztgOVrlUuDYR+cve23ZpIoN/S19GYVsFZzP7My9FXKqtaTM+0
         WE1JFDe2TZK3oimDFzI0QCoTo4svLb040sdc3V34EKNr6ZQPXPaHp4s2lGDzn5zq2MGH
         Mnrnunsg80rYpufiCM3f35Lk4uSd1/1QwVh0es4HDgtqw0q8W9dLUO0bzlv/pq0ZAmp0
         fXFw==
X-Gm-Message-State: AOAM531/UekHJAYii0el7Ebqd9ll+54xiHTlMbESeuzFzIXxZRRvZf8H
        bDtZYMbrv1MIdY3YfYA195M8tVe7TfS8Cg==
X-Google-Smtp-Source: ABdhPJyqWITxbnsFHIxvaXumnsP+t28c0RZ1VaYZy5bhDwV+SEVUTXvlHQUE7rUmWP+CXDa5mLgmrw==
X-Received: by 2002:a17:906:3ec7:b0:6d6:e52b:b with SMTP id d7-20020a1709063ec700b006d6e52b000bmr6931528ejj.521.1648764698980;
        Thu, 31 Mar 2022 15:11:38 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z6-20020a056402274600b004194fc1b7casm321322edd.48.2022.03.31.15.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:11:38 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 2/2] efi: replace usage of found with dedicated list iterator variable
Date:   Fri,  1 Apr 2022 00:10:30 +0200
Message-Id: <20220331221030.889718-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331221030.889718-1-jakobkoschel@gmail.com>
References: <20220331221030.889718-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/firmware/efi/vars.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 3994aad38661..e4e1cc593441 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -809,22 +809,21 @@ EXPORT_SYMBOL_GPL(efivar_entry_set_safe);
 struct efivar_entry *efivar_entry_find(efi_char16_t *name, efi_guid_t guid,
 				       struct list_head *head, bool remove)
 {
-	struct efivar_entry *entry, *n;
+	struct efivar_entry *entry = NULL, *iter, *n;
 	int strsize1, strsize2;
-	bool found = false;
 
-	list_for_each_entry_safe(entry, n, head, list) {
+	list_for_each_entry_safe(iter, n, head, list) {
 		strsize1 = ucs2_strsize(name, 1024);
-		strsize2 = ucs2_strsize(entry->var.VariableName, 1024);
+		strsize2 = ucs2_strsize(iter->var.VariableName, 1024);
 		if (strsize1 == strsize2 &&
-		    !memcmp(name, &(entry->var.VariableName), strsize1) &&
-		    !efi_guidcmp(guid, entry->var.VendorGuid)) {
-			found = true;
+		    !memcmp(name, &(iter->var.VariableName), strsize1) &&
+		    !efi_guidcmp(guid, iter->var.VendorGuid)) {
+			entry = iter;
 			break;
 		}
 	}
 
-	if (!found)
+	if (!entry)
 		return NULL;
 
 	if (remove) {
-- 
2.25.1

