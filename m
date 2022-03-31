Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42904EE3DB
	for <lists+linux-efi@lfdr.de>; Fri,  1 Apr 2022 00:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbiCaWN3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 18:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbiCaWN2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 18:13:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BCF2467D4;
        Thu, 31 Mar 2022 15:11:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c10so2036289ejs.13;
        Thu, 31 Mar 2022 15:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DvaX5NXvnnhCONDjD2TggHPkVfcRk9lluokmAGVTnZM=;
        b=ZMW4W/JXgOmdAE/uk7oLtCBZGANvEkTZm27+6vll59icGjEh1fmGtj9aHhF+N8VwWe
         cFImyl/m3yOuxHZf2mR+o6SqxnFrCk7PmuiTKnwhWSS4mMhMp8MhqK3+dxnFksGHc1f9
         E7ao7/8B5qUyV+7zEKkTwcnPhXmeYwEAsKTo9hEfom5PMgh98phNWgamRIoeGTGvbr8u
         A6iICD5lPCAwiqMRDgxcI0OXWaB5gQA61TQwpxYCn1ox2tZdGYgklyfRXAcsjYxOPqE2
         v4vKCcK8OAuzr11Q6MUj4xDVz9Llhn8evvyKM5jYcZKJAFLK7zmTkhphCPrKnhU1EnCd
         K8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DvaX5NXvnnhCONDjD2TggHPkVfcRk9lluokmAGVTnZM=;
        b=DRIA3f0P4GeCLEEOjcrCSVXX/tDIgTrWRkVGQvUmLGvYYWQBsOoC5eOEUwkdCP96GX
         +ff46RcCUqYfHxogHoYcu/gj4ao/UofGhHfDkSYUgnb+todJiIDs/df+jmKGQraKsbQA
         CawSU2DUPU9rqHqaO4Td6QSmVnEgDa/2tSXm03NwvYdULr/OpN3aQdEjBlt31x5xJude
         TkxktPkaVyknVRDP+/z28J6DzoFoJwu8pFSjpc0v31sX4A2Gqx/YDBkWh7mQ7JuwOalM
         4+fTmJOZzlVqLZ1vAf1iWmmwTOW+CDPVcx4uoJB0R62qRkcCbMFtF3xXlRqFBvw7ilnv
         AXLA==
X-Gm-Message-State: AOAM531ZhvpmAATvbHX1Py7PXJ6jqeB1y1oR4J9DTDlr/I8AUvUXoVBX
        niMwGaWD3N81Z2FzcQ/FAMo=
X-Google-Smtp-Source: ABdhPJxCUKRSlGZtTUbpQVH7NVvnrmeHu9U5lXqC5ZbW3RbN0yM+3Cb5dTyZj+0ARepqIki5fTdfzg==
X-Received: by 2002:a17:907:c16:b0:6da:7d72:1357 with SMTP id ga22-20020a1709070c1600b006da7d721357mr6718359ejc.251.1648764698305;
        Thu, 31 Mar 2022 15:11:38 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z6-20020a056402274600b004194fc1b7casm321322edd.48.2022.03.31.15.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:11:37 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 1/2] efi: remove use of list iterator variable after loop
Date:   Fri,  1 Apr 2022 00:10:29 +0200
Message-Id: <20220331221030.889718-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

In preparation to limiting the scope of a list iterator to the list
traversal loop, use a dedicated pointer to iterate through the list [1].

In the current state the list_for_each_entry() is guaranteed to
hit a break or goto in order to work properly. If the list iterator
executes completely or the list is empty the iterator variable contains
a type confused bogus value infered from the head of the list.

With this patch the variable used past the list iterator is only set
if the list exists early and is NULL otherwise. It should therefore
be safe to just set *prev = NULL (as it was before).

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/firmware/efi/vars.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index cae590bd08f2..3994aad38661 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -1081,14 +1081,16 @@ int __efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
 			struct list_head *head, void *data,
 			struct efivar_entry **prev)
 {
-	struct efivar_entry *entry, *n;
+	struct efivar_entry *entry = NULL, *iter, *n;
 	int err = 0;
 
 	if (!prev || !*prev) {
-		list_for_each_entry_safe(entry, n, head, list) {
-			err = func(entry, data);
-			if (err)
+		list_for_each_entry_safe(iter, n, head, list) {
+			err = func(iter, data);
+			if (err) {
+				entry = iter;
 				break;
+			}
 		}
 
 		if (prev)

base-commit: d888c83fcec75194a8a48ccd283953bdba7b2550
-- 
2.25.1

