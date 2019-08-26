Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D08149D2C9
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2019 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfHZPai (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Aug 2019 11:30:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbfHZPai (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Aug 2019 11:30:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF6573082131;
        Mon, 26 Aug 2019 15:30:37 +0000 (UTC)
Received: from trillian.uncooperative.org.com (dhcp-10-20-1-91.bss.redhat.com [10.20.1.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C6AE1001E85;
        Mon, 26 Aug 2019 15:30:37 +0000 (UTC)
From:   Peter Jones <pjones@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg59@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>
Subject: [PATCH 1/2] efi+tpm: Don't access event->count when it isn't mapped.
Date:   Mon, 26 Aug 2019 11:30:27 -0400
Message-Id: <20190826153028.32639-1-pjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 26 Aug 2019 15:30:38 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some machines generate a lot of event log entries.  When we're
iterating over them, the code removes the old mapping and adds a
new one, so once we cross the page boundary we're unmapping the page
with the count on it.  Hilarity ensues.

This patch keeps the info from the header in local variables so we don't
need to access that page again or keep track of if it's mapped.

Signed-off-by: Peter Jones <pjones@redhat.com>
Tested-by: Lyude Paul <lyude@redhat.com>
---
 include/linux/tpm_eventlog.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 63238c84dc0..549dab0b56b 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -170,6 +170,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	u16 halg;
 	int i;
 	int j;
+	u32 count, event_type;
 
 	marker = event;
 	marker_start = marker;
@@ -190,16 +191,22 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	}
 
 	event = (struct tcg_pcr_event2_head *)mapping;
+	/*
+	 * the loop below will unmap these fields if the log is larger than
+	 * one page, so save them here for reference.
+	 */
+	count = event->count;
+	event_type = event->event_type;
 
 	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
 	/* Check if event is malformed. */
-	if (event->count > efispecid->num_algs) {
+	if (count > efispecid->num_algs) {
 		size = 0;
 		goto out;
 	}
 
-	for (i = 0; i < event->count; i++) {
+	for (i = 0; i < count; i++) {
 		halg_size = sizeof(event->digests[i].alg_id);
 
 		/* Map the digest's algorithm identifier */
@@ -256,8 +263,9 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 		+ event_field->event_size;
 	size = marker - marker_start;
 
-	if ((event->event_type == 0) && (event_field->event_size == 0))
+	if (event_type == 0 && event_field->event_size == 0)
 		size = 0;
+
 out:
 	if (do_mapping)
 		TPM_MEMUNMAP(mapping, mapping_size);
-- 
2.23.0.rc2

