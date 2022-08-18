Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43FC5985DA
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbiHRObI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 10:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbiHRObH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 10:31:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F37B9F96;
        Thu, 18 Aug 2022 07:31:05 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IEQYck016278;
        Thu, 18 Aug 2022 14:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tmVVL7O/qn1TjOlvqXwvP1/LiHg+Auw2h/LEJhl9vkE=;
 b=rrKUcLjfzciFadbzAWgEQOz/Ixqlu6sMcKWOOqLgGSNuj3FkII/yoMK8rfXEDYECvF1Z
 BTRcyunecu+kyrVKiVOZGV3IsQLnibtfjdar6nJ21GOtFNfqg5VDMHNggOXLsU/gKrZ2
 6PjG4sWaLKouwZh3cKIwkAEYurandcUQhsDEArgM3GyZYHe6rW2px68EkvSsDAWSPUSI
 ZOswIcZwhDvYn5fNkYUY8Tp0zUY8zBmmOP1Q2E2domiFGJbU8X9byGPdM3vDnf3vm9DC
 1OnrMhsnpVuFeL0F5p+RisWIPoUpNK81FqEYZXgrU3Q7YpHzWe+Q6I0H0MzpQvmMDI6N /A== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1nxkkb1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 14:30:50 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27IEL7xb021351;
        Thu, 18 Aug 2022 14:30:50 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 3j1gh6t00j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 14:30:50 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IEUnPF066286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 14:30:49 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C9067805E;
        Thu, 18 Aug 2022 14:30:49 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11B7B7805F;
        Thu, 18 Aug 2022 14:30:47 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.160.121.241])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 14:30:47 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, axboe@kernel.dk, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, linux-efi@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v2 0/3 RESEND] sed-opal: keyrings, discovery, revert, key store
Date:   Thu, 18 Aug 2022 09:30:42 -0500
Message-Id: <20220818143045.680972-1-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7MTW7VbcQgNFi_6fggS-iI80-yP4aBRD
X-Proofpoint-ORIG-GUID: 7MTW7VbcQgNFi_6fggS-iI80-yP4aBRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0
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

TCG SED Opal is a specification from The Trusted Computing Group
that allows self encrypting storage devices (SED) to be locked at
power on and require an authentication key to unlock the drive.

The current SED Opal implementation in the block driver
requires that authentication keys be provided in an ioctl
so that they can be presented to the underlying SED
capable drive. Currently, the key is typically entered by
a user with an application like sedutil or sedcli. While
this process works, it does not lend itself to automation
like unlock by a udev rule.

The SED block driver has been extended so it can alternatively
obtain a key from a sed-opal kernel keyring. The SED ioctls
will indicate the source of the key, either directly in the
ioctl data or from the keyring.

Two new SED ioctls have also been added. These are:
  1) IOC_OPAL_REVERT_LSP to revert LSP state
  2) IOC_OPAL_DISCOVERY to discover drive capabilities/state

change log:
	- removed platform functions for persistent key storage
	- replaced key update logic with key_create_or_update()
	- minor bracing and padding changes
	- add error returns
	- opal_key structure is application provided but kernel
	  verified
	- added brief description of TCG SED Opal

Greg Joyce (3):
  block: sed-opal: Implement IOC_OPAL_DISCOVERY
  block: sed-opal: Implement IOC_OPAL_REVERT_LSP
  block: sed-opal: keyring support for SED Opal keys

 block/Kconfig                 |   1 +
 block/opal_proto.h            |   4 +
 block/sed-opal.c              | 252 +++++++++++++++++++++++++++++++++-
 include/linux/sed-opal.h      |   5 +
 include/uapi/linux/sed-opal.h |  25 +++-
 5 files changed, 281 insertions(+), 6 deletions(-)


Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
Reported-by: kernel test robot <lkp@intel.com>
base-commit: ff6992735ade75aae3e35d16b17da1008d753d28
-- 
2.27.0

