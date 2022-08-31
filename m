Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1179A5A737F
	for <lists+linux-efi@lfdr.de>; Wed, 31 Aug 2022 03:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiHaBtb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Aug 2022 21:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiHaBt3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Aug 2022 21:49:29 -0400
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DABAAD999;
        Tue, 30 Aug 2022 18:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-83-ed;
 t=1661908369; h=from : to : cc : subject : date : message-id :
 mime-version : content-transfer-encoding : from;
 bh=2vF0iKj3rZj+zvyIjC+40c2+iouHVtn9J64weGafMkM=;
 b=L6+P0BHb97HbSnhGWvmL54EzilcpLqqkkYNi7KJMPxEggJAcb3MrRrOsRCk0XHvHGaQZG
 DFBzI0Z0zKEEmKpAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-83-rsa; t=1661908369; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=2vF0iKj3rZj+zvyIjC+40c2+iouHVtn9J64weGafMkM=;
 b=S3aE+n3wq8AteH0qu7exNGRsJzUpTQRpNxRW0R5v+Ywxa0lbwfO3hDdp9tAeJAHLa+a/H
 1s4edV3leGB+ynX7DbTKqo4rm4u64Ltg613bPuHMkA1TADhn7JxPLkjfBDrmrHlIjkHbfbc
 bPVZUyP7C5k+cgCOhUgZO4ZFxfU7uMt1YoIS2/At3vrC8aVp96elmswyMP4weEpI9ZbPo+F
 km2eSZPmeQ3FmJj5yUW+gMb2eK40TFI4/R6h/cLDJ6A9Kzp7ZDXwNlvSajCRXpcJoage1Kj
 eHCJMPG204q50+8NiGXkwlApFw6OVSq8MRQfy1Kz9TAbdGzo0L/QzFZdeRuA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 16505160521;
        Tue, 30 Aug 2022 18:12:49 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 01312201B8; Tue, 30 Aug 2022 18:12:48 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Michael Roth <michael.roth@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 0/4] Remove unused variables resulting in CONFIG_EFI warnings
Date:   Tue, 30 Aug 2022 18:12:44 -0700
Message-Id: <20220831011248.28632-1-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This small series removes a few unused variables.
This fixes some CONFIG_EFI build warnings that were introduced in v5.19-rc1.

Is there any chance these could be pushed into v6.0 ?
If not, could you queue these for the next release cycle ?

Michel Lespinasse (4):
  Remove unused variable et in efi_get_system_table()
  Remove unused variable nr_tables in efi_get_rsdp_addr()
  Remove unused variable ret in efi_get_conf_table()
  Remove unused variable ret in __efi_get_rsdp_addr()

 arch/x86/boot/compressed/acpi.c | 2 --
 arch/x86/boot/compressed/efi.c  | 2 --
 2 files changed, 4 deletions(-)


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.20.1

