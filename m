Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D72B744DD1
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2019 22:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfFMUuq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jun 2019 16:50:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730002AbfFMUup (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jun 2019 16:50:45 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DKkqJE110433
        for <linux-efi@vger.kernel.org>; Thu, 13 Jun 2019 16:50:44 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3td38c40-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Thu, 13 Jun 2019 16:50:44 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Thu, 13 Jun 2019 21:50:42 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 21:50:38 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DKobsI31719474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 20:50:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E30265204F;
        Thu, 13 Jun 2019 20:50:36 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.207.125])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C0EEC5204E;
        Thu, 13 Jun 2019 20:50:33 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>
Subject: [PATCH 1/2] powerpc/powernv: add OPAL APIs for secure variables
Date:   Thu, 13 Jun 2019 16:50:26 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560459027-5248-1-git-send-email-nayna@linux.ibm.com>
References: <1560459027-5248-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061320-4275-0000-0000-000003421DD5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061320-4276-0000-0000-00003852391C
Message-Id: <1560459027-5248-2-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130156
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Claudio Carvalho <cclaudio@linux.ibm.com>

The X.509 certificates trusted by the platform and other information
required to secure boot the OS kernel are wrapped in secure variables,
which are controlled by OPAL. These variables are manipulated by
userspace tools using filesystem interface. This patch adds support
for the OPAL APIs required to expose variables to userspace.

OPAL_SECVAR_GET_NEXT:
For a given secure variable, it returns the name and vendor GUID
of the next variable.

OPAL_SECVAR_ENQUEUE_UPDATE:
Enqueue the supplied secure variable update so that it can be processed
by OPAL in the next boot. Variable updates cannot be be processed right
away because the variable storage is write locked at runtime.

OPAL_SECVAR_GET_SIZE:
Returns size information about the variable.

Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h          |  3 +
 arch/powerpc/include/asm/opal-secvar.h       |  9 +++
 arch/powerpc/include/asm/opal.h              |  8 +++
 arch/powerpc/platforms/powernv/opal-call.c   |  3 +
 arch/powerpc/platforms/powernv/opal-secvar.c | 60 +++++++++++++++++++-
 5 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index a505e669b4b6..fa3083966efc 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -213,6 +213,9 @@
 #define	OPAL_NX_COPROC_INIT			167
 #define OPAL_XIVE_GET_VP_STATE			170
 #define OPAL_SECVAR_GET                         173
+#define OPAL_SECVAR_GET_SIZE                    174
+#define OPAL_SECVAR_GET_NEXT                    175
+#define OPAL_SECVAR_ENQUEUE_UPDATE              176
 #define OPAL_SECVAR_BACKEND                     177
 #define OPAL_LAST				177
 
diff --git a/arch/powerpc/include/asm/opal-secvar.h b/arch/powerpc/include/asm/opal-secvar.h
index b677171a0368..26ebbc63dd70 100644
--- a/arch/powerpc/include/asm/opal-secvar.h
+++ b/arch/powerpc/include/asm/opal-secvar.h
@@ -20,4 +20,13 @@ extern int opal_get_variable(u8 *key, unsigned long ksize,
 
 extern int opal_variable_version(unsigned long *backend);
 
+extern int opal_get_variable_size(u8 *key, unsigned long ksize,
+				  unsigned long *mdsize, unsigned long *dsize);
+
+extern int opal_get_next_variable(u8 *key, unsigned long *keylen,
+				  unsigned long keysize);
+
+extern int opal_set_variable(u8 *key, unsigned long ksize, u8 *metadata,
+			     unsigned long mdsize, u8 *data,
+			     unsigned long dsize);
 #endif
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 57d2c2356eda..a6fcb59c91cc 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -399,6 +399,14 @@ extern int opal_secvar_get(uint64_t k_key, uint64_t k_key_len,
 			   uint64_t k_data, uint64_t k_data_size);
 
 extern int opal_secvar_backend(uint64_t k_backend);
+extern int opal_secvar_get_size(uint64_t k_key, uint64_t k_key_len,
+				uint64_t k_metadata_size, uint64_t k_data_size);
+extern int opal_secvar_get_next(uint64_t k_key, uint64_t k_key_len,
+				uint64_t k_key_size);
+extern int opal_secvar_enqueue_update(uint64_t k_key, uint64_t k_key_len,
+				      uint64_t k_metadata,
+				      uint64_t k_metadata_size,
+				      uint64_t k_data, uint64_t k_data_size);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
index 0445980f294f..dda3a4c5bb79 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -290,3 +290,6 @@ OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
 OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
 OPAL_CALL(opal_secvar_get,                      OPAL_SECVAR_GET);
 OPAL_CALL(opal_secvar_backend,                  OPAL_SECVAR_BACKEND);
+OPAL_CALL(opal_secvar_get_size,                 OPAL_SECVAR_GET_SIZE);
+OPAL_CALL(opal_secvar_get_next,                 OPAL_SECVAR_GET_NEXT);
+OPAL_CALL(opal_secvar_enqueue_update,           OPAL_SECVAR_ENQUEUE_UPDATE);
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
index dba441dd5af1..afa67b87ad7a 100644
--- a/arch/powerpc/platforms/powernv/opal-secvar.c
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -30,7 +30,10 @@ static bool is_opal_secvar_supported(void)
 		return opal_secvar_supported;
 
 	if (!opal_check_token(OPAL_SECVAR_GET)
-	    || !opal_check_token(OPAL_SECVAR_BACKEND)) {
+	    || !opal_check_token(OPAL_SECVAR_BACKEND)
+	    || !opal_check_token(OPAL_SECVAR_GET_SIZE)
+	    || !opal_check_token(OPAL_SECVAR_GET_NEXT)
+	    || !opal_check_token(OPAL_SECVAR_ENQUEUE_UPDATE)) {
 		pr_err("OPAL doesn't support secure variables\n");
 		opal_secvar_supported = false;
 	} else {
@@ -83,3 +86,58 @@ int opal_variable_version(unsigned long *backend)
 
 	return rc;
 }
+
+int opal_get_variable_size(u8 *key, unsigned long ksize, unsigned long *mdsize,
+			   unsigned long *dsize)
+{
+	int rc;
+
+	if (!is_opal_secvar_supported())
+		return OPAL_UNSUPPORTED;
+
+	if (mdsize)
+		*mdsize = cpu_to_be64(*mdsize);
+	if (dsize)
+		*dsize = cpu_to_be64(*dsize);
+
+	rc = opal_secvar_get_size(__pa(key), ksize, __pa(mdsize), __pa(dsize));
+
+	if (mdsize)
+		*mdsize = be64_to_cpu(*mdsize);
+	if (dsize)
+		*dsize = be64_to_cpu(*dsize);
+	return rc;
+}
+
+int opal_get_next_variable(u8 *key, unsigned long *keylen,
+			   unsigned long keysize)
+{
+	int rc;
+
+	if (!is_opal_secvar_supported())
+		return OPAL_UNSUPPORTED;
+
+	if (!keylen)
+		return OPAL_PARAMETER;
+	*keylen = cpu_to_be64(*keylen);
+
+	rc = opal_secvar_get_next(__pa(key), __pa(keylen), keysize);
+
+	*keylen = be64_to_cpu(*keylen);
+
+	return rc;
+}
+
+int opal_set_variable(u8 *key, unsigned long ksize, u8 *metadata,
+		      unsigned long mdsize, u8 *data, unsigned long dsize)
+{
+	int rc;
+
+	if (!is_opal_secvar_supported())
+		return OPAL_UNSUPPORTED;
+
+	rc = opal_secvar_enqueue_update(__pa(key), ksize, __pa(metadata),
+			mdsize, __pa(data), dsize);
+
+	return rc;
+}
-- 
2.20.1

