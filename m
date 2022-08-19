Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006D259A89A
	for <lists+linux-efi@lfdr.de>; Sat, 20 Aug 2022 00:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiHSWcJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 18:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbiHSWcH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 18:32:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F65104454;
        Fri, 19 Aug 2022 15:32:03 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JMCNnO024495;
        Fri, 19 Aug 2022 22:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=hNKyeozekJi2PjSmCRORvmrhcMPzXAsfxftZ27DJ9Qw=;
 b=hyBFHOOXVBzb+to2sr9kmbHFrZl2eCLmIHAagliGWkI3C23CpcV5kNL7e3RKTq6BwEMt
 r9GGSnD8vQ46BRDP4UrNbQr+Qe+QKi3rEQIBsY3G54uORnxIDwmb1gJDQfBidC2zPTM3
 JmUh2wQzwG91OuYeDouf15rZ2cKR292eIe4i8e210xaog7a8yvuignza9iZQ1zw8l+7o
 bCs58MdvQYg/gQHJY1CGUxS2RgFZtuy78pI4iQLHKESxU6oIghWPExAoBjDerLcDoTcC
 XDlm8YHPqCvyps6cWTKHBPWasr8wlYLnuy/z9EdvOdBmngD54pnxlInmoVb/GdXmd8Ay GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j2k3r8cdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 22:31:50 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27JMIpMB030831;
        Fri, 19 Aug 2022 22:31:49 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j2k3r8ccu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 22:31:49 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27JMKYCs014015;
        Fri, 19 Aug 2022 22:31:42 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 3hx3k9ycbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 22:31:42 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27JMVgSe1049312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 22:31:42 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 116856A05A;
        Fri, 19 Aug 2022 22:31:42 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1D496A058;
        Fri, 19 Aug 2022 22:31:40 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.65.239.18])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 19 Aug 2022 22:31:40 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, axboe@kernel.dk, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, linux-efi@vger.kernel.org,
        keyrings@vger.kernel.org, dhowells@redhat.com, jarkko@kernel.org
Subject: [PATCH v4 0/3] generic and PowerPC SED Opal keystore
Date:   Fri, 19 Aug 2022 17:31:35 -0500
Message-Id: <20220819223138.1457091-1-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9GrR6jiHhfNafSagfKQMJuYdnROVExZt
X-Proofpoint-ORIG-GUID: t3HxNYASMQEfOSD_lY1vCFuVW_HE2PHy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=896 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Greg Joyce <gjoyce@linux.vnet.ibm.com>

Generic functions have been defined for accessing SED Opal keys.
The generic functions are defined as weak so that they may be superseded
by keystore specific versions.

PowerPC/pseries versions of these functions provide read/write access
to SED Opal keys in the PLPKS keystore.

The SED block driver has been modified to read the SED Opal
keystore to populate a key in the SED Opal keyring. Changes to the
SED Opal key will be written to the SED Opal keystore.

Patch 3 "keystore access for SED Opal keys" is dependent on:
        https://lore.kernel.org/keyrings/20220818143045.680972-4-gjoyce@linux.vnet.ibm.com/T/#u

Changelog
v4:
        - scope reduced to cover just SED Opal keys
        - base SED Opal keystore is now in SED block driver
        - removed use of enum to indicate type
        - refactored common code into common function that read and
          write use
        - removed cast to void
        - added use of SED Opal keystore functions to SED block driver

v3:
        - No code changes, but per reviewer requests, adding additional
          mailing lists(keyring, EFI) for wider review.

v2:
	- Include feedback from Gregory Joyce, Eric Richter and
	  Murilo Opsfelder Araujo.
	- Include suggestions from Michael Ellerman.
	- Moved a dependency from generic SED code to this patchset.
	  This patchset now builds of its own.

Greg Joyce (3):
  block: sed-opal: SED Opal keystore
  powerpc/pseries: PLPKS SED Opal keystore support
  block: sed-opal: keystore access for SED Opal keys

 arch/powerpc/platforms/pseries/Makefile       |   1 +
 .../powerpc/platforms/pseries/plpks_sed_ops.c | 124 ++++++++++++++++++
 block/Makefile                                |   2 +-
 block/sed-opal-key.c                          |  23 ++++
 block/sed-opal.c                              |  17 ++-
 include/linux/sed-opal-key.h                  |  15 +++
 6 files changed, 179 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks_sed_ops.c
 create mode 100644 block/sed-opal-key.c
 create mode 100644 include/linux/sed-opal-key.h

-- 
gjoyce@linux.vnet.ibm.com

