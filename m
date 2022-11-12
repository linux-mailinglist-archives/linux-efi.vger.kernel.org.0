Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBC262699F
	for <lists+linux-efi@lfdr.de>; Sat, 12 Nov 2022 14:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiKLNmr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Nov 2022 08:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKLNmr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Nov 2022 08:42:47 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Nov 2022 05:42:46 PST
Received: from mailsrv.ikr.uni-stuttgart.de (mailsrv.ikr.uni-stuttgart.de [129.69.170.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF4B13FAC
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 05:42:46 -0800 (PST)
Received: from netsrv1.ikr.uni-stuttgart.de (netsrv1-c [10.11.12.12])
        by mailsrv.ikr.uni-stuttgart.de (Postfix) with ESMTP id 14949F96DE3
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 14:37:42 +0100 (CET)
Received: from ikr.uni-stuttgart.de (pc052 [10.21.21.52])
        by netsrv1.ikr.uni-stuttgart.de (Postfix) with SMTP id 967AFF96DE2
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 14:37:40 +0100 (CET)
Received: by ikr.uni-stuttgart.de (sSMTP sendmail emulation); Sat, 12 Nov 2022 14:37:39 +0100
From:   Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Organization: University of Stuttgart (Germany), IKR
To:     linux-efi@vger.kernel.org
Subject: Regression in Linux 6.0.8 in Lenovo T14 Gen 3 when adding EFI boot entries
Date:   Sat, 12 Nov 2022 14:37:39 +0100
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202211121437.39938.ulrich.gemkow@ikr.uni-stuttgart.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

calling efibootmgr for adding EFI boot entries with Linux 6.0.8 does
not work on our Lenovo T14 Gen 3 (intel). The error is "EFI variables
are not supported on this system". The directory /sys/firmware/efi/efivars/
exists but is empty.

This worked fine with the latest 5.19 kernel. The config was transferred
from 5.19 to 6.0 with "make oldconfig". All kernels are self-compiled
and without changes from the kernel.org downloads.

I saw earlier messages about bugs in this area, the fixes applied
seem to be not complete.

Please let me know when additional information would help to debug.

Thank you and best regards

Ulrich

-- 
Ulrich Gemkow
University of Stuttgart
Institute of Communication Networks and Computer Engineering (IKR)
