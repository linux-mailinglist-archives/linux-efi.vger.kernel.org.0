Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897E336917A
	for <lists+linux-efi@lfdr.de>; Fri, 23 Apr 2021 13:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhDWLta (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Apr 2021 07:49:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39662 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhDWLt3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Apr 2021 07:49:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13NBcwRV034176;
        Fri, 23 Apr 2021 11:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=iPby8n/oKiSg9iosJsx9rxTWFJNSezrrmzL3UQ0jX3w=;
 b=T66eUBCC0JclzjlmpGtcL8C33MI1jV9nSKjMGW+vpV55thrQz0Qelu9x5nCEDX0pXeBq
 nt4N1TohtoMWVhXNILiOb2GE/WjBR3Dprm9XTrOupSRyMqyIXfzqdJ8t1f86JYS/Chkh
 Z3Zeo80A8OqVPjBzmCMbsPLVtZx8XdN7zeqPKEJX/LQvHK2LTV4vP649qxBMfI2NhUqq
 MdOcIp1wvtV0qCYNVTmNaXBxaZxggJI0yZcy1A+u3QV5Y5pWrbliTgvYGzUHM79YT3nw
 uIPBlJ08Pj4M4f0et2ySqkt9KUvrwgfns/Du7zWpI2vrcVie1hfHimw+cWxIMpDsbfJ3 Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37yqmnr69j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:48:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13NBjTEL009544;
        Fri, 23 Apr 2021 11:48:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 383cbf3436-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:48:45 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13NBmiSS035729;
        Fri, 23 Apr 2021 11:48:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 383cbf3425-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:48:44 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13NBmbqu002744;
        Fri, 23 Apr 2021 11:48:37 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Apr 2021 04:48:37 -0700
Date:   Fri, 23 Apr 2021 14:48:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Philipp Fent <fent@in.tum.de>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] efi/libstub: prevent read overflow in find_file_option()
Message-ID: <YIK0D1JyV6ZeDMSS@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: 5ap1h2IUpdIXpA20rB1QYLJ-3aVVhSg9
X-Proofpoint-GUID: 5ap1h2IUpdIXpA20rB1QYLJ-3aVVhSg9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230076
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the buffer has slashes up to the end then this will read past the end
of the array.  I don't anticipate that this is an issue for many people
in real life, but it's the right thing to do and it makes static
checkers happy.

Fixes: 7a88a6227dc7 ("efi/libstub: Fix path separator regression")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/firmware/efi/libstub/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 4e81c6077188..dd95f330fe6e 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -103,7 +103,7 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
 		return 0;
 
 	/* Skip any leading slashes */
-	while (cmdline[i] == L'/' || cmdline[i] == L'\\')
+	while (i < cmdline_len && (cmdline[i] == L'/' || cmdline[i] == L'\\'))
 		i++;
 
 	while (--result_len > 0 && i < cmdline_len) {
-- 
2.30.2

