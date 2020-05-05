Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A591C608F
	for <lists+linux-efi@lfdr.de>; Tue,  5 May 2020 21:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgEETAZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 May 2020 15:00:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37241 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727083AbgEETAZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 May 2020 15:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588705224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=R7YqtoNVOAoFKS6RM3wllcWxnGsaIeVUvLmMoQN3l6s=;
        b=VN2sk+fuJdiPCK3DG8DTXvA0TQhVDkdF3M5DCCfu+vSBzP+LLEeqiN2gzaEQ0w72pT6/3S
        I9SCVM+sxkVkr8yQxe9R1ovDpwh51RUw9RBVVGCMlUxTdaqkSMmmB38ld3LmoN1ClukNpe
        c1KPdu5fRLkPxs7Q7LbUhTEDHQHLo/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-QjKGPL5FP2uTIWb7k7g_vw-1; Tue, 05 May 2020 15:00:20 -0400
X-MC-Unique: QjKGPL5FP2uTIWb7k7g_vw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1AE91899527;
        Tue,  5 May 2020 19:00:18 +0000 (UTC)
Received: from lszubowi.redhat.com (unknown [10.10.110.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A51F19C4F;
        Tue,  5 May 2020 19:00:17 +0000 (UTC)
From:   Lenny Szubowicz <lszubowi@redhat.com>
To:     ardb@kernel.org, eric.snowberg@oracle.com, mingo@kernel.org,
        nivedita@alum.mit.edu, tglx@linutronix.de,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi/libstub/x86: Free EFI map buffer in allocate_e820()
Date:   Tue,  5 May 2020 15:00:16 -0400
Message-Id: <20200505190016.4350-1-lszubowi@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In allocate_e820(), free the EFI map buffer that has been returned
by efi_get_memory_map(). The returned size of the EFI map buffer
is used to allocate an adequately sized e820ext buffer, if it's
needed. But the contents of that EFI map buffer is not used at all
and the local pointer to it is gone on return from allocate_e820().

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 05ccb229fb45..4efe3e7a218d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -623,6 +623,9 @@ static efi_status_t allocate_e820(struct boot_params *params,
 	if (status != EFI_SUCCESS)
 		return status;
 
+	/* Allocated EFI map buf is not used here. Just need its size. */
+	efi_bs_call(free_pool, map);
+
 	nr_desc = buff_size / desc_size;
 
 	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
-- 
2.18.4

