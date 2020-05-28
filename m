Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1208B1E6BA8
	for <lists+linux-efi@lfdr.de>; Thu, 28 May 2020 21:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406815AbgE1TtW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 May 2020 15:49:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:16414 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406796AbgE1TtK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 28 May 2020 15:49:10 -0400
IronPort-SDR: fbmfp/K5pdOxVUhXE1rW+XZbcSDxBJ3rVNwkP1GpRESjDKzorSCaPH1Pv2Wy2FaUQvelUEA2t1
 B138melZn1MQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 12:49:06 -0700
IronPort-SDR: 8F9810rEMx6IOPi3omf7m2l5VhxDBULuRDgai1F3PxuNtSGrcFhENKjpRoocZqPScKVtj3DuEJ
 lVfUp+VG43sQ==
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="469254374"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 12:49:06 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] efivarfs: Don't return -EINTR when rate-limiting reads
Date:   Thu, 28 May 2020 12:49:05 -0700
Message-Id: <20200528194905.690-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528194905.690-1-tony.luck@intel.com>
References: <20200528194905.690-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Applications that read EFI variables may see a return
value of -EINTR if they exceed the rate limit and a
signal delivery is attempted while the process is sleeping.

This is quite surprising to the application, which probably
doesn't have code to handle it.

Change the interruptible sleep to a non-interruptible one.

Reported-by: Lennart Poettering <mzxreary@0pointer.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/efivarfs/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 4b8bc4560d70..feaa5e182b7b 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -73,10 +73,8 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	ssize_t size = 0;
 	int err;
 
-	while (!__ratelimit(&file->f_cred->user->ratelimit)) {
-		if (!msleep_interruptible(50))
-			return -EINTR;
-	}
+	while (!__ratelimit(&file->f_cred->user->ratelimit))
+		msleep(50);
 
 	err = efivar_entry_size(var, &datasize);
 
-- 
2.21.1

