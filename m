Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE97D6857
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2019 19:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbfJNRVr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Oct 2019 13:21:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfJNRVr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Oct 2019 13:21:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1005B18C4279;
        Mon, 14 Oct 2019 17:21:47 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-190.phx2.redhat.com [10.3.116.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA5F65D6A9;
        Mon, 14 Oct 2019 17:21:46 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] efi/tpm: return -EINVAL when determining tpm final events log size fails
Date:   Mon, 14 Oct 2019 10:21:45 -0700
Message-Id: <20191014172145.9669-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Mon, 14 Oct 2019 17:21:47 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently nothing checks the return value of efi_tpm_eventlog_init,
but in case that changes in the future make sure an error is
returned when it fails to determine the tpm final events log
size.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-efi@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after successful event log parsing")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/firmware/efi/tpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index ebd7977653a8..31f9f0e369b9 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -88,6 +88,7 @@ int __init efi_tpm_eventlog_init(void)
 
 	if (tbl_size < 0) {
 		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
+		ret = -EINVAL;
 		goto out_calc;
 	}
 
-- 
2.23.0

