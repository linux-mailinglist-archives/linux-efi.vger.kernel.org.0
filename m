Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338E4232839
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jul 2020 01:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgG2XhS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jul 2020 19:37:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22290 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgG2Xgz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jul 2020 19:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596065815; x=1627601815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/aLmMoaf+R1cfTR4Mi4doOLt0MJCtDnvFjCl4cVqNk=;
  b=ZwJJAX47S/JMpfxMjORre7gBBOLM/av53Wg3HMlHXbVOSUfNGy3u+sda
   krLrtwzqyith94Zu9K9+BnPcRbXia/lcQsZOh10EBjvQvLBW0vqXrdE6U
   GKHKy8BKdpc7M5TTcyWi1yqYhkUfx37QkNbF/Snt1D6UCCNg/KNHrxquD
   H3w+cMTlpV13IIfD7IHSrHUf3L4UCEM7DwXuMv4aWlupXBOS8UawmShAO
   ACR13BtfIfU52b5Au8iU+ypKlXhXYHgcMcKIj22PDErJRzIF8WQbnt0Ed
   DNQrZB6Z04+KkDZZzZmUKaHhb3dW77e5vqe2T1ICZRD0G912UoX0o+59h
   A==;
IronPort-SDR: bHK89hTRJeeke1cx75lo8+BvuYK7+81yDjLxoz8anDSa9bCxzBjJUdK4LDePAQi8qSO2waZRpM
 yPNBQXqEIh5//tDfHiSHB8WOR+d+MhJK3iLcQYIssBibmQOMCPUoMGlR38/GUQLW+FSS6JiQOf
 YKOC1Fsojdcw5L82jq19uiIxjVGQ+/E6VvCsDygRd6b/N3FxUy4OQqFk91gvHWUhIQeH1JzVEt
 nFLQwpLVR+556IK+IAl5dhTMY1YZG2P4Wvm/Fzpd9lLulq/jk4qi1txAHa9I3amJlPPOWcgvIE
 9fk=
X-IronPort-AV: E=Sophos;i="5.75,412,1589212800"; 
   d="scan'208";a="144951804"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2020 07:36:55 +0800
IronPort-SDR: 57K1AXauuRMMA9TXuY9tt0RsZFWhKhpdPqIkZpNTerUaoxmztpghRLtRb4QRyavutYIns1ucNw
 gpCUxbf/0I2CbcqL+Me2AfRE02kW8Jww8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 16:25:02 -0700
IronPort-SDR: jl9KKWRuX6o+x8EQ503ka+/veCrEXiFcusdtj+sSoVDP1zToRbSi7am3W7Eg9UsAaTXR81Cm24
 ty0Zbev3UtFA==
WDCIronportException: Internal
Received: from jpf009043.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.210])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jul 2020 16:36:55 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yash Shah <yash.shah@sifive.com>, Zong Li <zong.li@sifive.com>
Subject: [RFT PATCH v4 4/9] include: pe.h: Add RISC-V related PE definition
Date:   Wed, 29 Jul 2020 16:36:30 -0700
Message-Id: <20200729233635.14406-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200729233635.14406-1-atish.patra@wdc.com>
References: <20200729233635.14406-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Define RISC-V related machine types.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Link: https://lore.kernel.org/r/20200415195422.19866-3-atish.patra@wdc.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/pe.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pe.h b/include/linux/pe.h
index 8ad71d763a77..daf09ffffe38 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -55,6 +55,9 @@
 #define	IMAGE_FILE_MACHINE_POWERPC	0x01f0
 #define	IMAGE_FILE_MACHINE_POWERPCFP	0x01f1
 #define	IMAGE_FILE_MACHINE_R4000	0x0166
+#define	IMAGE_FILE_MACHINE_RISCV32	0x5032
+#define	IMAGE_FILE_MACHINE_RISCV64	0x5064
+#define	IMAGE_FILE_MACHINE_RISCV128	0x5128
 #define	IMAGE_FILE_MACHINE_SH3		0x01a2
 #define	IMAGE_FILE_MACHINE_SH3DSP	0x01a3
 #define	IMAGE_FILE_MACHINE_SH3E		0x01a4
-- 
2.24.0

