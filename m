Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C245444DCE
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2019 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfFMUun (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jun 2019 16:50:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfFMUun (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jun 2019 16:50:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DKkomT138026
        for <linux-efi@vger.kernel.org>; Thu, 13 Jun 2019 16:50:42 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3v5gm66e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Thu, 13 Jun 2019 16:50:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Thu, 13 Jun 2019 21:50:39 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 21:50:34 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DKoPUi28442968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 20:50:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C52C552050;
        Thu, 13 Jun 2019 20:50:32 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.207.125])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B23F752051;
        Thu, 13 Jun 2019 20:50:29 +0000 (GMT)
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
Subject: [PATCH 0/2] powerpc/powernv: expose secure variables to userspace 
Date:   Thu, 13 Jun 2019 16:50:25 -0400
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19061320-0028-0000-0000-0000037A1891
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061320-0029-0000-0000-0000243A12FA
Message-Id: <1560459027-5248-1-git-send-email-nayna@linux.ibm.com>
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

This patch set is part of a series that implements secure boot on PowerNV
systems[1]. The original series had been split into two patchsets:
1. powerpc: enable ima arch specific policies[2]
2. powerpc/powernv: expose secure variables to userspace, which is this
patchset.

Since there are major changes in this patchset compared to the previous
one[1], I am posting it as new series rather than v2.

As part of PowerNV secure boot support, NV OS verification keys are stored
and controlled by OPAL as secure variables. However, to allow users to
manage these keys, the secure variables need to be exposed to userspace.

OPAL provides the runtime services for the kernel to be able to access the
secure variables[3]. This patchset defines the kernel interface for the
OPAL APIs. These APIs are used by the hooks, which expose these variables
to userspace for reading/writing.

In order to reuse the existing tools, we currently use the efi hooks to
expose the secure variables via sysfs. Keeping the usability and
maintainability in mind, we are starting with this scheme as simple sysfs
implementation. We expect to refine it over time as we incorporate the
feedback.

The patchset makes substantial reuse of drivers/firmware/efi/efivars.c and
drivers/firmware/efi/vars.c, however because POWER platforms do not use
EFI, a new config, POWER_SECVAR_SYSFS, is defined to enable this sysfs
interface in POWER.

This patchset has a pre-requisiste of other OPAL APIs which are posted as
part of ima arch specific patches[2].

[1]https://patchwork.kernel.org/cover/10882149/  
[2]https://lkml.org/lkml/2019/6/11/868
[3]https://patchwork.ozlabs.org/project/skiboot/list/?series=112868 

Claudio Carvalho (1):
  powerpc/powernv: add OPAL APIs for secure variables

Nayna Jain (1):
  powerpc: expose secure variables via sysfs

 arch/powerpc/Kconfig                         |   2 +
 arch/powerpc/include/asm/opal-api.h          |   3 +
 arch/powerpc/include/asm/opal-secvar.h       |   9 +
 arch/powerpc/include/asm/opal.h              |   8 +
 arch/powerpc/platforms/powernv/opal-call.c   |   3 +
 arch/powerpc/platforms/powernv/opal-secvar.c |  60 +++-
 drivers/firmware/Makefile                    |   1 +
 drivers/firmware/efi/efivars.c               |   2 +-
 drivers/firmware/powerpc/Kconfig             |  12 +
 drivers/firmware/powerpc/Makefile            |   3 +
 drivers/firmware/powerpc/efi_error.c         |  46 +++
 drivers/firmware/powerpc/secvar.c            | 326 +++++++++++++++++++
 12 files changed, 473 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/powerpc/Kconfig
 create mode 100644 drivers/firmware/powerpc/Makefile
 create mode 100644 drivers/firmware/powerpc/efi_error.c
 create mode 100644 drivers/firmware/powerpc/secvar.c

-- 
2.20.1

