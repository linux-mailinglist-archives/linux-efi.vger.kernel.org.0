Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1EA5985FD
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245296AbiHRObK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245192AbiHRObI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 10:31:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E34B99C6;
        Thu, 18 Aug 2022 07:31:06 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IDfr0D003963;
        Thu, 18 Aug 2022 14:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TAzDUvqbXfCA2IACO9YAMYkxmNEIQAorzKNDitphQK8=;
 b=kZ6jvQY9DQFNkpzY/D8MKWDSTN3RkGr2iLYrOhV6Ofo4L5PH2B/EtWHxo/tgXfAKDEHE
 n2yUdL32oFJiVViAgm0TzlLCqvw7joZm4f42Z5n+oJO7m0WDGLJ3e6+itqvEGfL6R75x
 FwCaDwi5+ihSceCg0/R4mL89THHaUPrNcvxkItiwOsaC1AiWz50vymgIIXvN7/MzAmMJ
 ap+DDxiNjPJvhopBWNkgd/HeY3tHF1lBvOKVdnnVhvo7PhyYGRQDJR4iCsOpu2ZGM+r+
 BG7rDZM762/NXrmlDRlT1gIX3GFB8ubG8CtNR2vgFJUQsUbARFw0TgY+W0un9+r4Qdq8 xQ== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1phjssdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 14:30:55 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27IEKplq005867;
        Thu, 18 Aug 2022 14:30:54 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3hx3kaexvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 14:30:54 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IEUrbZ49414504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 14:30:53 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E77678060;
        Thu, 18 Aug 2022 14:30:53 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1444D7805C;
        Thu, 18 Aug 2022 14:30:52 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.160.121.241])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 14:30:51 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, axboe@kernel.dk, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, linux-efi@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v2 3/3 RESEND] block: sed-opal: keyring support for SED keys
Date:   Thu, 18 Aug 2022 09:30:45 -0500
Message-Id: <20220818143045.680972-4-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220818143045.680972-1-gjoyce@linux.vnet.ibm.com>
References: <20220818143045.680972-1-gjoyce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CxbsJ-H76uriqGu_LFzHKhe37EJw7hW4
X-Proofpoint-ORIG-GUID: CxbsJ-H76uriqGu_LFzHKhe37EJw7hW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
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

Extend the SED block driver so it can alternatively
obtain a key from a sed-opal kernel keyring. The SED
ioctls will indicate the source of the key, either
directly in the ioctl data or from the keyring.

This allows the use of SED commands in scripts such as
udev scripts so that drives may be automatically unlocked
as they become available.

Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
---
 block/Kconfig                 |   1 +
 block/sed-opal.c              | 174 +++++++++++++++++++++++++++++++++-
 include/linux/sed-opal.h      |   3 +
 include/uapi/linux/sed-opal.h |   8 +-
 4 files changed, 183 insertions(+), 3 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 50b17e260fa2..f65169e9356b 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -182,6 +182,7 @@ config BLK_DEBUG_FS_ZONED
 
 config BLK_SED_OPAL
 	bool "Logic for interfacing with Opal enabled SEDs"
+	depends on KEYS
 	help
 	Builds Logic for interfacing with Opal enabled controllers.
 	Enabling this option enables users to setup/unlock/lock
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 2916b9539b84..3bdb31cf3e7c 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -20,6 +20,9 @@
 #include <linux/sed-opal.h>
 #include <linux/string.h>
 #include <linux/kdev_t.h>
+#include <linux/key.h>
+#include <linux/key-type.h>
+#include <keys/user-type.h>
 
 #include "opal_proto.h"
 
@@ -29,6 +32,8 @@
 /* Number of bytes needed by cmd_finalize. */
 #define CMD_FINALIZE_BYTES_NEEDED 7
 
+static struct key *sed_opal_keyring;
+
 struct opal_step {
 	int (*fn)(struct opal_dev *dev, void *data);
 	void *data;
@@ -266,6 +271,101 @@ static void print_buffer(const u8 *ptr, u32 length)
 #endif
 }
 
+/*
+ * Allocate/update a SED Opal key and add it to the SED Opal keyring.
+ */
+static int update_sed_opal_key(const char *desc, u_char *key_data, int keylen)
+{
+	key_ref_t kr;
+
+	if (!sed_opal_keyring)
+		return -ENOKEY;
+
+	kr = key_create_or_update(make_key_ref(sed_opal_keyring, true), "user",
+				  desc, (const void *)key_data, keylen,
+				  KEY_USR_VIEW | KEY_USR_SEARCH | KEY_USR_WRITE,
+				  KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN |
+					KEY_ALLOC_BYPASS_RESTRICTION);
+	if (IS_ERR(kr)) {
+		pr_err("Error adding SED key (%ld)\n", PTR_ERR(kr));
+		return PTR_ERR(kr);
+	}
+
+	return 0;
+}
+
+/*
+ * Read a SED Opal key from the SED Opal keyring.
+ */
+static int read_sed_opal_key(const char *key_name, u_char *buffer, int buflen)
+{
+	int ret;
+	key_ref_t kref;
+	struct key *key;
+
+	if (!sed_opal_keyring)
+		return -ENOKEY;
+
+	kref = keyring_search(make_key_ref(sed_opal_keyring, true),
+			      &key_type_user, key_name, true);
+
+	if (IS_ERR(kref))
+		ret = PTR_ERR(kref);
+
+	key = key_ref_to_ptr(kref);
+	down_read(&key->sem);
+	ret = key_validate(key);
+	if (ret == 0) {
+		if (buflen > key->datalen)
+			buflen = key->datalen;
+
+		ret = key->type->read(key, (char *)buffer, buflen);
+	}
+	up_read(&key->sem);
+
+	key_ref_put(kref);
+
+	return ret;
+}
+
+static int opal_get_key(struct opal_dev *dev, struct opal_key *key)
+{
+	int ret = 0;
+
+	switch (key->key_type) {
+	case OPAL_INCLUDED:
+		/* the key is ready to use */
+		break;
+	case OPAL_KEYRING:
+		/* the key is in the keyring */
+		ret = read_sed_opal_key(OPAL_AUTH_KEY, key->key, OPAL_KEY_MAX);
+		if (ret > 0) {
+			if (ret > 255) {
+				ret = -ENOSPC;
+				goto error;
+			}
+			key->key_len = ret;
+			key->key_type = OPAL_INCLUDED;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	if (ret < 0)
+		goto error;
+
+	/* must have a PEK by now or it's an error */
+	if (key->key_type != OPAL_INCLUDED || key->key_len == 0) {
+		ret = -EINVAL;
+		goto error;
+	}
+	return 0;
+error:
+	pr_debug("Error getting password: %d\n", ret);
+	return ret;
+}
+
 static bool check_tper(const void *data)
 {
 	const struct d0_tper_features *tper = data;
@@ -2204,6 +2304,9 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 	};
 	int ret;
 
+	ret = opal_get_key(dev, &opal_session->opal_key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
@@ -2237,6 +2340,9 @@ static int opal_revertlsp(struct opal_dev *dev, struct opal_revert_lsp *rev)
 	};
 	int ret;
 
+	ret = opal_get_key(dev, &rev->key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, steps, ARRAY_SIZE(steps));
@@ -2255,6 +2361,9 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 	};
 	int ret;
 
+	ret = opal_get_key(dev, &opal_session->opal_key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
@@ -2283,6 +2392,9 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 	    opal_mbr->enable_disable != OPAL_MBR_DISABLE)
 		return -EINVAL;
 
+	ret = opal_get_key(dev, &opal_mbr->key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
@@ -2308,6 +2420,9 @@ static int opal_set_mbr_done(struct opal_dev *dev,
 	    mbr_done->done_flag != OPAL_MBR_NOT_DONE)
 		return -EINVAL;
 
+	ret = opal_get_key(dev, &mbr_done->key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
@@ -2329,6 +2444,9 @@ static int opal_write_shadow_mbr(struct opal_dev *dev,
 	if (info->size == 0)
 		return 0;
 
+	ret = opal_get_key(dev, &info->key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
@@ -2385,6 +2503,9 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 		return -EINVAL;
 	}
 
+	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, steps, ARRAY_SIZE(steps));
@@ -2407,6 +2528,10 @@ static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal, bool psi
 
 	int ret;
 
+	ret = opal_get_key(dev, opal);
+
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	if (psid)
@@ -2469,6 +2594,9 @@ static int opal_lock_unlock(struct opal_dev *dev,
 	if (lk_unlk->session.who > OPAL_USER9)
 		return -EINVAL;
 
+	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	ret = __opal_lock_unlock(dev, lk_unlk);
 	mutex_unlock(&dev->dev_lock);
@@ -2491,6 +2619,9 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 	if (!dev)
 		return -ENODEV;
 
+	ret = opal_get_key(dev, opal);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, owner_steps, ARRAY_SIZE(owner_steps));
@@ -2513,6 +2644,9 @@ static int opal_activate_lsp(struct opal_dev *dev,
 	if (!opal_lr_act->num_lrs || opal_lr_act->num_lrs > OPAL_MAX_LRS)
 		return -EINVAL;
 
+	ret = opal_get_key(dev, &opal_lr_act->key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, active_steps, ARRAY_SIZE(active_steps));
@@ -2531,6 +2665,9 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 	};
 	int ret;
 
+	ret = opal_get_key(dev, &opal_lrs->session.opal_key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
@@ -2557,6 +2694,14 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 	ret = execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
 	mutex_unlock(&dev->dev_lock);
 
+	if (ret)
+		return ret;
+
+	/* update keyring with new password */
+	ret = update_sed_opal_key(OPAL_AUTH_KEY,
+				  opal_pw->new_user_pw.opal_key.key,
+				  opal_pw->new_user_pw.opal_key.key_len);
+
 	return ret;
 }
 
@@ -2577,6 +2722,9 @@ static int opal_activate_user(struct opal_dev *dev,
 		return -EINVAL;
 	}
 
+	ret = opal_get_key(dev, &opal_session->opal_key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, act_steps, ARRAY_SIZE(act_steps));
@@ -2663,6 +2811,9 @@ static int opal_generic_read_write_table(struct opal_dev *dev,
 {
 	int ret, bit_set;
 
+	ret = opal_get_key(dev, &rw_tbl->key);
+	if (ret)
+		return ret;
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 
@@ -2694,9 +2845,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (!dev)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	if (!dev->supported)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	p = memdup_user(arg, _IOC_SIZE(cmd));
 	if (IS_ERR(p))
@@ -2765,3 +2916,22 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sed_ioctl);
+
+static int __init sed_opal_init(void)
+{
+	struct key *kr;
+
+	kr = keyring_alloc(".sed_opal",
+			   GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
+			   (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW |
+			   KEY_USR_READ | KEY_USR_SEARCH | KEY_USR_WRITE,
+			   KEY_ALLOC_NOT_IN_QUOTA,
+			   NULL, NULL);
+	if (IS_ERR(kr))
+		return PTR_ERR(kr);
+
+	sed_opal_keyring = kr;
+
+	return 0;
+}
+late_initcall(sed_opal_init);
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 3a6082ff97e7..ed21e47bf773 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -24,6 +24,9 @@ bool opal_unlock_from_suspend(struct opal_dev *dev);
 struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv);
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *ioctl_ptr);
 
+#define	OPAL_AUTH_KEY           "opal-boot-pin"
+#define	OPAL_AUTH_KEY_PREV      "opal-boot-pin-prev"
+
 static inline bool is_sed_ioctl(unsigned int cmd)
 {
 	switch (cmd) {
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index bc91987a6328..852d3098ec00 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -44,10 +44,16 @@ enum opal_lock_state {
 	OPAL_LK = 0x04, /* 0100 */
 };
 
+enum opal_key_type {
+	OPAL_INCLUDED = 0,	/* key[] is the key */
+	OPAL_KEYRING,		/* key is in keyring */
+};
+
 struct opal_key {
 	__u8 lr;
 	__u8 key_len;
-	__u8 __align[6];
+	__u8 key_type;
+	__u8 __align[5];
 	__u8 key[OPAL_KEY_MAX];
 };
 
-- 
2.27.0

