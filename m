Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9934E1E6BA7
	for <lists+linux-efi@lfdr.de>; Thu, 28 May 2020 21:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406802AbgE1TtN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 May 2020 15:49:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:16406 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406795AbgE1TtL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 28 May 2020 15:49:11 -0400
IronPort-SDR: Q75qmzpaYoeO4BacWbyZAZTcmtaHeyTwh8uNujY3Sk+r4Sw9tFVk8h8sRmfJidVB7ecr0+oVjc
 ZoAVKdoUpdSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 12:49:06 -0700
IronPort-SDR: m8lmjzMvQLLU30r8CJme98SnP9j9uLCHw64wASn4v8w9Ug95kRxsV1cjU9WDrKEhU9RNHRP6r+
 DEV6EMU5LEyA==
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="469254370"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 12:49:05 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] efivarfs: Update inode modification time for successful writes
Date:   Thu, 28 May 2020 12:49:04 -0700
Message-Id: <20200528194905.690-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528194905.690-1-tony.luck@intel.com>
References: <20200528194905.690-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some applications want to be able to see when EFI variables
have been updated.

Update the modification time for successful writes.

Reported-by: Lennart Poettering <mzxreary@0pointer.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/efivarfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index e9e27a271af0..4b8bc4560d70 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -51,6 +51,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
+		inode->i_mtime = current_time(inode);
 		inode_unlock(inode);
 	}
 
-- 
2.21.1

