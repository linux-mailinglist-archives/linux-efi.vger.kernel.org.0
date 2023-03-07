Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99A46AF6C3
	for <lists+linux-efi@lfdr.de>; Tue,  7 Mar 2023 21:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCGUeE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Mar 2023 15:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCGUeD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Mar 2023 15:34:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1659EF65;
        Tue,  7 Mar 2023 12:34:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8D6F61544;
        Tue,  7 Mar 2023 20:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B6CC433D2;
        Tue,  7 Mar 2023 20:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678221241;
        bh=kkWug6elf1FF5TU6l9HS9iTilGWJHtTTme7IKC8aLyk=;
        h=From:To:Cc:Subject:Date:From;
        b=pSQ2kGdmEpnmL9TkwCusgrIavNRByjk/2izqJf90jwlYxwLJrcRGjlSP7WGQS74/u
         rBoajH+yr47dDIBR2LMyhB5Mqq4py2DstpsEvoukdPuFDDG3JheHZRA9RT5fRBD+C2
         zor04Hhk6qRQSHD6baHdTtMSgviyW00LNRGwlC3j8rSE5StrmS0/PKGAx5wklB2reA
         VHMIC5Dn/9KP0TSKUGO6moC6uftkTiInprwty4P5OOoWPbch6PBTJTrCzzTYGRbDAM
         8EtokCT0/YmvKXhmSVn1P9FF56ef30A52Bwp609c3j7Wqfz6oWDLYCfVp4cafytVuw
         JKF32JIhozoVw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] cper-arm: Remove unnecessary aer.h include
Date:   Tue,  7 Mar 2023 14:33:56 -0600
Message-Id: <20230307203356.882479-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

<linux/aer.h> is unused, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/firmware/efi/cper-arm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index 36d3b8b9da47..fa9c1c3bf168 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -12,7 +12,6 @@
 #include <linux/dmi.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
-#include <linux/aer.h>
 #include <linux/printk.h>
 #include <linux/bcd.h>
 #include <acpi/ghes.h>
-- 
2.25.1

