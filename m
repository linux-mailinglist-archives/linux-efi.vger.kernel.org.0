Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064CE5595B6
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiFXItp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 04:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFXIto (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 04:49:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FC25D105;
        Fri, 24 Jun 2022 01:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAE91B8274C;
        Fri, 24 Jun 2022 08:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B79C341CB;
        Fri, 24 Jun 2022 08:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656060581;
        bh=quDxoLCSV3k0NYsjwvT2zdum/ntBKP4WJKq7KS9sLKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlO1VyKlxktRWZExTVsjivXwkX1lLjCoeJSuKfp/joI8GTur7ruI0eifzk9xBG2RP
         hteY4bq0pUOK1VMhIoeEsm1KlBYX9YZfx1CZYvRvAQh7hcVkh8Q7LaE9vN8l143m7F
         eGjPGqc+67OFqdCQ78rXyGxmObGzTCd41koGkuws014eglbA0K7cqfDywL5aud+8wX
         zo7wLyR/mJA/lvxnccLcV6mtUweM6358si3pi7fdSPXvBj66NDGCgdiVZGb5gEwl2m
         GItvM7vwnspCcEQ+wfuMD4TRIK/+hnfCLn5N/TOr6EqHrY8hBK1loDVAI8cMb/+6YL
         oUnkqg6dUhkmg==
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
Subject: [PATCH v3 1/9] pstore: Add priv field to pstore_record for backend specific use
Date:   Fri, 24 Jun 2022 10:49:17 +0200
Message-Id: <20220624084925.724516-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624084925.724516-1-ardb@kernel.org>
References: <20220624084925.724516-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; h=from:subject; bh=quDxoLCSV3k0NYsjwvT2zdum/ntBKP4WJKq7KS9sLKQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBitXqGJ13sMqMYNtfXgKUZ3t5hymJ3nwoeoBBq8n8M pC8NVY2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrV6hgAKCRDDTyI5ktmPJMZ4DA CuTOVM4o38c3b2aY1NN8AusBeEtLrUmrfVYnUDaNj7nnTiBgjvfRvu1O6eZ0Uf7d98OknG/niI9qLO eH/0nqlPl0uwnOmGQkrFy2G7Abr1ukYrvZ8vxqKrseLk0daVx1YAVKVdkD6cgf+5UTrWUu3Qqml5A5 VXbRvpZ9wUzYRvr4y2sqRKjJF0BA813iJx+GENzb9+4jcv5Ai1ewW83FIUdAVf8WOQm3QeSp2NIVoo QOt/rNPP3nunmRZZ8W5PH1K9trtzpv0hkrcAMzYKz9hUisGMXDG4nfdbTfLAl4AztT4aruvwsOsnxV aeCjzKos4GgKwhBGjNEEGTCSCi0Lp5lCihycwVKmjc8syQZZO0gRGpgMVFgD/FC1OZD3KJSjcCIMi1 KGWQZrL6pXilvbXbkvFWvTpnG2r0gKa4+hLUdxQ+WISlJbJm1MwrOn6gdapQntTMdmOb8gMjBBgK8D hBuzH504+Ts4qitTcJ5nmtOQYmuOnwyK1fi1uMqPEEsmo=
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

The EFI pstore backend will need to store per-record variable name data
when we switch away from the efivars layer. Add a priv field to struct
pstore_record, and document it as holding a backend specific pointer
that is assumed to be a kmalloc()d buffer, and will be kfree()d when the
entire record is freed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/pstore/inode.c      | 1 +
 fs/pstore/platform.c   | 1 +
 include/linux/pstore.h | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 14658b009f1b..ffbadb8b3032 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -55,6 +55,7 @@ static void free_pstore_private(struct pstore_private *private)
 		return;
 	if (private->record) {
 		kfree(private->record->buf);
+		kfree(private->record->priv);
 		kfree(private->record);
 	}
 	kfree(private);
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index e26162f102ff..0c034ea39954 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -769,6 +769,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
 		if (rc) {
 			/* pstore_mkfile() did not take record, so free it. */
 			kfree(record->buf);
+			kfree(record->priv);
 			kfree(record);
 			if (rc != -EEXIST || !quiet)
 				failed++;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index e97a8188f0fd..638507a3c8ff 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -57,6 +57,9 @@ struct pstore_info;
  * @size:	size of @buf
  * @ecc_notice_size:
  *		ECC information for @buf
+ * @priv:	pointer for backend specific use, will be
+ *		kfree()d by the pstore core if non-NULL
+ *		when the record is freed.
  *
  * Valid for PSTORE_TYPE_DMESG @type:
  *
@@ -74,6 +77,7 @@ struct pstore_record {
 	char			*buf;
 	ssize_t			size;
 	ssize_t			ecc_notice_size;
+	void			*priv;
 
 	int			count;
 	enum kmsg_dump_reason	reason;
-- 
2.35.1

