Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4AB1A3C07
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgDIVo5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 17:44:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54766 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgDIVo4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Apr 2020 17:44:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039Lh6gl051871;
        Thu, 9 Apr 2020 21:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=KVyrR7Ev5APxOYVha5QcIl4uYw2bqBLsnRLs8f9X/Zo=;
 b=JVWpMDaFxV/Xn08SFhcnwE+kgFdAVQyxbDj8C/1buG1gAWbip/BW23tkFw70Lx8ghAj9
 YmMXoxpxmkLRSZef9thxMjHriDKdyZRDCcSyRLQzT1VXm/h7TOsRzng8QLLo/OxBbUfD
 ZeGkO0b7QdVOL9bUiTpKmuvoZHd362724REh9k0uNeDe4GolPiBU9J7Fe06vTl2B2Hsn
 lGTj0sMslkluHAT5JxcQv9P/sjot3EIlyIXNd1Ct9Zjsoz56um7D8sVa/VAWpQM05FdA
 7ogw1cGBuSWnw8v9qmLhqP7oa79pfV96LfTZcyNGqY5iQu4lN2wkOy1uJcQISJ8hmSHC /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 309gw4fuu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 21:44:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039LfdM1180988;
        Thu, 9 Apr 2020 21:44:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3091m9p5sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 21:44:54 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 039Lirng016549;
        Thu, 9 Apr 2020 21:44:53 GMT
Received: from toshiba-tecra.hsd1.ca.comcast.net (/10.159.132.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 14:44:53 -0700
From:   Victor Erminpour <victor.erminpour@oracle.com>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        victor.erminpour@oracle.com
Subject: [PATCH] efi/libstub/arm64: Enable __efistub_global define in .data section
Date:   Thu,  9 Apr 2020 14:44:29 -0700
Message-Id: <1586468669-21456-1-git-send-email-victor.erminpour@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=1 mlxlogscore=979
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004090152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 suspectscore=1 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090152
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Enable the __efistub_global define to place variables in the
.data section for both CONFIG_ARM and CONFIG_ARM64.

This places the EFIstub sys_table variable and other EFIstub
static variables in the .data section for both CONFIG_ARM and
CONFIG_ARM64.

Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
---
 drivers/firmware/efi/libstub/efistub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c244b16..59932d6 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,7 +25,7 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 #define __efistub_global	__section(.data)
 #else
 #define __efistub_global
