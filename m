Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E03D2A30DD
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 18:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgKBRG4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 12:06:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbgKBRGy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Nov 2020 12:06:54 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB7A422277;
        Mon,  2 Nov 2020 17:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604336813;
        bh=ejTlItCMWx4LMzuY2iTAsh9aBseFM7SLvGINqe/xaSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFWd43h9XulSjQKfZtUwI4VYQ0A5pR4zQ8iR5Y3etO0BOq8HZQFIlw8oUfg8n7RY6
         aAlcwvq8R1Mv8qWbKXMl4bL1eAhv7mYJ2l/+HUgMxhau07cs5mUzwad2l5GNMBaai3
         QmSh9r6Cfdmxv21Vn52FFKktr5rLgaFEHq58gjwo=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 2/7] efi/libstub: fix prototype of efi_tcg2_protocol::get_event_log()
Date:   Mon,  2 Nov 2020 18:06:29 +0100
Message-Id: <20201102170634.20575-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102170634.20575-1-ardb@kernel.org>
References: <20201102170634.20575-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efi_tcg2_protocol::get_event_log() takes a protocol pointer as the
first argument, not a EFI handle.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2d7abcd99de9..2bc389ec7fcd 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -672,7 +672,7 @@ typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
 union efi_tcg2_protocol {
 	struct {
 		void *get_capability;
-		efi_status_t (__efiapi *get_event_log)(efi_handle_t,
+		efi_status_t (__efiapi *get_event_log)(efi_tcg2_protocol_t *,
 						       efi_tcg2_event_log_format,
 						       efi_physical_addr_t *,
 						       efi_physical_addr_t *,
-- 
2.17.1

