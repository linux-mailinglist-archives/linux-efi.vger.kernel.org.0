Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 947A31655C9
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 04:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBTDnY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 22:43:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727370AbgBTDnY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 22:43:24 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 66B2FF2315AB71E79447;
        Thu, 20 Feb 2020 11:43:21 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Feb 2020 11:43:12 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <ardb@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>,
        <dvhart@infradead.org>, <andy@infradead.org>
CC:     <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-mm@kvack.org>,
        <wangkefeng.wang@huawei.com>, <jingxiangfeng@huawei.com>
Subject: [PATCH 0/2] arm64: Support to find mirrored memory ranges
Date:   Fri, 21 Feb 2020 07:52:58 -0500
Message-ID: <1582289580-24045-1-git-send-email-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series enable finding mirrored memory ranges
functionality on arm64 platform. This feature has been
implemented on the x86 platform, so we move some
functions from x86.

Jing Xiangfeng (2):
  efi: allow EFI_FAKE_MEMMAP on arm64 platform
  arm64/efi: support to find mirrored memory ranges

 arch/x86/include/asm/efi.h      |  5 -----
 arch/x86/platform/efi/efi.c     | 39 ---------------------------------------
 drivers/firmware/efi/Kconfig    |  2 +-
 drivers/firmware/efi/arm-init.c |  2 ++
 drivers/firmware/efi/efi.c      | 23 +++++++++++++++++++++++
 drivers/firmware/efi/memmap.c   | 16 ++++++++++++++++
 include/linux/efi.h             |  5 +++++
 7 files changed, 47 insertions(+), 45 deletions(-)

-- 
1.8.3.1

