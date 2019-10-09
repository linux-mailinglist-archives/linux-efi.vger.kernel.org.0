Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFDFD0D3B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2019 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfJIKzX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 06:55:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42494 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfJIKzW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Oct 2019 06:55:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99An3EM076380;
        Wed, 9 Oct 2019 10:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=M33GVO9Y3jme01jHHD3zcMXHqJ6aM2z9oePhh2hkmuM=;
 b=qqpha/Te0Pky6KVXQk6AfDXZU2rXagKbsGeiW09MRWld8zjLm9/Ca+V9NZIcRUTcP1Hp
 w/n76C552Hetap0fxKNnEQ9LoesxXYBtHMlazkm5/rKaq8t+L67kAFN8CLu6yeVTWF0s
 wyiJP5m6Bqi94EcYz3RRLU2ytkAMDkl8YB0uNEe2vIYai8pcGNSnD+gpdHHpH6vRxPCs
 eSQmKOJRg8QQNG+Y/UYNW30dTChC2GdjjKcrtFeM7JLrbudajEHPoMJCfB5LpJeYwKZ4
 FnUtQeYQkIpc4mTqkcxGD99Qz2QUOihkg5ZrrxY/v2c3vHt+xJIyNEqNfjvvzTUSaKIn +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vejkukb03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 10:54:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99AmbN2162723;
        Wed, 9 Oct 2019 10:54:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vh5caap72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 10:54:24 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x99AsHxQ031048;
        Wed, 9 Oct 2019 10:54:19 GMT
Received: from tomti.i.net-space.pl (/10.175.167.68)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 03:54:16 -0700
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, konrad.wilk@oracle.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v3 0/3] x86/boot: Introduce the kernel_info et consortes
Date:   Wed,  9 Oct 2019 12:53:55 +0200
Message-Id: <20191009105358.32256-1-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=672
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=747 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090101
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

Due to very limited space in the setup_header this patch series introduces new
kernel_info struct which will be used to convey information from the kernel to
the bootloader. This way the boot protocol can be extended regardless of the
setup_header limitations. Additionally, the patch series introduces some
convenience features like the setup_indirect struct and the
kernel_info.setup_type_max field.

Daniel

 Documentation/x86/boot.rst             | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/boot/Makefile                 |   2 +-
 arch/x86/boot/compressed/Makefile      |   4 +-
 arch/x86/boot/compressed/kaslr.c       |  12 ++++++
 arch/x86/boot/compressed/kernel_info.S |  22 +++++++++++
 arch/x86/boot/header.S                 |   3 +-
 arch/x86/boot/tools/build.c            |   5 +++
 arch/x86/include/uapi/asm/bootparam.h  |  16 +++++++-
 arch/x86/kernel/e820.c                 |  11 ++++++
 arch/x86/kernel/kdebugfs.c             |  20 ++++++++--
 arch/x86/kernel/ksysfs.c               |  30 ++++++++++----
 arch/x86/kernel/setup.c                |   4 ++
 arch/x86/mm/ioremap.c                  |  11 ++++++
 13 files changed, 292 insertions(+), 16 deletions(-)

Daniel Kiper (3):
      x86/boot: Introduce the kernel_info
      x86/boot: Introduce the kernel_info.setup_type_max
      x86/boot: Introduce the setup_indirect

