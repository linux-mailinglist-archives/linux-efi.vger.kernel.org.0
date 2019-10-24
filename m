Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2CEE2918
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2019 05:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437420AbfJXDsU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Oct 2019 23:48:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437404AbfJXDsU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Oct 2019 23:48:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9O3lExB003825
        for <linux-efi@vger.kernel.org>; Wed, 23 Oct 2019 23:48:19 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vu13h5afc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 23 Oct 2019 23:48:18 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Thu, 24 Oct 2019 04:48:17 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Oct 2019 04:48:11 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9O3m9L840042988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 03:48:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A420AE04D;
        Thu, 24 Oct 2019 03:48:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B17B9AE053;
        Thu, 24 Oct 2019 03:48:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.192.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Oct 2019 03:48:06 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v9 8/8] powerpc/ima: update ima arch policy to check for blacklist
Date:   Wed, 23 Oct 2019 22:47:17 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024034717.70552-1-nayna@linux.ibm.com>
References: <20191024034717.70552-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102403-0008-0000-0000-000003267A2E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102403-0009-0000-0000-00004A45AB93
Message-Id: <20191024034717.70552-9-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240033
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch updates the arch-specific policies for PowerNV system to make
sure that the binary hash is not blacklisted.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 arch/powerpc/kernel/ima_arch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index 0ef5956c9753..b9de0fb45bb9 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -23,9 +23,9 @@ bool arch_ima_get_secureboot(void)
  * is not enabled.
  */
 static const char *const secure_rules[] = {
-	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
+	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
 #ifndef CONFIG_MODULE_SIG_FORCE
-	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
+	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
 #endif
 	NULL
 };
@@ -49,9 +49,9 @@ static const char *const trusted_rules[] = {
 static const char *const secure_and_trusted_rules[] = {
 	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
 	"measure func=MODULE_CHECK template=ima-modsig",
-	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
+	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
 #ifndef CONFIG_MODULE_SIG_FORCE
-	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
+	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
 #endif
 	NULL
 };
-- 
2.20.1

