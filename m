Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50591A5C0A
	for <lists+linux-efi@lfdr.de>; Sun, 12 Apr 2020 04:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgDLCti (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Apr 2020 22:49:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20422 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726108AbgDLCth (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Apr 2020 22:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586659777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VogcAM4f+7ZYGZP3VmVCoYpWE3MtWwpRfqsHtlQY+ws=;
        b=ZNX4gvd86QfeJWXqc6fYzzFahZHRnQM8PD8GDONaugGLIiF8GzGjFGn97uaHvkC9jCdYNT
        /D/6nGUcBvXR0/AwdOpReIiA47fh0iHB0ikuYCbDkRJbyONAA31revLF4g6KTdFmwtScau
        CDwwRv59/3jc/RVLuRa8PADZHQwR0Y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-iwefRy8oOki2qNz0nU7NVA-1; Sat, 11 Apr 2020 22:49:34 -0400
X-MC-Unique: iwefRy8oOki2qNz0nU7NVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C977A107ACC9;
        Sun, 12 Apr 2020 02:49:33 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5514CFDE3;
        Sun, 12 Apr 2020 02:49:31 +0000 (UTC)
Date:   Sun, 12 Apr 2020 10:49:27 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi/earlycon: fix early printk for wider fonts
Message-ID: <20200412024927.GA6884@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When I play with terminus fonts I noticed the efi early printk does
not work because the earlycon code assumes font width is 8.

Here add the code to adapt with larger fonts.  Tested with all kinds
of kernel built-in fonts on my laptop. Also tested with a local draft
patch for 14x28 !bold terminus font.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 drivers/firmware/efi/earlycon.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- linux-x86.orig/drivers/firmware/efi/earlycon.c
+++ linux-x86/drivers/firmware/efi/earlycon.c
@@ -114,14 +114,16 @@ static void efi_earlycon_write_char(u32
 	const u32 color_black = 0x00000000;
 	const u32 color_white = 0x00ffffff;
 	const u8 *src;
-	u8 s8;
-	int m;
+	int m, n, bytes;
+	u8 x;
 
-	src = font->data + c * font->height;
-	s8 = *(src + h);
+	bytes = BITS_TO_BYTES(font->width);
+	src = font->data + c * font->height * bytes + h * bytes;
 
-	for (m = 0; m < 8; m++) {
-		if ((s8 >> (7 - m)) & 1)
+	for (m = 0; m < font->width; m++) {
+		n = m % 8;
+		x = *(src + m / 8);
+		if ((x >> (7 - n)) & 1)
 			*dst = color_white;
 		else
 			*dst = color_black;

