Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53B172B15
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 23:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgB0W0v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 17:26:51 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16827 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbgB0W0v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Feb 2020 17:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582842411; x=1614378411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qT9c7eXt7ksLkS8LTzuMlCHOyGGyAUacpIVqI65fctQ=;
  b=cK34gJbyzloEgJyQoQvkxp33M1W0xL6nw3Yr3cHtNSvgEQFr8ASfLCsw
   VUuU7fCeSjOOOGYqm5vqkd+wEpnKonQiTZzTqh0dpoi3j6tlcD4wvz3A6
   DX5dZPQJ6iBCqXN495Ja9wZ81vTgUovgI/1CrEKQpVmrMolMkLx4cS4qe
   AjsvFPqY8tQsVqWeKCJ6v7XtIiLXHiAZ9D+hFkLluQPrmitDfnT9GOgyH
   robskSHN6yIt2kNp5xyDr//o0w3CUen3a8vHA3394Ta3xm2ZQgVWujpKY
   f56z2wIW0jsVimKeEuCI+DxEzMSNcuwHsfIViVaEYsZ8mmt4A1lmbJk9C
   w==;
IronPort-SDR: z7qAPT0Z71At0/MYJQnCsTD1jKQwBMA2Dhc5Ll7d1qpwlfZ824AAeS7Cc5w8iqa2CphIlV6Nmc
 sF8TSu6SL5lui9EqzcsQtAL6FpdH2fWqBWOTpVMsUNfBYw+s5XnLgYNW+LDGwpxcP+VlcMEVim
 q7kmlaYuj60dPoRhWgg/nP/BiGso4m+bpmPip+UNmw4MSttMQpZI6Kr+E7QeBXcxnw7Mtwu46k
 ptyOK5NQKeWP2gLW8+Q8KOZ4sYp5duqLTo6ajyAP3sa/JYyNY4h5IZxXQP61N4Oh4hgsbPB2cB
 0qo=
X-IronPort-AV: E=Sophos;i="5.70,493,1574092800"; 
   d="scan'208";a="131459851"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2020 06:26:51 +0800
IronPort-SDR: gxib4UHiJb/eMA4TsQzP4AjtM0YkMuGD13uO4MyIlSPC1mhJL3mLxymDqiGS1MEgCvmtEZ89B/
 hTMZN2wowECI2+VOrzzZO9n5SAF39cyRgrnS9p4kTJadZuNlPn4XFiphNJk20hEzZeKOzDW0ON
 DXt5GfJmx5X/b/rbXCF/Pi9nNq3/hF4D8FwU2mhgvv/yeu98SeRRq87HZF6kzJxujzk0IggyBe
 90JaGviQ+eRcX9pr1DDLs6u1xZOKI83HNlbg4nhWeA7KgAweWqB1d5jmWDAqdO0zrMdqNuEJln
 rsvfDVGjTNxJe+3S+BaEPAPL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:19:13 -0800
IronPort-SDR: Xlu5k3vIok+8Q2sXn3fXcSfzEcT3N+zeXLWP2I3gx6u97u9rC/m5SLI7thhq3D5E0zFJuFq/wd
 3X9QzHoTqJ5RKs07wtgL/FfdFEFvqdMRi0tGoLhBNaW3IYXhg5hAa1+13rc9YJ8N+H+L/9ag72
 0y429qordRATXOLpQkiVvOfnX4a9cV4wRXhng58/8qRwTjqlqegwFn1P0wtku1IlXlcfbCkQht
 c5kr6PGJOFNqFVi/FL8f0le4x6oJwiK9WWVnpd7CAquJl7BPVtZoYiKMmpTkVd5dKzdkzfpWUy
 lQk=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Feb 2020 14:26:50 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mao Han <han_mao@c-sky.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Alexander Graf <agraf@csgraf.de>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "Chang, Abner (HPS SW/FW Technologist)" <abner.chang@hpe.com>,
        daniel.schaefer@hpe.com
Subject: [v1 PATCH 2/5] include: pe.h: Add RISC-V related PE definition
Date:   Thu, 27 Feb 2020 14:26:41 -0800
Message-Id: <20200227222644.9468-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200227222644.9468-1-atish.patra@wdc.com>
References: <20200227222644.9468-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Define RISC-V related machine types.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
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

