Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A8F2A30E3
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 18:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKBRHG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 12:07:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbgKBRHG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Nov 2020 12:07:06 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D4D20786;
        Mon,  2 Nov 2020 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604336826;
        bh=Tnt4XyZOR83rloFTE9j3o926aXONz+ceZy2Utv5nUSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6hfnfXRlAAVGkr1XVaI3eecb5HY/hqY7qEjUiNf8cbEDNgdvuT0swJ1qff4ocm8u
         H7+nR4zgOsbgrwb9Dwp7gwSiOUfB1Uia1azIcaoScEz9wJkH4wR4wsunz37n7poniC
         aTj5bNmSjTGDomRWG2lQNdeCS5PvthL2pdvtz7iY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 7/7] efi/libstub: measure loaded initrd info into the TPM
Date:   Mon,  2 Nov 2020 18:06:34 +0100
Message-Id: <20201102170634.20575-8-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102170634.20575-1-ardb@kernel.org>
References: <20201102170634.20575-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Modify the initrd loading sequence so that the contents of the initrd
loaded by the EFI stub are measured into the TPM. Note that this also
includes the measurement of a zero sized input if the stub's initrd
loader fails for any reason, or simply succeeds with no result, which
it does for legacy reasons when using the initrd= command line option.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 53 +++++++++++++++-----
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 72a7e7c4d403..d8cf1911171a 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -625,6 +625,22 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
 				    load_addr, load_size);
 }
 
+static const struct {
+	efi_tcg2_event_t	event_data;
+	u8			description[];
+} initrd_tcg2_event = {
+	{
+		sizeof(initrd_tcg2_event),
+		{
+			sizeof(initrd_tcg2_event.event_data.event_header),
+			EFI_TCG2_EVENT_HEADER_VERSION,
+			0,
+			0
+		},
+	},
+	"Linux initrd"
+};
+
 /**
  * efi_load_initrd() - Load initial RAM disk
  * @image:	EFI loaded image protocol
@@ -641,25 +657,36 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long soft_limit,
 			     unsigned long hard_limit)
 {
+	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
+	efi_tcg2_protocol_t *tcg2 = NULL;
 	efi_status_t status;
 
 	if (efi_noinitrd) {
 		*load_addr = *load_size = 0;
-		return EFI_SUCCESS;
+		status = EFI_SUCCESS;
+	} else {
+		status = efi_load_initrd_dev_path(load_addr, load_size, hard_limit);
+		if (status == EFI_SUCCESS) {
+			efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
+		} else if (status == EFI_NOT_FOUND) {
+			status = efi_load_initrd_cmdline(image, load_addr, load_size,
+							 soft_limit, hard_limit);
+			if (status == EFI_SUCCESS && *load_size > 0)
+				efi_info("Loaded initrd from command line option\n");
+		}
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to load initrd: 0x%lx\n", status);
+			*load_addr = *load_size = 0;
+		}
 	}
 
-	status = efi_load_initrd_dev_path(load_addr, load_size, hard_limit);
-	if (status == EFI_SUCCESS) {
-		efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
-	} else if (status == EFI_NOT_FOUND) {
-		status = efi_load_initrd_cmdline(image, load_addr, load_size,
-						 soft_limit, hard_limit);
-		if (status == EFI_SUCCESS && *load_size > 0)
-			efi_info("Loaded initrd from command line option\n");
-	}
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to load initrd: 0x%lx\n", status);
-		*load_addr = *load_size = 0;
+	efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
+	if (tcg2) {
+		efi_status_t s = efi_call_proto(tcg2, hash_log_extend_event,
+						0, *load_addr, *load_size,
+						&initrd_tcg2_event.event_data);
+		if (s != EFI_SUCCESS)
+			efi_warn("Failed to measure initrd data into PCR #xx: 0x%lx\n", s);
 	}
 	return status;
 }
-- 
2.17.1

