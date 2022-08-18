Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035525985CC
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245462AbiHRObJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 10:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245243AbiHRObH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 10:31:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DC0B9F9D;
        Thu, 18 Aug 2022 07:31:05 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IEEY1V014225;
        Thu, 18 Aug 2022 14:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kuf2QCWXrsl52T7eFPd0nJPt3gRfgPQ0AbooXYG3RPk=;
 b=lyQU7G2KwvWsvJj7n8o54APQm9nio/W6eJjwJDj4AemVvSpMT7tMAxYmxF/rqJKwav/k
 hOH6hZ4okNX5LOuLDc7wZsZYH9yrs+tj6ylJ5LUJtjripWqTpWGqHB/s0PX0K3/bzNho
 26C6SSOJZgE4V3Up9xNDQ7yQLweB/Fg+/ILfHrwBX/ar08G5sTYx2jbkOxj63dLkGFOv
 9delB+STnjh11U4h1Lf10vYqkwJHhesbNkqTaxkUSBwrduxyqyXcGPFuxWrA9/DL4Ufj
 vXDQEUIT3oxqOHs/kbc1/57y44URSgDPMM4KaX1dfkK3SPhfJRJwamEmdNHfyjzlZn3+ hg== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1q0w0js1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 14:30:54 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27IELhwd024218;
        Thu, 18 Aug 2022 14:30:53 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3hx3kaeyyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 14:30:53 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IEUpqn34865470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 14:30:52 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E00437805E;
        Thu, 18 Aug 2022 14:30:51 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B62FF7805C;
        Thu, 18 Aug 2022 14:30:50 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.160.121.241])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 14:30:50 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, axboe@kernel.dk, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, linux-efi@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v2 2/3 RESEND] block: sed-opal: Implement IOC_OPAL_REVERT_LSP
Date:   Thu, 18 Aug 2022 09:30:44 -0500
Message-Id: <20220818143045.680972-3-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220818143045.680972-1-gjoyce@linux.vnet.ibm.com>
References: <20220818143045.680972-1-gjoyce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v3fji98D0YIfuxmIrRD8kwfzYaiD1tkL
X-Proofpoint-GUID: v3fji98D0YIfuxmIrRD8kwfzYaiD1tkL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Greg Joyce <gjoyce@linux.vnet.ibm.com>

This is used in conjunction with IOC_OPAL_REVERT_TPR to return a drive to
Original Factory State without erasing the data. If IOC_OPAL_REVERT_LSP
is called with opal_revert_lsp.options bit OPAL_PRESERVE set prior
to calling IOC_OPAL_REVERT_TPR, the drive global locking range will not
be erased.

Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
---
 block/opal_proto.h            |  4 ++++
 block/sed-opal.c              | 40 +++++++++++++++++++++++++++++++++++
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h | 11 ++++++++++
 4 files changed, 56 insertions(+)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index b486b3ec7dc4..6127c08267f8 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -210,6 +210,10 @@ enum opal_parameter {
 	OPAL_SUM_SET_LIST = 0x060000,
 };
 
+enum opal_revertlsp {
+	OPAL_KEEP_GLOBAL_RANGE_KEY = 0x060000,
+};
+
 /* Packets derived from:
  * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
  * Secion: 3.2.3 ComPackets, Packets & Subpackets
diff --git a/block/sed-opal.c b/block/sed-opal.c
index e4d8fbdc9dad..2916b9539b84 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1593,6 +1593,26 @@ static int internal_activate_user(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
+static int revert_lsp(struct opal_dev *dev, void *data)
+{
+	struct opal_revert_lsp *rev = data;
+	int err;
+
+	err = cmd_start(dev, opaluid[OPAL_THISSP_UID],
+			opalmethod[OPAL_REVERTSP]);
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u64(&err, dev, OPAL_KEEP_GLOBAL_RANGE_KEY);
+	add_token_u8(&err, dev, (rev->options & OPAL_PRESERVE) ?
+			OPAL_TRUE : OPAL_FALSE);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+	if (err) {
+		pr_debug("Error building REVERT SP command.\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
 static int erase_locking_range(struct opal_dev *dev, void *data)
 {
 	struct opal_session_info *session = data;
@@ -2208,6 +2228,23 @@ static int opal_get_discv(struct opal_dev *dev, struct opal_discovery *discv)
 	return discv->size; /* modified to actual length of data */
 }
 
+static int opal_revertlsp(struct opal_dev *dev, struct opal_revert_lsp *rev)
+{
+	/* controller will terminate session */
+	const struct opal_step steps[] = {
+		{ start_admin1LSP_opal_session, &rev->key },
+		{ revert_lsp, rev }
+	};
+	int ret;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev);
+	ret = execute_steps(dev, steps, ARRAY_SIZE(steps));
+	mutex_unlock(&dev->dev_lock);
+
+	return ret;
+}
+
 static int opal_erase_locking_range(struct opal_dev *dev,
 				    struct opal_session_info *opal_session)
 {
@@ -2714,6 +2751,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_GENERIC_TABLE_RW:
 		ret = opal_generic_read_write_table(dev, p);
 		break;
+	case IOC_OPAL_REVERT_LSP:
+		ret = opal_revertlsp(dev, p);
+		break;
 	case IOC_OPAL_DISCOVERY:
 		ret = opal_get_discv(dev, p);
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 9197b7a628f2..3a6082ff97e7 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -43,6 +43,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_MBR_DONE:
 	case IOC_OPAL_WRITE_SHADOW_MBR:
 	case IOC_OPAL_GENERIC_TABLE_RW:
+	case IOC_OPAL_REVERT_LSP:
 	case IOC_OPAL_DISCOVERY:
 		return true;
 	}
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 89dd108b426f..bc91987a6328 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -51,6 +51,10 @@ struct opal_key {
 	__u8 key[OPAL_KEY_MAX];
 };
 
+enum opal_revert_lsp_opts {
+	OPAL_PRESERVE = 0x01,
+};
+
 struct opal_lr_act {
 	struct opal_key key;
 	__u32 sum;
@@ -137,6 +141,12 @@ struct opal_discovery {
 	__u64 size;
 };
 
+struct opal_revert_lsp {
+	struct opal_key key;
+	__u32 options;
+	__u32 __pad;
+};
+
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
@@ -154,5 +164,6 @@ struct opal_discovery {
 #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
 #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
 #define IOC_OPAL_DISCOVERY          _IOW('p', 236, struct opal_discovery)
+#define IOC_OPAL_REVERT_LSP         _IOW('p', 237, struct opal_revert_lsp)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.27.0

