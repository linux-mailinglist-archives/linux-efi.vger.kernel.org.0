Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9A5F2F9B
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJCL0x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 07:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJCL0w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 07:26:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CE628E13
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 04:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4371FB80DCA
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 11:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83587C433D6;
        Mon,  3 Oct 2022 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664796409;
        bh=9C7AAPmVD5BjjmNEGbxNnPMoOUW0Ie0fKwQ10Ayhy8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ef/m3g0HgmSAdlLxc6fqIZiY6+uN5iitg2tKlqJBx2kqyn1LxQerWZsFjBQKGZPPo
         5UCqsf8JYBVwYIfm0t42Hd+d2AkVCw26i1ECycyFRk8twGtzgdzIzgWc12l/6u6YF6
         LH5J/jNu7aqKOutEydBgmoMzH+yaikiyc6cA7saaEgHV1A3iyLAml1itploasROBbw
         zlMGZ5MRNQ3RhSk4/QnAogqaAsUikGi6wXIXrS7VXzzc39CQEabYr11vCF3zMIXCFC
         vMYmvKSVN6NxPaW7VX5h4lWeDPKFV5OOaSAzWX7+9Psix9WpMLL3i9IWNGwX55IQYM
         bFfyndgoAL10w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: [PATCH v2 6/6] efi: Apply allowlist to EFI configuration tables when running under Xen
Date:   Mon,  3 Oct 2022 13:26:25 +0200
Message-Id: <20221003112625.972646-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221003112625.972646-1-ardb@kernel.org>
References: <20221003112625.972646-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3156; i=ardb@kernel.org; h=from:subject; bh=9C7AAPmVD5BjjmNEGbxNnPMoOUW0Ie0fKwQ10Ayhy8c=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjOsbenzLnpjmFV4NFmLKMBzkM6EYzVcY2tgtXvDcv bUFOheqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzrG3gAKCRDDTyI5ktmPJJBDC/ 43/+s+cosevfZ50pJwVpCc4I/DH7QKq7kvyhnFWKLHDPwOMJ93i8yiedrIbu95b4QIMIPJEc8tBq9y cW38DNbTE6rxfpTMb73VT4UiZ6bDN/qv+/x6zmOCHVaThg0MLBnjYO1SUCvck73IxWowiReFOO1WGA U7s9cJds+g1X15WxZf9dnt6+muhFLE2Dk5JXvjzjLPBfrXW14dHcCseM7PfBgtwrR8aSkv67OV1yTo mfZNAn3PtjxCdEsecnBhnrAytAQu4yW30XYa8DqqR6mLgjRSs7yzsdhtNCrO04A4C+eqjTpZAePYdy XXMRhHa/tIhzLLb+53o6W3/IUwm8sXP4fLwN892QVrkRXlRmwSmYcMiFf2neJxawz+DjREv9MSIa47 QJPwQvr6LGddffvkVCGaKavWwhMxpj3Q46J6qhGfbsF7f2vkS3Kso6HtD4OuXi3KVF1pcclOHbOvfT qiDRgl+P1O5UEKV58pQHT1jpiJ1EjxP/f4HUFXDu0VYmQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

As it turns out, Xen does not guarantee that EFI bootservices data
regions in memory are preserved, which means that EFI configuration
tables pointing into such memory regions may be corrupted before the
dom0 OS has had a chance to inspect them.

Demi Marie reports that this is causing problems for Qubes OS when it
attempts to perform system firmware updates, which requires that the
contents of the ESRT configuration table are valid when the fwupd user
space program runs.

However, other configuration tables such as the memory attributes
table or the runtime properties table are equally affected, and so we
need a comprehensive workaround that works for any table type.

So when running under Xen, check the EFI memory descriptor covering the
start of the table, and disregard the table if it does not reside in
memory that is preserved by Xen.

Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c |  7 ++++++
 drivers/xen/efi.c          | 24 ++++++++++++++++++++
 include/linux/efi.h        |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 2c12b1a06481..0a4583c13a40 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -560,6 +560,13 @@ static __init int match_config_table(const efi_guid_t *guid,
 
 	for (i = 0; efi_guidcmp(table_types[i].guid, NULL_GUID); i++) {
 		if (!efi_guidcmp(*guid, table_types[i].guid)) {
+			if (IS_ENABLED(CONFIG_XEN_EFI) &&
+			    !xen_efi_config_table_is_usable(guid, table)) {
+				if (table_types[i].name[0])
+					pr_cont("(%s=0x%lx) ",
+						table_types[i].name, table);
+				return 1;
+			}
 			*(table_types[i].ptr) = table;
 			if (table_types[i].name[0])
 				pr_cont("%s=0x%lx ",
diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
index 74f3f6d8cdc8..c275a9c377fe 100644
--- a/drivers/xen/efi.c
+++ b/drivers/xen/efi.c
@@ -326,3 +326,27 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 
         return 0;
 }
+
+bool __init xen_efi_config_table_is_usable(const efi_guid_t *guid,
+					   unsigned long table)
+{
+	efi_memory_desc_t md;
+	int rc;
+
+	if (!efi_enabled(EFI_PARAVIRT))
+		return true;
+
+	rc = efi_mem_desc_lookup(table, &md);
+	if (rc)
+		return false;
+
+	switch (md.type) {
+	case EFI_RUNTIME_SERVICES_CODE:
+	case EFI_RUNTIME_SERVICES_DATA:
+	case EFI_ACPI_RECLAIM_MEMORY:
+	case EFI_RESERVED_TYPE:
+		return true;
+	}
+
+	return false;
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e0ee6f6da4b4..b0cba86352ce 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1352,4 +1352,6 @@ struct linux_efi_initrd {
 /* Header of a populated EFI secret area */
 #define EFI_SECRET_TABLE_HEADER_GUID	EFI_GUID(0x1e74f542, 0x71dd, 0x4d66,  0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
 
+bool xen_efi_config_table_is_usable(const efi_guid_t *, unsigned long table);
+
 #endif /* _LINUX_EFI_H */
-- 
2.35.1

