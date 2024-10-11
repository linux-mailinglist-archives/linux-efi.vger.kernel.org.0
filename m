Return-Path: <linux-efi+bounces-1936-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E5F99AEDC
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 00:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24101C2074F
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2024 22:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03741E6321;
	Fri, 11 Oct 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="YVba/RoN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D61E5022
	for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2024 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687124; cv=none; b=o4bF3rUPnHjFpaTX+VukdYMIsNX8oSuuuqeAjLUjRLgIEWMyGm7MKJ/4bRZk0vqrUDVlvY2PoPyu2Pt/1m+CPM2z+6uTSo+GOMItwOugLFFUHkTEohUDdDik4NZtdxWgWFrwAHwSA+AOBT41i9Zx9U4dg3jcjPn4IoJcJ4siAyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687124; c=relaxed/simple;
	bh=L29aB0pF4VVsMx4ptKUs75EonWW99gNI2hdo898WanY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXn4OQyE0CjJYaTLo18jdA6pTfzQeLNEIG59ag9/dXW4/VCbltTr5tqWzxW49O2JbFKld9QPYOuYCNIAgdCMd7+F4pLNqiTtmV/LWyzi4zdF+WEYJ0ivgaijT5xV5yqTsXRu3lEfhUNrpaIQMYz3nPHFL5emgp5L6u3cvz4sk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=YVba/RoN; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7ae3e3db294so132280485a.2
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2024 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728687121; x=1729291921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZmCRqbf8/hzVSLIg4Tl+xwsidMruzMMIt+xIxBoTDA=;
        b=YVba/RoNIaMqVcTPMhYCmBbZgjIWjzE5faPl9nKjgtrhyKJijliY52oJBQaKe4kB6n
         wDNXB2oXL32fQZKTvz9hveBHQ+9oey5n9KtEgRCp7ov/kXjR6Rx5rJGHQ2hJ7fRmPtcD
         orrz+QvHcVRj/Pv4wYAzRFdX+l75QJ8VdH73r1hNtqPYaZP5NuLUmv1EN3aGxnHy5Drg
         nfklCo0GY0ZomEG5iQ6/zZAbVAHH4gebtcvhpz9vHkfnFZOiwZggud9c0ThP3t1rO78m
         32bfx453S0EL2w2sdrRpeJNzb0Nh2huNmX9dfgmIyLQJl6c0y4V7U0fv11NpAr3nFDjD
         hpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728687121; x=1729291921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZmCRqbf8/hzVSLIg4Tl+xwsidMruzMMIt+xIxBoTDA=;
        b=psVPm7DKAxf7KnFwA1k3nbzTscbau7+P+dXw2oGpclZx7yvH+wo/G91QIeKO5EEUSd
         7XiDwLIQPtdIKJA0xxm8atdTyqN9PLyKv4rOJDGTdhh2RLJl4Q+8P7jDGU9+v7WMVq+o
         dgZg5XJZduHJ1j6sWCyuCPW60pVxytxtcZr//D9toa/gFcYnId4z+g5mEMTl+Pgv3sTb
         QF4EWJKjmnxUAcxCkCXGuVqNnKgY0dGFVsmiKNERjm2d7e4uJUwwFT3OgyL6q//LQVES
         EgOfK5b+llpup3qP9iSuchIxj/V2GkFVNGoJdGcuRQoCAf/n7wDbqpN24YwiaHMdu3LO
         0nLw==
X-Gm-Message-State: AOJu0YzjSIdawj5hgXU/9PRHbdir+jZWD2dCBH6HB0QVelJxRAPWcVFH
	r4LkxOnDASEyic4ac0rdZb2RgwEiUc+vDpml3t/zPavzlGBb+OX+AaN/ItRPibq54S0ti3IKQxT
	6ZCA=
X-Google-Smtp-Source: AGHT+IFFEBaiVXnCVTSt27OreKF3NQPEnOZc6yhYLoOEoHBZA2WYWNsyqtjP28Tel3AafyYWXhhwuQ==
X-Received: by 2002:a05:620a:29c3:b0:7b1:12e0:39ef with SMTP id af79cd13be357-7b11a361247mr626548785a.21.1728687120283;
        Fri, 11 Oct 2024 15:52:00 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1149893basm176499585a.134.2024.10.11.15.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 15:52:00 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] efi/libstub: consider CONFIG_CMDLINE for initrd= and dtb= options
Date: Fri, 11 Oct 2024 18:48:02 -0400
Message-ID: <20241011224812.25763-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241011224812.25763-1-jonathan@marek.ca>
References: <20241011224812.25763-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace cmdline with CONFIG_CMDLINE when it should be used instead of
load_options.

In the EXTEND case, it may be necessary to combine both CONFIG_CMDLINE and
load_options. In that case, keep the old behavior and print a warning about
the incorrect behavior.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/firmware/efi/libstub/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index d6a025df07dcf..2a69e2b3583d4 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -208,6 +208,18 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 	if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
 		efi_chunk_size = EFI_READ_CHUNK_SIZE;
 
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
+	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
+	    cmdline_len == 0) {
+		if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_len > 0) {
+			/* both CONFIG_CMDLINE and load_options should be used */
+			efi_warn("ignoring %ls from CONFIG_CMDLINE\n", optstr);
+		} else {
+			cmdline = L"" CONFIG_CMDLINE;
+			cmdline_len = ARRAY_SIZE(L"" CONFIG_CMDLINE) - 1;
+		}
+	}
+
 	alloc_addr = alloc_size = 0;
 	do {
 		struct finfo fi;
-- 
2.45.1


