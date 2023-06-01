Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E0071A002
	for <lists+linux-efi@lfdr.de>; Thu,  1 Jun 2023 16:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjFAOaB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Jun 2023 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjFAO3w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Jun 2023 10:29:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED998;
        Thu,  1 Jun 2023 07:29:51 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351ESGQA002486;
        Thu, 1 Jun 2023 14:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=CcPfCzY8208PdCOnE1aO6P15WOICSUETE+4+BuarsJ4=;
 b=glePTwE33g12AqTcQp4b5bnMaxXtrd5xg2kPD1vJknFsnN2IIsVVBRHlJvun7/jKDi9Z
 hWWMlfMXTk0j1gTbo1iBvWVL/Y6cPX00ORLM8ywqcXOz6dZSCNovDBKy4Y2D6CBiEFOO
 3imgXNaWcdgUEOvUY0VpdavdJAI2hGtxsfkY/8r/1/S8R++jMP+7ybT3IklCtE3+I/Qh
 2zfAU5TeB1VJU0+Qraacmr8CeQ4R1wZrd9ykrpQPb12jZ/H1lZLLmbBAhQkDYXS3xWL6
 bYtaQYZMzyFDap6YeMcsjhKnslMsagN8LedS0BUekyOv75K6CK31kjgCGho9F4K9uxQF 4Q== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxw4fg0wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 14:29:30 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 351C6hSo012658;
        Thu, 1 Jun 2023 14:29:30 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g625tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 14:29:29 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 351ETSAT57737500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jun 2023 14:29:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8577358067;
        Thu,  1 Jun 2023 14:29:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E82A5805D;
        Thu,  1 Jun 2023 14:29:28 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.58.163])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jun 2023 14:29:28 +0000 (GMT)
Message-ID: <9a752cf0b1e1d6f4ee2744fa3979f323b863dbbd.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] block:sed-opal: SED Opal keystore
From:   Greg Joyce <gjoyce@linux.vnet.ibm.com>
Reply-To: gjoyce@linux.vnet.ibm.com
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        axboe@kernel.dk, akpm@linux-foundation.org,
        linux-efi@vger.kernel.org, keyrings@vger.kernel.org,
        me@benboeckel.net, elliott@hpe.com, andonnel@au1.ibm.com
Date:   Thu, 01 Jun 2023 09:29:28 -0500
In-Reply-To: <CSIYR76Z8U02.30IIQJ49LMY05@suppilovahvero>
References: <20230505194402.2079010-1-gjoyce@linux.vnet.ibm.com>
         <20230505194402.2079010-2-gjoyce@linux.vnet.ibm.com>
         <CSIYR76Z8U02.30IIQJ49LMY05@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DlyEBDRksE0zBECYKv0_QIgClff7ChD6
X-Proofpoint-ORIG-GUID: DlyEBDRksE0zBECYKv0_QIgClff7ChD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 mlxlogscore=984 clxscore=1011 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2023-05-11 at 01:50 +0300, Jarkko Sakkinen wrote:
> On Fri May 5, 2023 at 10:43 PM EEST,  wrote:
> > From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> > 
> > Add read and write functions that allow SED Opal keys to stored
> > in a permanent keystore.
> 
> Please be more verbose starting from "Self-Encrypting Drive (SED)",
> instead of just "SED", and take time to explain what these keys are.

A further elaboration of SED and the keys will be in the next patchset.

> 
> > Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> > Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> > ---
> >  block/Makefile               |  2 +-
> >  block/sed-opal-key.c         | 24 ++++++++++++++++++++++++
> >  include/linux/sed-opal-key.h | 15 +++++++++++++++
> >  3 files changed, 40 insertions(+), 1 deletion(-)
> >  create mode 100644 block/sed-opal-key.c
> >  create mode 100644 include/linux/sed-opal-key.h
> > 
> > diff --git a/block/Makefile b/block/Makefile
> > index 4e01bb71ad6e..464a9f209552 100644
> > --- a/block/Makefile
> > +++ b/block/Makefile
> > @@ -35,7 +35,7 @@ obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
> >  obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
> >  obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
> >  obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
> > -obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
> > +obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o sed-opal-key.o
> >  obj-$(CONFIG_BLK_PM)		+= blk-pm.o
> >  obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-
> > crypto-profile.o \
> >  					   blk-crypto-sysfs.o
> > diff --git a/block/sed-opal-key.c b/block/sed-opal-key.c
> > new file mode 100644
> > index 000000000000..16f380164c44
> > --- /dev/null
> > +++ b/block/sed-opal-key.c
> > @@ -0,0 +1,24 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * SED key operations.
> > + *
> > + * Copyright (C) 2022 IBM Corporation
> > + *
> > + * These are the accessor functions (read/write) for SED Opal
> > + * keys. Specific keystores can provide overrides.
> > + *
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/sed-opal-key.h>
> > +
> > +int __weak sed_read_key(char *keyname, char *key, u_int *keylen)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +int __weak sed_write_key(char *keyname, char *key, u_int keylen)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > diff --git a/include/linux/sed-opal-key.h b/include/linux/sed-opal-
> > key.h
> > new file mode 100644
> > index 000000000000..c9b1447986d8
> > --- /dev/null
> > +++ b/include/linux/sed-opal-key.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * SED key operations.
> > + *
> > + * Copyright (C) 2022 IBM Corporation
> > + *
> > + * These are the accessor functions (read/write) for SED Opal
> > + * keys. Specific keystores can provide overrides.
> > + *
> > + */
> > +
> > +#include <linux/kernel.h>
> > +
> > +int sed_read_key(char *keyname, char *key, u_int *keylen);
> > +int sed_write_key(char *keyname, char *key, u_int keylen);
> > -- 
> > gjoyce@linux.vnet.ibm.com
> 
> BR, Jarkko

