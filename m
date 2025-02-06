Return-Path: <linux-efi+bounces-2761-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B8EA2A9A0
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 14:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAB4169B62
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 13:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1819F24634B;
	Thu,  6 Feb 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fjhjveDt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F6226884
	for <linux-efi@vger.kernel.org>; Thu,  6 Feb 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848019; cv=none; b=ONb4iH4Z0jD84wWiLd4iphyIUaJ7puk4NCv4trebVUxMUY7xosvETCQwAGhBlWIrPOt/kX3tS77BIfub5qKPn5aaBJa/nZfG6J9DQYxPNUIh2jOo8CQgPofyQ1JHz5On4WV5j2oiRSeYrwWn9Irx8HTq95GIKcYEkZiiV2gZ2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848019; c=relaxed/simple;
	bh=CcAUF/3QIi/x84tx81/0uAfBF9yCMM/rt/arbcDZQTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afBZR/nzE289afYvfJMAi/EoUkGJcgzZhfnjOeSW1yymBndOLXtUU7bmJiPIZzbpSE+W4x7rOgaupcCwEWU3rGjZo7w6bIG99OGoO5s8jg0gDmfPk9RSKLhuTQHDzIpbJWDVUc6yhwqcxlTdaciNgcZAXzr6WJoNnEnjzGJsNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fjhjveDt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f3c119fe6so10712875ad.0
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2025 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738848015; x=1739452815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqkbJ8TV5TbCZyR0Ouzf3HmJ2PyLDsRK/LA88RD7yqE=;
        b=fjhjveDtcVhqwYpja5XZJY4MKrdtyjVzq0Peg6UDw1yE9+8dC7dNariQRJ7AnvFrlm
         mMVGNLdIWNXaRCpCV7UmtCoeSP2hCymJ71Pkh0uRLIeRolyvxfCYMPVzOQs3WP+IAn+r
         RXI39SIA8gjZMUBRRSI9FJDSMU61O4MraAq9kq3rPz31a2l9XEREN9M/mZRrmQgv8Qf0
         dYbkcrZenLOi5jikuSXDNovq8+fqixOh+7E8WNfFCQuh8npoaO/8Dn812jDyLuxKnzRk
         uHDZNqnOlrP8Yz0p3j/Ht5qlV42FppJkw2H0O3JS7bqtboGwMtqyHjZxwwgAY9TzN/vw
         91Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738848015; x=1739452815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqkbJ8TV5TbCZyR0Ouzf3HmJ2PyLDsRK/LA88RD7yqE=;
        b=F/+Q2Qfh08rQcnfcXKNKykkzk0JOgSLMy1T7Tyio2c2xDrs9edpNOmP5RApZDBAKjk
         Rlrb/nvEinaOFAttAv85/OeslGxdlSFEgvQcdzkwTsTfJH9Es02XWdJVFPXzT2xEqnvq
         lz3QoEp0wU5yXGA9cOC4nodyl3QwXB6xNB3XCvYlbJUoiUQHDpThLp4g2ke85lQA0j2y
         g9g4HaAP3wcIUSblVwKOtOM22dj3lqS/OeQOrX5d6OzOZEehF7Txd11VOG66hAUBiiuH
         jLQoj7H7A8bTenCn0x6xDUMPiDh7VRDiymeNcB6WFipq90h6XHN1FgvwHYNqeu3dvknQ
         Evew==
X-Forwarded-Encrypted: i=1; AJvYcCU1ELJW/IJcFMeVR7mbzLH0FwlrJW0CYsoulN+rfcmEJ+G53OCFSnxa/gWeAkIV5IVt3lDHH4SKiPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyKr0I4ZvnhWPq1ypGEkJbxOB0NonHGuVwoJU8FHYf5GrPboeK
	/cm0ThaeCASS82rstrQ8OuFXD9XB7HWWrowpgzlakzZTmPmC6Sn1xXfcTqklvpk=
X-Gm-Gg: ASbGnctQd1o1u9G80EuW2F2r/dEW537Z2gkTyOhzrg+5WkiRvy5cDyjjzIsOgFXsQbk
	7RELNyLNs6Qm7T1BIE9enQPURUrfExU+0bLY6bSVGTL4vDsCoZnAHN7ziKfmARFr4rZsziwluIL
	2k01wvjiZd0EPFT5WF9DNlMGufhUntc5Q1+X/NsilyRrtpBqX1A+jmVvfMVXZDjcFTsVQ4ggEXV
	6WWisPcbcS1LGSs/tZRc7qtO1Vy2h4PvvFfwfe8ji7h8zNcPYOB3dc/HreMfe299DXQMCGiT8tj
	rbChtJHhc72YfI36eA==
X-Google-Smtp-Source: AGHT+IG5GFPXn73eqa/ah28qsPEtdkabbkJ77MRXgD8idntcYPl7k6bk4bqy9R9tarIhqzZRJyuChA==
X-Received: by 2002:a17:902:db08:b0:21a:87d1:168a with SMTP id d9443c01a7336-21f17efedc1mr127014865ad.41.1738848014663;
        Thu, 06 Feb 2025 05:20:14 -0800 (PST)
Received: from L4CR4519N7.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d987sm12170775ad.120.2025.02.06.05.20.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Feb 2025 05:20:14 -0800 (PST)
From: Rui Qi <qirui.001@bytedance.com>
X-Google-Original-From: Rui Qi
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	haibo1.xu@intel.com,
	guohanjun@huawei.com,
	sunilvl@ventanamicro.com,
	samuel.holland@sifive.com,
	parri.andrea@gmail.com,
	ericchancf@google.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [RFC 3/5] riscv: add fix map index for GHES IRQ
Date: Thu,  6 Feb 2025 21:19:24 +0800
Message-Id: <20250206131926.91289-4-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250206131926.91289-1-qirui.001@bytedance.com>
References: <20250206131926.91289-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

GHES error handling requires fixmap entries for IRQ notifications.
Add fixmap index for it.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/riscv/include/asm/fixmap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..bca75c0e66a1 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -36,6 +36,9 @@ enum fixed_addresses {
 	FIX_P4D,
 	FIX_TEXT_POKE1,
 	FIX_TEXT_POKE0,
+#ifdef CONFIG_ACPI_APEI_GHES
+	FIX_APEI_GHES_IRQ,
+#endif
 	FIX_EARLYCON_MEM_BASE,
 
 	__end_of_permanent_fixed_addresses,
-- 
2.20.1


