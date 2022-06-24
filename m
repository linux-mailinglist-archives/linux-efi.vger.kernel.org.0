Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC62E5595BF
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 10:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiFXIuO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 04:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiFXIuJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 04:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74BC74E62;
        Fri, 24 Jun 2022 01:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E03562039;
        Fri, 24 Jun 2022 08:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF3CC341CA;
        Fri, 24 Jun 2022 08:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656060595;
        bh=BFgf0zqrAMHCzVhB0LR42v1zFL2DGd2X7e3aolkhaXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9UqJuszxn09wCbbQi2ykrdDpU5W//kqkm4nSyXjbs6+KQ4G1LfFsmAWuwAtrJm4/
         ik49ESy9EdffXKFCQFUrPSQ69CeySKyMLz0gmRSnt83kPOAvIUS3QYCyoqKDWwT/a/
         q4CW4XlfP4hwPz3SbWTeShk7L4XikaW1mN+7RqNuwdb5HtgooY+LKWCheXH5KDpXQW
         6Hqpg7IZr5SU/6/MpbDwxQ12y/TLPBdo1/Q0X6nFjexMbTua+ZG8YYxShlPpf/2Yaz
         pCUQYrAkI9DGDlowABuay94E1YNoDAr3HB1YofllL/Xs5XEsT2NY/g19HGzNWbV6Oh
         Ui/4FWEojJt3g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>, Jeremy Kerr <jk@ozlabs.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3 6/9] efi: vars: Drop __efivar_entry_iter() helper which is no longer used
Date:   Fri, 24 Jun 2022 10:49:22 +0200
Message-Id: <20220624084925.724516-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624084925.724516-1-ardb@kernel.org>
References: <20220624084925.724516-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3578; h=from:subject; bh=BFgf0zqrAMHCzVhB0LR42v1zFL2DGd2X7e3aolkhaXg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBitXqPIqcpwelyfxmZMoxYNwsSZIUcY7u1TlZrlFba KjdWVCWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrV6jwAKCRDDTyI5ktmPJIQqDA CczRRSIEUNMxQiaDtv76g4VXUkdzggParBWyTqGp6vDDbM34rpBVXEps+pMvm7w50WrFoMFckb2gHH 6m48RcY0yCfsKffBfUYUbF2Q40aO55WsV6yVzAve4GvN27becmIXwwvK2IVNNL0ItvWRO4j7Qc1yIE 6IumdDjwdTnuStEZk/TNgI95oadkGyFCPsXraHTKfG9K2zVNZxi60acJsAPuq3jqDV3SNfqH1odg87 Caib/o6AKC3x5az+1/r0I5sDBgfTEo16Kpxq9vZvDy0+iyOFb+bQsYcG6HOMfPi9FpUlNVEsHDwcmd d6vTn5p28FNPeiXo4Yfn/Vaz2wplS3zehmvgzHJTr0FXzwxAIhOr7/FojQQpeZK5Vuc+EHmqL7vWbT fPbmm+aON8dc9aZ+8PgVq2cXbvrssi34Y9GjWSqJKP3Kmy5RqcC+prFbgVuxbWXQVCC7WITc1hCu1d B/uI2lC6OswOnM0K53hqIzYQSb6ONxZAZiL253ZydU+IU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

__efivar_entry_iter() uses a list iterator in a dubious way, i.e., it
assumes that the iteration variable always points to an object of the
appropriate type, even if the list traversal exhausts the list
completely, in which case it will point somewhere in the vicinity of the
list's anchor instead.

Fortunately, we no longer use this function so we can just get rid of it
entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/vars.c | 61 +++-----------------
 include/linux/efi.h         |  3 -
 2 files changed, 7 insertions(+), 57 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 29540013b358..932435945c85 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -1034,59 +1034,6 @@ void efivar_entry_iter_end(void)
 }
 EXPORT_SYMBOL_GPL(efivar_entry_iter_end);
 
-/**
- * __efivar_entry_iter - iterate over variable list
- * @func: callback function
- * @head: head of the variable list
- * @data: function-specific data to pass to callback
- * @prev: entry to begin iterating from
- *
- * Iterate over the list of EFI variables and call @func with every
- * entry on the list. It is safe for @func to remove entries in the
- * list via efivar_entry_delete().
- *
- * You MUST call efivar_entry_iter_begin() before this function, and
- * efivar_entry_iter_end() afterwards.
- *
- * It is possible to begin iteration from an arbitrary entry within
- * the list by passing @prev. @prev is updated on return to point to
- * the last entry passed to @func. To begin iterating from the
- * beginning of the list @prev must be %NULL.
- *
- * The restrictions for @func are the same as documented for
- * efivar_entry_iter().
- */
-int __efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
-			struct list_head *head, void *data,
-			struct efivar_entry **prev)
-{
-	struct efivar_entry *entry, *n;
-	int err = 0;
-
-	if (!prev || !*prev) {
-		list_for_each_entry_safe(entry, n, head, list) {
-			err = func(entry, data);
-			if (err)
-				break;
-		}
-
-		if (prev)
-			*prev = entry;
-
-		return err;
-	}
-
-
-	list_for_each_entry_safe_continue((*prev), n, head, list) {
-		err = func(*prev, data);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(__efivar_entry_iter);
-
 /**
  * efivar_entry_iter - iterate over variable list
  * @func: callback function
@@ -1104,12 +1051,18 @@ EXPORT_SYMBOL_GPL(__efivar_entry_iter);
 int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
 		      struct list_head *head, void *data)
 {
+	struct efivar_entry *entry, *n;
 	int err = 0;
 
 	err = efivar_entry_iter_begin();
 	if (err)
 		return err;
-	err = __efivar_entry_iter(func, head, data, NULL);
+
+	list_for_each_entry_safe(entry, n, head, list) {
+		err = func(entry, data);
+		if (err)
+			break;
+	}
 	efivar_entry_iter_end();
 
 	return err;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 54ca2d6b6c78..93ce85a14a46 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1083,9 +1083,6 @@ int efivar_entry_set_safe(efi_char16_t *name, efi_guid_t vendor, u32 attributes,
 int efivar_entry_iter_begin(void);
 void efivar_entry_iter_end(void);
 
-int __efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
-			struct list_head *head, void *data,
-			struct efivar_entry **prev);
 int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
 		      struct list_head *head, void *data);
 
-- 
2.35.1

