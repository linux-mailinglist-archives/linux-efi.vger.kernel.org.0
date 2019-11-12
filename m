Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28332F90FA
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 14:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfKLNs5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 08:48:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42184 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfKLNs4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Nov 2019 08:48:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACDimK6003260;
        Tue, 12 Nov 2019 13:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=sMMKPgpww4smX1YXtV6wvZBBiRbV6FeG/gIOCQT+ds0=;
 b=Bq6pJIEVs4RMpNnXnIBOggUpB4Pl+OJCfwsaO7OdULOY1eVaDRgmE4FttDhZAl2GFacg
 Jc5xudY3smfglUuw/njbjej9AVjqLt2Y9N7TKzdzczNr6CW7EocX6h0e//J3Pj27Lm05
 SbcaevEvvY1l5GUe796cnfT+9fhFKLKdUueVLLdw0ojx9iPLUJ2tum5VGUu5djZtUKrL
 9MupeomPWigh66UlhkInUrtyqKTUArrVvaC4BEbPfur+MfwYXWVuxbF+Ed7tU9wQy4vC
 oHcCCQb7+V4v4C8C1aDl1Sy36cz9HSL9FhfUob7U0bo3Pb+mcXeLSCTCa4zhKO6qjY4y IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2w5mvtmvda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 13:47:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACDhMli076743;
        Tue, 12 Nov 2019 13:47:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2w7vbav1xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 13:47:04 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xACDkuC7009057;
        Tue, 12 Nov 2019 13:46:58 GMT
Received: from tomti.i.net-space.pl (/10.175.202.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 05:46:56 -0800
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com, rdunlap@infradead.org,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v6 0/3] x86/boot: Introduce the kernel_info et consortes
Date:   Tue, 12 Nov 2019 14:46:37 +0100
Message-Id: <20191112134640.16035-1-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=659
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=725 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120124
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

 Documentation/x86/boot.rst             | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/boot/Makefile                 |   2 +-
 arch/x86/boot/compressed/Makefile      |   4 +-
 arch/x86/boot/compressed/kaslr.c       |  12 ++++++
 arch/x86/boot/compressed/kernel_info.S |  22 ++++++++++
 arch/x86/boot/header.S                 |   3 +-
 arch/x86/boot/tools/build.c            |   5 +++
 arch/x86/include/uapi/asm/bootparam.h  |  16 +++++++-
 arch/x86/kernel/e820.c                 |  11 +++++
 arch/x86/kernel/kdebugfs.c             |  21 ++++++++--
 arch/x86/kernel/ksysfs.c               |  31 ++++++++++----
 arch/x86/kernel/setup.c                |   6 +++
 arch/x86/mm/ioremap.c                  |  11 +++++
 13 files changed, 302 insertions(+), 16 deletions(-)

Daniel Kiper (3):
      x86/boot: Introduce the kernel_info
      x86/boot: Introduce the kernel_info.setup_type_max
      x86/boot: Introduce the setup_indirect

