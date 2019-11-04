Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A211EE368
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2019 16:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfKDPRG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Nov 2019 10:17:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDPRG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Nov 2019 10:17:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4FCH2q032157;
        Mon, 4 Nov 2019 15:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=+83lcVguJyvnyafDeVP9ncl+WMvkJ+8ZOi3EzqtPjgg=;
 b=ILq4JoZ91xi0X3BXYbFx3Jh8Aov5v6iXEjEc8SDZw/oOBGdKSX//iFs7g5bXLcofHE+j
 0vEJXr3MXBR+RsxU1IHBhSehGzuhhZhGkQ05jap4OVRaCocR7O96nIop/p4fI11n0+Nb
 QKysaIwRZnn58e6Fh/GR4foux9BMiMMqHGZTXLiNqmAI4SgNZUxyWNkgxahaHDs+1x21
 iJjsxkaWE7GsYTMp7/OStbWM8FMZCyBk68WXMEZxPH173hsbVjnuRG2fyEXlseydpbu6
 Tos8URXi3eSie9mw/WGIlY7CEWPRyqcwu3/3OMb1ngMxtu52S/NbipUYBE4zleispc7n LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2w11rpr139-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 15:14:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4FB2JA136281;
        Mon, 4 Nov 2019 15:14:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w1k8uxutt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 15:14:30 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA4FEKf4002177;
        Mon, 4 Nov 2019 15:14:25 GMT
Received: from tomti.i.net-space.pl (/10.175.168.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 07:14:16 -0800
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com, rdunlap@infradead.org,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v5 0/3] x86/boot: Introduce the kernel_info et consortes
Date:   Mon,  4 Nov 2019 16:13:51 +0100
Message-Id: <20191104151354.28145-1-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=663
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=742 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040151
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
 arch/x86/kernel/kdebugfs.c             |  20 +++++++--
 arch/x86/kernel/ksysfs.c               |  30 ++++++++++----
 arch/x86/kernel/setup.c                |   4 ++
 arch/x86/mm/ioremap.c                  |  11 +++++
 13 files changed, 298 insertions(+), 16 deletions(-)

Daniel Kiper (3):
      x86/boot: Introduce the kernel_info
      x86/boot: Introduce the kernel_info.setup_type_max
      x86/boot: Introduce the setup_indirect

