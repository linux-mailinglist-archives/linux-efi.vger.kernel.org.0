Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA660B04FE
	for <lists+linux-efi@lfdr.de>; Wed, 11 Sep 2019 22:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfIKUsf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Sep 2019 16:48:35 -0400
Received: from bear.techie.net ([205.134.185.202]:47126 "EHLO bear.techie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbfIKUse (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 11 Sep 2019 16:48:34 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 16:48:34 EDT
Received: by bear.techie.net (Postfix, from userid 545)
        id 9D40222A0931; Wed, 11 Sep 2019 16:42:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=techie.net; s=default;
        t=1568234578; bh=880V0fhz/0QIcPvAiMTaPBq9sxIWXJ9fVcKzwOv0uBU=;
        h=Date:From:To:Subject:From;
        b=E03ngTWARPc5/LpuQgNqmCCyuZNN+MyS69VAmh5ENUJxjlWRmGAm9//nsgiQ9YHhV
         E++MRKDMSTmc0LkPhjSI9VzQsFbmgAoL6fdxcU+9H2w6xqaqDgYFHo42PqV8QsdDDE
         3B0f3/OoGqKdVdjtJH6lPx0+5sapHScSm+/ayVes=
Received: from localhost (localhost [127.0.0.1])
        by bear.techie.net (Postfix) with ESMTP id 7FE7822A0927
        for <linux-efi@vger.kernel.org>; Wed, 11 Sep 2019 16:42:58 -0400 (EDT)
Date:   Wed, 11 Sep 2019 16:42:58 -0400 (EDT)
From:   Scott Talbert <swt@techie.net>
X-X-Sender: talbert@bear.techie.net
To:     linux-efi@vger.kernel.org
Subject: Boot regression in 4.8 for Mac Pro server
Message-ID: <alpine.DEB.2.21.1909111635530.3954@bear.techie.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

I just recently discovered a boot regression that occurred starting in 4.8 
on a Mac Pro Mid-2012 server (MacPro5,1).  Yes, I realize this problem is 
over 3 years old.  Obviously, I haven't been using Linux on this hardware 
in a while.  :-)  I bisected the regression to 
475fb4e8b2f4444d1d7b406ff3a7d21bc89a1e6f "efi / ACPI: load SSTDs from EFI 
variables".  And indeed, v5.3-rc7 will boot if I comment out the 
efivar_ssdt_load() call, as in:

$ git diff
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ad3b1f4866b3..691a8671a2ba 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -364,8 +364,8 @@ static int __init efisubsys_init(void)
         if (error)
                 goto err_put;

-       if (efi_enabled(EFI_RUNTIME_SERVICES))
-               efivar_ssdt_load();
+       //if (efi_enabled(EFI_RUNTIME_SERVICES))
+       //      efivar_ssdt_load();

         error = sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
         if (error) {


Any thoughts on how to fix this?

Thanks,
Scott
