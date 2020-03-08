Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E2F17D26B
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCHIJg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgCHIJf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:09:35 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1E220866;
        Sun,  8 Mar 2020 08:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583654974;
        bh=v/U4OkqxqRWTdenDwIzfbVlCTaQKqrUR3iIvfWvw9xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILIPEOPW/3A2F7Xa/1PxE9iA76qsSGdayrtwU0wqAypZfJjT5zjayK/yp93AHoLWX
         okoYKGdlxprle4Fxm384zWqydDptxOjSvwGsc1OgHLVUywY6zK0Y+yXo2fZCKDzkEK
         cH4j1vtBwnUg11V9+DbHNDjWrg/KP+mYorE7Mj5s=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 08/28] efi/libstub: add libstub/mem.c to documentation tree
Date:   Sun,  8 Mar 2020 09:08:39 +0100
Message-Id: <20200308080859.21568-9-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

Let the description of the efi/libstub/mem.c functions appear in the Kernel
API documentation in chapter

    The Linux driver implementer’s API guide
        Linux Firmware API
            UEFI Support
                UEFI stub library functions

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Acked-by: Jonathan Corbet <corbet@lwn.net>
Link: https://lore.kernel.org/r/20200221035832.144960-1-xypron.glpk@gmx.de
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/driver-api/firmware/efi/index.rst | 11 +++++++++++
 Documentation/driver-api/firmware/index.rst     |  1 +
 2 files changed, 12 insertions(+)
 create mode 100644 Documentation/driver-api/firmware/efi/index.rst

diff --git a/Documentation/driver-api/firmware/efi/index.rst b/Documentation/driver-api/firmware/efi/index.rst
new file mode 100644
index 000000000000..4fe8abba9fc6
--- /dev/null
+++ b/Documentation/driver-api/firmware/efi/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+UEFI Support
+============
+
+UEFI stub library functions
+===========================
+
+.. kernel-doc:: drivers/firmware/efi/libstub/mem.c
+   :internal:
diff --git a/Documentation/driver-api/firmware/index.rst b/Documentation/driver-api/firmware/index.rst
index 29da39ec4b8a..57415d657173 100644
--- a/Documentation/driver-api/firmware/index.rst
+++ b/Documentation/driver-api/firmware/index.rst
@@ -6,6 +6,7 @@ Linux Firmware API
 
    introduction
    core
+   efi/index
    request_firmware
    other_interfaces
 
-- 
2.17.1

