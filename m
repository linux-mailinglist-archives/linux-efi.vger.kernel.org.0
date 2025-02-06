Return-Path: <linux-efi+bounces-2759-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A9FA2A98C
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 14:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEF93A943D
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DF822F16F;
	Thu,  6 Feb 2025 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ujs4GxpX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F61D2288CB
	for <linux-efi@vger.kernel.org>; Thu,  6 Feb 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847993; cv=none; b=FiVRP0DFMrgrxLZYEAb2nfX4c0mquq+ma+624sHZFip6NQArvR4UhK/ydMdIsgadpVqAblcaIDEBMzU0JvMH1DBQsJjlAqHsepJchGbBemCaHUzhc8tXRpD7HVMAVy11M79A6FsIomDAWsHSTTJHUUxPP9m9uR8bEpZcJHZF2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847993; c=relaxed/simple;
	bh=FnH+hEd/jOysJrzD6EbQwOA5F3HBH9Mq8jvhDCPVw6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vw5y8RbHq2Po2vWW4WSuD5an60+SYo8nvhY2xIcN8gg8W+aUxh77RRLiorjaKgJRO6z9NXDDLfe9oFHCu0pnu/sjvEdcD50t7/MxDL02JtzwnTXJm12OFhl2EXJGtkLO5T7T75+EpJUMEcGpMGrfZlItA12mjUrN5jLbelZoqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ujs4GxpX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f9bed1f521so1228902a91.3
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2025 05:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738847991; x=1739452791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdj6PVBcwHidoO5BXn3s9EOfHL8khlRsKQpRtEXGdyE=;
        b=Ujs4GxpXBp1GkOmIYfrWB9tvKSN4ue3nnZ6H6EUzxp/Je/Tj54jzy1nP7oIGs15uwg
         /ItVyHwbSb7oMKqGEvt3BklDsEurexYGDjPUYmaJYU9NEjXkk4mw0SJggOPaRJQ0JEu4
         VTyOg1CIiGlAyMn0WQSl8rmTl0BV1b16tFLhrB/b7s4BdMaL3XdKRIICoK5Cs7fxry0v
         hBQuNsJrK+cPwb5JL23Rocbqijkq6dSWC995LVa+OG51XqHOG+V+mVu5JYr/IWizE2g4
         e8GXUBWW0Xh7zb8CKLo6cj7sCTWdCwT7zL3MYTbj1qFxqhB2MDQ/9VR3StKrh+Sxf/6W
         dzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738847991; x=1739452791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdj6PVBcwHidoO5BXn3s9EOfHL8khlRsKQpRtEXGdyE=;
        b=WbyJaVPWsmSOU0rbXmn6+Xp3vyrEo92pFgygPgh5C/83PTn0z5PgQijCAhLOYS57fZ
         H2GWF9vg2JCZ3t7Ao3xjdUxT35K3oNm+zSVgPj3I66Lmcb/tp6P+DtUy/T19Y9CFQ+mT
         cHJn6SuogCRvy1zht2tD+dvLhhPB7ycdm2JKA+aoRwWM218OdXYLnnvfVIvalyIclYY+
         71CfbmdwhUkLRJNYtI65FW6XYNzmCTPnNNwwJWNWq1cx69JRlNYNdE5DC+Zhk4CzAiSn
         UgZLcwXf7omOtqNK69Oyzgo8Ul6LnX5BK54b8iZk7+OUOVVIEQxCZ3UiuU4KN4+elc37
         e/NA==
X-Forwarded-Encrypted: i=1; AJvYcCXX/O4vTlh+v9Fz9mlHFRM+383aoq0JX4VEn1U5vOqUX+dzS5CMSmQhVSjUEgmMdMadolJr1aLOfqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Xvju7rnivZPCJzgjQeEyuppI0ca3/k5eq4DM967c0KU0Gi3I
	E1hK2lR+b3AoI1zqSK9ZzRjzJ5wZv3C+Ey2R72Vr4qR3nV1ibMbUJaSzdkRKVl4=
X-Gm-Gg: ASbGncu7lwJvT/5myq15pf9hugU4pnt3/1PbjNoJtitiHMQetJvxQRjt3ka07kCkA6E
	GEGQxrjdIsDbZb4vdromZVisH333SF+llQBfiVyfvmi2xxi1CDnO8dINZB3PlfI00is0Apqfl3V
	JoiJFJIg2GXZ9Rn7jw1kacnKVDUuw2HrlDJbqVXDAisUZ/3P22sD6eI+veJ/34SEcbxltyuja0k
	yoiFiWdzaBVQ4f9rLTdTuYBNUEUecj902BOUZ3JbEevgKjRg2CsIb0/FkOxj1FThsNH27D5p/wE
	exVhAUhRgRUgLPXR9Q==
X-Google-Smtp-Source: AGHT+IHfXnIXGHHOMLsW93QKlkZW4Ccyu2SXidx5aNBvkoYn0PbZECkavhjDqZaPqEQhZX0lGCcrNA==
X-Received: by 2002:a17:90a:d406:b0:2ee:e113:815d with SMTP id 98e67ed59e1d1-2f9e0761240mr10760981a91.8.1738847991406;
        Thu, 06 Feb 2025 05:19:51 -0800 (PST)
Received: from L4CR4519N7.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d987sm12170775ad.120.2025.02.06.05.19.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Feb 2025 05:19:51 -0800 (PST)
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
Subject: [RFC 1/5] riscv: select HAVE_ACPI_APEI
Date: Thu,  6 Feb 2025 21:19:22 +0800
Message-Id: <20250206131926.91289-2-qirui.001@bytedance.com>
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

The current riscv architecture code can already support GHES,
GHES depends on HAVE_ACPI_APEI, so enable it

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..df01fe8cc24a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -120,6 +120,7 @@ config RISCV
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
 	select HAVE_ALIGNED_STRUCT_PAGE
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
-- 
2.20.1


