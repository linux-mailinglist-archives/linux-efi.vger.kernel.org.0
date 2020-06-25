Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5611920A966
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 01:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgFYXpz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 19:45:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4093 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgFYXp3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Jun 2020 19:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593128728; x=1624664728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/aLmMoaf+R1cfTR4Mi4doOLt0MJCtDnvFjCl4cVqNk=;
  b=hejhZixO4l/dG2gmpj+wQ772nvwNsZrsdT9uuagyDXwYksiO29jdpo8L
   Np2lEiQI9WyH/VGRtenXV3ms3hP3laxKsKaYFZwO548Fy+4C+pHNkhM4I
   TrfRwSGNpnAWQIXIy7s308rQhWAVEpod1s+DrOk6m6pLirLM68AvHeRWI
   74U4CoEXVhSzm9g5JbXd0FytelzGuRBsA4dGnGi+Go2GrgUqKwIVERj+k
   vQXZ0K8x4aWGnSnmosxgwSBhBFq+MttV6xVyaccjTawhopSKhUkz/RQWG
   St95oZTNoS4v8PGI6RC+tn+q3vxkgMsiN5u4iBNY0FzlJfarcmXRc5LW7
   g==;
IronPort-SDR: 9H6UgJJP6yyYX0w6rCJ4g8kia7YTJu/5AiiQJA7uTfG9K15co5mpZvmEwIl/pwakjC1YyOviRf
 2JRzBW5WwtEu6Dxp208/6a5mfuDnqAtXm6WV/92Ok2u9R18HAXF56U77jHKVOD1WErKIb8FO10
 bYQ4sL+AyAjuvt2CulllrzLwyIULz9mMzhxmerGaJNOHVlzsR0oBDT5lDV9njJlCDoPONuQUWw
 nTrALwxyv0dgSoho+RYkFkccyJisbKmfcsZVF6Tg4Z0Tj/sxmkNcsZFIVv4xNNOZH+akFLW6Mm
 POY=
X-IronPort-AV: E=Sophos;i="5.75,280,1589212800"; 
   d="scan'208";a="140953464"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 07:45:27 +0800
IronPort-SDR: 2nboY54Evh/Vyz4d0NwWoyGAolDfH5VmMn5Ltd7JOkhkOmoxaBLZpnMY3+3ck90eTzHTNaeJe2
 TN4fQMaOqaGmQrh+ncMfY6S7QtcqXFZQA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 16:34:27 -0700
IronPort-SDR: rsP8xzULUfBFMDuMCtJGe0TMaOrFxT6DTyZwDjC5tdJA7trEYutCByptrNB4uMfLlWXegYkKzb
 pktVpb+3JPPA==
WDCIronportException: Internal
Received: from 2349pbt5e4f.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.78])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2020 16:45:26 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 07/11] include: pe.h: Add RISC-V related PE definition
Date:   Thu, 25 Jun 2020 16:45:12 -0700
Message-Id: <20200625234516.31406-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200625234516.31406-1-atish.patra@wdc.com>
References: <20200625234516.31406-1-atish.patra@wdc.com>
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

