Return-Path: <linux-efi+bounces-1934-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E099AED7
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 00:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9ABA1F256B3
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2024 22:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A01D27A0;
	Fri, 11 Oct 2024 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="bDXzvV2X"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF2D1D14E0
	for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2024 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687117; cv=none; b=V2qimEMRrWMenHzZSTPYqHierYO9gc0cEp8Myp82tKLpimfbBs96FxOedzyQZQh69QIDubBOEdrFfIBx4aQ72zwYZwdTwUisJJYeFYbT2Bg//76XyqroVoTIylPdmoBK+uFNDh52ILTVFQmKqBhE9VB423VcEtsjHB90aSCH/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687117; c=relaxed/simple;
	bh=PGqGRVa6i6CZ3/pmHFL6eZ8DIO1wDLUvbIri95jeNdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYATUH+5BJKpXlH10v9i10zBTBBoHvRJTRfEBDYGtQ9/S0Xa4cavRXD0fl9Ulqyq2zY683+TBJ2msKbWs4SiRkRAima0KN10sJbSwneTp57K0OYa4YQ4FepvCgg5WLZlqiGuTlazh0JotjRuM4r2EYwO4NigLQ4KExdNg/5IPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=bDXzvV2X; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b10f298052so127050485a.1
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2024 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728687114; x=1729291914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMUWZ3q7Ti8/RCuTsETxNisdsE3nA1AwrhUgKEomt6E=;
        b=bDXzvV2X1l8m29PUJxETiSHgOqspDSyRsQvj0OaCIJKotRD8U+xY8acprv7CIrdbfJ
         xXvECJ23EWLzQ5ngLruVlyqG4pYTm4JQwpLx8XwlFPxdbajm3MqmF/Qxt6XFQOLLzfsv
         +wvtaIQfNuseFkO63GZL5DDPIxkY3bFzNq6sF5yc1sTMaHRlNXC3RaRTIZR0d7DTfsru
         UTJCrYhUswzIBWUXiEOwI6KSA5K/RIDqfMVTVpkpUuLNn/W8vnVMj7HQIYFSlRhQmb8K
         HlAIQnDJ8pb24NhX4hAin2CTGcWhe/Rxi98dICO7Vn+qGz2UfcWk6EBZ+IT3fpJizkl6
         0s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728687114; x=1729291914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMUWZ3q7Ti8/RCuTsETxNisdsE3nA1AwrhUgKEomt6E=;
        b=Z6JFCwrTN/jIatohoQMK1vwWeOfkkOp3rwGCObKnq118pR6bN9q0+nqswWT2PaYrEg
         kZw471VEQtzbKkruENcLv53MTeN7ITWIoy5Ayism6K0aD68mmr0LPVecnmPFzvRMxpXl
         poFNGlukvaqQjZRQTIFNpfrUW9uYuCa8N9vrM2IIqSMKhUk/ZlyHKZy4ZgMzwJUHvmkt
         fRbSn7P56WntJaUrf6D5nRCMYXzQSFpa8b3ZnbKxZyjwaU32DHn4x4s6CuC49ZpOjJnv
         W1P9YMe4gUL94Vezqg6afeHG286v/cpzCKoMG3qD99qMT89r099P1JW4stAh2pMSRYHP
         9K6g==
X-Gm-Message-State: AOJu0YzdSCmtpPHekx5bMptxvD6wBmekVkf+n+IUo5Rpt88TSKuCEZFv
	RseWbmdiNJqnHxUikeE15kjw3GZz461oMpimUlEa8oT2dxlE1kpr/2a4gV4VhXcEYQnuX4Qeuty
	WYdY=
X-Google-Smtp-Source: AGHT+IHSbs0r4KzmUdFCsDosn4fsYLvCrF1f3B/mUVR/2u6PmRwI4ys1SiD6Ibt8c4zS0l4tREf9Rg==
X-Received: by 2002:a05:620a:4489:b0:7b1:e64:902d with SMTP id af79cd13be357-7b11a34ee97mr635211685a.9.1728687114029;
        Fri, 11 Oct 2024 15:51:54 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1149893basm176499585a.134.2024.10.11.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 15:51:53 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] efi/libstub: fix efi_parse_options() ignoring the default command line
Date: Fri, 11 Oct 2024 18:48:00 -0400
Message-ID: <20241011224812.25763-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

efi_convert_cmdline() always returns a size of at least 1 because it counts
the NUL terminator, so the "cmdline_size == 0" condition is not possible.

Change it to compare against 1 to get the intended behavior: to use
CONFIG_CMDLINE when load_options_size is 0.

Fixes: 60f38de7a8d4 ("efi/libstub: Unify command line param parsing")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/firmware/efi/libstub/efi-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 958a680e0660d..709ae2d41a632 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -129,7 +129,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
 	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
-	    cmdline_size == 0) {
+	    cmdline_size == 1) {
 		status = efi_parse_options(CONFIG_CMDLINE);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
-- 
2.45.1


