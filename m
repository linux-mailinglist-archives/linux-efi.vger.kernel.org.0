Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD1620A95F
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 01:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFYXps (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 19:45:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4093 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgFYXpd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Jun 2020 19:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593128732; x=1624664732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aWD4YBmJs4KzatxYQf8rnaaoWvjExyC78q596yR2/no=;
  b=gpLkR53PDcyF5A2LfInAXArW7n0fkm7bEm0HWTNjDxIGqsgoxpP3dwao
   5g0G64U9jdXlriIgR9Puyh/To5Mo6RGCc0mJ4uRCqVEuaH2hWnDQAFr6e
   5Y1cw9qpUE3H1s+yV3AtkO+KyITCaOepmwKRmzHpUkz1wPlc8FPzmWGkW
   i2oD0PaZYDNeFeDyaxqFoFWDlYbtIM0R3IsxWRCw8kqWuuojXhAKBq7Af
   hslzRFt2TVVAjNCVd2DgOsHVbP268kjHIXxVVinusLUlTN/+5umdMuidt
   x9jm+K3dWqjoq/dBCvFRa/UHDRiorlm0dqr9eIxr83cdVKJf+n3EVEUGO
   Q==;
IronPort-SDR: LEy8adutllvsJbhfcbhPdTyMO4ykJNc+TSPDiiuZSOO9SNcLe7jo/JPUz2xYh6Q6qGqW5ivb0P
 IyKZVqwUFS16Yh3tPcKcRe4GZjO2DQFqs+/8WzjxcfFSGmlET/Of2HmXZfaqhb9PhCg3Rp7Y0D
 ZwRSFQooQV4dR6PDvTY1KvStkfBIRlO9HzdgbUAmZT4Tin7W/0W0TXG/LxS6dm1047YRrsi4+i
 kpyuacw9o8VWaLMrJtl6+N5wetFM/E07v+8XIEctYtLvATgWG1zWVEM++pxdLu2Zacm/26VzkS
 vzY=
X-IronPort-AV: E=Sophos;i="5.75,280,1589212800"; 
   d="scan'208";a="140953470"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 07:45:28 +0800
IronPort-SDR: 5Y9PsVGruZUsvAKOVgZal1lGdCaGdcrulz/sDjgiA8z+hPScz4D/njnKonzjlqpQnjQZuG5x1k
 vAdcnkpwS5mkgP5IsQGgRJt3Iotqxss1o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 16:34:28 -0700
IronPort-SDR: qzucKY1oxxKLbrAVAstjJ6LHkYhYSEJngCI+ItcjpIHTI3dmgOGrYo+V24ODpy0uGkhcgytR3B
 fUSIjAQFVOTQ==
WDCIronportException: Internal
Received: from 2349pbt5e4f.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.78])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2020 16:45:28 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 10/11] efi: Rename arm-init to efi-init common for all arch
Date:   Thu, 25 Jun 2020 16:45:15 -0700
Message-Id: <20200625234516.31406-11-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200625234516.31406-1-atish.patra@wdc.com>
References: <20200625234516.31406-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

arm-init is responsible for setting up efi runtime and doesn't actually
do any ARM specific stuff. RISC-V can use the same source code as it is.

Rename it to efi-init so that RISC-V can use it.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/firmware/efi/{arm-init.c => efi-init.c} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/efi-init.c
similarity index 100%
rename from drivers/firmware/efi/arm-init.c
rename to drivers/firmware/efi/efi-init.c
-- 
2.24.0

