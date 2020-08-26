Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E732525E4
	for <lists+linux-efi@lfdr.de>; Wed, 26 Aug 2020 05:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHZDpZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Aug 2020 23:45:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33162 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726802AbgHZDpR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Aug 2020 23:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598413516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=8T5WfWs/Tv1MkqhnVgGnky3bmtEaukh+fceB8s7dUAI=;
        b=bPoRkC3UPeSIIHqx3+9eHw3G+Eqyp8o0m96RskYcGizz9NeOD/ABG9P8GX1XeVObWjRbWl
        GAppN8CkvrBTGbVCeOhY4xO5aiyHHYNAVSsXYV8ikJdK2iAsgUgQ+0Vwp4AZLTus5Ox3Xv
        aNkNK47KGYbJawAuD4NSzl9BqhNXT8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-MeUhVzXSOAKGS-OxOO4fTw-1; Tue, 25 Aug 2020 23:45:12 -0400
X-MC-Unique: MeUhVzXSOAKGS-OxOO4fTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFA0F1DDE0;
        Wed, 26 Aug 2020 03:45:10 +0000 (UTC)
Received: from lszubowi.redhat.com (unknown [10.10.110.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5588B5D9E4;
        Wed, 26 Aug 2020 03:45:08 +0000 (UTC)
From:   Lenny Szubowicz <lszubowi@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, ardb@kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        zohar@linux.ibm.com, bp@alien8.de, pjones@redhat.com,
        dhowells@redhat.com, prarit@redhat.com
Subject: [PATCH 3/3] integrity: Load certs from the EFI MOK config table
Date:   Tue, 25 Aug 2020 23:44:55 -0400
Message-Id: <20200826034455.28707-4-lszubowi@redhat.com>
In-Reply-To: <20200826034455.28707-1-lszubowi@redhat.com>
References: <20200826034455.28707-1-lszubowi@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Because of system-specific EFI firmware limitations,
EFI volatile variables may not be capable of holding the
required contents of the Machine Owner Key (MOK) certificate
store. Therefore, an EFI boot loader may pass the MOK certs
via a EFI configuration table created specifically for this
purpose to avoid this firmware limitation.

An EFI configuration table is a much more primitive mechanism
compared to EFI variables and is well suited for one-way passage
of static information from a pre-OS environment to the kernel.

This patch adds the support to load certs from the MokListRT
entry in the MOK variable configuration table, if it's present.
The pre-existing support to load certs from the MokListRT EFI
variable remains and is used if the EFI MOK configuration table
isn't present or can't be successfully used.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
---
 security/integrity/platform_certs/load_uefi.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 547410d8ffa5..2c9c847d9b62 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -72,6 +72,9 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
  *
  * Load the certs contained in the UEFI MokListRT database into the
  * platform trusted keyring.
+ *
+ * This routine checks the EFI MOK config table first. If and only if
+ * that fails, this routine uses the MokListRT ordinary UEFI variable.
  */
 static int __init load_moklist_certs(void)
 {
@@ -79,8 +82,27 @@ static int __init load_moklist_certs(void)
 	void *mok = NULL;
 	unsigned long moksize = 0;
 	efi_status_t status;
+	struct efi_mokvar_table_entry *mokvar_entry = NULL;
 	int rc = 0;
 
+	/* First try to load certs from the EFI MOKvar config table.
+	 * It's not an error if the MOKvar config table doesn't exist
+	 * or the MokListRT entry is not found in it.
+	 */
+	mokvar_entry = efi_mokvar_entry_find("MokListRT");
+	if (mokvar_entry) {
+		rc = parse_efi_signature_list("UEFI:MokListRT (MOKvar table)",
+					      mokvar_entry->data,
+					      mokvar_entry->data_size,
+					      get_handler_for_db);
+		/* All done if that worked. */
+		if (!rc)
+			return rc;
+
+		pr_err("Couldn't parse MokListRT signatures from EFI MOKvar config table: %d\n",
+		       rc);
+	}
+
 	/* Get MokListRT. It might not exist, so it isn't an error
 	 * if we can't get it.
 	 */
-- 
2.27.0

