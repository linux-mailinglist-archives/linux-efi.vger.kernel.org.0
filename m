Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02B8296DFB
	for <lists+linux-efi@lfdr.de>; Fri, 23 Oct 2020 13:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463219AbgJWLyq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Oct 2020 07:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463215AbgJWLyp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Oct 2020 07:54:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBE8C0613CE;
        Fri, 23 Oct 2020 04:54:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s22so1039492pga.9;
        Fri, 23 Oct 2020 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=08FxWPaHOZfE7vb8PUbzmWXfr0VHNirhD4p1dQWe7f8=;
        b=HIBBt/puogeHvSvzCMXjQXsQgSaRU3Y65wcmIEES6DFYsPJ9NIPvuUdOWI+IP+ITXc
         v3I36L7CxFXMul1PTDIPZoPoSQjR45g2PeSu2yQjixGNHkWtBQydLavAdKvx5E8FlXbc
         u3Rx7IkRpLEnd9Poa4m+SxxWvx5Odzq3SHYcbNvOHGhwfD0XqTtNTQAaoxOKWiOC4oIF
         J/HpJcRMlVfJKUQhudLBfRqcxf/gfEovbGhfnvEb96kJee6vmYKhuiwbV+DuQDgqIMv6
         o6HXuoglMZXAzn5HRXoYq0MDsaJp+R+7SzRcj4dl8ZKbP79dcP+h75aKhIW/yOHvaPca
         v/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=08FxWPaHOZfE7vb8PUbzmWXfr0VHNirhD4p1dQWe7f8=;
        b=RigfmX68P6AkHA0aozJH20Z+zyHFquSXn//JRD5a+1q+u50iztB8K5JiwfYBeQtNok
         2jkxyAFy8w0CjuBDaAOzrocK6dZ3X+zjrzalkZ9AgE8zt+nsw5UoxaOSnCZAGo/A1+HA
         jzE8SJoxfAGGyhU0JL+IszX0Wq5h49H94MfkGpOJaWL0wb3ODZBQk/TxrBgm5m1aeI6H
         FH/Pq3P+S4bk4eOHiJWrV6H8IwpT4jzkXkr5U0uIY5BNqzKMIj6qgCQv6RRIqeUcZPFs
         RQrftDWrRh0IMDZewP1KXSki27JaiLFN+VGkSlC8GRyeR2Pl2FW300C5NJ/c2cN8i54P
         L0kw==
X-Gm-Message-State: AOAM532kAHUhqbl89VUhmCjQWd4XEYPvftfwUR03363U7kWt/nsLjsJW
        gnavYSM2qP12TF+g0nKe9p10hblDtKc=
X-Google-Smtp-Source: ABdhPJyxxJf8RIPJtC70buGn5yiDFudcz3rMy2wb94QjGYSyyE9/w8cJm2EE5WVI4Lj2ejzFogJlAg==
X-Received: by 2002:a17:90a:7788:: with SMTP id v8mr2199447pjk.8.1603454084224;
        Fri, 23 Oct 2020 04:54:44 -0700 (PDT)
Received: from cosmos ([103.113.142.250])
        by smtp.gmail.com with ESMTPSA id s8sm2080852pjn.46.2020.10.23.04.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 04:54:43 -0700 (PDT)
Date:   Fri, 23 Oct 2020 17:24:39 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     matthew.garrett@nebula.com, jk@ozlabs.org, ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efivarfs: fix memory leak in efivarfs_create()
Message-ID: <20201023115429.GA2479@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

kmemleak report:
  unreferenced object 0xffff9b8915fcb000 (size 4096):
  comm "efivarfs.sh", pid 2360, jiffies 4294920096 (age 48.264s)
  hex dump (first 32 bytes):
    2d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  -...............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000cc4d897c>] kmem_cache_alloc_trace+0x155/0x4b0
    [<000000007d1dfa72>] efivarfs_create+0x6e/0x1a0
    [<00000000e6ee18fc>] path_openat+0xe4b/0x1120
    [<000000000ad0414f>] do_filp_open+0x91/0x100
    [<00000000ce93a198>] do_sys_openat2+0x20c/0x2d0
    [<000000002a91be6d>] do_sys_open+0x46/0x80
    [<000000000a854999>] __x64_sys_openat+0x20/0x30
    [<00000000c50d89c9>] do_syscall_64+0x38/0x90
    [<00000000cecd6b5f>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

In efivarfs_create(), inode->i_private is setup with efivar_entry
object which is never freed.

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 fs/efivarfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 15880a6..f943fd0 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -21,6 +21,7 @@ LIST_HEAD(efivarfs_list);
 static void efivarfs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
+	kfree(inode->i_private);
 }
 
 static const struct super_operations efivarfs_ops = {
-- 
2.7.4

