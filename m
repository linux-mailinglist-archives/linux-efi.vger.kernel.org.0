Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E6C1AB22A
	for <lists+linux-efi@lfdr.de>; Wed, 15 Apr 2020 21:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634657AbgDOTzG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 15:55:06 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22140 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406336AbgDOTyn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 15:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586980482; x=1618516482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qT9c7eXt7ksLkS8LTzuMlCHOyGGyAUacpIVqI65fctQ=;
  b=QtWKMFFZvshehjkCuXOkhVK2vjfM69CY0jQLwQMUosceq5koYKpbDWs2
   sT+nYnxKY0mKvxbo57QLKwtvJRGVvXkqQMPDzUkDEphBCUG7D2rsdhrl+
   0fZuUFXBy1i5rVD7JYr7xVZho94oJ4r8T+oMat3CGye9oDN+s5Ia5Y4fa
   T4cmSBU1sCSseShi9FuiOXbMZuLD03E4eIyklejO4sFR3Bn3NQAj0VIaR
   79GylVooOWlUcXBQAQJUU52HDejd+DVlw6C6yjTUknMElndmMoTXe4DES
   h7w2kDLOLE3IyaIcPXeVfy6nArtoRJKXC+HESoYoD86yl5UGn4iZpdKAn
   g==;
IronPort-SDR: 51fIwTWZrPDIWI4I2/8o84TWcu6c475mmQHC0B350yZlu9G6SaQqtgW4wCNSzik20LDVFG0wMC
 uOjhdY4faXo7SaS4cd7Zjy4PlnRxcq4fJdZ39hgwViJzxiuJ3ylnIk8jMXSKTRIqHFxFSgOoql
 a6ETLOHtHVYHwVfEEU/BfaM1sKLttjS5ryIVL1mWWGXhXwVf2orCFOD2mIg9uNN0NIUqt5Y/gd
 YLj60Gh8e3XidA9Bmv3JtEFogv91ulh9aU5r2H79aXO1lMOyU2EAPgAqhrm8iGUKB1/GB/crdD
 Zkk=
X-IronPort-AV: E=Sophos;i="5.72,388,1580745600"; 
   d="scan'208";a="244077017"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2020 03:54:41 +0800
IronPort-SDR: r2MTZIgYKd16wFwYsEpdbd2f8UDMBhPx1yX3kI9Z7d/z7XDLvPmJYp8ujlDM7DK5kt/Ks4rOOW
 6yseG3mWyuLqWPdCtQ+sBVq3IFCVQ53ShN+MNGi/71/KcFbmMJasga5sAOiVkBIt2Biul2c/WH
 33fpb3yaxMxoCjUl0eg7u+GRMSpkDtWIKFDutoxg+Cv8PzUZpDt/JRJ2QNVY6femAbqlCp5wRm
 l9p6Ov4BPNjjChSvkjLmXYkob+cLIdNaknh7e+zJ9wBDOIuYJ9cUkKnEBejeg9mVw+aRCUUyOn
 ZBMXnP7tATqH77zIQJwLqVzS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 12:45:09 -0700
IronPort-SDR: knJxDpysSdXz1GAUcRumT6u3DQfuJKc6iXGu46uVx6L6yak8+KA0bLmLArXQGY0922X1ngMzDf
 vQnhFvlOMK4Bvry2PcsKAh2GOXYccYAGxa2yalQ+SUmw8/tqPAan7ZDULyBafUl6HbGby4Cwnb
 tiolgXLVo+J7AD1a2FBjHkCWFs81lfxedUY5YC+Wjl6qq52YwIvKJVv2/Xu+UR57l/VjRwSBMb
 rowNC+ZGuUjXkUKTuXO2prpj+3tXkmss1t6HXEnniWbkBOd9jx5mXLEWgLaJqN3QXAem8bXeTX
 53w=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.55.244])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2020 12:54:41 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
Subject: [v3 PATCH 2/5] include: pe.h: Add RISC-V related PE definition
Date:   Wed, 15 Apr 2020 12:54:19 -0700
Message-Id: <20200415195422.19866-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200415195422.19866-1-atish.patra@wdc.com>
References: <20200415195422.19866-1-atish.patra@wdc.com>
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

