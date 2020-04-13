Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463941A6E47
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 23:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbgDMVaB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 17:30:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20797 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389040AbgDMV3b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Apr 2020 17:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586813371; x=1618349371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qT9c7eXt7ksLkS8LTzuMlCHOyGGyAUacpIVqI65fctQ=;
  b=MLu70IUS2hLE69xBtxf4HXYYqiqCJ90w8n1+FmW88Re/x94ThSHjswHK
   bp7s9W90OoJr6gfPFiOjZBPAC1DKJZ8FxjSAhxbLg4dHJrOloJpeNYFrn
   +T8wKZLrtWas9KB16rPV6bY8o74Q9U6+VRNzfzhIxCVvXSuMDC+m+r9m7
   uwYJtUuj125fhUc8eWbBSgvouZX0ZzZvUa3k+Q7M9rQrKbI4+fgqksW4Q
   AHzVOk1KvXLrY4bYgSTjdj2UmC5Kd+z84rStAgTJE3D2xPKOxdmo5F6dn
   YpHAcOThfs9H0HDnuQvcOfGiIiIHzTfFOaYaVVC5P17nFw3BGXyrqyyG8
   g==;
IronPort-SDR: nO1ZchRJARMTrxNZe+PgS8g00BAg5iWqV5aVQyS1K2FiuY0XSg+TMivYXlxWacnuJ7BHFxh+Oi
 GBtM6C+ov+tgms68OgVyRuDXh5tO6acghjfFKiwF5xkMqDG9hUcnvQZ7bm1Ms/s0YyQzjj0BVy
 udmpLJAVenuzN66L375m0UFApkRVX0WZW/y30IBxSTUOHQa602sGMJuROVEkD1O3eUi+hfcovk
 1u1Wq/M93Aly361bQPo56znF1QlyosBDNosfBlxW5dx4nhM5vwF9TWjfWz6bcp/jU3WHjEuQvh
 AOk=
X-IronPort-AV: E=Sophos;i="5.72,380,1580745600"; 
   d="scan'208";a="139583355"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2020 05:29:30 +0800
IronPort-SDR: E+yvfvhXJbEhx/CJBD5D0zj3URslcIkkwYG2kUR8NYq7lgAAOOR5IXKoVweJWHWLFfTlK6S9E7
 IXcAoo4FyCo786j/yMWuYE0lA6JzgZYpSWSFA/7Lrj1ho088J+JWhdwDdJnjgnUn1q0j7O0rn+
 DtUrXFGqRh7+vchy/6wtt+h22IMn5K7D/mNipAcFyKKzqalt1IdwuboFXGltTrnF27vQ1Z7kdl
 /r2yZvX5M0LG9oIjdRYdWEFG4FHMhW6v58OWqwpgjrQbiaZab7oO3PZrBhkKSwjhOcgC/9lOiF
 Egv00Nxz5nqd5qJzb1ekxcyE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 14:20:35 -0700
IronPort-SDR: 9G9nj2p0GT4YHZw2NCS5Fuwgbl/gAoRjzgFyJNSm5Lcn1NpB/1a46z/Nv8AljWcfv1LEgthoiw
 HQ4OPpp3BFp/21DWwQGdRZ5V26kUUtMlkny8vEd+BlAHg/uN/7p6R+m3zx7loxswaqt/FnF/Oe
 P6ZRbX+r7QcCgxG0UovpYsZJW9k4AUDuSdvPxf4ta9+KGGxh/Zmy97/uxm4CYNjPYg6ZRc+BAr
 4gFQSVSiWGzxgCQ9Lk6/bwB90WBZZvPSQ5Mrl+frU+xteloZJgUJ8ArkHvwex4rdexUtILiskv
 Xqs=
WDCIronportException: Internal
Received: from 9dg4l72.ad.shared (HELO jedi-01.hgst.com) ([10.86.55.26])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Apr 2020 14:29:30 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
Subject: [v2 PATCH 2/5] include: pe.h: Add RISC-V related PE definition
Date:   Mon, 13 Apr 2020 14:29:04 -0700
Message-Id: <20200413212907.29244-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200413212907.29244-1-atish.patra@wdc.com>
References: <20200413212907.29244-1-atish.patra@wdc.com>
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

