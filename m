Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C85770588
	for <lists+linux-efi@lfdr.de>; Fri,  4 Aug 2023 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjHDQEV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Aug 2023 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjHDQET (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Aug 2023 12:04:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311DEB2;
        Fri,  4 Aug 2023 09:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7670962094;
        Fri,  4 Aug 2023 16:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F36C433C7;
        Fri,  4 Aug 2023 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691165050;
        bh=Ps+d066ShaMnLNUT+HgxeSOlR8GwrqJ6PE4HjhQvyfA=;
        h=From:To:Cc:Subject:Date:From;
        b=iDnmB9L4XGERLKjX8G42r1+ADP/WphJnR3IUvL7ohuaqw/HeesebohFAMxSLsrCcQ
         ogS4urOYT7k2FRebpp742eBWibqp3WEGtrG3BoGN8g484uLO1C9MY3bMBsOJBRDLEc
         HVg3nA6mpL+vqzBEDjmEIeaNEN7MlIqEJPu1hS6vDAQzyIYeiXjqwFrWkPuGMN/FcX
         a+hLCab5otBRfmHmLeXz27FbbMOv3UFQZ5Dh4F4dd1RWXi1Srlvy7zoopoPmWvNNnp
         eHi0YNOFmM5xG18n9IrcFdTldTymTG+4uhR8qiRc+JvlmlotWoqYUUldJwwGfBZ5v8
         O5OO6G1P9aihA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/4] efi: Clean up runtime wrapper and wire it up for PRM
Date:   Fri,  4 Aug 2023 18:03:55 +0200
Message-Id: <20230804160359.228901-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=ardb@kernel.org; h=from:subject; bh=Ps+d066ShaMnLNUT+HgxeSOlR8GwrqJ6PE4HjhQvyfA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWsYmaSqh9L7eG5iUxzNQ0cAjXu7OAM8OZ+KnY6JjrrS 5aE2v+OUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJGsJIb/cTe/Wzvd33XwJ8tm ho1akplLilMu+yz+fNrKujxqjxL/E0aG/ZtZNthduvO5O2ml+wYrDdv327sOcsj+3r3uhurajcL 7OAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

ACPI PRM uses the EFI runtime services infrastructure, but currently, it
issues the firmware calls directly, instead of going through the
wrappers and handing off the call to the EFI workqueue.

Given that ACPI PRM is used for vendor code rather than core EFI runtime
services, it would be nice if these calls get sandboxed in the same way
as EFI runtime services calls are. This ensures that any faults
occurring in the firmware are handled gracefully and don't bring down
the kernel.

Another reason for using the work queue is the fact that on some
platforms, the EFI memory regions are remapping into the lower address
space, and this means that sampling the instruction pointer in a perf
interrupt may cause confusion about whether the task is running in user
space or in the firmware.

So let's move the ACPI PRM calls into the EFI runtime wrapper
infrastructure. Before that, let's clean it up a bit.

Ard Biesheuvel (4):
  efi/runtime-wrappers: Use type safe encapsulation of call arguments
  efi/runtime-wrapper: Move workqueue manipulation out of line
  efi/runtime-wrappers: Remove duplicated macro for service returning
    void
  acpi/prmt: Use EFI runtime sandbox to invoke PRM handlers

 drivers/acpi/prmt.c                     |   8 +-
 drivers/firmware/efi/runtime-wrappers.c | 201 +++++++++++---------
 include/linux/efi.h                     | 110 ++++++++---
 3 files changed, 198 insertions(+), 121 deletions(-)

-- 
2.39.2

