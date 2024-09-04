Return-Path: <linux-efi+bounces-1648-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0F696B0F0
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 08:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363421F26565
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD6684A5C;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRSZAUpH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE784A39;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430064; cv=none; b=Yw1KqvoZ/iwMriIzDHShD2KmxLCetpxhT8kIAJAXC35T5fPayzAtTnuhz06L9W60Zpc4AOwo/TxSMHiUIBlvV7i898f7M2mrrAYvyw72EbOSCPHIlQamm5kQw10dfW3Wz4sKq+PXuC6S8foGA93he8pmZYfArI05zy5lyLBAiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430064; c=relaxed/simple;
	bh=YMlq9QoUoCLoMxst/4NMlo33uzF4F4yQHY7Nvhg0G6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1rmMHU3QW7MpwnIIjRWlR1USxgcRAqGcMYzPiEJwma23Pk3Fzg+HXtu78QiAyIxqYcSgJRFP+i0siIIfXRO3MPBTG6jFbeKPazUFKUmZNq+8ouhQtZFivpssrunJ6YGrfzcruwMICBGTGb4HFsXyHJrjWW1GuuwgStB3n55AAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRSZAUpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19488C4CEC9;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725430064;
	bh=YMlq9QoUoCLoMxst/4NMlo33uzF4F4yQHY7Nvhg0G6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRSZAUpH/AIJi5QwiTsM0Mw5bpNYrwtGB1YyEvFjMJNqr3bk8qJJWJuJLZw0sTcLt
	 7DyLfNdpZMM2Mk/9vgRRBHueHQTA6DSoX3a5wnCgQ7Vt4lFJEEkC752l40pRMezTf+
	 nPDJut6K6wFuzwtmNK4ELszm2W+51orj1K9VhSoIrJiTBNBLbTkiK8Bt8+4GKVaWUU
	 4sMuKcXouPV7h0/CqR/qrbUlR6t3rVfv3mqEc8EROnqnLZIM2mKc+j8K5CyiSHq+xM
	 Q63TdD0NV1PO+GBi00NLNVeIEWeoDEZrjqLGBP9OtmDOeRCzSgd9Nq2PNN01HiaRMM
	 shZ7HeMNPrSXQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sljB8-00000006Itk-0KWm;
	Wed, 04 Sep 2024 08:07:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ard Biesheuvel <mchehab+huawei@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 2/5] efi/cper: Adjust infopfx size to accept an extra space
Date: Wed,  4 Sep 2024 08:07:15 +0200
Message-ID: <1f92a7f3ceaba7ef877afdb53d3a7bbac58995ce.1725429659.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725429659.git.mchehab+huawei@kernel.org>
References: <cover.1725429659.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Compiling with W=1 with werror enabled produces an error:

drivers/firmware/efi/cper-arm.c: In function ‘cper_print_proc_arm’:
drivers/firmware/efi/cper-arm.c:298:64: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  298 |                         snprintf(infopfx, sizeof(infopfx), "%s ", newpfx);
      |                                                                ^
drivers/firmware/efi/cper-arm.c:298:25: note: ‘snprintf’ output between 2 and 65 bytes into a destination of size 64
  298 |                         snprintf(infopfx, sizeof(infopfx), "%s ", newpfx);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As the logic there adds an space at the end of infopx buffer.
Add an extra space to avoid such warning.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/firmware/efi/cper-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index fa9c1c3bf168..eb7ee6af55f2 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -240,7 +240,7 @@ void cper_print_proc_arm(const char *pfx,
 	int i, len, max_ctx_type;
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
-	char newpfx[64], infopfx[64];
+	char newpfx[64], infopfx[ARRAY_SIZE(newpfx) + 1];
 
 	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
 
-- 
2.46.0


