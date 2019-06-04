Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE31352F0
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2019 01:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFDXEn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jun 2019 19:04:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36668 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDXEn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Jun 2019 19:04:43 -0400
Received: from 95.172.237.253.ip.static.uno.uk.net ([95.172.237.253] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <chris.coulson@canonical.com>)
        id 1hYITw-0006ef-GL; Tue, 04 Jun 2019 23:04:40 +0000
From:   Chris Coulson <chris.coulson@canonical.com>
To:     linux-integrity@vger.kernel.org
Cc:     Chris Coulson <chris.coulson@canonical.com>,
        linux-efi@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Garrett <mjg59@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Fix crash in __calc_tpm2_event_size
Date:   Wed,  5 Jun 2019 00:04:32 +0100
Message-Id: <20190604230433.20936-1-chris.coulson@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I've been testing the latest code in the linux-tpmdd branch and I'm
experiencing a crash in __calc_tpm2_event_size when it's called to
calculate the size of events in the final log. I hope I'm not stepping on
anyone's toes, but this small change seems to fix it.

What seems to happen is that the event header is mapped here:

    /* Map the event header */
    if (do_mapping) {
        mapping_size = marker - marker_start;
        mapping = TPM_MEMREMAP((unsigned long)marker_start,
                       mapping_size);

    ...

    event = (struct tcg_pcr_event2_head *)mapping;

When calculating the cumulative size of the digests, the event header is
dereferenced here on each loop iteration in order to obtain the digest
count:

    for (i = 0; i < event->count; i++) {
        halg_size = sizeof(event->digests[i].alg_id);

But the first iteration of the loop unmaps the event header:

        /* Map the digest's algorithm identifier */
        if (do_mapping) {
            TPM_MEMUNMAP(mapping, mapping_size);
            mapping_size = halg_size;
            mapping = TPM_MEMREMAP((unsigned long)marker,
                         mapping_size);

Subsequent loop iterations then dereference a pointer to unmapped memory.

Chris Coulson (1):
  tpm: Don't dereference event after it's unmapped in
    __calc_tpm2_event_size

 include/linux/tpm_eventlog.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1

