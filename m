Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850986F899B
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 21:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjEETmR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjEETmQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 15:42:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127291BE4;
        Fri,  5 May 2023 12:42:15 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345JcmLO026399;
        Fri, 5 May 2023 19:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UrkXztJs4up8OoP4VgwErPUXYorlb1pBypAFlNLJZXg=;
 b=YPji9VtJ5Y/9j91XAIrNTz/7ouEhRc461F2WqiL7PciaqjZoTh93aD3TuJeRjeIz/o7Y
 ARydMf3fcBB+7g41S8obMi58w9uMntEYnxCzfzTsn2t1UaC25LSrkAqg0AV0QrRNQQo8
 QkL28zggw+sJtazJKozrExQVoN4CcnRM8eVbD2vD21VKgTtxfmXKiPcjfxM+L03zegwH
 OxP3db9qURNfGRkVEAAPw86R7mRm3VaGw2OYfj8Y5OfGegB0y0AYDN7M5vx9GgVPQoq4
 7IBg/DCjV0jfkUaCgY/TLgmfpmW6mQLWBfH0GCDXzS4kEyWKFq3Lld/YU46mGTqtxGi3 Fw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qd78vsemk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 19:41:59 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 345Gs2v9025333;
        Fri, 5 May 2023 19:41:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3q8tv888hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 19:41:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 345JfuND36307698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 May 2023 19:41:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B71065805E;
        Fri,  5 May 2023 19:41:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6245F5805A;
        Fri,  5 May 2023 19:41:55 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.160.1.159])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  5 May 2023 19:41:55 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        axboe@kernel.dk, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, linux-efi@vger.kernel.org,
        keyrings@vger.kernel.org, me@benboeckel.net, elliott@hpe.com
Subject: [PATCH v4 1/3] block: sed-opal: Implement IOC_OPAL_DISCOVERY
Date:   Fri,  5 May 2023 14:41:49 -0500
Message-Id: <20230505194151.2078678-2-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230505194151.2078678-1-gjoyce@linux.vnet.ibm.com>
References: <20230505194151.2078678-1-gjoyce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Fq7JpJZGvHD6ARVVBwHYGA0tEF0yPN-
X-Proofpoint-ORIG-GUID: -Fq7JpJZGvHD6ARVVBwHYGA0tEF0yPN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_26,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Greg Joyce <gjoyce@linux.vnet.ibm.com>

Add IOC_OPAL_DISCOVERY ioctl to return raw discovery data to a SED Opal
application. This allows the application to display drive capabilities
and state.

Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 block/sed-opal.c              | 38 ++++++++++++++++++++++++++++++++---
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  6 ++++++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index c320093c14f1..b55a8eb29f5b 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -457,8 +457,11 @@ static int execute_steps(struct opal_dev *dev,
 	return error;
 }
 
-static int opal_discovery0_end(struct opal_dev *dev)
+static int opal_discovery0_end(struct opal_dev *dev, void *data)
 {
+	struct opal_discovery *discv_out = data; /* may be NULL */
+	u8 __user *buf_out;
+	u64 len_out;
 	bool found_com_id = false, supported = true, single_user = false;
 	const struct d0_header *hdr = (struct d0_header *)dev->resp;
 	const u8 *epos = dev->resp, *cpos = dev->resp;
@@ -474,6 +477,15 @@ static int opal_discovery0_end(struct opal_dev *dev)
 		return -EFAULT;
 	}
 
+	if (discv_out) {
+		buf_out = (u8 __user *)(uintptr_t)discv_out->data;
+		len_out = min_t(u64, discv_out->size, hlen);
+		if (buf_out && copy_to_user(buf_out, dev->resp, len_out))
+			return -EFAULT;
+
+		discv_out->size = hlen; /* actual size of data */
+	}
+
 	epos += hlen; /* end of buffer */
 	cpos += sizeof(*hdr); /* current position on buffer */
 
@@ -559,13 +571,13 @@ static int opal_discovery0(struct opal_dev *dev, void *data)
 	if (ret)
 		return ret;
 
-	return opal_discovery0_end(dev);
+	return opal_discovery0_end(dev, data);
 }
 
 static int opal_discovery0_step(struct opal_dev *dev)
 {
 	const struct opal_step discovery0_step = {
-		opal_discovery0,
+		opal_discovery0, NULL
 	};
 
 	return execute_step(dev, &discovery0_step, 0);
@@ -2247,6 +2259,22 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 	return ret;
 }
 
+static int opal_get_discv(struct opal_dev *dev, struct opal_discovery *discv)
+{
+	const struct opal_step discovery0_step = {
+		opal_discovery0, discv
+	};
+	int ret = 0;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev);
+	ret = execute_step(dev, &discovery0_step, 0);
+	mutex_unlock(&dev->dev_lock);
+	if (ret)
+		return ret;
+	return discv->size; /* modified to actual length of data */
+}
+
 static int opal_erase_locking_range(struct opal_dev *dev,
 				    struct opal_session_info *opal_session)
 {
@@ -2814,6 +2842,10 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_GET_STATUS:
 		ret = opal_get_status(dev, arg);
 		break;
+	case IOC_OPAL_DISCOVERY:
+		ret = opal_get_discv(dev, p);
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 31ac562a17d7..8e824ab908e9 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -45,6 +45,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_WRITE_SHADOW_MBR:
 	case IOC_OPAL_GENERIC_TABLE_RW:
 	case IOC_OPAL_GET_STATUS:
+	case IOC_OPAL_DISCOVERY:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index d7a1524023db..98f216cf2241 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -151,6 +151,11 @@ struct opal_status {
 	__u32 reserved;
 };
 
+struct opal_discovery {
+	__u64 data;
+	__u64 size;
+};
+
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
@@ -168,5 +173,6 @@ struct opal_status {
 #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
 #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
 #define IOC_OPAL_GET_STATUS         _IOR('p', 236, struct opal_status)
+#define IOC_OPAL_DISCOVERY          _IOW('p', 237, struct opal_discovery)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
gjoyce@linux.vnet.ibm.com

