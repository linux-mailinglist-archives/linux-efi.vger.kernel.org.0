Return-Path: <linux-efi+bounces-49-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B887EA8E4
	for <lists+linux-efi@lfdr.de>; Tue, 14 Nov 2023 04:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214AAB20A86
	for <lists+linux-efi@lfdr.de>; Tue, 14 Nov 2023 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB0679DE;
	Tue, 14 Nov 2023 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncf.edu header.i=@ncf.edu header.b="i66m2BXx"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C9446A9
	for <linux-efi@vger.kernel.org>; Tue, 14 Nov 2023 03:02:29 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3161A2
	for <linux-efi@vger.kernel.org>; Mon, 13 Nov 2023 19:02:28 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5bf58914bacso57066357b3.3
        for <linux-efi@vger.kernel.org>; Mon, 13 Nov 2023 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1699930948; x=1700535748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMWgF1k2ykWuu8Bjcr4iQLPBPTDTPxlZiLEGw/7iu+w=;
        b=i66m2BXxO5m2fCl6TChxLH3RK3HhkX1c9U+6fhB3huWTo2pHps72Eh9SfsPCfjNGKF
         MGahg1zOaHYCHWXRUI7RIeqxCDuvBD9WNAl8KQV+khG8laHxqoDB9GJDTfV6Z6etnWfV
         2bFesxMPwGPk4jne/ehvQaxZ4jmmkmnM2Rogc8ccg0SUWXiRN4cptodc6ORcBDs1NGLa
         nXAo/P81gpjTLI/L6LbnSTZ3QH/iL4+lCAxILi1RICeMfdHTEXfcU7/9WfNByGnK2Vyw
         cYXeazQbe3kLGXsoDS3Dn7v5uQA64MFOuIPPgElaR6I+8zk4S+BJbL71u9ZGZ+r4oiib
         tjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699930948; x=1700535748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMWgF1k2ykWuu8Bjcr4iQLPBPTDTPxlZiLEGw/7iu+w=;
        b=nOYMGGYtvfniBjlKPYzjB+I83VwkbBorPOb8KtJ87txrU0fh5WI85AWmke7ehQds2s
         7SwLEX/T30PK5ABui1VCMRhLn/V9GhinF2e/G2up8qbBPITw9ncLop4VHagh93/ry6LY
         tbQSsuG3CmryHbU0kvptQg9sp4ul+xYzCQKOf/2KL1vJqpMbgYf4HJRYkk6DhGURSwmE
         GeR3Bv7MX0WiqXWb0frcPI2i1586HfxsuNmgyR7/E1FjJaWAwLd/HlUiplHd/Mo8Vu/Z
         LNd2tRH+kdCGrpEUcmDZwPpEPobZdmggQKhLLg0vLTzY2e22hgGxFm31GTCYSlqZH5X/
         mtvg==
X-Gm-Message-State: AOJu0Yx/gMltf+Up25504iSINuUyeTQb9xgq1e2j77YKEDlsAvxUqK8z
	3fk4Ial4jr7P4vQATgXpI8teZw==
X-Google-Smtp-Source: AGHT+IFD7KvbTb+tGl/UoCilRnSomvyyiLX7mTYIn/1QS351TQtySzpDsuxpleORlfRRWeSOhHUCBg==
X-Received: by 2002:a25:34d1:0:b0:daf:6698:89d7 with SMTP id b200-20020a2534d1000000b00daf669889d7mr6608575yba.47.1699930947775;
        Mon, 13 Nov 2023 19:02:27 -0800 (PST)
Received: from Lux.hsd1.fl.comcast.net ([2601:580:8201:d0::4174])
        by smtp.gmail.com with ESMTPSA id x6-20020a25a006000000b00daf78e2e63dsm1403315ybh.27.2023.11.13.19.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 19:02:27 -0800 (PST)
From: Hunter Chasens <hunter.chasens18@ncf.edu>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	ardb@kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hunter Chasens <hunter.chasens18@ncf.edu>
Subject: [PATCH v3 2/2] docs: admin-guide: Adds explicit target to EFI-Stub doc
Date: Mon, 13 Nov 2023 22:02:08 -0500
Message-ID: <20231114030208.30479-2-hunter.chasens18@ncf.edu>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231114030208.30479-1-hunter.chasens18@ncf.edu>
References: <20231114030208.30479-1-hunter.chasens18@ncf.edu>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds an explicit target to efi-stub.rst so that it can be
referenced via roles in other documentation.

Note: scripts/checkpatch.pl is asking for a SPDX_LICENSE_TAG.
I believe this is under GPL2 but i'd like to confirm.

Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
---
 Documentation/admin-guide/efi-stub.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
index 090f3a185e18..cba966338087 100644
--- a/Documentation/admin-guide/efi-stub.rst
+++ b/Documentation/admin-guide/efi-stub.rst
@@ -1,3 +1,5 @@
+.. _efi_stub:
+
 =================
 The EFI Boot Stub
 =================
-- 
2.42.1


