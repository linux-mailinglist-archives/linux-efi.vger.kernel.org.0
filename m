Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2683262753
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 08:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgIIGrE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 02:47:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbgIIGrD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Sep 2020 02:47:03 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6294519359DCD4192FA1;
        Wed,  9 Sep 2020 14:47:01 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 14:46:50 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <ardb@kernel.org>, <nivedita@alum.mit.edu>,
        <linux-efi@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] efi/printf: remove unneeded semicolon
Date:   Wed, 9 Sep 2020 14:44:32 +0800
Message-ID: <1599633872-36784-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fix the warning below.
efi/libstub/vsprintf.c:135:2-3: Unneeded semicolon

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/firmware/efi/libstub/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index e65ef49..1088e28 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -135,7 +135,7 @@ char *number(char *end, unsigned long long num, int base, char locase)
 		break;
 	default:
 		unreachable();
-	};
+	}
 
 	return end;
 }
-- 
2.7.4

