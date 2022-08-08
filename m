Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8836358CB6D
	for <lists+linux-efi@lfdr.de>; Mon,  8 Aug 2022 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbiHHPoI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Aug 2022 11:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiHHPoH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Aug 2022 11:44:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A121E1E8;
        Mon,  8 Aug 2022 08:44:06 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278EQG4m023357;
        Mon, 8 Aug 2022 15:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TJRNHRKMYb+wVCTUJoKgdADLtCM9GmrKnPjThoWBHlM=;
 b=tI16lyH+taLovUzzgjkd7N6g+v6kBA7yOnia5elj8PpZApKFe7fzhz6vecoEAfgdB3BN
 lUVx2TGNiJ+zXSexObttnbtj/O4NVDf6vHnDVR7zFA6QMtjTGXOkVvYkCHL2+i/aJVn3
 hO9tg89MAHGOwFsuWdfJ0Vlsets9c/DVCjhdGVs8vVmBAUwbnufL5To1Sd57xnJEfi6U
 x6sf96NhBYBjTwx9rQImXnSNLiVjFR8E3uMHHp7IwhMRvppLGmXDdXGrRXnixMGtDkNF
 7Px4PT385HBA/usNL7iHr2K5ubHP6qGIZk7NBzM6IJ865F8lQWu/BTR4PVJRDrEpmcjE mg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu48fawdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 15:43:50 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 278FaInk001436;
        Mon, 8 Aug 2022 15:43:49 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 3hsfx98m4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 15:43:49 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 278FhmFT18809532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 15:43:48 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4BA17805F;
        Mon,  8 Aug 2022 15:43:48 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 856E478066;
        Mon,  8 Aug 2022 15:43:47 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.160.34.213])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 15:43:47 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, axboe@kernel.dk, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, linux-efi@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v3a 0/2] generic and PowerPC accessor functions for arch keystore
Date:   Mon,  8 Aug 2022 10:43:43 -0500
Message-Id: <20220808154345.11240-1-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xQ0zENTjHMPLyJS0S3NO8-iy9hc8sWi0
X-Proofpoint-ORIG-GUID: xQ0zENTjHMPLyJS0S3NO8-iy9hc8sWi0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxlogscore=843 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Greg Joyce <gjoyce@linux.vnet.ibm.com>

Changelog v3a:
        - No code changes, but per reviewer requests, adding additional
          mailing lists(keyring, EFI) for wider review.

Architectural neutral functions have been defined for accessing
architecture specific variable store. The neutral functions are
defined as weak so that they may be superseded by platform
specific versions. The functions have been desigined so that 
they can support a large range of platforms/architectures.

PowerPC/pseries versions of these functions provide read/write access
to the non-volatile PLPKS data store.

This functionality allows kernel code such as the block SED opal
driver to store authentication keys in a secure permanent store.

Greg Joyce (2):
  lib: define generic accessor functions for arch specific keystore
  powerpc/pseries: Override lib/arch_vars.c functions

 arch/powerpc/platforms/pseries/Makefile       |   1 +
 .../platforms/pseries/plpks_arch_ops.c        | 167 ++++++++++++++++++
 include/linux/arch_vars.h                     |  23 +++
 lib/Makefile                                  |   2 +-
 lib/arch_vars.c                               |  25 +++
 5 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks_arch_ops.c
 create mode 100644 include/linux/arch_vars.h
 create mode 100644 lib/arch_vars.c


Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
base-commit: ff6992735ade75aae3e35d16b17da1008d753d28
-- 
2.27.0

