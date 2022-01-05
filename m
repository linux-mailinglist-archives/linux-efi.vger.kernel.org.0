Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B4B48588D
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 19:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbiAESh2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 13:37:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60676 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbiAESh1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 13:37:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EA79B81D38;
        Wed,  5 Jan 2022 18:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CB0C36AE9;
        Wed,  5 Jan 2022 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641407845;
        bh=yn8IcHE7h9fqD/cjERArRVpjBpyJFcdTE2ffAfx17dA=;
        h=From:To:Cc:Subject:Date:From;
        b=Th+j2JFrcOlvWm4iIRi+v+gnshmUD7R7VhZ4aYuTxyXU23rvQUJmmVMW4j7dKCLKQ
         9TObFB23wnhbK+FCSaiQAeJvMEUWZ56Vp3KBGVJPtCqzN8m+4VcInmkcIF71MzsusB
         sQAE2rf7dBGl2d1yM0DFyaqRCdbF8SabazOIygys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH] efi: use default_groups in kobj_type
Date:   Wed,  5 Jan 2022 19:37:16 +0100
Message-Id: <20220105183716.2841210-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2651; h=from:subject; bh=yn8IcHE7h9fqD/cjERArRVpjBpyJFcdTE2ffAfx17dA=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXn8ZoG7Upn/qncsTuvXb94TeGu9Q7eh8vv2ud1VKmP3V/ ssPSjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjItD8McwV5FtWKfs3Sbal65vlay/ n0jwm7KhgWLFz2X3j5Rw8Fvevhe35fcLF2vnOAHwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the firmware efi sysfs code to use default_groups
field which has been the preferred way since aa30f47cf666 ("kobject: Add
support for default attribute groups to kobj_type") so that we can soon
get rid of the obsolete default_attrs field.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/efivars.c     | 3 ++-
 drivers/firmware/efi/esrt.c        | 4 +++-
 drivers/firmware/efi/runtime-map.c | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index e6b16b3a17a8..ea0bc39dc965 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -352,11 +352,12 @@ static struct attribute *def_attrs[] = {
 	&efivar_attr_raw_var.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(def);
 
 static struct kobj_type efivar_ktype = {
 	.release = efivar_release,
 	.sysfs_ops = &efivar_attr_ops,
-	.default_attrs = def_attrs,
+	.default_groups = def_groups,
 };
 
 static ssize_t efivar_create(struct file *filp, struct kobject *kobj,
diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index d5915272141f..2a2f52b017e7 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -146,6 +146,8 @@ static struct attribute *esre1_attrs[] = {
 	&esre_last_attempt_status.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(esre1);
+
 static void esre_release(struct kobject *kobj)
 {
 	struct esre_entry *entry = to_entry(kobj);
@@ -157,7 +159,7 @@ static void esre_release(struct kobject *kobj)
 static struct kobj_type esre1_ktype = {
 	.release = esre_release,
 	.sysfs_ops = &esre_attr_ops,
-	.default_attrs = esre1_attrs,
+	.default_groups = esre1_groups,
 };
 
 
diff --git a/drivers/firmware/efi/runtime-map.c b/drivers/firmware/efi/runtime-map.c
index ad9ddefc9dcb..92a3d45a795c 100644
--- a/drivers/firmware/efi/runtime-map.c
+++ b/drivers/firmware/efi/runtime-map.c
@@ -79,6 +79,7 @@ static struct attribute *def_attrs[] = {
 	&map_attribute_attr.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(def);
 
 static const struct sysfs_ops map_attr_ops = {
 	.show = map_attr_show,
@@ -94,7 +95,7 @@ static void map_release(struct kobject *kobj)
 
 static struct kobj_type __refdata map_ktype = {
 	.sysfs_ops	= &map_attr_ops,
-	.default_attrs	= def_attrs,
+	.default_groups	= def_groups,
 	.release	= map_release,
 };
 
-- 
2.34.1

