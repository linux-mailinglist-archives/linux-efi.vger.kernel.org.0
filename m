Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F08EE3158
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2019 13:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439331AbfJXLtc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Oct 2019 07:49:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46116 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfJXLtc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Oct 2019 07:49:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OBdBot022926;
        Thu, 24 Oct 2019 11:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=+83lcVguJyvnyafDeVP9ncl+WMvkJ+8ZOi3EzqtPjgg=;
 b=PpqDwkeJLhJ7Ingfq7KJFOlkrifCd+/mA6l8d9UJ1OOM/xI0iraz0D8SdpNPN0VdCxTa
 xoUl6oQNnxJdYQ69+qro0MemPKSRZLJesx7Mq3CCloJRBn2sbnhIdzna6ddDNltl/eEd
 gIV2KA9OKZ2qd8GcfHEZlEjZSmR+gY1DGF8oh+0JyDSUFLo00OhWzNVR4zz9m71jpbrn
 gvuccVAW7JjSwBDWewa7pc8WRmYf6Mk8W4x4j2UOeuAmTmp35PqTXSOdLXVQdw7IYPZR
 PRQqjrPEGuMAZnr6hVloS9IaWycgWbMs+G9wF9wPmSlHlB65eAxQT4kJRhZqbb8/+Tig ZQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4r2vjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 11:48:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OBeE34147828;
        Thu, 24 Oct 2019 11:48:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vtsk4kdhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 11:48:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9OBmc76019554;
        Thu, 24 Oct 2019 11:48:38 GMT
Received: from tomti.i.net-space.pl (/10.175.165.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 04:48:37 -0700
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com, rdunlap@infradead.org,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v4 0/3] x86/boot: Introduce the kernel_info et consortes
Date:   Thu, 24 Oct 2019 13:48:11 +0200
Message-Id: <20191024114814.6488-1-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=663
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=742 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240116
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

