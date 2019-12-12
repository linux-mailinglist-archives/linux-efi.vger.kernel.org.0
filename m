Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7111D89C
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 22:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfLLVeq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 16:34:46 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37688 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbfLLVeq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 16:34:46 -0500
Received: by mail-qk1-f193.google.com with SMTP id m188so49832qkc.4
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 13:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H2nKgCZNFFEBZCU2Z37qQNI7htkAaxmvPk6e+dzcsRQ=;
        b=RqjJiEMCaJHl5clxBnYh9arA8mG5J+lAD+1CKvq/z7EMSF/hMB6bfgbiYHefe7Mnuq
         LFndLw/EtxnMcK/UqTjitDJeiJr99wq464mtycRqXvi2Z5q5wpx16BCvCyk0DPRFElmz
         OilJWhRO2NLsBKL7NMdgzK+b/sZTIYgPAPN4mqJAgHXgvy5QzoM/VqmXfO/8uk9oDD9w
         NCorlk7iLYwJ1gfyO+0P6uxaNwaeMtAVuwQJ3fi1XH97tMUZbxdJW2lnENo643MRO3hG
         k15PaHJVGLJLqSWLZGT/AExEvNerveRkyNkT5vz2nduGNSftBXqyP6pFH2rTuWe3GgKJ
         ItYQ==
X-Gm-Message-State: APjAAAWlTXnmHj6g58dh4Ul2d4H0yDJTDoJ3jIKzXhu7yooxmR/h2U0c
        46C/qtbYAp/x07HeCamDbTw=
X-Google-Smtp-Source: APXvYqwhQ4XJzhsiagpvaP2+F4kfTWMUjE45USEiP4I9crh1lg6tuQRBbJE5uxUoH2Hd+ZkDMXkDvg==
X-Received: by 2002:ae9:f709:: with SMTP id s9mr10196255qkg.463.1576186485085;
        Thu, 12 Dec 2019 13:34:45 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r5sm2116467qkf.44.2019.12.12.13.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:34:44 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [RFC PATCH 0/5] efi/gop: Merge 32/64-bit code
Date:   Thu, 12 Dec 2019 16:34:38 -0500
Message-Id: <20191212213443.24128-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series unifies the 32-bit and 64-bit firmware functions in gop.c.

Patches 1, 2 and 5 are bugfix/cleanup. The merge is in patches 3/4.

Patch 1 removes __packed from the GOP structures, which is wrong but
didn't impact their layout.

The UEFI spec differs from the standard gcc layout for 32-bit systems,
in that it specifies 64-bit alignment for 64-bit members. We have a bit
of a mix in the type definitions currently, with different types doing
one of the below:
	(a) nothing, if a 64-bit member happens to fall naturally on a
	    64-bit boundary
	(b) explicit padding fields
	(c) use of __aligned_u64
The last method is the only one that gets the alignment requirement of
the structure itself correct as well as the internal layout -- is it
worth fixing everything to use it?

Patch 5 is to make sure that we don't wind up with a >4G framebuffer on
a 32-bit kernel that can only address 4G. I'm not sure if this can
practically happen on anything that we can run a 32-bit kernel on, but
UEFI specs the framebuffer physical address to be 64-bit even on 32-bit
systems, so I figured we might as well cover this edge case.

For the code merge, formatting is a bit annoying as the types are named
"graphics_output_protocol", which is overly long to let code fit nicely
into 80 columns. I've used an intermediate macro to address that
somewhat. Alternatively, would renaming the types to use just "gop" be
acceptable?

Arvind Sankar (5):
  efi/gop: Remove bogus packed attribute from GOP structures
  efi/gop: Remove unused typedef
  efi/gop: Convert GOP structures to typedef and cleanup some types
  efi/gop: Unify 32/64-bit functions
  efi/gop: Check that the framebuffer will be accessible

 drivers/firmware/efi/libstub/gop.c | 150 ++++++-----------------------
 include/linux/efi.h                |  50 +++++-----
 2 files changed, 50 insertions(+), 150 deletions(-)

-- 
2.23.0

