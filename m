Return-Path: <linux-efi+bounces-2760-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF27A2A9A3
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 14:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B243A9B7A
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C633923F29A;
	Thu,  6 Feb 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hwJJM1ZR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899F22C352
	for <linux-efi@vger.kernel.org>; Thu,  6 Feb 2025 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848012; cv=none; b=f19Sse7ijlR4+kHr+3pBjHZDlDCfsjX6mBt4jTSGmWTC/PLiH0Vu4b14UBoXkjjsk4yxz2xtvWfwB2zOvbdsubu1duJQ9s7Wy/RmPHikoG/h+oFPfZYodAL3u9Y/7Bf2vc2+Astoc9UOM4hMRfU3vfC8VvANkOV/3wEn0oJw8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848012; c=relaxed/simple;
	bh=0F6nOjUetrXOfzInBD9D3roQgpO3tl7/CFQLwv11kZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yr6Kl6XpL+6eT0c3E5eTuAKli2eBM+yOIb7uIACnnw3S5q0hw/DsDnKMh65Qx783ZKxq2rzTcWzWmavzrpFfxrOBRu5DZioPsitB8VE6BpRiPUshMMWEY1XYLWF+gzQdFT41xNNbyXDNfex80PL4aqfFt52lvC8OeamFBDlDqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hwJJM1ZR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f48ab13d5so2299745ad.0
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2025 05:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738848009; x=1739452809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf4go4iQL4QMflVyTQa4GngDZqe61egNHavae1e4JE8=;
        b=hwJJM1ZRHaGTf0qSnB9Effwzv1/KyvXpNSTs8CxQavApMmDwPmVb04MMCYKqCwjtZa
         0wZ7TMFwS0okfaaCIUbKwQAMHPcWQvkii33Va6Q1Yi57TjncuJOtQAVj8kj4OSL4qDbT
         isADFT+3wPegsoQPvi2+cgj/eb5XYhrfPxtqSwPiHc17fnTzYPObXCgtbG//wwl1mssD
         1tM9AyVhZ2/c8d30sWgsXRPUXi5lzfNle74UGN1Sq4We9cZnJDb7PgBXXZO1exC+ujE9
         kMNU7h9dk+rxnEO6+49dP0pkQf6eW0GjxU7HREaUk9C+YxHeB02DWxbg5t4fs2T8bIRX
         toMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738848009; x=1739452809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf4go4iQL4QMflVyTQa4GngDZqe61egNHavae1e4JE8=;
        b=sNspT8f8WpezC4QsksN4vldXNynhrgZD0XncmbC0V/SGCsfQIB+i23nUYhd3/8olQO
         lRpzwiXpl3XXXxiSZkzT7B6F1DVUkX0bGmtRtw+c8iqEFdnDvy7iUF1bEJ2qo/rvvyIK
         DF/tx5IGwQAHPLbQCaIuyQnVIENMMnmlRjvwIZD5SI4vMob3aCxI7btm2TuyGzfdStXx
         NBbbHAZopGxgUded49YlmvZELF2HDuB0FBvwe4ScuWBv6bY9uHyPI1WV2G4qE7XNelsG
         WT6rTFUzdwr4UZi+z9cbTUlF+NveRmoKnFxXsxa1qFz4/isgiHRRkkOgnck3PShb1kcv
         99eA==
X-Forwarded-Encrypted: i=1; AJvYcCUiPSD1WR6b9oE6eGmAiJH57Jkj01RqLaC/hq9QoBX5Dps8Funs0EZPgy/UGQ8kAUI3bDmGI374Q3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn53qViFcZ6Tyy8yuofr+4JuY7J7Tr0teqzsl3XEPaCpONNNr2
	NtvLnFzvAjjE6ESeteF9Pyyn6zZZkPl7eBLWRYuCHqAzR/JpRAqHsFtkkd0bGB8=
X-Gm-Gg: ASbGncvQKcO8glIg0QlY+scjJsunj5ajE/hrN9XyAsCSJdWeURv5SdxUvVGRSMixXte
	Z05zIgDQPa+LAifA0qMNyEy0vd/Yt7BeVkNI+Ef1MqLWrPL6pRbmW7i9j/tSHN7Jhjy9VOq5ii7
	zTPp6F9izh7H40sytYX9H40ZQmqw9MEgp2L+7pKuuetpDFDQMIexylaV5E/MotI8O9LphcefNEm
	3IaLNgHAzndItx6CVqsfCzz05rXng06EzM9Qf6IerRp/xSo4SIPHOd4zCZwUhAw6HPXYrZjvu9v
	L0ts0ghYgkg4wV0ygQ==
X-Google-Smtp-Source: AGHT+IGCPThNvLp+8va8nWxjbFE00U6UwUxIviEx1VgOqPw4pw4AKuRjGCX0YPWkMIbmGUsUZc9LiA==
X-Received: by 2002:a17:902:cf12:b0:21f:46b:a25 with SMTP id d9443c01a7336-21f17df5701mr115615155ad.16.1738848009353;
        Thu, 06 Feb 2025 05:20:09 -0800 (PST)
Received: from L4CR4519N7.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d987sm12170775ad.120.2025.02.06.05.20.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Feb 2025 05:20:09 -0800 (PST)
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
Subject: [RFC 2/5] efi: add riscv APEI generic processor error printing support
Date: Thu,  6 Feb 2025 21:19:23 +0800
Message-Id: <20250206131926.91289-3-qirui.001@bytedance.com>
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

Add support for riscv Common Platform Error Record (CPER).

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 drivers/firmware/efi/cper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b69e68ef3f02..50f84a0f2801 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -110,6 +110,7 @@ static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
 	"ARM",
+	"RISCV",
 };
 
 static const char * const proc_isa_strs[] = {
@@ -118,6 +119,9 @@ static const char * const proc_isa_strs[] = {
 	"X64",
 	"ARM A32/T32",
 	"ARM A64",
+	"RISCV32",
+	"RISCV64",
+
 };
 
 const char * const cper_proc_error_type_strs[] = {
-- 
2.20.1


