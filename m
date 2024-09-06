Return-Path: <linux-efi+bounces-1667-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2B696EDC6
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 10:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5E0287C40
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2061598E9;
	Fri,  6 Sep 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="G1IQEWMm"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE98159568;
	Fri,  6 Sep 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611043; cv=none; b=Dn09oh6uGatmkI4j3RiYStlCYoVwWoBSPWqSb4lOnzYsVUyCXe7DD1QlMQus4DT0ndzwqKaGRmdlM9ZmoQOWqgzhonfJHNvnYNEYYhcGHi6RbFdNVdIlDgtczLvFJ6KstTtziqzAqMnOy16SVYemR1BTg8Dem717wuPtUzw+3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611043; c=relaxed/simple;
	bh=THSFwabHtGXp5+YvqfOjEzrrlxUrdNIEqvSF5uhbQ38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtfPjF3uy2AgLI1FiAlYrX9g1VtHN8ZOBFLoH/IR5Dcrpg3oDQPgEMX41bIhf3yJUMPd4Ef6j7q8+J/288ev48AfkkFYBsnNXGraZXEJFbKAJ3iH3BuTiERcYV4fSuL9j+ur2LcWb250wduKD1BAaA7si+a3Hwu4ChI6mj3s88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=G1IQEWMm; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725611021;
	bh=MO0pi98eViiMaBz/NH3uP9iuQWzc2fwH2Tnw5ppTaJs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=G1IQEWMmAp+d++lXR0jpIFVa8dUuiRGJhm3w4rslK4iNq/JGXXyXJHoJTwZJvdx9j
	 BPgEDxmAPS/qtitTpQlQbQ0OL+4i7+bwQtSgyPkuP6cFymo8Y6yojQ4+nyz6Sc9n4K
	 /atGDwzvxcdqrtDoNGGoLXsRQnMbLuptY0Oa1RwY=
X-QQ-mid: bizesmtp82t1725611003tulm6gpk
X-QQ-Originating-IP: WlORxptxdtKcKmsPKXiz0WSiWrD5HCSBdepoR+2Hh7o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Sep 2024 16:23:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18096305791163907771
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	alexghiti@rivosinc.com,
	palmer@rivosinc.com,
	wangyuli@uniontech.com
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	anup@brainfault.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	dvlachos@ics.forth.gr,
	bhe@redhat.com,
	samuel.holland@sifive.com,
	guoren@kernel.org,
	linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	fengwei.yin@intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	conor.dooley@microchip.com,
	glider@google.com,
	elver@google.com,
	dvyukov@google.com,
	kasan-dev@googlegroups.com,
	ardb@kernel.org,
	linux-efi@vger.kernel.org,
	atishp@atishpatra.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	qiaozhe@iscas.ac.cn,
	ryan.roberts@arm.com,
	ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	vincenzo.frascino@arm.com,
	namcao@linutronix.de
Subject: [PATCH 6.6 3/4] riscv: mm: Only compile pgtable.c if MMU
Date: Fri,  6 Sep 2024 16:22:38 +0800
Message-ID: <A01B1440514C416E+20240906082254.435410-3-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240906082254.435410-1-wangyuli@uniontech.com>
References: <20240906082254.435410-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Alexandre Ghiti <alexghiti@rivosinc.com>

[ Upstream commit d6508999d1882ddd0db8b3b4bd7967d83e9909fa ]

All functions defined in there depend on MMU, so no need to compile it
for !MMU configs.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20231213203001.179237-4-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/riscv/mm/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 3a4dfc8babcf..2c869f8026a8 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,10 +13,9 @@ endif
 KCOV_INSTRUMENT_init.o := n
 
 obj-y += init.o
-obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o
+obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o pgtable.o
 obj-y += cacheflush.o
 obj-y += context.o
-obj-y += pgtable.o
 obj-y += pmem.o
 
 ifeq ($(CONFIG_MMU),y)
-- 
2.43.4


