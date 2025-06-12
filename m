Return-Path: <linux-efi+bounces-3828-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1269BAD6C39
	for <lists+linux-efi@lfdr.de>; Thu, 12 Jun 2025 11:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9957717E8BD
	for <lists+linux-efi@lfdr.de>; Thu, 12 Jun 2025 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEC92288EE;
	Thu, 12 Jun 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bhImUav7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B420371F;
	Thu, 12 Jun 2025 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720666; cv=none; b=qY2X4AVBGAnFNVF8wQawemlLfxlWBZW4FFizLhKZ+Y03dC5HliGTzNCoxhaHwxJKdqwba6A4Zs4PjoieHsgTryIAiyt1soNsUg5FW4mweiEPnCl62seuCRxelHTm0IPJ7gYyqSL7QWA6+DGkyYyE1HxbDTKwR6W7UdQmBBng2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720666; c=relaxed/simple;
	bh=GMXia8xTHHjLS+xTJzeKQWOYx6IlzyLhpBUkC3SxmjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pqzKir8qYxeqyDHuLtnHQnVNQc9eraE7hJWkqVYBOUJwrfkgpbh6T3DxEwa5a3zLlNP9/HnuYJGTEIoHqD6XjnHWWkUWFtqGJ0XrbHFZKjzqdUU4RFUAAJ9cftiPzo2IRPdzpHraS2nn4Ck1S8GwFkKOJq6qE0Z60eiJw4q6cBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bhImUav7; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1749720645;
	bh=2Zy4bFoBVzl6nVTabnVpris3XyN2VolT0oRORLqhxgY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=bhImUav7I27ncKIEx7XNpBDu13ojWS6AeaMzo9E01QgXaxKKj5/viUBC3Li22EwJj
	 uznKXUZZODbqTppUzWxAmFRMRIdvAq/7jXjmbiCbMSVt/Y5tjHB8ZBqkrP4+qyRBYx
	 Oc9pjgkkRSKXoufyrJ8oNyOq3jmRFd43Sv7eikeo=
X-QQ-mid: zesmtpip2t1749720636tcbef0ec9
X-QQ-Originating-IP: LbLuh+31dWspvgSIPYQRMs7XmdvIPMOO1pEFScbjCQQ=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Jun 2025 17:30:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11818956612719598227
EX-QQ-RecipientCnt: 70
From: Zhenghan Cheng <chengzhenghan@uniontech.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	rafael@kernel.org,
	jgross@suse.com,
	Jason@zx2c4.com,
	mhiramat@kernel.org,
	ebiggers@kernel.org,
	masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	lenb@kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	ppaalanen@gmail.com,
	boris.ostrovsky@oracle.com,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	ilpo.jarvinen@linux.intel.com,
	usamaarif642@gmail.com,
	ubizjat@gmail.com,
	dyoung@redhat.com,
	myrrhperiwinkle@qtmlabs.xyz,
	guoweikang.kernel@gmail.com,
	graf@amazon.com,
	chao.gao@intel.com,
	chang.seok.bae@intel.com,
	sohil.mehta@intel.com,
	vigbalas@amd.com,
	aruna.ramakrishna@oracle.com,
	zhangkunbo@huawei.com,
	fvdl@google.com,
	gatlin.newhouse@gmail.com,
	snovitoll@gmail.com,
	bjohannesmeyer@gmail.com,
	glider@google.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	shivankg@amd.com,
	peterx@redhat.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	kevin.brodsky@arm.com,
	willy@infradead.org,
	linux@treblig.org,
	Neeraj.Upadhyay@amd.com,
	chengzhenghan@uniontech.com,
	wangyuli@uniontech.com,
	linux-crypto@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	"Huacai Chen" <chenhuacai@loongson.cn>,
	Zhenghan Cheng <your_email@example.com>
Subject: [PATCH] x86: Fix build warnings about export.h
Date: Thu, 12 Jun 2025 17:30:21 +0800
Message-Id: <20250612093021.7187-1-chengzhenghan@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M4+GqYRlc6iC0/2XewH4aZosFmxA2lvwvGc+W0psKSGqc2rEdN3lKGbv
	HaR411+bj+3bR220lTevUctqZW5q3euUvPFS19o/gPMw0ywtpW34jad+qZpzYXHyJ2AvZ9G
	/WXf6mOcPV17ddd7UbUa1mRSxf8HqrVgpi722nsXwa95acarLqrpS7KTDUkNeyaaOuwLF6O
	HcpT3Qs3eqTA0V3PqGhzcuZePcAj1+eABECKFjESkOzhdtn1KFBaTOljdDHJfifW+cIT8Zg
	G2IzcAg2EUeKR3hW0lNDTv3qJi/GMpL/1+aj7vTUXJ+Pq7+IoSR8BQFTRUCH7I+s5+Skqj4
	FKkrriW4Hod+caEoTWjgdzCK9hE6bvkP0lmWLjtz4TCrgd4eaA0td4fLhEv7Y/mmKaeoYlu
	vo/U5JZFEC9P5kwHSFNuR7NMBoJKgQuwKHbqC1ncEp+fEmBT4TU/q00oKA8gy+V4c9XEJz8
	HGqHaYR7CjcBJjz3z2NNIibBcfImNUMlZbs6LqaSjtxqsSVORZu8uBaev0GU/cOaGpbLst4
	3TOvdLsmf5Gq9W78XrjBM5ZXh0C39N+tSCw7sCxBGicOeJoqj8HxmKkf7JDc8h5Rt2y8fYs
	mxh/UfQNo1CrJShfEVAdLmMKac+TZDQttPeMs1XdZxUzSwb97sZqickAOgkQSNmm7BMnWYH
	ZmNCImVm+ELF/pYMMqT+q9SMnr7Z9b/Bt0Fr+kfGR2K7HWJXQC4iP99d7fVBQ6KXKfXRwcv
	uOLqoc8mf6wZY7uKDwFGIryZgebmO84p3c6hEhAS5dTIlZtAsXGdK2ntmh3xEdAWhfkk206
	5b6Swe7yfnD0qXLK/cN4cqxL9pTqUiYCxEymsvgGa6OaO3xLWcEdFR0QSbtmZA1uRzLs/2I
	eVmklbJ4jtiTeoCITweC4LqIaMoPbp4sfEkRp17ineTaPwofwaWwF/SvEseKVFoZMATd940
	FtGMsY9M//dtxnuaZRsl0+22nNWZ9RQcKOcb25tZuw1tPlW/CiLGsyTBZgmGvmYNnEAWtU9
	Nv+GK5BxkWw21Vxoi6tcRHJA2Y4hb78qXh/U6soTrbfD2SBaGbPM4ea9NhqOcTiqWXRrdoB
	g==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

After commit a934a57a42f64a4 ("scripts/misc-check:
check missing #include <linux/export.h> when W=1")
and commit 7d95680d64ac8e836c ("scripts/misc-check:
check unnecessary #include <linux/export.h> when W=1"),
we get some build warnings with W=1,such as:

arch/x86/coco/sev/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
arch/x86/crypto/aria_aesni_avx2_glue.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
arch/x86/kernel/unwind_orc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
arch/x86/kvm/hyperv.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
arch/x86/events/intel/core.c: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present
arch/x86/events/zhaoxin/core.c: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present
arch/x86/kernel/crash.c: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present
arch/x86/kernel/devicetree.c: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present

so fix these build warnings for x86.

Signed-off-by: "Zhenghan Cheng" <chengzhenghan@uniontech.com>
Suggested-by: "Huacai Chen" <chenhuacai@loongson.cn>

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b6db4e0b936b..773b24859037 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/psp-sev.h>
 #include <linux/dmi.h>
+#include <linux/export.h>
 #include <uapi/linux/sev-guest.h>
 #include <crypto/gcm.h>

diff --git a/arch/x86/crypto/aria_aesni_avx2_glue.c b/arch/x86/crypto/aria_aesni_avx2_glue.c
index b4bddcd58457..007b250f774c 100644
--- a/arch/x86/crypto/aria_aesni_avx2_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx2_glue.c
@@ -9,6 +9,7 @@
 #include <crypto/aria.h>
 #include <linux/crypto.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/types.h>

diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index ab9b38d05332..4c88ef4eba82 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -9,6 +9,7 @@
 #include <crypto/aria.h>
 #include <linux/crypto.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/types.h>

diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index a7d162388142..5c321f255eb7 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -8,6 +8,7 @@
 #include <crypto/algapi.h>
 #include <linux/crypto.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/types.h>

diff --git a/arch/x86/crypto/camellia_glue.c b/arch/x86/crypto/camellia_glue.c
index 3bd37d664121..cbede120e5f2 100644
--- a/arch/x86/crypto/camellia_glue.c
+++ b/arch/x86/crypto/camellia_glue.c
@@ -10,6 +10,7 @@

 #include <linux/unaligned.h>
 #include <linux/crypto.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index dcfc0de333de..86d4c4d85487 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -8,6 +8,7 @@
 #include <crypto/internal/kpp.h>

 #include <linux/types.h>
+#include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index e640abc1cb8a..9c8b3a335d5c 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/crypto.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <crypto/algapi.h>
 #include <crypto/serpent.h>

diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
index 72867fc49ce8..88caf418a06f 100644
--- a/arch/x86/crypto/sm4_aesni_avx_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx_glue.c
@@ -11,6 +11,7 @@
 #include <asm/fpu/api.h>
 #include <linux/module.h>
 #include <linux/crypto.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <crypto/internal/skcipher.h>
 #include <crypto/sm4.h>
diff --git a/arch/x86/crypto/twofish_glue.c b/arch/x86/crypto/twofish_glue.c
index 4c67184dc573..8e9906d36902 100644
--- a/arch/x86/crypto/twofish_glue.c
+++ b/arch/x86/crypto/twofish_glue.c
@@ -40,6 +40,7 @@

 #include <crypto/algapi.h>
 #include <crypto/twofish.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 1a1ecfa7f72a..8ad77725bf60 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -9,6 +9,7 @@
 #include <crypto/algapi.h>
 #include <crypto/twofish.h>
 #include <linux/crypto.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 741b229f0718..04cf3d1019d9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/export.h>
 #include <linux/nmi.h>
 #include <linux/kvm_host.h>

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 7aa59966e7c3..10619c767602 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/perf_event.h>
+#include <linux/export.h>
 #include <linux/types.h>

 #include <asm/cpu_device_id.h>
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index e8cf29d2b10c..9c772c89b623 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -17,6 +17,8 @@
 #include <linux/limits.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/export.h>
+

 #include <asm/cpuid/api.h>
 #include <asm/perf_event.h>
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 4bdfcf091200..67fa000cf372 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -9,7 +9,6 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/export.h>
 #include <linux/nmi.h>

 #include <asm/cpufeature.h>
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3d1d3547095a..3bd18521cd46 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -29,6 +29,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/cpuhotplug.h>
 #include <linux/syscore_ops.h>
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 31f0d29cbc5e..f7627bc8fe49 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -10,6 +10,7 @@

 #include <linux/pci.h>
 #include <linux/irq.h>
+#include <linux/export.h>
 #include <asm/mshyperv.h>

 static int hv_map_interrupt(union hv_device_id device_id, bool level,
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index e93a2f488ff7..d9c0b3064222 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -7,6 +7,7 @@
  */

 #include <linux/bitfield.h>
+#include <linux/export.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index 1083dc8646f9..1413bfe40ea9 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -9,7 +9,7 @@
  */
 #define pr_fmt(fmt)  "Hyper-V: " fmt

-
+#include <linux/export.h>
 #include <linux/types.h>
 #include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 7047124490f6..e943947ccb3d 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -5,6 +5,7 @@
  */

 #include <linux/bitfield.h>
+#include <linux/export.h>

 #include <acpi/cppc_acpi.h>
 #include <asm/msr.h>
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ecfe7b497cad..882d99b1f4fb 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -6,6 +6,7 @@
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
 #include <linux/execmem.h>
+#include <linux/export.h>

 #include <asm/text-patching.h>
 #include <asm/insn.h>
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index a40176b62eb5..55118dd87116 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -9,6 +9,7 @@
  */

 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <asm/amd/node.h>

 /*
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index 9ef3be866832..f7e1cbb70029 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -3,6 +3,7 @@
  *
  * SPDX-License-Identifier: GPL-2.0
  */
+#include <linux/export.h>
 #include <linux/irq.h>
 #include <asm/apic.h>

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 66bc5d3e79db..3f133e24a38e 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -14,6 +14,7 @@
 #include <linux/dmar.h>
 #include <linux/hpet.h>
 #include <linux/msi.h>
+#include <linux/export.h>
 #include <asm/irqdomain.h>
 #include <asm/hpet.h>
 #include <asm/hw_irq.h>
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 93069b13d3af..f35c9184ac30 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/compiler.h>
 #include <linux/slab.h>
+#include <linux/export.h>
 #include <asm/irqdomain.h>
 #include <asm/hw_irq.h>
 #include <asm/traps.h>
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 2c5b51aad91a..8f181da43b20 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -10,6 +10,7 @@
  */

 #include <linux/interrupt.h>
+#include <linux/export.h>

 #include <asm/acrn.h>
 #include <asm/apic.h>
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index a315b0627dfb..e441400106f8 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -8,6 +8,7 @@
  */
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/ktime.h>
 #include <linux/math64.h>
 #include <linux/percpu.h>
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7f94e6a5497d..fd136016ff8f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -16,6 +16,7 @@
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
+#include <linux/export.h>

 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 981f8b1f0792..68105db4dc66 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -6,6 +6,7 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/cpuhotplug.h>
+#include <linux/export.h>
 #include <asm/cpu_device_id.h>
 #include <asm/cmdline.h>
 #include <asm/traps.h>
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9d852c3b2cb5..9b335a939576 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/kobject.h>
+#include <linux/export.h>
 #include <linux/percpu.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 8d023239ce18..4657fdb4810e 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -10,6 +10,7 @@
  */

 #include <linux/miscdevice.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/poll.h>
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 371ca6eac00e..50b17579ca97 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -14,6 +14,7 @@
 #include <linux/earlycpio.h>
 #include <linux/firmware.h>
 #include <linux/uaccess.h>
+#include <linux/export.h>
 #include <linux/initrd.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 2de01b379aa3..cb9eade755ee 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */

+#include <linux/export.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
 #include <linux/highmem.h>
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 7aaa3652e31d..15ce2a05c260 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -5,6 +5,7 @@
  * Copyright(c) 2021 Intel Corporation.
  */

+#include <linux/export.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index e35ccdc84910..30df9f9c4b0d 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -23,6 +23,7 @@
  */
 #define pr_fmt(fmt) "CPU topo: " fmt
 #include <linux/cpu.h>
+#include <linux/export.h>

 #include <xen/xen.h>

diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index b5a5e1411469..fa841c8b70df 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/cpu.h>
+#include <linux/export.h>

 #include <xen/xen.h>

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index bcb534688dfe..3dbabdfe9649 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -21,7 +21,6 @@
 #include <linux/delay.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
-#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index dd8748c45529..2b72ca27eaac 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -3,7 +3,6 @@
  * Architecture specific OF callbacks.
  */
 #include <linux/acpi.h>
-#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 722fd712e1cf..16f5a7984a46 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -9,7 +9,6 @@
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 #include <linux/kdebug.h>
-#include <linux/export.h>
 #include <linux/ptrace.h>
 #include <linux/kexec.h>
 #include <linux/sysfs.h>
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 6c5defd6569a..4975c5546ba9 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -9,7 +9,6 @@
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 #include <linux/kdebug.h>
-#include <linux/export.h>
 #include <linux/ptrace.h>
 #include <linux/kexec.h>
 #include <linux/sysfs.h>
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c3acbd26408b..9edbb4ebac31 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -12,6 +12,7 @@
 #include <linux/crash_dump.h>
 #include <linux/memblock.h>
 #include <linux/suspend.h>
+#include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/firmware-map.h>
 #include <linux/sort.h>
diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 6b6f32f40cbe..097721a95a8d 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/pci_ids.h>
 #include <linux/bcma/bcma.h>
 #include <linux/bcma/bcma_regs.h>
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ea138583dd92..2e4e37bf9d8f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -17,6 +17,7 @@

 #include <uapi/asm/kvm.h>

+#include <linux/export.h>
 #include <linux/hardirq.h>
 #include <linux/pkeys.h>
 #include <linux/vmalloc.h>
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9aa9ac8399ae..6e1dcafc457d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,7 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/export.h>
 #include <linux/mman.h>
 #include <linux/nospec.h>
 #include <linux/pkeys.h>
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 533fcf5636fc..b58c6128554f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -19,6 +19,7 @@
 #include <linux/memblock.h>
 #include <linux/cc_platform.h>
 #include <linux/pgtable.h>
+#include <linux/export.h>

 #include <asm/asm.h>
 #include <asm/page_64.h>
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 2bade73f49e3..212f5e9959e1 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/linkage.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/ioport.h>
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 921c1c783bc1..37a94e2a2d46 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -29,6 +29,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/cc_platform.h>
 #include <linux/efi.h>
+#include <linux/export.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 9e1ea99ad9df..7f131a15ac9e 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -4,7 +4,6 @@
  * compiled in a FTRACE-compatible way.
  */
 #include <linux/spinlock.h>
-#include <linux/export.h>
 #include <linux/jump_label.h>

 #include <asm/paravirt.h>
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 095f04bdabdc..dfc8ebc8b0f8 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -22,7 +22,6 @@
 #include <linux/perf_event.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/rcupdate.h>
-#include <linux/export.h>
 #include <linux/context_tracking.h>
 #include <linux/nospec.h>

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index b3f81379c2fc..96d944e26dbe 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -11,6 +11,7 @@
 #include <linux/gfp.h>
 #include <linux/memblock.h>
 #include <linux/nmi.h>
+#include <linux/export.h>

 #include <asm/fixmap.h>
 #include <asm/pvclock.h>
diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index a92f18db9610..221014f3d306 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -5,6 +5,7 @@
 #include <linux/dmi.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
+#include <linux/export.h>

 #include <asm/hpet.h>
 #include <asm/setup.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index fb27be697128..ea43a022f9a8 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -11,6 +11,7 @@
 #include <linux/crash_dump.h>
 #include <linux/dma-map-ops.h>
 #include <linux/efi.h>
+#include <linux/export.h>
 #include <linux/hugetlb.h>
 #include <linux/ima.h>
 #include <linux/init_ohci1394_dma.h>
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index ee117fcf46ed..ddce014f29b2 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -7,7 +7,6 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
-#include <linux/export.h>
 #include <linux/uaccess.h>
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 378c388d1b31..3ab922966ab4 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/static_call.h>
+#include <linux/export.h>
 #include <linux/memory.h>
 #include <linux/bug.h>
 #include <asm/text-patching.h>
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 46b8f1f16676..b6a1bb741ebd 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -8,7 +8,6 @@

 #include <linux/init_task.h>
 #include <linux/spinlock.h>
-#include <linux/export.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/init.h>
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c5c897a86418..5a038f66271b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -22,7 +22,6 @@
 #include <linux/kdebug.h>
 #include <linux/kgdb.h>
 #include <linux/kernel.h>
-#include <linux/export.h>
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
 #include <linux/string.h>
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index d8ba93778ae3..f3b893c0e5e7 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -3,6 +3,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/interrupt.h>
+#include <linux/export.h>
 #include <asm/sections.h>
 #include <asm/ptrace.h>
 #include <asm/bitops.h>
diff --git a/arch/x86/kernel/unwind_guess.c b/arch/x86/kernel/unwind_guess.c
index 884d68a6e714..86813ae9d57c 100644
--- a/arch/x86/kernel/unwind_guess.c
+++ b/arch/x86/kernel/unwind_guess.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/sched.h>
 #include <linux/ftrace.h>
+#include <linux/export.h>
 #include <asm/ptrace.h>
 #include <asm/bitops.h>
 #include <asm/stacktrace.h>
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 977ee75e047c..ec0cd3c54616 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/objtool.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <asm/ptrace.h>
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 24f0318c50d7..09f9de4555dd 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -33,6 +33,7 @@
 #include <linux/sched/cputime.h>
 #include <linux/spinlock.h>
 #include <linux/eventfd.h>
+#include <linux/export.h>

 #include <asm/apicdef.h>
 #include <asm/mshyperv.h>
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 45dae2d5d2f1..bfa87e74fe18 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -36,7 +36,6 @@
 #include <linux/hrtimer.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include <linux/export.h>
 #include <linux/nospec.h>
 #include <asm/processor.h>
 #include <asm/page.h>
diff --git a/arch/x86/kvm/kvm_onhyperv.c b/arch/x86/kvm/kvm_onhyperv.c
index ded0bd688c65..73a97e1dcdbd 100644
--- a/arch/x86/kvm/kvm_onhyperv.c
+++ b/arch/x86/kvm/kvm_onhyperv.c
@@ -4,6 +4,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+#include <linux/export.h>
 #include <linux/kvm_host.h>
 #include <asm/mshyperv.h>

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 1b17b12393a8..2c407d7edd09 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -15,6 +15,7 @@
 #include <linux/lockdep.h>
 #include <linux/kvm_host.h>
 #include <linux/rculist.h>
+#include <linux/export.h>

 #include "mmu.h"
 #include "mmu_internal.h"
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index cfce03d8f123..217a802e86f9 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -9,6 +9,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+#include <linux/export.h>
 #include <linux/kvm_host.h>
 #include "mmu.h"
 #include "mmu_internal.h"
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7f3d7229b2c1..1df1726f506c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -8,6 +8,7 @@
 #include "tdp_mmu.h"
 #include "spte.h"

+#include <linux/export.h>
 #include <asm/cmpxchg.h>
 #include <trace/events/kvm.h>

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 75e9cfc689f8..308a6ae502e3 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -16,6 +16,7 @@
 #include <linux/perf_event.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/export.h>
 #include <asm/perf_event.h>
 #include <asm/cpu_device_id.h>
 #include "x86.h"
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 9864c057187d..4b13a6346f06 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/kvm_host.h>
+#include <linux/export.h>
 #include "x86.h"
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
diff --git a/arch/x86/lib/atomic64_32.c b/arch/x86/lib/atomic64_32.c
index a0b4a350daa7..04a6901a8969 100644
--- a/arch/x86/lib/atomic64_32.c
+++ b/arch/x86/lib/atomic64_32.c
@@ -1,4 +1,3 @@
 #define ATOMIC64_EXPORT EXPORT_SYMBOL

-#include <linux/export.h>
 #include <linux/atomic.h>
diff --git a/arch/x86/lib/crc-t10dif.c b/arch/x86/lib/crc-t10dif.c
index db7ce59c31ac..c8c2108675cd 100644
--- a/arch/x86/lib/crc-t10dif.c
+++ b/arch/x86/lib/crc-t10dif.c
@@ -6,6 +6,7 @@
  */

 #include <linux/crc-t10dif.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include "crc-pclmul-template.h"

diff --git a/arch/x86/lib/crc32.c b/arch/x86/lib/crc32.c
index d09343e2cea9..21e84e3c94eb 100644
--- a/arch/x86/lib/crc32.c
+++ b/arch/x86/lib/crc32.c
@@ -8,6 +8,7 @@
  */

 #include <linux/crc32.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include "crc-pclmul-template.h"

diff --git a/arch/x86/lib/crc64.c b/arch/x86/lib/crc64.c
index 351a09f5813e..6c1a1beb5c97 100644
--- a/arch/x86/lib/crc64.c
+++ b/arch/x86/lib/crc64.c
@@ -6,6 +6,7 @@
  */

 #include <linux/crc64.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include "crc-pclmul-template.h"

diff --git a/arch/x86/lib/crypto/blake2s-glue.c b/arch/x86/lib/crypto/blake2s-glue.c
index adc296cd17c9..e65cebbdc043 100644
--- a/arch/x86/lib/crypto/blake2s-glue.c
+++ b/arch/x86/lib/crypto/blake2s-glue.c
@@ -8,6 +8,7 @@
 #include <asm/processor.h>
 #include <asm/simd.h>
 #include <crypto/internal/blake2s.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
diff --git a/arch/x86/lib/crypto/chacha_glue.c b/arch/x86/lib/crypto/chacha_glue.c
index 10b2c945f541..7e3bf4b091f1 100644
--- a/arch/x86/lib/crypto/chacha_glue.c
+++ b/arch/x86/lib/crypto/chacha_glue.c
@@ -7,6 +7,7 @@

 #include <asm/simd.h>
 #include <crypto/chacha.h>
+#include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/arch/x86/lib/crypto/poly1305_glue.c b/arch/x86/lib/crypto/poly1305_glue.c
index b7e78a583e07..c2bc5b831551 100644
--- a/arch/x86/lib/crypto/poly1305_glue.c
+++ b/arch/x86/lib/crypto/poly1305_glue.c
@@ -6,6 +6,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/fpu/api.h>
 #include <crypto/internal/poly1305.h>
+#include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/arch/x86/lib/crypto/sha256.c b/arch/x86/lib/crypto/sha256.c
index 80380f8fdcee..46d5d174e821 100644
--- a/arch/x86/lib/crypto/sha256.c
+++ b/arch/x86/lib/crypto/sha256.c
@@ -6,6 +6,7 @@
  */
 #include <asm/fpu/api.h>
 #include <crypto/internal/sha2.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/static_call.h>
diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index c20e04764edc..20f90c60e34e 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -1,5 +1,6 @@
 #include <linux/string.h>
 #include <linux/module.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kmsan-checks.h>

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 575f863f3c75..2ffd4628643b 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -5,6 +5,7 @@
 #include <linux/kallsyms.h>
 #include <linux/kcore.h>
 #include <linux/pgtable.h>
+#include <linux/export.h>

 #include <asm/cpu_entry_area.h>
 #include <asm/fixmap.h>
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index a4700ef6eb64..90df00f4ef88 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -9,6 +9,7 @@
  */

 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/init.h>
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7456df985d96..00c7088c5835 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -8,6 +8,7 @@
 #include <linux/kmemleak.h>
 #include <linux/sched/task.h>
 #include <linux/execmem.h>
+#include <linux/export.h>

 #include <asm/set_memory.h>
 #include <asm/cpu_device_id.h>
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 607d6a2e66e2..633887c582af 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -31,6 +31,7 @@
 #include <linux/cpumask.h>
 #include <linux/gfp.h>
 #include <linux/execmem.h>
+#include <linux/export.h>

 #include <asm/asm.h>
 #include <asm/bios_ebda.h>
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ee66fae9ebcc..e3bd8adea411 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -35,6 +35,7 @@
 #include <linux/kcore.h>
 #include <linux/bootmem_info.h>
 #include <linux/execmem.h>
+#include <linux/export.h>

 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 12c8180ca1ba..4e2101e637ba 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -17,6 +17,7 @@
 #include <linux/mmiotrace.h>
 #include <linux/cc_platform.h>
 #include <linux/efi.h>
+#include <linux/export.h>
 #include <linux/pgtable.h>
 #include <linux/kmsan.h>

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index faf3a13fb6ba..cb069276f756 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/cc_platform.h>
+#include <linux/export.h>

 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index c3317f0650d8..7555c0ef2cf3 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -21,6 +21,7 @@
 #include <linux/atomic.h>
 #include <linux/percpu.h>
 #include <linux/cpu.h>
+#include <linux/export.h>

 #include "pf_in.h"

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index c24890c40138..5e3ac16ceea5 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -14,6 +14,7 @@
 #include <linux/topology.h>
 #include <linux/sort.h>
 #include <linux/numa_memblks.h>
+#include <linux/export.h>

 #include <asm/e820/api.h>
 #include <asm/proto.h>
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 2e7923844afe..3eeee5b2384a 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -34,6 +34,7 @@
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/pfn_t.h>
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 46edc11726b7..89973d5e4327 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -22,6 +22,7 @@
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
 #include <linux/memregion.h>
+#include <linux/export.h>

 #include <asm/e820/api.h>
 #include <asm/processor.h>
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ddf248c3ee7d..92ee7b5cd93b 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm.h>
 #include <linux/gfp.h>
+#include <linux/export.h>
 #include <linux/hugetlb.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
diff --git a/arch/x86/mm/pgtable_32.c b/arch/x86/mm/pgtable_32.c
index c234634e26ba..2acb05736cf1 100644
--- a/arch/x86/mm/pgtable_32.c
+++ b/arch/x86/mm/pgtable_32.c
@@ -9,6 +9,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
+#include <linux/export.h>

 #include <asm/cpu_entry_area.h>
 #include <asm/fixmap.h>
diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 244c643bb0b5..1956cb58e281 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -5,6 +5,7 @@

 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 463b784499a8..6288436d8ec3 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -35,7 +35,6 @@
 #include <linux/init.h>
 #include <linux/efi.h>
 #include <linux/efi-bgrt.h>
-#include <linux/export.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e7e8f77f77f8..627d084c344d 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -27,7 +27,6 @@
 #include <linux/ioport.h>
 #include <linux/mc146818rtc.h>
 #include <linux/efi.h>
-#include <linux/export.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 553f330198f2..4119b2f693bc 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -7,6 +7,7 @@
 #include <linux/time.h>
 #include <linux/types.h>
 #include <linux/efi.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/acpi.h>
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index a8e75f8c14fd..a877e52cb38e 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -15,7 +15,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/scatterlist.h>
 #include <linux/irq.h>
-#include <linux/export.h>
 #include <linux/notifier.h>

 #include <asm/setup.h>
diff --git a/arch/x86/platform/intel-mid/pwr.c b/arch/x86/platform/intel-mid/pwr.c
index cd7e0c71adde..77c0ff63ee28 100644
--- a/arch/x86/platform/intel-mid/pwr.c
+++ b/arch/x86/platform/intel-mid/pwr.c
@@ -20,7 +20,6 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>

diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index ee25b032c0b3..f97c11d3c1d2 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -32,6 +32,7 @@
 #include <asm/io.h>

 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/types.h>
diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index 40ae94db20d8..49af88f1deda 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -18,6 +18,7 @@
 #include <linux/capability.h>
 #include <linux/pm_qos.h>
 #include <linux/wait.h>
+#include <linux/export.h>

 #include <asm/iosf_mbi.h>

diff --git a/arch/x86/platform/scx200/scx200_32.c b/arch/x86/platform/scx200/scx200_32.c
index 80662b72035d..97386353b0f5 100644
--- a/arch/x86/platform/scx200/scx200_32.c
+++ b/arch/x86/platform/scx200/scx200_32.c
@@ -7,6 +7,7 @@

 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
index 81fc97a2a837..57070d9e1a56 100644
--- a/arch/x86/video/video-common.c
+++ b/arch/x86/video/video-common.c
@@ -7,6 +7,7 @@
  *
  */

+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/vgaarb.h>
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 942372e69b4d..7cd06bb3aa9f 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -19,6 +19,7 @@
 #include <linux/iommu.h>
 #include <linux/amd-iommu.h>
 #include <linux/nospec.h>
+#include <linux/export.h>

 #include <asm/sev.h>
 #include <asm/processor.h>
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2457d13c3f9e..e5bb81dc8497 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -12,6 +12,7 @@
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/printk.h>
 #include <linux/cpu.h>
 #include <linux/spinlock.h>
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 53282dc7d5ac..4b2b038a1ec8 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -2,6 +2,7 @@

 #include <linux/console.h>
 #include <linux/cpu.h>
+#include <linux/export.h>
 #include <linux/instrumentation.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index fe57ff85d004..4399a1796861 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -2,6 +2,7 @@

 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/export.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
 #include <linux/virtio_anchor.h>
diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index c4c479373249..da38470e6131 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0

 #include <linux/pfn.h>
+#include <linux/export.h>
 #include <asm/xen/page.h>
 #include <asm/xen/hypercall.h>
 #include <xen/interface/memory.h>

Signed-off-by: Zhenghan Cheng <your_email@example.com>
---
 arch/x86/coco/sev/core.c                  | 1 +
 arch/x86/crypto/aria_aesni_avx2_glue.c    | 1 +
 arch/x86/crypto/aria_aesni_avx_glue.c     | 1 +
 arch/x86/crypto/camellia_aesni_avx_glue.c | 1 +
 arch/x86/crypto/camellia_glue.c           | 1 +
 arch/x86/crypto/curve25519-x86_64.c       | 1 +
 arch/x86/crypto/serpent_avx_glue.c        | 1 +
 arch/x86/crypto/sm4_aesni_avx_glue.c      | 1 +
 arch/x86/crypto/twofish_glue.c            | 1 +
 arch/x86/crypto/twofish_glue_3way.c       | 1 +
 arch/x86/events/intel/core.c              | 1 -
 arch/x86/events/intel/lbr.c               | 1 +
 arch/x86/events/intel/pt.c                | 2 ++
 arch/x86/events/zhaoxin/core.c            | 1 -
 arch/x86/hyperv/hv_init.c                 | 1 +
 arch/x86/hyperv/irqdomain.c               | 1 +
 arch/x86/hyperv/ivm.c                     | 1 +
 arch/x86/hyperv/nested.c                  | 2 +-
 arch/x86/kernel/acpi/cppc.c               | 1 +
 arch/x86/kernel/alternative.c             | 1 +
 arch/x86/kernel/amd_node.c                | 1 +
 arch/x86/kernel/apic/apic_common.c        | 1 +
 arch/x86/kernel/apic/msi.c                | 1 +
 arch/x86/kernel/apic/vector.c             | 1 +
 arch/x86/kernel/cpu/acrn.c                | 1 +
 arch/x86/kernel/cpu/aperfmperf.c          | 1 +
 arch/x86/kernel/cpu/bugs.c                | 1 +
 arch/x86/kernel/cpu/bus_lock.c            | 1 +
 arch/x86/kernel/cpu/mce/amd.c             | 1 +
 arch/x86/kernel/cpu/mce/dev-mcelog.c      | 1 +
 arch/x86/kernel/cpu/microcode/intel.c     | 1 +
 arch/x86/kernel/cpu/sgx/main.c            | 1 +
 arch/x86/kernel/cpu/sgx/virt.c            | 1 +
 arch/x86/kernel/cpu/topology.c            | 1 +
 arch/x86/kernel/cpu/topology_common.c     | 1 +
 arch/x86/kernel/crash.c                   | 1 -
 arch/x86/kernel/devicetree.c              | 1 -
 arch/x86/kernel/dumpstack_32.c            | 1 -
 arch/x86/kernel/dumpstack_64.c            | 1 -
 arch/x86/kernel/e820.c                    | 1 +
 arch/x86/kernel/early-quirks.c            | 1 +
 arch/x86/kernel/fpu/core.c                | 1 +
 arch/x86/kernel/fpu/xstate.c              | 1 +
 arch/x86/kernel/head64.c                  | 1 +
 arch/x86/kernel/i8259.c                   | 1 +
 arch/x86/kernel/kvm.c                     | 1 +
 arch/x86/kernel/paravirt-spinlocks.c      | 1 -
 arch/x86/kernel/ptrace.c                  | 1 -
 arch/x86/kernel/pvclock.c                 | 1 +
 arch/x86/kernel/quirks.c                  | 1 +
 arch/x86/kernel/setup.c                   | 1 +
 arch/x86/kernel/stacktrace.c              | 1 -
 arch/x86/kernel/static_call.c             | 1 +
 arch/x86/kernel/tboot.c                   | 1 -
 arch/x86/kernel/traps.c                   | 1 -
 arch/x86/kernel/unwind_frame.c            | 1 +
 arch/x86/kernel/unwind_guess.c            | 1 +
 arch/x86/kernel/unwind_orc.c              | 1 +
 arch/x86/kvm/hyperv.c                     | 1 +
 arch/x86/kvm/ioapic.c                     | 1 -
 arch/x86/kvm/kvm_onhyperv.c               | 1 +
 arch/x86/kvm/mmu/page_track.c             | 1 +
 arch/x86/kvm/mmu/spte.c                   | 1 +
 arch/x86/kvm/mmu/tdp_mmu.c                | 1 +
 arch/x86/kvm/pmu.c                        | 1 +
 arch/x86/kvm/smm.c                        | 1 +
 arch/x86/lib/atomic64_32.c                | 1 -
 arch/x86/lib/crc-t10dif.c                 | 1 +
 arch/x86/lib/crc32.c                      | 1 +
 arch/x86/lib/crc64.c                      | 1 +
 arch/x86/lib/crypto/blake2s-glue.c        | 1 +
 arch/x86/lib/crypto/chacha_glue.c         | 1 +
 arch/x86/lib/crypto/poly1305_glue.c       | 1 +
 arch/x86/lib/crypto/sha256.c              | 1 +
 arch/x86/lib/iomem.c                      | 1 +
 arch/x86/mm/cpu_entry_area.c              | 1 +
 arch/x86/mm/dump_pagetables.c             | 1 +
 arch/x86/mm/init.c                        | 1 +
 arch/x86/mm/init_32.c                     | 1 +
 arch/x86/mm/init_64.c                     | 1 +
 arch/x86/mm/ioremap.c                     | 1 +
 arch/x86/mm/mem_encrypt_amd.c             | 1 +
 arch/x86/mm/mmio-mod.c                    | 1 +
 arch/x86/mm/numa.c                        | 1 +
 arch/x86/mm/pat/memtype.c                 | 1 +
 arch/x86/mm/pat/set_memory.c              | 1 +
 arch/x86/mm/pgtable.c                     | 1 +
 arch/x86/mm/pgtable_32.c                  | 1 +
 arch/x86/pci/pcbios.c                     | 1 +
 arch/x86/platform/efi/efi.c               | 1 -
 arch/x86/platform/efi/efi_64.c            | 1 -
 arch/x86/platform/efi/quirks.c            | 1 +
 arch/x86/platform/intel-mid/intel-mid.c   | 1 -
 arch/x86/platform/intel-mid/pwr.c         | 1 -
 arch/x86/platform/intel-quark/imr.c       | 1 +
 arch/x86/platform/intel/iosf_mbi.c        | 1 +
 arch/x86/platform/scx200/scx200_32.c      | 1 +
 arch/x86/video/video-common.c             | 1 +
 arch/x86/virt/svm/sev.c                   | 1 +
 arch/x86/virt/vmx/tdx/tdx.c               | 1 +
 arch/x86/xen/enlighten.c                  | 1 +
 arch/x86/xen/enlighten_hvm.c              | 1 +
 arch/x86/xen/mmu.c                        | 1 +
 103 files changed, 87 insertions(+), 18 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b6db4e0b936b..773b24859037 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/psp-sev.h>
 #include <linux/dmi.h>
+#include <linux/export.h>
 #include <uapi/linux/sev-guest.h>
 #include <crypto/gcm.h>
 
diff --git a/arch/x86/crypto/aria_aesni_avx2_glue.c b/arch/x86/crypto/aria_aesni_avx2_glue.c
index b4bddcd58457..007b250f774c 100644
--- a/arch/x86/crypto/aria_aesni_avx2_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx2_glue.c
@@ -9,6 +9,7 @@
 #include <crypto/aria.h>
 #include <linux/crypto.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/types.h>
 
diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index ab9b38d05332..4c88ef4eba82 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -9,6 +9,7 @@
 #include <crypto/aria.h>
 #include <linux/crypto.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/types.h>
 
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index a7d162388142..5c321f255eb7 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -8,6 +8,7 @@
 #include <crypto/algapi.h>
 #include <linux/crypto.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/types.h>
 
diff --git a/arch/x86/crypto/camellia_glue.c b/arch/x86/crypto/camellia_glue.c
index 3bd37d664121..cbede120e5f2 100644
--- a/arch/x86/crypto/camellia_glue.c
+++ b/arch/x86/crypto/camellia_glue.c
@@ -10,6 +10,7 @@
 
 #include <linux/unaligned.h>
 #include <linux/crypto.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index dcfc0de333de..86d4c4d85487 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -8,6 +8,7 @@
 #include <crypto/internal/kpp.h>
 
 #include <linux/types.h>
+#include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index e640abc1cb8a..9c8b3a335d5c 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/crypto.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <crypto/algapi.h>
 #include <crypto/serpent.h>
 
diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
index 72867fc49ce8..88caf418a06f 100644
--- a/arch/x86/crypto/sm4_aesni_avx_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx_glue.c
@@ -11,6 +11,7 @@
 #include <asm/fpu/api.h>
 #include <linux/module.h>
 #include <linux/crypto.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <crypto/internal/skcipher.h>
 #include <crypto/sm4.h>
diff --git a/arch/x86/crypto/twofish_glue.c b/arch/x86/crypto/twofish_glue.c
index 4c67184dc573..8e9906d36902 100644
--- a/arch/x86/crypto/twofish_glue.c
+++ b/arch/x86/crypto/twofish_glue.c
@@ -40,6 +40,7 @@
 
 #include <crypto/algapi.h>
 #include <crypto/twofish.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 1a1ecfa7f72a..8ad77725bf60 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -9,6 +9,7 @@
 #include <crypto/algapi.h>
 #include <crypto/twofish.h>
 #include <linux/crypto.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 741b229f0718..04cf3d1019d9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/export.h>
 #include <linux/nmi.h>
 #include <linux/kvm_host.h>
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 7aa59966e7c3..10619c767602 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/perf_event.h>
+#include <linux/export.h>
 #include <linux/types.h>
 
 #include <asm/cpu_device_id.h>
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index e8cf29d2b10c..9c772c89b623 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -17,6 +17,8 @@
 #include <linux/limits.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/export.h>
+
 
 #include <asm/cpuid/api.h>
 #include <asm/perf_event.h>
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 4bdfcf091200..67fa000cf372 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -9,7 +9,6 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/export.h>
 #include <linux/nmi.h>
 
 #include <asm/cpufeature.h>
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3d1d3547095a..3bd18521cd46 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -29,6 +29,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/cpuhotplug.h>
 #include <linux/syscore_ops.h>
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 31f0d29cbc5e..f7627bc8fe49 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -10,6 +10,7 @@
 
 #include <linux/pci.h>
 #include <linux/irq.h>
+#include <linux/export.h>
 #include <asm/mshyperv.h>
 
 static int hv_map_interrupt(union hv_device_id device_id, bool level,
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index e93a2f488ff7..d9c0b3064222 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/export.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index 1083dc8646f9..1413bfe40ea9 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -9,7 +9,7 @@
  */
 #define pr_fmt(fmt)  "Hyper-V: " fmt
 
-
+#include <linux/export.h>
 #include <linux/types.h>
 #include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 7047124490f6..e943947ccb3d 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/export.h>
 
 #include <acpi/cppc_acpi.h>
 #include <asm/msr.h>
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ecfe7b497cad..882d99b1f4fb 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -6,6 +6,7 @@
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
 #include <linux/execmem.h>
+#include <linux/export.h>
 
 #include <asm/text-patching.h>
 #include <asm/insn.h>
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index a40176b62eb5..55118dd87116 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <asm/amd/node.h>
 
 /*
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index 9ef3be866832..f7e1cbb70029 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -3,6 +3,7 @@
  *
  * SPDX-License-Identifier: GPL-2.0
  */
+#include <linux/export.h>
 #include <linux/irq.h>
 #include <asm/apic.h>
 
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 66bc5d3e79db..3f133e24a38e 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -14,6 +14,7 @@
 #include <linux/dmar.h>
 #include <linux/hpet.h>
 #include <linux/msi.h>
+#include <linux/export.h>
 #include <asm/irqdomain.h>
 #include <asm/hpet.h>
 #include <asm/hw_irq.h>
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 93069b13d3af..f35c9184ac30 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/compiler.h>
 #include <linux/slab.h>
+#include <linux/export.h>
 #include <asm/irqdomain.h>
 #include <asm/hw_irq.h>
 #include <asm/traps.h>
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 2c5b51aad91a..8f181da43b20 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/export.h>
 
 #include <asm/acrn.h>
 #include <asm/apic.h>
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index a315b0627dfb..e441400106f8 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -8,6 +8,7 @@
  */
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/ktime.h>
 #include <linux/math64.h>
 #include <linux/percpu.h>
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7f94e6a5497d..fd136016ff8f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -16,6 +16,7 @@
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
+#include <linux/export.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 981f8b1f0792..68105db4dc66 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -6,6 +6,7 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/cpuhotplug.h>
+#include <linux/export.h>
 #include <asm/cpu_device_id.h>
 #include <asm/cmdline.h>
 #include <asm/traps.h>
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9d852c3b2cb5..9b335a939576 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/kobject.h>
+#include <linux/export.h>
 #include <linux/percpu.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 8d023239ce18..4657fdb4810e 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/miscdevice.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/poll.h>
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 371ca6eac00e..50b17579ca97 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -14,6 +14,7 @@
 #include <linux/earlycpio.h>
 #include <linux/firmware.h>
 #include <linux/uaccess.h>
+#include <linux/export.h>
 #include <linux/initrd.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 2de01b379aa3..cb9eade755ee 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
 
+#include <linux/export.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
 #include <linux/highmem.h>
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 7aaa3652e31d..15ce2a05c260 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -5,6 +5,7 @@
  * Copyright(c) 2021 Intel Corporation.
  */
 
+#include <linux/export.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index e35ccdc84910..30df9f9c4b0d 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -23,6 +23,7 @@
  */
 #define pr_fmt(fmt) "CPU topo: " fmt
 #include <linux/cpu.h>
+#include <linux/export.h>
 
 #include <xen/xen.h>
 
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index b5a5e1411469..fa841c8b70df 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/cpu.h>
+#include <linux/export.h>
 
 #include <xen/xen.h>
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index bcb534688dfe..3dbabdfe9649 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -21,7 +21,6 @@
 #include <linux/delay.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
-#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index dd8748c45529..2b72ca27eaac 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -3,7 +3,6 @@
  * Architecture specific OF callbacks.
  */
 #include <linux/acpi.h>
-#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 722fd712e1cf..16f5a7984a46 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -9,7 +9,6 @@
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 #include <linux/kdebug.h>
-#include <linux/export.h>
 #include <linux/ptrace.h>
 #include <linux/kexec.h>
 #include <linux/sysfs.h>
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 6c5defd6569a..4975c5546ba9 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -9,7 +9,6 @@
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 #include <linux/kdebug.h>
-#include <linux/export.h>
 #include <linux/ptrace.h>
 #include <linux/kexec.h>
 #include <linux/sysfs.h>
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c3acbd26408b..9edbb4ebac31 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -12,6 +12,7 @@
 #include <linux/crash_dump.h>
 #include <linux/memblock.h>
 #include <linux/suspend.h>
+#include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/firmware-map.h>
 #include <linux/sort.h>
diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 6b6f32f40cbe..097721a95a8d 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/pci_ids.h>
 #include <linux/bcma/bcma.h>
 #include <linux/bcma/bcma_regs.h>
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ea138583dd92..2e4e37bf9d8f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -17,6 +17,7 @@
 
 #include <uapi/asm/kvm.h>
 
+#include <linux/export.h>
 #include <linux/hardirq.h>
 #include <linux/pkeys.h>
 #include <linux/vmalloc.h>
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9aa9ac8399ae..6e1dcafc457d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,7 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/export.h>
 #include <linux/mman.h>
 #include <linux/nospec.h>
 #include <linux/pkeys.h>
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 533fcf5636fc..b58c6128554f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -19,6 +19,7 @@
 #include <linux/memblock.h>
 #include <linux/cc_platform.h>
 #include <linux/pgtable.h>
+#include <linux/export.h>
 
 #include <asm/asm.h>
 #include <asm/page_64.h>
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 2bade73f49e3..212f5e9959e1 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/linkage.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/ioport.h>
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 921c1c783bc1..37a94e2a2d46 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -29,6 +29,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/cc_platform.h>
 #include <linux/efi.h>
+#include <linux/export.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 9e1ea99ad9df..7f131a15ac9e 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -4,7 +4,6 @@
  * compiled in a FTRACE-compatible way.
  */
 #include <linux/spinlock.h>
-#include <linux/export.h>
 #include <linux/jump_label.h>
 
 #include <asm/paravirt.h>
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 095f04bdabdc..dfc8ebc8b0f8 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -22,7 +22,6 @@
 #include <linux/perf_event.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/rcupdate.h>
-#include <linux/export.h>
 #include <linux/context_tracking.h>
 #include <linux/nospec.h>
 
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index b3f81379c2fc..96d944e26dbe 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -11,6 +11,7 @@
 #include <linux/gfp.h>
 #include <linux/memblock.h>
 #include <linux/nmi.h>
+#include <linux/export.h>
 
 #include <asm/fixmap.h>
 #include <asm/pvclock.h>
diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index a92f18db9610..221014f3d306 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -5,6 +5,7 @@
 #include <linux/dmi.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
+#include <linux/export.h>
 
 #include <asm/hpet.h>
 #include <asm/setup.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index fb27be697128..ea43a022f9a8 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -11,6 +11,7 @@
 #include <linux/crash_dump.h>
 #include <linux/dma-map-ops.h>
 #include <linux/efi.h>
+#include <linux/export.h>
 #include <linux/hugetlb.h>
 #include <linux/ima.h>
 #include <linux/init_ohci1394_dma.h>
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index ee117fcf46ed..ddce014f29b2 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -7,7 +7,6 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
-#include <linux/export.h>
 #include <linux/uaccess.h>
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 378c388d1b31..3ab922966ab4 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/static_call.h>
+#include <linux/export.h>
 #include <linux/memory.h>
 #include <linux/bug.h>
 #include <asm/text-patching.h>
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 46b8f1f16676..b6a1bb741ebd 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -8,7 +8,6 @@
 
 #include <linux/init_task.h>
 #include <linux/spinlock.h>
-#include <linux/export.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/init.h>
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c5c897a86418..5a038f66271b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -22,7 +22,6 @@
 #include <linux/kdebug.h>
 #include <linux/kgdb.h>
 #include <linux/kernel.h>
-#include <linux/export.h>
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
 #include <linux/string.h>
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index d8ba93778ae3..f3b893c0e5e7 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -3,6 +3,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/interrupt.h>
+#include <linux/export.h>
 #include <asm/sections.h>
 #include <asm/ptrace.h>
 #include <asm/bitops.h>
diff --git a/arch/x86/kernel/unwind_guess.c b/arch/x86/kernel/unwind_guess.c
index 884d68a6e714..86813ae9d57c 100644
--- a/arch/x86/kernel/unwind_guess.c
+++ b/arch/x86/kernel/unwind_guess.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/sched.h>
 #include <linux/ftrace.h>
+#include <linux/export.h>
 #include <asm/ptrace.h>
 #include <asm/bitops.h>
 #include <asm/stacktrace.h>
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 977ee75e047c..ec0cd3c54616 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/objtool.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <asm/ptrace.h>
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 24f0318c50d7..09f9de4555dd 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -33,6 +33,7 @@
 #include <linux/sched/cputime.h>
 #include <linux/spinlock.h>
 #include <linux/eventfd.h>
+#include <linux/export.h>
 
 #include <asm/apicdef.h>
 #include <asm/mshyperv.h>
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 45dae2d5d2f1..bfa87e74fe18 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -36,7 +36,6 @@
 #include <linux/hrtimer.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include <linux/export.h>
 #include <linux/nospec.h>
 #include <asm/processor.h>
 #include <asm/page.h>
diff --git a/arch/x86/kvm/kvm_onhyperv.c b/arch/x86/kvm/kvm_onhyperv.c
index ded0bd688c65..73a97e1dcdbd 100644
--- a/arch/x86/kvm/kvm_onhyperv.c
+++ b/arch/x86/kvm/kvm_onhyperv.c
@@ -4,6 +4,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/export.h>
 #include <linux/kvm_host.h>
 #include <asm/mshyperv.h>
 
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 1b17b12393a8..2c407d7edd09 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -15,6 +15,7 @@
 #include <linux/lockdep.h>
 #include <linux/kvm_host.h>
 #include <linux/rculist.h>
+#include <linux/export.h>
 
 #include "mmu.h"
 #include "mmu_internal.h"
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index cfce03d8f123..217a802e86f9 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -9,6 +9,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/export.h>
 #include <linux/kvm_host.h>
 #include "mmu.h"
 #include "mmu_internal.h"
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7f3d7229b2c1..1df1726f506c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -8,6 +8,7 @@
 #include "tdp_mmu.h"
 #include "spte.h"
 
+#include <linux/export.h>
 #include <asm/cmpxchg.h>
 #include <trace/events/kvm.h>
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 75e9cfc689f8..308a6ae502e3 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -16,6 +16,7 @@
 #include <linux/perf_event.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/export.h>
 #include <asm/perf_event.h>
 #include <asm/cpu_device_id.h>
 #include "x86.h"
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 9864c057187d..4b13a6346f06 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
+#include <linux/export.h>
 #include "x86.h"
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
diff --git a/arch/x86/lib/atomic64_32.c b/arch/x86/lib/atomic64_32.c
index a0b4a350daa7..04a6901a8969 100644
--- a/arch/x86/lib/atomic64_32.c
+++ b/arch/x86/lib/atomic64_32.c
@@ -1,4 +1,3 @@
 #define ATOMIC64_EXPORT EXPORT_SYMBOL
 
-#include <linux/export.h>
 #include <linux/atomic.h>
diff --git a/arch/x86/lib/crc-t10dif.c b/arch/x86/lib/crc-t10dif.c
index db7ce59c31ac..c8c2108675cd 100644
--- a/arch/x86/lib/crc-t10dif.c
+++ b/arch/x86/lib/crc-t10dif.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/crc-t10dif.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include "crc-pclmul-template.h"
 
diff --git a/arch/x86/lib/crc32.c b/arch/x86/lib/crc32.c
index d09343e2cea9..21e84e3c94eb 100644
--- a/arch/x86/lib/crc32.c
+++ b/arch/x86/lib/crc32.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/crc32.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include "crc-pclmul-template.h"
 
diff --git a/arch/x86/lib/crc64.c b/arch/x86/lib/crc64.c
index 351a09f5813e..6c1a1beb5c97 100644
--- a/arch/x86/lib/crc64.c
+++ b/arch/x86/lib/crc64.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/crc64.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include "crc-pclmul-template.h"
 
diff --git a/arch/x86/lib/crypto/blake2s-glue.c b/arch/x86/lib/crypto/blake2s-glue.c
index adc296cd17c9..e65cebbdc043 100644
--- a/arch/x86/lib/crypto/blake2s-glue.c
+++ b/arch/x86/lib/crypto/blake2s-glue.c
@@ -8,6 +8,7 @@
 #include <asm/processor.h>
 #include <asm/simd.h>
 #include <crypto/internal/blake2s.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
diff --git a/arch/x86/lib/crypto/chacha_glue.c b/arch/x86/lib/crypto/chacha_glue.c
index 10b2c945f541..7e3bf4b091f1 100644
--- a/arch/x86/lib/crypto/chacha_glue.c
+++ b/arch/x86/lib/crypto/chacha_glue.c
@@ -7,6 +7,7 @@
 
 #include <asm/simd.h>
 #include <crypto/chacha.h>
+#include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/arch/x86/lib/crypto/poly1305_glue.c b/arch/x86/lib/crypto/poly1305_glue.c
index b7e78a583e07..c2bc5b831551 100644
--- a/arch/x86/lib/crypto/poly1305_glue.c
+++ b/arch/x86/lib/crypto/poly1305_glue.c
@@ -6,6 +6,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/fpu/api.h>
 #include <crypto/internal/poly1305.h>
+#include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/arch/x86/lib/crypto/sha256.c b/arch/x86/lib/crypto/sha256.c
index 80380f8fdcee..46d5d174e821 100644
--- a/arch/x86/lib/crypto/sha256.c
+++ b/arch/x86/lib/crypto/sha256.c
@@ -6,6 +6,7 @@
  */
 #include <asm/fpu/api.h>
 #include <crypto/internal/sha2.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/static_call.h>
diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index c20e04764edc..20f90c60e34e 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -1,5 +1,6 @@
 #include <linux/string.h>
 #include <linux/module.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kmsan-checks.h>
 
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 575f863f3c75..2ffd4628643b 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -5,6 +5,7 @@
 #include <linux/kallsyms.h>
 #include <linux/kcore.h>
 #include <linux/pgtable.h>
+#include <linux/export.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/fixmap.h>
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index a4700ef6eb64..90df00f4ef88 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/init.h>
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7456df985d96..00c7088c5835 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -8,6 +8,7 @@
 #include <linux/kmemleak.h>
 #include <linux/sched/task.h>
 #include <linux/execmem.h>
+#include <linux/export.h>
 
 #include <asm/set_memory.h>
 #include <asm/cpu_device_id.h>
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 607d6a2e66e2..633887c582af 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -31,6 +31,7 @@
 #include <linux/cpumask.h>
 #include <linux/gfp.h>
 #include <linux/execmem.h>
+#include <linux/export.h>
 
 #include <asm/asm.h>
 #include <asm/bios_ebda.h>
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ee66fae9ebcc..e3bd8adea411 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -35,6 +35,7 @@
 #include <linux/kcore.h>
 #include <linux/bootmem_info.h>
 #include <linux/execmem.h>
+#include <linux/export.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 12c8180ca1ba..4e2101e637ba 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -17,6 +17,7 @@
 #include <linux/mmiotrace.h>
 #include <linux/cc_platform.h>
 #include <linux/efi.h>
+#include <linux/export.h>
 #include <linux/pgtable.h>
 #include <linux/kmsan.h>
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index faf3a13fb6ba..cb069276f756 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/cc_platform.h>
+#include <linux/export.h>
 
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index c3317f0650d8..7555c0ef2cf3 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -21,6 +21,7 @@
 #include <linux/atomic.h>
 #include <linux/percpu.h>
 #include <linux/cpu.h>
+#include <linux/export.h>
 
 #include "pf_in.h"
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index c24890c40138..5e3ac16ceea5 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -14,6 +14,7 @@
 #include <linux/topology.h>
 #include <linux/sort.h>
 #include <linux/numa_memblks.h>
+#include <linux/export.h>
 
 #include <asm/e820/api.h>
 #include <asm/proto.h>
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 2e7923844afe..3eeee5b2384a 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -34,6 +34,7 @@
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/pfn_t.h>
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 46edc11726b7..89973d5e4327 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -22,6 +22,7 @@
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
 #include <linux/memregion.h>
+#include <linux/export.h>
 
 #include <asm/e820/api.h>
 #include <asm/processor.h>
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ddf248c3ee7d..92ee7b5cd93b 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm.h>
 #include <linux/gfp.h>
+#include <linux/export.h>
 #include <linux/hugetlb.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
diff --git a/arch/x86/mm/pgtable_32.c b/arch/x86/mm/pgtable_32.c
index c234634e26ba..2acb05736cf1 100644
--- a/arch/x86/mm/pgtable_32.c
+++ b/arch/x86/mm/pgtable_32.c
@@ -9,6 +9,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
+#include <linux/export.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/fixmap.h>
diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 244c643bb0b5..1956cb58e281 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -5,6 +5,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 463b784499a8..6288436d8ec3 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -35,7 +35,6 @@
 #include <linux/init.h>
 #include <linux/efi.h>
 #include <linux/efi-bgrt.h>
-#include <linux/export.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e7e8f77f77f8..627d084c344d 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -27,7 +27,6 @@
 #include <linux/ioport.h>
 #include <linux/mc146818rtc.h>
 #include <linux/efi.h>
-#include <linux/export.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 553f330198f2..4119b2f693bc 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -7,6 +7,7 @@
 #include <linux/time.h>
 #include <linux/types.h>
 #include <linux/efi.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/acpi.h>
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index a8e75f8c14fd..a877e52cb38e 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -15,7 +15,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/scatterlist.h>
 #include <linux/irq.h>
-#include <linux/export.h>
 #include <linux/notifier.h>
 
 #include <asm/setup.h>
diff --git a/arch/x86/platform/intel-mid/pwr.c b/arch/x86/platform/intel-mid/pwr.c
index cd7e0c71adde..77c0ff63ee28 100644
--- a/arch/x86/platform/intel-mid/pwr.c
+++ b/arch/x86/platform/intel-mid/pwr.c
@@ -20,7 +20,6 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 
diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index ee25b032c0b3..f97c11d3c1d2 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -32,6 +32,7 @@
 #include <asm/io.h>
 
 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/types.h>
diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index 40ae94db20d8..49af88f1deda 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -18,6 +18,7 @@
 #include <linux/capability.h>
 #include <linux/pm_qos.h>
 #include <linux/wait.h>
+#include <linux/export.h>
 
 #include <asm/iosf_mbi.h>
 
diff --git a/arch/x86/platform/scx200/scx200_32.c b/arch/x86/platform/scx200/scx200_32.c
index 80662b72035d..97386353b0f5 100644
--- a/arch/x86/platform/scx200/scx200_32.c
+++ b/arch/x86/platform/scx200/scx200_32.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
index 81fc97a2a837..57070d9e1a56 100644
--- a/arch/x86/video/video-common.c
+++ b/arch/x86/video/video-common.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/vgaarb.h>
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 942372e69b4d..7cd06bb3aa9f 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -19,6 +19,7 @@
 #include <linux/iommu.h>
 #include <linux/amd-iommu.h>
 #include <linux/nospec.h>
+#include <linux/export.h>
 
 #include <asm/sev.h>
 #include <asm/processor.h>
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2457d13c3f9e..e5bb81dc8497 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -12,6 +12,7 @@
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/printk.h>
 #include <linux/cpu.h>
 #include <linux/spinlock.h>
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 53282dc7d5ac..4b2b038a1ec8 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -2,6 +2,7 @@
 
 #include <linux/console.h>
 #include <linux/cpu.h>
+#include <linux/export.h>
 #include <linux/instrumentation.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index fe57ff85d004..4399a1796861 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -2,6 +2,7 @@
 
 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/export.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
 #include <linux/virtio_anchor.h>
diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index c4c479373249..da38470e6131 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/pfn.h>
+#include <linux/export.h>
 #include <asm/xen/page.h>
 #include <asm/xen/hypercall.h>
 #include <xen/interface/memory.h>
-- 
2.20.1


