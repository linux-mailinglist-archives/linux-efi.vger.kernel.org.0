Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FB279CC88
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjILJ4z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjILJ4z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:56:55 -0400
X-Greylist: delayed 242 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 02:56:50 PDT
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F01BB
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1694512608;
        bh=J8OG1iDcDUUGJihJuHEXuEHvND3G6wC1Te9rWSjo4Xs=;
        h=From:To:Cc:Subject:Date;
        b=zbENxDD8miV/BhL0wlTqUoqblfPRr8AHdP1fLb9aAzC4HvjG2+Usv54hMlnHOfgoZ
         jpRgAwJlKZIbGx/eez+l0u51z1sNFuyInlKVFSz/fxugmoCad+qv9q7bGcWM4XLgdF
         dGMBPJdPCbPflQy88rNdqGM4/APhmpkKLG8i/c98=
Received: from RT-NUC.. ([39.156.73.12])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id B15A362E; Tue, 12 Sep 2023 17:44:21 +0800
X-QQ-mid: xmsmtpt1694511861txywrzvke
Message-ID: <tencent_D07D67AD5F6EA840BEC68C82226A18B40A0A@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntuj3Jw3MGR/HNLy16DTxTk1+HhzVP8aw736QxVaYN1b97gQvnSr+o
         X1giU9NshOBTkctUKKnOlm1Gvge0CSwzap3JggcW0rwBNkzyY+FSRSu/gehsH3QwI+Pk2HFCZry8
         n/SVI2K583clUnm1Hx60M6p2CRyiJmvE5Eg0tgTWSMIE/i5jAIgIC4NbubsJPj07FdKJRtlkp30E
         KKiNu62ZbYiKeOhQ7BTq6FyVfTckMTHK7twCIxOpoQL454JtzntWwahO1HSioKySVIRZeVFPZNGi
         34GYQ9pTpdBfVbzcsBVPvixN3Hc+io1gwjJlzaqxutFNrGXRTy34w2ecUHn6qVkcoDaxy1BljZTK
         qTpCGRR15VXlj+pA/5fDR4aJnogCetHhM4b2j08ThMV+pfLTWj21cjm9hywPAxcUGCq/u2TXolXC
         xCVP0Ks6SDvz5Kmad7syBsvj9IhrhZSLcQItRHpviqXwXWD54PyQwUF9VbCBDmQ1ERMOxNkYEkEJ
         8gBUFzLNRejHP6yoPfgHQclBB0hEh1ZhdEcVKojSzHg5iatWQzQ1awMgZrptjo8WTbTKr65Aa1Ep
         W8CEm4pH4HXCdJyYo8VZpFoprR55tPk+NVGmoEIoyjzky/h8NIEmONM6Nbv4/pDUACJ6RK4OW9p5
         ynRUZfgJdT65FgnSA6usScm8r22+Staev6lMxxybfmznkrNG1N4X9CK5PusVCzPzcvhretr2KXk1
         bG5gQJkeUkXZv5KZNpFS+xmGQHYKmKO2GJWQPCkG1O8TDXgRQ/0YL6QffkU7mC5TXvR3xuVn9zAl
         bJhVXW9074RguYYrCqgw93P92iENMFm/Vs7QGfiAE1XrofFWnhxkrhSGPRNDFeusL3EvQr7SLOxN
         gkwY/oRUoaRYZOXCLQJqIazdYRavrDXGlliRZ8SiegdTS46KIQWg+Rp5i5PT1QJr32SKOyesmZ7x
         JUIpulD1/ku8XKkwTlk7F2XoTfiqYMhUZzbllD+jIDB8xId2ygpsaDad1iX4s4
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   Rong Tao <rtoax@foxmail.com>
To:     ardb@kernel.org, rongtao@cestc.cn, rtoax@foxmail.com
Cc:     linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE
        (EFI)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] efi: Add new variable attributes
Date:   Tue, 12 Sep 2023 17:44:20 +0800
X-OQ-MSGID: <20230912094420.135737-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

More recent versions of the UEFI spec have added a new attribute for
variables [0]. Add it.

[0] https://uefi.org/specs/UEFI/2.10/08_Services_Runtime_Services.html#getvariable

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 include/linux/efi.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 80b21d1c6eaf..f15835873b31 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -928,6 +928,7 @@ extern int efi_status_to_err(efi_status_t status);
 #define EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS 0x0000000000000010
 #define EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS 0x0000000000000020
 #define EFI_VARIABLE_APPEND_WRITE	0x0000000000000040
+#define EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS	0x0000000000000080
 
 #define EFI_VARIABLE_MASK	(EFI_VARIABLE_NON_VOLATILE | \
 				EFI_VARIABLE_BOOTSERVICE_ACCESS | \
@@ -935,7 +936,8 @@ extern int efi_status_to_err(efi_status_t status);
 				EFI_VARIABLE_HARDWARE_ERROR_RECORD | \
 				EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS | \
 				EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS | \
-				EFI_VARIABLE_APPEND_WRITE)
+				EFI_VARIABLE_APPEND_WRITE | \
+				EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS)
 /*
  * Length of a GUID string (strlen("aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"))
  * not including trailing NUL
-- 
2.41.0

