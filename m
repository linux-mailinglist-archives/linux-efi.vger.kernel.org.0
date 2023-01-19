Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4719F673F35
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jan 2023 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjASQpw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 11:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjASQpu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 11:45:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F323C4E52D;
        Thu, 19 Jan 2023 08:45:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FB3161CCD;
        Thu, 19 Jan 2023 16:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE99C433EF;
        Thu, 19 Jan 2023 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674146748;
        bh=SynuDDILfehL2T8hvUkrH01rNlfRaPkey2aIBkXZnIs=;
        h=From:To:Cc:Subject:Date:From;
        b=iJ9DCWPjBFu5yEWCcak1CL+EvQGhTSwSldgFj5QwVliquZTANRSw0CJPZ0dFqMmlm
         x2ttvAu6Jy2sBJUe1EKKHQ0gFWIxHUqPNX4vmEuba4++L02zRzsMiEnWXUIv6F0QWw
         DPicR+diMSuXSLonCl3ZkbgLmtcX2Y4qnyHkYaYjWFl2LUuIICnlm+1lXcpSIJvv9F
         b62ggmHkAHEiDshlDaYITgY5inU1WnwIR4i8uDJNqbaiI9uwUknWsCkc290+7WOK9/
         GpuOStTndQW1irU3aU5XJgZrHktrGDgg9q/sJ5MSPXWVauk79WtCrstyhvIKCJd136
         y+6rzIY3Afekw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pIY3L-0007Mp-UA; Thu, 19 Jan 2023 17:46:16 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/4] efi: verify that variable services are supported
Date:   Thu, 19 Jan 2023 17:42:51 +0100
Message-Id: <20230119164255.28091-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
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

This series adds a sanity check to make sure that the variable services
are actually available before registering the generic efivar ops.

This is used to address some potential races with custom efivars
implementation such as the Google SMI or upcoming Qualcomm SCM ones.

Specifically, efivarfs currently requires that the efivar ops have been
registered before module init time even though the Google driver can be
built as a module. Instead, the driver has so far relied on the fact
that the generic ops have been registered by efi core only to later be
overridden by the custom implementation (or Google doesn't use
efivarfs).

Instead, let's move the efivars sanity check to mount time to allow for
late registration of efivars.

Note that requiring that all efivars implementation to always be
built-in and registered before module init time could be an alternative,
but we'd still need to make sure that the custom implementation is then
not overridden by the default (broken) one. To avoid such init call
games, allowing late registration seems preferable.

This would however require any drivers that use efivars to probe defer
until it becomes available, which is also unfortunate, but possibly
still better than having generic kernels carry multiple built-in efivars
implementations.

Note that there are currently no such (efivars consumer) drivers in-tree
except for the efivars_pstore driver, which currently do rely on
efivarfs being available at module init time (and hence may fail to
initialise with the custom efivar implementations).

Johan


Johan Hovold (4):
  efi: efivars: add efivars printk prefix
  efivarfs: always register filesystem
  efi: verify that variable services are supported
  efi: efivars: prevent double registration

 drivers/firmware/efi/efi.c  | 22 ++++++++++++++++++++++
 drivers/firmware/efi/vars.c | 17 ++++++++++++++---
 fs/efivarfs/super.c         |  6 +++---
 3 files changed, 39 insertions(+), 6 deletions(-)

-- 
2.38.2

