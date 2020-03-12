Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE9B182681
	for <lists+linux-efi@lfdr.de>; Thu, 12 Mar 2020 02:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbgCLBMd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Mar 2020 21:12:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:5622 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387411AbgCLBMd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 11 Mar 2020 21:12:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 18:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="415756621"
Received: from qiuxu-lab.sh.intel.com ([10.239.53.133])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2020 18:12:30 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     ardb@kernel.org, keescook@chromium.org
Cc:     tony.luck@intel.com, matt@codeblueprint.co.uk,
        liming.gao@intel.com, linux-efi@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v6 0/2] Add capsule-pstore backend support
Date:   Thu, 12 Mar 2020 09:13:12 +0800
Message-Id: <20200312011312.70653-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Change Log v5->v6:
  Part1: No changes.
  Part2: Update capsule-pstore.c file header.
         Move the variable 'efi_capsule_pstore_info' backward (for removing some function declarations).


History:
  The v5 was sent about two years ago [1]. At that time there was a concern about the EFI system table
  entry 'CapsulePtr' as below: whether it was an array of capsules or an array of pointers to capsules.

      typedef struct { UINT32 CapsuleArrayNumber; VOID* CapsulePtr[1]; } EFI_CAPSULE_TABLE;

  The latest UEFI specification v2.8 [2] has a clarification in P268 for 'CapsulePtr'  as below:

      "CapsulePtr A pointer to an array of capsules that contain the same CapsuleGuid value.
       Each CapsulePtr points to an instance of an EFI_CAPSULE_HEADER, with the capsule data
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
       concatenated on its end."
       ^^^^^^^^^^^^^^^^^^^^^^^

  According to the highlighted description above, the 'CapsulePtr' should be an array of pointers to capsules.
  The capsule-pstore driver and the tested BIOS also use the 'CapsulePtr' as an array of pointers to capsules.


Test:
  The v6 is well-tested on an Intel Kaby Lake client platform + BIOS(10/24/2016) and an Intel Ice Lake
  client platform + BIOS(09/12/2019).

Reference:
  [1] https://lore.kernel.org/linux-efi/?q=capsule-pstore
  [2] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_A_Feb14.pdf 

Qiuxu Zhuo (2):
  efi: Add 'nr_config_table' variable in efi structure
  eif/capsule-pstore: Add capsule pstore backend

 arch/x86/platform/efi/efi.c           |   1 +
 drivers/firmware/efi/Kconfig          |  21 +
 drivers/firmware/efi/Makefile         |   1 +
 drivers/firmware/efi/arm-init.c       |   4 +-
 drivers/firmware/efi/capsule-pstore.c | 692 ++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c            |   1 +
 include/linux/efi.h                   |   1 +
 7 files changed, 720 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/capsule-pstore.c

-- 
2.17.1

