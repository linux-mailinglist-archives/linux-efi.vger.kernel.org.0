Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA6E1FA418
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 01:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgFOX2J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 19:28:09 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45588 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOX2J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Jun 2020 19:28:09 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 657B920B4780;
        Mon, 15 Jun 2020 16:28:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 657B920B4780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592263688;
        bh=24da9vv8AG04i92vfIYdv7Ik8ZBjVgmLxlUf5hhLH44=;
        h=From:To:Cc:Subject:Date:From;
        b=HjclWTngt51xsAal4zzyK0uAtUedBu2Y7q/XWrKVuhbLSJpCqw2ExCH4kxcbRu1vB
         yhsc7vwUXpblnhoxrZPvfUb5+brRVxSvwxZLh5+XAOgbcnwms1xrZL4a9VQJaCQIcB
         uDPfW+rzO5f5KFUPMJ93ceQ3foH3VSXtI/YOjNSM=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Petr Vandrovec <petr@vmware.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        linux-integrity@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Require that all digests are present in TCG_PCR_EVENT2 structures
Date:   Mon, 15 Jun 2020 18:25:04 -0500
Message-Id: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Require that the TCG_PCR_EVENT2.digests.count value strictly matches the
value of TCG_EfiSpecIdEvent.numberOfAlgorithms in the event field of the
TCG_PCClientPCREvent event log header. Also require that
TCG_EfiSpecIdEvent.numberOfAlgorithms is non-zero.

The TCG PC Client Platform Firmware Profile Specification section 9.1
(Family "2.0", Level 00 Revision 1.04) states:

 For each Hash algorithm enumerated in the TCG_PCClientPCREvent entry,
 there SHALL be a corresponding digest in all TCG_PCR_EVENT2 structures.
 Note: This includes EV_NO_ACTION events which do not extend the PCR.

Section 9.4.5.1 provides this description of
TCG_EfiSpecIdEvent.numberOfAlgorithms:

 The number of Hash algorithms in the digestSizes field. This field MUST
 be set to a value of 0x01 or greater.

Enforce these restrictions, as required by the above specification, in
order to better identify and ignore invalid sequences of bytes at the
end of an otherwise valid TPM2 event log. Firmware doesn't always have
the means necessary to inform the kernel of the actual event log size so
the kernel's event log parsing code should be stringent when parsing the
event log for resiliency against firmware bugs. This is true, for
example, when firmware passes the event log to the kernel via a reserved
memory region described in device tree.

Prior to this patch, a single bit set in the offset corresponding to
either the TCG_PCR_EVENT2.eventType or TCG_PCR_EVENT2.eventSize fields,
after the last valid event log entry, could confuse the parser into
thinking that an additional entry is present in the event log. This
patch raises the bar on how difficult it is for stale memory to confuse
the kernel's event log parser but there's still a reliance on firmware
to properly initialize the remainder of the memory region reserved for
the event log as the parser cannot be expected to detect a stale but
otherwise properly formatted firmware event log entry.

Fixes: fd5c78694f3f ("tpm: fix handling of the TPM 2.0 event logs")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 include/linux/tpm_eventlog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 4f8c90c93c29..d83eb9fd5614 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -201,7 +201,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
 	/* Check if event is malformed. */
-	if (count > efispecid->num_algs) {
+	if (!efispecid->num_algs || count != efispecid->num_algs) {
 		size = 0;
 		goto out;
 	}
-- 
2.25.1

