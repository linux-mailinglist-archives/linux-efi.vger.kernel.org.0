Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141181F8F30
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 09:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgFOHQj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 03:16:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:53718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgFOHQj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Jun 2020 03:16:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4FC28AEB2;
        Mon, 15 Jun 2020 07:16:41 +0000 (UTC)
From:   Fabian Vogt <fvogt@suse.de>
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>,
        =?ISO-8859-1?Q?Lo=EFc?= Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v2] tpm: verify that it's actually an event log header before  parsing
Date:   Mon, 15 Jun 2020 09:16:36 +0200
Message-ID: <1927248.evlx2EsYKh@linux-e202.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

It's possible that the first event in the log is not actually a log
header at all, but rather a normal event. This leads to the cast in
__calc_tpm2_event_size being an invalid conversion, which means that
the values read are effectively garbage. Depending on the first event's
contents, this leads either to apparently normal behaviour, a crash or
a freeze.

While this behaviour of the firmware is not in accordance with the
TCG Client EFI Specification, this happens on a Dell Precision 5510
with the TPM enabled but hidden from the OS ("TPM On" disabled, state
otherwise untouched). The EFI claims that the TPM is present and active
and supports the TCG 2.0 event log format.

Fortunately, this can be worked around by simply checking the header
of the first event and the event log header signature itself.

Commit b4f1874c6216 ("tpm: check event log version before reading final
events") addressed a similar issue also found on Dell models.

Fixes: 6b0326190205 ("efi: Attempt to get the TCG2 event log in the boot stub")
Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1165773
Signed-off-by: Fabian Vogt <fvogt@suse.de>
---
v2: Drop unneeded READ_ONCE around event_header derefs.

 include/linux/tpm_eventlog.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 4f8c90c93c29..64356b199e94 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -81,6 +81,8 @@ struct tcg_efi_specid_event_algs {
 	u16 digest_size;
 } __packed;
 
+#define TCG_SPECID_SIG "Spec ID Event03"
+
 struct tcg_efi_specid_event_head {
 	u8 signature[16];
 	u32 platform_class;
@@ -171,6 +173,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	int i;
 	int j;
 	u32 count, event_type;
+	const u8 zero_digest[sizeof(event_header->digest)] = {0};
 
 	marker = event;
 	marker_start = marker;
@@ -198,10 +201,19 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	count = READ_ONCE(event->count);
 	event_type = READ_ONCE(event->event_type);
 
+	/* Verify that it's the log header */
+	if (event_header->pcr_idx != 0 ||
+	    event_header->event_type != NO_ACTION ||
+	    memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
+		size = 0;
+		goto out;
+	}
+
 	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
 	/* Check if event is malformed. */
-	if (count > efispecid->num_algs) {
+	if (memcmp(efispecid->signature, TCG_SPECID_SIG,
+		   sizeof(TCG_SPECID_SIG)) || count > efispecid->num_algs) {
 		size = 0;
 		goto out;
 	}
-- 
2.25.1




