Return-Path: <linux-efi+bounces-5988-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D46D1C96E
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jan 2026 06:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16B65305E85B
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jan 2026 05:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E1E274B40;
	Wed, 14 Jan 2026 05:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IqrCaQBA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9335EDB2;
	Wed, 14 Jan 2026 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768368762; cv=none; b=A70uSxDfg2M4llSUNqScBsb8v/BK4wYr/zD2i4SxvmsUsK8dczKNC7vFKcm4AYp9GFPld8nZr1spcs21gTgNKRJFYUDTYxF+eq68tNjVeTkuCWKxVuPKiilZFWWzOkrMqnhV+lA8hlFirR5SPU60a3DUQ7Vgx0dvwFKJGjIOT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768368762; c=relaxed/simple;
	bh=RgB2UdTm+24rF+4O4bAjYfUxAKD+cHQqt9VTHHJtUJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbBdtdEZzLK3IZFJJ3XgzVnEBxZNLi5RDu0B12g2A4UGvI9mm4cxCTJTcRVt4t6qnvHMaHYSfm3n5+p7wF0xMhoMzCK12sSEvITba23J7my9Wab9U8A8hTEIsatzXhYM06/QnITlsomKMckKgV+4ys3DSFyNkhAHndLb0Pyw+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IqrCaQBA; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1768368729;
	bh=FI7bkbgrIX+fBW6u4Ru5bB8HmN+BY5ejYxIceYoJcNw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IqrCaQBAlOK02L477cDk44Ard4G7syz9CyLssoodrF1L54QEcPSgJFkfsDtUcS+QX
	 +WKsj20Crchuv1UWoEQ8EzHa+kUgQWWOGbpc51MoQZ63ne47Dgr5CgTKpCR8RBR1Ti
	 Vl0yWd+K2NQRaf0uFIviJDEb4Iga8ueEVSNT5k90=
X-QQ-mid: esmtpgz12t1768368698t2836aeba
X-QQ-Originating-IP: X+7Y3qpth4VEaCUA6K/uKhUtNkMF/TiVYAMSZwThpTE=
Received: from uos-PC ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 Jan 2026 13:31:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15513342025828384446
EX-QQ-RecipientCnt: 6
From: Morduan Zang <zhangdandan@uniontech.com>
To: ardb@kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: guanwentao@uniontech.com,
	zhangdandan@uniontech.com,
	niecheng1@uniontech.com
Subject: [PATCH] efi/cper: Fix cper_bits_to_str buffer handling and return value
Date: Wed, 14 Jan 2026 13:30:33 +0800
Message-ID: <7E55C4CEDE596906+20260114053033.124359-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MGsW0jV72LNN14RfY2Qrd24FJ88SZIt6EWOUvwgGLKCrOQfQ48GzhcNK
	Mw4GZqwaHT/KBZD3IJo03kN1IFfckBr0DY7vGqm+0vzXOB1UhV9COz9ZQ46WqPg7wm4NMXs
	OhfxYZ5KNmuDb24FVzr2PUS5pFoLw8NHLflxhv0yPb9uVj77C4PRI/CIWUnqu3H76XsBn6F
	F2hnrQdKfIFWWPcIwDjGJ7HaZMMq3Ivrg4ReoH6yZaf/581p18aYxaCbN++unRbbwBMvAJv
	XWU+cDdFk7qYMTiGyTv48lwRdesOZhQyte4wT2P5nR17G70a+9CsDo7j2JRbEiCxvWibl/K
	rV3SOV2rEr9pKQovjoBQfa4LIddzHa7S4+DelZ/wX166K4MzZrYw8GHRJzbmqXOG89stOMl
	KkT5+lRLXD0Sw2//0Do3OSz+qjRu963F/7qezNHXG8d/5U0DVb8Zlaxj3W1xal2g6Gr/LWH
	8La5pvvpxBwLwa3UWoXhQ/CZSfR0fvVwJ/ZOdnbQYC9NY2zcSUIHLYvdBWE0nqgjd03tqcu
	tB0dWcIExJCX2BAewrpSoxCrpCt2LmxeoyRFlUF/RoNK4SuI0C+oCsnWJemROPP2eIsboxl
	2adhIJ4ZGEr3IPRPG9WXdlsyKPXAbfLjfAwpahg+vklaIqKLo1jcwB5Q3Lyz8e+7ec71aX2
	htC5xeEvYRioF27RBTi8eXxjqy4xu6F+hPDVwu7hEqnPP1i03wm3d5DZaBJOpc9Y0e2/Bqr
	DbOT8yYD2I3zCf793GFLpv1XsFjuXC9WbSKk5hqQ7EeWuuomw6M9EfKnqKZi8gdMHb2rtXF
	vayYPaSyv2hdCd0b5zmOubZQo/99QyrY8tZ8HG8vDGrLn8H/Z6vPxsD9D234raitxYliFED
	DAhs+7B54ZIEIL/g8to6bLUmivVdqHU88zLp3POEiC84K18pUHeAdFRxILTXTOpkTMojp+h
	JxYwEXBvzfEDJEkb32mget9VqzadfPzPCVefI6HHwg8Xh+4j0VicapHyUZbeNzyXG/hZGqD
	3Uw4BlPcZRrt6um+uN50VlNHfv7L1c4xTL6ge4wkr6c76KenNpfQP5HfbxQkTOft+Hs3JwE
	P38+rP9LWE4
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

The return value calculation was incorrect:
    `return len - buf_size;`
    Initially `len = buf_size`, then `len` decreases with each operation.
    This results in a negative return value on success.

Fix by returning `buf_size - len` which correctly calculates the
    actual number of bytes written.

Fixes: a976d790f494 ("efi/cper: Add a new helper function to print bitmasks")
Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
---
 drivers/firmware/efi/cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 0232bd040f61..bd99802cb0ca 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -162,7 +162,7 @@ int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
 		len -= size;
 		str += size;
 	}
-	return len - buf_size;
+	return buf_size - len;
 }
 EXPORT_SYMBOL_GPL(cper_bits_to_str);
 
-- 
2.50.1


